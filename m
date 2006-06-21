Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWFUGui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWFUGui (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 02:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbWFUGui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 02:50:38 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:30783 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1751213AbWFUGuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 02:50:37 -0400
Date: Tue, 20 Jun 2006 23:50:36 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc[56]-mm*: pcmcia "I/O resource not free"
Message-ID: <20060621065036.GR2038@hexapodia.org>
References: <20060615162859.GA1520@hexapodia.org> <20060617100327.e752b89a.akpm@osdl.org> <20060620211723.GA28016@hexapodia.org> <20060620150317.746372c5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620150317.746372c5.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 03:03:17PM -0700, Andrew Morton wrote:
> It's strange (to me) that IDE is requesting a single-byte memory region. 
> Possibly we've broken the resource.c code such that it has some off-by-one
> and is now rejecting single-byte requests.
[snip]
> +++ a/kernel/resource.c
> +			printk("conflict: %s[%Lx->%Lx]\n",
[snip]
> Then again, perhaps IDE is broken (as well?), because you don't have any
> single-byte iomem regions in your 2.6.17-rc6 /proc/iomem.  It would be
> interesting to run this patch in both 2.6.17-rc6 and in 2.6.17-rc6-mm2, see
> what it says:
[snip]
> +++ 25-akpm/drivers/ide/ide.c	Tue Jun 20 15:02:15 2006
> +		printk("%s: single-byte request\n", __FUNCTION__);
> +		dump_stack();

With both patches, rc6-mm2 dumps the following.

[ 2034.052000] pccard: PCMCIA card inserted into slot 0
[ 2034.052000] cs: memory probe 0xf0000000-0xf7ffffff: excluding 0xf0000000-0xf7ffffff
[ 2034.052000] cs: memory probe 0xd0200000-0xdfffffff: excluding 0xd0200000-0xd11fffff 0xd1a00000-0xd41fffff 0xd4a00000-0xd51fffff 0xd5a00000-0xd61fffff 0xd6a00000-0xd71fffff 0xd7a00000-0xd81fffff 0xd8a00000-0xd91fffff 0xd9a00000-0xda1fffff 0xdaa00000-0xdb1fffff 0xdba00000-0xdc1fffff 0xdca00000-0xdd1fffff 0xdda00000-0xde1fffff 0xdea00000-0xdf1fffff 0xdfa00000-0xe01fffff
[ 2034.060000] pcmcia: registering new device pcmcia0.0
[ 2034.060000] PM: Adding info for pcmcia:0.0
[ 2035.976000] conflict: PCI IO[0->ffff]
[ 2035.976000] hwif_request_region: single-byte request for ide2
[ 2035.976000]  [<c0257386>] hwif_request_region+0xa6/0xb0
[ 2035.976000]  [<c02574bf>] ide_hwif_request_regions+0x12f/0x150
[ 2035.976000]  [<c0257177>] init_hwif_default+0x37/0x120
[ 2035.976000]  [<f8b070b0>] idecs_mmio_fixup+0x0/0x30 [ide_cs]
[ 2035.976000]  [<c025e8a9>] probe_hwif+0x29/0x4f0
[ 2035.976000]  [<f8b070b0>] idecs_mmio_fixup+0x0/0x30 [ide_cs]
[ 2035.976000]  [<c025ed85>] probe_hwif_init_with_fixup+0x15/0xa0
[ 2035.976000]  [<c0257ea5>] ide_register_hw_with_fixup+0x165/0x1b0
[ 2035.976000]  [<f8b070b0>] idecs_mmio_fixup+0x0/0x30 [ide_cs]
[ 2035.976000]  [<f8b070b0>] idecs_mmio_fixup+0x0/0x30 [ide_cs]
[ 2035.976000]  [<f8b07163>] idecs_register+0x83/0xd0 [ide_cs]
[ 2035.976000]  [<f8b070b0>] idecs_mmio_fixup+0x0/0x30 [ide_cs]
[ 2035.976000]  [<f8b071c0>] outb_mem+0x0/0x10 [ide_cs]
[ 2035.976000]  [<f8b075e4>] ide_config+0x414/0x790 [ide_cs]
[ 2035.976000]  [<f8b071c0>] outb_mem+0x0/0x10 [ide_cs]
[ 2035.976000]  [<f8b0f4c8>] pcmcia_device_probe+0xa8/0x160 [pcmcia]
[ 2035.976000]  [<c025104c>] driver_probe_device+0xbc/0xe0
[ 2035.976000]  [<c02510f0>] __driver_attach+0x0/0x80
[ 2035.976000]  [<c0251160>] __driver_attach+0x70/0x80
[ 2035.976000]  [<c0250369>] bus_for_each_dev+0x69/0x80
[ 2035.976000]  [<c0251195>] driver_attach+0x25/0x30
[ 2035.976000]  [<c02510f0>] __driver_attach+0x0/0x80
[ 2035.976000]  [<c0250968>] bus_add_driver+0x88/0xd0
[ 2035.976000]  [<f8b0b00f>] init_ide_cs+0xf/0x11 [ide_cs]
[ 2035.976000]  [<c0139f32>] sys_init_module+0xf2/0x190
[ 2035.976000]  [<c02e3105>] sysenter_past_esp+0x56/0x79
[ 2035.976000]  [<c02e007b>] inet6_lookup_listener+0x2b/0x100
[ 2035.976000] ide2: I/O resource 0xF8B0200E-0xF8B0200E not free.
[ 2035.976000] ide2: ports already in use, skipping probe
[ 2035.976000] conflict: PCI IO[0->ffff]
[ 2035.976000] hwif_request_region: single-byte request for ide2
[ 2035.976000]  [<c0257386>] hwif_request_region+0xa6/0xb0
[ 2035.976000]  [<c02574bf>] ide_hwif_request_regions+0x12f/0x150
[ 2035.976000]  [<c0257177>] init_hwif_default+0x37/0x120

[snip 1400 lines more]

-andy
