Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWGCUqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWGCUqT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWGCUqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:46:14 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:11955 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932066AbWGCUpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:45:50 -0400
Message-ID: <44A98261.1000300@oracle.com>
Date: Mon, 03 Jul 2006 13:47:29 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: James@superbug.demon.co.uk, akpm <akpm@osdl.org>
Subject: [Ubuntu PATCH] FIx no mpu401 interface can cause hard freeze
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the remaining instances in our tree where a non-
existent mpu401 interface can cause a hard freeze when i/o is issued.

This commit closes Malone #34831.

Bug: https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/34831

patch location:
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=b422309cdd980cfefe99379796c04e961d3c1544

---
 sound/pci/emu10k1/emu10k1x.c  |   35 +++++++++++++++++++++++++----------
 sound/pci/emu10k1/emumpu401.c |   35 +++++++++++++++++++++++++----------
 2 files changed, 50 insertions(+), 20 deletions(-)

--- linux-2617-g21.orig/sound/pci/emu10k1/emu10k1x.c
+++ linux-2617-g21/sound/pci/emu10k1/emu10k1x.c
@@ -1286,7 +1286,7 @@ static void snd_emu10k1x_midi_interrupt(
 	do_emu10k1x_midi_interrupt(emu, &emu->midi, status);
 }
 
-static void snd_emu10k1x_midi_cmd(struct emu10k1x * emu,
+static int snd_emu10k1x_midi_cmd(struct emu10k1x * emu,
 				  struct emu10k1x_midi *midi, unsigned char cmd, int ack)
 {
 	unsigned long flags;
@@ -1312,11 +1312,14 @@ static void snd_emu10k1x_midi_cmd(struct
 		ok = 1;
 	}
 	spin_unlock_irqrestore(&midi->input_lock, flags);
-	if (!ok)
+	if (!ok) {
 		snd_printk(KERN_ERR "midi_cmd: 0x%x failed at 0x%lx (status = 0x%x, data = 0x%x)!!!\n",
 			   cmd, emu->port,
 			   mpu401_read_stat(emu, midi),
 			   mpu401_read_data(emu, midi));
+		return 1;
+	}
+	return 0;
 }
 
 static int snd_emu10k1x_midi_input_open(struct snd_rawmidi_substream *substream)
@@ -1332,12 +1335,17 @@ static int snd_emu10k1x_midi_input_open(
 	midi->substream_input = substream;
 	if (!(midi->midi_mode & EMU10K1X_MIDI_MODE_OUTPUT)) {
 		spin_unlock_irqrestore(&midi->open_lock, flags);
-		snd_emu10k1x_midi_cmd(emu, midi, MPU401_RESET, 1);
-		snd_emu10k1x_midi_cmd(emu, midi, MPU401_ENTER_UART, 1);
+		if (snd_emu10k1x_midi_cmd(emu, midi, MPU401_RESET, 1))
+			goto error_out;
+		if (snd_emu10k1x_midi_cmd(emu, midi, MPU401_ENTER_UART, 1))
+			goto error_out;
 	} else {
 		spin_unlock_irqrestore(&midi->open_lock, flags);
 	}
 	return 0;
+
+error_out:
+	return -EIO;
 }
 
 static int snd_emu10k1x_midi_output_open(struct snd_rawmidi_substream *substream)
@@ -1353,12 +1361,17 @@ static int snd_emu10k1x_midi_output_open
 	midi->substream_output = substream;
 	if (!(midi->midi_mode & EMU10K1X_MIDI_MODE_INPUT)) {
 		spin_unlock_irqrestore(&midi->open_lock, flags);
-		snd_emu10k1x_midi_cmd(emu, midi, MPU401_RESET, 1);
-		snd_emu10k1x_midi_cmd(emu, midi, MPU401_ENTER_UART, 1);
+		if (snd_emu10k1x_midi_cmd(emu, midi, MPU401_RESET, 1))
+			goto error_out;
+		if (snd_emu10k1x_midi_cmd(emu, midi, MPU401_ENTER_UART, 1))
+			goto error_out;
 	} else {
 		spin_unlock_irqrestore(&midi->open_lock, flags);
 	}
 	return 0;
+
+error_out:
+	return -EIO;
 }
 
 static int snd_emu10k1x_midi_input_close(struct snd_rawmidi_substream *substream)
