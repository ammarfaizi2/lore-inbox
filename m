Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267607AbUIJR0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267607AbUIJR0m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 13:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267557AbUIJRZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 13:25:54 -0400
Received: from [12.177.129.25] ([12.177.129.25]:24515 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S267599AbUIJRYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 13:24:50 -0400
Message-Id: <200409101828.i8AISE0O003433@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - fix binary layout assumption
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 Sep 2004 14:28:14 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch calculates section boundaries differently so as to not get tripped
up by holes in the binary such as are introduced by exec-shield.

				Jeff

Index: 2.6.9-rc1/arch/um/kernel/tt/process_kern.c
===================================================================
--- 2.6.9-rc1.orig/arch/um/kernel/tt/process_kern.c	2004-09-10 12:59:10.000000000 -0400
+++ 2.6.9-rc1/arch/um/kernel/tt/process_kern.c	2004-09-10 13:07:19.000000000 -0400
@@ -423,7 +423,7 @@
 	protect_memory(start, end - start, 1, w, 1, 1);
 
 	start = (unsigned long) UML_ROUND_DOWN(&__bss_start);
-	end = (unsigned long) UML_ROUND_UP(&_end);
+	end = (unsigned long) UML_ROUND_UP(brk_start);
 	protect_memory(start, end - start, 1, w, 1, 1);
 
 	mprotect_kernel_vm(w);
Index: 2.6.9-rc1/arch/um/kernel/um_arch.c
===================================================================
--- 2.6.9-rc1.orig/arch/um/kernel/um_arch.c	2004-09-10 12:52:44.000000000 -0400
+++ 2.6.9-rc1/arch/um/kernel/um_arch.c	2004-09-10 13:07:44.000000000 -0400
@@ -306,7 +306,7 @@
 
 int linux_main(int argc, char **argv)
 {
-	unsigned long avail;
+	unsigned long avail, diff;
 	unsigned long virtmem_size, max_physmem;
 	unsigned int i, add;
 
@@ -324,6 +324,16 @@
 
 	brk_start = (unsigned long) sbrk(0);
 	CHOOSE_MODE_PROC(before_mem_tt, before_mem_skas, brk_start);
+	/* Increase physical memory size for exec-shield users
+	so they actually get what they asked for. This should
+	add zero for non-exec shield users */
+	
+	diff = UML_ROUND_UP(brk_start) - UML_ROUND_UP(&_end);
+	if(diff > 1024 * 1024){
+		printf("Adding %ld bytes to physical memory to account for "
+		       "exec-shield gap\n", diff);
+		physmem_size += UML_ROUND_UP(brk_start) - UML_ROUND_UP(&_end);
+	}
 
 	uml_physmem = uml_start;
 

