Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTIQPks (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 11:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262793AbTIQPks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 11:40:48 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:58801 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262790AbTIQPki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 11:40:38 -0400
Message-ID: <3F688074.7010905@acm.org>
Date: Wed, 17 Sep 2003 10:40:36 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Incorrect value for SIGRTMAX in the kernel
Content-Type: multipart/mixed;
 boundary="------------020208060507070804000800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020208060507070804000800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I was having a problem with signals with POSIX timers, and it turns out 
that the value of SIGRTMAX is incorrect.  Remember that there is no 
signal 0, so the signals should go from 1-_NSIG.  However, SIGRTMAX is 
defined as (_NSIG-1) in all architectures.  The following patch fixes this.

This define is only used in drivers/usb/core/devio.c and 
kernel/posix-timers.c, and both are incorrect without this fix.  There's 
also no check for zero in posix-timers.c, that fix is part of the diff.

Also, shouldn't do_sigaction() use this value instead of _NSIG?  It's 
not a big deal, but some architectures have different values for _NSIG 
and SIGRTMAX.

-Corey

--------------020208060507070804000800
Content-Type: text/plain;
 name="sigrtmax.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sigrtmax.diff"

Index: include/asm-alpha/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-alpha/signal.h,v
retrieving revision 1.7
diff -u -r1.7 signal.h
--- a/include/asm-alpha/signal.h	12 Feb 2003 02:58:50 -0000	1.7
+++ b/include/asm-alpha/signal.h	17 Sep 2003 13:02:39 -0000
@@ -71,7 +71,7 @@
 
 /* These should not be considered constants from userland.  */
 #define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define SIGRTMAX	_NSIG
 
 /*
  * SA_FLAGS values:
Index: include/asm-arm/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-arm/signal.h,v
retrieving revision 1.7
diff -u -r1.7 signal.h
--- a/include/asm-arm/signal.h	17 Feb 2003 21:23:05 -0000	1.7
+++ b/include/asm-arm/signal.h	17 Sep 2003 13:02:40 -0000
@@ -68,7 +68,7 @@
 
 /* These should not be considered constants from userland.  */
 #define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define SIGRTMAX	_NSIG
 
 #define SIGSWI		32
 
Index: include/asm-arm26/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-arm26/signal.h,v
retrieving revision 1.2
diff -u -r1.2 signal.h
--- a/include/asm-arm26/signal.h	8 Jun 2003 16:21:42 -0000	1.2
+++ b/include/asm-arm26/signal.h	17 Sep 2003 13:02:40 -0000
@@ -68,7 +68,7 @@
 
 /* These should not be considered constants from userland.  */
 #define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define SIGRTMAX	_NSIG
 
 #define SIGSWI		32
 
Index: include/asm-cris/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-cris/signal.h,v
retrieving revision 1.5
diff -u -r1.5 signal.h
--- a/include/asm-cris/signal.h	10 Jul 2003 17:33:07 -0000	1.5
+++ b/include/asm-cris/signal.h	17 Sep 2003 13:02:41 -0000
@@ -68,7 +68,7 @@
 
 /* These should not be considered constants from userland.  */
 #define SIGRTMIN        32
-#define SIGRTMAX        (_NSIG-1)
+#define SIGRTMAX        _NSIG
 
 /*
  * SA_FLAGS values:
Index: include/asm-h8300/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-h8300/signal.h,v
retrieving revision 1.2
diff -u -r1.2 signal.h
--- a/include/asm-h8300/signal.h	17 Apr 2003 23:27:57 -0000	1.2
+++ b/include/asm-h8300/signal.h	17 Sep 2003 13:02:41 -0000
@@ -68,7 +68,7 @@
 
 /* These should not be considered constants from userland.  */
 #define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define SIGRTMAX	_NSIG
 
 /*
  * SA_FLAGS values:
Index: include/asm-i386/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-i386/signal.h,v
retrieving revision 1.9
diff -u -r1.9 signal.h
--- a/include/asm-i386/signal.h	9 Apr 2003 00:14:26 -0000	1.9
+++ b/include/asm-i386/signal.h	17 Sep 2003 13:02:43 -0000
@@ -70,7 +70,7 @@
 
 /* These should not be considered constants from userland.  */
 #define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define SIGRTMAX	_NSIG
 
 /*
  * SA_FLAGS values:
Index: include/asm-ia64/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-ia64/signal.h,v
retrieving revision 1.11
diff -u -r1.11 signal.h
--- a/include/asm-ia64/signal.h	9 Sep 2003 16:07:11 -0000	1.11
+++ b/include/asm-ia64/signal.h	17 Sep 2003 13:02:44 -0000
@@ -50,7 +50,7 @@
 
 /* These should not be considered constants from userland.  */
 #define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define SIGRTMAX	_NSIG
 
 /*
  * SA_FLAGS values:
Index: include/asm-m68k/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-m68k/signal.h,v
retrieving revision 1.5
diff -u -r1.5 signal.h
--- a/include/asm-m68k/signal.h	7 Feb 2003 16:22:22 -0000	1.5
+++ b/include/asm-m68k/signal.h	17 Sep 2003 13:02:44 -0000
@@ -68,7 +68,7 @@
 
 /* These should not be considered constants from userland.  */
 #define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define SIGRTMAX	_NSIG
 
 /*
  * SA_FLAGS values:
Index: include/asm-m68knommu/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-m68knommu/signal.h,v
retrieving revision 1.4
diff -u -r1.4 signal.h
--- a/include/asm-m68knommu/signal.h	12 Feb 2003 02:58:50 -0000	1.4
+++ b/include/asm-m68knommu/signal.h	17 Sep 2003 13:02:44 -0000
@@ -68,7 +68,7 @@
 
 /* These should not be considered constants from userland.  */
 #define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define SIGRTMAX	_NSIG
 
 /*
  * SA_FLAGS values:
Index: include/asm-mips/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-mips/signal.h,v
retrieving revision 1.6
diff -u -r1.6 signal.h
--- a/include/asm-mips/signal.h	1 Aug 2003 05:40:55 -0000	1.6
+++ b/include/asm-mips/signal.h	17 Sep 2003 13:02:44 -0000
@@ -59,7 +59,7 @@
 
 /* These should not be considered constants from userland.  */
 #define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define SIGRTMAX	_NSIG
 
 /*
  * SA_FLAGS values:
Index: include/asm-parisc/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-parisc/signal.h,v
retrieving revision 1.4
diff -u -r1.4 signal.h
--- a/include/asm-parisc/signal.h	18 Mar 2003 20:49:12 -0000	1.4
+++ b/include/asm-parisc/signal.h	17 Sep 2003 13:02:44 -0000
@@ -42,7 +42,7 @@
 
 /* These should not be considered constants from userland.  */
 #define SIGRTMIN	37
-#define SIGRTMAX	(_NSIG-1) /* it's 44 under HP/UX */
+#define SIGRTMAX	_NSIG /* it's 44 under HP/UX */
 
 /*
  * SA_FLAGS values:
Index: include/asm-ppc/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-ppc/signal.h,v
retrieving revision 1.7
diff -u -r1.7 signal.h
--- a/include/asm-ppc/signal.h	12 Feb 2003 02:58:50 -0000	1.7
+++ b/include/asm-ppc/signal.h	17 Sep 2003 13:02:44 -0000
@@ -61,7 +61,7 @@
 
 /* These should not be considered constants from userland.  */
 #define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define SIGRTMAX	_NSIG
 
 /*
  * SA_FLAGS values:
Index: include/asm-ppc64/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-ppc64/signal.h,v
retrieving revision 1.7
diff -u -r1.7 signal.h
--- a/include/asm-ppc64/signal.h	3 Jun 2003 04:52:28 -0000	1.7
+++ b/include/asm-ppc64/signal.h	17 Sep 2003 13:02:45 -0000
@@ -57,7 +57,7 @@
 
 /* These should not be considered constants from userland.  */
 #define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define SIGRTMAX	_NSIG
 
 /*
  * SA_FLAGS values:
Index: include/asm-s390/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-s390/signal.h,v
retrieving revision 1.9
diff -u -r1.9 signal.h
--- a/include/asm-s390/signal.h	14 Apr 2003 18:27:39 -0000	1.9
+++ b/include/asm-s390/signal.h	17 Sep 2003 13:02:45 -0000
@@ -78,7 +78,7 @@
 
 /* These should not be considered constants from userland.  */
 #define SIGRTMIN        32
-#define SIGRTMAX        (_NSIG-1)
+#define SIGRTMAX        _NSIG
 
 /*
  * SA_FLAGS values:
Index: include/asm-sh/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-sh/signal.h,v
retrieving revision 1.6
diff -u -r1.6 signal.h
--- a/include/asm-sh/signal.h	2 Jul 2003 05:34:18 -0000	1.6
+++ b/include/asm-sh/signal.h	17 Sep 2003 13:02:45 -0000
@@ -57,7 +57,7 @@
 
 /* These should not be considered constants from userland.  */
 #define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define SIGRTMAX	_NSIG
 
 /*
  * SA_FLAGS values:
Index: include/asm-sparc/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-sparc/signal.h,v
retrieving revision 1.7
diff -u -r1.7 signal.h
--- a/include/asm-sparc/signal.h	21 Apr 2003 05:05:24 -0000	1.7
+++ b/include/asm-sparc/signal.h	17 Sep 2003 13:02:46 -0000
@@ -89,7 +89,7 @@
 #define _NSIG_WORDS	(__NEW_NSIG / _NSIG_BPW)
 
 #define SIGRTMIN	32
-#define SIGRTMAX	(__NEW_NSIG - 1)
+#define SIGRTMAX	__NEW_NSIG
 
 #if defined(__KERNEL__) || defined(__WANT_POSIX1B_SIGNALS__)
 #define	_NSIG		__NEW_NSIG
Index: include/asm-sparc64/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-sparc64/signal.h,v
retrieving revision 1.10
diff -u -r1.10 signal.h
--- a/include/asm-sparc64/signal.h	21 Apr 2003 05:05:24 -0000	1.10
+++ b/include/asm-sparc64/signal.h	17 Sep 2003 13:02:46 -0000
@@ -89,7 +89,7 @@
 #define _NSIG_WORDS   	(__NEW_NSIG / _NSIG_BPW)
 
 #define SIGRTMIN       32
-#define SIGRTMAX       (__NEW_NSIG - 1)
+#define SIGRTMAX       __NEW_NSIG
 
 #if defined(__KERNEL__) || defined(__WANT_POSIX1B_SIGNALS__)
 #define _NSIG			__NEW_NSIG
Index: include/asm-v850/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-v850/signal.h,v
retrieving revision 1.4
diff -u -r1.4 signal.h
--- a/include/asm-v850/signal.h	12 Feb 2003 02:58:50 -0000	1.4
+++ b/include/asm-v850/signal.h	17 Sep 2003 13:02:47 -0000
@@ -71,7 +71,7 @@
 
 /* These should not be considered constants from userland.  */
 #define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define SIGRTMAX	_NSIG
 
 /*
  * SA_FLAGS values:
Index: include/asm-x86_64/signal.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-x86_64/signal.h,v
retrieving revision 1.8
diff -u -r1.8 signal.h
--- a/include/asm-x86_64/signal.h	22 Feb 2003 23:46:46 -0000	1.8
+++ b/include/asm-x86_64/signal.h	17 Sep 2003 13:02:47 -0000
@@ -77,7 +77,7 @@
 
 /* These should not be considered constants from userland.  */
 #define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define SIGRTMAX	_NSIG
 
 /*
  * SA_FLAGS values:
Index: kernel/posix-timers.c
===================================================================
RCS file: /home/cvs/linux-2.5/kernel/posix-timers.c,v
retrieving revision 1.21
diff -u -r1.21 posix-timers.c
--- a/kernel/posix-timers.c	1 Sep 2003 16:44:03 -0000	1.21
+++ b/kernel/posix-timers.c	17 Sep 2003 13:59:22 -0000
@@ -344,6 +344,7 @@
 		return NULL;
 
 	if ((event->sigev_notify & ~SIGEV_NONE & MIPS_SIGEV) &&
+			event->sigev_signo &&
 			((unsigned) (event->sigev_signo > SIGRTMAX)))
 		return NULL;
 

--------------020208060507070804000800--

