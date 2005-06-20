Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVFUCZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVFUCZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVFUCZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:25:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:30180 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261719AbVFTW7r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:47 -0400
Cc: gregkh@suse.de
Subject: [PATCH] class: convert drivers/char/* to use the new class api instead of class_simple
In-Reply-To: <1119308362895@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:23 -0700
Message-Id: <11193083631119@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] class: convert drivers/char/* to use the new class api instead of class_simple

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ca8eca6884861c1ce294b05aacfdf9045bba9aff
tree d155207bb52a56683160aa192765a19d67161c01
parent deb3697037a7d362d13468a73643e09cbc1615a8
author gregkh@suse.de <gregkh@suse.de> Wed, 23 Mar 2005 09:53:09 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:08 -0700

 drivers/char/dsp56k.c                   |   14 +++++++-------
 drivers/char/ftape/zftape/zftape-init.c |   30 +++++++++++++++---------------
 drivers/char/ip2main.c                  |   24 ++++++++++++------------
 drivers/char/istallion.c                |   10 +++++-----
 drivers/char/lp.c                       |   12 ++++++------
 drivers/char/mem.c                      |    7 +++----
 drivers/char/misc.c                     |   16 ++++++++--------
 drivers/char/ppdev.c                    |   12 ++++++------
 drivers/char/raw.c                      |   18 +++++++++---------
 drivers/char/snsc.c                     |    7 ++++---
 drivers/char/stallion.c                 |   10 +++++-----
 drivers/char/tipar.c                    |   14 +++++++-------
 drivers/char/vc_screen.c                |   16 ++++++++--------
 drivers/char/viotape.c                  |   16 ++++++++--------
 14 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/drivers/char/dsp56k.c b/drivers/char/dsp56k.c
--- a/drivers/char/dsp56k.c
+++ b/drivers/char/dsp56k.c
@@ -144,7 +144,7 @@ static struct dsp56k_device {
 	int tx_wsize, rx_wsize;
 } dsp56k;
 
-static struct class_simple *dsp56k_class;
+static struct class *dsp56k_class;
 
 static int dsp56k_reset(void)
 {
@@ -510,12 +510,12 @@ static int __init dsp56k_init_driver(voi
 		printk("DSP56k driver: Unable to register driver\n");
 		return -ENODEV;
 	}
-	dsp56k_class = class_simple_create(THIS_MODULE, "dsp56k");
+	dsp56k_class = class_create(THIS_MODULE, "dsp56k");
 	if (IS_ERR(dsp56k_class)) {
 		err = PTR_ERR(dsp56k_class);
 		goto out_chrdev;
 	}
-	class_simple_device_add(dsp56k_class, MKDEV(DSP56K_MAJOR, 0), NULL, "dsp56k");
+	class_device_create(dsp56k_class, MKDEV(DSP56K_MAJOR, 0), NULL, "dsp56k");
 
 	err = devfs_mk_cdev(MKDEV(DSP56K_MAJOR, 0),
 		      S_IFCHR | S_IRUSR | S_IWUSR, "dsp56k");
@@ -526,8 +526,8 @@ static int __init dsp56k_init_driver(voi
 	goto out;
 
 out_class:
-	class_simple_device_remove(MKDEV(DSP56K_MAJOR, 0));
-	class_simple_destroy(dsp56k_class);
+	class_device_destroy(dsp56k_class, MKDEV(DSP56K_MAJOR, 0));
+	class_destroy(dsp56k_class);
 out_chrdev:
 	unregister_chrdev(DSP56K_MAJOR, "dsp56k");
 out:
@@ -537,8 +537,8 @@ module_init(dsp56k_init_driver);
 
 static void __exit dsp56k_cleanup_driver(void)
 {
-	class_simple_device_remove(MKDEV(DSP56K_MAJOR, 0));
-	class_simple_destroy(dsp56k_class);
+	class_device_destroy(dsp56k_class, MKDEV(DSP56K_MAJOR, 0));
+	class_destroy(dsp56k_class);
 	unregister_chrdev(DSP56K_MAJOR, "dsp56k");
 	devfs_remove("dsp56k");
 }
diff --git a/drivers/char/ftape/zftape/zftape-init.c b/drivers/char/ftape/zftape/zftape-init.c
--- a/drivers/char/ftape/zftape/zftape-init.c
+++ b/drivers/char/ftape/zftape/zftape-init.c
@@ -99,7 +99,7 @@ static struct file_operations zft_cdev =
 	.release	= zft_close,
 };
 
-static struct class_simple *zft_class;
+static struct class *zft_class;
 
 /*      Open floppy tape device
  */
