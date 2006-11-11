Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947312AbWKKVsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947312AbWKKVsm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 16:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947311AbWKKVsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 16:48:42 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:3754 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1947312AbWKKVsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 16:48:40 -0500
Message-id: <122049607428825941@wsc.cz>
In-reply-to: <196416110522272@wsc.cz>
Subject: [PATCH 3/5] Char: istallion, change init sequence
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat, 11 Nov 2006 22:48:52 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

istallion, change init sequence

Reorganizate module init and exit and implement logic, when something
fails in these functions. The former is needed for proper handling dynamic
tty_register_device.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 92452a22c4ada362e991cbf0de84c8914525672a
tree 6e6dc05ce30f3cf7f159842136f96b2009dbbaa1
parent d804883791d787b9c0bc0b79ccec78d0d20d850d
author Jiri Slaby <jirislaby@gmail.com> Sat, 11 Nov 2006 02:17:14 +0100
committer Jiri Slaby <jirislaby@gmail.com> Sat, 11 Nov 2006 22:23:35 +0100

 drivers/char/istallion.c |  130 +++++++++++++++++++++++++++-------------------
 1 files changed, 75 insertions(+), 55 deletions(-)

diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index 2de677f..bf58938 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -4545,46 +4545,49 @@ static const struct tty_operations stli_
  *	Loadable module initialization stuff.
  */
 
+static void istallion_cleanup_isa(void)
+{
+	struct stlibrd	*brdp;
+	unsigned int j;
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
 static int __init istallion_module_init(void)
 {
-	int i;
+	unsigned int i;
+	int retval;
 
 	printk(KERN_INFO "%s: version %s\n", stli_drvtitle, stli_drvversion);
 
 	spin_lock_init(&stli_lock);
 	spin_lock_init(&brd_lock);
 
-	stli_initbrds();
-
-	stli_serial = alloc_tty_driver(STL_MAXBRDS * STL_MAXPORTS);
-	if (!stli_serial)
-		return -ENOMEM;
-
-/*
- *	Allocate a temporary write buffer.
- */
 	stli_txcookbuf = kmalloc(STLI_TXBUFSIZE, GFP_KERNEL);
-	if (!stli_txcookbuf)
+	if (!stli_txcookbuf) {
 		printk(KERN_ERR "STALLION: failed to allocate memory "
 				"(size=%d)\n", STLI_TXBUFSIZE);
+		retval = -ENOMEM;
+		goto err;
+	}
 
-/*
- *	Set up a character driver for the shared memory region. We need this
- *	to down load the slave code image. Also it is a useful debugging tool.
- */
-	if (register_chrdev(STL_SIOMEMMAJOR, "staliomem", &stli_fsiomem))
-		printk(KERN_ERR "STALLION: failed to register serial memory "
-				"device\n");
-
-	istallion_class = class_create(THIS_MODULE, "staliomem");
-	for (i = 0; i < 4; i++)
-		class_device_create(istallion_class, NULL,
-				MKDEV(STL_SIOMEMMAJOR, i),
-				NULL, "staliomem%d", i);
+	stli_serial = alloc_tty_driver(STL_MAXBRDS * STL_MAXPORTS);
+	if (!stli_serial) {
+		retval = -ENOMEM;
+		goto err_free;
+	}
 
-/*
- *	Set up the tty driver structure and register us as a driver.
- */
 	stli_serial->owner = THIS_MODULE;
 	stli_serial->driver_name = stli_drvname;
 	stli_serial->name = stli_serialname;
@@ -4596,58 +4599,75 @@ static int __init istallion_module_init(
 	stli_serial->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(stli_serial, &stli_ops);
 
-	if (tty_register_driver(stli_serial)) {
-		put_tty_driver(stli_serial);
+	retval = tty_register_driver(stli_serial);
+	if (retval) {
 		printk(KERN_ERR "STALLION: failed to register serial driver\n");
-		return -EBUSY;
+		goto err_ttyput;
+	}
+
+	retval = stli_initbrds();
+	if (retval)
+		goto err_ttyunr;
+
+/*
+ *	Set up a character driver for the shared memory region. We need this
+ *	to down load the slave code image. Also it is a useful debugging tool.
+ */
+	retval = register_chrdev(STL_SIOMEMMAJOR, "staliomem", &stli_fsiomem);
+	if (retval) {
+		printk(KERN_ERR "STALLION: failed to register serial memory "
+				"device\n");
+		goto err_deinit;
 	}
+
+	istallion_class = class_create(THIS_MODULE, "staliomem");
+	for (i = 0; i < 4; i++)
+		class_device_create(istallion_class, NULL,
+				MKDEV(STL_SIOMEMMAJOR, i),
+				NULL, "staliomem%d", i);
+
 	return 0;
+err_deinit:
+	pci_unregister_driver(&stli_pcidriver);
+	istallion_cleanup_isa();
+err_ttyunr:
+	tty_unregister_driver(stli_serial);
+err_ttyput:
+	put_tty_driver(stli_serial);
+err_free:
+	kfree(stli_txcookbuf);
+err:
+	return retval;
 }
 
 /*****************************************************************************/
 
 static void __exit istallion_module_exit(void)
 {
-	struct stlibrd	*brdp;
 	unsigned int j;
-	int		i;
 
 	printk(KERN_INFO "Unloading %s: version %s\n", stli_drvtitle,
 		stli_drvversion);
 
-	pci_unregister_driver(&stli_pcidriver);
-	/*
-	 *	Free up all allocated resources used by the ports. This includes
-	 *	memory and interrupts.
-	 */
 	if (stli_timeron) {
 		stli_timeron = 0;
 		del_timer_sync(&stli_timerlist);
 	}
 
-	i = tty_unregister_driver(stli_serial);
-	put_tty_driver(stli_serial);
+	unregister_chrdev(STL_SIOMEMMAJOR, "staliomem");
+
 	for (j = 0; j < 4; j++)
-		class_device_destroy(istallion_class, MKDEV(STL_SIOMEMMAJOR, j));
+		class_device_destroy(istallion_class, MKDEV(STL_SIOMEMMAJOR,
+					j));
 	class_destroy(istallion_class);
-	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
-		printk("STALLION: failed to un-register serial memory device, "
-			"errno=%d\n", -i);
-
-	kfree(stli_txcookbuf);
 
-	for (j = 0; (j < stli_nrbrds); j++) {
-		if ((brdp = stli_brds[j]) == NULL || (brdp->state & BST_PROBED))
-			continue;
+	pci_unregister_driver(&stli_pcidriver);
+	istallion_cleanup_isa();
 
-		stli_cleanup_ports(brdp);
+	tty_unregister_driver(stli_serial);
+	put_tty_driver(stli_serial);
 
-		iounmap(brdp->membase);
-		if (brdp->iosize > 0)
-			release_region(brdp->iobase, brdp->iosize);
-		kfree(brdp);
-		stli_brds[j] = NULL;
-	}
+	kfree(stli_txcookbuf);
 }
 
 module_init(istallion_module_init);
