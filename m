Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317131AbSFFTiM>; Thu, 6 Jun 2002 15:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317140AbSFFTiL>; Thu, 6 Jun 2002 15:38:11 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:60091 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S317131AbSFFTho>; Thu, 6 Jun 2002 15:37:44 -0400
Message-ID: <3CFFB9F8.54455B6E@nortelnetworks.com>
Date: Thu, 06 Jun 2002 15:37:28 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: RFC: per-socket statistics on received/dropped packets
Content-Type: multipart/mixed;
 boundary="------------A0F272EED9DE80C6387983F5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A0F272EED9DE80C6387983F5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


For a while I've been wanting a way for a program to find out if any of its
socket buffers were overflowing due to too much incoming traffic.  Finally, I
decided to code it up and try it out.

As it turns out, it was relatively simple to add, although it required the
addition of two new entries in sockios.h.

Basically, inside of sock_queue_rcv_skb() and sock_queue_err_skb() the receive
counter gets incremented unconditionally, and then if there is no free space in
the socket buffer then we also increment the counter for messages dropped due to
out of memory.

The stats are stored as part of a socket_stats struct, making it easy to add
other counters in the future.

To access and reset the counters, two ioctl commands were added to the socket
ioctl. GIOCSOCKSTATS is used to get the stats, while SIOCZEROSOCKSTATS is used
to reset them.  I haven't bothered with trying to reset them both atomically as
I don't think it's that critical.

The patch was coded and tested for 2.4.18, but it is known to at least apply
(with offsets) on 2.5.20.

Feel free to bash on it a bit, once the issues are worked out I'll submit to the
appropriate maintainer.

Chris
 
-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
--------------A0F272EED9DE80C6387983F5
Content-Type: text/plain; charset=us-ascii;
 name="sockstats.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sockstats.patch"

diff -Nur 2.4.18/include/linux/sockios.h 2.4.18/include/linux/sockios.h
--- 2.4.18/include/linux/sockios.h	Wed Nov  7 17:39:36 2001
+++ 2.4.18/include/linux/sockios.h	Wed Jun  5 15:55:54 2002
@@ -113,6 +113,10 @@
 #define SIOCBONDSLAVEINFOQUERY 0x8993   /* rtn info about slave state   */
 #define SIOCBONDINFOQUERY      0x8994	/* rtn info about bond state    */
 #define SIOCBONDCHANGEACTIVE   0x8995   /* update to a new active slave */
+
+/* per-socket statistics manipulation */
+#define GIOCSOCKSTATS		0x8996	/* get the per-socket statistics */
+#define  SIOCZEROSOCKSTATS	0x8997	/* zero out the per-socket statistics */
 			
 /* Device private ioctl calls */
 
diff -Nur 2.4.18/include/net/sock.h 2.4.18/include/net/sock.h
--- 2.4.18/include/net/sock.h	Thu May  2 15:32:20 2002
+++ 2.4.18/include/net/sock.h	Wed Jun  5 15:58:24 2002
@@ -480,6 +480,16 @@
 	wait_queue_head_t	wq;
 } socket_lock_t;
 
+/* per-socket statistics.  received is the total number of skbuffs received
+ * on that socket.  dropped_no_mem is the number of packets dropped due
+ * to a lack of space on the socket receive buffer
+ */
+typedef struct {
+	__u64			received;
+	__u32			dropped_no_mem;
+} socket_stats;
+
+
 #define sock_lock_init(__sk) \
 do {	spin_lock_init(&((__sk)->lock.slock)); \
 	(__sk)->lock.users = 0; \
@@ -678,6 +688,10 @@
   	int			(*backlog_rcv) (struct sock *sk,
 						struct sk_buff *skb);  
 	void                    (*destruct)(struct sock *sk);
+	
+	
+	/* per-socket statistics */
+	socket_stats		stats;
 };
 
 /* The per-socket spinlock must be held here. */
@@ -1145,11 +1159,15 @@
 
 static inline int sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
+	sk->stats.received++;
+
 	/* Cast skb->rcvbuf to unsigned... It's pointless, but reduces
 	   number of warnings when compiling with -W --ANK
 	 */
-	if (atomic_read(&sk->rmem_alloc) + skb->truesize >= (unsigned)sk->rcvbuf)
+	if (atomic_read(&sk->rmem_alloc) + skb->truesize >= (unsigned)sk->rcvbuf) {
+		sk->stats.dropped_no_mem++;
                 return -ENOMEM;
+	}
 
 #ifdef CONFIG_FILTER
 	if (sk->filter) {
@@ -1179,11 +1197,16 @@
 
 static inline int sock_queue_err_skb(struct sock *sk, struct sk_buff *skb)
 {
+	sk->stats.received++;
+	
 	/* Cast skb->rcvbuf to unsigned... It's pointless, but reduces
 	   number of warnings when compiling with -W --ANK
 	 */
-	if (atomic_read(&sk->rmem_alloc) + skb->truesize >= (unsigned)sk->rcvbuf)
+	if (atomic_read(&sk->rmem_alloc) + skb->truesize >= (unsigned)sk->rcvbuf) {
+		sk->stats.dropped_no_mem++;
 		return -ENOMEM;
+	}
+	
 	skb_set_owner_r(skb, sk);
 	skb_queue_tail(&sk->error_queue,skb);
 	if (!sk->dead)
diff -Nur 2.4.18/net/core/sock.c 2.4.18/net/core/sock.c
--- 2.4.18/net/core/sock.c	Fri Dec 21 12:42:05 2001
+++ 2.4.18/net/core/sock.c	Wed Jun  5 13:59:37 2002
@@ -1202,6 +1202,9 @@
 	sk->rcvlowat		=	1;
 	sk->rcvtimeo		=	MAX_SCHEDULE_TIMEOUT;
 	sk->sndtimeo		=	MAX_SCHEDULE_TIMEOUT;
+	
+	sk->stats.received	=	0;
+	sk->stats.dropped_no_mem	=	0;
 
 	atomic_set(&sk->refcnt, 1);
 }
diff -Nur 2.4.18/net/ipv4/af_inet.c 2.4.18/net/ipv4/af_inet.c
--- 2.4.18/net/ipv4/af_inet.c	Fri Dec 21 12:42:05 2001
+++ 2.4.18/net/ipv4/af_inet.c	Wed Jun  5 15:56:20 2002
@@ -834,6 +834,16 @@
 	int pid;
 
 	switch(cmd) {
+		case GIOCSOCKSTATS:
+			return copy_to_user((void *)arg, &sk->stats, sizeof(sk->stats));
+		case SIOCZEROSOCKSTATS:
+			if (!capable(CAP_NET_ADMIN))
+				return -EPERM;
+			else {
+				sk->stats.dropped_no_mem = 0;
+				sk->stats.received = 0;
+				return (0);
+			}
 		case FIOSETOWN:
 		case SIOCSPGRP:
 			err = get_user(pid, (int *) arg);

--------------A0F272EED9DE80C6387983F5--

