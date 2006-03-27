Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWC0HWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWC0HWN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 02:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWC0HWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 02:22:13 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:47285 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750763AbWC0HWM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 02:22:12 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] deinline 200+ byte inlines in sock.h
Date: Mon, 27 Mar 2006 10:21:08 +0300
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kJ5JE/WNmeZbbf8"
Message-Id: <200603271021.08310.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_kJ5JE/WNmeZbbf8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sizes in bytes (allyesconfig, i386) and files where those inlines
are used:

238 sock_queue_rcv_skb 2.6.16/net/x25/x25_in.o
238 sock_queue_rcv_skb 2.6.16/net/rose/rose_in.o
238 sock_queue_rcv_skb 2.6.16/net/packet/af_packet.o
238 sock_queue_rcv_skb 2.6.16/net/netrom/nr_in.o
238 sock_queue_rcv_skb 2.6.16/net/llc/llc_sap.o
238 sock_queue_rcv_skb 2.6.16/net/llc/llc_conn.o
238 sock_queue_rcv_skb 2.6.16/net/irda/af_irda.o
238 sock_queue_rcv_skb 2.6.16/net/ipx/af_ipx.o
238 sock_queue_rcv_skb 2.6.16/net/ipv6/udp.o
238 sock_queue_rcv_skb 2.6.16/net/ipv6/raw.o
238 sock_queue_rcv_skb 2.6.16/net/ipv4/udp.o
238 sock_queue_rcv_skb 2.6.16/net/ipv4/raw.o
238 sock_queue_rcv_skb 2.6.16/net/ipv4/ipmr.o
238 sock_queue_rcv_skb 2.6.16/net/econet/econet.o
238 sock_queue_rcv_skb 2.6.16/net/econet/af_econet.o
238 sock_queue_rcv_skb 2.6.16/net/bluetooth/sco.o
238 sock_queue_rcv_skb 2.6.16/net/bluetooth/l2cap.o
238 sock_queue_rcv_skb 2.6.16/net/bluetooth/hci_sock.o
238 sock_queue_rcv_skb 2.6.16/net/ax25/ax25_in.o
238 sock_queue_rcv_skb 2.6.16/net/ax25/af_ax25.o
238 sock_queue_rcv_skb 2.6.16/net/appletalk/ddp.o
238 sock_queue_rcv_skb 2.6.16/drivers/net/pppoe.o

276 sk_receive_skb 2.6.16/net/decnet/dn_nsp_in.o
276 sk_receive_skb 2.6.16/net/dccp/ipv6.o
276 sk_receive_skb 2.6.16/net/dccp/ipv4.o
276 sk_receive_skb 2.6.16/net/dccp/dccp_ipv6.o
276 sk_receive_skb 2.6.16/drivers/net/pppoe.o

209 sk_dst_check 2.6.16/net/ipv6/ip6_output.o
209 sk_dst_check 2.6.16/net/ipv4/udp.o
209 sk_dst_check 2.6.16/net/decnet/dn_nsp_out.o

Should I also attack sock_recv_timestamp() etc?

Large inlines with multiple callers:
Size  Uses Wasted Name and definition
===== ==== ====== ================================================
  238   21   4360 sock_queue_rcv_skb    include/net/sock.h
  109   10    801 sock_recv_timestamp   include/net/sock.h
  276    4    768 sk_receive_skb        include/net/sock.h
   94    8    518 __sk_dst_check        include/net/sock.h
  209    3    378 sk_dst_check  include/net/sock.h
  131    4    333 sk_setup_caps include/net/sock.h
  152    2    132 sk_stream_alloc_pskb  include/net/sock.h
  125    2    105 sk_stream_writequeue_purge    include/net/sock.h
--
vda


--Boundary-00=_kJ5JE/WNmeZbbf8
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sock.patch"

diff -urpN linux-2.6.16.org/include/net/sock.h linux-2.6.16.deinline/include/net/sock.h
--- linux-2.6.16.org/include/net/sock.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.deinline/include/net/sock.h	Mon Mar 27 09:55:12 2006
@@ -926,28 +926,7 @@ static inline void sock_put(struct sock 
 		sk_free(sk);
 }
 
