Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVFTTIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVFTTIh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVFTTHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:07:32 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:25866 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261481AbVFTS4t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:56:49 -0400
Message-Id: <200506201851.j5KIpHig008488@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/8] UML - Fix timer initialization
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 20 Jun 2005 14:51:17 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In skas mode, the call to uml_idle_timer permanently shut off the
virtual timer, resulting in no timer ticks to anything but the idle
thread.  This is likely the cause of the soft lockups that are seen 
sporadically in recent UMLs.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/process_kern.c	2005-06-20 12:02:19.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/process_kern.c	2005-06-20 12:06:08.000000000 -0400
@@ -169,7 +169,7 @@ int current_pid(void)
 
 void default_idle(void)
 {
-	uml_idle_timer();
+	CHOOSE_MODE(uml_idle_timer(), (void) 0);
 
 	atomic_inc(&init_mm.mm_count);
 	current->mm = &init_mm;
Index: linux-2.6.12/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/process_kern.c	2005-06-20 12:02:32.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/process_kern.c	2005-06-20 12:06:08.000000000 -0400
@@ -180,7 +180,6 @@ int start_uml_skas(void)
 	start_userspace(0);
 
 	init_new_thread_signals(1);
-	uml_idle_timer();
 
 	init_task.thread.request.u.thread.proc = start_kernel_proc;
 	init_task.thread.request.u.thread.arg = NULL;

