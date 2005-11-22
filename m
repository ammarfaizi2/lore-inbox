Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbVKVSb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbVKVSb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbVKVSb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:31:26 -0500
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:395 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S965093AbVKVSbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:31:24 -0500
Date: Tue, 22 Nov 2005 19:31:17 +0100 (CET)
From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Marvell SATA fixes v2
In-Reply-To: <Pine.LNX.4.63.0511211311260.22263@dingo.iwr.uni-heidelberg.de>
Message-ID: <Pine.LNX.4.63.0511221809430.24388@dingo.iwr.uni-heidelberg.de>
References: <437D2DED.5030602@pobox.com>
 <Pine.LNX.4.44.0511182241420.5095-100000@kenzo.iwr.uni-heidelberg.de>
 <20051118215209.GA9425@havoc.gtf.org> <Pine.LNX.4.63.0511211311260.22263@dingo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Bogdan Costescu wrote:

> This was a SMP kernel running on an Intel PIV with HyperThreading 
> and with 2 disks attached to the controller. I'll try to get this 
> crash again with serial console...

I seem to have some problems getting the serial console to work, but 
in the mean time I have some more results, this time using a UP 
kernel (again without MSI and libata DEBUG):

1. several badblocks tests finished fine; the speed is also fine 
(about 50Mbytes/s both read and write as reported by both iostat 
during badblocks and bonnie++ on an ext2 FS).

2. I know that we are not yet talking about hotplugging, but this 
is what happens if you do it (unplug) :-)

Badness in mv_channel_reset at /root/sata_mv/sata_mv.c:1701 (Not 
tainted)
  [<f8955282>] mv_channel_reset+0xe3/0xed [sata_mv]
  [<f89552b0>] mv_stop_and_reset+0x24/0x2d [sata_mv]
  [<f8954ae0>] mv_host_intr+0x13d/0x17c [sata_mv]
  [<f8954b92>] mv_interrupt+0x73/0xeb [sata_mv]
  [<c0141f0d>] handle_IRQ_event+0x2e/0x5a
  [<c0141fb7>] __do_IRQ+0x7e/0xd7
  [<c0104e7e>] do_IRQ+0x4a/0x82
  =======================
  [<c01038ca>] common_interrupt+0x1a/0x20
  [<c023a35f>] acpi_safe_halt+0x22/0x2c
  [<c023a472>] acpi_processor_idle+0x109/0x27a
  [<c01010c1>] cpu_idle+0x40/0x58
  [<c03f873f>] start_kernel+0x15b/0x1b2
  [<c03f831d>] unknown_bootoption+0x0/0x1b6
Badness in __msleep at /root/sata_mv/sata_mv.c:1721 (Not tainted)
  [<f8955649>] __mv_phy_reset+0x390/0x405 [sata_mv]
  [<c0111923>] delay_tsc+0xb/0x13
  [<c01e7659>] __delay+0x9/0xa
  [<f8954ae0>] mv_host_intr+0x13d/0x17c [sata_mv]
  [<f8954b92>] mv_interrupt+0x73/0xeb [sata_mv]
  [<c0141f0d>] handle_IRQ_event+0x2e/0x5a
  [<c0141fb7>] __do_IRQ+0x7e/0xd7
  [<c0104e7e>] do_IRQ+0x4a/0x82
  =======================
  [<c01038ca>] common_interrupt+0x1a/0x20
  [<c023a35f>] acpi_safe_halt+0x22/0x2c
  [<c023a472>] acpi_processor_idle+0x109/0x27a
  [<c01010c1>] cpu_idle+0x40/0x58
  [<c03f873f>] start_kernel+0x15b/0x1b2
  [<c03f831d>] unknown_bootoption+0x0/0x1b6
ata4: no device found (phy stat 00000000)

The acpi_* stuff might be due to the fact that this interrupt is taken 
over first by ACPI and later assigned also to sata_mv; this happens 
only with the UP kernel, for the SMP kernel sata_mv did not share the 
interrupt.

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
