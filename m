Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVDRLVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVDRLVn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 07:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVDRLVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 07:21:43 -0400
Received: from mail.dif.dk ([193.138.115.101]:20702 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262037AbVDRLVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 07:21:17 -0400
Date: Mon, 18 Apr 2005 13:24:13 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] misc verify_area cleanups - last one, I promise ;)
Message-ID: <Pine.LNX.4.62.0504181316520.2522@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There were still a few comments left refering to verify_area, and two 
functions, verify_area_skas & verify_area_tt that just wrap corresponding 
access_ok_skas & access_ok_tt functions, just like verify_area does for 
access_ok - deprecate those.
There was also a few places that still used verify_area in commented-out 
code, fix those up to use access_ok.

Note: I made this one on against a plain 2.6.12-rc2-mm3, so for the files 
that this patch changes it duplicates the bits in the 'rename 
TEST_VERIFY_AREA to TEST_ACCESS_OK' patch.

After applying this one there should not be anything left but finally 
removing verify_area completely, which will happen after a kernel release 
or two.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc2-mm3-orig/./arch/i386/kernel/vm86.c	2005-04-11 21:20:38.000000000 +0200
+++ linux-2.6.12-rc2-mm3/./arch/i386/kernel/vm86.c	2005-04-17 23:36:20.000000000 +0200
@@ -222,7 +222,7 @@
 			goto out;
 		case VM86_PLUS_INSTALL_CHECK:
 			/* NOTE: on old vm86 stuff this will return the error
-			   from verify_area(), because the subfunction is
+			   from access_ok(), because the subfunction is
 			   interpreted as (invalid) address to vm86_struct.
 			   So the installation check works.
 			 */
--- linux-2.6.12-rc2-mm3-orig/./arch/um/kernel/skas/include/uaccess-skas.h	2005-03-02 08:38:07.000000000 +0100
+++ linux-2.6.12-rc2-mm3/./arch/um/kernel/skas/include/uaccess-skas.h	2005-04-18 13:00:46.000000000 +0200
@@ -18,7 +18,7 @@
 	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END) && \
 	  ((unsigned long) (addr) + (size) >= (unsigned long)(addr))))
 
