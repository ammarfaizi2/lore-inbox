Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292280AbSBTUHA>; Wed, 20 Feb 2002 15:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292276AbSBTUGw>; Wed, 20 Feb 2002 15:06:52 -0500
Received: from mallaury.noc.nerim.net ([62.4.17.82]:57864 "HELO
	mallaury.noc.nerim.net") by vger.kernel.org with SMTP
	id <S292255AbSBTUGm>; Wed, 20 Feb 2002 15:06:42 -0500
To: davem@caip.rutgers.edu, Eric.Schenk@dna.lth.se, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PROBLEM+PATCH] linux 2.[45].x: negative inode numbers in /proc/net/*
From: Arnaud Giersch <arnaud.giersch@free.fr>
Organization: NaN
X-Face: &yL?ZRfSIk3zaRm*dlb3R4f.8RM"~b/h|\wI]>pL)}]l$H>.Q3Qd3[<h!`K6mI=+cWpg-El
 B(FEm\EEdLdS{2l7,8\!RQ5aL0ZXlzzPKLxV/OQfrg/<t!FG>i.K[5isyT&2oBNdnvk`~y}vwPYL;R
 y)NYo"]T8NlX{nmIUEi\a$hozWm#0GCT'e'{5f@Rl"[g|I8<{By=R8R>bDe>W7)S0-8:b;ZKo~9K?'
 wq!G,MQ\eSt8g`)jeITEuig89NGmN^%1j>!*F8~kW(yfF7W[:bl>RT[`w3x-C
Date: 20 Feb 2002 21:06:39 +0100
Message-ID: <871yff535c.fsf@free.fr>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I think I found a little but annoying bug in the /proc/net reporting
functions for various types of sockets: when the inode numbers become
large enough, they are printed as negative values.

For example in /proc/net/{udp,unix} (kernel 2.4.17, i686):

        $ cat /proc/net/udp
          sl  ...  inode
        [...]
          79: ...  -1834994132 2 dba94580
        [...]

        $ cat /proc/net/unix
        Num       ...  Inode Path
        [...]
        c35b1580: ...  -2123437312 /tmp/.X11-unix/X0
        ce571040: ...  -2123437313
        [...]

I found it because it causes netstat <= 1.60 to segfault (there was of
course a bug in netstat too).

This can be reproduced using brute force: keep opening and closing
sockets during enough time in order to have inode numbers become
greater than 2^31 (this takes a few hours on my AMD Duron 800).

The problem exists apparently in all 2.4.x and 2.5.x kernel versions.

The reason is that the inode numbers are printed as signed long ("%ld"
printf format) instead of unsigned long ("%lu" printf format) as it
should be.

I grep'ed the kernel source net subdirectory in order to find other
similar bugs. I found that it is present for {ipv4,ipv6}/{raw,udp} and
unix sockets.

Here is my patch against kernel version 2.4.17:

<======================================================================>
diff -Naur linux.orig/net/ipv4/raw.c linux/net/ipv4/raw.c
--- linux.orig/net/ipv4/raw.c	Wed Jul 11 01:11:43 2001
+++ linux/net/ipv4/raw.c	Tue Feb 19 23:06:45 2002
@@ -631,7 +631,7 @@
 	      srcp  = sp->num;
 
 	sprintf(tmpbuf, "%4d: %08X:%04X %08X:%04X"
-		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %ld %d %p",
+		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %lu %d %p",
 		i, src, srcp, dest, destp, sp->state, 
 		atomic_read(&sp->wmem_alloc), atomic_read(&sp->rmem_alloc),
 		0, 0L, 0,
diff -Naur linux.orig/net/ipv4/udp.c linux/net/ipv4/udp.c
--- linux.orig/net/ipv4/udp.c	Wed Oct 17 23:16:39 2001
+++ linux/net/ipv4/udp.c	Mon Feb 18 15:49:49 2002
@@ -957,7 +957,7 @@
 	destp = ntohs(sp->dport);
 	srcp  = ntohs(sp->sport);
 	sprintf(tmpbuf, "%4d: %08X:%04X %08X:%04X"
-		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %ld %d %p",
+		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %lu %d %p",
 		i, src, srcp, dest, destp, sp->state, 
 		atomic_read(&sp->wmem_alloc), atomic_read(&sp->rmem_alloc),
 		0, 0L, 0,
diff -Naur linux.orig/net/ipv6/raw.c linux/net/ipv6/raw.c
--- linux.orig/net/ipv6/raw.c	Thu Sep 20 23:12:56 2001
+++ linux/net/ipv6/raw.c	Tue Feb 19 23:10:33 2002
@@ -761,7 +761,7 @@
 	srcp  = sp->num;
 	sprintf(tmpbuf,
 		"%4d: %08X%08X%08X%08X:%04X %08X%08X%08X%08X:%04X "
-		"%02X %08X:%08X %02X:%08lX %08X %5d %8d %ld %d %p",
+		"%02X %08X:%08X %02X:%08lX %08X %5d %8d %lu %d %p",
 		i,
 		src->s6_addr32[0], src->s6_addr32[1],
 		src->s6_addr32[2], src->s6_addr32[3], srcp,
diff -Naur linux.orig/net/ipv6/udp.c linux/net/ipv6/udp.c
--- linux.orig/net/ipv6/udp.c	Fri Sep  7 20:01:21 2001
+++ linux/net/ipv6/udp.c	Tue Feb 19 23:10:18 2002
@@ -916,7 +916,7 @@
 	srcp  = ntohs(sp->sport);
 	sprintf(tmpbuf,
 		"%4d: %08X%08X%08X%08X:%04X %08X%08X%08X%08X:%04X "
-		"%02X %08X:%08X %02X:%08lX %08X %5d %8d %ld %d %p",
+		"%02X %08X:%08X %02X:%08lX %08X %5d %8d %lu %d %p",
 		i,
 		src->s6_addr32[0], src->s6_addr32[1],
 		src->s6_addr32[2], src->s6_addr32[3], srcp,
diff -Naur linux.orig/net/unix/af_unix.c linux/net/unix/af_unix.c
--- linux.orig/net/unix/af_unix.c	Fri Dec 21 18:42:06 2001
+++ linux/net/unix/af_unix.c	Mon Feb 18 22:01:29 2002
@@ -1742,7 +1742,7 @@
 	{
 		unix_state_rlock(s);
 
-		len+=sprintf(buffer+len,"%p: %08X %08X %08X %04X %02X %5ld",
+		len+=sprintf(buffer+len,"%p: %08X %08X %08X %04X %02X %5lu",
 			s,
 			atomic_read(&s->refcnt),
 			0,
<======================================================================>


Greetings
-- 
Arnaud
