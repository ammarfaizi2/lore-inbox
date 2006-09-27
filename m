Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030506AbWI0R7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbWI0R7N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 13:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030508AbWI0R7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 13:59:13 -0400
Received: from [198.99.130.12] ([198.99.130.12]:44979 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030506AbWI0R7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 13:59:11 -0400
Message-Id: <200609271757.k8RHvvtK005747@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 5/5] UML - Stack consumption reduction
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 27 Sep 2006 13:57:57 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some stack abuse in the sysrq t path.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
---

 arch/um/drivers/mconsole_kern.c |   15 ++++++++++-----
 arch/um/drivers/mconsole_user.c |    4 ++++
 2 files changed, 14 insertions(+), 5 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/mconsole_kern.c	2006-09-26 16:28:51.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/mconsole_kern.c	2006-09-26 16:39:37.000000000 -0400
@@ -598,6 +598,11 @@ out:
 	mconsole_reply(req, err_msg, err, 0);
 }
 
+struct mconsole_output {
+	struct list_head list;
+	struct mc_request *req;
+};
+
 static DEFINE_SPINLOCK(console_lock);
 static LIST_HEAD(clients);
 static char console_buf[MCONSOLE_MAX_DATA];
@@ -622,10 +627,10 @@ static void console_write(struct console
 			return;
 
 		list_for_each(ele, &clients){
-			struct mconsole_entry *entry;
+			struct mconsole_output *entry;
 
-			entry = list_entry(ele, struct mconsole_entry, list);
-			mconsole_reply_len(&entry->request, console_buf,
+			entry = list_entry(ele, struct mconsole_output, list);
+			mconsole_reply_len(entry->req, console_buf,
 					   console_index, 0, 1);
 		}
 
@@ -649,10 +654,10 @@ late_initcall(mc_add_console);
 static void with_console(struct mc_request *req, void (*proc)(void *),
 			 void *arg)
 {
-	struct mconsole_entry entry;
+	struct mconsole_output entry;
 	unsigned long flags;
 
-	entry.request = *req;
+	entry.req = req;
 	list_add(&entry.list, &clients);
 	spin_lock_irqsave(&console_lock, flags);
 
Index: linux-2.6.18-mm/arch/um/drivers/mconsole_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/mconsole_user.c	2006-09-26 16:28:51.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/mconsole_user.c	2006-09-26 16:39:37.000000000 -0400
@@ -131,6 +131,10 @@ int mconsole_get_request(int fd, struct 
 int mconsole_reply_len(struct mc_request *req, const char *str, int total,
 		       int err, int more)
 {
+	/* XXX This is a stack consumption problem.  It'd be nice to
+	 * make it global and serialize access to it, but there are a
+	 * ton of callers to this function.
+	 */
 	struct mconsole_reply reply;
 	int len, n;
 

