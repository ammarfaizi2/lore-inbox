Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269147AbUING1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269147AbUING1u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 02:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269163AbUINGZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 02:25:50 -0400
Received: from [12.177.129.25] ([12.177.129.25]:30403 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S269165AbUINGYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 02:24:10 -0400
Message-Id: <200409140727.i8E7RqL7005653@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - Fix a signal race
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Sep 2004 03:27:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch saves and restores UML's idea of user mode across an interrupt.
Without this, an interrupt arriving at the wrong time can cause UML to lose
track of whether an interrupted handler is handing a userspace interrupt.

>From Ingo Molnar
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/kernel/skas/trap_user.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/skas/trap_user.c	2004-09-14 02:03:52.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/skas/trap_user.c	2004-09-14 02:04:00.000000000 -0400
@@ -19,8 +19,10 @@
 	struct skas_regs *r;
 	struct signal_info *info;
 	int save_errno = errno;
+	int save_user;
 
 	r = &TASK_REGS(get_current())->skas;
+	save_user = r->is_user;
 	r->is_user = 0;
 	r->fault_addr = SC_FAULT_ADDR(sc);
 	r->fault_type = SC_FAULT_TYPE(sc);
@@ -33,6 +35,7 @@
 	(*info->handler)(sig, (union uml_pt_regs *) r);
 
 	errno = save_errno;
+	r->is_user = save_user;
 }
 
 void user_signal(int sig, union uml_pt_regs *regs)

