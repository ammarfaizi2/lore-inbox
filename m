Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751792AbWADU74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbWADU74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbWADU74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:59:56 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:49310 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750711AbWADU7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:59:55 -0500
Message-Id: <200601042151.k04LpuTO009231@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/9] UML - SIGWINCH handling cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Jan 2006 16:51:56 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Code cleanup - unregister_winch and winch_cleanup had some duplicate code.
This is now abstracted out into free_winch.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/line.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/line.c	2006-01-04 13:57:45.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/line.c	2006-01-04 13:58:17.000000000 -0500
@@ -774,55 +774,49 @@ void register_winch_irq(int fd, int tty_
 		printk("register_winch_irq - failed to register IRQ\n");
 }
 
+static void free_winch(struct winch *winch)
+{
+	list_del(&winch->list);
+
+	if(winch->pid != -1)
+		os_kill_process(winch->pid, 1);
+	if(winch->fd != -1)
+		os_close_file(winch->fd);
+
+	free_irq(WINCH_IRQ, winch);
+	kfree(winch);
+}
+
 static void unregister_winch(struct tty_struct *tty)
 {
 	struct list_head *ele;
-	struct winch *winch, *found = NULL;
+	struct winch *winch;
 
 	spin_lock(&winch_handler_lock);
+
 	list_for_each(ele, &winch_handlers){
 		winch = list_entry(ele, struct winch, list);
                 if(winch->tty == tty){
-                        found = winch;
-                        break;
+			free_winch(winch);
+			break;
                 }
         }
-        if(found == NULL)
-		goto err;
-
-	list_del(&winch->list);
-	spin_unlock(&winch_handler_lock);
-
-        if(winch->pid != -1)
-                os_kill_process(winch->pid, 1);
-
-        free_irq(WINCH_IRQ, winch);
-        kfree(winch);
-
-	return;
-err:
 	spin_unlock(&winch_handler_lock);
 }
 
-/* XXX: No lock as it's an exitcall... is this valid? Depending on cleanup
- * order... are we sure that nothing else is done on the list? */
 static void winch_cleanup(void)
 {
-	struct list_head *ele;
+	struct list_head *ele, *next;
 	struct winch *winch;
 
-	list_for_each(ele, &winch_handlers){
+	spin_lock(&winch_handler_lock);
+
+	list_for_each_safe(ele, next, &winch_handlers){
 		winch = list_entry(ele, struct winch, list);
-		if(winch->fd != -1){
-			/* Why is this different from the above free_irq(),
-			 * which deactivates SIGIO? This searches the FD
-			 * somewhere else and removes it from the list... */
-			deactivate_fd(winch->fd, WINCH_IRQ);
-			os_close_file(winch->fd);
-		}
-		if(winch->pid != -1)
-			os_kill_process(winch->pid, 1);
+		free_winch(winch);
 	}
+
+	spin_unlock(&winch_handler_lock);
 }
 __uml_exitcall(winch_cleanup);
 