@@ -329,29 +329,29 @@ KERN_INFO
 	      "installing zftape VFS interface for ftape driver ...");
 	TRACE_CATCH(register_chrdev(QIC117_TAPE_MAJOR, "zft", &zft_cdev),);
 
-	zft_class = class_simple_create(THIS_MODULE, "zft");
+	zft_class = class_create(THIS_MODULE, "zft");
 	for (i = 0; i < 4; i++) {
-		class_simple_device_add(zft_class, MKDEV(QIC117_TAPE_MAJOR, i), NULL, "qft%i", i);
+		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i), NULL, "qft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"qft%i", i);
-		class_simple_device_add(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 4), NULL, "nqft%i", i);
+		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 4), NULL, "nqft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 4),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"nqft%i", i);
-		class_simple_device_add(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 16), NULL, "zqft%i", i);
+		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 16), NULL, "zqft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 16),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"zqft%i", i);
-		class_simple_device_add(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 20), NULL, "nzqft%i", i);
+		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 20), NULL, "nzqft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 20),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"nzqft%i", i);
-		class_simple_device_add(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 32), NULL, "rawqft%i", i);
+		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 32), NULL, "rawqft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 32),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"rawqft%i", i);
-		class_simple_device_add(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 36), NULL, "nrawrawqft%i", i);
+		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 36), NULL, "nrawrawqft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 36),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"nrawqft%i", i);
@@ -381,19 +381,19 @@ static void zft_exit(void)
 	}
         for (i = 0; i < 4; i++) {
 		devfs_remove("qft%i", i);
-		class_simple_device_remove(MKDEV(QIC117_TAPE_MAJOR, i));
+		class_device_destroy(zft_class, MKDEV(QIC117_TAPE_MAJOR, i));
 		devfs_remove("nqft%i", i);
-		class_simple_device_remove(MKDEV(QIC117_TAPE_MAJOR, i + 4));
+		class_device_destroy(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 4));
 		devfs_remove("zqft%i", i);
-		class_simple_device_remove(MKDEV(QIC117_TAPE_MAJOR, i + 16));
+		class_device_destroy(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 16));
 		devfs_remove("nzqft%i", i);
-		class_simple_device_remove(MKDEV(QIC117_TAPE_MAJOR, i + 20));
+		class_device_destroy(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 20));
 		devfs_remove("rawqft%i", i);
-		class_simple_device_remove(MKDEV(QIC117_TAPE_MAJOR, i + 32));
+		class_device_destroy(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 32));
 		devfs_remove("nrawqft%i", i);
-		class_simple_device_remove(MKDEV(QIC117_TAPE_MAJOR, i + 36));
+		class_device_destroy(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 36));
 	}
-	class_simple_destroy(zft_class);
+	class_destroy(zft_class);
 	zft_uninit_mem(); /* release remaining memory, if any */
         printk(KERN_INFO "zftape successfully unloaded.\n");
 	TRACE_EXIT;
diff --git a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c
+++ b/drivers/char/ip2main.c
@@ -302,7 +302,7 @@ static char rirqs[IP2_MAX_BOARDS];
 static int Valid_Irqs[] = { 3, 4, 5, 7, 10, 11, 12, 15, 0};
 
 /* for sysfs class support */
-static struct class_simple *ip2_class;
+static struct class *ip2_class;
 
 // Some functions to keep track of what irq's we have
 
@@ -414,9 +414,9 @@ cleanup_module(void)
 			iiResetDelay( i2BoardPtrTable[i] );
 			/* free io addresses and Tibet */
 			release_region( ip2config.addr[i], 8 );
-			class_simple_device_remove(MKDEV(IP2_IPL_MAJOR, 4 * i)); 
+			class_device_destroy(ip2_class, MKDEV(IP2_IPL_MAJOR, 4 * i));
 			devfs_remove("ip2/ipl%d", i);
-			class_simple_device_remove(MKDEV(IP2_IPL_MAJOR, 4 * i + 1));
+			class_device_destroy(ip2_class, MKDEV(IP2_IPL_MAJOR, 4 * i + 1));
 			devfs_remove("ip2/stat%d", i);
 		}
 		/* Disable and remove interrupt handler. */
@@ -425,7 +425,7 @@ cleanup_module(void)
 			clear_requested_irq( ip2config.irq[i]);
 		}
 	}