-static inline int sk_receive_skb(struct sock *sk, struct sk_buff *skb)
-{
-	int rc = NET_RX_SUCCESS;
-
-	if (sk_filter(sk, skb, 0))
-		goto discard_and_relse;
-
-	skb->dev = NULL;
-
-	bh_lock_sock(sk);
-	if (!sock_owned_by_user(sk))
-		rc = sk->sk_backlog_rcv(sk, skb);
-	else
-		sk_add_backlog(sk, skb);
-	bh_unlock_sock(sk);
-out:
-	sock_put(sk);
-	return rc;
-discard_and_relse:
-	kfree_skb(skb);
-	goto out;
-}
+extern int sk_receive_skb(struct sock *sk, struct sk_buff *skb);
 
 /* Detach socket from process context.
  * Announce socket dead, detach it from wait queue and inode.
@@ -1032,33 +1011,9 @@ sk_dst_reset(struct sock *sk)
 	write_unlock(&sk->sk_dst_lock);
 }
 
-static inline struct dst_entry *
-__sk_dst_check(struct sock *sk, u32 cookie)
-{
-	struct dst_entry *dst = sk->sk_dst_cache;
-
-	if (dst && dst->obsolete && dst->ops->check(dst, cookie) == NULL) {
-		sk->sk_dst_cache = NULL;
-		dst_release(dst);
-		return NULL;
-	}
-
-	return dst;
-}
-
-static inline struct dst_entry *
-sk_dst_check(struct sock *sk, u32 cookie)
-{
-	struct dst_entry *dst = sk_dst_get(sk);
-
-	if (dst && dst->obsolete && dst->ops->check(dst, cookie) == NULL) {
-		sk_dst_reset(sk);
-		dst_release(dst);
-		return NULL;
-	}
+extern struct dst_entry *__sk_dst_check(struct sock *sk, u32 cookie);
 
-	return dst;
-}
+extern struct dst_entry *sk_dst_check(struct sock *sk, u32 cookie);
 
 static inline void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 {
@@ -1128,45 +1083,7 @@ extern void sk_reset_timer(struct sock *
 
 extern void sk_stop_timer(struct sock *sk, struct timer_list* timer);
 
-static inline int sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
-{
-	int err = 0;
-	int skb_len;
-
-	/* Cast skb->rcvbuf to unsigned... It's pointless, but reduces
-	   number of warnings when compiling with -W --ANK
-	 */
-	if (atomic_read(&sk->sk_rmem_alloc) + skb->truesize >=
-	    (unsigned)sk->sk_rcvbuf) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	/* It would be deadlock, if sock_queue_rcv_skb is used
-	   with socket lock! We assume that users of this
-	   function are lock free.
-	*/
-	err = sk_filter(sk, skb, 1);
-	if (err)
-		goto out;
-
-	skb->dev = NULL;
-	skb_set_owner_r(skb, sk);
-
-	/* Cache the SKB length before we tack it onto the receive
-	 * queue.  Once it is added it no longer belongs to us and
-	 * may be freed by other threads of control pulling packets
-	 * from the queue.
-	 */
-	skb_len = skb->len;
-
-	skb_queue_tail(&sk->sk_receive_queue, skb);
-
-	if (!sock_flag(sk, SOCK_DEAD))
-		sk->sk_data_ready(sk, skb_len);
-out:
-	return err;
-}
+extern int sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
 
 static inline int sock_queue_err_skb(struct sock *sk, struct sk_buff *skb)
 {
diff -urpN linux-2.6.16.org/net/core/sock.c linux-2.6.16.deinline/net/core/sock.c
--- linux-2.6.16.org/net/core/sock.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.deinline/net/core/sock.c	Mon Mar 27 09:45:09 2006
@@ -187,6 +187,99 @@ static void sock_disable_timestamp(struc
 }
 
 
+int sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
+{
+	int err = 0;
+	int skb_len;
+
+	/* Cast skb->rcvbuf to unsigned... It's pointless, but reduces
+	   number of warnings when compiling with -W --ANK
+	 */
+	if (atomic_read(&sk->sk_rmem_alloc) + skb->truesize >=
+	    (unsigned)sk->sk_rcvbuf) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* It would be deadlock, if sock_queue_rcv_skb is used
+	   with socket lock! We assume that users of this
+	   function are lock free.
+	*/
+	err = sk_filter(sk, skb, 1);
+	if (err)
+		goto out;
+
+	skb->dev = NULL;
+	skb_set_owner_r(skb, sk);
+
+	/* Cache the SKB length before we tack it onto the receive
+	 * queue.  Once it is added it no longer belongs to us and
+	 * may be freed by other threads of control pulling packets
+	 * from the queue.
+	 */
+	skb_len = skb->len;
+
+	skb_queue_tail(&sk->sk_receive_queue, skb);
+
+	if (!sock_flag(sk, SOCK_DEAD))
+		sk->sk_data_ready(sk, skb_len);
+out:
+	return err;
+}
+EXPORT_SYMBOL(sock_queue_rcv_skb);
+
+int sk_receive_skb(struct sock *sk, struct sk_buff *skb)
+{
+	int rc = NET_RX_SUCCESS;
+
+	if (sk_filter(sk, skb, 0))
+		goto discard_and_relse;
+
+	skb->dev = NULL;
+
+	bh_lock_sock(sk);
+	if (!sock_owned_by_user(sk))
+		rc = sk->sk_backlog_rcv(sk, skb);
+	else
+		sk_add_backlog(sk, skb);
+	bh_unlock_sock(sk);
+out:
+	sock_put(sk);
+	return rc;
+discard_and_relse:
+	kfree_skb(skb);
+	goto out;
+}
+EXPORT_SYMBOL(sk_receive_skb);
+
+struct dst_entry *__sk_dst_check(struct sock *sk, u32 cookie)
+{
+	struct dst_entry *dst = sk->sk_dst_cache;
+
+	if (dst && dst->obsolete && dst->ops->check(dst, cookie) == NULL) {
+		sk->sk_dst_cache = NULL;
+		dst_release(dst);
+		return NULL;
+	}
+
+	return dst;
+}
+EXPORT_SYMBOL(__sk_dst_check);
+
+struct dst_entry *sk_dst_check(struct sock *sk, u32 cookie)
+{
+	struct dst_entry *dst = sk_dst_get(sk);
+
+	if (dst && dst->obsolete && dst->ops->check(dst, cookie) == NULL) {
+		sk_dst_reset(sk);
+		dst_release(dst);
+		return NULL;
+	}
+
+	return dst;
+}
+EXPORT_SYMBOL(sk_dst_check);
+
 /*
  *	This is meant for all protocols to use and covers goings on
  *	at the socket level. Everything here is generic.

--Boundary-00=_kJ5JE/WNmeZbbf8--
