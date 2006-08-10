Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161093AbWHJHqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbWHJHqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 03:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbWHJHqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 03:46:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:57030 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161091AbWHJHqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 03:46:06 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: 2.6.18-rc4 Intermittent failures to detect sata disks 
In-reply-to: Your message of "Wed, 09 Aug 2006 07:48:39 -0400."
             <44D9CB97.6050407@pobox.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 10 Aug 2006 17:43:58 +1000
Message-ID: <10085.1155195838@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik (on Wed, 09 Aug 2006 07:48:39 -0400) wrote:
>Keith Owens wrote:
>> This problem has been occurring since at least 2.6.18-rc2.  Standard
>
>What was the last kernel that passed your test(s) consistently? 
>2.6.18-rc1?  2.6.17?  Earlier?

Summary:

  2.6.16.27 is OK.  2.6.17.7 will sometimes freeze, but does not appear
  to have any problems reading pcs.  2.6.18-rc1 will sometimes freeze,
  sometimes get the wrong pcs.  2.6.18-rc4 often gets the wrong pcs.

  Adding the kdb patch and turning on kdb debug options makes the sata
  bugs more likely to occur.  Timing effects or VM usage changes?

  Doing a hard power cycle seems to make the bug more likely to occur.
  This could just be an artifact.

  This machine has dual Xeons.  If I run them in x86_64 mode, I never
  get any SATA problems.  the problems only occur in i386 mode.  lspci
  reports

    00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
	    Subsystem: Dell PowerEdge SC1425
	    Flags: bus master, medium devsel, latency 0, IRQ 17
	    I/O ports at <unassigned>
	    I/O ports at <unassigned>
	    I/O ports at <unassigned>
	    I/O ports at <unassigned>
	    I/O ports at fc00 [size=16]
	    Memory at 80000000 (32-bit, non-prefetchable) [size=1K]

    00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
	    Subsystem: Dell PowerEdge SC1425
	    Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 17
	    I/O ports at ccb8 [size=8]
	    I/O ports at ccb0 [size=4]
	    I/O ports at cca0 [size=8]
	    I/O ports at cc98 [size=4]
	    I/O ports at cc80 [size=16]

After running some soak tests, I found another SATA problem.  Sometimes
the machine will freeze after the debug statement that prints
'scsi0 : ata_piix' or 'scsi1 : ata_piix'.  The next lines would normally be

   Vendor: ATA       Model: WDC WD800JD-75JN  Rev: 06.0
   Type:   Direct-Access                      ANSI SCSI revision: 05

but they do not appear.  This bug appears to be independent of the
"wrong pcs" value, if the machine freezes then the code may or not not
have read 0x33 from pcs.

2.6.16.27:  No problems hit in 70+ cycles.

