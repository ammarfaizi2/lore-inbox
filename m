Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261342AbRFATQt>; Fri, 1 Jun 2001 15:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbRFATQj>; Fri, 1 Jun 2001 15:16:39 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:54071 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261342AbRFATQa>; Fri, 1 Jun 2001 15:16:30 -0400
Date: Fri, 1 Jun 2001 15:16:15 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200106011916.f51JGF616750@devserv.devel.redhat.com>
To: kaos@ocs.com.au, Matt Chapman <matthewc@cse.unsw.edu.au>
Cc: Dag Brattli <dag@brattli.net>, linux-kernel@vger.kernel.org,
        linux-irda@pasta.cs.uit.no
Subject: Re: [PATCH] for Linux IRDA initialisation bug 2.4.5
In-Reply-To: <mailman.991404121.32135.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.991404121.32135.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >I've found that if you compile IRDA into the kernel, irda_proto_init
> >gets called twice - once at do_initcalls time, and once explicitly
> >in do_basic_setup - eventually resulting in a hang (as
> >register_netdevice_notifier gets called twice with the same struct,
> >and it's list becomes circular).
> 
> The suggested patch has one non-obvious side effect which somebody in
> irda needs to verify is OK.  Previously irda_proto_init() and
> irda_device_init() were called after every other driver had
> initialized.  Now irda_proto_init() is called based on the object order
> in the top level Makefile, so irda is initialized before i2c,
> telephony, acpi and mddev.  Is this a valid initialization order?  If
> not, move
> 
>   DRIVERS-$(CONFIG_IRDA) += drivers/net/irda/irda.o
> 
> to the end of the drivers list and document why it needs to be there.

Keith, you mistake Matt's fix for an "obvious" fix that turns
old style inits into new ones. Matt's fix does not change
initialization order and certainly cannot be corrected by
moving object files about.

I tried to change the thing to new style init and it did not
quite work. The original problem was fixed but now the system
hangs when it tries to initialize IP loopback. Perhaps irda0
gets in the way.

The suggestion about the link order is very relevant for the
attached patch. I need Dag to pick it where I left it.

-- Pete

diff -ur -X dontdiff linux-2.4.5/net/irda/ircomm/ircomm_core.c linux-2.4.5-tr5/net/irda/ircomm/ircomm_core.c
--- linux-2.4.5/net/irda/ircomm/ircomm_core.c	Fri Mar  2 11:12:12 2001
+++ linux-2.4.5-tr5/net/irda/ircomm/ircomm_core.c	Fri May 25 23:26:12 2001@@ -76,8 +76,7 @@
 	return 0;
 }
 
-#ifdef MODULE
-void ircomm_cleanup(void)
+void __exit ircomm_cleanup(void)
 {
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
 
@@ -87,7 +86,6 @@
 	remove_proc_entry("ircomm", proc_irda);
 #endif /* CONFIG_PROC_FS */
 }
-#endif /* MODULE */
 
 /*
  * Function ircomm_open (client_notify)
@@ -511,18 +509,8 @@
 }
 #endif /* CONFIG_PROC_FS */
 
-#ifdef MODULE
 MODULE_AUTHOR("Dag Brattli <dag@brattli.net>");
 MODULE_DESCRIPTION("IrCOMM protocol");
 
-int init_module(void) 
-{
-	return ircomm_init();
-}
-	
-void cleanup_module(void)
-{
-	ircomm_cleanup();
-}
-#endif /* MODULE */
-
+module_init(ircomm_init);
+module_exit(ircomm_cleanup);
diff -ur -X dontdiff linux-2.4.5/net/irda/ircomm/ircomm_tty.c linux-2.4.5-tr5/net/irda/ircomm/ircomm_tty.c
--- linux-2.4.5/net/irda/ircomm/ircomm_tty.c	Fri Mar  2 11:12:12 2001
+++ linux-2.4.5-tr5/net/irda/ircomm/ircomm_tty.c	Fri May 25 23:27:11 2001@@ -89,7 +89,7 @@
  *    Init IrCOMM TTY layer/driver
  *
  */
-int __init ircomm_tty_init(void)
+static int __init ircomm_tty_init(void)
 {	
 	ircomm_tty = hashbin_new(HB_LOCAL); 
 	if (ircomm_tty == NULL) {
@@ -142,8 +142,7 @@
 	return 0;
 }
 
-#ifdef MODULE
-static void __ircomm_tty_cleanup(struct ircomm_tty_cb *self)
+static void __exit __ircomm_tty_cleanup(struct ircomm_tty_cb *self)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "()\n");
 
@@ -162,7 +161,7 @@
  *    Remove IrCOMM TTY layer/driver
  *
  */
-void ircomm_tty_cleanup(void)
+static void __exit ircomm_tty_cleanup(void)
 {
 	int ret;
 
@@ -176,7 +175,6 @@
 
 	hashbin_delete(ircomm_tty, (FREE_FUNC) __ircomm_tty_cleanup);
 }
-#endif /* MODULE */
 
 /*
  * Function ircomm_startup (self)
@@ -1359,22 +1357,8 @@
 }
 #endif /* CONFIG_PROC_FS */
 
-#ifdef MODULE
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("IrCOMM serial TTY driver");
 
-int init_module(void) 
-{
-	return ircomm_tty_init();
-}
-
-void cleanup_module(void)
-{
-	ircomm_tty_cleanup();
-}
-
-#endif /* MODULE */
-
-
-
-
+module_init(ircomm_tty_init);
+module_exit(ircomm_tty_cleanup);
diff -ur -X dontdiff linux-2.4.5/net/irda/irsyms.c linux-2.4.5-tr5/net/irda/irsyms.c
--- linux-2.4.5/net/irda/irsyms.c	Sun Nov 12 20:43:11 2000
+++ linux-2.4.5-tr5/net/irda/irsyms.c	Fri May 25 23:28:47 2001
@@ -61,8 +61,6 @@
 extern int irlan_init(void);
 extern int irlan_client_init(void);
 extern int irlan_server_init(void);
-extern int ircomm_init(void);
-extern int ircomm_tty_init(void);
 extern int irlpt_client_init(void);
 extern int irlpt_server_init(void);
 
@@ -203,10 +201,6 @@
 	 */
 #ifdef CONFIG_IRLAN
 	irlan_init();
-#endif
-#ifdef CONFIG_IRCOMM
-	ircomm_init();
-	ircomm_tty_init();
 #endif
 
 #ifdef CONFIG_IRDA_COMPRESSION

