Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUF1JUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUF1JUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 05:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264908AbUF1JUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 05:20:41 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:50032 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264903AbUF1JU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 05:20:29 -0400
Date: Mon, 28 Jun 2004 10:58:12 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [patch-2.6.7] fix to microcode driver for the old CPUs.
Message-ID: <Pine.LNX.4.44.0406281050190.17182-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus,

Here is a patch against Linux 2.6.7 which fixes the sigmatch() macro to
work for the relatively old processors as well, which have 'pf == 0'
(processor flags as read from MSR 0x17), For example, the processors
failing without this patch are Pentium II 300 MHz (Klamath) with
family/model/stepping 6/3/4 and 6/3/3.

The patch also contains minor cosmetic changes (to make source code more 
uniform).

I'll send the same thing to Marcelo re-cut against 2.4.x shortly.

Kind regards
Tigran

--- arch/i386/kernel/microcode.c.0	2004-06-25 11:20:59.000000000 +0100
+++ arch/i386/kernel/microcode.c	2004-06-28 10:16:06.000000000 +0100
@@ -1,7 +1,7 @@
 /*
- *	Intel CPU Microcode Update driver for Linux
+ *	Intel CPU Microcode Update Driver for Linux
  *
- *	Copyright (C) 2000 Tigran Aivazian
+ *	Copyright (C) 2000-2004 Tigran Aivazian
  *
  *	This driver allows to upgrade microcode on Intel processors
  *	belonging to IA-32 family - PentiumPro, Pentium II, 
@@ -32,7 +32,7 @@
  *		Added misc device support (now uses both devfs and misc).
  *		Added MICROCODE_IOCFREE ioctl to clear memory.
  *	1.05	09 Jun 2000, Simon Trimmer <simon@veritas.com>
- *		Messages for error cases (non intel & no suitable microcode).
+ *		Messages for error cases (non Intel & no suitable microcode).
  *	1.06	03 Aug 2000, Tigran Aivazian <tigran@veritas.com>
  *		Removed ->release(). Removed exclusive open and status bitmap.
  *		Added microcode_rwsem to serialize read()/write()/ioctl().
@@ -64,6 +64,9 @@
  *		Removed ->read() method and obsoleted MICROCODE_IOCFREE ioctl
  *		because we no longer hold a copy of applied microcode 
  *		in kernel memory.
+ *	1.14	25 Jun 2004 Tigran Aivazian <tigran@veritas.com>
+ *		Fix sigmatch() macro to handle old CPUs with pf == 0.
+ *		Thanks to Stuart Swales for pointing out this bug.
  */
 
 
@@ -80,11 +83,11 @@
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 
-MODULE_DESCRIPTION("Intel CPU (IA-32) microcode update driver");
+MODULE_DESCRIPTION("Intel CPU (IA-32) Microcode Update Driver");
 MODULE_AUTHOR("Tigran Aivazian <tigran@veritas.com>");
 MODULE_LICENSE("GPL");
 
-#define MICROCODE_VERSION 	"1.13"
+#define MICROCODE_VERSION 	"1.14"
 #define MICRO_DEBUG 		0
 #if MICRO_DEBUG
 #define dprintk(x...) printk(KERN_INFO x)
@@ -104,7 +107,10 @@
 #define get_datasize(mc) \
 	(((microcode_t *)mc)->hdr.datasize ? \
 	 ((microcode_t *)mc)->hdr.datasize : DEFAULT_UCODE_DATASIZE)
-#define sigmatch(s1, s2, p1, p2) (((s1) == (s2)) && ((p1) & (p2)))
+
+#define sigmatch(s1, s2, p1, p2) \
+	(((s1) == (s2)) && (((p1) & (p2)) || ((p1) == (p2) == 0 )))
+
 #define exttable_size(et) ((et)->count * EXT_SIGNATURE_SIZE + EXT_HEADER_SIZE)
 
 /* serialize access to the physical write to MSR 0x79 */
@@ -363,7 +369,7 @@
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu_num;
 
 	if (uci->mc == NULL) {
-		printk(KERN_INFO "microcode: No suitable data for cpu %d\n", cpu_num);
+		printk(KERN_INFO "microcode: No suitable data for CPU%d\n", cpu_num);
 		return;
 	}
 
@@ -495,16 +501,14 @@
 	}
 
 	printk(KERN_INFO 
-		"IA-32 Microcode Update Driver: v%s <tigran@veritas.com>\n", 
-		MICROCODE_VERSION);
+		"IA-32 Microcode Update Driver: v" MICROCODE_VERSION " <tigran@veritas.com>\n");
 	return 0;
 }
 
 static void __exit microcode_exit (void)
 {
 	misc_deregister(&microcode_dev);
-	printk(KERN_INFO "IA-32 Microcode Update Driver v%s unregistered\n", 
-			MICROCODE_VERSION);
+	printk(KERN_INFO "IA-32 Microcode Update Driver v" MICROCODE_VERSION " unregistered\n");
 }
 
 module_init(microcode_init)


