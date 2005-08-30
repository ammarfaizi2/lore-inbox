Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbVH3Irq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbVH3Irq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 04:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVH3Irq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 04:47:46 -0400
Received: from spc1-leed3-6-0-cust185.seac.broadband.ntl.com ([80.7.68.185]:50704
	"EHLO fentible.pjc.net") by vger.kernel.org with ESMTP
	id S1751239AbVH3Irq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 04:47:46 -0400
Date: Tue, 30 Aug 2005 09:47:36 +0100
From: Patrick Caulfield <pcaulfie@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, steve@chygwyn.com
Subject: [PATCH] DECnet Tidy
Message-ID: <20050830084736.GA32184@tykepenguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from Steve which I've vetted and tested:

"This patch is really intended has a move towards fixing the sendmsg/recvmsg     
 functions in various ways so that we will finally have working nagle. Also      
 reduces code duplication. "

Signed-off-by: Patrick Caulfield <patrick@tykepenguin.com>

--- a/net/decnet/af_decnet.c
+++ b/net/decnet/af_decnet.c
@@ -1876,8 +1876,27 @@ static inline unsigned int dn_current_ms
 	return mss_now;
 }
 
+/* 
+ * N.B. We get the timeout wrong here, but then we always did get it
+ * wrong before and this is another step along the road to correcting
+ * it. It ought to get updated each time we pass through the routine,
+ * but in practise it probably doesn't matter too much for now.
+ */
+static inline struct sk_buff *dn_alloc_send_pskb(struct sock *sk,
+			      unsigned long datalen, int noblock,
+			      int *errcode)
+{
+	struct sk_buff *skb = sock_alloc_send_skb(sk, datalen,
+						   noblock, errcode);
+	if (skb) {
+		skb->protocol = __constant_htons(ETH_P_DNA_RT);
+		skb->pkt_type = PACKET_OUTGOING;
+	}
+	return skb;
+}
+
 static int dn_sendmsg(struct kiocb *iocb, struct socket *sock,
-	   struct msghdr *msg, size_t size)
+		      struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 	struct dn_scp *scp = DN_SK(sk);
@@ -1892,7 +1911,7 @@ static int dn_sendmsg(struct kiocb *iocb
 	struct dn_skb_cb *cb;
 	size_t len;
 	unsigned char fctype;
-	long timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
+	long timeo;
 
 	if (flags & ~(MSG_TRYHARD|MSG_OOB|MSG_DONTWAIT|MSG_EOR|MSG_NOSIGNAL|MSG_MORE|MSG_CMSG_COMPAT))
 		return -EOPNOTSUPP;
@@ -1900,18 +1919,21 @@ static int dn_sendmsg(struct kiocb *iocb
 	if (addr_len && (addr_len != sizeof(struct sockaddr_dn)))
 		return -EINVAL;
 
+	lock_sock(sk);
+	timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
 	/*
 	 * The only difference between stream sockets and sequenced packet
 	 * sockets is that the stream sockets always behave as if MSG_EOR
 	 * has been set.
 	 */
 	if (sock->type == SOCK_STREAM) {
-		if (flags & MSG_EOR)
-			return -EINVAL;
+		if (flags & MSG_EOR) {
+			err = -EINVAL;
+			goto out;
+		}
 		flags |= MSG_EOR;
 	}
 
-	lock_sock(sk);
 
 	err = dn_check_state(sk, addr, addr_len, &timeo, flags);
 	if (err)
@@ -1980,8 +2002,12 @@ static int dn_sendmsg(struct kiocb *iocb
 
 		/*
 		 * Get a suitably sized skb.
+		 * 64 is a bit of a hack really, but its larger than any
+		 * link-layer headers and has served us well as a good
+		 * guess as to their real length.
 		 */
-		skb = dn_alloc_send_skb(sk, &len, flags & MSG_DONTWAIT, timeo, &err);
+		skb = dn_alloc_send_pskb(sk, len + 64 + DN_MAX_NSP_DATA_HEADER,
+					 flags & MSG_DONTWAIT, &err);
 
 		if (err)
 			break;
@@ -1991,7 +2017,7 @@ static int dn_sendmsg(struct kiocb *iocb
 
 		cb = DN_SKB_CB(skb);
 
-		skb_reserve(skb, DN_MAX_NSP_DATA_HEADER);
+		skb_reserve(skb, 64 + DN_MAX_NSP_DATA_HEADER);
 
 		if (memcpy_fromiovec(skb_put(skb, len), msg->msg_iov, len)) {
 			err = -EFAULT;
--- a/net/decnet/dn_nsp_out.c
+++ b/net/decnet/dn_nsp_out.c
@@ -137,69 +137,6 @@ struct sk_buff *dn_alloc_skb(struct sock
 }
 
 /*
- * Wrapper for the above, for allocs of data skbs. We try and get the
- * whole size thats been asked for (plus 11 bytes of header). If this
- * fails, then we try for any size over 16 bytes for SOCK_STREAMS.
- */
-struct sk_buff *dn_alloc_send_skb(struct sock *sk, size_t *size, int noblock, long timeo, int *err)
-{
-	int space;
-	int len;
-	struct sk_buff *skb = NULL;
-
-	*err = 0;
-
-	while(skb == NULL) {
-		if (signal_pending(current)) {
-			*err = sock_intr_errno(timeo);
-			break;
-		}
-
-		if (sk->sk_shutdown & SEND_SHUTDOWN) {
-			*err = EINVAL;
-			break;
-		}
-
-		if (sk->sk_err)
-			break;
-
-		len = *size + 11;
-		space = sk->sk_sndbuf - atomic_read(&sk->sk_wmem_alloc);
-
-		if (space < len) {
-			if ((sk->sk_socket->type == SOCK_STREAM) &&
-			    (space >= (16 + 11)))
-				len = space;
-		}
-
-		if (space < len) {
-			set_bit(SOCK_ASYNC_NOSPACE, &sk->sk_socket->flags);
-			if (noblock) {
-				*err = EWOULDBLOCK;
-				break;
-			}
-
-			clear_bit(SOCK_ASYNC_WAITDATA, &sk->sk_socket->flags);
-			SOCK_SLEEP_PRE(sk)
-
-			if ((sk->sk_sndbuf - atomic_read(&sk->sk_wmem_alloc)) <
-			    len)
-				schedule();
-
-			SOCK_SLEEP_POST(sk)
-			continue;
-		}
-
-		if ((skb = dn_alloc_skb(sk, len, sk->sk_allocation)) == NULL)
-			continue;
-
-		*size = len - 11;
-	}
-
-	return skb;
-}
-
-/*
  * Calculate persist timer based upon the smoothed round
  * trip time and the variance. Backoff according to the
  * nsp_backoff[] array.
