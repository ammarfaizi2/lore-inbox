Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWDEHHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWDEHHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 03:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWDEHHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 03:07:48 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:64430 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751128AbWDEHHr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 03:07:47 -0400
Message-ID: <44336CC0.6030206@clusterfs.com>
Date: Wed, 05 Apr 2006 15:07:44 +0800
From: yzy <yzy@clusterfs.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: eeb@clusterfs.com, green@clusterfs.com
Subject: Here is the tcp-zero-copy patch for kernel 2.6.12-6 .
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel:

I do some work on tcp-zero-copy for kernel 2.6.12-6 ( vanilla ) , Here 
is the patch . Please review and discussion it .

The patch modify mainly these files below :
(1) include/linux/skbuff.h : add a zccd_t struct , it include the 
zero-copy's callback function pointer and reference count.
(2)include/net/tcp.h : add a new function  tcp_sendpage_zccd( ) . It  
was used as send a memory page to TCP/IP stack.
(3)net/core/dev.c (4)net/core/skbuff.c : process the initial ,refcount 
and release of zccd information.
(5)net/ipv4/tcp.c : call the tcp_sendpage_zccd() function to send a 
memory page.
 
If have any question , Please let me know.
Thanks .
yzy@clusterfs.com

===============================================================================================

diff -Nur linux-2.6.12.6-orig/include/linux/skbuff.h linux-2.6.12.6/include/linux/skbuff.h
--- linux-2.6.12.6-orig/include/linux/skbuff.h	2006-03-14 19:40:26.000000000 +0800
+++ linux-2.6.12.6/include/linux/skbuff.h	2006-03-16 17:04:51.000000000 +0800
@@ -128,6 +128,30 @@
 	__u16 size;
 };
 
+/* Support for callback when skb data has been released */
+typedef struct zccd                            /* Zero Copy Callback Descriptor */
+{                                              /* (embed as first member of custom struct) */
+	atomic_t        zccd_count;             /* reference count */
+	void           (*zccd_destructor)(struct zccd *); /* callback when refcount reaches zero */
+} zccd_t;
+
+static inline void zccd_init (zccd_t *d, void (*callback)(zccd_t *))
+{
+	atomic_set (&d->zccd_count, 1);
+	d->zccd_destructor = callback;
+}
+
+static inline void zccd_get (zccd_t *d)                /* take a reference */
+{
+	atomic_inc (&d->zccd_count);
+}
+
+static inline void zccd_put (zccd_t *d)                /* release a reference */
+{
+	if (atomic_dec_and_test (&d->zccd_count))
+		(d->zccd_destructor)(d);
+}
+
 /* This data is invariant across clones and lives at
  * the end of the header data, ie. at skb->end.
  */
@@ -137,6 +161,13 @@
 	unsigned short	tso_size;
 	unsigned short	tso_segs;
 	struct sk_buff	*frag_list;
+	zccd_t          *zccd;                  /* zero copy descriptor */
+	zccd_t          *zccd2;                 /* 2nd zero copy descriptor */
+	/* NB we expect zero-copy data to be at least 1 packet, so
+	* having 2 zccds means we don't unneccessarily split the packet
+	* where consecutive zero-copy sends abutt.
+	*/
+
 	skb_frag_t	frags[MAX_SKB_FRAGS];
 };
 
diff -Nur linux-2.6.12.6-orig/include/net/tcp.h linux-2.6.12.6/include/net/tcp.h
--- linux-2.6.12.6-orig/include/net/tcp.h	2005-06-18 03:48:29.000000000 +0800
+++ linux-2.6.12.6/include/net/tcp.h	2006-03-16 17:05:02.000000000 +0800
@@ -783,6 +783,9 @@
 extern int			tcp_sendmsg(struct kiocb *iocb, struct sock *sk,
 					    struct msghdr *msg, size_t size);
 extern ssize_t			tcp_sendpage(struct socket *sock, struct page *page, int offset, size_t size, int flags);
+extern ssize_t                 tcp_sendpage_zccd(struct socket *sock, struct page *page, int offset, size_t size,
+						int flags, zccd_t *zccd);
+
 
 extern int			tcp_ioctl(struct sock *sk, 
 					  int cmd, 
@@ -879,6 +882,9 @@
 					    struct msghdr *msg,
 					    size_t len, int nonblock, 
 					    int flags, int *addr_len);
+extern int                     tcp_recvpackets(struct sock *sk,
+						struct sk_buff_head *packets,
+						int len, int nonblock);
 
 extern int			tcp_listen_start(struct sock *sk);
 
