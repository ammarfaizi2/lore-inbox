Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280774AbRKGF4j>; Wed, 7 Nov 2001 00:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280779AbRKGF4a>; Wed, 7 Nov 2001 00:56:30 -0500
Received: from pizda.ninka.net ([216.101.162.242]:40322 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280774AbRKGF4N>;
	Wed, 7 Nov 2001 00:56:13 -0500
Date: Tue, 06 Nov 2001 21:55:41 -0800 (PST)
Message-Id: <20011106.215541.70220495.davem@redhat.com>
To: kaos@ocs.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 net errors
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <27124.1005106118@kao2.melbourne.sgi.com>
In-Reply-To: <27124.1005106118@kao2.melbourne.sgi.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Keith Owens <kaos@ocs.com.au>
   Date: Wed, 07 Nov 2001 15:08:38 +1100

   Compile a minimal 2.4.14 kernel, everything set to N.
   
   include/net/tcp_ecn.h: In function `TCP_ECN_send':

This problem has actually been around for a long time.  Be always
suspicious of generic networking support code which includes things
like "tcp.h" and "udp.h" :-)

Fix at the end of this email.

   # FIXME: this always selects these objects, even when CONFIG_NET is
   # 'n'.  Probably wrong but 2.4.0-test13-pre4 did the same.  KAO
   
   select(sock.o skbuff.o iovec.o datagram.o scm.o)
   
   Why do we compile these objects even when CONFIG_NET=n?
   
Probably to get the socket system calls.  That could easily be
fixed by just providing stubs.  There could be other references
via the VFS... one I know of is sock_readv_writev().

Anyways, here is the patch:

--- ./net/core/sock.c.~1~	Mon Nov  5 09:57:13 2001
+++ ./net/core/sock.c	Tue Nov  6 21:33:48 2001
@@ -113,18 +113,10 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
-#include <linux/inet.h>
 #include <linux/netdevice.h>
-#include <net/ip.h>
 #include <net/protocol.h>
-#include <net/arp.h>
-#include <net/route.h>
-#include <net/tcp.h>
-#include <net/udp.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <net/raw.h>
-#include <net/icmp.h>
 #include <linux/ipsec.h>
 
 #ifdef CONFIG_FILTER
--- ./net/core/skbuff.c.~1~	Sun Oct 21 02:47:54 2001
+++ ./net/core/skbuff.c	Tue Nov  6 21:33:24 2001
@@ -49,15 +49,14 @@
 #include <linux/string.h>
 #include <linux/skbuff.h>
 #include <linux/cache.h>
+#include <linux/rtnetlink.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
 
-#include <net/ip.h>
 #include <net/protocol.h>
 #include <net/dst.h>
-#include <net/tcp.h>
-#include <net/udp.h>
 #include <net/sock.h>
+#include <net/checksum.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
--- ./net/core/datagram.c.~1~	Sun Oct 21 02:47:54 2001
+++ ./net/core/datagram.c	Tue Nov  6 21:40:33 2001
@@ -30,21 +30,18 @@
 #include <asm/system.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
-#include <linux/in.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/inet.h>
 #include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
 #include <linux/poll.h>
 #include <linux/highmem.h>
 
-#include <net/ip.h>
 #include <net/protocol.h>
-#include <net/route.h>
-#include <net/tcp.h>
-#include <net/udp.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
+#include <net/checksum.h>
 
 
 /*
--- ./net/core/scm.c.~1~	Sun Oct 21 02:47:54 2001
+++ ./net/core/scm.c	Tue Nov  6 21:42:23 2001
@@ -26,11 +26,7 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
-#include <linux/inet.h>
-#include <net/ip.h>
 #include <net/protocol.h>
-#include <net/tcp.h>
-#include <net/udp.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
 #include <net/scm.h>
--- ./net/socket.c.~1~	Wed Oct 31 10:56:41 2001
+++ ./net/socket.c	Tue Nov  6 21:44:29 2001
@@ -79,12 +79,8 @@
 
 #include <asm/uaccess.h>
 
-#include <linux/inet.h>
-#include <net/ip.h>
 #include <net/sock.h>
-#include <net/tcp.h>
-#include <net/udp.h>
 #include <net/scm.h>
 #include <linux/netfilter.h>
 
