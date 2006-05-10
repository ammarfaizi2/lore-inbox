Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbWEJX5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbWEJX5Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 19:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbWEJX5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 19:57:16 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:5519 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S965092AbWEJX44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 19:56:56 -0400
Date: Thu, 11 May 2006 00:56:51 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: ata_piix failure on ich6m
Message-ID: <20060510235650.GA20206@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We've got an ich6m system (a Toshiba Portege S100). ata_piix attempts to 
drive the chipset, but fails - however, it doesn't bail out. As a result 
it remains bound to the device and ahci isn't loaded.

I've attached the lspci output for the chipset. A few things to note 
are:

1) The AHCI BAR is set
2) The SCC register identifies it as an AHCI controller
3) Bits 2 and 0 of the PCS are set, which the spec claims indicates that 
the port is to be controlled as an ahci device.

So, my question is effectively: why does ata_piix attempt to disable 
ahci rather than simply letting the ahci driver bind? Points (1) and (2) 
seem to be checked by the code, but I'm guessing that in the case of (3) 
it should just return ENODEV and let ahci be run instead. If so, should 
I code up a patch?

Dmesg output:

[4294674.890000] ata_piix 0000:00:1f.2: version 1.05
[4294674.890000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, 
low) -> IRQ 233
[4294674.890000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[4294674.890000] ata1: SATA max UDMA/133 cmd 0xBF28 ctl 0xBF26 bmdma 
0xBF00 irq 233
[4294674.890000] ata2: SATA max UDMA/133 cmd 0xBF18 ctl 0xBF16 bmdma 
0xBF08 irq 233
[4294674.900000] hda: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, 
UDMA(33)
[4294674.900000] Uniform CD-ROM driver Revision: 3.20
[4294674.983000] Probing IDE interface ide1...
[4294675.056000] ATA: abnormal status 0xFF on port 0xBF2F
[4294675.056000] ata1: disabling port
[4294675.057000] scsi0 : ata_piix
[4294675.223000] ATA: abnormal status 0xFF on port 0xBF1F
[4294675.223000] ata2: disabling port
[4294675.224000] scsi1 : ata_piix

lspci output:

0000:00:1f.2 0106: Intel Corporation 82801FBM (ICH6M) SATA Controller
(rev 03) (prog-if 01)
 Subsystem: Toshiba America Info Systems: Unknown device 0f00
 Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 233
 I/O ports at bf28 [size=8]
 I/O ports at bf24 [size=4]
 I/O ports at bf18 [size=8]
 I/O ports at bf14 [size=4]
 I/O ports at bf00 [size=16]
 Memory at cddffc00 (32-bit, non-prefetchable) [size=1K]
 Capabilities: [70] Power Management version 2
00: 86 80 53 26 07 00 b0 02 03 01 06 01 00 00 00 00
10: 29 bf 00 00 25 bf 00 00 19 bf 00 00 15 bf 00 00
20: 01 bf 00 00 00 fc df cd 00 00 00 00 79 11 00 0f
30: 00 00 00 00 70 00 00 00 00 00 00 00 0b 02 00 00
40: 07 23 00 00 00 00 00 00 01 00 01 00 00 00 00 00
50: 00 00 00 00 10 10 04 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 02 40 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 70 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 80 00 15 00 82 01 c0 0a 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 80 0f 04 00 00 00 00 00
-- 
Matthew Garrett | mjg59@srcf.ucam.org
