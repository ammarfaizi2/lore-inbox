Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVLKTho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVLKTho (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 14:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVLKTho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 14:37:44 -0500
Received: from thorn.pobox.com ([208.210.124.75]:61933 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1750819AbVLKThn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 14:37:43 -0500
Date: Sun, 11 Dec 2005 14:37:40 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: slab corruption in block layer during ipr_probe (2.6.15-rc5)
Message-ID: <20051211193740.GA3180@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing a flurry of slab corruption messages during ipr probe on a
Power5 system.  Been a while since I tested on this box, so I'm not
sure when this started.  I'll try to narrow it down in the meantime.

Since the messages are so numerous that the log buffer wraps, I
modified check_poison_obj to dump_stack on the first detection of
corruption and captured the following:


Linux version 2.6.15-rc5-ge4f5c82a (nathanl@zippy) (gcc version 3.3.2) #14 SMP PREEMPT Sun Dec 11 12:30:16 CST 2005

<snip>

ipr: IBM Power RAID SCSI Device Driver version: 2.1.0 (October 31, 2005)
ipr 0001:d0:01.0: Found IOA with IRQ: 167
ipr 0001:d0:01.0: Starting IOA initialization sequence.
ipr 0001:d0:01.0: Adapter firmware version: 020A005C
ipr 0001:d0:01.0: IOA initialized.
scsi0 : IBM 570B Storage Adapter
Slab corruption: start=c000000007650340, len=728
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c000000000227cd8>](.blk_cleanup_queue+0x98/0xd8)
1d0: 6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 00 00 00 00
2b0: 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=c000000007650050, len=728
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<0000000000000000>](0x0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=c000000007650630, len=728
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c000000000227e7c>](.blk_alloc_queue_node+0x2c/0x90)
000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Call Trace:
[C00000009FF52E70] [C000000000028464] .show_stack+0x5c/0x1cc (unreliable)
[C00000009FF52F20] [C0000000000A04B4] .check_poison_obj+0x1e0/0x2a8
[C00000009FF52FE0] [C0000000000A2AE4] .cache_alloc_debugcheck_after+0x1b8/0x1d0
[C00000009FF53080] [C0000000000A3528] .kmem_cache_alloc_node+0x21c/0x26c
[C00000009FF53120] [C000000000227E7C] .blk_alloc_queue_node+0x2c/0x90
[C00000009FF531A0] [C000000000227F44] .blk_init_queue_node+0x3c/0x180
[C00000009FF53260] [C000000000227EF4] .blk_init_queue+0x14/0x28
[C00000009FF532E0] [C000000000367FD4] .scsi_alloc_queue+0x30/0x158
[C00000009FF53370] [C000000000368DFC] .scsi_alloc_sdev+0x178/0x298
[C00000009FF53460] [C000000000369EC0] .scsi_probe_and_add_lun+0x2b0/0x2c4
[C00000009FF53530] [C00000000036AB04] .__scsi_scan_target+0x124/0x170
[C00000009FF535E0] [C00000000036AD54] .scsi_scan_channel+0xb0/0xec
[C00000009FF53680] [C00000000036AEB8] .scsi_scan_host_selected+0x128/0x1a4
[C00000009FF53730] [C00000000038F094] .ipr_probe+0x108/0x160
[C00000009FF537D0] [C00000000024A778] .pci_call_probe+0x7c/0xd8
[C00000009FF53860] [C00000000024A84C] .__pci_device_probe+0x78/0x90
[C00000009FF538E0] [C00000000024A89C] .pci_device_probe+0x38/0x70
[C00000009FF53970] [C0000000002BF8B4] .driver_probe_device+0x70/0x124
[C00000009FF53A00] [C0000000002BFB34] .__driver_attach+0xd0/0xe0
[C00000009FF53A90] [C0000000002BEA50] .bus_for_each_dev+0x8c/0xcc
[C00000009FF53B50] [C0000000002BFB6C] .driver_attach+0x28/0x40
[C00000009FF53BD0] [C0000000002BF1C4] .bus_add_driver+0xc8/0x11c
[C00000009FF53C70] [C0000000002C0240] .driver_register+0x70/0x94
[C00000009FF53D30] [C00000000024AD04] .__pci_register_driver+0xa0/0xf8
[C00000009FF53DF0] [C000000000614704] .ipr_init+0x34/0x4c
[C00000009FF53E70] [C0000000005E9B14] .do_initcalls+0x64/0x120
[C00000009FF53F00] [C000000000009328] .init+0x90/0x248
[C00000009FF53F90] [C00000000002D5A0] .kernel_thread+0x4c/0x68
  Vendor: IBM       Model: VSBPD4E1  U4SCSI  Rev: 4770
  Type:   Enclosure                          ANSI SCSI revision: 02
  Vendor: IBM   H0  Model: HUS103036FL3800   Rev: RPQF
  Type:   Direct-Access                      ANSI SCSI revision: 04
  Vendor: IBM   H0  Model: HUS103036FL3800   Rev: RPQF
  Type:   Direct-Access                      ANSI SCSI revision: 04
  Vendor: IBM   H0  Model: HUS103036FL3800   Rev: RPQF
  Type:   Direct-Access                      ANSI SCSI revision: 04
  Vendor: IBM   H0  Model: HUS103036FL3800   Rev: RPQF
  Type:   Direct-Access                      ANSI SCSI revision: 04
  Vendor: IBM       Model: VSBPD4E1  U4SCSI  Rev: 4770
  Type:   Enclosure                          ANSI SCSI revision: 02
scsi: unknown device type 31
  Vendor: IBM       Model: 570B001           Rev: 0150
  Type:   Unknown                            ANSI SCSI revision: 00
vio_register_driver: driver ibmvscsi registering
libata version 1.20 loaded.

