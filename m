Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277293AbRJEBTA>; Thu, 4 Oct 2001 21:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277294AbRJEBSu>; Thu, 4 Oct 2001 21:18:50 -0400
Received: from dot.cygnus.com ([205.180.230.224]:772 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S277293AbRJEBSf>;
	Thu, 4 Oct 2001 21:18:35 -0400
Date: Thu, 4 Oct 2001 18:18:53 -0700
From: Richard Henderson <rth@dot.cygnus.com>
To: torvalds@transmeta.com, alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: alpha 2.4.11-pre3: fix bootp initrd
Message-ID: <20011004181853.A789@dot.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Jay Estabrook:

At some point the bootp image builder broke wrt initrd.

There is a definition of INITRD_SIZE in <asm/system.h>
that defines how the running kernel gets hold of this
size, which conflicts with the INITRD_SIZE used in the
bootstrap code.

So rename the variable in the bootstrap code.


r~



diff -rup 2.4.10-dist/arch/alpha/boot/Makefile 2.4.10/arch/alpha/boot/Makefile
--- 2.4.10-dist/arch/alpha/boot/Makefile	Mon Sep 25 12:36:09 2000
+++ 2.4.10/arch/alpha/boot/Makefile	Thu Oct  4 16:05:16 2001
@@ -59,7 +59,7 @@ ksize.h: vmlinux.nh dummy
 	echo "#define KERNEL_SIZE `ls -l vmlinux.nh | awk '{print $$5}'`" > $@T
 ifdef INITRD
 	[ -f $(INITRD) ] || exit 1
-	echo "#define INITRD_SIZE `ls -l $(INITRD) | awk '{print $$5}'`" >> $@T
+	echo "#define INITRD_IMAGE_SIZE `ls -l $(INITRD) | awk '{print $$5}'`" >> $@T
 endif
 	cmp -s $@T $@ || mv -f $@T $@
 	rm -f $@T
diff -rup 2.4.10-dist/arch/alpha/boot/bootp.c 2.4.10/arch/alpha/boot/bootp.c
--- 2.4.10-dist/arch/alpha/boot/bootp.c	Mon Jun 19 17:59:32 2000
+++ 2.4.10/arch/alpha/boot/bootp.c	Thu Oct  4 16:05:16 2001
@@ -147,7 +147,7 @@ start_kernel(void)
 	 */
 	static long nbytes;
 	static char envval[256] __attribute__((aligned(8)));
-#ifdef INITRD_SIZE
+#ifdef INITRD_IMAGE_SIZE
 	static unsigned long initrd_start;
 #endif
 
@@ -164,7 +164,7 @@ start_kernel(void)
 	}
 	pal_init();
 
-#ifdef INITRD_SIZE
+#ifdef INITRD_IMAGE_SIZE
 	/* The initrd must be page-aligned.  See below for the 
 	   cause of the magic number 5.  */
 	initrd_start = ((START_ADDR + 5*KERNEL_SIZE) | (PAGE_SIZE-1)) + 1;
@@ -192,17 +192,17 @@ start_kernel(void)
 	 *
 	 * Sigh...  */
 
-#ifdef INITRD_SIZE
-	load(initrd_start, KERNEL_ORIGIN+KERNEL_SIZE, INITRD_SIZE);
+#ifdef INITRD_IMAGE_SIZE
+	load(initrd_start, KERNEL_ORIGIN+KERNEL_SIZE, INITRD_IMAGE_SIZE);
 #endif
         load(START_ADDR+(4*KERNEL_SIZE), KERNEL_ORIGIN, KERNEL_SIZE);
         load(START_ADDR, START_ADDR+(4*KERNEL_SIZE), KERNEL_SIZE);
 
 	memset((char*)ZERO_PGE, 0, PAGE_SIZE);
 	strcpy((char*)ZERO_PGE, envval);
-#ifdef INITRD_SIZE
+#ifdef INITRD_IMAGE_SIZE
 	((long *)(ZERO_PGE+256))[0] = initrd_start;
-	((long *)(ZERO_PGE+256))[1] = INITRD_SIZE;
+	((long *)(ZERO_PGE+256))[1] = INITRD_IMAGE_SIZE;
 #endif
 
 	runkernel();
