Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143372AbRATJBA>; Sat, 20 Jan 2001 04:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137212AbRATJAv>; Sat, 20 Jan 2001 04:00:51 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:43015 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S137190AbRATJAk>; Sat, 20 Jan 2001 04:00:40 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101200900.f0K90UU26829@wellhouse.underworld>
Subject: [PATCH] : Sound module locking - uart401
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Date: Sat, 20 Jan 2001 20:00:27 +1100 (EST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I was going to save this patch until people (Alan) returned from
linux.conf.au, but seeing as 2.4.0-ac10 has just been posted ...

This patch makes the uart401 honour the module owner for MIDI and
synth devices, and then moves the MIDI operations into the text
section.

Chris

--- linux-2.4.0/drivers/sound/uart401.c.orig	Wed Jan 17 01:24:40 2001
+++ linux-2.4.0/drivers/sound/uart401.c	Thu Jan 18 01:44:49 2001
@@ -202,7 +202,7 @@
 #define MIDI_SYNTH_CAPS	SYNTH_CAP_INPUT
 #include "midi_synth.h"
 
-static struct midi_operations uart401_operations =
+static const struct midi_operations uart401_operations =
 {
 	owner:		THIS_MODULE,
 	info:		{"MPU-401 (UART) MIDI", 0, 0, SNDCARD_MPU401},
@@ -351,7 +351,6 @@
 		goto cleanup_irq;
 	}
 	conf_printf(name, hw_config);
-	std_midi_synth.midi_dev = devc->my_dev;
 	midi_devs[devc->my_dev] = kmalloc(sizeof(struct midi_operations), GFP_KERNEL);
 	if (!midi_devs[devc->my_dev]) {
 		printk(KERN_ERR "uart401: Failed to allocate memory\n");
@@ -371,6 +370,11 @@
 	memcpy(midi_devs[devc->my_dev]->converter, &std_midi_synth, sizeof(struct synth_operations));
 	strcpy(midi_devs[devc->my_dev]->info.name, name);
 	midi_devs[devc->my_dev]->converter->id = "UART401";
+	midi_devs[devc->my_dev]->converter->midi_dev = devc->my_dev;
+
+	if (owner)
+		midi_devs[devc->my_dev]->converter->owner = owner;
+
 	hw_config->slots[4] = devc->my_dev;
 	sequencer_init();
 	devc->opened = 0;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
