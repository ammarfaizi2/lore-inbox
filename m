Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbUCOT3b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 14:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbUCOT2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 14:28:18 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:13788 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262729AbUCOT1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 14:27:25 -0500
Date: Mon, 15 Mar 2004 19:27:07 GMT
Message-Id: <200403151927.i2FJR7mt015712@delerium.codemonkey.org.uk>
From: davej@redhat.com
To: linux-kernel@vger.kernel.org
Subject: [ALSA][6/6] Don't leave crap in /sys after module exit.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a fun one. modprobe snd_dt019x.c when you don't have the hardware.
It fails to detect as expected, but doesn't stay around, so you don't
even need to rmmod it afterwards. Unfortunatly, it leaves around crap
in /sys/bus/pnp/drivers/dt019x  which buggers up any subsequent usage of
the pnp code. Fix is easy : Keep the module around even when things fail.

		Dave

--- linux-2.6.4/sound/isa/dt019x.c~	2004-03-15 18:56:08.000000000 +0000
+++ linux-2.6.4/sound/isa/dt019x.c	2004-03-15 19:01:39.000000000 +0000
@@ -325,7 +325,7 @@
 	if (!cards)
 		snd_printk(KERN_ERR "no DT-019X / ALS-007 based soundcards found\n");
 #endif
-	return cards ? 0 : -ENODEV;
+	return cards < 0 ? cards : 0;
 }
 
 static void __exit alsa_card_dt019x_exit(void)
