Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269189AbTCBMEI>; Sun, 2 Mar 2003 07:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269191AbTCBMEI>; Sun, 2 Mar 2003 07:04:08 -0500
Received: from mail.tbdnetworks.com ([63.209.25.99]:15542 "EHLO
	tbdnetworks.com") by vger.kernel.org with ESMTP id <S269189AbTCBMEG>;
	Sun, 2 Mar 2003 07:04:06 -0500
Date: Sun, 2 Mar 2003 04:14:25 -0800
To: linux-kernel@vger.kernel.org
Cc: Norbert Kiesel <nkiesel@defiant>
Subject: [PATCH] Multiple & vs. && and | vs. || bugs in 2.4.20
Message-ID: <20030302121425.GA27040@defiant>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here are patches for some | vs. || and & vs. && bugs found with
find ${1:-.} -name \*.c | xargs grep -En \
 '![a-zA-Z0-9_ ]+(\|[^|]|\&[^&])|([^|]\||[^&]\&) *!'

I also emailed them to the maintainers/authors if I could find them, but
failed for some (e.g. gus_xxx.c).

so long
	Norbert

--- linux-2.4.20/drivers/usb/acm.c~	2002-12-03 00:17:50.000000000 -0800
+++ linux-2.4.20/drivers/usb/acm.c	2003-03-02 03:03:34.000000000 -0800
@@ -240,7 +240,7 @@
 	if (urb->status)
 		dbg("nonzero read bulk status received: %d", urb->status);
 
-	if (!urb->status & !acm->throttle)  {
+	if (!urb->status && !acm->throttle)  {
 		for (i = 0; i < urb->actual_length && !acm->throttle; i++) {
 			/* if we insert more than TTY_FLIPBUF_SIZE characters,
 			 * we drop them. */
--- linux-2.4.20/drivers/net/aironet4500_core.c~	2001-09-30 12:26:06.000000000 -0700
+++ linux-2.4.20/drivers/net/aironet4500_core.c	2003-03-02 03:03:35.000000000 -0800
@@ -2676,10 +2676,8 @@
 #endif
 	//awc_dump_registers(dev);
 
-	if (adhoc & !max_mtu)
-		max_mtu= 2250;
-	else if (!max_mtu)
-		max_mtu= 1500;
+	if (!max_mtu)
+		max_mtu= adhoc ? 2250 : 1500;
 			
         priv->sleeping_bap = 1;
         	
--- linux-2.4.20/drivers/video/aty128fb.c~	2002-12-03 00:17:56.000000000 -0800
+++ linux-2.4.20/drivers/video/aty128fb.c	2003-03-02 03:05:44.000000000 -0800
@@ -2531,7 +2531,7 @@
 	reg |= LVDS_BL_MOD_EN | LVDS_BLON;
 	if (on && level > BACKLIGHT_OFF) {
 		reg |= LVDS_DIGION;
-		if (!reg & LVDS_ON) {
+		if ((reg & LVDS_ON) == 0) {
 			reg &= ~LVDS_BLON;
 			aty_st_le32(LVDS_GEN_CNTL, reg);
 			(void)aty_ld_le32(LVDS_GEN_CNTL);
--- linux-2.4.20/drivers/sound/gus_midi.c~	2001-03-06 19:28:32.000000000 -0800
+++ linux-2.4.20/drivers/sound/gus_midi.c	2003-03-02 03:03:35.000000000 -0800
@@ -183,7 +183,7 @@
 		qhead++;
 	}
 	restore_flags(flags);
-	return (qlen > 0) | !(GUS_MIDI_STATUS() & MIDI_XMIT_EMPTY);
+	return (qlen > 0) || !(GUS_MIDI_STATUS() & MIDI_XMIT_EMPTY);
 }
 
 #define MIDI_SYNTH_NAME	"Gravis Ultrasound Midi"
--- linux-2.4.20/drivers/sound/gus_wave.c~	2001-09-14 14:40:00.000000000 -0700
+++ linux-2.4.20/drivers/sound/gus_wave.c	2003-03-02 03:03:35.000000000 -0800
@@ -3123,7 +3123,7 @@
 
 	gus_initialize();
 	
-	if ((gus_mem_size > 0) & !gus_no_wave_dma)
+	if ((gus_mem_size > 0) && !gus_no_wave_dma)
 	{
 		hw_config->slots[4] = -1;
 		if ((gus_devnum = sound_install_audiodrv(AUDIO_DRIVER_VERSION,
--- linux-2.4.20/drivers/i2c/i2c-proc.c~	2002-03-11 01:07:21.000000000 -0800
+++ linux-2.4.20/drivers/i2c/i2c-proc.c	2003-03-02 03:03:34.000000000 -0800
@@ -729,7 +729,7 @@
 			     ||
 			     ((address_data->
 			       ignore_range[i] ==
-			       SENSORS_ANY_I2C_BUS) & !is_isa))
+			       SENSORS_ANY_I2C_BUS) && !is_isa))
 			    && (addr >= address_data->ignore_range[i + 1])
 			    && (addr <= address_data->ignore_range[i + 2])) {
 #ifdef DEBUG
@@ -818,7 +818,7 @@
 		     i += 2) {
 			if (((adapter_id == address_data->probe[i]) ||
 			     ((address_data->
-			       probe[i] == SENSORS_ANY_I2C_BUS) & !is_isa))
+			       probe[i] == SENSORS_ANY_I2C_BUS) && !is_isa))
 			    && (addr == address_data->probe[i + 1])) {
 #ifdef DEBUG
 				printk
@@ -835,7 +835,7 @@
 			    ((adapter_id == address_data->probe_range[i])
 			     ||
 			     ((address_data->probe_range[i] ==
-			       SENSORS_ANY_I2C_BUS) & !is_isa))
+			       SENSORS_ANY_I2C_BUS) && !is_isa))
 			    && (addr >= address_data->probe_range[i + 1])
 			    && (addr <= address_data->probe_range[i + 2])) {
 				found = 1;
--- linux-2.4.20/drivers/sound/maestro.c~	2002-08-25 03:12:46.000000000 -0700
+++ linux-2.4.20/drivers/sound/maestro.c	2003-03-02 03:03:34.000000000 -0800
@@ -3359,7 +3359,7 @@
 	/* check to see if we have a capabilities list in
 		the config register */
 	pci_read_config_word(pcidev, PCI_STATUS, &w);
-	if(! w & PCI_STATUS_CAP_LIST) return 0;
+	if(!(w & PCI_STATUS_CAP_LIST)) return 0;
 
 	/* walk the list, starting at the head. */
 	pci_read_config_byte(pcidev,PCI_CAPABILITY_LIST,&next);
--- linux-2.4.20/drivers/video/radeonfb.c~	2002-12-03 00:17:56.000000000 -0800
+++ linux-2.4.20/drivers/video/radeonfb.c	2003-03-02 03:05:42.000000000 -0800
@@ -2778,7 +2778,7 @@
 	lvds_gen_cntl |= (LVDS_BL_MOD_EN | LVDS_BLON);
 	if (on && (level > BACKLIGHT_OFF)) {
 		lvds_gen_cntl |= LVDS_DIGON;
-		if (!lvds_gen_cntl & LVDS_ON) {
+		if ((lvds_gen_cntl & LVDS_ON) == 0) {
 			lvds_gen_cntl &= ~LVDS_BLON;
 			OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
 			(void)INREG(LVDS_GEN_CNTL);
