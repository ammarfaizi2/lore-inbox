Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbUJaMWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbUJaMWG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 07:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUJaMWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 07:22:06 -0500
Received: from mailhub1.nextra.sk ([195.168.1.111]:33031 "EHLO
	mailhub1.nextra.sk") by vger.kernel.org with ESMTP id S261565AbUJaMV4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 07:21:56 -0500
Message-ID: <4184D8EB.6000306@rainbow-software.org>
Date: Sun, 31 Oct 2004 13:22:03 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ingmar@gonzo.schwaben.de
CC: linux-kernel@vger.kernel.org
Subject: HP C2502 SCSI card (NCR 53C400A based) not working
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have an old ISA SCSI card that came with HP ScanJet IIP scanner. It's
HP C2502 card based on NCR 53C400A chip. I was unable to get it working
with g_NCR5380 driver so I tried loading the official MINI400I.SYS
driver in DOSemu. I was surprised that the values sent to the ports are 
not the same as in the g_NCR5380 driver.

The g_NCR5380 driver uses these "magic outbs" to configure the card 
(this sequence disables the card):
outb(0x59, 0x779);
outb(0xb9, 0x379);
outb(0xc5, 0x379);
outb(0xae, 0x379);
outb(0xa6, 0x379);
outb(0x00, 0x379);

This is the output from DOSemu:
779 < f
379 < 22
379 < f0
379 < 20
379 < 80
379 < 00

The magic numbers are different - so I have a card that is not supported 
by the driver. I've changed the numbers in the driver to match my card 
but I'm still unable to get it working.

The g_NCR5380 driver uses this to check if the card is present at a 
particular base address:

outb(0xc0, ports[i] + 9);
if (inb(ports[i] + 9) != 0x80)
	continue;

The MINI400I.SYS uses something different:
(this is failed presence test at base address 0x280)
28e < 25
28f < a5
28f > ff

(this looks like a successful test at base address 0x350)
35e < 25
35f < a5
35f > a5
35f < 5a
35f > 5a
35e < 0
35f < 0
359 < 80
359 < 10
351 < 0
352 < 0
353 < 0
354 < 0
357 > ff
359 < 80
359 < 10
351 < 0
352 < 0
353 < 0
354 < 0
357 > ff
351 < 80
351 < 0
357 > ff

According to this, I think that my card has the 53C400A chip registers 
mapped to different addresses (offsets) but I'm unable to determine what 
the mapping is. I was also unable to find the 53C400A datasheet which 
might help a bit.

-- 
Ondrej Zary