diff -Nur linux-2.6.12.6-orig/net/core/dev.c linux-2.6.12.6/net/core/dev.c
--- linux-2.6.12.6-orig/net/core/dev.c	2005-06-18 03:48:29.000000000 +0800
+++ linux-2.6.12.6/net/core/dev.c	2006-03-16 17:04:36.000000000 +0800
@@ -1176,6 +1176,9 @@
 	ninfo->tso_segs = skb_shinfo(skb)->tso_segs;
 	ninfo->nr_frags = 0;
 	ninfo->frag_list = NULL;
+	ninfo->zccd = NULL;             /* copied data => no user zero copy descriptor */
+	ninfo->zccd2 = NULL;
+
 
 	/* Offset between the two in bytes */
 	offset = data - skb->head;
diff -Nur linux-2.6.12.6-orig/net/core/skbuff.c linux-2.6.12.6/net/core/skbuff.c
--- linux-2.6.12.6-orig/net/core/skbuff.c	2005-06-18 03:48:29.000000000 +0800
+++ linux-2.6.12.6/net/core/skbuff.c	2006-03-16 17:04:41.000000000 +0800
@@ -159,6 +159,9 @@
 	skb_shinfo(skb)->tso_size = 0;
 	skb_shinfo(skb)->tso_segs = 0;
 	skb_shinfo(skb)->frag_list = NULL;
+	skb_shinfo(skb)->zccd = NULL;           /* skbuffs kick off with NO user zero copy descriptors */
+	skb_shinfo(skb)->zccd2 = NULL;
+
 out:
 	return skb;
 nodata:
@@ -247,6 +250,10 @@
 	if (!skb->cloned ||
 	    !atomic_sub_return(skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1,
 			       &skb_shinfo(skb)->dataref)) {
+		if (skb_shinfo(skb)->zccd != NULL) /* zero copy callback descriptor? */
+			zccd_put (skb_shinfo(skb)->zccd); /* release hold */
+		if (skb_shinfo(skb)->zccd2 != NULL) /* 2nd zero copy callback descriptor? */
+			zccd_put (skb_shinfo(skb)->zccd2); /* release hold */
 		if (skb_shinfo(skb)->nr_frags) {
 			int i;
 			for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
@@ -529,6 +536,14 @@
 	n->data_len  = skb->data_len;
 	n->len	     = skb->len;
 
+	if (skb_shinfo(skb)->zccd != NULL)      /* user zero copy descriptor? */
+		zccd_get (skb_shinfo(skb)->zccd); /* 1 more ref (pages are shared) */
+	skb_shinfo(n)->zccd = skb_shinfo(skb)->zccd;
+
+	if (skb_shinfo(skb)->zccd2 != NULL)     /* 2nd user zero copy descriptor? */
+		zccd_get (skb_shinfo(skb)->zccd2); /* 1 more ref (pages are shared) */
+	skb_shinfo(n)->zccd2 = skb_shinfo(skb)->zccd2;
+
 	if (skb_shinfo(skb)->nr_frags) {
 		int i;
 
@@ -571,6 +586,9 @@
 	u8 *data;
 	int size = nhead + (skb->end - skb->head) + ntail;
 	long off;
+	zccd_t *zccd = skb_shinfo(skb)->zccd;   /* stash user zero copy descriptor */
+	zccd_t *zccd2 = skb_shinfo(skb)->zccd2; /* stash 2nd user zero copy descriptor */
+
 
 	if (skb_shared(skb))
 		BUG();
@@ -592,6 +610,11 @@
 	if (skb_shinfo(skb)->frag_list)
 		skb_clone_fraglist(skb);
 
+	if (zccd != NULL)                       /* user zero copy descriptor? */
+		zccd_get (zccd);                /* extra ref (pages are shared) */
+	if (zccd2 != NULL)                      /* 2nd user zero copy descriptor? */
+		zccd_get (zccd2);               /* extra ref (pages are shared) */
+
 	skb_release_data(skb);
 
 	off = (data + nhead) - skb->head;
@@ -606,6 +629,8 @@
 	skb->cloned   = 0;
 	skb->nohdr    = 0;
 	atomic_set(&skb_shinfo(skb)->dataref, 1);
+	skb_shinfo(skb)->zccd = zccd;
+	skb_shinfo(skb)->zccd2 = zccd2;
 	return 0;
 
 nodata:
diff -Nur linux-2.6.12.6-orig/net/ipv4/tcp.c linux-2.6.12.6/net/ipv4/tcp.c
--- linux-2.6.12.6-orig/net/ipv4/tcp.c	2005-06-18 03:48:29.000000000 +0800
+++ linux-2.6.12.6/net/ipv4/tcp.c	2006-03-16 17:04:57.000000000 +0800
@@ -630,8 +630,10 @@
 	}
 }
 
+/* Extra parameter: user zero copy descriptor (or NULL if not doing that) */
 static ssize_t do_tcp_sendpages(struct sock *sk, struct page **pages, int poffset,
-			 size_t psize, int flags)
+				size_t psize, int flags, zccd_t *zccd)
+
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	int mss_now;
@@ -678,6 +680,17 @@
 			copy = size;
 
 		i = skb_shinfo(skb)->nr_frags;
