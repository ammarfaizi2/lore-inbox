Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264028AbRFIRJl>; Sat, 9 Jun 2001 13:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264416AbRFIRJb>; Sat, 9 Jun 2001 13:09:31 -0400
Received: from kosmo.edeal.de ([62.40.13.104]:35343 "EHLO kosmo.edeal.de")
	by vger.kernel.org with ESMTP id <S264028AbRFIRJO>;
	Sat, 9 Jun 2001 13:09:14 -0400
Date: Sat, 9 Jun 2001 19:09:17 +0200
From: Lukas Schroeder <lukas@edeal.de>
To: alan@redhat.com, zab@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] ess maestro, support for hardware volume control
Message-ID: <20010609190917.A10629@kosmo.edeal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


this patch applies to (at least) 2.4.3 up to and including 2.4.6-pre2.
It enables the hardware volume control feature of the maestro.
By giving hwv=0 to insmod one can explicitly disable it. Setting
hwv_input=1 requests the alternative HWV input pins to be used.

The maestro will generate interrupts on an input signal with bit 6 at
iobase+0x1A set. This case was already tested for, but 
a) nothing was done there and
b) this event never occurred anyway b/c the irq was turned off.
Now the master volume counter is read out and the mixer's 
master volume is changed accordingly.



regards,
  lukas



--- linux-2.4.6-pre2/drivers/sound/maestro.c	Sat Jun  9 16:55:22 2001
+++ linux/drivers/sound/maestro.c	Sat Jun  9 17:13:24 2001
@@ -115,6 +115,10 @@
  *	themselves, but we'll see.  
  *	
  * History
+ *  v0.15 - Jun 09 2001 - Lukas Schroeder <lukas@edeal.de>
+ *	enable hardware volume control (by default)
+ *	add hwv= to allow disabling of HWV (values are 0 or 1)
+ *	add hwv_input= to allow selecting the HWV input pins (values are 0 or 1)
  *  (still kind of v0.14) Nov 23 - Alan Cox <alan@redhat.com>
  *	Add clocking= for people with seriously warped hardware
  *  (still v0.14) Nov 10 2000 - Bartlomiej Zolnierkiewicz <bkz@linux-ide.org>
@@ -269,8 +273,13 @@
 	
 static int clocking=48000;
 
+/* enable hardware volume control? */
+static int hwv = 1;
+/* hardware volume input pin selection */
+static int hwv_input = 0;
+
 /* --------------------------------------------------------------------- */
-#define DRIVER_VERSION "0.14"
+#define DRIVER_VERSION "0.15"
 
 #ifndef PCI_VENDOR_ESS
 #define PCI_VENDOR_ESS			0x125D
@@ -312,6 +321,9 @@
 #define NR_APUS		64
 #define NR_APU_REGS	16
 
+/* steps per hardware volume count */
+#define HWV_MIXER_STEP	15
+
 /* acpi states */
 enum {
 	ACPI_D0=0,
@@ -514,6 +526,7 @@
 
 /* --------------------------------------------------------------------- */
 
+static void set_mixer(struct ess_card *card,unsigned int mixer, unsigned int val ) ;
 static void check_suspend(struct ess_card *card);
 
 static struct ess_card *devs = NULL;
@@ -1898,10 +1911,18 @@
 
 	if(event&(1<<6))
 	{
-		/* XXX if we have a hw volume control int enable
-			all the ints?  doesn't make sense.. */
+		unsigned int val;
+
 		event = inw(c->iobase+0x18);
-		outb(0xFF, c->iobase+0x1A);
+		outb((1<<6), c->iobase+0x1A);
+
+		/* read the HW Master Volume Counter
+                   Bits 7:5       Master Volume Left
+                   Bits 3:1       Master Volume Right
+                */
+		i = inb(c->iobase+0x1f);
+		val = ((HWV_MIXER_STEP * ((i>>1) & 7)) << 8) | HWV_MIXER_STEP * ((i>>5) & 7);
+		set_mixer(c, 0, val);
 	}
 	else
 	{
@@ -3088,8 +3109,10 @@
 	w&=~(1<<14);		/* External clock */
 	
 	w&=~(1<<7);		/* HWV off */
+	if (hwv) w|=(1<<7);
 	w&=~(1<<6);		/* Debounce off */
-	w&=~(1<<5);		/* GPIO 4:5 */
+	w&=~(1<<5);		/* GPIO 4:5 ; HVI pin selection */
+	if (hwv_input) w|=(1<<5);
 	w|= (1<<4);             /* Disconnect from the CHI.  Enabling this made a dell 7500 work. */
 	w&=~(1<<2);		/* MIDI fix off (undoc) */
 	w&=~(1<<1);		/* reserved, always write 0 */
@@ -3170,7 +3193,8 @@
 	outw(w, iobase+0x18);
 
 	w=inw(iobase+0x18);
-	w&=~(1<<6);		/* Harpo off */
+	w&=~(1<<6);		/* HWV irq off */
+	if (hwv) w|=(1<<6);
 	outw(w, iobase+0x18);
 	
 	w=inw(iobase+0x18);
@@ -3487,6 +3511,7 @@
 	/* now go to sleep 'till something interesting happens */
 	maestro_power(card,ACPI_D2);
 
+	printk(KERN_INFO "maestro: hardware volume control %senabled\n", (hwv) ? "" : "not ");
 	printk(KERN_INFO "maestro: %d channels configured.\n", num);
 	return 1; 
 }
@@ -3593,6 +3618,10 @@
 MODULE_PARM(dsps_order,"i");
 MODULE_PARM(use_pm,"i");
 MODULE_PARM(clocking, "i");
+
+MODULE_PARM(hwv, "i");
+MODULE_PARM(hwv_input, "i");
+
 
 void cleanup_module(void) {
 	M_printk("maestro: unloading\n");


