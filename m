Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262548AbSJBS7z>; Wed, 2 Oct 2002 14:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262545AbSJBS7z>; Wed, 2 Oct 2002 14:59:55 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:10252
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262548AbSJBS7x>; Wed, 2 Oct 2002 14:59:53 -0400
Subject: [PATCH] sys_ioperm: might_sleep fix and optimization
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1033585517.24108.64.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 02 Oct 2002 15:05:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A might_sleep() check caught sys_ioperm() calling kmalloc() whilst
atomic.

The issue is we call get_cpu() prior to kmalloc().  The fix is simply to
move the get_cpu() further south, which has the added bonus of shrinking
the non-preemptibility region by a few instructions.  Credit to Nick
Piggin.

I also added some comments.

Patch is against current BK, please apply.

	Robert Love

diff -urN linux-2.5.40/arch/i386/kernel/ioport.c linux/arch/i386/kernel/ioport.c
--- linux-2.5.40/arch/i386/kernel/ioport.c	Tue Oct  1 03:06:59 2002
+++ linux/arch/i386/kernel/ioport.c	Wed Oct  2 15:01:53 2002
@@ -49,8 +49,11 @@
 	}
 }
 
-/*
- * this changes the io permissions bitmap in the current task.
+/**
+ * sys_ioperm - sets the I/O permission bits for the current process
+ * @from: starting port address
+ * @num: number of bytes from starting address
+ * @turn_on: value to change the permission bits to
  */
 asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int turn_on)
 {
@@ -63,16 +66,14 @@
 	if (turn_on && !capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
-	tss = init_tss + get_cpu();
-
 	/*
 	 * If it's the first ioperm() call in this thread's lifetime, set the
 	 * IO bitmap up. ioperm() is much less timing critical than clone(),
 	 * this is why we delay this operation until now:
 	 */
 	if (!t->ts_io_bitmap) {
-		unsigned long *bitmap;
-		bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
+		unsigned long *bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
+
 		if (!bitmap) {
 			ret = -ENOMEM;
 			goto out;
@@ -83,11 +84,14 @@
 		 */
 		memset(bitmap, 0xff, IO_BITMAP_BYTES);
 		t->ts_io_bitmap = bitmap;
+
 		/*
 		 * this activates it in the TSS
 		 */
+		tss = init_tss + get_cpu();
 		tss->bitmap = IO_BITMAP_OFFSET;
-	}
+	} else
+		tss = init_tss + get_cpu();
 
 	/*
 	 * do it in the per-thread copy and in the TSS ...
@@ -95,8 +99,9 @@
 	set_bitmap(t->ts_io_bitmap, from, num, !turn_on);
 	set_bitmap(tss->io_bitmap, from, num, !turn_on);
 
-out:
 	put_cpu();
+
+out:
 	return ret;
 }
 



