Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263865AbUDZNrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbUDZNrR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 09:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbUDZNph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 09:45:37 -0400
Received: from mail.convergence.de ([212.84.236.4]:37252 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261998AbUDZNlv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 09:41:51 -0400
To: hunold@linuxtv.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 3/9] DVB: Update DVB budget drivers
In-Reply-To: <10829867363017@convergence.de>
Message-Id: <10829867862196@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Mon, 26 Apr 2004 09:41:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] budget-av: patch by Kenneth Aafløy to add support for Typhoon DVB-S budget card
- [DVB] budget.c: support for Fujitsu-Siemens Activy Card
- [DVB] budget-ci: add preliminary CI support
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/ttpci/budget-av.c linux-2.6.5-patched/drivers/media/dvb/ttpci/budget-av.c
--- xx-linux-2.6.5/drivers/media/dvb/ttpci/budget-av.c	2004-03-12 20:31:29.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/ttpci/budget-av.c	2004-03-19 18:13:56.000000000 +0100
@@ -39,6 +39,7 @@
 	struct budget budget;
 	struct video_device vd;
 	int cur_input;
+	int has_saa7113;
 };
 
 /****************************************************************************
@@ -149,6 +150,9 @@
 {
 	struct budget *budget = &budget_av->budget;
 
+	if ( 1 != budget_av->has_saa7113 )
+		return -ENODEV;
+
 	if (input == 1) {
 		i2c_writereg(budget->i2c_bus, 0x4a, 0x02, 0xc7);
 		i2c_writereg(budget->i2c_bus, 0x4a, 0x09, 0x80);
@@ -170,11 +174,13 @@
 
 	DEB_EE(("dev: %p\n",dev));
 
+	if ( 1 == budget_av->has_saa7113 ) {
 	saa7146_setgpio(dev, 0, SAA7146_GPIO_OUTLO);
 
 	dvb_delay(200);
 
 	saa7146_unregister_device (&budget_av->vd, dev);
+	}
 
 	err = ttpci_budget_deinit (&budget_av->budget);
 
@@ -221,11 +227,8 @@
 	saa7146_setgpio(dev, 0, SAA7146_GPIO_OUTHI);
 	dvb_delay(500);
 
-	if ((err = saa7113_init (budget_av))) {
-		/* fixme: proper cleanup here */
-		ERR(("cannot init saa7113.\n"));
-		return err;
-	}
+	if ( 0 == saa7113_init(budget_av) ) {
+		budget_av->has_saa7113 = 1;
 
 	if ( 0 != saa7146_vv_init(dev,&vv_data)) {
 		/* fixme: proper cleanup here */
@@ -246,14 +249,12 @@
 					SAA7146_HPS_SYNC_PORT_A);
 
 	saa7113_setinput (budget_av, 0);
+	} else {
+		budget_av->has_saa7113 = 0;
 
-	/* what is this? since we don't support open()/close()
-	   notifications, we simply put this into the release handler... */
-/*
 	saa7146_setgpio(dev, 0, SAA7146_GPIO_OUTLO);
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout (20);
-*/
+	}
+
 	/* fixme: find some sane values here... */
 	saa7146_write(dev, PCI_BT_V1, 0x1c00101f);
 
@@ -333,13 +334,13 @@
 static struct saa7146_standard standard[] = {
 	{
 		.name	= "PAL", 	.id	= V4L2_STD_PAL,
-		.v_offset	= 0x17,	.v_field 	= 288,	.v_calc		= 576,
-		.h_offset	= 0x14,	.h_pixels 	= 680,	.h_calc		= 680+1,
-		.v_max_out	= 576,	.h_max_out	= 768,
+		.v_offset	= 0x17,	.v_field 	= 288,
+		.h_offset	= 0x14,	.h_pixels 	= 680,  	      
+		.v_max_out	= 576,	.h_max_out	= 768
 	}, {
 		.name	= "NTSC", 	.id	= V4L2_STD_NTSC,
-		.v_offset	= 0x16,	.v_field 	= 240,	.v_calc		= 480,
-		.h_offset	= 0x06,	.h_pixels 	= 708,	.h_calc		= 708+1,
+		.v_offset	= 0x16,	.v_field 	= 240,
+		.h_offset	= 0x06,	.h_pixels 	= 708,
 		.v_max_out	= 480,	.h_max_out	= 640,
 	}
 };
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/ttpci/budget.c linux-2.6.5-patched/drivers/media/dvb/ttpci/budget.c
--- xx-linux-2.6.5/drivers/media/dvb/ttpci/budget.c	2003-12-18 03:58:57.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/ttpci/budget.c	2004-02-27 14:45:59.000000000 +0100
@@ -8,6 +8,11 @@
  * Copyright (C) 1999-2002 Ralph  Metzler 
  *                       & Marcus Metzler for convergence integrated media GmbH
  *