+
+		if (zccd != NULL &&             /* this is a zcc I/O */
+				skb_shinfo(skb)->zccd != NULL && /* skb is part of a zcc I/O */
+				skb_shinfo(skb)->zccd2 != NULL &&
+				skb_shinfo(skb)->zccd != zccd && /* not the same one */
+				skb_shinfo(skb)->zccd2 != zccd)
+		{
+			tcp_mark_push (tp, skb);
+			goto new_segment;
+		}
+
 		can_coalesce = skb_can_coalesce(skb, i, page, offset);
 		if (!can_coalesce && i >= MAX_SKB_FRAGS) {
 			tcp_mark_push(tp, skb);
@@ -694,6 +707,20 @@
 			skb_fill_page_desc(skb, i, page, offset, copy);
 		}
 
+		if (zccd != NULL &&     /* this is a zcc I/O */
+			skb_shinfo(skb)->zccd != zccd && /* not already referencing this zccd */
+			skb_shinfo(skb)->zccd2 != zccd)
+		{
+			zccd_get (zccd);        /* bump ref count */
+
+			BUG_TRAP (skb_shinfo(skb)->zccd2 == NULL);
+
+			if (skb_shinfo(skb)->zccd == NULL) /* reference this zccd */
+				skb_shinfo(skb)->zccd = zccd;
+			else
+				skb_shinfo(skb)->zccd2 = zccd;
+		}
+
 		skb->len += copy;
 		skb->data_len += copy;
 		skb->truesize += copy;
@@ -762,12 +789,37 @@
 
 	lock_sock(sk);
 	TCP_CHECK_TIMER(sk);
-	res = do_tcp_sendpages(sk, &page, offset, size, flags);
+	res = do_tcp_sendpages(sk, &page, offset, size, flags,NULL);
+	TCP_CHECK_TIMER(sk);
+	release_sock(sk);
+	return res;
+}
+
+ssize_t tcp_sendpage_zccd(struct socket *sock, struct page *page, int offset, size_t size,
+                          int flags, zccd_t *zccd)
+{
+	ssize_t res;
+	struct sock *sk = sock->sk;
+
+#define TCP_ZC_CSUM_FLAGS (NETIF_F_IP_CSUM|NETIF_F_NO_CSUM|NETIF_F_HW_CSUM)
+
+	if (!(sk->sk_route_caps & NETIF_F_SG) ||        /* caller shouldn't waste her time */
+	    !(sk->sk_route_caps & TCP_ZC_CSUM_FLAGS)) /* on double mapping */
+		BUG ();
+
+#undef TCP_ZC_CSUM_FLAGS
+
+	lock_sock(sk);
+	TCP_CHECK_TIMER(sk);
+
+	res = do_tcp_sendpages(sk, &page, offset, size, flags, zccd);
+
 	TCP_CHECK_TIMER(sk);
 	release_sock(sk);
 	return res;
 }
 
+
 #define TCP_PAGE(sk)	(sk->sk_sndmsg_page)
 #define TCP_OFF(sk)	(sk->sk_sndmsg_off)
 
@@ -1530,6 +1582,202 @@
 	goto out;
 }
 
