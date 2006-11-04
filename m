Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965558AbWKDR1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965558AbWKDR1f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 12:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965562AbWKDR1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 12:27:34 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:2533 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S965561AbWKDR1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 12:27:17 -0500
Message-id: <229096512441526094@wsc.cz>
Subject: [PATCH 6/6] Char: stallion, use dynamic dev
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat,  4 Nov 2006 18:27:12 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stallion, use dynamic dev

Use dynamic tty device registering depending on board's port count.
(i -> retval change is relevant, since gcc complains about signedness of i)

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit f5387c4764732e6e830152bee8c546f69843a2a7
tree 9d8e98202750f685a58680b87f1273df18615874
parent 4f8d6cfde402d83afad0231d03bfa721fb6b8589
author Jiri Slaby <jirislaby@gmail.com> Fri, 03 Nov 2006 00:07:32 +0100
committer Jiri Slaby <jirislaby@gmail.com> Fri, 03 Nov 2006 00:07:32 +0100

 drivers/char/stallion.c |   33 +++++++++++++++++++++++++++------
 1 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 3bbc86f..e8ca041 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -2350,7 +2350,7 @@ static int __devinit stl_pciprobe(struct
 		const struct pci_device_id *ent)
 {
 	struct stlbrd *brdp;
-	unsigned int brdtype = ent->driver_data;
+	unsigned int i, brdtype = ent->driver_data;
 	int brdnr, retval = -ENODEV;
 
 	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE)
@@ -2411,6 +2411,10 @@ static int __devinit stl_pciprobe(struct
 
 	pci_set_drvdata(pdev, brdp);
 
+	for (i = 0; i < brdp->nrports; i++)
+		tty_register_device(stl_serial,
+				brdp->brdnr * STL_MAXPORTS + i, &pdev->dev);
+
 	return 0;
 err_null:
 	stl_brds[brdp->brdnr] = NULL;
@@ -2423,6 +2427,7 @@ err:
 static void __devexit stl_pciremove(struct pci_dev *pdev)
 {
 	struct stlbrd *brdp = pci_get_drvdata(pdev);
+	unsigned int i;
 
 	free_irq(brdp->irq, brdp);
 
@@ -2432,6 +2437,10 @@ static void __devexit stl_pciremove(stru
 	if (brdp->iosize2 > 0)
 		release_region(brdp->ioaddr2, brdp->iosize2);
 
+	for (i = 0; i < brdp->nrports; i++)
+		tty_unregister_device(stl_serial,
+				brdp->brdnr * STL_MAXPORTS + i);
+
 	stl_brds[brdp->brdnr] = NULL;
 	kfree(brdp);
 }
@@ -4695,7 +4704,7 @@ static int __init stallion_module_init(v
 {
 	struct stlbrd	*brdp;
 	struct stlconf	conf;
-	unsigned int i;
+	unsigned int i, j;
 	int retval;
 
 	printk(KERN_INFO "%s: version %s\n", stl_drvtitle, stl_drvversion);
@@ -4722,6 +4731,9 @@ static int __init stallion_module_init(v
 		if (stl_brdinit(brdp))
 			kfree(brdp);
 		else {
+			for (j = 0; j < brdp->nrports; j++)
+				tty_register_device(stl_serial,
+					brdp->brdnr * STL_MAXPORTS + j, NULL);
 			stl_brds[brdp->brdnr] = brdp;
 			stl_nrbrds = i + 1;
 		}
@@ -4763,7 +4775,7 @@ static int __init stallion_module_init(v
 	stl_serial->type = TTY_DRIVER_TYPE_SERIAL;
 	stl_serial->subtype = SERIAL_TYPE_NORMAL;
 	stl_serial->init_termios = stl_deftermios;
-	stl_serial->flags = TTY_DRIVER_REAL_RAW;
+	stl_serial->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	tty_set_operations(stl_serial, &stl_ops);
 
 	retval = tty_register_driver(stl_serial);
@@ -4789,7 +4801,9 @@ err:
 
 static void __exit stallion_module_exit(void)
 {
-	int		i;
+	struct stlbrd *brdp;
+	unsigned int i, j;
+	int retval;
 
 	pr_debug("cleanup_module()\n");
 
@@ -4802,14 +4816,21 @@ static void __exit stallion_module_exit(
  *	a hangup on every open port - to try to flush out any processes
  *	hanging onto ports.
  */
+	for (i = 0; i < stl_nrbrds; i++) {
+		if ((brdp = stl_brds[i]) == NULL || (brdp->state & STL_PROBED))
+			continue;
+		for (j = 0; j < brdp->nrports; j++)
+			tty_unregister_device(stl_serial,
+				brdp->brdnr * STL_MAXPORTS + j);
+	}
 	tty_unregister_driver(stl_serial);
 	put_tty_driver(stl_serial);
 
 	for (i = 0; i < 4; i++)
 		class_device_destroy(stallion_class, MKDEV(STL_SIOMEMMAJOR, i));
-	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
+	if ((retval = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
 		printk("STALLION: failed to un-register serial memory device, "
-			"errno=%d\n", -i);
+			"errno=%d\n", -retval);
 	class_destroy(stallion_class);
 
 	pci_unregister_driver(&stl_pcidriver);