-	class_simple_destroy(ip2_class);
+	class_destroy(ip2_class);
 	devfs_remove("ip2");
 	if ( ( err = tty_unregister_driver ( ip2_tty_driver ) ) ) {
 		printk(KERN_ERR "IP2: failed to unregister tty driver (%d)\n", err);
@@ -700,7 +700,7 @@ ip2_loadmain(int *iop, int *irqp, unsign
 		printk(KERN_ERR "IP2: failed to register IPL device (%d)\n", err );
 	} else {
 		/* create the sysfs class */
-		ip2_class = class_simple_create(THIS_MODULE, "ip2");
+		ip2_class = class_create(THIS_MODULE, "ip2");
 		if (IS_ERR(ip2_class)) {
 			err = PTR_ERR(ip2_class);
 			goto out_chrdev;	
@@ -722,25 +722,25 @@ ip2_loadmain(int *iop, int *irqp, unsign
 			}
 
 			if ( NULL != ( pB = i2BoardPtrTable[i] ) ) {
-				class_simple_device_add(ip2_class, MKDEV(IP2_IPL_MAJOR, 
+				class_device_create(ip2_class, MKDEV(IP2_IPL_MAJOR,
 						4 * i), NULL, "ipl%d", i);
 				err = devfs_mk_cdev(MKDEV(IP2_IPL_MAJOR, 4 * i),
 						S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
 						"ip2/ipl%d", i);
 				if (err) {
-					class_simple_device_remove(MKDEV(IP2_IPL_MAJOR, 
-						4 * i));
+					class_device_destroy(ip2_class,
+						MKDEV(IP2_IPL_MAJOR, 4 * i));
 					goto out_class;
 				}
 
-				class_simple_device_add(ip2_class, MKDEV(IP2_IPL_MAJOR, 
+				class_device_create(ip2_class, MKDEV(IP2_IPL_MAJOR,
 						4 * i + 1), NULL, "stat%d", i);
 				err = devfs_mk_cdev(MKDEV(IP2_IPL_MAJOR, 4 * i + 1),
 						S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
 						"ip2/stat%d", i);
 				if (err) {
-					class_simple_device_remove(MKDEV(IP2_IPL_MAJOR, 
-						4 * i + 1));
+					class_device_destroy(ip2_class,
+						MKDEV(IP2_IPL_MAJOR, 4 * i + 1));
 					goto out_class;
 				}
 
@@ -798,7 +798,7 @@ retry:
 	goto out;
 
 out_class:
-	class_simple_destroy(ip2_class);
+	class_destroy(ip2_class);
 out_chrdev:
 	unregister_chrdev(IP2_IPL_MAJOR, "ip2");
 out:
diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -792,7 +792,7 @@ static int	stli_timeron;
 
 /*****************************************************************************/
 
-static struct class_simple *istallion_class;
+static struct class *istallion_class;
 
 #ifdef MODULE
 
@@ -854,10 +854,10 @@ static void __exit istallion_module_exit
 	put_tty_driver(stli_serial);
 	for (i = 0; i < 4; i++) {
 		devfs_remove("staliomem/%d", i);
-		class_simple_device_remove(MKDEV(STL_SIOMEMMAJOR, i));
+		class_device_destroy(istallion_class, MKDEV(STL_SIOMEMMAJOR, i));
 	}
 	devfs_remove("staliomem");
-	class_simple_destroy(istallion_class);
+	class_destroy(istallion_class);
 	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
 		printk("STALLION: failed to un-register serial memory device, "
 			"errno=%d\n", -i);
@@ -5242,12 +5242,12 @@ int __init stli_init(void)
 				"device\n");
 
 	devfs_mk_dir("staliomem");
-	istallion_class = class_simple_create(THIS_MODULE, "staliomem");
+	istallion_class = class_create(THIS_MODULE, "staliomem");
 	for (i = 0; i < 4; i++) {
 		devfs_mk_cdev(MKDEV(STL_SIOMEMMAJOR, i),
 			       S_IFCHR | S_IRUSR | S_IWUSR,
 			       "staliomem/%d", i);
-		class_simple_device_add(istallion_class, MKDEV(STL_SIOMEMMAJOR, i), 
+		class_device_create(istallion_class, MKDEV(STL_SIOMEMMAJOR, i),
 				NULL, "staliomem%d", i);
 	}
 
diff --git a/drivers/char/lp.c b/drivers/char/lp.c
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -146,7 +146,7 @@
 static struct lp_struct lp_table[LP_NO];
 
 static unsigned int lp_count = 0;
-static struct class_simple *lp_class;
+static struct class *lp_class;
 
 #ifdef CONFIG_LP_CONSOLE
 static struct parport *console_registered; // initially NULL
@@ -804,7 +804,7 @@ static int lp_register(int nr, struct pa
 	if (reset)
 		lp_reset(nr);
 
-	class_simple_device_add(lp_class, MKDEV(LP_MAJOR, nr), NULL,
+	class_device_create(lp_class, MKDEV(LP_MAJOR, nr), NULL,
 				"lp%d", nr);
 	devfs_mk_cdev(MKDEV(LP_MAJOR, nr), S_IFCHR | S_IRUGO | S_IWUGO,
 			"printers/%d", nr);
@@ -907,7 +907,7 @@ static int __init lp_init (void)
 	}
 
 	devfs_mk_dir("printers");
-	lp_class = class_simple_create(THIS_MODULE, "printer");
+	lp_class = class_create(THIS_MODULE, "printer");
 	if (IS_ERR(lp_class)) {
 		err = PTR_ERR(lp_class);
 		goto out_devfs;
@@ -930,7 +930,7 @@ static int __init lp_init (void)
 	return 0;
 
 out_class:
-	class_simple_destroy(lp_class);
+	class_destroy(lp_class);
 out_devfs:
 	devfs_remove("printers");
 	unregister_chrdev(LP_MAJOR, "lp");
@@ -981,10 +981,10 @@ static void lp_cleanup_module (void)
 			continue;
 		parport_unregister_device(lp_table[offset].dev);
 		devfs_remove("printers/%d", offset);
-		class_simple_device_remove(MKDEV(LP_MAJOR, offset));
+		class_device_destroy(lp_class, MKDEV(LP_MAJOR, offset));
 	}
 	devfs_remove("printers");
-	class_simple_destroy(lp_class);
+	class_destroy(lp_class);
 }
 
 __setup("lp=", lp_setup);
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -856,7 +856,7 @@ static const struct {
 	{11,"kmsg",    S_IRUGO | S_IWUSR,           &kmsg_fops},
 };
 
-static struct class_simple *mem_class;
+static struct class *mem_class;
 
 static int __init chr_dev_init(void)
 {
@@ -865,10 +865,9 @@ static int __init chr_dev_init(void)
 	if (register_chrdev(MEM_MAJOR,"mem",&memory_fops))
 		printk("unable to get major %d for memory devs\n", MEM_MAJOR);
 
-	mem_class = class_simple_create(THIS_MODULE, "mem");
+	mem_class = class_create(THIS_MODULE, "mem");
 	for (i = 0; i < ARRAY_SIZE(devlist); i++) {
-		class_simple_device_add(mem_class,
-					MKDEV(MEM_MAJOR, devlist[i].minor),
+		class_device_create(mem_class, MKDEV(MEM_MAJOR, devlist[i].minor),
 					NULL, devlist[i].name);
 		devfs_mk_cdev(MKDEV(MEM_MAJOR, devlist[i].minor),
 				S_IFCHR | devlist[i].mode, devlist[i].name);
diff --git a/drivers/char/misc.c b/drivers/char/misc.c
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -177,10 +177,10 @@ fail:
 
 /* 
  * TODO for 2.7:
- *  - add a struct class_device to struct miscdevice and make all usages of
+ *  - add a struct kref to struct miscdevice and make all usages of
  *    them dynamic.
  */
-static struct class_simple *misc_class;
+static struct class *misc_class;
 
 static struct file_operations misc_fops = {
 	.owner		= THIS_MODULE,
@@ -238,8 +238,8 @@ int misc_register(struct miscdevice * mi
 	}
 	dev = MKDEV(MISC_MAJOR, misc->minor);
 
-	misc->class = class_simple_device_add(misc_class, dev,
-					      misc->dev, misc->name);
+	misc->class = class_device_create(misc_class, dev, misc->dev,
+					  "%s", misc->name);
 	if (IS_ERR(misc->class)) {
 		err = PTR_ERR(misc->class);
 		goto out;
@@ -248,7 +248,7 @@ int misc_register(struct miscdevice * mi
 	err = devfs_mk_cdev(dev, S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP, 
 			    misc->devfs_name);
 	if (err) {
-		class_simple_device_remove(dev);
+		class_device_destroy(misc_class, dev);
 		goto out;
 	}
 
@@ -281,7 +281,7 @@ int misc_deregister(struct miscdevice * 
 
 	down(&misc_sem);
 	list_del(&misc->list);
-	class_simple_device_remove(MKDEV(MISC_MAJOR, misc->minor));
+	class_device_destroy(misc_class, MKDEV(MISC_MAJOR, misc->minor));
 	devfs_remove(misc->devfs_name);
 	if (i < DYNAMIC_MINORS && i>0) {
 		misc_minors[i>>3] &= ~(1 << (misc->minor & 7));
@@ -302,7 +302,7 @@ static int __init misc_init(void)
 	if (ent)
 		ent->proc_fops = &misc_proc_fops;
 #endif
-	misc_class = class_simple_create(THIS_MODULE, "misc");
+	misc_class = class_create(THIS_MODULE, "misc");
 	if (IS_ERR(misc_class))
 		return PTR_ERR(misc_class);
 #ifdef CONFIG_MVME16x
@@ -323,7 +323,7 @@ static int __init misc_init(void)
 	if (register_chrdev(MISC_MAJOR,"misc",&misc_fops)) {
 		printk("unable to get major %d for misc devices\n",
 		       MISC_MAJOR);
-		class_simple_destroy(misc_class);
+		class_destroy(misc_class);
 		return -EIO;
 	}
 	return 0;
diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -737,7 +737,7 @@ static unsigned int pp_poll (struct file
 	return mask;
 }
 
-static struct class_simple *ppdev_class;
+static struct class *ppdev_class;
 
 static struct file_operations pp_fops = {
 	.owner		= THIS_MODULE,
@@ -752,13 +752,13 @@ static struct file_operations pp_fops = 
 
 static void pp_attach(struct parport *port)
 {
-	class_simple_device_add(ppdev_class, MKDEV(PP_MAJOR, port->number),
+	class_device_create(ppdev_class, MKDEV(PP_MAJOR, port->number),
 			NULL, "parport%d", port->number);
 }
 
 static void pp_detach(struct parport *port)
 {
-	class_simple_device_remove(MKDEV(PP_MAJOR, port->number));
+	class_device_destroy(ppdev_class, MKDEV(PP_MAJOR, port->number));
 }
 
 static struct parport_driver pp_driver = {
@@ -776,7 +776,7 @@ static int __init ppdev_init (void)
 			PP_MAJOR);
 		return -EIO;
 	}
-	ppdev_class = class_simple_create(THIS_MODULE, CHRDEV);
+	ppdev_class = class_create(THIS_MODULE, CHRDEV);
 	if (IS_ERR(ppdev_class)) {
 		err = PTR_ERR(ppdev_class);
 		goto out_chrdev;
@@ -798,7 +798,7 @@ out_class:
 	for (i = 0; i < PARPORT_MAX; i++)
 		devfs_remove("parports/%d", i);
 	devfs_remove("parports");
-	class_simple_destroy(ppdev_class);
+	class_destroy(ppdev_class);
 out_chrdev:
 	unregister_chrdev(PP_MAJOR, CHRDEV);
 out:
@@ -813,7 +813,7 @@ static void __exit ppdev_cleanup (void)
 		devfs_remove("parports/%d", i);
 	parport_unregister_driver(&pp_driver);
 	devfs_remove("parports");
-	class_simple_destroy(ppdev_class);
+	class_destroy(ppdev_class);
 	unregister_chrdev (PP_MAJOR, CHRDEV);
 }
 
diff --git a/drivers/char/raw.c b/drivers/char/raw.c
--- a/drivers/char/raw.c
+++ b/drivers/char/raw.c
@@ -27,7 +27,7 @@ struct raw_device_data {
 	int inuse;
 };
 
-static struct class_simple *raw_class;
+static struct class *raw_class;
 static struct raw_device_data raw_devices[MAX_RAW_MINORS];
 static DECLARE_MUTEX(raw_mutex);
 static struct file_operations raw_ctl_fops;	     /* forward declaration */
@@ -127,8 +127,8 @@ raw_ioctl(struct inode *inode, struct fi
 
 static void bind_device(struct raw_config_request *rq)
 {
-	class_simple_device_remove(MKDEV(RAW_MAJOR, rq->raw_minor));
-	class_simple_device_add(raw_class, MKDEV(RAW_MAJOR, rq->raw_minor),
+	class_device_destroy(raw_class, MKDEV(RAW_MAJOR, rq->raw_minor));
+	class_device_create(raw_class, MKDEV(RAW_MAJOR, rq->raw_minor),
 				      NULL, "raw%d", rq->raw_minor);
 }
 
@@ -200,8 +200,8 @@ static int raw_ctl_ioctl(struct inode *i
 			if (rq.block_major == 0 && rq.block_minor == 0) {
 				/* unbind */
 				rawdev->binding = NULL;
-				class_simple_device_remove(MKDEV(RAW_MAJOR,
-								rq.raw_minor));
+				class_device_destroy(raw_class,
+						MKDEV(RAW_MAJOR, rq.raw_minor));
 			} else {
 				rawdev->binding = bdget(dev);
 				if (rawdev->binding == NULL)
@@ -300,14 +300,14 @@ static int __init raw_init(void)
 		goto error;
 	}
 
-	raw_class = class_simple_create(THIS_MODULE, "raw");
+	raw_class = class_create(THIS_MODULE, "raw");
 	if (IS_ERR(raw_class)) {
 		printk(KERN_ERR "Error creating raw class.\n");
 		cdev_del(&raw_cdev);
 		unregister_chrdev_region(dev, MAX_RAW_MINORS);
 		goto error;
 	}
-	class_simple_device_add(raw_class, MKDEV(RAW_MAJOR, 0), NULL, "rawctl");
+	class_device_create(raw_class, MKDEV(RAW_MAJOR, 0), NULL, "rawctl");
 
 	devfs_mk_cdev(MKDEV(RAW_MAJOR, 0),
 		      S_IFCHR | S_IRUGO | S_IWUGO,
@@ -331,8 +331,8 @@ static void __exit raw_exit(void)
 		devfs_remove("raw/raw%d", i);
 	devfs_remove("raw/rawctl");
 	devfs_remove("raw");
-	class_simple_device_remove(MKDEV(RAW_MAJOR, 0));
-	class_simple_destroy(raw_class);
+	class_device_destroy(raw_class, MKDEV(RAW_MAJOR, 0));
+	class_destroy(raw_class);
 	cdev_del(&raw_cdev);
 	unregister_chrdev_region(MKDEV(RAW_MAJOR, 0), MAX_RAW_MINORS);
 }
diff --git a/drivers/char/snsc.c b/drivers/char/snsc.c
--- a/drivers/char/snsc.c
+++ b/drivers/char/snsc.c
@@ -357,6 +357,8 @@ static struct file_operations scdrv_fops
 	.release =	scdrv_release,
 };
 
+static struct class *snsc_class;
+
 /*
  * scdrv_init
  *
@@ -372,7 +374,6 @@ scdrv_init(void)
 	char *devnamep;
 	struct sysctl_data_s *scd;
 	void *salbuf;
-	struct class_simple *snsc_class;
 	dev_t first_dev, dev;
 	nasid_t event_nasid = ia64_sn_get_console_nasid();
 
@@ -382,7 +383,7 @@ scdrv_init(void)
 		       __FUNCTION__);
 		return -ENODEV;
 	}
-	snsc_class = class_simple_create(THIS_MODULE, SYSCTL_BASENAME);
+	snsc_class = class_create(THIS_MODULE, SYSCTL_BASENAME);
 
 	for (cnode = 0; cnode < numionodes; cnode++) {
 			geoid = cnodeid_get_geoid(cnode);
@@ -436,7 +437,7 @@ scdrv_init(void)
 				continue;
 			}
 
-			class_simple_device_add(snsc_class, dev, NULL,
+			class__device_create(snsc_class, dev, NULL,
 						"%s", devname);
 
 			ia64_sn_irtr_intr_enable(scd->scd_nasid,
diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -719,7 +719,7 @@ static struct file_operations	stl_fsiome
 
 /*****************************************************************************/
 
-static struct class_simple *stallion_class;
+static struct class *stallion_class;
 
 /*
  *	Loadable module initialization stuff.
@@ -777,13 +777,13 @@ static void __exit stallion_module_exit(
 	}
 	for (i = 0; i < 4; i++) {
 		devfs_remove("staliomem/%d", i);
-		class_simple_device_remove(MKDEV(STL_SIOMEMMAJOR, i));
+		class_device_destroy(stallion_class, MKDEV(STL_SIOMEMMAJOR, i));
 	}
 	devfs_remove("staliomem");
 	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
 		printk("STALLION: failed to un-register serial memory device, "
 			"errno=%d\n", -i);
-	class_simple_destroy(stallion_class);
+	class_destroy(stallion_class);
 
 	if (stl_tmpwritebuf != (char *) NULL)
 		kfree(stl_tmpwritebuf);
@@ -3090,12 +3090,12 @@ static int __init stl_init(void)
 		printk("STALLION: failed to register serial board device\n");
 	devfs_mk_dir("staliomem");
 
-	stallion_class = class_simple_create(THIS_MODULE, "staliomem");
+	stallion_class = class_create(THIS_MODULE, "staliomem");
 	for (i = 0; i < 4; i++) {
 		devfs_mk_cdev(MKDEV(STL_SIOMEMMAJOR, i),
 				S_IFCHR|S_IRUSR|S_IWUSR,
 				"staliomem/%d", i);
-		class_simple_device_add(stallion_class, MKDEV(STL_SIOMEMMAJOR, i), NULL, "staliomem%d", i);
+		class_device_create(stallion_class, MKDEV(STL_SIOMEMMAJOR, i), NULL, "staliomem%d", i);
 	}
 
 	stl_serial->owner = THIS_MODULE;
diff --git a/drivers/char/tipar.c b/drivers/char/tipar.c
--- a/drivers/char/tipar.c
+++ b/drivers/char/tipar.c
@@ -90,7 +90,7 @@ static int timeout = TIMAXTIME;	/* timeo
 static unsigned int tp_count;	/* tipar count */
 static unsigned long opened;	/* opened devices */
 
-static struct class_simple *tipar_class;
+static struct class *tipar_class;
 
 /* --- macros for parport access -------------------------------------- */
 
@@ -436,7 +436,7 @@ tipar_register(int nr, struct parport *p
 		goto out;
 	}
 
-	class_simple_device_add(tipar_class, MKDEV(TIPAR_MAJOR,
+	class_device_create(tipar_class, MKDEV(TIPAR_MAJOR,
 			TIPAR_MINOR + nr), NULL, "par%d", nr);
 	/* Use devfs, tree: /dev/ticables/par/[0..2] */
 	err = devfs_mk_cdev(MKDEV(TIPAR_MAJOR, TIPAR_MINOR + nr),
@@ -458,8 +458,8 @@ tipar_register(int nr, struct parport *p
 	goto out;
 
 out_class:
-	class_simple_device_remove(MKDEV(TIPAR_MAJOR, TIPAR_MINOR + nr));
-	class_simple_destroy(tipar_class);
+	class_device_destroy(tipar_class, MKDEV(TIPAR_MAJOR, TIPAR_MINOR + nr));
+	class_destroy(tipar_class);
 out:
 	return err;
 }
@@ -505,7 +505,7 @@ tipar_init_module(void)
 	/* Use devfs with tree: /dev/ticables/par/[0..2] */
 	devfs_mk_dir("ticables/par");
 
-	tipar_class = class_simple_create(THIS_MODULE, "ticables");
+	tipar_class = class_create(THIS_MODULE, "ticables");
 	if (IS_ERR(tipar_class)) {
 		err = PTR_ERR(tipar_class);
 		goto out_chrdev;
@@ -539,10 +539,10 @@ tipar_cleanup_module(void)
 		if (table[i].dev == NULL)
 			continue;
 		parport_unregister_device(table[i].dev);
-		class_simple_device_remove(MKDEV(TIPAR_MAJOR, i));
+		class_device_destroy(tipar_class, MKDEV(TIPAR_MAJOR, i));
 		devfs_remove("ticables/par/%d", i);
 	}
-	class_simple_destroy(tipar_class);
+	class_destroy(tipar_class);
 	devfs_remove("ticables/par");
 
 	pr_info("tipar: module unloaded\n");
diff --git a/drivers/char/vc_screen.c b/drivers/char/vc_screen.c
--- a/drivers/char/vc_screen.c
+++ b/drivers/char/vc_screen.c
@@ -474,7 +474,7 @@ static struct file_operations vcs_fops =
 	.open		= vcs_open,
 };
 
-static struct class_simple *vc_class;
+static struct class *vc_class;
 
 void vcs_make_devfs(struct tty_struct *tty)
 {
@@ -484,26 +484,26 @@ void vcs_make_devfs(struct tty_struct *t
 	devfs_mk_cdev(MKDEV(VCS_MAJOR, tty->index + 129),
 			S_IFCHR|S_IRUSR|S_IWUSR,
 			"vcc/a%u", tty->index + 1);
-	class_simple_device_add(vc_class, MKDEV(VCS_MAJOR, tty->index + 1), NULL, "vcs%u", tty->index + 1);
-	class_simple_device_add(vc_class, MKDEV(VCS_MAJOR, tty->index + 129), NULL, "vcsa%u", tty->index + 1);
+	class_device_create(vc_class, MKDEV(VCS_MAJOR, tty->index + 1), NULL, "vcs%u", tty->index + 1);
+	class_device_create(vc_class, MKDEV(VCS_MAJOR, tty->index + 129), NULL, "vcsa%u", tty->index + 1);
 }
 void vcs_remove_devfs(struct tty_struct *tty)
 {
 	devfs_remove("vcc/%u", tty->index + 1);
 	devfs_remove("vcc/a%u", tty->index + 1);
-	class_simple_device_remove(MKDEV(VCS_MAJOR, tty->index + 1));
-	class_simple_device_remove(MKDEV(VCS_MAJOR, tty->index + 129));
+	class_device_destroy(vc_class, MKDEV(VCS_MAJOR, tty->index + 1));
+	class_device_destroy(vc_class, MKDEV(VCS_MAJOR, tty->index + 129));
 }
 
 int __init vcs_init(void)
 {
 	if (register_chrdev(VCS_MAJOR, "vcs", &vcs_fops))
 		panic("unable to get major %d for vcs device", VCS_MAJOR);
-	vc_class = class_simple_create(THIS_MODULE, "vc");
+	vc_class = class_create(THIS_MODULE, "vc");
 
 	devfs_mk_cdev(MKDEV(VCS_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR, "vcc/0");
 	devfs_mk_cdev(MKDEV(VCS_MAJOR, 128), S_IFCHR|S_IRUSR|S_IWUSR, "vcc/a0");
-	class_simple_device_add(vc_class, MKDEV(VCS_MAJOR, 0), NULL, "vcs");
-	class_simple_device_add(vc_class, MKDEV(VCS_MAJOR, 128), NULL, "vcsa");
+	class_device_create(vc_class, MKDEV(VCS_MAJOR, 0), NULL, "vcs");
+	class_device_create(vc_class, MKDEV(VCS_MAJOR, 128), NULL, "vcsa");
 	return 0;
 }
diff --git a/drivers/char/viotape.c b/drivers/char/viotape.c
--- a/drivers/char/viotape.c
+++ b/drivers/char/viotape.c
@@ -237,7 +237,7 @@ static dma_addr_t viotape_unitinfo_token
 
 static struct mtget viomtget[VIOTAPE_MAX_TAPE];
 
-static struct class_simple *tape_class;
+static struct class *tape_class;
 
 static struct device *tape_device[VIOTAPE_MAX_TAPE];
 
@@ -956,9 +956,9 @@ static int viotape_probe(struct vio_dev 
 	state[i].cur_part = 0;
 	for (j = 0; j < MAX_PARTITIONS; ++j)
 		state[i].part_stat_rwi[j] = VIOT_IDLE;
-	class_simple_device_add(tape_class, MKDEV(VIOTAPE_MAJOR, i), NULL,
+	class_device_create(tape_class, MKDEV(VIOTAPE_MAJOR, i), NULL,
 			"iseries!vt%d", i);
-	class_simple_device_add(tape_class, MKDEV(VIOTAPE_MAJOR, i | 0x80),
+	class_device_create(tape_class, MKDEV(VIOTAPE_MAJOR, i | 0x80),
 			NULL, "iseries!nvt%d", i);
 	devfs_mk_cdev(MKDEV(VIOTAPE_MAJOR, i), S_IFCHR | S_IRUSR | S_IWUSR,
 			"iseries/vt%d", i);
@@ -980,8 +980,8 @@ static int viotape_remove(struct vio_dev
 	devfs_remove("iseries/nvt%d", i);
 	devfs_remove("iseries/vt%d", i);
 	devfs_unregister_tape(state[i].dev_handle);
-	class_simple_device_remove(MKDEV(VIOTAPE_MAJOR, i | 0x80));
-	class_simple_device_remove(MKDEV(VIOTAPE_MAJOR, i));
+	class_device_destroy(tape_class, MKDEV(VIOTAPE_MAJOR, i | 0x80));
+	class_device_destroy(tape_class, MKDEV(VIOTAPE_MAJOR, i));
 	return 0;
 }
 
@@ -1045,7 +1045,7 @@ int __init viotap_init(void)
 		goto clear_handler;
 	}
 
-	tape_class = class_simple_create(THIS_MODULE, "tape");
+	tape_class = class_create(THIS_MODULE, "tape");
 	if (IS_ERR(tape_class)) {
 		printk(VIOTAPE_KERN_WARN "Unable to allocat class\n");
 		ret = PTR_ERR(tape_class);
@@ -1070,7 +1070,7 @@ int __init viotap_init(void)
 	return 0;
 
 unreg_class:
-	class_simple_destroy(tape_class);
+	class_destroy(tape_class);
 unreg_chrdev:
 	unregister_chrdev(VIOTAPE_MAJOR, "viotape");
 clear_handler:
@@ -1110,7 +1110,7 @@ static void __exit viotap_exit(void)
 
 	remove_proc_entry("iSeries/viotape", NULL);
 	vio_unregister_driver(&viotape_driver);
-	class_simple_destroy(tape_class);
+	class_destroy(tape_class);
 	ret = unregister_chrdev(VIOTAPE_MAJOR, "viotape");
 	if (ret < 0)
 		printk(VIOTAPE_KERN_WARN "Error unregistering device: %d\n",

