Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWDSOlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWDSOlf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 10:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWDSOlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 10:41:35 -0400
Received: from dmesg.printk.net ([212.13.197.101]:60863 "EHLO dmesg.printk.net")
	by vger.kernel.org with ESMTP id S1750807AbWDSOle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 10:41:34 -0400
Date: Wed, 19 Apr 2006 15:34:26 +0100
From: Jon Masters <jonathan@jonmasters.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: fix hang in mpu401_uart.c (version 2)
Message-ID: <20060419143426.GA18514@apogee.jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Masters <jcm@jonmasters.org>

This fixes a hang in mpu401_uart.c that can occur when the mpu401
interface is non-existent or otherwise doesn't respond to commands but
we issue IO anyway. snd_mpu401_uart_cmd now returns an error code that is
passed up the stack so that an open() will fail immediately in such cases.

Eventually discovered after wine/cxoffice would constantly cause hard
lockups on my desktop immediately after loading (emulating Windows too
well). Turned out that I'd recently moved my sound cards around and
using /dev/sequencer now talks to a sound card with a broken MPU.

This second version changes -EFAULT to -EIO and frees open resources on
error too. Test booted and seems to work ok.

Signed-off-by: Jon Masters <jcm@jonmasters.org>

diff -urN linux-2.6.16.2_orig/sound/drivers/mpu401/mpu401_uart.c linux-2.6.16.2_dev/sound/drivers/mpu401/mpu401_uart.c
--- linux-2.6.16.2_orig/sound/drivers/mpu401/mpu401_uart.c	2006-04-07 17:56:47.000000000 +0100
+++ linux-2.6.16.2_dev/sound/drivers/mpu401/mpu401_uart.c	2006-04-19 13:10:34.000000000 +0100
@@ -183,7 +183,8 @@
 
  */
 
-static void snd_mpu401_uart_cmd(struct snd_mpu401 * mpu, unsigned char cmd, int ack)
+static int snd_mpu401_uart_cmd(struct snd_mpu401 * mpu, unsigned char cmd,
+		int ack)
 {
 	unsigned long flags;
 	int timeout, ok;
@@ -218,9 +219,11 @@
 		ok = 1;
 	}
 	spin_unlock_irqrestore(&mpu->input_lock, flags);
-	if (! ok)
+	if (!ok) {
 		snd_printk("cmd: 0x%x failed at 0x%lx (status = 0x%x, data = 0x%x)\n", cmd, mpu->port, mpu->read(mpu, MPU401C(mpu)), mpu->read(mpu, MPU401D(mpu)));
-	// snd_printk("cmd: 0x%x at 0x%lx (status = 0x%x, data = 0x%x)\n", cmd, mpu->port, mpu->read(mpu, MPU401C(mpu)), mpu->read(mpu, MPU401D(mpu)));
+		return 1;
+	}
+	return 0;
 }
 
 /*
@@ -235,12 +238,19 @@
 	if (mpu->open_input && (err = mpu->open_input(mpu)) < 0)
 		return err;
 	if (! test_bit(MPU401_MODE_BIT_OUTPUT, &mpu->mode)) {
-		snd_mpu401_uart_cmd(mpu, MPU401_RESET, 1);
-		snd_mpu401_uart_cmd(mpu, MPU401_ENTER_UART, 1);
+		if (snd_mpu401_uart_cmd(mpu, MPU401_RESET, 1))
+			goto error_out;
+		if (snd_mpu401_uart_cmd(mpu, MPU401_ENTER_UART, 1))
+			goto error_out;
 	}
 	mpu->substream_input = substream;
 	set_bit(MPU401_MODE_BIT_INPUT, &mpu->mode);
 	return 0;
+
+error_out:
+	if (mpu->open_input && mpu->close_input)
+		mpu->close_input(mpu);
+	return -EIO;
 }
 
 static int snd_mpu401_uart_output_open(struct snd_rawmidi_substream *substream)
@@ -252,39 +262,52 @@
 	if (mpu->open_output && (err = mpu->open_output(mpu)) < 0)
 		return err;
 	if (! test_bit(MPU401_MODE_BIT_INPUT, &mpu->mode)) {
-		snd_mpu401_uart_cmd(mpu, MPU401_RESET, 1);
-		snd_mpu401_uart_cmd(mpu, MPU401_ENTER_UART, 1);
+		if (snd_mpu401_uart_cmd(mpu, MPU401_RESET, 1))
+			goto error_out;
+		if (snd_mpu401_uart_cmd(mpu, MPU401_ENTER_UART, 1))
+			goto error_out;
 	}
 	mpu->substream_output = substream;
 	set_bit(MPU401_MODE_BIT_OUTPUT, &mpu->mode);
 	return 0;
+
+error_out:
+	if (mpu->open_output && mpu->close_output)
+		mpu->close_output(mpu);
+	return -EIO;
 }
 
 static int snd_mpu401_uart_input_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_mpu401 *mpu;
-
+	int err = 0;
+	
 	mpu = substream->rmidi->private_data;
 	clear_bit(MPU401_MODE_BIT_INPUT, &mpu->mode);
 	mpu->substream_input = NULL;
 	if (! test_bit(MPU401_MODE_BIT_OUTPUT, &mpu->mode))
-		snd_mpu401_uart_cmd(mpu, MPU401_RESET, 0);
+		err = snd_mpu401_uart_cmd(mpu, MPU401_RESET, 0);
 	if (mpu->close_input)
 		mpu->close_input(mpu);
+	if (err)
+		return -EIO;
 	return 0;
 }
 
 static int snd_mpu401_uart_output_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_mpu401 *mpu;
+	int err = 0;
 
 	mpu = substream->rmidi->private_data;
 	clear_bit(MPU401_MODE_BIT_OUTPUT, &mpu->mode);
 	mpu->substream_output = NULL;
 	if (! test_bit(MPU401_MODE_BIT_INPUT, &mpu->mode))
-		snd_mpu401_uart_cmd(mpu, MPU401_RESET, 0);
+		err = snd_mpu401_uart_cmd(mpu, MPU401_RESET, 0);
 	if (mpu->close_output)
 		mpu->close_output(mpu);
+	if (err)
+		return -EIO;
 	return 0;
 }
 
@@ -316,6 +339,7 @@
 			snd_mpu401_uart_remove_timer(mpu, 1);
 		clear_bit(MPU401_MODE_BIT_INPUT_TRIGGER, &mpu->mode);
 	}
+
 }
 
 /*