+int tcp_recvpackets (struct sock *sk, struct sk_buff_head *packets,
+		     int len, int nonblock)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	int copied;
+	long timeo;
+
+	BUG_TRAP (len > 0);
+	/*BUG_TRAP ((flags & (MSG_OOB | MSG_PEEK | MSG_TRUNC)) == 0);*/
+
+	lock_sock(sk);
+
+	TCP_CHECK_TIMER(sk);
+
+	copied = -ENOTCONN;
+	if (sk->sk_state == TCP_LISTEN)
+		goto out;
+
+	copied = 0;
+	timeo = sock_rcvtimeo(sk, nonblock);
+
+	do {
+		struct sk_buff * skb;
+		u32 offset;
+		unsigned long used;
+		int exhausted;
+		int eaten;
+
+		/* Are we at urgent data? Stop if we have read anything. */
+		if (copied && tp->urg_data && tp->urg_seq == tp->copied_seq)
+			break;
+
+		/* We need to check signals first, to get correct SIGURG
+		 * handling. FIXME: Need to check this doesnt impact 1003.1g
+		 * and move it down to the bottom of the loop
+		 */
+		if (signal_pending(current)) {
+			if (copied)
+				break;
+			copied = timeo ? sock_intr_errno(timeo) : -EAGAIN;
+			break;
+		}
+
+		/* Next get a buffer. */
+
+		skb = skb_peek(&sk->sk_receive_queue);
+
+		if (skb == NULL)		/* nothing ready */
+		{
+			if (copied) {
+				if (sk->sk_err ||
+				    sk->sk_state == TCP_CLOSE ||
+				    (sk->sk_shutdown & RCV_SHUTDOWN) ||
+				    !timeo ||
+				    (0))
+					break;
+			} else {
+				if (sock_flag(sk, SOCK_DONE))
+					break;
+
+				if (sk->sk_err) {
+					copied = sock_error(sk);
+					break;
+				}
+
+				if (sk->sk_shutdown & RCV_SHUTDOWN)
+					break;
+
+				if (sk->sk_state == TCP_CLOSE) {
+					if (!(sock_flag(sk, SOCK_DONE))) {
+						/* This occurs when user tries to read
+						 * from never connected socket.
+						 */
+						copied = -ENOTCONN;
+						break;
+					}
+					break;
+				}
+
+				if (!timeo) {
+					copied = -EAGAIN;
+					break;
+				}
+			}
+
+			cleanup_rbuf(sk, copied);
+			sk_wait_data(sk, &timeo);
+			continue;
+		}
+
+		BUG_TRAP (atomic_read (&skb->users) == 1);
+
+		exhausted = eaten = 0;
+
+		offset = tp->copied_seq - TCP_SKB_CB(skb)->seq;
+		if (skb->h.th->syn)
+			offset--;
+
+		used = skb->len - offset;
+
+		if (tp->urg_data) {
+			u32 urg_offset = tp->urg_seq - tp->copied_seq;
+			if (urg_offset < used) {
+				if (!urg_offset) { /* at urgent date */
+					if (!(sock_flag(sk, SOCK_URGINLINE))) {
+						tp->copied_seq++; /* discard the single byte of urgent data */
+						offset++;
+						used--;
+					}
+				} else		/* truncate read */
+					used = urg_offset;
+			}
+		}
+
+		BUG_TRAP (used >= 0);
+		if (len < used)
+			used = len;
+
+		if (used == 0)
+			exhausted = 1;
+		else
+		{
+			if (skb_is_nonlinear (skb))
+			{
+				int   rc = skb_linearize (skb, GFP_KERNEL);
+
+				printk ("tcp_recvpackets(): linearising: %d\n", rc);
+
+				if (rc)
+				{
+					if (!copied)
+						copied = rc;
+					break;
+				}
+			}
+
+			if ((offset + used) == skb->len) /* consuming the whole packet */
+			{
+				__skb_unlink (skb, &sk->sk_receive_queue);
+				dst_release (skb->dst);
+				skb_orphan (skb);
+				__skb_pull (skb, offset);
+				__skb_queue_tail (packets, skb);
+				exhausted = eaten = 1;
+			}
+			else			/* consuming only part of the packet */
+			{
+				struct sk_buff *skb2 = skb_clone (skb, GFP_KERNEL);
+
+				if (skb2 == NULL)
+				{
+					if (!copied)
+						copied = -ENOMEM;
+					break;
+				}
+
+				dst_release (skb2->dst);
+				__skb_pull (skb2, offset);
+				__skb_trim (skb2, used);
+				__skb_queue_tail (packets, skb2);
+			}
+
+			tp->copied_seq += used;
+			copied += used;
+			len -= used;
+		}
+
+		if (tp->urg_data && after(tp->copied_seq,tp->urg_seq)) {
+			tp->urg_data = 0;
+			tcp_fast_path_check(sk, tp);
+		}
+
+		if (!exhausted)
+			continue;
+
+		if (skb->h.th->fin)
+		{
+			tp->copied_seq++;
+			if (!eaten)
+				sk_eat_skb (sk, skb);
+			break;
+		}
+
+		if (!eaten)
+			sk_eat_skb (sk, skb);
+
+	} while (len > 0);
+
+ out:
+	/* Clean up data we have read: This will do ACK frames. */
+	cleanup_rbuf(sk, copied);
+	TCP_CHECK_TIMER(sk);
+	release_sock(sk);
+	return copied;
+}
+
 /*
  *	State processing on a close. This implements the state shift for
  *	sending our FIN frame. Note that we only send a FIN for some
@@ -2380,6 +2628,8 @@
 EXPORT_SYMBOL(tcp_recvmsg);
 EXPORT_SYMBOL(tcp_sendmsg);
 EXPORT_SYMBOL(tcp_sendpage);
+EXPORT_SYMBOL(tcp_sendpage_zccd);
+EXPORT_SYMBOL(tcp_recvpackets);
 EXPORT_SYMBOL(tcp_setsockopt);
 EXPORT_SYMBOL(tcp_shutdown);
 EXPORT_SYMBOL(tcp_statistics);


