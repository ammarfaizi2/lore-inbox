Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318855AbSHWPMH>; Fri, 23 Aug 2002 11:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318857AbSHWPMH>; Fri, 23 Aug 2002 11:12:07 -0400
Received: from codepoet.org ([166.70.99.138]:10130 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S318855AbSHWPMF>;
	Fri, 23 Aug 2002 11:12:05 -0400
Date: Fri, 23 Aug 2002 09:16:15 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix bitops.h circular dependancies
Message-ID: <20020823151615.GB24609@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200208231046.g7NAk2914276@devserv.devel.redhat.com> <20020823145907.GA24609@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020823145907.GA24609@codepoet.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 23, 2002 at 08:59:08AM -0600, Erik wrote:
> It appears that linux/bitops.h includes asm/bitops.h, which itself
> includes linux/bitops.h prior to the #define fls(x)...  Both files
> have include guards, therefore the #define never happens....

Here is a fix.  Not an ideal fix, but it at least works.


--- linux-2.4.20-pre4-ac1/include/asm/bitops.h.orig	Fri Aug 23 08:56:27 2002
+++ linux-2.4.20-pre4-ac1/include/asm/bitops.h	Fri Aug 23 09:12:02 2002
@@ -24,6 +24,35 @@
 
 #define ADDR (*(volatile long *) addr)
 
+static __inline__ int __generic_ffs(int x)
+{
+	int r = 1;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff)) {
+		x >>= 16;
+		r += 16;
+	}
+	if (!(x & 0xff)) {
+		x >>= 8;
+		r += 8;
+	}
+	if (!(x & 0xf)) {
+		x >>= 4;
+		r += 4;
+	}
+	if (!(x & 3)) {
+		x >>= 2;
+		r += 2;
+	}
+	if (!(x & 1)) {
+		x >>= 1;
+		r += 1;
+	}
+	return r;
+}
+
 /**
  * set_bit - Atomically set a bit in memory
  * @nr: the bit to set
@@ -386,8 +415,6 @@
 	return (offset + set + res);
 }
 
-#include <linux/bitops.h>
-
 /**
  * ffz - find first zero in word.
  * @word: The word to search
@@ -399,7 +426,7 @@
 	/* The generic_ffs function is used to avoid the asm when the
 	   argument is a constant.  */
 	if (__builtin_constant_p (word)) {
-		return (~word ? (unsigned long) generic_ffs ((int) ~word) - 1 : 32);
+		return (~word ? (unsigned long) __generic_ffs ((int) ~word) - 1 : 32);
 	} else {
 		__asm__("bsfl %1,%0"
 			:"=r" (word)
@@ -462,7 +489,7 @@
 	/* The generic_ffs function is used to avoid the asm when the
 	   argument is a constant.  */
 	if (__builtin_constant_p (x)) {
-		return generic_ffs (x);
+		return __generic_ffs (x);
 	} else {
 		int r;
 
--- linux-2.4.20-pre4-ac1/include/linux/bitops.h.orig	Fri Aug 23 08:57:43 2002
+++ linux-2.4.20-pre4-ac1/include/linux/bitops.h	Fri Aug 23 09:12:12 2002
@@ -2,6 +2,7 @@
 #define _LINUX_BITOPS_H
 #include <asm/bitops.h>
 
+
 /*
  * ffs: find first bit set. This is defined the same way as
  * the libc and compiler builtin ffs routines, therefore
@@ -106,8 +107,5 @@
         res = (res & 0x33) + ((res >> 2) & 0x33);
         return (res & 0x0F) + ((res >> 4) & 0x0F);
 }
-
-#include <asm/bitops.h>
-
 
 #endif

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
