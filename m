Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbTLSMih (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTLSMgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:36:25 -0500
Received: from mail.directfb.org ([212.84.236.4]:30650 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262864AbTLSM2o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:28:44 -0500
Subject: [PATCH 7/12] Update av7110 driver
In-Reply-To: <10718369212949@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Dec 2003 13:28:42 +0100
Message-Id: <10718369223835@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DVB: - av7110: follow changes in saa7146_core regarding saa7146_set_gpio() and saa7146_wait_for_debi_done() function
DVB: - av7110: increased I2C speed to 275 kHz,  follow introduction of SAA7146_I2C_SHORT_DELAY flag to speed up I2C access
DVB: - budget: make budget-ci use this gpio function and the new wait_...() function, this fixes BORROWED_FROM_AV7110_H_BUT_REALLY_BELONGS_IN_SAA7146_DEFS_H remark
DVB: - budget: use alternative values for BRS setup on budget cards (by Rober Schlabbach)
DVB: - budget: remote control table should be filled completely. at least populate the entries that come with the standard Hauppauge RC (Jamie Honan)
DVB: - ttpci-eeprom: add proper MODULE_LICENSE("GPL") so we don't taint the kernel anymore
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/ttpci/av7110.c linux-2.6.0-p/drivers/media/dvb/ttpci/av7110.c
--- linux-2.6.0/drivers/media/dvb/ttpci/av7110.c	2003-12-18 03:59:05.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/ttpci/av7110.c	2003-12-10 13:50:16.000000000 +0100
@@ -35,7 +35,6 @@
 
 #define __KERNEL_SYSCALLS__
 #include <linux/module.h>
-#include <linux/init.h>
 #include <linux/kmod.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
@@ -43,7 +42,6 @@
 #include <linux/poll.h>
 #include <linux/unistd.h>
 #include <linux/byteorder/swabb.h>
-#include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <stdarg.h>
 
@@ -55,10 +53,8 @@
 #include <linux/ptrace.h>
 #include <linux/ioport.h>
 #include <linux/in.h>
-#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/pci.h>
-#include <linux/init.h>
 #include <linux/vmalloc.h>
 #include <linux/netdevice.h>
 #include <linux/inetdevice.h>
@@ -108,6 +105,7 @@
 static int pids_off;
 static int adac=DVB_ADAC_TI;
 static int hw_sections = 1;
+static int rgb_on = 0;
 
 int av7110_num = 0;
 
@@ -118,42 +116,12 @@
  * DEBI functions
  ****************************************************************************/
 
+#define wait_for_debi_done(x) \
+       saa7146_wait_for_debi_done(x->dev) \
+
 /* This DEBI code is based on the Stradis driver 
    by Nathan Laredo <laredo@gnu.org> */
 
-static int wait_for_debi_done(struct av7110 *av7110)
-{
-	struct saa7146_dev *dev = av7110->dev;
-	int start;
-
-	/* wait for registers to be programmed */
-	start = jiffies;
-	while (1) {
-                if (saa7146_read(dev, MC2) & 2)
-                        break;
-		if (jiffies-start > HZ/20) {
-			printk ("%s: timed out while waiting for registers "
-				"getting programmed\n", __FUNCTION__);
-			return -ETIMEDOUT;
-		}
-	}
-
-	/* wait for transfer to complete */
-	start = jiffies;
-	while (1) {
-		if (!(saa7146_read(dev, PSR) & SPCI_DEBI_S))
-			break;
-		saa7146_read(dev, MC2);
-		if (jiffies-start > HZ/4) {
-			printk ("%s: timed out while waiting for transfer "
-				"completion\n", __FUNCTION__);
-			return -ETIMEDOUT;
-		}
-	}
-
-	return 0;
-}
-
 static int debiwrite(struct av7110 *av7110, u32 config, 
                      int addr, u32 val, int count)
 {
@@ -375,7 +344,7 @@
 {
         struct dvb_demux_feed *dvbdmxfeed=(struct dvb_demux_feed *) p2t->priv;
 
-	DEB_EE(("struct dvb_filter_pes2ts:%p\n",p2t));
+//	DEB_EE(("struct dvb_filter_pes2ts:%p\n",p2t));
 
         if (!(dvbdmxfeed->ts_type & TS_PACKET)) 
                 return 0;
@@ -385,14 +354,14 @@
                 return dvbdmxfeed->cb.ts(buf, len, 0, 0, 
                                          &dvbdmxfeed->feed.ts, DMX_OK); 
         else
-                return dvb_filter_pes2ts(p2t, buf, len);
+                return dvb_filter_pes2ts(p2t, buf, len, 1);
 }
 
 static int dvb_filter_pes2ts_cb(void *priv, unsigned char *data)
 {
         struct dvb_demux_feed *dvbdmxfeed=(struct dvb_demux_feed *) priv;
 
-	DEB_EE(("dvb_demux_feed:%p\n",dvbdmxfeed));
+//	DEB_EE(("dvb_demux_feed:%p\n",dvbdmxfeed));
         
         dvbdmxfeed->cb.ts(data, 188, 0, 0,
                           &dvbdmxfeed->feed.ts,
@@ -886,10 +855,10 @@
         txbuf=irdebi(av7110, DEBINOSWAP, TX_BUFF, 0, 2);
         len=(av7110->debilen+3)&(~3);
 
-        DEB_D(("GPIO0 irq %d %d\n", av7110->debitype, av7110->debilen));
+//        DEB_D(("GPIO0 irq %d %d\n", av7110->debitype, av7110->debilen));
         print_time("gpio");
 
-        DEB_D(("GPIO0 irq %02x\n", av7110->debitype&0xff));        
+//       DEB_D(("GPIO0 irq %02x\n", av7110->debitype&0xff));        
         switch (av7110->debitype&0xff) {
 
         case DATA_TS_PLAY:
@@ -2706,9 +2675,9 @@
 	buf[1] = div & 0xff;
 	buf[2] = 0x8e;
 
-	if (freq < (u32) (16*168.25) ) 
+	if (freq < (u32) 16*168.25 )
 		config = 0xa0;
-	else if (freq < (u32) (16*447.25)) 
+	else if (freq < (u32) 16*447.25)
 		config = 0x90;
 	else
 		config = 0x30;
@@ -4294,8 +4263,10 @@
                         av7110->pids[DMX_PES_TELETEXT], 0, 
                         av7110->pids[DMX_PES_PCR]);
         	outcom(av7110, COMTYPE_PIDFILTER, Scan, 0);
-	} else 
+	} else {
 		SetPIDs(av7110, 0, 0, 0, 0, 0);
+        	outcom(av7110, COMTYPE_PIDFILTER, FlushTSQueue, 0);
+	}
 
         up(&av7110->pid_mutex);
 }
@@ -4553,7 +4524,7 @@
 	   get recognized before the main driver is fully loaded */
 	saa7146_write(dev, GPIO_CTRL, 0x500000);
 
-	saa7146_i2c_adapter_prepare(dev, NULL, SAA7146_I2C_BUS_BIT_RATE_3200);
+	saa7146_i2c_adapter_prepare(dev, NULL, SAA7146_I2C_BUS_BIT_RATE_120); /* 275 kHz */
 
 	av7110->i2c_bus = dvb_register_i2c_bus (master_xfer, dev,
 						av7110->dvb_adapter, 0);
@@ -4571,7 +4542,7 @@
 
 	/* set dd1 stream a & b */
       	saa7146_write(dev, DD1_STREAM_B, 0x00000000);
-	saa7146_write(dev, DD1_INIT, 0x02000000);
+	saa7146_write(dev, DD1_INIT, 0x03000000);
 	saa7146_write(dev, MC2, (MASK_09 | MASK_25 | MASK_10 | MASK_26));
 
 	/* upload all */
@@ -4729,7 +4700,7 @@
 		memcpy(standard,dvb_standard,sizeof(struct saa7146_standard)*2);
 		/* set dd1 stream a & b */
       		saa7146_write(dev, DD1_STREAM_B, 0x00000000);
-		saa7146_write(dev, DD1_INIT, 0x02000700);
+		saa7146_write(dev, DD1_INIT, 0x03000700);
 		saa7146_write(dev, MC2, (MASK_09 | MASK_25 | MASK_10 | MASK_26));
 	}
 	else if (dev->pci->subsystem_vendor == 0x110a) {
@@ -4747,7 +4718,8 @@
 		// switch DVB SCART on
 		outcom(av7110, COMTYPE_AUDIODAC, MainSwitch, 1, 0);
 		outcom(av7110, COMTYPE_AUDIODAC, ADSwitch, 1, 1);
-		//saa7146_setgpio(dev, 1, SAA7146_GPIO_OUTHI); // RGB on, SCART pin 16
+		if (rgb_on)
+			saa7146_setgpio(dev, 1, SAA7146_GPIO_OUTHI); // RGB on, SCART pin 16
 		//saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTLO); // SCARTpin 8
 	}
 	
@@ -4858,7 +4830,7 @@
 {
 	struct av7110 *av7110 = (struct av7110*)dev->ext_priv;
 
-	DEB_INT(("dev: %p, av7110: %p\n",dev,av7110));
+//	DEB_INT(("dev: %p, av7110: %p\n",dev,av7110));
 
 	if (*isr & MASK_19)
 		tasklet_schedule (&av7110->debi_tasklet);
@@ -4887,7 +4859,7 @@
 static struct saa7146_standard analog_standard[] = {
 	{
 		.name	= "PAL", 	.id		= V4L2_STD_PAL_BG,
-		.v_offset	= 0x18,	.v_field 	= 288,		.v_calc	= 576,
+		.v_offset	= 0x18 /* 0 */ ,	.v_field 	= 288,		.v_calc	= 576,
 		.h_offset	= 0x08,	.h_pixels 	= 708,		.h_calc	= 709,
 		.v_max_out	= 576,	.h_max_out	= 768,
 	}, {
@@ -4975,7 +4947,7 @@
 	.inputs		= 1,
 	.audios 	= 1,
 	.capabilities	= 0,
-	.flags		= SAA7146_EXT_SWAP_ODD_EVEN,
+	.flags		= 0, 
 
 	.stds		= &standard[0],
 	.num_stds	= sizeof(standard)/sizeof(struct saa7146_standard),
@@ -5002,6 +4974,7 @@
 
 static struct saa7146_extension av7110_extension = {
 	.name		= "dvb\0",
+	.flags		= SAA7146_I2C_SHORT_DELAY,
 
 	.module		= THIS_MODULE,
 	.pci_tbl	= &pci_tbl[0],
@@ -5054,4 +5027,6 @@
 MODULE_PARM_DESC(adac,"audio DAC type: 0 TI, 1 CRYSTAL, 2 MSP (use if autodetection fails)");
 MODULE_PARM(hw_sections, "i");
 MODULE_PARM_DESC(hw_sections, "0 use software section filter, 1 use hardware");
-
+MODULE_PARM(rgb_on, "i");
+MODULE_PARM_DESC(rgb_on, "For Siemens DVB-C cards only: Enable RGB control"
+		" signal on SCART pin 16 to switch SCART video mode from CVBS to RGB");
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/ttpci/av7110.h linux-2.6.0-p/drivers/media/dvb/ttpci/av7110.h
--- linux-2.6.0/drivers/media/dvb/ttpci/av7110.h	2003-12-18 03:58:03.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/ttpci/av7110.h	2003-10-14 10:00:23.000000000 +0200
@@ -169,7 +169,8 @@
 	DelPIDFilter,
 	Scan,
 	SetDescr,
-        SetIR
+        SetIR,
+        FlushTSQueue
 };
 			
 enum av7110_mpeg_command {
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/ttpci/budget-ci.c linux-2.6.0-p/drivers/media/dvb/ttpci/budget-ci.c
--- linux-2.6.0/drivers/media/dvb/ttpci/budget-ci.c	2003-12-18 03:58:15.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/ttpci/budget-ci.c	2003-11-20 11:17:51.000000000 +0100
@@ -35,81 +35,26 @@
 #include <linux/interrupt.h>
 #include <linux/input.h>
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
+#include "input_fake.h"
+#endif
+
+
+
 struct budget_ci {
 	struct budget budget;
 	struct input_dev input_dev;
 	struct tasklet_struct msp430_irq_tasklet;
 };
 
-
-
-#ifndef BORROWED_FROM_AV7110_H_BUT_REALLY_BELONGS_IN_SAA7146_DEFS_H
-
-#define DEBINOSWAP 0x000e0000
-#define GPIO_IRQHI 0x10
-#define GPIO_INPUT 0x00
-
-void gpio_set(struct saa7146_dev* saa, u8 pin, u8 data)
-{
-        u32 value = 0;
-
-        /* sanity check */
-        if(pin > 3)
-                return;
-
-        /* read old register contents */
-        value = saa7146_read(saa, GPIO_CTRL );
-
-        value &= ~(0xff << (8*pin));
-        value |= (data << (8*pin));
-
-        saa7146_write(saa, GPIO_CTRL, value);
-}
-
-
-
-static int wait_for_debi_done(struct saa7146_dev *saa)
-{
-	int start = jiffies;
-
-	/* wait for registers to be programmed */
-	while (1) {
-		if (saa7146_read(saa, MC2) & 2)
-			break;
-		if (jiffies - start > HZ / 20) {
-			printk ("DVB (%s): timed out while waiting"
-				" for registers getting programmed\n",
-				__FUNCTION__);
-			return -ETIMEDOUT;
-		}
-	}
-
-	/* wait for transfer to complete */
-	start = jiffies;
-	while (1) {
-		if (!(saa7146_read(saa, PSR) & SPCI_DEBI_S))
-			break;
-		saa7146_read(saa, MC2);
-		if (jiffies - start > HZ / 4) {
-			printk ("DVB (%s): timed out while waiting"
-				" for transfer completion\n",
-				__FUNCTION__);
-			return -ETIMEDOUT;
-		}
-	}
-
-	return 0;
-}
-
-
-static u32 debiread (struct saa7146_dev *saa, u32 config, int addr, int count)
+static u32 budget_debiread4 (struct saa7146_dev *saa, u32 config, int addr, int count)
 {
 	u32 result = 0;
 
 	if (count > 4 || count <= 0)
 		return 0;
 
-	if (wait_for_debi_done(saa) < 0)
+	if (saa7146_wait_for_debi_done(saa) < 0)
 		return 0;
 
 	saa7146_write (saa, DEBI_COMMAND,
@@ -118,7 +63,7 @@
 	saa7146_write(saa, DEBI_CONFIG, config);
 	saa7146_write(saa, MC2, (2 << 16) | 2);
 
-	wait_for_debi_done(saa);
+	saa7146_wait_for_debi_done(saa);
 
 	result = saa7146_read(saa, DEBI_AD);
 	result &= (0xffffffffUL >> ((4 - count) * 8));
@@ -126,20 +71,6 @@
 	return result;
 }
 
-
-
-/* DEBI during interrupt */
-static inline u32 irdebi(struct saa7146_dev *saa, u32 config, int addr, u32 val, int count)
-{
-	u32 res;
-	res = debiread(saa, config, addr, count);
-	return res;
-}
-#endif
-
-
-
-
 /* from reading the following remotes:
    Zenith Universal 7 / TV Mode 807 / VCR Mode 837
    Hauppauge (from NOVA-CI-s box product)
@@ -150,7 +81,7 @@
 	KEY_0, KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_6, KEY_7, KEY_8,
 	KEY_9,
 	KEY_ENTER,
-	0,
+	KEY_RED,
 	KEY_POWER,              /* RADIO on Hauppauge */
 	KEY_MUTE,
 	0,
@@ -162,11 +93,11 @@
 	0, 0, 0, 0, 0, 0, 0,
 	KEY_UP, KEY_DOWN,
 	KEY_OPTION,             /* RESERVED on Hauppauge */
-	0,
+	KEY_BREAK,
 	/* 0x2X */
 	KEY_CHANNELUP, KEY_CHANNELDOWN,
 	KEY_PREVIOUS,           /* Prev. Ch on Zenith, SOURCE on Hauppauge */
-	0, 0, 0,
+	0, KEY_RESTART, KEY_OK,
 	KEY_CYCLEWINDOWS,       /* MINIMIZE on Hauppauge */
 	0,
 	KEY_ENTER,              /* VCR mode on Zenith */
@@ -177,7 +108,7 @@
 	KEY_MENU,               /* FULL SCREEN on Hauppauge */
 	0,
 	/* 0x3X */
-	0,
+	KEY_SLOW,
 	KEY_PREVIOUS,           /* VCR mode on Zenith */
 	KEY_REWIND,
 	0,
@@ -189,7 +120,7 @@
 	KEY_C,
 	0,
 	KEY_EXIT,
-	0,
+	KEY_POWER2,
 	KEY_TUNER,              /* VCR mode on Zenith */
 	0,
 };
@@ -217,7 +148,7 @@
 	struct budget_ci *budget_ci = (struct budget_ci*) data;
 	struct saa7146_dev *saa = budget_ci->budget.dev;
 	struct input_dev *dev = &budget_ci->input_dev;
-	unsigned int code = irdebi(saa, DEBINOSWAP, 0x1234, 0, 2) >> 8;
+	unsigned int code = budget_debiread4(saa, DEBINOSWAP, 0x1234, 2) >> 8;
 
 	if (code & 0x40) {
 	        code &= 0x3f;
@@ -271,7 +202,7 @@
 
 	saa7146_write(saa, IER, saa7146_read(saa, IER) | MASK_06);
 
-	gpio_set(saa, 3, GPIO_IRQHI);
+	saa7146_setgpio(saa, 3, SAA7146_GPIO_IRQHI); 
 
 	return 0;
 }
@@ -283,8 +214,8 @@
 	struct input_dev *dev = &budget_ci->input_dev;
 
 	saa7146_write(saa, IER, saa7146_read(saa, IER) & ~MASK_06);
-	gpio_set(saa, 3, GPIO_INPUT);
-	gpio_set(saa, 2, GPIO_INPUT);
+	saa7146_setgpio(saa, 3, SAA7146_GPIO_INPUT);
+	saa7146_setgpio(saa, 2, SAA7146_GPIO_INPUT);
 
 	if (del_timer(&dev->timer))
 		input_event(dev, EV_KEY, key_map[dev->repeat_key], !!0);
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/ttpci/budget.h linux-2.6.0-p/drivers/media/dvb/ttpci/budget.h
--- linux-2.6.0/drivers/media/dvb/ttpci/budget.h	2003-12-18 03:58:57.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/ttpci/budget.h	2003-11-03 20:08:11.000000000 +0100
@@ -64,8 +64,8 @@
 	.ext_priv = &x_var ## _info, \
 	.ext = &budget_extension };
 
-#define TS_WIDTH  (4*188)
-#define TS_HEIGHT (1024/4)
+#define TS_WIDTH  (376)
+#define TS_HEIGHT (512)
 #define TS_BUFLEN (TS_WIDTH*TS_HEIGHT)
 #define TS_MAX_PACKETS (TS_BUFLEN/TS_SIZE)
 
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/ttpci/ttpci-eeprom.c linux-2.6.0-p/drivers/media/dvb/ttpci/ttpci-eeprom.c
--- linux-2.6.0/drivers/media/dvb/ttpci/ttpci-eeprom.c	2003-12-18 03:59:05.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/ttpci/ttpci-eeprom.c	2003-11-05 16:42:47.000000000 +0100
@@ -142,3 +142,9 @@
 }
 
 EXPORT_SYMBOL(ttpci_eeprom_parse_mac);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ralph Metzler, Marcus Metzler, others");
+MODULE_DESCRIPTION("Decode dvb_net MAC address from EEPROM of PCI DVB cards "
+		"made by Siemens, Technotrend, Hauppauge");
+

