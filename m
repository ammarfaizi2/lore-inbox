Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268407AbUIQEQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268407AbUIQEQE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 00:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268331AbUIQENa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 00:13:30 -0400
Received: from [12.177.129.25] ([12.177.129.25]:5316 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268337AbUIQENC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 00:13:02 -0400
Message-Id: <200409170517.i8H5HV2J005392@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - mconsole fixes and cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Sep 2004 01:17:31 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch
	makes a couple of functions static
	tidies code a bit
	sends a response on shutdown before the shutdown happens

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/drivers/mconsole_kern.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/drivers/mconsole_kern.c	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/drivers/mconsole_kern.c	2004-09-16 23:29:40.000000000 -0400
@@ -51,27 +51,26 @@
 
 LIST_HEAD(mc_requests);
 
-void mc_work_proc(void *unused)
+static void mc_work_proc(void *unused)
 {
 	struct mconsole_entry *req;
 	unsigned long flags;
-	int done;
 
-	do {
+	while(!list_empty(&mc_requests)){
 		local_save_flags(flags);
 		req = list_entry(mc_requests.next, struct mconsole_entry, 
 				 list);
 		list_del(&req->list);
-		done = list_empty(&mc_requests);
 		local_irq_restore(flags);
 		req->request.cmd->handler(&req->request);
 		kfree(req);
-	} while(!done);
+	}
 }
 
 DECLARE_WORK(mconsole_work, mc_work_proc, NULL);
 
-irqreturn_t mconsole_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t mconsole_interrupt(int irq, void *dev_id, 
+				      struct pt_regs *regs)
 {
 	int fd;
 	struct mconsole_entry *new;
@@ -91,7 +90,8 @@
 			}
 		}
 	}
-	if(!list_empty(&mc_requests)) schedule_work(&mconsole_work);
+	if(!list_empty(&mc_requests)) 
+		schedule_work(&mconsole_work);
 	reactivate_fd(fd, MCONSOLE_IRQ);
 	return(IRQ_HANDLED);
 }
@@ -374,8 +374,8 @@
 	ptr += strlen("sysrq");
 	while(isspace(*ptr)) ptr++;
 
-	handle_sysrq(*ptr, &current->thread.regs, NULL);
 	mconsole_reply(req, "", 0, 0);
+	handle_sysrq(*ptr, &current->thread.regs, NULL);
 }
 #else
 void mconsole_sysrq(struct mc_request *req)