@@ -1366,6 +1379,7 @@ static int snd_emu10k1x_midi_input_close
 	struct emu10k1x *emu;
 	struct emu10k1x_midi *midi = substream->rmidi->private_data;
 	unsigned long flags;
+	int err = 0;
 
 	emu = midi->emu;
 	snd_assert(emu, return -ENXIO);
@@ -1375,11 +1389,11 @@ static int snd_emu10k1x_midi_input_close
 	midi->substream_input = NULL;
 	if (!(midi->midi_mode & EMU10K1X_MIDI_MODE_OUTPUT)) {
 		spin_unlock_irqrestore(&midi->open_lock, flags);
-		snd_emu10k1x_midi_cmd(emu, midi, MPU401_RESET, 0);
+		err = snd_emu10k1x_midi_cmd(emu, midi, MPU401_RESET, 0);
 	} else {
 		spin_unlock_irqrestore(&midi->open_lock, flags);
 	}
-	return 0;
+	return err;
 }
 
 static int snd_emu10k1x_midi_output_close(struct snd_rawmidi_substream *substream)
@@ -1387,6 +1401,7 @@ static int snd_emu10k1x_midi_output_clos
 	struct emu10k1x *emu;
 	struct emu10k1x_midi *midi = substream->rmidi->private_data;
 	unsigned long flags;
+	int err = 0;
 
 	emu = midi->emu;
 	snd_assert(emu, return -ENXIO);
@@ -1396,11 +1411,11 @@ static int snd_emu10k1x_midi_output_clos
 	midi->substream_output = NULL;
 	if (!(midi->midi_mode & EMU10K1X_MIDI_MODE_INPUT)) {
 		spin_unlock_irqrestore(&midi->open_lock, flags);
-		snd_emu10k1x_midi_cmd(emu, midi, MPU401_RESET, 0);
+		err = snd_emu10k1x_midi_cmd(emu, midi, MPU401_RESET, 0);
 	} else {
 		spin_unlock_irqrestore(&midi->open_lock, flags);
 	}
-	return 0;
+	return err;
 }
 
 static void snd_emu10k1x_midi_input_trigger(struct snd_rawmidi_substream *substream, int up)
--- linux-2617-g21.orig/sound/pci/emu10k1/emumpu401.c
+++ linux-2617-g21/sound/pci/emu10k1/emumpu401.c
@@ -116,7 +116,7 @@ static void snd_emu10k1_midi_interrupt2(
 	do_emu10k1_midi_interrupt(emu, &emu->midi2, status);
 }
 
-static void snd_emu10k1_midi_cmd(struct snd_emu10k1 * emu, struct snd_emu10k1_midi *midi, unsigned char cmd, int ack)
+static int snd_emu10k1_midi_cmd(struct snd_emu10k1 * emu, struct snd_emu10k1_midi *midi, unsigned char cmd, int ack)
 {
 	unsigned long flags;
 	int timeout, ok;
@@ -141,11 +141,14 @@ static void snd_emu10k1_midi_cmd(struct 
 		ok = 1;
 	}
 	spin_unlock_irqrestore(&midi->input_lock, flags);
-	if (!ok)
+	if (!ok) {
 		snd_printk(KERN_ERR "midi_cmd: 0x%x failed at 0x%lx (status = 0x%x, data = 0x%x)!!!\n",
 			   cmd, emu->port,
 			   mpu401_read_stat(emu, midi),
 			   mpu401_read_data(emu, midi));
+		return 1;
+	}
+	return 0;
 }
 
 static int snd_emu10k1_midi_input_open(struct snd_rawmidi_substream *substream)
