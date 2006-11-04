Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965554AbWKDR0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965554AbWKDR0X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 12:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965555AbWKDR0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 12:26:23 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:62692 "EHLO
	cacti.profiwh.com") by vger.kernel.org with ESMTP id S965554AbWKDR0W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 12:26:22 -0500
Message-id: <18642202483105730530@wsc.cz>
Subject: [PATCH 2/6] Char: stallion, fix fail paths
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat,  4 Nov 2006 18:26:29 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stallion, fix fail paths

Release everything what was allocated and check return value of isa probing.
Release only ISA boards in module exit, since pci have their own
pci-probing-remove.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 47b4f5a42e198be7c2cf3606cf2681c04a42b197
tree 149ff4c67896756102853163282c316ea8fe6016
parent 0dc9637900524e9d6b50d0d05368a19c8848dfb0
author Jiri Slaby <jirislaby@gmail.com> Thu, 02 Nov 2006 11:00:57 +0100
committer Jiri Slaby <jirislaby@gmail.com> Thu, 02 Nov 2006 11:00:57 +0100

 drivers/char/stallion.c |   81 ++++++++++++++++++++++++++++++-----------------
 1 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 928f406..048d2b0 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -143,6 +143,8 @@ static struct stlbrd		*stl_brds[STL_MAXB
  *	Not really much here!
  */
 #define	BRD_FOUND	0x1
+#define STL_PROBED	0x2
+
 
 /*
  *	Define the port structure istate flags. These set of flags are
@@ -2390,6 +2392,7 @@ static int __devinit stl_pciprobe(struct
 		goto err_fr;
 	}
 	brdp->brdtype = brdtype;
+	brdp->state |= STL_PROBED;
 
 /*
  *	We have all resources from the board, so let's setup the actual
@@ -4679,6 +4682,28 @@ static void stl_sc26198otherisr(struct s
 	}
 }
 
+static void stl_free_isabrds(void)
+{
+	struct stlbrd *brdp;
+	unsigned int i;
+
+	for (i = 0; i < stl_nrbrds; i++) {
+		if ((brdp = stl_brds[i]) == NULL || (brdp->state & STL_PROBED))
+			continue;
+
+		free_irq(brdp->irq, brdp);
+
+		stl_cleanup_panels(brdp);
+
+		release_region(brdp->ioaddr1, brdp->iosize1);
+		if (brdp->iosize2 > 0)
+			release_region(brdp->ioaddr2, brdp->iosize2);
+
+		kfree(brdp);
+		stl_brds[i] = NULL;
+	}
+}
+
 /*
  *	Loadable module initialization stuff.
  */
@@ -4686,7 +4711,8 @@ static int __init stallion_module_init(v
 {
 	struct stlbrd	*brdp;
 	struct stlconf	conf;
-	unsigned int i, retval;
+	unsigned int i;
+	int retval;
 
 	printk(KERN_INFO "%s: version %s\n", stl_drvtitle, stl_drvversion);
 
@@ -4716,12 +4742,14 @@ static int __init stallion_module_init(v
 	}
 
 	retval = pci_register_driver(&stl_pcidriver);
-	if (retval)
+	if (retval && stl_nrbrds == 0)
 		goto err;
 
 	stl_serial = alloc_tty_driver(STL_MAXBRDS * STL_MAXPORTS);
-	if (!stl_serial)
-		return -1;
+	if (!stl_serial) {
+		retval = -ENOMEM;
+		goto err_pcidr;
+	}
 
 /*
  *	Set up a character driver for per board stuff. This is mainly used
@@ -4731,6 +4759,10 @@ static int __init stallion_module_init(v
 		printk("STALLION: failed to register serial board device\n");
 
 	stallion_class = class_create(THIS_MODULE, "staliomem");
+	if (IS_ERR(stallion_class)) {
+		retval = PTR_ERR(stallion_class);
+		goto err_reg;
+	}
 	for (i = 0; i < 4; i++)
 		class_device_create(stallion_class, NULL,
 				    MKDEV(STL_SIOMEMMAJOR, i), NULL,
@@ -4747,20 +4779,29 @@ static int __init stallion_module_init(v
 	stl_serial->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(stl_serial, &stl_ops);
 
-	if (tty_register_driver(stl_serial)) {
-		put_tty_driver(stl_serial);
+	retval = tty_register_driver(stl_serial);
+	if (retval) {
 		printk("STALLION: failed to register serial driver\n");
-		return -1;
+		goto err_clsdev;
 	}
 
 	return 0;
+err_clsdev:
+	for (i = 0; i < 4; i++)
+		class_device_destroy(stallion_class, MKDEV(STL_SIOMEMMAJOR, i));
+	class_destroy(stallion_class);
+err_reg:
+	unregister_chrdev(STL_SIOMEMMAJOR, "staliomem");
+	put_tty_driver(stl_serial);
+err_pcidr:
+	pci_unregister_driver(&stl_pcidriver);
+	stl_free_isabrds();
 err:
 	return retval;
 }
 
 static void __exit stallion_module_exit(void)
 {
-	struct stlbrd	*brdp;
 	int		i;
 
 	pr_debug("cleanup_module()\n");
@@ -4774,13 +4815,9 @@ static void __exit stallion_module_exit(
  *	a hangup on every open port - to try to flush out any processes
  *	hanging onto ports.
  */
-	i = tty_unregister_driver(stl_serial);
+	tty_unregister_driver(stl_serial);
 	put_tty_driver(stl_serial);
-	if (i) {
-		printk("STALLION: failed to un-register tty driver, "
-			"errno=%d\n", -i);
-		return;
-	}
+
 	for (i = 0; i < 4; i++)
 		class_device_destroy(stallion_class, MKDEV(STL_SIOMEMMAJOR, i));
 	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
@@ -4790,21 +4827,7 @@ static void __exit stallion_module_exit(
 
 	pci_unregister_driver(&stl_pcidriver);
 
-	for (i = 0; (i < stl_nrbrds); i++) {
-		if ((brdp = stl_brds[i]) == NULL)
-			continue;
-
-		free_irq(brdp->irq, brdp);
-
-		stl_cleanup_panels(brdp);
-
-		release_region(brdp->ioaddr1, brdp->iosize1);
-		if (brdp->iosize2 > 0)
-			release_region(brdp->ioaddr2, brdp->iosize2);
-
-		kfree(brdp);
-		stl_brds[i] = NULL;
-	}
+	stl_free_isabrds();
 }
 
 module_init(stallion_module_init);