2.6.17.7:  It only hit the freeze problem, pcs was always 0x33.  Took
about 50 cycles to hang.  Typical debug trace for the freeze.

    [17179578.528000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
    [17179578.608000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    [17179578.708000] ICH5: IDE controller at PCI slot 0000:00:1f.1
    [17179578.776000] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
    [17179578.844000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
    [17179578.936000] ICH5: chipset revision 2
    [17179578.984000] ICH5: not 100% native mode: will probe irqs later
    [17179579.056000]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    [17179579.880000] hda: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive
    [17179580.624000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    [17179581.248000] piix_init: pci_module_init
    [17179581.296000] ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
    [17179581.360000] ata_pci_init_one: ENTER
    [17179581.408000] ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
    [17179581.500000] ata_device_add: ENTER
    [17179581.540000] ata_host_add: ENTER
    [17179581.580000] ata_port_start: prd alloc, virt f74bf000, dma 374bf000
    [17179581.660000] ata1: SATA max UDMA/133 cmd 0xCCB8 ctl 0xCCB2 bmdma 0xCC80 irq 17
    [17179581.748000] ata_host_add: ENTER
    [17179581.788000] ata_port_start: prd alloc, virt f792e000, dma 3792e000
    [17179581.864000] ata2: SATA max UDMA/133 cmd 0xCCA0 ctl 0xCC9A bmdma 0xCC88 irq 17
    [17179581.956000] ata_device_add: probe begin
    [17179582.004000] ata_device_add: ata1: bus probe begin
    [17179582.064000] piix_sata_probe: ata1: ENTER, pcs=0x33 base=0
    [17179582.236000] piix_sata_probe: ata1: LEAVE, pcs=0x33 present_mask=0x1
    [17179582.480000] ata1: dev 0 ATA-6, max UDMA/100, 156250000 sectors: LBA
    [17179582.568000] ata1: dev 0 configured for UDMA/100
    [17179582.628000] scsi0 : ata_piix

2.6.18-rc1:  Demonstrates both the freeze and the invalid pcs problems.
Typical debug trace for the freeze.

    [    4.651187] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
    [    4.727174] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    [    4.822963] ICH5: IDE controller at PCI slot 0000:00:1f.1
    [    4.887527] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
    [    4.955239] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
    [    5.043933] ICH5: chipset revision 2
    [    5.086706] ICH5: not 100% native mode: will probe irqs later
    [    5.155466]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    [    5.977784] hda: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive
    [    6.720226] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    [    7.337442] piix_init: pci_module_init
    [    7.382303] ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
    [    7.444772] ata_pci_init_one: ENTER
    [    7.486528] ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
    [    7.575238] ata_device_add: ENTER
    [    7.614886] ata_host_add: ENTER
    [    7.652530] ata_port_start: prd alloc, virt c2217000, dma 2217000
    [    7.725389] ata1: SATA max UDMA/133 cmd 0xCCB8 ctl 0xCCB2 bmdma 0xCC80 irq 17
    [    7.810759] __ata_port_freeze: ata1 port frozen
    [    7.864964] ata_host_add: ENTER
    [    7.902583] ata_port_start: prd alloc, virt f7889000, dma 37889000
    [    7.976506] ata2: SATA max UDMA/133 cmd 0xCCA0 ctl 0xCC9A bmdma 0xCC88 irq 17
    [    8.061877] __ata_port_freeze: ata2 port frozen
    [    8.116088] ata_device_add: probe begin
    [    8.161985] scsi0 : ata_piix
    [    8.196513] ata_port_schedule_eh: port EH scheduled
    [    8.196516] ata_scsi_error: ENTER
    [    8.196520] ata_port_flush_task: ENTER
    [    8.339364] ata_port_flush_task: flush #1
    [    8.387357] ata_eh_autopsy: ENTER
    [    8.427018] ata_eh_recover: ENTER
    [    8.466689] ata_eh_prep_resume: ENTER
    [    8.510521] ata_eh_prep_resume: EXIT
    [    8.553302] __ata_port_freeze: ata1 port frozen
    [    8.607518] piix_sata_prereset: ata1: ENTER, pcs=0x33 base=0
    [    8.779571] piix_sata_prereset: ata1: LEAVE, pcs=0x33 present_mask=0x1
    [    9.012481] ata1.00: ATA-6, max UDMA/100, 156250000 sectors: LBA 
    [    9.085354] ata1.00: ata1: dev 0 multi count 8
    [    9.139411] ata1.00: configured for UDMA/100
    [    9.206276] scsi1 : ata_piix

Typical debug trace for the bad pcs.

    [    4.651183] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
    [    4.727174] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    [    4.822965] ICH5: IDE controller at PCI slot 0000:00:1f.1
    [    4.887528] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
    [    4.955240] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
    [    5.043934] ICH5: chipset revision 2
    [    5.086706] ICH5: not 100% native mode: will probe irqs later
    [    5.155467]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    [    5.977777] hda: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive
    [    6.720220] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    [    7.337437] piix_init: pci_module_init
    [    7.382377] ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
    [    7.444848] ata_pci_init_one: ENTER
    [    7.486601] ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
    [    7.575310] ata_device_add: ENTER
    [    7.614959] ata_host_add: ENTER
    [    7.652603] ata_port_start: prd alloc, virt f79f8000, dma 379f8000
    [    7.726500] ata1: SATA max UDMA/133 cmd 0xCCB8 ctl 0xCCB2 bmdma 0xCC80 irq 17
    [    7.811869] __ata_port_freeze: ata1 port frozen
    [    7.866072] ata_host_add: ENTER
    [    7.903696] ata_port_start: prd alloc, virt f7516000, dma 37516000
    [    7.977617] ata2: SATA max UDMA/133 cmd 0xCCA0 ctl 0xCC9A bmdma 0xCC88 irq 17
    [    8.062989] __ata_port_freeze: ata2 port frozen
    [    8.117200] ata_device_add: probe begin
    [    8.163098] scsi0 : ata_piix
    [    8.197631] ata_port_schedule_eh: port EH scheduled
    [    8.197635] ata_scsi_error: ENTER
    [    8.197639] ata_port_flush_task: ENTER
    [    8.340474] ata_port_flush_task: flush #1
    [    8.388465] ata_eh_autopsy: ENTER
    [    8.428130] ata_eh_recover: ENTER
    [    8.467802] ata_eh_prep_resume: ENTER
    [    8.511628] ata_eh_prep_resume: EXIT
    [    8.554418] __ata_port_freeze: ata1 port frozen
    [    8.608633] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [    8.780334] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [    8.857364] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [    9.028516] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [    9.105578] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [    9.276705] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [    9.353787] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [    9.524895] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [    9.601893] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [    9.773085] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [    9.850104] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   10.017262] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   10.094263] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   10.265452] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   10.342474] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   10.513642] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   10.590683] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   10.761831] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   10.838893] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   11.010021] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   11.087104] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   11.258211] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   11.335213] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   11.506401] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   11.583422] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   11.754590] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   11.831632] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   12.002780] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   12.079846] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   12.250961] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   12.328050] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   12.495147] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   12.572208] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   12.743337] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   12.820419] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   12.991527] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   13.068525] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   13.239716] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   13.316737] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   13.487906] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   13.564949] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   13.736096] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   13.813158] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   13.984286] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   14.061366] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   14.232475] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   14.309470] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   14.480665] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   14.557681] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   14.724835] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   14.801841] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   14.973024] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   15.050053] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   15.221214] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   15.298263] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   15.469404] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   15.546475] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   15.717594] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   15.794685] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   15.965783] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   16.042795] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   16.213973] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   16.291010] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   16.462163] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   16.539217] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   16.710352] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   16.787436] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   16.958543] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   17.035549] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   17.202720] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   17.279817] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   17.450910] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   17.527924] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   17.699099] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   17.776135] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   17.947289] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   18.024345] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   18.195479] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   18.272556] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   18.443668] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   18.520662] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   18.691858] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   18.768875] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   18.940048] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   19.017085] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   19.192234] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   19.269242] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   19.436403] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   19.513407] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   19.680581] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   19.757672] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   19.928771] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   20.005781] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   20.176960] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   20.253995] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   20.425150] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   20.502213] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   20.673340] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   20.750433] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   20.921530] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   20.998541] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   21.169719] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   21.246752] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   21.417909] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   21.494970] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   21.666099] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
    [   21.743196] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   21.910277] piix_sata_prereset: ata1: LEAVE, pcs=0x11 present_mask=0x1
    [   22.143494] ata1.00: ATA-6, max UDMA/100, 156250000 sectors: LBA 
    [   22.216385] ata1.00: ata1: dev 0 multi count 8
    [   22.270429] ata1.00: configured for UDMA/100
    [   22.334586] scsi1 : ata_piix
    [   22.628398] ata2.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 0/32)
    [   22.720008] ata2.00: ata2: dev 0 multi count 8
    [   22.774411] ata2.00: configured for UDMA/133
    [   22.825595]   Vendor: ATA       Model: WDC WD800JD-75JN  Rev: 06.0
    [   22.905984]   Type:   Direct-Access                      ANSI SCSI revision: 05
    [   22.993985]   Vendor: ATA       Model: ST3300622AS       Rev: 3.AA
    [   23.074331]   Type:   Direct-Access                      ANSI SCSI revision: 05
    [   23.162386] SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
    [   23.241566] sda: Write Protect is off
    [   23.285408] SCSI device sda: drive cache: write back
    [   23.344849] SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
    [   23.424037] sda: Write Protect is off
    [   23.467880] SCSI device sda: drive cache: write back
    [   23.527251]  sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 >
    [   23.692989] sd 0:0:0:0: Attached scsi disk sda
    [   23.746261] SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
    [   23.826482] sdb: Write Protect is off
    [   23.870323] SCSI device sdb: drive cache: write back
    [   23.929755] SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
    [   24.009883] sdb: Write Protect is off
    [   24.053723] SCSI device sdb: drive cache: write back
    [   24.113098]  sdb: sdb1 < sdb5 sdb6 sdb7 sdb8 >
    [   24.212091] sd 1:0:0:0: Attached scsi disk sdb

