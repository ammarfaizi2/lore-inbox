Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266665AbTADDM1>; Fri, 3 Jan 2003 22:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266676AbTADDM1>; Fri, 3 Jan 2003 22:12:27 -0500
Received: from dclient217-162-80-86.hispeed.ch ([217.162.80.86]:54154 "EHLO
	gamecube.hb9jnx.ampr.org") by vger.kernel.org with ESMTP
	id <S266665AbTADDMV>; Fri, 3 Jan 2003 22:12:21 -0500
Subject: [PATCH]: 2.4.20: fix oopsable bug in OSS PCI sound drivers
From: Thomas Sailer <sailer@scs.ch>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Jan 2003 04:21:07 +0100
Message-Id: <1041650467.9389.21.camel@gamecube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes an oopsable (according to a few reports) bug
in the multiple open exclusion logic in my sound drivers and a driver
derived from my code. Please apply.

Tom


--- drivers/sound/cmpci.c.orig	2002-08-03 02:39:44.000000000 +0200
+++ drivers/sound/cmpci.c	2003-01-04 02:33:05.000000000 +0100
@@ -82,6 +82,7 @@
  *	- speaker mixer support 
  *	Mon Aug 13 2001
  *	- optimizations and cleanups
+ *    03/01/2003 - open_mode fixes from Georg Acher <acher@in.tum.de>
  *
  */
 /*****************************************************************************/
@@ -2266,7 +2267,7 @@
 		stop_adc(s);
 		dealloc_dmabuf(&s->dma_adc);
 	}
-	s->open_mode &= (~file->f_mode) & (FMODE_READ|FMODE_WRITE);
+	s->open_mode &= ~(file->f_mode & (FMODE_READ|FMODE_WRITE));
 	up(&s->open_sem);
 	wake_up(&s->open_wait);
 	unlock_kernel();
@@ -2535,7 +2536,7 @@
 		set_current_state(TASK_RUNNING);
 	}
 	down(&s->open_sem);
