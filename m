Return-Path: <linux-kernel-owner+w=401wt.eu-S1030420AbWLOX7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbWLOX7q (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 18:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbWLOX7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 18:59:45 -0500
Received: from aun.it.uu.se ([130.238.12.36]:56649 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030420AbWLOX7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 18:59:44 -0500
X-Greylist: delayed 1421 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 18:59:44 EST
Date: Sat, 16 Dec 2006 00:35:00 +0100 (MET)
Message-Id: <200612152335.kBFNZ0tu003064@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: akpm@osdl.org, jirislaby@gmail.com
Subject: Re: OOPS: deref 0x14 at pdc_port_start+0x82 [Was: 2.6.20-rc1-mm1]
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       mikpe@it.uu.se
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006 11:24:12 -0800, Andrew Morton wrote:
>On Fri, 15 Dec 2006 15:45:55 +0059
>Jiri Slaby <jirislaby@gmail.com> wrote:
>
>> Andrew Morton wrote:
>> > Temporarily at
>> > 
>> > 	http://userweb.kernel.org/~akpm/2.6.20-rc1-mm1/
>> > 
>> > Will appear later at
>> > 
>> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc1/2.6.20-rc1-mm1/
>> 
>> The kernel panics at boot in pdc_port_start+0x82 with deref of 0x14:
>> http://www.fi.muni.cz/~xslaby/sklad/pdc_oops.png
>> 
>> ATA port is not connected, only 2 SATA disks on my
>> # lspci -vvxs 02:01.0
>> 02:01.0 Mass storage controller: Promise Technology, Inc. PDC40775 (SATA 300
>> TX2plus) (rev 02)
>>         Subsystem: Promise Technology, Inc. PDC40775 (SATA 300 TX2plus)
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B-
>>         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 72 (1000ns min, 4500ns max), Cache Line Size: 4 bytes
>>         Interrupt: pin A routed to IRQ 19
>>         Region 0: I/O ports at 8000 [size=128]
>>         Region 2: I/O ports at 8400 [size=256]
>>         Region 3: Memory at fb025000 (32-bit, non-prefetchable) [size=4K]
>>         Region 4: Memory at fb000000 (32-bit, non-prefetchable) [size=128K]
>>         [virtual] Expansion ROM at 50000000 [disabled] [size=32K]
>>         Capabilities: [60] Power Management version 2
>>                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>> 00: 5a 10 73 3d 07 00 30 02 02 00 80 01 01 48 00 00
>> 10: 01 80 00 00 00 00 00 00 01 84 00 00 00 50 02 fb
>> 20: 00 00 00 fb 00 00 00 00 00 00 00 00 5a 10 73 3d
>> 30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 01 04 12
>> 
>
>Presumably
>
>                void __iomem *mmio = (void __iomem *) ap->ioaddr.scr_addr;
>
>gave us a null pointer.

Yes, it does look like pdc_port_start() is invoked with scr_addr
being zero for the port.

The -mm patch kit includes the Promise 2037x PATA support patch,
via libata-all. That patch is incomplete and actually breaks 2057x
chips: it leaves the SATA flag set for all ports on 2057x, which
makes sata_scr_valid() erroneously return true for the PATA port,
and that breaks many things including pdc_port_start().

Applying the trivial patch below on top of 2.6.20-rc1-mm1 should
fix the oops and even make the PATA port work on the 2057x.
With this patch -mm1's sata_promise.c will match what I've been
using recently to access both SATA and PATA devices on 2057x.

/Mikael

diff -rupN linux-2.6.20-rc1-mm1/drivers/ata/sata_promise.c linux-2.6.20-rc1-mm1.sata_promise-2057x-pata-fix/drivers/ata/sata_promise.c
--- linux-2.6.20-rc1-mm1/drivers/ata/sata_promise.c	2006-12-15 23:33:17.000000000 +0100
+++ linux-2.6.20-rc1-mm1.sata_promise-2057x-pata-fix/drivers/ata/sata_promise.c	2006-12-15 23:58:09.000000000 +0100
@@ -213,7 +213,7 @@ static const struct ata_port_info pdc_po
 	/* board_2057x */
 	{
 		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
+		.flags		= PDC_COMMON_FLAGS /* | ATA_FLAG_SATA */,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
