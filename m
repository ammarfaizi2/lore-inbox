Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263226AbSJCKFE>; Thu, 3 Oct 2002 06:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263227AbSJCKFE>; Thu, 3 Oct 2002 06:05:04 -0400
Received: from gate.perex.cz ([194.212.165.105]:18190 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S263226AbSJCKEy>;
	Thu, 3 Oct 2002 06:04:54 -0400
Date: Thu, 3 Oct 2002 12:09:22 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA fixes #1
Message-ID: <Pine.LNX.4.33.0210031207110.521-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	this is the first patch which tries to solve major compilation / 
usage trouble for ALSA in 2.5.

						Jaroslav

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.676, 2002-10-03 12:03:21+02:00, perex@suse.cz
  ALSA compilation update
    - save_flags/cli/restore_flags removal
    - updated USB code for 2.5
    - fixed SPARC configuration
    - fixed spinlock/sleep race in PCM midlevel


 drivers/pnp/isapnp.c                  |    2 -
 include/sound/snd_wavefront.h         |    1 
 sound/Config.in                       |    9 +++----
 sound/core/oss/pcm_oss.c              |    4 +--
 sound/core/pcm_native.c               |   22 ++++++------------
 sound/isa/sgalaxy.c                   |   13 ++++------
 sound/isa/wavefront/wavefront.c       |    1 
 sound/isa/wavefront/wavefront_synth.c |   20 +++++++++++-----
 sound/pci/ali5451/ali5451.c           |   12 +++------
 sound/pci/cs46xx/dsp_spos.c           |    5 +---
 sound/pci/cs46xx/dsp_spos_scb_lib.c   |    4 ---
 sound/usb/usbaudio.c                  |   41 ++++++++++++++++++++++++++++++----
 sound/usb/usbmidi.c                   |   22 +++++++++++++++---
 sound/usb/usbmixer.c                  |    6 ++--
 14 files changed, 101 insertions(+), 61 deletions(-)


diff -Nru a/drivers/pnp/isapnp.c b/drivers/pnp/isapnp.c
--- a/drivers/pnp/isapnp.c	Thu Oct  3 12:05:41 2002
+++ b/drivers/pnp/isapnp.c	Thu Oct  3 12:05:41 2002
@@ -1048,7 +1048,7 @@
 	isapnp_wait();
 	isapnp_key();
 	isapnp_wake(csn);
-#if 1
+#if 0
 	/* to avoid malfunction when the isapnptools package is used */
 	/* we must set RDP to our value again */
 	/* it is possible to set RDP only in the isolation phase */ 
diff -Nru a/include/sound/snd_wavefront.h b/include/sound/snd_wavefront.h
--- a/include/sound/snd_wavefront.h	Thu Oct  3 12:05:41 2002
+++ b/include/sound/snd_wavefront.h	Thu Oct  3 12:05:41 2002
@@ -91,6 +91,7 @@
 	int samples_used;                  /* how many */
 	char interrupts_are_midi;          /* h/w MPU interrupts enabled ? */
 	char rom_samples_rdonly;           /* can we write on ROM samples */
+	spinlock_t irq_lock;
 	wait_queue_head_t interrupt_sleeper; 
         snd_wavefront_midi_t midi;         /* ICS2115 MIDI interface */
 };
diff -Nru a/sound/Config.in b/sound/Config.in
--- a/sound/Config.in	Thu Oct  3 12:05:41 2002
+++ b/sound/Config.in	Thu Oct  3 12:05:41 2002
@@ -36,11 +36,10 @@
 if [ "$CONFIG_SND" != "n" -a "$CONFIG_USB" != "n" ]; then
   source sound/usb/Config.in
 fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC32" = "y" ]; then
-  source sound/sparc/Config.in
-fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC64" = "y" ]; then
-  source sound/sparc/Config.in
+if [ "$CONFIG_SND" != "n" ]; then
+  if [ "$CONFIG_SPARC32" = "y" -o "$CONFIG_SPARC64" = "y" ]; then
+    source sound/sparc/Config.in
+  fi
 fi
 
 endmenu
