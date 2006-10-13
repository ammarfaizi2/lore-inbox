Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751922AbWJMVIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbWJMVIU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbWJMVIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:08:20 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:61933 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1751922AbWJMVIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:08:18 -0400
Message-id: <2732226987254797288@wsc.cz>
Subject: [PATCH 4/7] Char: stallion, move init/deinit
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri, 13 Oct 2006 23:08:29 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stallion, move init/deinit

- Move code from stl_init into module init function, because calling it was the
  only one thing, that it did.
- Move this code to the end of the driver (usual place for this) to resolve
  dependencies simply -- without prototypes.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 519ee9839cb1a759f701c0ab97e52f4199d93914
tree 72ce341157d3cad092b8e121742d78b821335f0d
parent 5aadf44d4bf07b6d7ec0fc1fa7af6037129decf8
author Jiri Slaby <jirislaby@gmail.com> Fri, 13 Oct 2006 00:01:02 +0200
committer Jiri Slaby <jirislaby@gmail.com> Fri, 13 Oct 2006 00:01:02 +0200

 drivers/char/stallion.c |  256 ++++++++++++++++++++++-------------------------
 1 files changed, 120 insertions(+), 136 deletions(-)

diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 8d66014..48db973 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -278,9 +278,6 @@ static struct {
 /*
  *	Define the module agruments.
  */
-MODULE_AUTHOR("Greg Ungerer");
-MODULE_DESCRIPTION("Stallion Multiport Serial Driver");
-MODULE_LICENSE("GPL");
 
 module_param_array(board0, charp, &stl_nargs, 0);
 MODULE_PARM_DESC(board0, "Board 0 config -> name[,ioaddr[,ioaddr2][,irq]]");
@@ -458,7 +455,6 @@ static int	stl_parsebrd(struct stlconf *
 
 static unsigned long stl_atol(char *str);
 
-static int	stl_init(void);
 static int	stl_open(struct tty_struct *tty, struct file *filp);
 static void	stl_close(struct tty_struct *tty, struct file *filp);
 static int	stl_write(struct tty_struct *tty, const unsigned char *buf, int count);
@@ -708,91 +704,9 @@ static const struct file_operations	stl_
 	.ioctl		= stl_memioctl,
 };
 
-/*****************************************************************************/
-
 static struct class *stallion_class;
 
 /*
- *	Loadable module initialization stuff.
- */
-
-static int __init stallion_module_init(void)
-{
-	stl_init();
-	return 0;
-}
-
-/*****************************************************************************/
-
-static void __exit stallion_module_exit(void)
-{
-	struct stlbrd	*brdp;
-	struct stlpanel	*panelp;
-	struct stlport	*portp;
-	int		i, j, k;
-
-	pr_debug("cleanup_module()\n");
-
-	printk(KERN_INFO "Unloading %s: version %s\n", stl_drvtitle,
-		stl_drvversion);
-
-/*
- *	Free up all allocated resources used by the ports. This includes
- *	memory and interrupts. As part of this process we will also do
- *	a hangup on every open port - to try to flush out any processes
- *	hanging onto ports.
- */
-	i = tty_unregister_driver(stl_serial);
-	put_tty_driver(stl_serial);
-	if (i) {
-		printk("STALLION: failed to un-register tty driver, "
-			"errno=%d\n", -i);
-		return;
-	}
-	for (i = 0; i < 4; i++)
-		class_device_destroy(stallion_class, MKDEV(STL_SIOMEMMAJOR, i));
-	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
-		printk("STALLION: failed to un-register serial memory device, "
-			"errno=%d\n", -i);
-	class_destroy(stallion_class);
-
-	for (i = 0; (i < stl_nrbrds); i++) {
-		if ((brdp = stl_brds[i]) == NULL)
-			continue;
-
-		free_irq(brdp->irq, brdp);
-
-		for (j = 0; (j < STL_MAXPANELS); j++) {
-			panelp = brdp->panels[j];
-			if (panelp == NULL)
-				continue;
-			for (k = 0; (k < STL_PORTSPERPANEL); k++) {
-				portp = panelp->ports[k];
-				if (portp == NULL)
-					continue;
-				if (portp->tty != NULL)
-					stl_hangup(portp->tty);
-				kfree(portp->tx.buf);
-				kfree(portp);
-			}
-			kfree(panelp);
-		}
-
-		release_region(brdp->ioaddr1, brdp->iosize1);
-		if (brdp->iosize2 > 0)
-			release_region(brdp->ioaddr2, brdp->iosize2);
-
-		kfree(brdp);
-		stl_brds[i] = NULL;
-	}
-}
-
-module_init(stallion_module_init);
-module_exit(stallion_module_exit);
-
-/*****************************************************************************/
-
-/*
  *	Check for any arguments passed in on the module load command line.
  */
 
@@ -2937,55 +2851,6 @@ static const struct tty_operations stl_o
 };
 
 /*****************************************************************************/
