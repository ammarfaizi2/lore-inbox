Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbVIOHIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbVIOHIn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbVIOHIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:08:23 -0400
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:19324 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030440AbVIOHEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:04:07 -0400
Message-Id: <20050915070304.621069000.dtor_core@ameritech.net>
References: <20050915070131.813650000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 02:01:51 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>
Subject: [patch 20/28] Input: convert driver/input/misc to dynamic input_dev allocation
Content-Disposition: inline; filename=input-dynalloc-misc.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: convert driver/input/misc to dynamic input_dev allocation

This is required for input_dev sysfs integration

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/m68kspkr.c  |   40 ++++++++++++++++++------------------
 drivers/input/misc/pcspkr.c    |   34 +++++++++++++++---------------
 drivers/input/misc/sparcspkr.c |   45 ++++++++++++++++++++---------------------
 3 files changed, 59 insertions(+), 60 deletions(-)

Index: work/drivers/input/misc/m68kspkr.c
===================================================================
--- work.orig/drivers/input/misc/m68kspkr.c
+++ work/drivers/input/misc/m68kspkr.c
@@ -24,9 +24,7 @@ MODULE_AUTHOR("Richard Zidlicky <rz@linu
 MODULE_DESCRIPTION("m68k beeper driver");
 MODULE_LICENSE("GPL");
 
-static char m68kspkr_name[] = "m68k beeper";
-static char m68kspkr_phys[] = "m68k/generic";
-static struct input_dev m68kspkr_dev;
+static struct input_dev *m68kspkr_dev;
 
 static int m68kspkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
@@ -51,32 +49,34 @@ static int m68kspkr_event(struct input_d
 
 static int __init m68kspkr_init(void)
 {
-        if (!mach_beep){
-		printk("%s: no lowlevel beep support\n", m68kspkr_name);
-		return -1;
+        if (!mach_beep) {
+		printk(KERN_INFO "m68kspkr: no lowlevel beep support\n");
+		return -ENODEV;
         }
 
-	m68kspkr_dev.evbit[0] = BIT(EV_SND);
-	m68kspkr_dev.sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
-	m68kspkr_dev.event = m68kspkr_event;
-
-	m68kspkr_dev.name = m68kspkr_name;
-	m68kspkr_dev.phys = m68kspkr_phys;
-	m68kspkr_dev.id.bustype = BUS_HOST;
-	m68kspkr_dev.id.vendor = 0x001f;
-	m68kspkr_dev.id.product = 0x0001;
-	m68kspkr_dev.id.version = 0x0100;
-
-	input_register_device(&m68kspkr_dev);
+	m68kspkr_dev = input_allocate_device();
+	if (!m68kspkr_dev)
+		return -ENOMEM;
+
+	m68kspkr_dev->name = "m68k beeper";
+	m68kspkr_dev->phys = "m68k/generic";
+	m68kspkr_dev->id.bustype = BUS_HOST;
+	m68kspkr_dev->id.vendor = 0x001f;
+	m68kspkr_dev->id.product = 0x0001;
+	m68kspkr_dev->id.version = 0x0100;
+
+	m68kspkr_dev->evbit[0] = BIT(EV_SND);
+	m68kspkr_dev->sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
+	m68kspkr_dev->event = m68kspkr_event;
 
-        printk(KERN_INFO "input: %s\n", m68kspkr_name);
+	input_register_device(m68kspkr_dev);
 
 	return 0;
 }
 
 static void __exit m68kspkr_exit(void)
 {
-        input_unregister_device(&m68kspkr_dev);
+        input_unregister_device(m68kspkr_dev);
 }
 
 module_init(m68kspkr_init);
Index: work/drivers/input/misc/pcspkr.c
===================================================================
--- work.orig/drivers/input/misc/pcspkr.c
+++ work/drivers/input/misc/pcspkr.c
@@ -23,9 +23,7 @@ MODULE_AUTHOR("Vojtech Pavlik <vojtech@u
 MODULE_DESCRIPTION("PC Speaker beeper driver");
 MODULE_LICENSE("GPL");
 
-static char pcspkr_name[] = "PC Speaker";
-static char pcspkr_phys[] = "isa0061/input0";
-static struct input_dev pcspkr_dev;
+static struct input_dev *pcspkr_dev;
 
 static DEFINE_SPINLOCK(i8253_beep_lock);
 
@@ -68,27 +66,29 @@ static int pcspkr_event(struct input_dev
 
 static int __init pcspkr_init(void)
 {
-	pcspkr_dev.evbit[0] = BIT(EV_SND);
-	pcspkr_dev.sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
-	pcspkr_dev.event = pcspkr_event;
-
-	pcspkr_dev.name = pcspkr_name;
-	pcspkr_dev.phys = pcspkr_phys;
-	pcspkr_dev.id.bustype = BUS_ISA;
-	pcspkr_dev.id.vendor = 0x001f;
-	pcspkr_dev.id.product = 0x0001;
-	pcspkr_dev.id.version = 0x0100;
+	pcspkr_dev = input_allocate_device();
+	if (!pcspkr_dev)
+		return -ENOMEM;
+
+	pcspkr_dev->name = "PC Speaker";
+	pcspkr_dev->name = "isa0061/input0";
+	pcspkr_dev->id.bustype = BUS_ISA;
+	pcspkr_dev->id.vendor = 0x001f;
+	pcspkr_dev->id.product = 0x0001;
+	pcspkr_dev->id.version = 0x0100;
+
+	pcspkr_dev->evbit[0] = BIT(EV_SND);
+	pcspkr_dev->sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
+	pcspkr_dev->event = pcspkr_event;
 
-	input_register_device(&pcspkr_dev);
-
-        printk(KERN_INFO "input: %s\n", pcspkr_name);
+	input_register_device(pcspkr_dev);
 
 	return 0;
 }
 
 static void __exit pcspkr_exit(void)
 {
-        input_unregister_device(&pcspkr_dev);
+        input_unregister_device(pcspkr_dev);
 	/* turn off the speaker */
 	pcspkr_event(NULL, EV_SND, SND_BELL, 0);
 }
Index: work/drivers/input/misc/sparcspkr.c
===================================================================
--- work.orig/drivers/input/misc/sparcspkr.c
+++ work/drivers/input/misc/sparcspkr.c
@@ -17,28 +17,24 @@
 #endif
 
 MODULE_AUTHOR("David S. Miller <davem@redhat.com>");
-MODULE_DESCRIPTION("PC Speaker beeper driver");
+MODULE_DESCRIPTION("Sparc Speaker beeper driver");
 MODULE_LICENSE("GPL");
 
 static unsigned long beep_iobase;
-
-static char *sparcspkr_isa_name = "Sparc ISA Speaker";
-static char *sparcspkr_ebus_name = "Sparc EBUS Speaker";
-static char *sparcspkr_phys = "sparc/input0";
-static struct input_dev sparcspkr_dev;
+static struct input_dev *sparcspkr_dev;
 
 DEFINE_SPINLOCK(beep_lock);
 
 static void __init init_sparcspkr_struct(void)
 {
-	sparcspkr_dev.evbit[0] = BIT(EV_SND);
-	sparcspkr_dev.sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
+	sparcspkr_dev->evbit[0] = BIT(EV_SND);
+	sparcspkr_dev->sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
 
-	sparcspkr_dev.phys = sparcspkr_phys;
-	sparcspkr_dev.id.bustype = BUS_ISA;
-	sparcspkr_dev.id.vendor = 0x001f;
-	sparcspkr_dev.id.product = 0x0001;
-	sparcspkr_dev.id.version = 0x0100;
+	sparcspkr_dev->phys = "sparc/input0";
+	sparcspkr_dev->id.bustype = BUS_ISA;
+	sparcspkr_dev->id.vendor = 0x001f;
+	sparcspkr_dev->id.product = 0x0001;
+	sparcspkr_dev->id.version = 0x0100;
 }
 
 static int ebus_spkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
@@ -84,14 +80,15 @@ static int __init init_ebus_beep(struct 
 {
 	beep_iobase = edev->resource[0].start;
 
-	init_sparcspkr_struct();
+	sparcspkr_dev = input_allocate_device();
+	if (!sparcspkr_dev)
+		return -ENOMEM;
 
-	sparcspkr_dev.name = sparcspkr_ebus_name;
-	sparcspkr_dev.event = ebus_spkr_event;
+	sparcspkr_dev->name = "Sparc EBUS Speaker";
+	sparcspkr_dev->event = ebus_spkr_event;
 
-	input_register_device(&sparcspkr_dev);
+	input_register_device(sparcspkr_dev);
 
-        printk(KERN_INFO "input: %s\n", sparcspkr_ebus_name);
 	return 0;
 }
 
@@ -137,15 +134,17 @@ static int __init init_isa_beep(struct s
 {
 	beep_iobase = isa_dev->resource.start;
 
+	sparcspkr_dev = input_allocate_device();
+	if (!sparcspkr_dev)
+		return -ENOMEM;
+
 	init_sparcspkr_struct();
 
-	sparcspkr_dev.name = sparcspkr_isa_name;
-	sparcspkr_dev.event = isa_spkr_event;
-	sparcspkr_dev.id.bustype = BUS_ISA;
+	sparcspkr_dev->name = "Sparc ISA Speaker";
+	sparcspkr_dev->event = isa_spkr_event;
 
 	input_register_device(&sparcspkr_dev);
 
-        printk(KERN_INFO "input: %s\n", sparcspkr_isa_name);
 	return 0;
 }
 #endif
@@ -182,7 +181,7 @@ static int __init sparcspkr_init(void)
 
 static void __exit sparcspkr_exit(void)
 {
-	input_unregister_device(&sparcspkr_dev);
+	input_unregister_device(sparcspkr_dev);
 }
 
 module_init(sparcspkr_init);