-	s->open_mode &= (~(file->f_mode << FMODE_MIDI_SHIFT)) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE);
+	s->open_mode &= ~((file->f_mode << FMODE_MIDI_SHIFT) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE));
 	spin_lock_irqsave(&s->lock, flags);
 	if (!(s->open_mode & (FMODE_MIDI_READ | FMODE_MIDI_WRITE))) {
 		del_timer(&s->midi.timer);		
--- drivers/sound/es1370.c.orig	2002-11-29 00:53:14.000000000 +0100
+++ drivers/sound/es1370.c	2003-01-04 02:33:05.000000000 +0100
@@ -3,7 +3,7 @@
 /*
  *      es1370.c  --  Ensoniq ES1370/Asahi Kasei AK4531 audio driver.
  *
- *      Copyright (C) 1998-2001  Thomas Sailer (t.sailer@alumni.ethz.ch)
+ *      Copyright (C) 1998-2001, 2003  Thomas Sailer (t.sailer@alumni.ethz.ch)
  *
  *      This program is free software; you can redistribute it and/or modify
  *      it under the terms of the GNU General Public License as published by
@@ -122,6 +122,7 @@
  *    07.01.2001   0.36  Timeout change in wrcodec as requested by Frank Klemm <pfk@fuchs.offl.uni-jena.de>
  *    31.01.2001   0.37  Register/Unregister gameport
  *                       Fix SETTRIGGER non OSS API conformity
+ *    03.01.2003   0.38  open_mode fixes from Georg Acher <acher@in.tum.de>
  *
  * some important things missing in Ensoniq documentation:
  *
@@ -1809,7 +1810,7 @@
 		stop_adc(s);
 		dealloc_dmabuf(s, &s->dma_adc);
 	}
-	s->open_mode &= (~file->f_mode) & (FMODE_READ|FMODE_WRITE);
+	s->open_mode &= ~(file->f_mode & (FMODE_READ|FMODE_WRITE));
 	wake_up(&s->open_wait);
 	up(&s->open_sem);
 	unlock_kernel();
@@ -2494,7 +2495,7 @@
 		set_current_state(TASK_RUNNING);
 	}
 	down(&s->open_sem);
-	s->open_mode &= (~(file->f_mode << FMODE_MIDI_SHIFT)) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE);
+	s->open_mode &= ~((file->f_mode << FMODE_MIDI_SHIFT) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE));
 	spin_lock_irqsave(&s->lock, flags);
 	if (!(s->open_mode & (FMODE_MIDI_READ | FMODE_MIDI_WRITE))) {
 		s->ctrl &= ~CTRL_UART_EN;
@@ -2745,7 +2746,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "es1370: version v0.37 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "es1370: version v0.38 time " __TIME__ " " __DATE__ "\n");
 	return pci_module_init(&es1370_driver);
 }
 
--- drivers/sound/es1371.c.orig	2002-11-29 00:53:14.000000000 +0100
+++ drivers/sound/es1371.c	2003-01-04 02:33:05.000000000 +0100
@@ -3,7 +3,7 @@
 /*
  *      es1371.c  --  Creative Ensoniq ES1371.
  *
- *      Copyright (C) 1998-2001  Thomas Sailer (t.sailer@alumni.ethz.ch)
+ *      Copyright (C) 1998-2001, 2003  Thomas Sailer (t.sailer@alumni.ethz.ch)
  *
  *      This program is free software; you can redistribute it and/or modify
  *      it under the terms of the GNU General Public License as published by
@@ -110,6 +110,7 @@
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
@@ -2670,7 +2671,7 @@
 		set_current_state(TASK_RUNNING);
 	}
 	down(&s->open_sem);
-	s->open_mode &= (~(file->f_mode << FMODE_MIDI_SHIFT)) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE);
+	s->open_mode &= ~((file->f_mode << FMODE_MIDI_SHIFT) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE));
 	spin_lock_irqsave(&s->lock, flags);
 	if (!(s->open_mode & (FMODE_MIDI_READ | FMODE_MIDI_WRITE))) {
 		s->ctrl &= ~CTRL_UART_EN;
@@ -3046,7 +3047,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO PFX "version v0.30 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO PFX "version v0.32 time " __TIME__ " " __DATE__ "\n");
 	return pci_module_init(&es1371_driver);
 }
 
--- drivers/sound/esssolo1.c.orig	2002-08-03 02:39:44.000000000 +0200
+++ drivers/sound/esssolo1.c	2003-01-04 02:33:05.000000000 +0100
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
@@ -1977,7 +1978,7 @@
 		set_current_state(TASK_RUNNING);
 	}
 	down(&s->open_sem);
-	s->open_mode &= (~(file->f_mode << FMODE_MIDI_SHIFT)) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE);
+	s->open_mode &= ~((file->f_mode << FMODE_MIDI_SHIFT) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE));
 	spin_lock_irqsave(&s->lock, flags);
 	if (!(s->open_mode & (FMODE_MIDI_READ | FMODE_MIDI_WRITE))) {
 		outb(0x30, s->iobase + 7); /* enable A1, A2 irq's */
@@ -2452,7 +2453,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "solo1: version v0.19 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "solo1: version v0.20 time " __TIME__ " " __DATE__ "\n");
 	if (!pci_register_driver(&solo1_driver)) {
 		pci_unregister_driver(&solo1_driver);
                 return -ENODEV;
--- drivers/sound/sonicvibes.c.orig	2002-08-03 02:39:44.000000000 +0200
+++ drivers/sound/sonicvibes.c	2003-01-04 02:33:05.000000000 +0100
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
 
@@ -1964,7 +1965,7 @@
 		stop_adc(s);
 		dealloc_dmabuf(s, &s->dma_adc);
 	}
-	s->open_mode &= (~file->f_mode) & (FMODE_READ|FMODE_WRITE);
+	s->open_mode &= ~(file->f_mode & (FMODE_READ|FMODE_WRITE));
 	wake_up(&s->open_wait);
 	up(&s->open_sem);
 	unlock_kernel();
@@ -2236,7 +2237,7 @@
 		set_current_state(TASK_RUNNING);
 	}
 	down(&s->open_sem);
-	s->open_mode &= (~(file->f_mode << FMODE_MIDI_SHIFT)) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE);
+	s->open_mode &= ~((file->f_mode << FMODE_MIDI_SHIFT) & (FMODE_MIDI_READ|FMODE_MIDI_WRITE));
 	spin_lock_irqsave(&s->lock, flags);
 	if (!(s->open_mode & (FMODE_MIDI_READ | FMODE_MIDI_WRITE))) {
 		outb(inb(s->ioenh + SV_CODEC_INTMASK) & ~SV_CINTMASK_MIDI, s->ioenh + SV_CODEC_INTMASK);
@@ -2716,7 +2717,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "sv: version v0.30 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "sv: version v0.31 time " __TIME__ " " __DATE__ "\n");
 #if 0
 	if (!(wavetable_mem = __get_free_pages(GFP_KERNEL, 20-PAGE_SHIFT)))
 		printk(KERN_INFO "sv: cannot allocate 1MB of contiguous nonpageable memory for wavetable data\n");