-static inline int verify_area_skas(int type, const void * addr,
+static inline int __deprecated verify_area_skas(int type, const void * addr,
 				   unsigned long size)
 {
 	return(access_ok_skas(type, addr, size) ? 0 : -EFAULT);
--- linux-2.6.12-rc2-mm3-orig/./arch/um/kernel/tt/include/uaccess-tt.h	2005-03-02 08:38:12.000000000 +0100
+++ linux-2.6.12-rc2-mm3/./arch/um/kernel/tt/include/uaccess-tt.h	2005-04-18 13:01:01.000000000 +0200
@@ -33,7 +33,7 @@
          (((unsigned long) (addr) <= ((unsigned long) (addr) + (size))) && \
           (under_task_size(addr, size) || is_stack(addr, size))))
 
-static inline int verify_area_tt(int type, const void * addr,
+static inline int __deprecated verify_area_tt(int type, const void * addr,
 				 unsigned long size)
 {
 	return(access_ok_tt(type, addr, size) ? 0 : -EFAULT);
--- linux-2.6.12-rc2-mm3-orig/./drivers/char/dtlk.c	2005-03-02 08:38:07.000000000 +0100
+++ linux-2.6.12-rc2-mm3/./drivers/char/dtlk.c	2005-04-18 13:01:13.000000000 +0200
@@ -52,7 +52,7 @@
 #define KERNEL
 #include <linux/types.h>
 #include <linux/fs.h>
-#include <linux/mm.h>		/* for verify_area */
+#include <linux/mm.h>
 #include <linux/errno.h>	/* for -EBUSY */
 #include <linux/ioport.h>	/* for request_region */
 #include <linux/delay.h>	/* for loops_per_jiffy */
--- linux-2.6.12-rc2-mm3-orig/./drivers/char/specialix.c	2005-04-05 21:21:23.000000000 +0200
+++ linux-2.6.12-rc2-mm3/./drivers/char/specialix.c	2005-04-18 13:03:22.000000000 +0200
@@ -1987,10 +1987,9 @@
 
 	func_enter();
 	/*
-	error = verify_area(VERIFY_READ, (void *) newinfo, sizeof(tmp));
-	if (error) {
+	if (!access_ok(VERIFY_READ, (void *) newinfo, sizeof(tmp))) {
 		func_exit();
-		return error;
+		return -EFAULT;
 	}
 	*/
 	if (copy_from_user(&tmp, newinfo, sizeof(tmp))) {
@@ -2046,14 +2045,12 @@
 {
 	struct serial_struct tmp;
 	struct specialix_board *bp = port_Board(port);
-	//	int error;
 	
 	func_enter();
 
 	/*
-	error = verify_area(VERIFY_WRITE, (void *) retinfo, sizeof(tmp));
-	if (error)
-		return error;
+	if (!access_ok(VERIFY_WRITE, (void *) retinfo, sizeof(tmp)))
+		return -EFAULT;
 	*/
 
 	memset(&tmp, 0, sizeof(tmp));
--- linux-2.6.12-rc2-mm3-orig/./include/asm-frv/pgtable.h	2005-04-11 21:20:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3/./include/asm-frv/pgtable.h	2005-04-18 13:15:02.000000000 +0200
@@ -349,9 +349,9 @@
 
 /*
  * Define this to warn about kernel memory accesses that are
- * done without a 'verify_area(VERIFY_WRITE,..)'
+ * done without a 'access_ok(VERIFY_WRITE,..)'
  */
-#undef TEST_VERIFY_AREA
+#undef TEST_ACCESS_OK
 
 #define pte_present(x)	(pte_val(x) & _PAGE_PRESENT)
 #define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
--- linux-2.6.12-rc2-mm3-orig/./include/asm-i386/checksum.h	2005-03-02 08:38:38.000000000 +0100
+++ linux-2.6.12-rc2-mm3/./include/asm-i386/checksum.h	2005-04-18 13:04:02.000000000 +0200
@@ -33,7 +33,7 @@
  *	passed in an incorrect kernel address to one of these functions.
  *
  *	If you use these functions directly please don't forget the
- *	verify_area().
+ *	access_ok().
  */
 static __inline__
 unsigned int csum_partial_copy_nocheck (const unsigned char *src, unsigned char *dst,
--- linux-2.6.12-rc2-mm3-orig/./include/asm-i386/pgtable.h	2005-04-11 21:20:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3/./include/asm-i386/pgtable.h	2005-04-18 13:15:02.000000000 +0200
@@ -193,9 +193,9 @@
 /*
  * Define this if things work differently on an i386 and an i486:
  * it will (on an i486) warn about kernel memory accesses that are
- * done without a 'verify_area(VERIFY_WRITE,..)'
+ * done without a 'access_ok(VERIFY_WRITE,..)'
  */
-#undef TEST_VERIFY_AREA
+#undef TEST_ACCESS_OK
 
 /* The boot page tables (all created as a single array) */
 extern unsigned long pg0[];
--- linux-2.6.12-rc2-mm3-orig/./include/asm-parisc/uaccess.h	2005-04-05 21:21:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3/./include/asm-parisc/uaccess.h	2005-04-18 13:04:45.000000000 +0200
@@ -24,7 +24,7 @@
 
 /*
  * Note that since kernel addresses are in a separate address space on
- * parisc, we don't need to do anything for access_ok() or verify_area().
+ * parisc, we don't need to do anything for access_ok().
  * We just let the page fault handler do the right thing. This also means
  * that put_user is the same as __put_user, etc.
  */
--- linux-2.6.12-rc2-mm3-orig/./include/asm-sh/checksum.h	2005-03-02 08:37:49.000000000 +0100
+++ linux-2.6.12-rc2-mm3/./include/asm-sh/checksum.h	2005-04-18 13:04:56.000000000 +0200
@@ -42,7 +42,7 @@
  *	passed in an incorrect kernel address to one of these functions. 
  *	
  *	If you use these functions directly please don't forget the 
- *	verify_area().
+ *	access_ok().
  */
 static __inline__
 unsigned int csum_partial_copy_nocheck (const unsigned char *src, unsigned char *dst,
--- linux-2.6.12-rc2-mm3-orig/./include/asm-sh64/checksum.h	2005-03-02 08:37:54.000000000 +0100
+++ linux-2.6.12-rc2-mm3/./include/asm-sh64/checksum.h	2005-04-18 13:05:06.000000000 +0200
@@ -34,7 +34,7 @@
  *	passed in an incorrect kernel address to one of these functions.
  *
  *	If you use these functions directly please don't forget the
- *	verify_area().
+ *	access_ok().
  */
 
 
--- linux-2.6.12-rc2-mm3-orig/./include/asm-sparc/uaccess.h	2005-04-05 21:21:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3/./include/asm-sparc/uaccess.h	2005-04-18 13:05:26.000000000 +0200
@@ -18,7 +18,7 @@
 
 #ifndef __ASSEMBLY__
 
-/* Sparc is not segmented, however we need to be able to fool verify_area()
+/* Sparc is not segmented, however we need to be able to fool access_ok()
  * when doing system calls from kernel mode legitimately.
  *
  * "For historical reasons, these macros are grossly misnamed." -Linus
--- linux-2.6.12-rc2-mm3-orig/./net/8021q/vlanproc.c	2005-03-02 08:37:54.000000000 +0100
+++ linux-2.6.12-rc2-mm3/./net/8021q/vlanproc.c	2005-04-18 13:05:41.000000000 +0200
@@ -23,7 +23,7 @@
 #include <linux/errno.h>	/* return codes */
 #include <linux/kernel.h>
 #include <linux/slab.h>		/* kmalloc(), kfree() */
-#include <linux/mm.h>		/* verify_area(), etc. */
+#include <linux/mm.h>
 #include <linux/string.h>	/* inline mem*, str* functions */
 #include <linux/init.h>		/* __initfunc et al. */
 #include <asm/byteorder.h>	/* htons(), etc. */
--- linux-2.6.12-rc2-mm3-orig/./net/atm/common.c	2005-04-05 21:21:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3/./net/atm/common.c	2005-04-18 13:05:57.000000000 +0200
@@ -12,7 +12,7 @@
 #include <linux/socket.h>	/* SOL_SOCKET */
 #include <linux/errno.h>	/* error codes */
 #include <linux/capability.h>
-#include <linux/mm.h>		/* verify_area */
+#include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/time.h>		/* struct timeval */
 #include <linux/skbuff.h>
@@ -540,7 +540,7 @@
 		error = -EMSGSIZE;
 		goto out;
 	}
-	/* verify_area is done by net/socket.c */
+
 	eff = (size+3) & ~3; /* align to word boundary */
 	prepare_to_wait(sk->sk_sleep, &wait, TASK_INTERRUPTIBLE);
 	error = 0;
--- linux-2.6.12-rc2-mm3-orig/./net/core/iovec.c	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.12-rc2-mm3/./net/core/iovec.c	2005-04-18 13:06:15.000000000 +0200
@@ -33,7 +33,7 @@
  *	Verify iovec. The caller must ensure that the iovec is big enough
  *	to hold the message iovec.
  *
- *	Save time not doing verify_area. copy_*_user will make this work
+ *	Save time not doing access_ok. copy_*_user will make this work
  *	in any case.
  */
 
--- linux-2.6.12-rc2-mm3-orig/./net/wanrouter/wanmain.c	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.12-rc2-mm3/./net/wanrouter/wanmain.c	2005-04-18 13:06:48.000000000 +0200
@@ -48,8 +48,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>	/* support for loadable modules */
-#include <linux/slab.h>	/* kmalloc(), kfree() */
-#include <linux/mm.h>		/* verify_area(), etc. */
+#include <linux/slab.h>		/* kmalloc(), kfree() */
+#include <linux/mm.h>
 #include <linux/string.h>	/* inline mem*, str* functions */
 
 #include <asm/byteorder.h>	/* htons(), etc. */


