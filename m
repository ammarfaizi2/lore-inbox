Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbTADDJf>; Fri, 3 Jan 2003 22:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265872AbTADDJf>; Fri, 3 Jan 2003 22:09:35 -0500
Received: from dclient217-162-80-86.hispeed.ch ([217.162.80.86]:53386 "EHLO
	gamecube.hb9jnx.ampr.org") by vger.kernel.org with ESMTP
	id <S265863AbTADDJc>; Fri, 3 Jan 2003 22:09:32 -0500
Subject: [PATCH]: 2.5.54: fix oopsable bug in OSS PCI sound drivers
From: Thomas Sailer <sailer@scs.ch>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Jan 2003 04:18:21 +0100
Message-Id: <1041650301.9390.17.camel@gamecube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes an oopsable (according to a few reports) bug
in the multiple open exclusion logic in my sound drivers and a driver
derived from my code. If you intend to keep the OSS drivers for 2.6,
please apply.

Tom

--- sound/oss/es1370.c.orig	2003-01-02 04:23:16.000000000 +0100
+++ sound/oss/es1370.c	2003-01-03 22:41:49.000000000 +0100
@@ -3,7 +3,7 @@
 /*
  *      es1370.c  --  Ensoniq ES1370/Asahi Kasei AK4531 audio driver.
  *
- *      Copyright (C) 1998-2001  Thomas Sailer (t.sailer@alumni.ethz.ch)
+ *      Copyright (C) 1998-2001, 2003  Thomas Sailer (t.sailer@alumni.ethz.ch)
  *
  *      This program is free software; you can redistribute it and/or modify
  *      it under the terms of the GNU General Public License as published by
@@ -117,6 +117,7 @@
  *    07.01.2001   0.36  Timeout change in wrcodec as requested by Frank Klemm <pfk@fuchs.offl.uni-jena.de>
  *    31.01.2001   0.37  Register/Unregister gameport
  *                       Fix SETTRIGGER non OSS API conformity
+ *    03.01.2003   0.38  open_mode fixes from Georg Acher <acher@in.tum.de>
  *
  * some important things missing in Ensoniq documentation:
  *
@@ -1807,7 +1808,7 @@
 		stop_adc(s);
 		dealloc_dmabuf(s, &s->dma_adc);
 	}
-	s->open_mode &= (~file->f_mode) & (FMODE_READ|FMODE_WRITE);
+	s->open_mode &= ~(file->f_mode & (FMODE_READ|FMODE_WRITE));
 	wake_up(&s->open_wait);
 	up(&s->open_sem);
 	unlock_kernel();
@@ -2498,7 +2499,7 @@
 		set_current_state(TASK_RUNNING);
 	}
 	down(&s->open_sem);
-	s->open_mode &= (~(file->f_mode << FMODE_MIDI_SHIFT)) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE);
+	s->open_mode &= ~((file->f_mode << FMODE_MIDI_SHIFT) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE));
 	spin_lock_irqsave(&s->lock, flags);
 	if (!(s->open_mode & (FMODE_MIDI_READ | FMODE_MIDI_WRITE))) {
 		s->ctrl &= ~CTRL_UART_EN;
@@ -2740,7 +2741,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "es1370: version v0.37 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "es1370: version v0.38 time " __TIME__ " " __DATE__ "\n");
 	return pci_module_init(&es1370_driver);
 }
 
--- sound/oss/es1371.c.orig	2003-01-03 22:24:47.000000000 +0100
+++ sound/oss/es1371.c	2003-01-03 22:31:53.000000000 +0100
@@ -3,7 +3,7 @@
 /*
  *      es1371.c  --  Creative Ensoniq ES1371.
  *
- *      Copyright (C) 1998-2001  Thomas Sailer (t.sailer@alumni.ethz.ch)
+ *      Copyright (C) 1998-2001, 2003  Thomas Sailer (t.sailer@alumni.ethz.ch)
  *
  *      This program is free software; you can redistribute it and/or modify
  *      it under the terms of the GNU General Public License as published by
@@ -104,6 +104,7 @@
  *    31.01.2001   0.30  Register/Unregister gameport
  *                       Fix SETTRIGGER non OSS API conformity
  *    14.07.2001   0.31  Add list of laptops needing amplifier control
+ *    03.01.2003   0.32  open_mode fixes from Georg Acher <acher@in.tum.de>
  */
 
 /*****************************************************************************/
@@ -1995,7 +1996,7 @@
 		stop_adc(s);
 		dealloc_dmabuf(s, &s->dma_adc);
 	}