+ * 26feb2004 Support for FS Activy Card (Grundig tuner) by
+ *           Michael Dreher <michael@5dot1.de>,
+ *           Oliver Endriss <o.endriss@gmx.de> and
+ *           Andreas 'randy' Weinberger
+ * 
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version 2
@@ -142,6 +147,49 @@
 }
 
 
+/*
+ *   Routines for the Fujitsu Siemens Activy budget card
+ *   22 kHz tone and DiSEqC are handled by the frontend.
+ *   Voltage must be set here.
+ */
+static int SetVoltage_Activy (struct budget *budget, fe_sec_voltage_t voltage)
+{
+	struct saa7146_dev *dev=budget->dev;
+
+	DEB_EE(("budget: %p\n",budget));
+
+	switch (voltage) {
+		case SEC_VOLTAGE_13:
+			saa7146_setgpio(dev, 2, SAA7146_GPIO_OUTLO);
+			break;
+		case SEC_VOLTAGE_18:
+			saa7146_setgpio(dev, 2, SAA7146_GPIO_OUTHI);
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+
+static int budget_ioctl_activy (struct dvb_frontend *fe, unsigned int cmd, void *arg)
+{
+	struct budget *budget = fe->before_after_data;
+
+	DEB_EE(("budget: %p\n",budget));
+
+	switch (cmd) {
+		case FE_SET_VOLTAGE:
+			return SetVoltage_Activy (budget, (fe_sec_voltage_t) arg);
+		default:
+			return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+
 static int budget_attach (struct saa7146_dev* dev, struct saa7146_pci_extension_data *info)
 {
 	struct budget *budget = NULL;
@@ -160,6 +208,10 @@
 		return err;
 	}
 
+	if (budget->card->type == BUDGET_FS_ACTIVY)
+		dvb_add_frontend_ioctls (budget->dvb_adapter,
+				 budget_ioctl_activy, NULL, budget);
+	else
 	dvb_add_frontend_ioctls (budget->dvb_adapter,
 				 budget_diseqc_ioctl, NULL, budget);
 
@@ -174,6 +226,10 @@
 	struct budget *budget = (struct budget*) dev->ext_priv;
 	int err;
 
+	if (budget->card->type == BUDGET_FS_ACTIVY)
+		dvb_remove_frontend_ioctls (budget->dvb_adapter,
+				    budget_ioctl_activy, NULL);
+	else
 	dvb_remove_frontend_ioctls (budget->dvb_adapter,
 				    budget_diseqc_ioctl, NULL);
 
@@ -193,6 +249,7 @@
 MAKE_BUDGET_INFO(ttbc,	"TT-Budget/WinTV-NOVA-C  PCI",	BUDGET_TT);
 MAKE_BUDGET_INFO(ttbt,	"TT-Budget/WinTV-NOVA-T  PCI",	BUDGET_TT);
 MAKE_BUDGET_INFO(satel,	"SATELCO Multimedia PCI",	BUDGET_TT_HW_DISEQC);
+MAKE_BUDGET_INFO(fsacs, "Fujitsu Siemens Activy Budget-S PCI", BUDGET_FS_ACTIVY);
 /* Uncomment for Budget Patch */
 /*MAKE_BUDGET_INFO(fs_1_3,"Siemens/Technotrend/Hauppauge PCI rev1.3+Budget_Patch", BUDGET_PATCH);*/
 
@@ -203,6 +260,7 @@
 	MAKE_EXTENSION_PCI(ttbc,  0x13c2, 0x1004),
 	MAKE_EXTENSION_PCI(ttbt,  0x13c2, 0x1005),
 	MAKE_EXTENSION_PCI(satel, 0x13c2, 0x1013),
+	MAKE_EXTENSION_PCI(fsacs, 0x1131, 0x4f61),
 	{
 		.vendor    = 0,
 	}
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/ttpci/budget-ci.c linux-2.6.5-patched/drivers/media/dvb/ttpci/budget-ci.c
--- xx-linux-2.6.5/drivers/media/dvb/ttpci/budget-ci.c	2004-01-16 18:25:17.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/ttpci/budget-ci.c	2004-04-21 01:23:32.000000000 +0200
@@ -6,6 +6,8 @@
  *     msp430 IR support contributed by Jack Thomasson <jkt@Helius.COM>
  *     partially based on the Siemens DVB driver by Ralph+Marcus Metzler
  *
+ * CI interface support (c) 2004 Andrew de Quincey <adq_dvb@lidskialf.net>
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version 2
@@ -34,22 +36,59 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
+#include <linux/spinlock.h>
+
+#include "dvb_functions.h"
+#include "dvb_ca_en50221.h"
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
+#include "input_fake.h"
+#endif
+
+#define DEBIADDR_IR		0x1234
+#define DEBIADDR_CICONTROL	0x0000
+#define DEBIADDR_CIVERSION	0x4000
+#define DEBIADDR_IO		0x1000
+#define DEBIADDR_ATTR		0x3000
+
+#define CICONTROL_RESET		0x01
+#define CICONTROL_ENABLETS	0x02
+#define CICONTROL_CAMDETECT	0x08
+
+#define DEBICICTL		0x00420000
+#define DEBICICAM		0x02420000
+
+#define SLOTSTATUS_NONE		1
+#define SLOTSTATUS_PRESENT	2
+#define SLOTSTATUS_RESET	4
+#define SLOTSTATUS_READY	8
+#define SLOTSTATUS_OCCUPIED	(SLOTSTATUS_PRESENT|SLOTSTATUS_RESET|SLOTSTATUS_READY)
 
 struct budget_ci {
 	struct budget budget;
 	struct input_dev input_dev;
 	struct tasklet_struct msp430_irq_tasklet;
+	struct tasklet_struct ciintf_irq_tasklet;
+	spinlock_t debilock;
+	int slot_status;
+	struct dvb_ca_en50221 ca;
+	char ir_dev_name[50];
 };
 
-static u32 budget_debiread4 (struct saa7146_dev *saa, u32 config, int addr, int count)
+static u32 budget_debiread (struct budget_ci* budget_ci, u32 config, int addr, int count)
 {
+	struct saa7146_dev *saa = budget_ci->budget.dev;
 	u32 result = 0;
 
 	if (count > 4 || count <= 0)
 		return 0;
 
-	if (saa7146_wait_for_debi_done(saa) < 0)
+	spin_lock(&budget_ci->debilock);
+
+	if (saa7146_wait_for_debi_done(saa) < 0) {
+		spin_unlock(&budget_ci->debilock);
 		return 0;
+	}
 
 	saa7146_write (saa, DEBI_COMMAND,
 		       (count << 17) | 0x10000 | (addr & 0xffff));
@@ -53,18 +92,47 @@
 
 	saa7146_write (saa, DEBI_COMMAND,
 		       (count << 17) | 0x10000 | (addr & 0xffff));
-
 	saa7146_write(saa, DEBI_CONFIG, config);
+	saa7146_write(saa, DEBI_PAGE, 0);
 	saa7146_write(saa, MC2, (2 << 16) | 2);
 
 	saa7146_wait_for_debi_done(saa);
 
-	result = saa7146_read(saa, DEBI_AD);
+	result = saa7146_read(saa, 0x88);
 	result &= (0xffffffffUL >> ((4 - count) * 8));
 
+	spin_unlock(&budget_ci->debilock);
 	return result;
 }
 
+static u8 budget_debiwrite (struct budget_ci* budget_ci, u32 config, int addr, int count, u32 value)
+{
+	struct saa7146_dev *saa = budget_ci->budget.dev;
+
+	if (count > 4 || count <= 0)
+		return 0;
+
+	spin_lock(&budget_ci->debilock);
+
+	if (saa7146_wait_for_debi_done(saa) < 0) {
+		spin_unlock(&budget_ci->debilock);
+		return 0;
+	}
+
+	saa7146_write (saa, DEBI_COMMAND,
+		       (count << 17) | 0x00000 | (addr & 0xffff));
+	saa7146_write(saa, DEBI_CONFIG, config);
+	saa7146_write(saa, DEBI_PAGE, 0);
+	saa7146_write(saa, DEBI_AD, value);
+	saa7146_write(saa, MC2, (2 << 16) | 2);
+
+	saa7146_wait_for_debi_done(saa);
+
+	spin_unlock(&budget_ci->debilock);
+	return 0;
+}
+
+
 /* from reading the following remotes:
    Zenith Universal 7 / TV Mode 807 / VCR Mode 837
    Hauppauge (from NOVA-CI-s box product)
@@ -140,9 +208,8 @@
 static void msp430_ir_interrupt (unsigned long data)
 {
 	struct budget_ci *budget_ci = (struct budget_ci*) data;
-	struct saa7146_dev *saa = budget_ci->budget.dev;
 	struct input_dev *dev = &budget_ci->input_dev;
-	unsigned int code = budget_debiread4(saa, DEBINOSWAP, 0x1234, 2) >> 8;
+	unsigned int code = budget_debiread(budget_ci, DEBINOSWAP, DEBIADDR_IR, 2) >> 8;
 
 	if (code & 0x40) {
 	        code &= 0x3f;
@@ -182,7 +249,8 @@
 
 	memset(&budget_ci->input_dev, 0, sizeof(struct input_dev));
 
-	budget_ci->input_dev.name = saa->name;
+	sprintf (budget_ci->ir_dev_name, "Budget-CI dvb ir receiver %s", saa->name);
+	budget_ci->input_dev.name = budget_ci->ir_dev_name;
 
 	set_bit(EV_KEY, budget_ci->input_dev.evbit);
 
@@ -209,7 +277,6 @@
 
 	saa7146_write(saa, IER, saa7146_read(saa, IER) & ~MASK_06);
 	saa7146_setgpio(saa, 3, SAA7146_GPIO_INPUT);
-	saa7146_setgpio(saa, 2, SAA7146_GPIO_INPUT);
 
 	if (del_timer(&dev->timer))
 		input_event(dev, EV_KEY, key_map[dev->repeat_key], !!0);
@@ -217,6 +284,209 @@
 	input_unregister_device(dev);
 }
 
+static int ciintf_read_attribute_mem(struct dvb_ca_en50221* ca, int slot, int address) {
+	struct budget_ci* budget_ci = (struct budget_ci*) ca->data;
+
+	if (slot != 0) return -EINVAL;
+
+	return budget_debiread(budget_ci, DEBICICAM, DEBIADDR_ATTR | (address & 0xfff), 1);
+}
+
+static int ciintf_write_attribute_mem(struct dvb_ca_en50221* ca, int slot, int address, u8 value) {
+	struct budget_ci* budget_ci = (struct budget_ci*) ca->data;
+
+	if (slot != 0) return -EINVAL;
+
+	return budget_debiwrite(budget_ci, DEBICICAM, DEBIADDR_ATTR | (address & 0xfff), 1, value);
+}
+
+static int ciintf_read_cam_control(struct dvb_ca_en50221* ca, int slot, u8 address) {
+	struct budget_ci* budget_ci = (struct budget_ci*) ca->data;
+
+	if (slot != 0) return -EINVAL;
+
+	return budget_debiread(budget_ci, DEBICICAM, DEBIADDR_IO | (address & 3), 1);
+}
+
+static int ciintf_write_cam_control(struct dvb_ca_en50221* ca, int slot, u8 address, u8 value) {
+	struct budget_ci* budget_ci = (struct budget_ci*) ca->data;
+
+	if (slot != 0) return -EINVAL;
+
+	return budget_debiwrite(budget_ci, DEBICICAM, DEBIADDR_IO | (address & 3), 1, value);
+}
+
+static int ciintf_slot_reset(struct dvb_ca_en50221* ca, int slot) {
+	struct budget_ci* budget_ci = (struct budget_ci*) ca->data;
+	struct saa7146_dev *saa = budget_ci->budget.dev;
+
+	if (slot != 0) return -EINVAL;
+
+	// trigger on RISING edge during reset so we know when READY is re-asserted
+	saa7146_setgpio(saa, 0, SAA7146_GPIO_IRQHI);
+	budget_ci->slot_status = SLOTSTATUS_RESET;
+	budget_debiwrite(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1, 0);
+	dvb_delay(1);
+	budget_debiwrite(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1, CICONTROL_RESET);
+
+	saa7146_setgpio(saa, 1, SAA7146_GPIO_OUTHI);
+   	ttpci_budget_set_video_port(saa, BUDGET_VIDEO_PORTB);
+	return 0;
+}
+
+static int ciintf_slot_shutdown(struct dvb_ca_en50221* ca, int slot) {
+   	struct budget_ci* budget_ci = (struct budget_ci*) ca->data;
+	struct saa7146_dev *saa = budget_ci->budget.dev;
+
+	if (slot != 0) return -EINVAL;
+
+	saa7146_setgpio(saa, 1, SAA7146_GPIO_OUTHI);
+	ttpci_budget_set_video_port(saa, BUDGET_VIDEO_PORTB);
+	return 0;
+}
+
+static int ciintf_slot_ts_enable(struct dvb_ca_en50221* ca, int slot) {
+	struct budget_ci* budget_ci = (struct budget_ci*) ca->data;
+	struct saa7146_dev *saa = budget_ci->budget.dev;
+	int tmp;
+
+	if (slot != 0) return -EINVAL;
+
+
+	saa7146_setgpio(saa, 1, SAA7146_GPIO_OUTLO);
+
+	tmp = budget_debiread(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1);
+	budget_debiwrite(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1, tmp | CICONTROL_ENABLETS);
+
+   	ttpci_budget_set_video_port(saa, BUDGET_VIDEO_PORTA);
+	return 0;
+}
+
+
+static void ciintf_interrupt (unsigned long data)
+{
+	struct budget_ci *budget_ci = (struct budget_ci*) data;
+	struct saa7146_dev *saa = budget_ci->budget.dev;
+	unsigned int flags;
+
+	// ensure we don't get spurious IRQs during initialisation
+	if (!budget_ci->budget.ci_present) return;
+
+	flags = budget_debiread(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1);
+
+	// always set the GPIO mode back to "normal", in case the card is
+	// yanked at an inopportune moment
+	saa7146_setgpio(saa, 0, SAA7146_GPIO_IRQLO);
+
+	if (flags & CICONTROL_CAMDETECT) {
+
+		if (budget_ci->slot_status & SLOTSTATUS_NONE) {
+			// CAM insertion IRQ
+			budget_ci->slot_status = SLOTSTATUS_PRESENT;
+			dvb_ca_en50221_camchange_irq(&budget_ci->ca, 0, DVB_CA_EN50221_CAMCHANGE_INSERTED);
+
+		} else if (budget_ci->slot_status & SLOTSTATUS_RESET) {
+			// CAM ready (reset completed)
+			budget_ci->slot_status = SLOTSTATUS_READY;
+			dvb_ca_en50221_camready_irq(&budget_ci->ca, 0);
+
+		} else if (budget_ci->slot_status & SLOTSTATUS_READY) {
+			// FR/DA IRQ
+			dvb_ca_en50221_frda_irq(&budget_ci->ca, 0);
+		}
+	} else {
+		if (budget_ci->slot_status & SLOTSTATUS_OCCUPIED) {
+			budget_ci->slot_status = SLOTSTATUS_NONE;
+			dvb_ca_en50221_camchange_irq(&budget_ci->ca, 0, DVB_CA_EN50221_CAMCHANGE_REMOVED);
+		}
+	}
+}
+
+static int ciintf_init(struct budget_ci* budget_ci)
+{
+	struct saa7146_dev *saa = budget_ci->budget.dev;
+	int flags;
+	int result;
+
+	memset(&budget_ci->ca, 0, sizeof(struct dvb_ca_en50221));
+
+	// enable DEBI pins
+	saa7146_write(saa, MC1, saa7146_read(saa, MC1) | (0x800 << 16) | 0x800);
+
+	// test if it is there
+	if ((budget_debiread(budget_ci, DEBICICTL, DEBIADDR_CIVERSION, 1) & 0xa0) != 0xa0) {
+		result = -ENODEV;
+		goto error;
+	}
+
+	// determine whether a CAM is present or not
+	flags = budget_debiread(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1);
+	budget_ci->slot_status = SLOTSTATUS_NONE;
+	if (flags & CICONTROL_CAMDETECT) budget_ci->slot_status = SLOTSTATUS_PRESENT;
+
+
+	// register CI interface
+	budget_ci->ca.read_attribute_mem = ciintf_read_attribute_mem;
+	budget_ci->ca.write_attribute_mem = ciintf_write_attribute_mem;
+	budget_ci->ca.read_cam_control = ciintf_read_cam_control;
+	budget_ci->ca.write_cam_control = ciintf_write_cam_control;
+	budget_ci->ca.slot_reset = ciintf_slot_reset;
+	budget_ci->ca.slot_shutdown = ciintf_slot_shutdown;
+	budget_ci->ca.slot_ts_enable = ciintf_slot_ts_enable;
+	budget_ci->ca.data = budget_ci;
+	if ((result = dvb_ca_en50221_init(budget_ci->budget.dvb_adapter,
+					  &budget_ci->ca,
+					  DVB_CA_EN50221_FLAG_IRQ_CAMCHANGE |
+					  DVB_CA_EN50221_FLAG_IRQ_FR |
+					  DVB_CA_EN50221_FLAG_IRQ_DA,
+				  1)) != 0) {
+		printk("budget_ci: CI interface detected, but initialisation failed.\n");
+		goto error;
+	}
+
+	// Setup CI slot IRQ
+	tasklet_init (&budget_ci->ciintf_irq_tasklet, ciintf_interrupt, (unsigned long) budget_ci);
+	saa7146_setgpio(saa, 0, SAA7146_GPIO_IRQLO);
+	saa7146_write(saa, IER, saa7146_read(saa, IER) | MASK_03);
+	budget_debiwrite(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1, CICONTROL_RESET);
+
+	// success!
+	printk("budget_ci: CI interface initialised\n");
+	budget_ci->budget.ci_present = 1;
+
+	// forge a fake CI IRQ so the CAM state is setup correctly
+	flags = DVB_CA_EN50221_CAMCHANGE_REMOVED;
+	if (budget_ci->slot_status != SLOTSTATUS_NONE) flags = DVB_CA_EN50221_CAMCHANGE_INSERTED;
+	dvb_ca_en50221_camchange_irq(&budget_ci->ca, 0, flags);
+
+	return 0;
+
+error:
+	saa7146_write(saa, MC1, saa7146_read(saa, MC1) | (0x800 << 16));
+	return result;
+}
+
+static void ciintf_deinit(struct budget_ci* budget_ci)
+{
+	struct saa7146_dev *saa = budget_ci->budget.dev;
+
+	// disable CI interrupts
+	saa7146_write(saa, IER, saa7146_read(saa, IER) & ~MASK_03);
+	saa7146_setgpio(saa, 0, SAA7146_GPIO_INPUT);
+	tasklet_kill(&budget_ci->ciintf_irq_tasklet);
+	budget_debiwrite(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1, 0);
+	dvb_delay(1);
+	budget_debiwrite(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1, CICONTROL_RESET);
+
+	// disable TS data stream to CI interface
+	saa7146_setgpio(saa, 1, SAA7146_GPIO_INPUT);
+
+	// release the CA device
+	dvb_ca_en50221_release(&budget_ci->ca);
+
+	// disable DEBI pins
+	saa7146_write(saa, MC1, saa7146_read(saa, MC1) | (0x800 << 16));
+}
 
 static void budget_ci_irq (struct saa7146_dev *dev, u32 *isr)
 {
@@ -229,6 +499,9 @@
 
         if (*isr & MASK_10)
 		ttpci_budget_irq10_handler (dev, isr);
+
+	if ((*isr & MASK_03) && (budget_ci->budget.ci_present))
+		tasklet_schedule (&budget_ci->ciintf_irq_tasklet);
 }
 
 
@@ -244,6 +517,9 @@
 
 	DEB_EE(("budget_ci: %p\n", budget_ci));
 
+	spin_lock_init(&budget_ci->debilock);
+	budget_ci->budget.ci_present = 0;
+
 	if ((err = ttpci_budget_init (&budget_ci->budget, dev, info))) {
 		kfree (budget_ci);
 		return err;
@@ -256,6 +532,9 @@
 
 	msp430_ir_init (budget_ci);
 
+	// UNCOMMENT TO TEST CI INTERFACE
+//	ciintf_init(budget_ci);
+
 	return 0;
 }
 
@@ -264,14 +543,20 @@
 static int budget_ci_detach (struct saa7146_dev* dev)
 {
 	struct budget_ci *budget_ci = (struct budget_ci*) dev->ext_priv;
+	struct saa7146_dev *saa = budget_ci->budget.dev;
 	int err;
 
+	if (budget_ci->budget.ci_present) ciintf_deinit(budget_ci);
+
 	err = ttpci_budget_deinit (&budget_ci->budget);
 
 	tasklet_kill (&budget_ci->msp430_irq_tasklet);
 
 	msp430_ir_deinit (budget_ci);
 
+	// disable frontend and CI interface
+	saa7146_setgpio(saa, 2, SAA7146_GPIO_INPUT);
+
 	kfree (budget_ci);
 
 	return err;
@@ -304,7 +589,7 @@
 	.attach		= budget_ci_attach,
 	.detach		= budget_ci_detach,
 
-	.irq_mask	= MASK_06 | MASK_10,
+	.irq_mask	= MASK_03 | MASK_06 | MASK_10,
 	.irq_func	= budget_ci_irq,
 };	
 
@@ -325,7 +610,7 @@
 module_exit(budget_ci_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Michael Hunold, Jack Thomasson, others");
+MODULE_AUTHOR("Michael Hunold, Jack Thomasson, Andrew de Quincey, others");
 MODULE_DESCRIPTION("driver for the SAA7146 based so-called "
 		   "budget PCI DVB cards w/ CI-module produced by "
 		   "Siemens, Technotrend, Hauppauge");
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/ttpci/budget-core.c linux-2.6.5-patched/drivers/media/dvb/ttpci/budget-core.c
--- xx-linux-2.6.5/drivers/media/dvb/ttpci/budget-core.c	2003-12-18 03:58:39.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/ttpci/budget-core.c	2004-04-21 01:23:32.000000000 +0200
@@ -1,3 +1,39 @@
+/*
+ * budget-core.c: driver for the SAA7146 based Budget DVB cards
+ *
+ * Compiled from various sources by Michael Hunold <michael@mihu.de>
+ *
+ * Copyright (C) 2002 Ralph Metzler <rjkm@metzlerbros.de>
+ *
+ * Copyright (C) 1999-2002 Ralph  Metzler
+ *			 & Marcus Metzler for convergence integrated media GmbH
+ *
+ * 26feb2004 Support for FS Activy Card (Grundig tuner) by
+ *	     Michael Dreher <michael@5dot1.de>,
+ *	     Oliver Endriss <o.endriss@gmx.de>,
+ *	     Andreas 'randy' Weinberger
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ * Or, point your browser to http://www.gnu.org/copyleft/gpl.html
+ *
+ *
+ * the project's page is at http://www.linuxtv.org/dvb/
+ */
+
 #include "budget.h"
 #include "ttpci-eeprom.h"
 
@@ -38,10 +74,33 @@
 
         budget->tsf=0xff;
         budget->ttbp=0;
+
+	/*
+	 *  Signal path on the Activy:
+	 *
+	 *  tuner -> SAA7146 port A -> SAA7146 BRS -> SAA7146 DMA3 -> memory
+	 *
+	 *  Since the tuner feeds 204 bytes packets into the SAA7146,
+	 *  DMA3 is configured to strip the trailing 16 FEC bytes:
+	 *	Pitch: 188, NumBytes3: 188, NumLines3: 1024
+	 */
+
+	if (budget->card->type == BUDGET_FS_ACTIVY) {
+		saa7146_write(dev, DD1_INIT, 0x04000000);
+		saa7146_write(dev, MC2, (MASK_09 | MASK_25));
+		saa7146_write(dev, BRS_CTRL, 0x00000000);
+	} else {
+		if (budget->video_port == BUDGET_VIDEO_PORTA) {
+			saa7146_write(dev, DD1_INIT, 0x06000200);
+			saa7146_write(dev, MC2, (MASK_09 | MASK_25 | MASK_10 | MASK_26));
+			saa7146_write(dev, BRS_CTRL, 0x00000000);
+		} else {
         saa7146_write(dev, DD1_INIT, 0x02000600);
         saa7146_write(dev, MC2, (MASK_09 | MASK_25 | MASK_10 | MASK_26));
-
         saa7146_write(dev, BRS_CTRL, 0x60000000);	
+		}
+	}
+
       	saa7146_write(dev, MC2, (MASK_08 | MASK_24));
         mdelay(10);
 
@@ -49,9 +108,15 @@
         saa7146_write(dev, BASE_EVEN3, 0);
         saa7146_write(dev, PROT_ADDR3, TS_WIDTH*TS_HEIGHT);	
         saa7146_write(dev, BASE_PAGE3, budget->pt.dma |ME1|0x90);
-        saa7146_write(dev, PITCH3, TS_WIDTH);
 
+	if (budget->card->type == BUDGET_FS_ACTIVY) {
+		saa7146_write(dev, PITCH3, TS_WIDTH/2);
+		saa7146_write(dev, NUM_LINE_BYTE3, ((TS_HEIGHT*2)<<16)|(TS_WIDTH/2));
+	} else {
+		saa7146_write(dev, PITCH3, TS_WIDTH);
         saa7146_write(dev, NUM_LINE_BYTE3, (TS_HEIGHT<<16)|TS_WIDTH);
+	}
+
       	saa7146_write(dev, MC2, (MASK_04 | MASK_20));
      	saa7146_write(dev, MC1, (MASK_04 | MASK_20)); // DMA3 on
 
@@ -99,23 +164,31 @@
 {
         struct dvb_demux *demux = feed->demux;
         struct budget *budget = (struct budget*) demux->priv;
+	int status;
 
 	DEB_EE(("budget: %p\n",budget));
 
         if (!demux->dmx.frontend)
                 return -EINVAL;
 
-	return start_ts_capture (budget); 
+   	spin_lock(&budget->feedlock);   
+	status = start_ts_capture (budget);
+   	spin_unlock(&budget->feedlock);
+	return status;
 }
 
 static int budget_stop_feed(struct dvb_demux_feed *feed)
 {
         struct dvb_demux *demux = feed->demux;
         struct budget *budget = (struct budget *) demux->priv;
+	int status;
 
 	DEB_EE(("budget: %p\n",budget));
 
-	return stop_ts_capture (budget); 
+   	spin_lock(&budget->feedlock);
+	status = stop_ts_capture (budget);
+   	spin_unlock(&budget->feedlock);
+	return status;
 }
 
 
@@ -208,18 +281,27 @@
 	budget->card = bi;
 	budget->dev = (struct saa7146_dev *) dev;
 
-	dvb_register_adapter(&budget->dvb_adapter, budget->card->name);
+	dvb_register_adapter(&budget->dvb_adapter, budget->card->name, THIS_MODULE);
 
 	/* set dd1 stream a & b */
       	saa7146_write(dev, DD1_STREAM_B, 0x00000000);
+	saa7146_write(dev, MC2, (MASK_09 | MASK_25));
+	saa7146_write(dev, MC2, (MASK_10 | MASK_26));
 	saa7146_write(dev, DD1_INIT, 0x02000000);
 	saa7146_write(dev, MC2, (MASK_09 | MASK_25 | MASK_10 | MASK_26));
 
+       	if (bi->type != BUDGET_FS_ACTIVY)
+		budget->video_port = BUDGET_VIDEO_PORTB;
+	else
+		budget->video_port = BUDGET_VIDEO_PORTA;
+	spin_lock_init(&budget->feedlock);
+
 	/* the Siemens DVB needs this if you want to have the i2c chips
            get recognized before the main driver is loaded */
-        saa7146_write(dev, GPIO_CTRL, 0x500000);
+	if (bi->type != BUDGET_FS_ACTIVY)
+		saa7146_write(dev, GPIO_CTRL, 0x500000); /* GPIO 3 = 1 */
 	
-	saa7146_i2c_adapter_prepare(dev, NULL, SAA7146_I2C_BUS_BIT_RATE_120);
+	saa7146_i2c_adapter_prepare(dev, NULL, 0, SAA7146_I2C_BUS_BIT_RATE_120);
 
 	budget->i2c_bus = dvb_register_i2c_bus (master_xfer, dev,
 						budget->dvb_adapter, 0);
@@ -242,7 +324,11 @@
 
 	tasklet_init (&budget->vpe_tasklet, vpeirq, (unsigned long) budget);
 
-	saa7146_setgpio(dev, 2, SAA7146_GPIO_OUTHI); /* frontend power on */
+	/* frontend power on */
+	if (bi->type == BUDGET_FS_ACTIVY)
+		saa7146_setgpio(dev, 1, SAA7146_GPIO_OUTHI);
+	else
+		saa7146_setgpio(dev, 2, SAA7146_GPIO_OUTHI);
 
         if (budget_register(budget) == 0) {
 		return 0;
@@ -292,10 +378,28 @@
 		tasklet_schedule (&budget->vpe_tasklet);
 }
 
+void ttpci_budget_set_video_port(struct saa7146_dev* dev, int video_port)
+{
+	struct budget *budget = (struct budget*)dev->ext_priv;
+
+	spin_lock(&budget->feedlock);
+	budget->video_port = video_port;
+	if (budget->feeding) {
+		int oldfeeding = budget->feeding;
+	   	budget->feeding = 1;
+		stop_ts_capture(budget);
+		start_ts_capture(budget);
+	   	budget->feeding = oldfeeding;
+	}
+   	spin_unlock(&budget->feedlock);
+}
+
+
 
 EXPORT_SYMBOL_GPL(ttpci_budget_init);
 EXPORT_SYMBOL_GPL(ttpci_budget_deinit);
 EXPORT_SYMBOL_GPL(ttpci_budget_irq10_handler);
+EXPORT_SYMBOL_GPL(ttpci_budget_set_video_port);
 EXPORT_SYMBOL_GPL(budget_debug);
 
 MODULE_PARM(budget_debug,"i");
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/ttpci/budget.h linux-2.6.5-patched/drivers/media/dvb/ttpci/budget.h
--- xx-linux-2.6.5/drivers/media/dvb/ttpci/budget.h	2004-01-16 18:25:17.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/ttpci/budget.h	2004-04-21 01:23:32.000000000 +0200
@@ -46,10 +46,15 @@
         int                     fe_synced; 
         struct semaphore        pid_mutex;
 
+	int                     ci_present;
+        int                     video_port;
+
         u8 tsf;
         u32 ttbp;
         int feeding;
 
+	spinlock_t feedlock;
+
         struct dvb_adapter       *dvb_adapter;
 	void			 *priv;
 };
@@ -73,13 +78,17 @@
 #define BUDGET_TT_HW_DISEQC	   1
 #define BUDGET_KNC1		   2
 #define BUDGET_PATCH		   3
+#define BUDGET_FS_ACTIVY	   4
 
+#define BUDGET_VIDEO_PORTA         0
+#define BUDGET_VIDEO_PORTB         1
 
 extern int ttpci_budget_init (struct budget *budget,
 			      struct saa7146_dev* dev,
 			      struct saa7146_pci_extension_data *info);
 extern int ttpci_budget_deinit (struct budget *budget);
 extern void ttpci_budget_irq10_handler (struct saa7146_dev* dev, u32 *isr);
+extern void ttpci_budget_set_video_port(struct saa7146_dev* dev, int video_port);
 
 #endif
 


