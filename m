Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311883AbSCTRnP>; Wed, 20 Mar 2002 12:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311884AbSCTRm4>; Wed, 20 Mar 2002 12:42:56 -0500
Received: from ep09.kernel.pl ([212.87.11.162]:42128 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S311882AbSCTRmm>;
	Wed, 20 Mar 2002 12:42:42 -0500
Date: Wed, 20 Mar 2002 18:42:38 +0100
From: Michal Moskal <malekith@pld.org.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] gcc-3.1 ffs problem, kernel 2.4.18
Message-ID: <20020320174238.GA13533@ep09.kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patch is needed to compile linux-2.4.18 with xfs patch with
recent gcc 3.1 snapshot. It is clearly bug in linux includes (they use
asm code unconditionally, even on constants, and they can get constants
if exposed to tree-inliner). Other asm includes might need fixing too,
I saw asm-cris is fixed already.

Beside this linux-2.4.18 compiled with gcc-3.1 20020311 works fine for
me.

diff -ur linux-/include/asm-i386/bitops.h linux/include/asm-i386/bitops.h
--- linux-/include/asm-i386/bitops.h	Thu Nov 22 20:46:18 2001
+++ linux/include/asm-i386/bitops.h	Tue Mar  5 21:08:15 2002
@@ -316,6 +316,8 @@
 	return (offset + set + res);
 }
 
+#include <linux/bitops.h>
+
 /**
  * ffz - find first zero in word.
  * @word: The word to search
@@ -324,10 +326,16 @@
  */
 static __inline__ unsigned long ffz(unsigned long word)
 {
-	__asm__("bsfl %1,%0"
-		:"=r" (word)
-		:"r" (~word));
-	return word;
+	/* The generic_ffs function is used to avoid the asm when the
+	   argument is a constant.  */
+	if (__builtin_constant_p (word)) {
+		return (~word ? (unsigned long) generic_ffs ((int) ~word) - 1 : 32);
+	} else {
+		__asm__("bsfl %1,%0"
+			:"=r" (word)
+			:"r" (~word));
+		return word;
+	}
 }
 
 #ifdef __KERNEL__
@@ -342,13 +350,19 @@
  */
 static __inline__ int ffs(int x)
 {
-	int r;
-
-	__asm__("bsfl %1,%0\n\t"
-		"jnz 1f\n\t"
-		"movl $-1,%0\n"
-		"1:" : "=r" (r) : "g" (x));
-	return r+1;
+	/* The generic_ffs function is used to avoid the asm when the
+	   argument is a constant.  */
+	if (__builtin_constant_p (x)) {
+		return generic_ffs (x);
+	} else {
+		int r;
+		
+		__asm__("bsfl %1,%0\n\t"
+			"jnz 1f\n\t"
+			"movl $-1,%0\n"
+			"1:" : "=r" (r) : "g" (x));
+		return r+1;
+	}
 }
 
 /**

-- 
: Michal Moskal :::::::: malekith/at/pld.org.pl :  GCS {C,UL}++++$ a? !tv
: PLD Linux ::::::: Wroclaw University, CS Dept :  {E-,w}-- {b++,e}>+++ h