2.6.18-rc4:  The bug with the invalid pcs is so bad that I never get
more than a few cycles before the machine dies, so I cannot tell if
this kernel has the freeze bug or not.  Typical debug trace for the bad
pcs.

    [    8.030917] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
    [    8.106974] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    [    8.202771] ICH5: IDE controller at PCI slot 0000:00:1f.1
    [    8.267344] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
    [    8.335053] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
    [    8.423747] ICH5: chipset revision 2
    [    8.466530] ICH5: not 100% native mode: will probe irqs later
    [    8.535283]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    [    9.358354] hda: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive
    [   10.100806] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    [   10.718013] piix_init: pci_module_init
    [   10.762918] ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
    [   10.825398] ata_pci_init_one: ENTER
    [   10.867153] ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
    [   10.955863] ata_device_add: ENTER
    [   10.995516] ata_host_add: ENTER
    [   11.033166] ata_port_start: prd alloc, virt f74de000, dma 374de000
    [   11.107069] ata1: SATA max UDMA/133 cmd 0xCCB8 ctl 0xCCB2 bmdma 0xCC80 irq 17
    [   11.192441] __ata_port_freeze: ata1 port frozen
    [   11.246648] ata_host_add: ENTER
    [   11.284269] ata_port_start: prd alloc, virt f74d2000, dma 374d2000
    [   11.358197] ata2: SATA max UDMA/133 cmd 0xCCA0 ctl 0xCC9A bmdma 0xCC88 irq 17
    [   11.443573] __ata_port_freeze: ata2 port frozen
    [   11.497786] ata_device_add: probe begin
    [   11.543689] scsi0 : ata_piix
    [   11.578222] ata_port_schedule_eh: port EH scheduled
    [   11.578226] ata_scsi_error: ENTER
    [   11.578230] ata_port_flush_task: ENTER
    [   11.721086] ata_port_flush_task: flush #1
    [   11.769081] ata_eh_autopsy: ENTER
    [   11.808748] ata_eh_recover: ENTER
    [   11.848426] ata_eh_prep_resume: ENTER
    [   11.894053] ata_eh_prep_resume: EXIT
    [   11.936812] __ata_port_freeze: ata1 port frozen
    [   11.991030] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   12.057706] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   12.129579] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   12.196254] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   12.268122] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   12.334797] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   12.406675] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   12.473349] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   12.545220] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   12.611896] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   12.683769] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   12.750446] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   12.822319] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   12.888995] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   12.960867] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   13.027542] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   13.099417] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   13.166086] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   13.237957] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   13.304634] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   13.376506] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   13.443183] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   13.515055] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   13.581729] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   13.653599] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   13.720272] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   13.792149] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   13.858814] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   13.930684] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   13.997359] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   14.069229] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   14.135903] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   14.207773] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   14.274447] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   14.346317] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   14.412992] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   14.484865] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   14.551536] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   14.623406] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   14.690084] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   14.761957] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   14.828631] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   14.900502] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   14.967178] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   15.039048] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   15.105725] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   15.177597] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   15.244272] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   15.316145] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   15.382822] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   15.454691] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   15.521365] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   15.593237] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   15.659913] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   15.731783] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   15.798459] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   15.870332] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   15.937002] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   16.008873] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   16.075545] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   16.147414] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   16.214088] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   16.285959] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   16.352634] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   16.424504] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   16.491179] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   16.563051] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   16.629723] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   16.701596] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   16.768271] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   16.840144] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   16.906820] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   16.978689] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   17.045362] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   17.117233] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   17.183909] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   17.255783] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   17.322459] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   17.394328] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   17.461003] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   17.532871] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   17.599544] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   17.671414] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   17.738089] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   17.809958] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   17.876632] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   17.948509] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   18.015179] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   18.087048] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   18.153724] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   18.225595] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   18.292269] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   18.364138] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   18.430810] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   18.502679] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   18.569352] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   18.641231] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   18.707896] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   18.779765] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   18.846439] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   18.918309] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   18.984982] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   19.056853] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   19.123526] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   19.195396] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   19.262070] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   19.333947] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   19.400615] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   19.472484] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   19.539158] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   19.611029] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   19.677705] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   19.749573] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   19.816247] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   19.888117] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   19.954795] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   20.026671] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   20.093341] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   20.165211] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   20.231888] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   20.303759] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   20.370433] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   20.442302] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   20.508978] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   20.580849] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   20.647525] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   20.719405] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   20.786075] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   20.857950] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   20.924631] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   20.996508] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   21.063184] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   21.135054] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   21.201731] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   21.273606] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   21.340282] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   21.412158] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   21.478832] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   21.550707] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   21.617386] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   21.689259] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   21.755936] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   21.827809] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   21.894484] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   21.966356] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   22.033033] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   22.104916] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   22.171586] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   22.243463] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   22.310143] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   22.382018] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   22.448699] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   22.520575] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   22.587251] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   22.659126] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   22.725804] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   22.797680] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   22.864359] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   22.936234] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   23.002913] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   23.074788] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   23.141463] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   23.213338] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   23.280014] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   23.351885] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   23.418565] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   23.490441] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   23.557122] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   23.629001] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   23.695680] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   23.767557] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   23.834239] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   23.906116] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   23.972796] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   24.044675] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   24.111354] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   24.183229] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   24.249909] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   24.323595] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   24.390234] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   24.462111] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   24.528793] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   24.600670] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   24.667348] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   24.739225] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   24.805901] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   24.877775] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   24.944450] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   25.016324] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   25.083001] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   25.154872] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   25.221550] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   25.293422] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   25.360104] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   25.431975] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   25.498655] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   25.570528] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   25.637202] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   25.709072] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
    [   25.775746] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present=0x0
    [   25.847615] ata1: SATA port has no device.
    [   25.911652] scsi1 : ata_piix
    [   25.946230] ata2: SATA port has no device.

