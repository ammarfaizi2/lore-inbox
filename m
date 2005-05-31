Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVEaXeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVEaXeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 19:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVEaXeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 19:34:08 -0400
Received: from server132-han.de-nserver.de ([85.158.180.16]:46511 "EHLO
	server132-han.de-nserver.de") by vger.kernel.org with ESMTP
	id S261196AbVEaXdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 19:33:11 -0400
X-User-Auth: Auth by mail@kristov.de through 145.254.150.77
Message-ID: <429CF432.6020702@kristov.de>
Date: Wed, 01 Jun 2005 01:33:06 +0200
From: Christoph Schulz <develop@kristov.de>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: perex@suse.cz
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] cs4236.c, kernel 2.6.11
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------020108040709040407090003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020108040709040407090003
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hello,

please consider attached patch for the cs4236.c driver module, located
in sound/isa/cs423x/ in the Linux 2.6.11 kernel.

Background: The card/chipset supports an external MIDI interrupt. By
default, this interrupt isn't used (because the isapnp mechanism chooses
a configuration without an assigned interrupt). If the user wishes to
explicitly select an interrupt via the mpu_irq parameter for such a
configured device, it doesn't work: The driver always shows:

isapnp MPU: port=0x330, irq=-1

(note the "irq=-1")

Problem: The driver only allows to set the irq if pnp_irq_valid returns
true for this particular pnp device. This, however, is only true if an
interrupt has already been assigned (pnp_valid_irq returns true if the
flag IORESOURCE_IRQ is set and IORESOURCE_UNSET is not set). If no
interrupt has been assigned so far, IORESOURCE_UNSET is set and
pnp_irq_valid returns false, thereby inhibiting the selection of a valid
irq.

Solution: Don't check for a valid (= already assigned) irq at the point
of calling pnp_resource_change.

Tested successfully on Linux 2.6.11.

Before applying the patch:

May 30 10:50:15 fenrir kernel: pnp: Device 01:01.00 activated.
May 30 10:50:15 fenrir kernel: ALSA sound/isa/cs423x/cs4236.c:325:
isapnp WSS: wss port=0x534, fm port=0x388, sb port=0x220
May 30 10:50:15 fenrir kernel: ALSA sound/isa/cs423x/cs4236.c:327:
isapnp WSS: irq=5, dma1=1, dma2=3
May 30 10:50:15 fenrir kernel: pnp: Device 01:01.02 activated.
May 30 10:50:15 fenrir kernel: ALSA sound/isa/cs423x/cs4236.c:344:
isapnp CTRL: control port=0x120
May 30 10:50:15 fenrir kernel: pnp: Device 01:01.03 activated.
May 30 10:50:15 fenrir kernel: ALSA sound/isa/cs423x/cs4236.c:372:
isapnp MPU: port=0x330, irq=-1
May 30 10:50:15 fenrir kernel: ALSA sound/isa/cs423x/cs4231_lib.c:1053:
cs4231: port = 0x534, id = 0xa
May 30 10:50:15 fenrir kernel: ALSA sound/isa/cs423x/cs4231_lib.c:1059:
CS4231: VERSION (I25) = 0x3
May 30 10:50:15 fenrir kernel: ALSA sound/isa/cs423x/cs4231_lib.c:1128:
CS4231: ext version; rev = 0xeb, id = 0xeb
May 30 10:50:15 fenrir kernel: ALSA sound/isa/cs423x/cs4236_lib.c:300:
CS4236: [0x120] C1 (version) = 0xeb, ext = 0xeb

After applying the patch:

May 30 12:06:46 fenrir kernel: pnp: Device 01:01.00 activated.
May 30 12:06:46 fenrir kernel: ALSA sound/isa/cs423x/cs4236.c:325:
isapnp WSS: wss port=0x534, fm port=0x388, sb port=0x220
May 30 12:06:46 fenrir kernel: ALSA sound/isa/cs423x/cs4236.c:327:
isapnp WSS: irq=5, dma1=1, dma2=3
May 30 12:06:46 fenrir kernel: pnp: Device 01:01.02 activated.
May 30 12:06:46 fenrir kernel: ALSA sound/isa/cs423x/cs4236.c:344:
isapnp CTRL: control port=0x120
May 30 12:06:46 fenrir kernel: pnp: Device 01:01.03 activated.
May 30 12:06:46 fenrir kernel: ALSA sound/isa/cs423x/cs4236.c:371:
isapnp MPU: port=0x330, irq=11
May 30 12:06:46 fenrir kernel: ALSA sound/isa/cs423x/cs4231_lib.c:1053:
cs4231: port = 0x534, id = 0xa
May 30 12:06:46 fenrir kernel: ALSA sound/isa/cs423x/cs4231_lib.c:1059:
CS4231: VERSION (I25) = 0x3
May 30 12:06:46 fenrir kernel: ALSA sound/isa/cs423x/cs4231_lib.c:1128:
CS4231: ext version; rev = 0xeb, id = 0xeb
May 30 12:06:46 fenrir kernel: ALSA sound/isa/cs423x/cs4236_lib.c:300:
CS4236: [0x120] C1 (version) = 0xeb, ext = 0xeb

(note the "irq=11" after applying the patch)

I am not a kernel developer, so I cannot guarantee that my observations
are correct. Please feel free to contact me for further information
and/or if I should have missed something. Please cc: to me if possible.


Regards,

Christoph Schulz
E-Mail: develop@kristov.de


--------------020108040709040407090003
Content-Type: text/plain;
 name="cs4236-irq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs4236-irq.patch"

diff -ur linux-2.6.11/sound/isa/cs423x/cs4236.c linux-2.6.11-patched/sound/isa/cs423x/cs4236.c
--- linux-2.6.11/sound/isa/cs423x/cs4236.c	2005-03-02 07:37:48.000000000 +0100
+++ linux-2.6.11-patched/sound/isa/cs423x/cs4236.c	2005-05-31 14:31:07.040130710 +0200
@@ -349,8 +349,7 @@
 		pnp_init_resource_table(cfg);
 		if (mpu_port[dev] != SNDRV_AUTO_PORT)
 			pnp_resource_change(&cfg->port_resource[0], mpu_port[dev], 2);
-		if (mpu_irq[dev] != SNDRV_AUTO_IRQ && mpu_irq[dev] >= 0 &&
-		    pnp_irq_valid(pdev, 0))
+		if (mpu_irq[dev] != SNDRV_AUTO_IRQ && mpu_irq[dev] >= 0)
 			pnp_resource_change(&cfg->irq_resource[0], mpu_irq[dev], 1);
 		err = pnp_manual_config_dev(pdev, cfg, 0);
 		if (err < 0)

--------------020108040709040407090003--