-
-static int __init stl_init(void)
-{
-	int i;
-	printk(KERN_INFO "%s: version %s\n", stl_drvtitle, stl_drvversion);
-
-	spin_lock_init(&stallion_lock);
-	spin_lock_init(&brd_lock);
-
-	stl_initbrds();
-
-	stl_serial = alloc_tty_driver(STL_MAXBRDS * STL_MAXPORTS);
-	if (!stl_serial)
-		return -1;
-
-/*
- *	Set up a character driver for per board stuff. This is mainly used
- *	to do stats ioctls on the ports.
- */
-	if (register_chrdev(STL_SIOMEMMAJOR, "staliomem", &stl_fsiomem))
-		printk("STALLION: failed to register serial board device\n");
-
-	stallion_class = class_create(THIS_MODULE, "staliomem");
-	for (i = 0; i < 4; i++)
-		class_device_create(stallion_class, NULL,
-				    MKDEV(STL_SIOMEMMAJOR, i), NULL,
-				    "staliomem%d", i);
-
-	stl_serial->owner = THIS_MODULE;
-	stl_serial->driver_name = stl_drvname;
-	stl_serial->name = "ttyE";
-	stl_serial->major = STL_SERIALMAJOR;
-	stl_serial->minor_start = 0;
-	stl_serial->type = TTY_DRIVER_TYPE_SERIAL;
-	stl_serial->subtype = SERIAL_TYPE_NORMAL;
-	stl_serial->init_termios = stl_deftermios;
-	stl_serial->flags = TTY_DRIVER_REAL_RAW;
-	tty_set_operations(stl_serial, &stl_ops);
-
-	if (tty_register_driver(stl_serial)) {
-		put_tty_driver(stl_serial);
-		printk("STALLION: failed to register serial driver\n");
-		return -1;
-	}
-
-	return 0;
-}
-
-/*****************************************************************************/
 /*                       CD1400 HARDWARE FUNCTIONS                           */
 /*****************************************************************************/
 
@@ -4956,4 +4821,123 @@ static void stl_sc26198otherisr(struct s
 	}
 }
 
-/*****************************************************************************/
+/*
+ *	Loadable module initialization stuff.
+ */
+static int __init stallion_module_init(void)
+{
+	unsigned int i;
+
+	printk(KERN_INFO "%s: version %s\n", stl_drvtitle, stl_drvversion);
+
+	spin_lock_init(&stallion_lock);
+	spin_lock_init(&brd_lock);
+
+	stl_initbrds();
+
+	stl_serial = alloc_tty_driver(STL_MAXBRDS * STL_MAXPORTS);
+	if (!stl_serial)
+		return -1;
+
+/*
+ *	Set up a character driver for per board stuff. This is mainly used
+ *	to do stats ioctls on the ports.
+ */
+	if (register_chrdev(STL_SIOMEMMAJOR, "staliomem", &stl_fsiomem))
+		printk("STALLION: failed to register serial board device\n");
+
+	stallion_class = class_create(THIS_MODULE, "staliomem");
+	for (i = 0; i < 4; i++)
+		class_device_create(stallion_class, NULL,
+				    MKDEV(STL_SIOMEMMAJOR, i), NULL,
+				    "staliomem%d", i);
+
+	stl_serial->owner = THIS_MODULE;
+	stl_serial->driver_name = stl_drvname;
+	stl_serial->name = "ttyE";
+	stl_serial->major = STL_SERIALMAJOR;
+	stl_serial->minor_start = 0;
+	stl_serial->type = TTY_DRIVER_TYPE_SERIAL;
+	stl_serial->subtype = SERIAL_TYPE_NORMAL;
+	stl_serial->init_termios = stl_deftermios;
+	stl_serial->flags = TTY_DRIVER_REAL_RAW;
+	tty_set_operations(stl_serial, &stl_ops);
+
+	if (tty_register_driver(stl_serial)) {
+		put_tty_driver(stl_serial);
+		printk("STALLION: failed to register serial driver\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static void __exit stallion_module_exit(void)
+{
+	struct stlbrd	*brdp;
+	struct stlpanel	*panelp;
+	struct stlport	*portp;
+	int		i, j, k;
+
+	pr_debug("cleanup_module()\n");
+
+	printk(KERN_INFO "Unloading %s: version %s\n", stl_drvtitle,
+		stl_drvversion);
+
+/*
+ *	Free up all allocated resources used by the ports. This includes
+ *	memory and interrupts. As part of this process we will also do
+ *	a hangup on every open port - to try to flush out any processes
+ *	hanging onto ports.
+ */
+	i = tty_unregister_driver(stl_serial);
+	put_tty_driver(stl_serial);
+	if (i) {
+		printk("STALLION: failed to un-register tty driver, "
+			"errno=%d\n", -i);
+		return;
+	}
+	for (i = 0; i < 4; i++)
+		class_device_destroy(stallion_class, MKDEV(STL_SIOMEMMAJOR, i));
+	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
+		printk("STALLION: failed to un-register serial memory device, "
+			"errno=%d\n", -i);
+	class_destroy(stallion_class);
+
+	for (i = 0; (i < stl_nrbrds); i++) {
+		if ((brdp = stl_brds[i]) == NULL)
+			continue;
+
+		free_irq(brdp->irq, brdp);
+
+		for (j = 0; (j < STL_MAXPANELS); j++) {
+			panelp = brdp->panels[j];
+			if (panelp == NULL)
+				continue;
+			for (k = 0; (k < STL_PORTSPERPANEL); k++) {
+				portp = panelp->ports[k];
+				if (portp == NULL)
+					continue;
+				if (portp->tty != NULL)
+					stl_hangup(portp->tty);
+				kfree(portp->tx.buf);
+				kfree(portp);
+			}
+			kfree(panelp);
+		}
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
+module_init(stallion_module_init);
+module_exit(stallion_module_exit);
+
+MODULE_AUTHOR("Greg Ungerer");
+MODULE_DESCRIPTION("Stallion Multiport Serial Driver");
+MODULE_LICENSE("GPL");
