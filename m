Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262981AbSJaS4X>; Thu, 31 Oct 2002 13:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263016AbSJaS4Q>; Thu, 31 Oct 2002 13:56:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4882 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262981AbSJaSzj>;
	Thu, 31 Oct 2002 13:55:39 -0500
Date: Thu, 31 Oct 2002 19:02:05 +0000
From: Matthew Wilcox <willy@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [PATCH] update packet & wanpipe ioctl routines
Message-ID: <20021031190205.M27461@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert af_packet.c and af_wanpipe.c to call dev_ioctl by default.  I'm
less than convinced these protocols should be calling inet_ioctl, but I'm
not going to change that behaviour.

diff -urpNX dontdiff linux-2.5.45/net/packet/af_packet.c linux-2.5.45-willy/net/packet/af_packet.c
--- linux-2.5.45/net/packet/af_packet.c	2002-10-31 10:28:10.000000000 -0500
+++ linux-2.5.45-willy/net/packet/af_packet.c	2002-10-29 17:25:30.000000000 -0500
@@ -1432,8 +1432,7 @@ static int packet_ioctl(struct socket *s
 {
 	struct sock *sk = sock->sk;
 
-	switch(cmd) 
-	{
+	switch(cmd) {
 		case SIOCOUTQ:
 		{
 			int amount = atomic_read(&sk->wmem_alloc);
@@ -1452,35 +1451,12 @@ static int packet_ioctl(struct socket *s
 			return put_user(amount, (int *)arg);
 		}
 		case SIOCGSTAMP:
-			if(sk->stamp.tv_sec==0)
+			if (sk->stamp.tv_sec==0)
 				return -ENOENT;
 			if (copy_to_user((void *)arg, &sk->stamp,
 					 sizeof(struct timeval)))
 				return -EFAULT;
 			break;
-		case SIOCGIFFLAGS:
-#ifndef CONFIG_INET
-		case SIOCSIFFLAGS:
-#endif
-		case SIOCGIFCONF:
-		case SIOCGIFMETRIC:
-		case SIOCSIFMETRIC:
-		case SIOCGIFMEM:
-		case SIOCSIFMEM:
-		case SIOCGIFMTU:
-		case SIOCSIFMTU:
-		case SIOCSIFLINK:
-		case SIOCGIFHWADDR:
-		case SIOCSIFHWADDR:
-		case SIOCSIFMAP:
-		case SIOCGIFMAP:
-		case SIOCSIFSLAVE:
-		case SIOCGIFSLAVE:
-		case SIOCGIFINDEX:
-		case SIOCGIFNAME:
-		case SIOCGIFCOUNT:
-		case SIOCSIFHWBROADCAST:
-			return(dev_ioctl(cmd,(void *) arg));
 
 #ifdef CONFIG_INET
 		case SIOCADDRT:
@@ -1501,7 +1477,7 @@ static int packet_ioctl(struct socket *s
 #endif
 
 		default:
-			return -EOPNOTSUPP;
+			return dev_ioctl(cmd, (void *)arg);
 	}
 	return 0;
 }
diff -urpNX dontdiff linux-2.5.45/net/wanrouter/af_wanpipe.c linux-2.5.45-willy/net/wanrouter/af_wanpipe.c
--- linux-2.5.45/net/wanrouter/af_wanpipe.c	2002-10-31 10:28:10.000000000 -0500
+++ linux-2.5.45-willy/net/wanrouter/af_wanpipe.c	2002-10-29 16:34:36.000000000 -0500
@@ -1922,30 +1922,6 @@ static int wanpipe_ioctl(struct socket *
 			sock->file->f_flags |= O_NONBLOCK;
 			return 0;
 	
-		case SIOCGIFFLAGS:
-#ifndef CONFIG_INET
-		case SIOCSIFFLAGS:
-#endif
-		case SIOCGIFCONF:
-		case SIOCGIFMETRIC:
-		case SIOCSIFMETRIC:
-		case SIOCGIFMEM:
-		case SIOCSIFMEM:
-		case SIOCGIFMTU:
-		case SIOCSIFMTU:
-		case SIOCSIFLINK:
-		case SIOCGIFHWADDR:
-		case SIOCSIFHWADDR:
-		case SIOCSIFMAP:
-		case SIOCGIFMAP:
-		case SIOCSIFSLAVE:
-		case SIOCGIFSLAVE:
-		case SIOCGIFINDEX:
-		case SIOCGIFNAME:
-		case SIOCGIFCOUNT:
-		case SIOCSIFHWBROADCAST:
-			return(dev_ioctl(cmd,(void *) arg));
-
 #ifdef CONFIG_INET
 		case SIOCADDRT:
 		case SIOCDELRT:
@@ -1968,7 +1944,7 @@ static int wanpipe_ioctl(struct socket *
 #endif
 
 		default:
-			return -EOPNOTSUPP;
+			return dev_ioctl(cmd,(void *) arg);
 	}
 	/*NOTREACHED*/
 }

-- 
Revolutions do not require corporate support.