-	s->open_mode &= (~file->f_mode) & (FMODE_READ|FMODE_WRITE);
+	s->open_mode &= ~(file->f_mode & (FMODE_READ|FMODE_WRITE));
 	up(&s->open_sem);
 	wake_up(&s->open_wait);
 	unlock_kernel();
@@ -2675,7 +2676,7 @@
 		set_current_state(TASK_RUNNING);
 	}
 	down(&s->open_sem);
-	s->open_mode &= (~(file->f_mode << FMODE_MIDI_SHIFT)) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE);
+	s->open_mode &= ~((file->f_mode << FMODE_MIDI_SHIFT) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE));
 	spin_lock_irqsave(&s->lock, flags);
 	if (!(s->open_mode & (FMODE_MIDI_READ | FMODE_MIDI_WRITE))) {
 		s->ctrl &= ~CTRL_UART_EN;
@@ -3044,7 +3045,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO PFX "version v0.30 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO PFX "version v0.32 time " __TIME__ " " __DATE__ "\n");
 	return pci_module_init(&es1371_driver);
 }
 
--- sound/oss/esssolo1.c.orig	2003-01-02 04:21:09.000000000 +0100
+++ sound/oss/esssolo1.c	2003-01-03 22:40:43.000000000 +0100
@@ -3,7 +3,7 @@
 /*
  *      esssolo1.c  --  ESS Technology Solo1 (ES1946) audio driver.
  *
- *      Copyright (C) 1998-2001  Thomas Sailer (t.sailer@alumni.ethz.ch)
+ *      Copyright (C) 1998-2001, 2003  Thomas Sailer (t.sailer@alumni.ethz.ch)
  *
  *      This program is free software; you can redistribute it and/or modify
  *      it under the terms of the GNU General Public License as published by
@@ -82,6 +82,7 @@
  *    22.05.2001   0.19  more cleanups, changed PM to PCI 2.4 style, got rid
  *                       of global list of devices, using pci device data.
  *                       Marcus Meissner <mm@caldera.de>
+ *    03.01.2003   0.20  open_mode fixes from Georg Acher <acher@in.tum.de>
  */
 
 /*****************************************************************************/
@@ -1986,7 +1987,7 @@
 		set_current_state(TASK_RUNNING);
 	}
 	down(&s->open_sem);
