Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbULOVOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbULOVOr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 16:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbULOVOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 16:14:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39887 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262499AbULOVOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 16:14:10 -0500
Date: Wed, 15 Dec 2004 13:13:42 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: netdev@oss.sgi.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org, <shemminger@osdl.org>,
       davem@redhat.com
Subject: udp_poll breaks vpnc
Message-ID: <20041215131342.21768388@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Guys:

I found that the attached patch breaks VPNC. By looking at strace, it never
gets any poll events about arriving encrypted data. It may be a bug in VPNC,
but this is a rather old binary which I used even on 2.4...

Unfortunately, I cannot investigate it closer at this time, because of, uhh,
some work commitments. Sorry. I do not insist that we back this out, but
let it be known that something was broken.

Cheers,
-- Pete

diff -urp -X dontdiff linux-2.6.10-rc2-bk8-usb/include/net/udp.h linux-2.6.10-rc3-usb/include/net/udp.h
--- linux-2.6.10-rc2-bk8-usb/include/net/udp.h	2004-08-19 17:16:10.000000000 -0700
+++ linux-2.6.10-rc3-usb/include/net/udp.h	2004-12-15 02:01:19.000000000 -0800
@@ -71,6 +71,8 @@ extern int	udp_sendmsg(struct kiocb *ioc
 extern int	udp_rcv(struct sk_buff *skb);
 extern int	udp_ioctl(struct sock *sk, int cmd, unsigned long arg);
 extern int	udp_disconnect(struct sock *sk, int flags);
+extern unsigned int udp_poll(struct file *file, struct socket *sock,
+			     poll_table *wait);
 
 DECLARE_SNMP_STAT(struct udp_mib, udp_statistics);
 #define UDP_INC_STATS(field)		SNMP_INC_STATS(udp_statistics, field)
diff -urp -X dontdiff linux-2.6.10-rc2-bk8-usb/net/ipv4/af_inet.c linux-2.6.10-rc3-usb/net/ipv4/af_inet.c
--- linux-2.6.10-rc2-bk8-usb/net/ipv4/af_inet.c	2004-11-23 09:54:15.000000000 -0800
+++ linux-2.6.10-rc3-usb/net/ipv4/af_inet.c	2004-12-15 02:01:21.000000000 -0800
@@ -809,7 +809,7 @@ struct proto_ops inet_dgram_ops = {
 	.socketpair =	sock_no_socketpair,
 	.accept =	sock_no_accept,
 	.getname =	inet_getname,
-	.poll =		datagram_poll,
+	.poll =		udp_poll,
 	.ioctl =	inet_ioctl,
 	.listen =	sock_no_listen,
 	.shutdown =	inet_shutdown,
diff -urp -X dontdiff linux-2.6.10-rc2-bk8-usb/net/ipv4/udp.c linux-2.6.10-rc3-usb/net/ipv4/udp.c
--- linux-2.6.10-rc2-bk8-usb/net/ipv4/udp.c	2004-11-23 09:54:15.000000000 -0800
+++ linux-2.6.10-rc3-usb/net/ipv4/udp.c	2004-12-15 02:01:21.000000000 -0800
@@ -1303,6 +1303,52 @@ static int udp_getsockopt(struct sock *s
   	return 0;
 }
 
+/**
+ * 	udp_poll - wait for a UDP event.
+ *	@file - file struct
+ *	@sock - socket
+ *	@wait - poll table
+ *
+ *	This is same as datagram poll, except for the special case of 
+ *	blocking sockets. If application is using a blocking fd
+ *	and a packet with checksum error is in the queue;
+ *	then it could get return from select indicating data available
+ *	but then block when reading it. Add special case code
+ *	to work around these arguably broken applications.
+ */
+unsigned int udp_poll(struct file *file, struct socket *sock, poll_table *wait)
+{
+	unsigned int mask = datagram_poll(file, sock, wait);
+	struct sock *sk = sock->sk;
+	
+	/* Check for false positives due to checksum errors */
+	if ( (mask & POLLRDNORM) &&
+	     !(file->f_flags & O_NONBLOCK) &&
+	     !(sk->sk_shutdown & RCV_SHUTDOWN)){
+		struct sk_buff_head *rcvq = &sk->sk_receive_queue;
+		struct sk_buff *skb;
+
+		spin_lock_irq(&rcvq->lock);
+		while ((skb = skb_peek(rcvq)) != NULL) {
+			if (udp_checksum_complete(skb)) {
+				UDP_INC_STATS_BH(UDP_MIB_INERRORS);
+				__skb_unlink(skb, rcvq);
+				kfree_skb(skb);
+			} else {
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
+				break;
+			}
+		}
+		spin_unlock_irq(&rcvq->lock);
+
+		/* nothing to see, move along */
+		if (skb == NULL)
+			mask &= ~(POLLIN | POLLRDNORM);
+	}
+
+	return mask;
+	
+}
 
 struct proto udp_prot = {
  	.name =		"UDP",
@@ -1517,6 +1563,7 @@ EXPORT_SYMBOL(udp_ioctl);
 EXPORT_SYMBOL(udp_port_rover);
 EXPORT_SYMBOL(udp_prot);
 EXPORT_SYMBOL(udp_sendmsg);
+EXPORT_SYMBOL(udp_poll);
 
 #ifdef CONFIG_PROC_FS
 EXPORT_SYMBOL(udp_proc_register);
diff -urp -X dontdiff linux-2.6.10-rc2-bk8-usb/net/ipv6/af_inet6.c linux-2.6.10-rc3-usb/net/ipv6/af_inet6.c
--- linux-2.6.10-rc2-bk8-usb/net/ipv6/af_inet6.c	2004-11-23 09:54:15.000000000 -0800
+++ linux-2.6.10-rc3-usb/net/ipv6/af_inet6.c	2004-12-15 02:01:21.000000000 -0800
@@ -501,7 +501,7 @@ struct proto_ops inet6_dgram_ops = {
 	.socketpair =	sock_no_socketpair,		/* a do nothing	*/
 	.accept =	sock_no_accept,			/* a do nothing	*/
 	.getname =	inet6_getname, 
-	.poll =		datagram_poll,			/* ok		*/
+	.poll =		udp_poll,			/* ok		*/
 	.ioctl =	inet6_ioctl,			/* must change  */
 	.listen =	sock_no_listen,			/* ok		*/
 	.shutdown =	inet_shutdown,			/* ok		*/