diff -Nru a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
--- a/sound/core/oss/pcm_oss.c	Thu Oct  3 12:05:41 2002
+++ b/sound/core/oss/pcm_oss.c	Thu Oct  3 12:05:41 2002
@@ -1851,8 +1851,8 @@
 	mask = 0;
 	if (psubstream != NULL) {
 		snd_pcm_runtime_t *runtime = psubstream->runtime;
-		spin_lock_irq(&runtime->lock);
 		poll_wait(file, &runtime->sleep, wait);
+		spin_lock_irq(&runtime->lock);
 		if (runtime->status->state != SNDRV_PCM_STATE_DRAINING &&
 		    (runtime->status->state != SNDRV_PCM_STATE_RUNNING ||
 		     snd_pcm_oss_playback_ready(psubstream)))
@@ -1861,8 +1861,8 @@
 	}
 	if (csubstream != NULL) {
 		snd_pcm_runtime_t *runtime = csubstream->runtime;
-		spin_lock_irq(&runtime->lock);
 		poll_wait(file, &runtime->sleep, wait);
+		spin_lock_irq(&runtime->lock);
 		if (runtime->status->state != SNDRV_PCM_STATE_RUNNING ||
 		    snd_pcm_oss_capture_ready(csubstream))
 			mask |= POLLIN | POLLRDNORM;
diff -Nru a/sound/core/pcm_native.c b/sound/core/pcm_native.c
--- a/sound/core/pcm_native.c	Thu Oct  3 12:05:41 2002
+++ b/sound/core/pcm_native.c	Thu Oct  3 12:05:41 2002
@@ -947,7 +947,10 @@
 static int snd_pcm_reset(snd_pcm_substream_t *substream)
 {
 	int res;
+
+	spin_lock_irq(&substream->runtime->lock);
 	_SND_PCM_ACTION(reset, substream, 0, res, 0);
+	spin_unlock_irq(&substream->runtime->lock);
 	return res;
 }
 
@@ -984,6 +987,7 @@
 {
 	int res;
 	snd_card_t *card = substream->pcm->card;
+
 	snd_power_lock(card);
 	while (snd_power_get_state(card) != SNDRV_CTL_POWER_D0) {
 		if (substream->ffile->f_flags & O_NONBLOCK) {
@@ -993,7 +997,9 @@
 		snd_power_wait(card);
 	}
 
+	spin_lock_irq(&substream->runtime->lock);
 	_SND_PCM_ACTION(prepare, substream, 0, res, 0);
+	spin_unlock_irq(&substream->runtime->lock);
 
        _power_unlock:
 	snd_power_unlock(card);
@@ -2051,21 +2057,9 @@
 	case SNDRV_PCM_IOCTL_CHANNEL_INFO:
 		return snd_pcm_channel_info(substream, (snd_pcm_channel_info_t *) arg);
 	case SNDRV_PCM_IOCTL_PREPARE:
-	{
-		int res;
-		spin_lock_irq(&substream->runtime->lock);
-		res = snd_pcm_prepare(substream);
-		spin_unlock_irq(&substream->runtime->lock);
-		return res;
-	}
+		return snd_pcm_prepare(substream);
 	case SNDRV_PCM_IOCTL_RESET:
-	{
-		int res;
-		spin_lock_irq(&substream->runtime->lock);
-		res = snd_pcm_reset(substream);
-		spin_unlock_irq(&substream->runtime->lock);
-		return res;
-	}
+		return snd_pcm_reset(substream);
 	case SNDRV_PCM_IOCTL_START:
 	{
 		int res;
diff -Nru a/sound/isa/sgalaxy.c b/sound/isa/sgalaxy.c
--- a/sound/isa/sgalaxy.c	Thu Oct  3 12:05:41 2002
+++ b/sound/isa/sgalaxy.c	Thu Oct  3 12:05:41 2002
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/time.h>
+#include <linux/irq.h>
 #include <sound/core.h>
 #include <sound/sb.h>
 #include <sound/ad1848.h>
@@ -117,8 +118,6 @@
 	static int dma_bits[] = {1, 2, 0, 3};
 	int tmp, tmp1;
 
-	unsigned long flags;
-
 	if ((tmp = inb(port + 3)) == 0xff)
 	{
 		snd_printdd("I/O address dead (0x%lx)\n", port);
@@ -140,20 +139,18 @@
 	snd_printdd("sgalaxy - setting up IRQ/DMA for WSS\n");
 #endif
 
-	save_flags(flags);
-	cli();
+	/* FIXME: this is really bogus --jk */
+	/* the irq line is not allocated (thus locked) for this device at the moment */
+	disable_irq(irq);
 
         /* initialize IRQ for WSS codec */
         tmp = interrupt_bits[irq % 16];
-        if (tmp < 0) {
-		restore_flags(flags);
+        if (tmp < 0)
                 return -EINVAL;
-	}
         outb(tmp | 0x40, port);
         tmp1 = dma_bits[dma % 4];
         outb(tmp | tmp1, port);
 
-	restore_flags(flags);
 	return 0;
 }
 
diff -Nru a/sound/isa/wavefront/wavefront.c b/sound/isa/wavefront/wavefront.c
--- a/sound/isa/wavefront/wavefront.c	Thu Oct  3 12:05:41 2002
+++ b/sound/isa/wavefront/wavefront.c	Thu Oct  3 12:05:41 2002
@@ -495,6 +495,7 @@
 	}
 	acard = (snd_wavefront_card_t *)card->private_data;
 	acard->wavefront.irq = -1;
+	spin_lock_init(&acard->wavefront.irq_lock);
 	init_waitqueue_head(&acard->wavefront.interrupt_sleeper);
 	spin_lock_init(&acard->wavefront.midi.open);
 	spin_lock_init(&acard->wavefront.midi.virtual);
diff -Nru a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
--- a/sound/isa/wavefront/wavefront_synth.c	Thu Oct  3 12:05:41 2002
+++ b/sound/isa/wavefront/wavefront_synth.c	Thu Oct  3 12:05:41 2002
@@ -1705,9 +1705,11 @@
 		return;
 	}
 
+	spin_lock(&dev->irq_lock);
 	dev->irq_ok = 1;
 	dev->irq_cnt++;
-	wake_up_interruptible (&dev->interrupt_sleeper);
+	spin_unlock(&dev->irq_lock);
+	wake_up(&dev->interrupt_sleeper);
 }
 
 /* STATUS REGISTER 
@@ -1755,14 +1757,20 @@
 				  int val, int port, int timeout)
 
 {
-	unsigned long flags;
+	wait_queue_t wait;
 
-	save_flags (flags);
-	cli();
+	init_waitqueue_entry(&wait, current);
+	spin_lock_irq(&dev->irq_lock);
+	add_wait_queue(&dev->interrupt_sleeper, &wait);
 	dev->irq_ok = 0;
 	outb (val,port);
-	interruptible_sleep_on_timeout (&dev->interrupt_sleeper, timeout);
-	restore_flags (flags);
+	spin_unlock_irq(&dev->irq_lock);
+	while (1) {
+		if ((timeout = schedule_timeout(timeout)) == 0)
+			return;
+		if (dev->irq_ok)
+			return;
+	}
 }
 
 static int __init
diff -Nru a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
--- a/sound/pci/ali5451/ali5451.c	Thu Oct  3 12:05:41 2002
+++ b/sound/pci/ali5451/ali5451.c	Thu Oct  3 12:05:41 2002
@@ -1871,7 +1871,6 @@
 	ali_t *chip = snd_magic_cast(ali_t, pci_get_drvdata(dev), return);
 #endif
 	ali_image_t *im;
-	unsigned long flags;
 	int i, j;
 
 	im = chip->image;
@@ -1882,8 +1881,7 @@
 		return;
 #endif
 
-	save_flags(flags); 
-	cli();
+	spin_lock_irq(&chip->reg_lock);
 	
 	im->regs[ALI_MISCINT >> 2] = inl(ALI_REG(chip, ALI_MISCINT));
 	// im->regs[ALI_START >> 2] = inl(ALI_REG(chip, ALI_START));
@@ -1907,7 +1905,7 @@
 	// stop all HW channel
 	outl(0xffffffff, ALI_REG(chip, ALI_STOP));
 
-	restore_flags(flags);
+	spin_unlock_irq(&chip->reg_lock);
 #ifndef PCI_OLD_SUSPEND
 	return 0;
 #endif
@@ -1925,7 +1923,6 @@
 	ali_t *chip = snd_magic_cast(ali_t, pci_get_drvdata(dev), return);
 #endif
 	ali_image_t *im;
-	unsigned long flags;
 	int i, j;
 
 	im = chip->image;
@@ -1938,8 +1935,7 @@
 
 	pci_enable_device(chip->pci);
 
-	save_flags(flags); 
-	cli();
+	spin_lock_irq(&chip->reg_lock);
 	
 	for (i = 0; i < ALI_CHANNELS; i++) {
 		outb(i, ALI_REG(chip, ALI_GC_CIR));
@@ -1960,7 +1956,7 @@
 	// restore IRQ enable bits
 	outl(im->regs[ALI_MISCINT >> 2], ALI_REG(chip, ALI_MISCINT));
 	
-	restore_flags(flags);
+	spin_unlock_irq(&chip->reg_lock);
 #ifndef PCI_OLD_SUSPEND
 	return 0;
 #endif
diff -Nru a/sound/pci/cs46xx/dsp_spos.c b/sound/pci/cs46xx/dsp_spos.c
--- a/sound/pci/cs46xx/dsp_spos.c	Thu Oct  3 12:05:41 2002
+++ b/sound/pci/cs46xx/dsp_spos.c	Thu Oct  3 12:05:41 2002
@@ -1595,8 +1595,7 @@
 								ins->spdif_in_src,
 								SCB_ON_PARENT_SUBLIST_SCB);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irq(&chip->reg_lock);
 
 	/* reset SPDIF input sample buffer pointer */
 	snd_cs46xx_poke (chip, (SPDIFI_SCB_INST + 0x0c) << 2,
@@ -1609,7 +1608,7 @@
 	/* restore SPDIF input volume */
 	snd_cs46xx_poke(chip, (ASYNCRX_SCB_ADDR + 0xE) << 2, ins->spdif_input_volume);
 	snd_cs46xx_poke(chip, (ASYNCRX_SCB_ADDR + 0xF) << 2, ins->spdif_input_volume);
-	restore_flags(flags);
+	spin_unlock_irq(&chip->reg_lock);
 
 	/* set SPDIF input sample rate and unmute
 	   NOTE: only 48khz support for SPDIF input this time */
diff -Nru a/sound/pci/cs46xx/dsp_spos_scb_lib.c b/sound/pci/cs46xx/dsp_spos_scb_lib.c
--- a/sound/pci/cs46xx/dsp_spos_scb_lib.c	Thu Oct  3 12:05:41 2002
+++ b/sound/pci/cs46xx/dsp_spos_scb_lib.c	Thu Oct  3 12:05:41 2002
@@ -1426,14 +1426,10 @@
 	src->parent_scb_ptr = parent_scb;
 
 	/* update entry in DSP RAM */
-	spin_lock_irqsave(&chip->reg_lock, flags);
 	snd_cs46xx_poke(chip,
 			(parent_scb->address + SCBsubListPtr) << 2,
 			(parent_scb->sub_list_ptr->address << 0x10) |
 			(parent_scb->next_scb_ptr->address));
-  
-
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
   
 	return 0;
 }
diff -Nru a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
--- a/sound/usb/usbaudio.c	Thu Oct  3 12:05:41 2002
+++ b/sound/usb/usbaudio.c	Thu Oct  3 12:05:41 2002
@@ -1292,9 +1292,15 @@
  * entry point for linux usb interface
  */
 
-static void * usb_audio_probe(struct usb_device *dev, unsigned int ifnum,
+#ifndef OLD_USB
+static int usb_audio_probe(struct usb_interface *intf,
+			   const struct usb_device_id *id);
+static void usb_audio_disconnect(struct usb_interface *intf);
+#else
+static void * usb_audio_probe(usb_device *dev, unsigned int ifnum,
 			      const struct usb_device_id *id);
 static void usb_audio_disconnect(struct usb_device *dev, void *ptr);
+#endif
 
 static struct usb_device_id usb_audio_ids [] = {
 #include "usbquirks.h"
@@ -1310,7 +1316,9 @@
 	.name =		"snd-usb-audio",
 	.probe =	usb_audio_probe,
 	.disconnect =	usb_audio_disconnect,
+#ifdef OLD_USB
 	.driver_list =	LIST_HEAD_INIT(usb_audio_driver.driver_list), 
+#endif
 	.id_table =	usb_audio_ids,
 };
 
@@ -2042,9 +2050,18 @@
  * only at the first time.  the successive calls of this function will
  * append the pcm interface to the corresponding card.
  */
+#ifndef OLD_USB
+static int usb_audio_probe(struct usb_interface *intf,
+			   const struct usb_device_id *id)
+#else
 static void *usb_audio_probe(struct usb_device *dev, unsigned int ifnum,
 			     const struct usb_device_id *id)
+#endif
 {
+#ifndef OLD_USB
+	struct usb_device *dev = interface_to_usbdev(intf);
+	int ifnum = intf->altsetting->bInterfaceNumber;
+#endif
 	struct usb_config_descriptor *config = dev->actconfig;	
 	const snd_usb_audio_quirk_t *quirk = (const snd_usb_audio_quirk_t *)id->driver_info;
 	unsigned char *buffer;
@@ -2054,17 +2071,17 @@
 	snd_usb_audio_t *chip;
 
 	if (quirk && ifnum != quirk->ifnum)
-		return NULL;
+		goto __err_val;
 
 	if (usb_set_configuration(dev, config->bConfigurationValue) < 0) {
 		snd_printk(KERN_ERR "cannot set configuration (value 0x%x)\n", config->bConfigurationValue);
-		return NULL;
+		goto __err_val;
 	}
 
 	index = dev->actconfig - config;
 	buflen = alloc_desc_buffer(dev, index, &buffer);
 	if (buflen <= 0)
-		return NULL;
+		goto __err_val;
 
 	/*
 	 * found a config.  now register to ALSA
@@ -2126,12 +2143,21 @@
 	chip->num_interfaces++;
 	up(&register_mutex);
 	kfree(buffer);
+#ifndef OLD_USB
+	return 0;
+#else
 	return chip;
+#endif
 
  __error:
 	up(&register_mutex);
 	kfree(buffer);
+ __err_val:
+#ifndef OLD_USB
+	return -EIO;
+#else
 	return NULL;
+#endif
 }
 
 
@@ -2139,8 +2165,15 @@
  * we need to take care of counter, since disconnection can be called also
  * many times as well as usb_audio_probe(). 
  */
+#ifndef OLD_USB
+static void usb_audio_disconnect(struct usb_interface *intf)
+#else
 static void usb_audio_disconnect(struct usb_device *dev, void *ptr)
+#endif
 {
+#ifndef OLD_USB
+	void *ptr = dev_get_drvdata(&intf->dev);
+#endif
 	snd_usb_audio_t *chip;
 
 	if (ptr == (void *)-1)
diff -Nru a/sound/usb/usbmidi.c b/sound/usb/usbmidi.c
--- a/sound/usb/usbmidi.c	Thu Oct  3 12:05:41 2002
+++ b/sound/usb/usbmidi.c	Thu Oct  3 12:05:41 2002
@@ -479,6 +479,22 @@
 	snd_magic_kfree(ep);
 }
 
+#ifndef OLD_USB
+/* this code is not exported from USB core anymore */
+struct usb_interface *local_usb_ifnum_to_if(struct usb_device *dev, unsigned ifnum)
+{
+	int i;
+        
+	for (i = 0; i < dev->actconfig->bNumInterfaces; i++)
+		if (dev->actconfig->interface[i].altsetting[0].bInterfaceNumber == ifnum)
+			return &dev->actconfig->interface[i];
+                                                        
+	return NULL;
+}
+#else
+#define local_usb_ifnum_to_if usb_ifnum_to_if
+#endif
+
 /*
  * For Roland devices, use the alternate setting which uses interrupt
  * transfers for input.
@@ -491,7 +507,7 @@
 
 	if (umidi->chip->dev->descriptor.idVendor != 0x0582)
 		return NULL;
-	intf = usb_ifnum_to_if(umidi->chip->dev, umidi->ifnum);
+	intf = local_usb_ifnum_to_if(umidi->chip->dev, umidi->ifnum);
 	if (!intf || intf->num_altsetting != 2)
 		return NULL;
 
@@ -803,7 +819,7 @@
 
 	memset(endpoints, 0, sizeof(*endpoints) * MIDI_MAX_ENDPOINTS);
 
-	intf = usb_ifnum_to_if(umidi->chip->dev, umidi->ifnum);
+	intf = local_usb_ifnum_to_if(umidi->chip->dev, umidi->ifnum);
 	if (!intf)
 		return -ENXIO;
 	intfd = &intf->altsetting[0];
@@ -862,7 +878,7 @@
 	usb_endpoint_descriptor_t* epd;
 
 	if (endpoint->epnum == -1) {
-		intf = usb_ifnum_to_if(umidi->chip->dev, umidi->ifnum);
+		intf = local_usb_ifnum_to_if(umidi->chip->dev, umidi->ifnum);
 		if (!intf || intf->num_altsetting < 1)
 			return -ENOENT;
 		intfd = intf->altsetting;
diff -Nru a/sound/usb/usbmixer.c b/sound/usb/usbmixer.c
--- a/sound/usb/usbmixer.c	Thu Oct  3 12:05:41 2002
+++ b/sound/usb/usbmixer.c	Thu Oct  3 12:05:41 2002
@@ -60,7 +60,7 @@
 	unsigned char *buffer;
 	unsigned int buflen;
 	unsigned int ctrlif;
-	unsigned long unitbitmap[32/sizeof(unsigned long)];
+	DECLARE_BITMAP(unitbitmap, 32*32);
 	usb_audio_term_t oterm;
 };
 
@@ -1252,7 +1252,7 @@
 {
 	unsigned char *p1;
 
-	if (test_and_set_bit(unitid, &state->unitbitmap))
+	if (test_and_set_bit(unitid, state->unitbitmap))
 		return 0; /* the unit already visited */
 
 	p1 = find_audio_control_unit(state, unitid);
@@ -1302,7 +1302,7 @@
 	while ((desc = snd_usb_find_csint_desc(buffer, buflen, desc, OUTPUT_TERMINAL, ctrlif, -1)) != NULL) {
 		if (desc[0] < 9)
 			continue; /* invalid descriptor? */
-		set_bit(desc[3], &state.unitbitmap);  /* mark terminal ID as visited */
+		set_bit(desc[3], state.unitbitmap);  /* mark terminal ID as visited */
 		state.oterm.id = desc[3];
 		state.oterm.type = combine_word(&desc[4]);
 		state.oterm.name = desc[8];

===================================================================


This BitKeeper patch contains the following changesets:
1.676
## Wrapped with gzip_uu ##


begin 664 bkpatch6928
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
0:1!ZH]"V_@OY(Y)$@S``````
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

