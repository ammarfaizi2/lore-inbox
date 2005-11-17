Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbVKQUSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbVKQUSI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 15:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbVKQUSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 15:18:08 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:58382 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S964901AbVKQUSG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 15:18:06 -0500
Message-Id: <200511172110.jAHLATGR010209@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/4] UML - Eliminate use of libc PAGE_SIZE
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 Nov 2005 16:10:29 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On some systems, libc PAGE_SIZE calls getpagesize, which can't
happen from a stub.  So, I use UM_KERN_PAGE_SIZE, which is less
variable in its definition, instead.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/kernel/skas/clone.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/skas/clone.c	2005-11-17 14:58:54.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/skas/clone.c	2005-11-17 14:59:40.000000000 -0500
@@ -9,9 +9,13 @@
 #include "stub-data.h"
 #include "uml-config.h"
 #include "sysdep/stub.h"
+#include "kern_constants.h"
 
 /* This is in a separate file because it needs to be compiled with any
  * extraneous gcc flags (-pg, -fprofile-arcs, -ftest-coverage) disabled
+ *
+ * Use UM_KERN_PAGE_SIZE instead of PAGE_SIZE because that calls getpagesize
+ * on some systems.
  */
 
 #define STUB_DATA(field) (((struct stub_data *) UML_CONFIG_STUB_DATA)->field)
@@ -22,7 +26,7 @@ stub_clone_handler(void)
 	long err;
 
 	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
-			    UML_CONFIG_STUB_DATA + PAGE_SIZE / 2 -
+			    UML_CONFIG_STUB_DATA + UM_KERN_PAGE_SIZE / 2 -
 			    sizeof(void *));
 	if(err != 0)
 		goto out;
@@ -36,9 +40,10 @@ stub_clone_handler(void)
 	if(err)
 		goto out;
 
-	err = stub_syscall6(STUB_MMAP_NR, UML_CONFIG_STUB_DATA, PAGE_SIZE,
-			    PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
-			    STUB_DATA(fd), STUB_DATA(offset));
+	err = stub_syscall6(STUB_MMAP_NR, UML_CONFIG_STUB_DATA, 
+			    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE, 
+			    MAP_FIXED | MAP_SHARED, STUB_DATA(fd), 
+			    STUB_DATA(offset));
  out:
 	/* save current result. Parent: pid; child: retcode of mmap */
 	STUB_DATA(err) = err;

