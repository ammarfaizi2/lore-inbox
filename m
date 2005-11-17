Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbVKQUSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbVKQUSK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 15:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbVKQUSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 15:18:09 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:58638 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S964904AbVKQUSG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 15:18:06 -0500
Message-Id: <200511172110.jAHLAPRZ010194@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/4] UML - Eliminate use of local in clone stub
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 Nov 2005 16:10:25 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ These four patches are 2.6.15 material, as they fix various crashes and 
a compile failure ]

We have a bug in the i386 stub_syscall6 which pushes ebp before the
system call and pops it afterwards.  Because we use syscall6 to
remap the stack, the old contents of the stack (and the former value
of ebp) are no longer available.  Some versions of gcc make from a
real local, accessed through ebp, despite my efforts to make it
obvious that references to from are really constants.
This patch attempts to make it even more obvious by eliminating from
and using a macro to access the stub's data explicitly with
constants.
My original thinking on this was to replace syscall6 with a
remap_stack interface which saved ebp someplace and restored it
afterwards.  The problem is that there are no registers to put it
in, except for esp.  That could work, since we can store a constant
in esp after the mmap because we just replaced the stack.  However,
this approach seems a tad cleaner.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/kernel/skas/clone.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/skas/clone.c	2005-11-17 14:58:30.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/skas/clone.c	2005-11-17 14:58:54.000000000 -0500
@@ -13,11 +13,13 @@
 /* This is in a separate file because it needs to be compiled with any
  * extraneous gcc flags (-pg, -fprofile-arcs, -ftest-coverage) disabled
  */
+
+#define STUB_DATA(field) (((struct stub_data *) UML_CONFIG_STUB_DATA)->field)
+
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_clone_handler(void)
 {
 	long err;
-	struct stub_data *from = (struct stub_data *) UML_CONFIG_STUB_DATA;
 
 	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
 			    UML_CONFIG_STUB_DATA + PAGE_SIZE / 2 -
@@ -30,15 +32,15 @@ stub_clone_handler(void)
 		goto out;
 
 	err = stub_syscall3(__NR_setitimer, ITIMER_VIRTUAL,
-			    (long) &from->timer, 0);
+			    (long) &STUB_DATA(timer), 0);
 	if(err)
 		goto out;
 
 	err = stub_syscall6(STUB_MMAP_NR, UML_CONFIG_STUB_DATA, PAGE_SIZE,
 			    PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
-			    from->fd, from->offset);
+			    STUB_DATA(fd), STUB_DATA(offset));
  out:
 	/* save current result. Parent: pid; child: retcode of mmap */
-	from->err = err;
+	STUB_DATA(err) = err;
 	trap_myself();
 }

