Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132202AbRAASbe>; Mon, 1 Jan 2001 13:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132125AbRAASbX>; Mon, 1 Jan 2001 13:31:23 -0500
Received: from mout1.freenet.de ([194.97.50.132]:1212 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S132124AbRAASbM>;
	Mon, 1 Jan 2001 13:31:12 -0500
From: Andreas Franck <afranck@gmx.de>
Date: Mon, 1 Jan 2001 19:00:41 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_5PWHEQIWWPXL3BWY2LHE"
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Mike Galbraith <mikeg@wen-online.de>
Subject: [revisited] Oops on boot with 2.4.0testX and GCC snapshots
MIME-Version: 1.0
Message-Id: <01010119004100.01545@dg1kfa.ampr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_5PWHEQIWWPXL3BWY2LHE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hello together,

after all the new year's celebrations, I have today taken the time to create 
a small patch, based on Linus' idea, that will fix this problem in the 
kernel, _without_ pessimizing any code or breaking with earlier compilers.

2.4.0-prerelease is now running here for an hour compiled completely with 
gcc-snapshot-2.97-20001222, without any noticed problems (so far).

Perhaps this could be included in the kernel to enable people to look for the 
real caveats when compiling everything on the bleeding edge, or should we 
wait for the GCC maintainers' call - I haven't had any reaction on my bug 
report yet.

Along with it is a small fix for a typo in fs/umsdos/mangle.c, which was 
detected by GCC's new preprocessor (#elseif instead of #else).

Greetings and a happy new year to everyone,
Andreas

-- 
->>>----------------------- Andreas Franck --------<<<-
---<<<---- Andreas.Franck@post.rwth-aachen.de --->>>---
->>>---- Keep smiling! ----------------------------<<<-

--------------Boundary-00=_5PWHEQIWWPXL3BWY2LHE
Content-Type: text/english;
  name="newgcc.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="newgcc.patch"

--- linux-2.4.0-prerelease/include/asm-i386/semaphore.h.original	Mon Jan  1 16:25:31 2001
+++ linux-2.4.0-prerelease/include/asm-i386/semaphore.h	Mon Jan  1 17:38:40 2001
@@ -23,6 +23,12 @@
  *                     Optimized "0(ecx)" -> "(ecx)" (the assembler does not
  *                     do this). Changed calling sequences from push/jmp to
  *                     traditional call/ret.
+ * Modified 2001-01-01 Andreas Franck <afranck@gmx.de>
+ *		       Some hacks to ensure compatibility with recent
+ *		       GCC snapshots, to avoid stack corruption when compiling
+ *		       with -fomit-frame-pointer. It's not sure if this will
+ *		       be fixed in GCC, as our previous implementation was a
+ *		       bit dubious.
  *
  * If you would like to see an analysis of this implementation, please
  * ftp to gcom.com and download the file
@@ -113,14 +119,14 @@
 
 	__asm__ __volatile__(
 		"# atomic down operation\n\t"
-		LOCK "decl (%0)\n\t"     /* --sem->count */
+		LOCK "decl (%1)\n\t"     /* --sem->count */
 		"js 2f\n"
 		"1:\n"
 		".section .text.lock,\"ax\"\n"
 		"2:\tcall __down_failed\n\t"
 		"jmp 1b\n"
 		".previous"
-		:/* no outputs */
+		:"=m" (sem->count)
 		:"c" (sem)
 		:"memory");
 }
@@ -135,7 +141,7 @@
 
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
-		LOCK "decl (%1)\n\t"     /* --sem->count */
+		LOCK "decl (%2)\n\t"     /* --sem->count */
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
@@ -143,7 +149,7 @@
 		"2:\tcall __down_failed_interruptible\n\t"
 		"jmp 1b\n"
 		".previous"
-		:"=a" (result)
+		:"=a" (result), "=m" (sem->count)
 		:"c" (sem)
 		:"memory");
 	return result;
@@ -159,7 +165,7 @@
 
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
-		LOCK "decl (%1)\n\t"     /* --sem->count */
+		LOCK "decl (%2)\n\t"     /* --sem->count */
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
@@ -167,7 +173,7 @@
 		"2:\tcall __down_failed_trylock\n\t"
 		"jmp 1b\n"
 		".previous"
-		:"=a" (result)
+		:"=a" (result), "=m" (sem->count)
 		:"c" (sem)
 		:"memory");
 	return result;
@@ -186,14 +192,14 @@
 #endif
 	__asm__ __volatile__(
 		"# atomic up operation\n\t"
-		LOCK "incl (%0)\n\t"     /* ++sem->count */
+		LOCK "incl (%1)\n\t"     /* ++sem->count */
 		"jle 2f\n"
 		"1:\n"
 		".section .text.lock,\"ax\"\n"
 		"2:\tcall __up_wakeup\n\t"
 		"jmp 1b\n"
 		".previous"
-		:/* no outputs */
+		:"=m" (sem->count)
 		:"c" (sem)
 		:"memory");
 }
@@ -322,7 +328,8 @@
 		"2:\tcall __rwsem_wake\n\t"
 		"jmp 1b\n"
 		".previous"
-		::"a" (sem)
+		:"=m" (sem->count)
+		:"a" (sem)
 		:"memory"
 		);
 }
@@ -341,7 +348,8 @@
 		"2:\tcall __rwsem_wake\n\t"
 		"jmp 1b\n"
 		".previous"
-		::"a" (sem)
+		:"=m" (sem->count)
+		:"a" (sem)
 		:"memory"
 		);
 }
--- linux-2.4.0-prerelease/fs/umsdos/mangle.c.original	Mon Jan  1 18:15:42 2001
+++ linux-2.4.0-prerelease/fs/umsdos/mangle.c	Mon Jan  1 18:15:59 2001
@@ -435,7 +435,7 @@
 	"HELLO", 1, "hello",
 	"Hello.1", 1, "hello.1",
 	"Hello.c", 1, "hello.c",
-#elseif
+#else
 /*
  * I find the three examples below very unfortunate.  I propose to
  * convert them to lower case in a quick preliminary pass, then test

--------------Boundary-00=_5PWHEQIWWPXL3BWY2LHE--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
