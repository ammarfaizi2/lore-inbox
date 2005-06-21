Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVFUBuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVFUBuF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 21:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVFUBnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 21:43:52 -0400
Received: from [151.97.230.9] ([151.97.230.9]:17094 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261856AbVFUBlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 21:41:40 -0400
Subject: [patch 1/1] uml: remove winch sem
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Tue, 21 Jun 2005 03:41:56 +0200
Message-Id: <20050621014156.6928E9919D@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Replace a semaphore (winch_handler_sem) used in atomic code with a spinlock,
and reduces as needed the amount of protected code to the bare minimum (for
instance no kmalloc calls are needed).

This fixes the last problems with spinlocking (in UP mode with DEBUG options);
the semaphore, taken inside spinlocks, caused a "spin_lock was already locked"
warning, without this patch.

Some doubts about existing code and changes are marked in the comments, so
keep this for a while into -mm.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/drivers/line.c |   37 ++++++++++++++++++-----------
 1 files changed, 24 insertions(+), 13 deletions(-)

diff -puN arch/um/drivers/line.c~uml-remove-winch-sem arch/um/drivers/line.c
--- linux-2.6.git/arch/um/drivers/line.c~uml-remove-winch-sem	2005-06-21 03:35:38.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/drivers/line.c	2005-06-21 03:37:19.000000000 +0200
@@ -648,11 +648,15 @@ struct tty_driver *line_register_devfs(s
 	return driver;
 }
 
+static spinlock_t winch_handler_lock;
+LIST_HEAD(winch_handlers);
+
 void lines_init(struct line *lines, int nlines)
 {
 	struct line *line;
 	int i;
 
+	spin_lock_init(&winch_handler_lock);
 	for(i = 0; i < nlines; i++){
 		line = &lines[i];
 		INIT_LIST_HEAD(&line->chan_list);
@@ -709,31 +713,30 @@ irqreturn_t winch_interrupt(int irq, voi
 	return IRQ_HANDLED;
 }
 
-DECLARE_MUTEX(winch_handler_sem);
-LIST_HEAD(winch_handlers);
-
 void register_winch_irq(int fd, int tty_fd, int pid, struct tty_struct *tty)
 {
 	struct winch *winch;
 
-	down(&winch_handler_sem);
 	winch = kmalloc(sizeof(*winch), GFP_KERNEL);
 	if (winch == NULL) {
 		printk("register_winch_irq - kmalloc failed\n");
-		goto out;
+		return;
 	}
+
 	*winch = ((struct winch) { .list  	= LIST_HEAD_INIT(winch->list),
 				   .fd  	= fd,
 				   .tty_fd 	= tty_fd,
 				   .pid  	= pid,
 				   .tty 	= tty });
+
+	spin_lock(&winch_handler_lock);
 	list_add(&winch->list, &winch_handlers);
+	spin_unlock(&winch_handler_lock);
+
 	if(um_request_irq(WINCH_IRQ, fd, IRQ_READ, winch_interrupt,
 			  SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM, 
 			  "winch", winch) < 0)
 		printk("register_winch_irq - failed to register IRQ\n");
- out:
-	up(&winch_handler_sem);
 }
 
 static void unregister_winch(struct tty_struct *tty)
@@ -741,7 +744,7 @@ static void unregister_winch(struct tty_
 	struct list_head *ele;
 	struct winch *winch, *found = NULL;
 
-	down(&winch_handler_sem);
+	spin_lock(&winch_handler_lock);
 	list_for_each(ele, &winch_handlers){
 		winch = list_entry(ele, struct winch, list);
                 if(winch->tty == tty){
@@ -749,20 +752,25 @@ static void unregister_winch(struct tty_
                         break;
                 }
         }
-
         if(found == NULL)
-                goto out;
+		goto err;
+
+	list_del(&winch->list);
+	spin_unlock(&winch_handler_lock);
 
         if(winch->pid != -1)
                 os_kill_process(winch->pid, 1);
 
         free_irq(WINCH_IRQ, winch);
-        list_del(&winch->list);
         kfree(winch);
- out:
-	up(&winch_handler_sem);
+
+	return;
+err:
+	spin_unlock(&winch_handler_lock);
 }
 
+/* XXX: No lock as it's an exitcall... is this valid? Depending on cleanup
+ * order... are we sure that nothing else is done on the list? */
 static void winch_cleanup(void)
 {
 	struct list_head *ele;
@@ -771,6 +779,9 @@ static void winch_cleanup(void)
 	list_for_each(ele, &winch_handlers){
 		winch = list_entry(ele, struct winch, list);
 		if(winch->fd != -1){
+			/* Why is this different from the above free_irq(),
+			 * which deactivates SIGIO? This searches the FD
+			 * somewhere else and removes it from the list... */
 			deactivate_fd(winch->fd, WINCH_IRQ);
 			os_close_file(winch->fd);
 		}
_
