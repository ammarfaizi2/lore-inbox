Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbWACXqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWACXqn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWACXqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:46:15 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:41109 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S965132AbWACXpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:45:54 -0500
Message-Id: <200601040037.k040bfiE012555@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 7/12] UML - Add static initializations and declarations
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Jan 2006 19:37:41 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some structure fields were being dynamically initialized when they
could be initialized at compile-time instead.
This also makes some declarations static (in the C sense).

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/include/line.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/line.h	2006-01-03 17:29:31.000000000 -0500
+++ linux-2.6.15/arch/um/include/line.h	2006-01-03 17:29:31.000000000 -0500
@@ -58,8 +58,8 @@ struct line {
 #define LINE_INIT(str, d) \
 	{ init_str :	str, \
 	  init_pri :	INIT_STATIC, \
-	  chan_list : 	{ }, \
 	  valid :	1, \
+	  lock :	SPIN_LOCK_UNLOCKED, \
 	  buffer :	NULL, \
 	  head :	NULL, \
 	  tail :	NULL, \
Index: linux-2.6.15/arch/um/drivers/line.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/line.c	2006-01-03 17:29:31.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/line.c	2006-01-03 17:29:31.000000000 -0500
@@ -668,19 +668,18 @@ struct tty_driver *line_register_devfs(s
 	return driver;
 }
 
-static spinlock_t winch_handler_lock;
-LIST_HEAD(winch_handlers);
+static DEFINE_SPINLOCK(winch_handler_lock);
+static LIST_HEAD(winch_handlers);
 
 void lines_init(struct line *lines, int nlines)
 {
 	struct line *line;
 	int i;
 
-	spin_lock_init(&winch_handler_lock);
 	for(i = 0; i < nlines; i++){
 		line = &lines[i];
 		INIT_LIST_HEAD(&line->chan_list);
-		spin_lock_init(&line->lock);
+
 		if(line->init_str == NULL)
 			continue;
 
Index: linux-2.6.15/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/mconsole_kern.c	2006-01-03 17:28:28.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/mconsole_kern.c	2006-01-03 17:30:12.000000000 -0500
@@ -51,7 +51,7 @@ static struct notifier_block reboot_noti
  * itself and it can only happen on CPU 0.
  */
 
-LIST_HEAD(mc_requests);
+static LIST_HEAD(mc_requests);
 
 static void mc_work_proc(void *unused)
 {
@@ -69,7 +69,7 @@ static void mc_work_proc(void *unused)
 	}
 }
 
-DECLARE_WORK(mconsole_work, mc_work_proc, NULL);
+static DECLARE_WORK(mconsole_work, mc_work_proc, NULL);
 
 static irqreturn_t mconsole_interrupt(int irq, void *dev_id,
 				      struct pt_regs *regs)
@@ -535,7 +535,7 @@ void mconsole_stack(struct mc_request *r
  */
 static char *notify_socket = NULL;
 
-int mconsole_init(void)
+static int mconsole_init(void)
 {
 	/* long to avoid size mismatch warnings from gcc */
 	long sock;
Index: linux-2.6.15/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/net_kern.c	2006-01-03 17:27:59.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/net_kern.c	2006-01-03 17:29:31.000000000 -0500
@@ -34,7 +34,7 @@
 #define DRIVER_NAME "uml-netdev"
 
 static DEFINE_SPINLOCK(opened_lock);
-LIST_HEAD(opened);
+static LIST_HEAD(opened);
 
 static int uml_net_rx(struct net_device *dev)
 {
@@ -266,7 +266,7 @@ void uml_net_user_timer_expire(unsigned 
 }
 
 static DEFINE_SPINLOCK(devices_lock);
-static struct list_head devices = LIST_HEAD_INIT(devices);
+static LIST_HEAD(devices);
 
 static struct platform_driver uml_net_driver = {
 	.driver = {