-	s->open_mode &= (~(file->f_mode << FMODE_MIDI_SHIFT)) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE);
+	s->open_mode &= ~((file->f_mode << FMODE_MIDI_SHIFT) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE));
 	spin_lock_irqsave(&s->lock, flags);
 	if (!(s->open_mode & (FMODE_MIDI_READ | FMODE_MIDI_WRITE))) {
 		outb(0x30, s->iobase + 7); /* enable A1, A2 irq's */
@@ -2461,7 +2462,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "solo1: version v0.19 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "solo1: version v0.20 time " __TIME__ " " __DATE__ "\n");
 	if (!pci_register_driver(&solo1_driver)) {
 		pci_unregister_driver(&solo1_driver);
                 return -ENODEV;
--- sound/oss/sonicvibes.c.orig	2003-01-02 04:21:53.000000000 +0100
+++ sound/oss/sonicvibes.c	2003-01-03 22:44:52.000000000 +0100
@@ -3,7 +3,7 @@
 /*
  *      sonicvibes.c  --  S3 Sonic Vibes audio driver.
  *
- *      Copyright (C) 1998-2001  Thomas Sailer (t.sailer@alumni.ethz.ch)
+ *      Copyright (C) 1998-2001, 2003  Thomas Sailer (t.sailer@alumni.ethz.ch)
  *
  *      This program is free software; you can redistribute it and/or modify
  *      it under the terms of the GNU General Public License as published by
@@ -94,6 +94,7 @@
  *                       Fix SETTRIGGER non OSS API conformity
  *    18.05.2001   0.30  PCI probing and error values cleaned up by Marcus
  *                       Meissner <mm@caldera.de>
+ *    03.01.2003   0.31  open_mode fixes from Georg Acher <acher@in.tum.de>
  *
  */
 
@@ -1969,7 +1970,7 @@
 		stop_adc(s);
 		dealloc_dmabuf(s, &s->dma_adc);
 	}
-	s->open_mode &= (~file->f_mode) & (FMODE_READ|FMODE_WRITE);
+	s->open_mode &= ~(file->f_mode & (FMODE_READ|FMODE_WRITE));
 	wake_up(&s->open_wait);
 	up(&s->open_sem);
 	unlock_kernel();
@@ -2245,7 +2246,7 @@
 		set_current_state(TASK_RUNNING);
 	}
 	down(&s->open_sem);
-	s->open_mode &= (~(file->f_mode << FMODE_MIDI_SHIFT)) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE);
+	s->open_mode &= ~((file->f_mode << FMODE_MIDI_SHIFT) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE));
 	spin_lock_irqsave(&s->lock, flags);
 	if (!(s->open_mode & (FMODE_MIDI_READ | FMODE_MIDI_WRITE))) {
 		outb(inb(s->ioenh + SV_CODEC_INTMASK) & ~SV_CINTMASK_MIDI, s->ioenh + SV_CODEC_INTMASK);
@@ -2725,7 +2726,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "sv: version v0.30 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "sv: version v0.31 time " __TIME__ " " __DATE__ "\n");
 #if 0
 	if (!(wavetable_mem = __get_free_pages(GFP_KERNEL, 20-PAGE_SHIFT)))
 		printk(KERN_INFO "sv: cannot allocate 1MB of contiguous nonpageable memory for wavetable data\n");
--- sound/oss/cmpci.c.orig	2003-01-02 04:22:17.000000000 +0100
+++ sound/oss/cmpci.c	2003-01-03 22:38:48.000000000 +0100
@@ -82,6 +82,7 @@
  *	- speaker mixer support 
  *	Mon Aug 13 2001
  *	- optimizations and cleanups
+ *    03/01/2003 - open_mode fixes from Georg Acher <acher@in.tum.de>
  *
  */
 /*****************************************************************************/
@@ -2272,7 +2273,7 @@
 		stop_adc(s);
 		dealloc_dmabuf(&s->dma_adc);
 	}
-	s->open_mode &= (~file->f_mode) & (FMODE_READ|FMODE_WRITE);
+	s->open_mode &= ~(file->f_mode & (FMODE_READ|FMODE_WRITE));
 	up(&s->open_sem);
 	wake_up(&s->open_wait);
 	unlock_kernel();
@@ -2540,7 +2541,7 @@
 		set_current_state(TASK_RUNNING);
 	}
 	down(&s->open_sem);
-	s->open_mode &= (~(file->f_mode << FMODE_MIDI_SHIFT)) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE);
+	s->open_mode &= ~((file->f_mode << FMODE_MIDI_SHIFT) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE));
 	spin_lock_irqsave(&s->lock, flags);
 	if (!(s->open_mode & (FMODE_MIDI_READ | FMODE_MIDI_WRITE))) {
 		del_timer(&s->midi.timer);		

-- 
