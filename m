Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWADVAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWADVAd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWADVAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:00:05 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:53150 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751299AbWADU7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:59:55 -0500
Message-Id: <200601042152.k04Lq40R009252@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 7/9] UML - Capture printk output for mconsole sysrq
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Jan 2006 16:52:04 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pass sysrq output back to the mconsole client using the mechanism
introduced for stack output.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/mconsole_kern.c	2006-01-04 13:59:58.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/mconsole_kern.c	2006-01-04 14:00:45.000000000 -0500
@@ -463,24 +463,6 @@ void mconsole_remove(struct mc_request *
 	mconsole_reply(req, err_msg, err, 0);
 }
 
-#ifdef CONFIG_MAGIC_SYSRQ
-void mconsole_sysrq(struct mc_request *req)
-{
-	char *ptr = req->request.data;
-
-	ptr += strlen("sysrq");
-	while(isspace(*ptr)) ptr++;
-
-	mconsole_reply(req, "", 0, 0);
-	handle_sysrq(*ptr, &current->thread.regs, NULL);
-}
-#else
-void mconsole_sysrq(struct mc_request *req)
-{
-	mconsole_reply(req, "Sysrq not compiled in", 1, 0);
-}
-#endif
-
 static DEFINE_SPINLOCK(console_lock);
 static LIST_HEAD(clients);
 static char console_buf[MCONSOLE_MAX_DATA];
@@ -549,6 +531,36 @@ static void with_console(struct mc_reque
 	list_del(&entry.list);
 }
 
+#ifdef CONFIG_MAGIC_SYSRQ
+static void sysrq_proc(void *arg)
+{
+	char *op = arg;
+
+	handle_sysrq(*op, &current->thread.regs, NULL);
+}
+
+void mconsole_sysrq(struct mc_request *req)
+{
+	char *ptr = req->request.data;
+
+	ptr += strlen("sysrq");
+	while(isspace(*ptr)) ptr++;
+
+	/* With 'b', the system will shut down without a chance to reply,
+	 * so in this case, we reply first.
+	 */
+	if(*ptr == 'b')
+		mconsole_reply(req, "", 0, 0);
+
+	with_console(req, sysrq_proc, ptr);
+}
+#else
+void mconsole_sysrq(struct mc_request *req)
+{
+	mconsole_reply(req, "Sysrq not compiled in", 1, 0);
+}
+#endif
+
 static void stack_proc(void *arg)
 {
 	struct task_struct *from = current, *to = arg;