@@ -161,12 +164,17 @@ static int snd_emu10k1_midi_input_open(s
 	midi->substream_input = substream;
 	if (!(midi->midi_mode & EMU10K1_MIDI_MODE_OUTPUT)) {
 		spin_unlock_irqrestore(&midi->open_lock, flags);
-		snd_emu10k1_midi_cmd(emu, midi, MPU401_RESET, 1);
-		snd_emu10k1_midi_cmd(emu, midi, MPU401_ENTER_UART, 1);
+		if (snd_emu10k1_midi_cmd(emu, midi, MPU401_RESET, 1))
+			goto error_out;
+		if (snd_emu10k1_midi_cmd(emu, midi, MPU401_ENTER_UART, 1))
+			goto error_out;
 	} else {
 		spin_unlock_irqrestore(&midi->open_lock, flags);
 	}
 	return 0;
+
+error_out:
+	return -EIO;
 }
 
 static int snd_emu10k1_midi_output_open(struct snd_rawmidi_substream *substream)
@@ -182,12 +190,17 @@ static int snd_emu10k1_midi_output_open(
 	midi->substream_output = substream;
 	if (!(midi->midi_mode & EMU10K1_MIDI_MODE_INPUT)) {
 		spin_unlock_irqrestore(&midi->open_lock, flags);
-		snd_emu10k1_midi_cmd(emu, midi, MPU401_RESET, 1);
-		snd_emu10k1_midi_cmd(emu, midi, MPU401_ENTER_UART, 1);
+		if (snd_emu10k1_midi_cmd(emu, midi, MPU401_RESET, 1))
+			goto error_out;
+		if (snd_emu10k1_midi_cmd(emu, midi, MPU401_ENTER_UART, 1))
+			goto error_out;
 	} else {
 		spin_unlock_irqrestore(&midi->open_lock, flags);
 	}
 	return 0;
+
+error_out:
+	return -EIO;
 }
 
 static int snd_emu10k1_midi_input_close(struct snd_rawmidi_substream *substream)
@@ -195,6 +208,7 @@ static int snd_emu10k1_midi_input_close(
 	struct snd_emu10k1 *emu;
 	struct snd_emu10k1_midi *midi = (struct snd_emu10k1_midi *)substream->rmidi->private_data;
 	unsigned long flags;
+	int err = 0;
 
 	emu = midi->emu;
 	snd_assert(emu, return -ENXIO);
@@ -204,11 +218,11 @@ static int snd_emu10k1_midi_input_close(
 	midi->substream_input = NULL;
 	if (!(midi->midi_mode & EMU10K1_MIDI_MODE_OUTPUT)) {
 		spin_unlock_irqrestore(&midi->open_lock, flags);
-		snd_emu10k1_midi_cmd(emu, midi, MPU401_RESET, 0);
+		err = snd_emu10k1_midi_cmd(emu, midi, MPU401_RESET, 0);
 	} else {
 		spin_unlock_irqrestore(&midi->open_lock, flags);
 	}
-	return 0;
+	return err;
 }
 
 static int snd_emu10k1_midi_output_close(struct snd_rawmidi_substream *substream)
@@ -216,6 +230,7 @@ static int snd_emu10k1_midi_output_close
 	struct snd_emu10k1 *emu;
 	struct snd_emu10k1_midi *midi = (struct snd_emu10k1_midi *)substream->rmidi->private_data;
 	unsigned long flags;
+	int err = 0;
 
 	emu = midi->emu;
 	snd_assert(emu, return -ENXIO);
@@ -225,11 +240,11 @@ static int snd_emu10k1_midi_output_close
 	midi->substream_output = NULL;
 	if (!(midi->midi_mode & EMU10K1_MIDI_MODE_INPUT)) {
 		spin_unlock_irqrestore(&midi->open_lock, flags);
-		snd_emu10k1_midi_cmd(emu, midi, MPU401_RESET, 0);
+		err = snd_emu10k1_midi_cmd(emu, midi, MPU401_RESET, 0);
 	} else {
 		spin_unlock_irqrestore(&midi->open_lock, flags);
 	}
-	return 0;
+	return err;
 }
 
 static void snd_emu10k1_midi_input_trigger(struct snd_rawmidi_substream *substream, int up)

