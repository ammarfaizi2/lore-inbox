Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSDNIOR>; Sun, 14 Apr 2002 04:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSDNIOR>; Sun, 14 Apr 2002 04:14:17 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:44983 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311749AbSDNIOP>; Sun, 14 Apr 2002 04:14:15 -0400
Date: Sun, 14 Apr 2002 09:58:55 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] attach_mpu401 cleanup on failure
Message-ID: <Pine.LNX.4.44.0204140957400.6690-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This patch changes the definition of attach_module from void to int, the 
reason being that it is possible to probe successfully and fail in attach. 
Currently the driver uses unload_mpu401 for cleaning up, but the module 
which did the attach won't know if it failed or not and therefore can't 
even do an unload. Brian came across this particular problem with the 
opl3sa2 driver which resulted in blank entries in /proc/ioports.

Cheers,
	Zwane

--- linux-2.4.19-pre-ac/drivers/sound/mpu401.c.orig	Fri Apr 12 06:40:20 2002
+++ linux-2.4.19-pre-ac/drivers/sound/mpu401.c	Sat Apr 13 10:40:25 2002
@@ -15,6 +15,7 @@
  * Alan Cox		modularisation, use normal request_irq, use dev_id
  * Bartlomiej Zolnierkiewicz	removed some __init to allow using many drivers
  * Chris Rankin		Update the module-usage counter for the coprocessor
+ * Zwane Mwaikambo	Changed attach/unload resource freeing
  */
 
 #include <linux/module.h>
@@ -77,7 +78,7 @@
 
 static void mpu401_close(int dev);
 
-static int mpu401_status(struct mpu_config *devc)
+static inline int mpu401_status(struct mpu_config *devc)
 {
 	return inb(STATPORT(devc->base));
 }
@@ -85,17 +86,17 @@
 #define input_avail(devc)		(!(mpu401_status(devc)&INPUT_AVAIL))
 #define output_ready(devc)		(!(mpu401_status(devc)&OUTPUT_READY))
 
-static void write_command(struct mpu_config *devc, unsigned char cmd)
+static inline void write_command(struct mpu_config *devc, unsigned char cmd)
 {
 	outb(cmd, COMDPORT(devc->base));
 }
 
-static int read_data(struct mpu_config *devc)
+static inline int read_data(struct mpu_config *devc)
 {
 	return inb(DATAPORT(devc->base));
 }
 
-static void write_data(struct mpu_config *devc, unsigned char byte)
+static inline void write_data(struct mpu_config *devc, unsigned char byte)
 {
 	outb(byte, DATAPORT(devc->base));
 }
@@ -965,12 +966,12 @@
 	restore_flags(flags);
 }
 
-void attach_mpu401(struct address_info *hw_config, struct module *owner)
+int attach_mpu401(struct address_info *hw_config, struct module *owner)
 {
 	unsigned long flags;
 	char revision_char;
 
-	int m;
+	int m, ret;
 	struct mpu_config *devc;
 
 	hw_config->slots[1] = -1;
@@ -978,7 +979,8 @@
 	if (m == -1)
 	{
 		printk(KERN_WARNING "MPU-401: Too many midi devices detected\n");
-		return;
+		ret = -ENOMEM;
+		goto out_err;
 	}
 	devc = &dev_conf[m];
 	devc->base = hw_config->io_base;
@@ -1008,16 +1010,16 @@
 		if (!reset_mpu401(devc))
 		{
 			printk(KERN_WARNING "mpu401: Device didn't respond\n");
-			sound_unload_mididev(m);
-			return;
+			ret = -ENODEV;
+			goto out_mididev;
 		}
 		if (!devc->shared_irq)
 		{
 			if (request_irq(devc->irq, mpuintr, 0, "mpu401", (void *)m) < 0)
 			{
 				printk(KERN_WARNING "mpu401: Failed to allocate IRQ%d\n", devc->irq);
-				sound_unload_mididev(m);
-				return;
+				ret = -ENOMEM;
+				goto out_mididev;
 			}
 		}
 		save_flags(flags);
@@ -1027,7 +1029,12 @@
 			mpu401_chk_version(m, devc);
 		restore_flags(flags);
 	}
-	request_region(hw_config->io_base, 2, "mpu401");
+
+	if (!request_region(hw_config->io_base, 2, "mpu401"))
+	{
+		ret = -ENOMEM;
+		goto out_irq;
+	}	
 
 	if (devc->version != 0)
 		if (mpu_cmd(m, 0xC5, 0) >= 0)	/* Set timebase OK */
@@ -1039,9 +1046,9 @@
 
 	if (mpu401_synth_operations[m] == NULL)
 	{
-		sound_unload_mididev(m);
 		printk(KERN_ERR "mpu401: Can't allocate memory\n");
-		return;
+		ret = -ENOMEM;
+		goto out_resource;
 	}
 	if (!(devc->capabilities & MPU_CAP_INTLG))	/* No intelligent mode */
 	{
@@ -1120,6 +1127,17 @@
 
 	hw_config->slots[1] = m;
 	sequencer_init();
+	
+	return 0;
+
+out_resource:
+	release_region(hw_config->io_base, 2);
+out_irq:
+	free_irq(devc->irq, (void *)m);
+out_mididev:
+	sound_unload_mididev(m);
+out_err:
+	return ret;
 }
 
 static int reset_mpu401(struct mpu_config *devc)
@@ -1231,15 +1249,17 @@
 {
 	void *p;
 	int n=hw_config->slots[1];
-	
-	release_region(hw_config->io_base, 2);
-	if (hw_config->always_detect == 0 && hw_config->irq > 0)
-		free_irq(hw_config->irq, (void *)n);
-	p=mpu401_synth_operations[n];
-	sound_unload_mididev(n);
-	sound_unload_timerdev(hw_config->slots[2]);
-	if(p)
-		kfree(p);
+		
+	if (n != -1) {
+		release_region(hw_config->io_base, 2);
+		if (hw_config->always_detect == 0 && hw_config->irq > 0)
+			free_irq(hw_config->irq, (void *)n);
+		p=mpu401_synth_operations[n];
+		sound_unload_mididev(n);
+		sound_unload_timerdev(hw_config->slots[2]);
+		if(p)
+			kfree(p);
+	}
 }
 
 /*****************************************************
@@ -1754,6 +1774,7 @@
 
 int __init init_mpu401(void)
 {
+	int ret;
 	/* Can be loaded either for module use or to provide functions
 	   to others */
 	if (io != -1 && irq != -1) {
@@ -1761,7 +1782,8 @@
 		cfg.io_base = io;
 		if (probe_mpu401(&cfg) == 0)
 			return -ENODEV;
-		attach_mpu401(&cfg, THIS_MODULE);
+		if ((ret = attach_mpu401(&cfg, THIS_MODULE)))
+			return ret;
 	}
 	
 	return 0;
--- linux-2.4.19-pre-ac/drivers/sound/mpu401.h.orig	Fri Apr 12 07:04:06 2002
+++ linux-2.4.19-pre-ac/drivers/sound/mpu401.h	Fri Apr 12 07:04:17 2002
@@ -7,7 +7,7 @@
 
 /*	From mpu401.c */
 int probe_mpu401(struct address_info *hw_config);
-void attach_mpu401(struct address_info * hw_config, struct module *owner);
+int attach_mpu401(struct address_info * hw_config, struct module *owner);
 void unload_mpu401(struct address_info *hw_info);
 
 int intchk_mpu401(void *dev_id);

-- 
http://function.linuxpower.ca
		

