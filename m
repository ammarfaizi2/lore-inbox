Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754636AbWKMNoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636AbWKMNoj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 08:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754644AbWKMNoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 08:44:39 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:51386 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1754636AbWKMNoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 08:44:38 -0500
Message-ID: <1163425477.455876c5637f6@imp4-g19.free.fr>
Date: Mon, 13 Nov 2006 14:44:37 +0100
From: Remi <remi.colinet@free.fr>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: 2.6.19-rc5-mm1 : probe of 0000:00:1f.2 failed with error -16
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 81.255.27.251
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since after 2.6.18-mm3, I'm unable to boot mm trees getting the following
message:

ata_piix: probe of 0000:00:1f.2 failed with error -16
Kernel panic - not syncing: Attempted to kill init!

I disabled most options in my .config file just keeping ata_piix enabled.
2.6.19-rc5 still boots fine but 2.6.19-rc-mm1 gives the same previous message.

I bissected the 2.6.19-rc5-mm1 tree and found the patch preventing my DELL D610
laptop from booting.

gregkh-pci-pci-quirks-fix-the-festering-mess-that-claims-to-handle-ide-quirks.patch

Digging further into the source code, I added some code to display I/O ports
allocations and stack traces at some useful points.
(http://remi.colinet.free.fr/ktrace/002/rco.patch)

So what happens with the previous patch applied?
(http://remi.colinet.free.fr/ktrace/002/dmesg_2.6.19-rc5-mm1-rco1)

=> Step 1 : with the patch applied, the resource of the pci device
dev->resource[x] are initialized to claim legacy I/O ports from 0x01f0 up to
0x01f7 with the flag IORESOURCE_IO (drivers/pci/probe.c).

=> Step 2 : then, these resources are allocated from the I/O port resources, by
pcibios_allocate_resources (arch/i386/pci/i386.c).

 [<b0103bc5>] show_trace_log_lvl+0x1a/0x2f
 [<b0103cbe>] show_trace+0x12/0x14
 [<b010440c>] dump_stack+0x19/0x1b
 [<b0120089>] catch_resource+0x36/0x38
 [<b0120377>] request_resource+0x36/0x47
 [<b03670f6>] pcibios_allocate_resources+0x7d/0x130
 [<b03671bd>] pcibios_resource_survey+0x14/0x20
 [<b036800e>] pcibios_init+0x5f/0x87
 [<b01004a4>] init+0x127/0x2cf
 [<b0103ad7>] kernel_thread_helper+0x7/0x10
 =======================

I/O port resources give :

01f0-01f7 : 0000:00:1f.2

Hence, the I/O port resources are allocated, but with the flag IORESOURCE_IO.

=> Step 3 : then the following code is executed

 [<b0120128>] __request_region+0x9d/0xa6
 [<b01c2030>] quirk_intel_ide_combined+0x1a4/0x1f9
 [<b01c16d5>] pci_fixup_device+0x6b/0x77
 [<b01c076f>] pci_init+0x14/0x2c
 [<b01004a4>] init+0x127/0x2cf
 [<b0103ad7>] kernel_thread_helper+0x7/0x10

which requests the same resources but with the IORESOURCE_BUSY flag. I/O ports
resources are then :

01f0-01f7 : 0000:00:1f.2
    01f0-01f7 : libata

=> Step 4 : then the libata tries to allocate once more the same ressources and
fails.

[<f00e3eed>] ata_pci_init_one+0xad/0x423 [libata]
 [<f001f9c1>] piix_init_one+0x4b7/0x4d4 [ata_piix]
 [<b01c2dd0>] pci_device_probe+0x39/0x5b
 [<b01f7170>] really_probe+0x7a/0x101
 [<b01f728c>] driver_probe_device+0x95/0xa1
 [<b01f736a>] __driver_attach+0x4c/0x83
 [<b01f67eb>] bus_for_each_dev+0x37/0x5c
 [<b01f702a>] driver_attach+0x19/0x1b
 [<b01f6ad2>] bus_add_driver+0x67/0x16a
 [<b01f753f>] driver_register+0x76/0x7b
 [<b01c2f5a>] __pci_register_driver+0x7e/0x99
 [<f0035012>] piix_init+0x12/0x25 [ata_piix]
 [<b0135c8b>] sys_init_module+0x1749/0x1926
 [<b0102fbb>] syscall_call+0x7/0xb

Ending with the messages.

PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2

And then,

ata_piix: probe of 0000:00:1f.2 failed with error -16
Kernel panic - not syncing: Attempted to kill init!

I/O ports resources are :

0170-0177 : 0000:00:1f.2
    0170-0177 : ide1
01f0-01f7 : 0000:00:1f.2
    01f0-01f7 : libata
0376-0376 : 0000:00:1f.2
    0376-0376 : ide1

What happens in 2.6.19-rc5 (which boots fine)?
(http://remi.colinet.free.fr/ktrace/002/dmesg_2.6.19-rc5-mm1-rco2)

Step 1 : dev-resource are not initialized. So, step 2 doesn't request resources.
Step 3 allocates I/O ports.

 [<b0103bc5>] show_trace_log_lvl+0x1a/0x2f
 [<b0103cbe>] show_trace+0x12/0x14
 [<b010440c>] dump_stack+0x19/0x1b
 [<b0120089>] catch_resource+0x36/0x38
 [<b0120128>] __request_region+0x9d/0xa6
 [<b01c2030>] quirk_intel_ide_combined+0x1a4/0x1f9
 [<b01c16d5>] pci_fixup_device+0x6b/0x77
 [<b01c076f>] pci_init+0x14/0x2c
 [<b01004a4>] init+0x127/0x2cf
 [<b0103ad7>] kernel_thread_helper+0x7/0x10

Step 4, doesn't request the I/O ports in pci_request_regions() and falls back to
legacy mode in the function ata_pci_init_one (drivers/ata/libata-sff.c)

I'am blured about which peace of code __has__ to request the I/O ports (pcibios,
quirk, libata, ...).

Any idea about what to change to fix this problem?

Thanks,
Remi


