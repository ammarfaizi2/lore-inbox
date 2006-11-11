Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947309AbWKKVsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947309AbWKKVsb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 16:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947311AbWKKVsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 16:48:31 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:2986 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1947309AbWKKVsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 16:48:30 -0500
Message-id: <29002300937186171@wsc.cz>
In-reply-to: <196416110522272@wsc.cz>
Subject: [PATCH 2/5] Char: istallion, move init and exit code
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat, 11 Nov 2006 22:48:41 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

istallion, move init and exit code

Let's have these function at the end of the driver and expand stli_init
directly into module_init fucntion, since there is nothing other to have
there.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit d804883791d787b9c0bc0b79ccec78d0d20d850d
tree 8b3975ffcc507aeab7081767816ce66f191ce653
parent 2f1c6f8998c724f6b323dfc913a650f26cc02efa
author Jiri Slaby <jirislaby@gmail.com> Sat, 11 Nov 2006 01:41:37 +0100
committer Jiri Slaby <jirislaby@gmail.com> Sat, 11 Nov 2006 22:23:34 +0100

 drivers/char/istallion.c |  113 +++++++++++++++++++++-------------------------
 1 files changed, 52 insertions(+), 61 deletions(-)

diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index e835258..2de677f 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -595,7 +595,6 @@ #define	MINOR2PORT(min)		((min) & 0x3f)
  */
 
 static int	stli_parsebrd(struct stlconf *confp, char **argp);
-static int	stli_init(void);
 static int	stli_open(struct tty_struct *tty, struct file *filp);
 static void	stli_close(struct tty_struct *tty, struct file *filp);
 static int	stli_write(struct tty_struct *tty, const unsigned char *buf, int count);
@@ -744,65 +743,6 @@ static void stli_cleanup_ports(struct st
 	}
 }
 
-/*
- *	Loadable module initialization stuff.
- */
-
-static int __init istallion_module_init(void)
-{
-	stli_init();
-	return 0;
-}
-
-/*****************************************************************************/
-
-static void __exit istallion_module_exit(void)
-{
-	struct stlibrd	*brdp;
-	unsigned int j;
-	int		i;
-
-	printk(KERN_INFO "Unloading %s: version %s\n", stli_drvtitle,
-		stli_drvversion);
-
-	pci_unregister_driver(&stli_pcidriver);
-	/*
-	 *	Free up all allocated resources used by the ports. This includes
-	 *	memory and interrupts.
-	 */
-	if (stli_timeron) {
-		stli_timeron = 0;
-		del_timer_sync(&stli_timerlist);
-	}
-
-	i = tty_unregister_driver(stli_serial);
-	put_tty_driver(stli_serial);
-	for (j = 0; j < 4; j++)
-		class_device_destroy(istallion_class, MKDEV(STL_SIOMEMMAJOR, j));
-	class_destroy(istallion_class);
-	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
-		printk("STALLION: failed to un-register serial memory device, "
-			"errno=%d\n", -i);
-
-	kfree(stli_txcookbuf);
-
-	for (j = 0; (j < stli_nrbrds); j++) {
-		if ((brdp = stli_brds[j]) == NULL || (brdp->state & BST_PROBED))
-			continue;
-
-		stli_cleanup_ports(brdp);
-
-		iounmap(brdp->membase);
-		if (brdp->iosize > 0)
-			release_region(brdp->iobase, brdp->iosize);
-		kfree(brdp);
-		stli_brds[j] = NULL;
-	}
-}
-
-module_init(istallion_module_init);
-module_exit(istallion_module_exit);
-
 /*****************************************************************************/
 
 /*
@@ -4601,10 +4541,14 @@ static const struct tty_operations stli_
 };
 
 /*****************************************************************************/
+/*
+ *	Loadable module initialization stuff.
+ */
 
-static int __init stli_init(void)
+static int __init istallion_module_init(void)
 {
 	int i;
+
 	printk(KERN_INFO "%s: version %s\n", stli_drvtitle, stli_drvversion);
 
 	spin_lock_init(&stli_lock);
@@ -4661,3 +4605,50 @@ static int __init stli_init(void)
 }
 
 /*****************************************************************************/
+
+static void __exit istallion_module_exit(void)
+{
+	struct stlibrd	*brdp;
+	unsigned int j;
+	int		i;
+
+	printk(KERN_INFO "Unloading %s: version %s\n", stli_drvtitle,
+		stli_drvversion);
+
+	pci_unregister_driver(&stli_pcidriver);
+	/*
+	 *	Free up all allocated resources used by the ports. This includes
+	 *	memory and interrupts.
+	 */
+	if (stli_timeron) {
+		stli_timeron = 0;
+		del_timer_sync(&stli_timerlist);
+	}
+
+	i = tty_unregister_driver(stli_serial);
+	put_tty_driver(stli_serial);
+	for (j = 0; j < 4; j++)
+		class_device_destroy(istallion_class, MKDEV(STL_SIOMEMMAJOR, j));
+	class_destroy(istallion_class);
+	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
+		printk("STALLION: failed to un-register serial memory device, "
+			"errno=%d\n", -i);
+
+	kfree(stli_txcookbuf);
+
+	for (j = 0; (j < stli_nrbrds); j++) {
+		if ((brdp = stli_brds[j]) == NULL || (brdp->state & BST_PROBED))
+			continue;
+
+		stli_cleanup_ports(brdp);
+
+		iounmap(brdp->membase);
+		if (brdp->iosize > 0)
+			release_region(brdp->iobase, brdp->iosize);
+		kfree(brdp);
+		stli_brds[j] = NULL;
+	}
+}
+
+module_init(istallion_module_init);
+module_exit(istallion_module_exit);
