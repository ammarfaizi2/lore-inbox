Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUIWBQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUIWBQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 21:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267935AbUIWBQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 21:16:12 -0400
Received: from [12.177.129.25] ([12.177.129.25]:65219 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S266486AbUIWBQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 21:16:00 -0400
Message-Id: <200409230220.i8N2KhiF004260@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
Subject: [PATCH] UML - free wrapper fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Sep 2004 22:20:43 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__wrap_free is now careful about freeing to the same allocator that allocated
the buffer.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.9-rc2-mm1-orig/arch/um/kernel/main.c
===================================================================
--- linux-2.6.9-rc2-mm1-orig.orig/arch/um/kernel/main.c	2004-09-22 19:51:02.000000000 -0400
+++ linux-2.6.9-rc2-mm1-orig/arch/um/kernel/main.c	2004-09-22 20:07:02.000000000 -0400
@@ -220,14 +220,19 @@
 	 * If kmalloc is not yet possible, then the kernel memory regions
 	 * may not be set up yet, and the variables not initialized.  So,
 	 * free is called.
+	 *
+	 * CAN_KMALLOC is checked because it would be bad to free a buffer
+	 * with kmalloc/vmalloc after they have been turned off during
+	 * shutdown.
 	 */
-	if(CAN_KMALLOC()){
-		if((addr >= uml_physmem) && (addr <= high_physmem))
+
+	if((addr >= uml_physmem) && (addr < high_physmem)){
+		if(CAN_KMALLOC())
 			kfree(ptr);
-		else if((addr >= start_vm) && (addr <= end_vm))
+	}
+	else if((addr >= start_vm) && (addr < end_vm)){
+		if(CAN_KMALLOC())
 			vfree(ptr);
-		else
-			__real_free(ptr);
 	}
 	else __real_free(ptr);
 }

