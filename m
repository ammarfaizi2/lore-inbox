Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbUK1PNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUK1PNA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 10:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbUK1PMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 10:12:50 -0500
Received: from smtp1.suscom.net ([64.78.119.248]:59270 "EHLO smtp1.suscom.net")
	by vger.kernel.org with ESMTP id S261491AbUK1PLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 10:11:05 -0500
Date: Sun, 28 Nov 2004 10:09:14 -0500
From: Eric Brundick <kernel@spirilis.net>
To: linux-kernel@vger.kernel.org
Subject: [IDE] Need assistance on a Silicon Image 680-based board
Message-ID: <20041128150914.GA2556@riker.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-Mailer-Agent: Mutt (1.2.5i for UNIX)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-
I have recently purchased an IDE Host Adapter card based on the Silicon Image 680 chipset.
The board is a Creative I/O UW-A133RPCI-A01.  User manual says "ULTRA ATA/133 IDE RAID CONTROLLER
CARD SIL680-RAID."
The board's chipset itself says:
"Silicon Image
 Sil0680 ACL144
 4E0032
 0411"
Elsewhere on the board there is a marking near the PCI edge connector which says: "SIL0680 REV:E"

First off, I am using a SuSE kernel with this-- kernel-source-2.6.5-7.111.i586.rpm was used to produce
the /usr/src/linux source code.  I should be able to attempt this with a vanilla kernel tarball if necessary.
The system is an AMD Athlon 900 running on a VIA chipset board, possibly a KT133.

I noticed Linux already has a driver installed for the SiL680 boards, located in drivers/ide/pci/siimage.c

The first problem I noticed is Linux did not detect the card at all.  A quick lspci -vv revealed:
0000:00:08.0 RAID bus controller: Unknown device 0095:0680 (rev 02)
        Subsystem: Unknown device 0095:3680
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 64, cache line size 01
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at ec00 [size=ffe00000]
        Region 1: I/O ports at e880 [size=4]
        Region 2: I/O ports at e800 [size=8]
        Region 3: I/O ports at e480 [size=4]
        Region 4: I/O ports at e400 [size=16]
        Region 5: Memory at ffefec00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 00080000 [disabled]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

Apparently the manufacturer used 0095 for the vendor ID, rather than 1095 as is listed for Silicon Image in
drivers/pci/pci.ids.  Hoping that's all it is, I modified drivers/pci/pci.ids and changed the PCI ID for
Silicon Image/CMD to 0095, and did the same in include/linux/pci_ids.h.
Rebuilt the kernel, building siimage as a module (siimage.ko)

Upon bootup, I get the following relevant messages:
SiI680: IDE controller at PCI slot 0000:00:08.0
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133
SiI680: 100% native mode on irq 10
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
hde: 377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377, ATA DISK drive
------------[ cut here ]------------
kernel BUG at drivers/ide/pci/siimage.c:220!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<d2e32440>]    Tainted: P  U
EFLAGS: 00010206   (2.6.5-7.111-default)
EIP is at siimage_ratemask+0x110/0x120 [siimage]
eax: 00000030   ebx: c0447e38   ecx: 00000005   edx: 00000680
esi: c0447ee4   edi: 00000000   ebp: c0447e38   esp: c9bd9e94
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1916, threadinfo=c9bd8000 task=cd5b2c50)
Stack: 00000216 ff448384 c0447ee4 ca4d6200 c0447e38 d2e32989 c0447ee4 00000001
       d2e328e0 c025a7dc 0000000a c9bd9ed8 0000000a ca498080 00000001 0000000a
       00000286 00000000 00000002 c0447e38 cdf91800 d2e34820 d2e320c0 c025a9b1
Call Trace:
 [<d2e32989>] siimage_config_drive_for_dma+0xa9/0x110 [siimage]
 [<d2e328e0>] siimage_config_drive_for_dma+0x0/0x110 [siimage]
 [<c025a7dc>] probe_hwif+0x52c/0x5d0
 [<d2e320c0>] siimage_init_one+0x0/0x40 [siimage]
 [<c025a9b1>] probe_hwif_init+0x11/0x59
 [<c025e30f>] ide_setup_pci_device+0x3f/0x70
 [<d2e320ee>] siimage_init_one+0x2e/0x40 [siimage]
 [<c01ee3be>] pci_device_probe+0x9e/0x150
 [<c022c432>] bus_match+0x32/0x70
 [<c022c62f>] driver_attach+0x4f/0x90
 [<c01e4b02>] kobject_register+0x22/0x5f
 [<c022c6fc>] bus_add_driver+0x8c/0xc0
 [<c022cbf8>] driver_register+0x28/0x30
 [<c01ee5d6>] pci_register_driver+0x56/0xb0
 [<c025d51b>] ide_pci_register_driver+0x5b/0x70
 [<c01384da>] sys_init_module+0x13a/0x240
 [<c0107f59>] sysenter_past_esp+0x52/0x71

Code: 0f 0b dc 00 4f 32 e3 d2 e9 55 ff ff ff 8d 76 00 83 ec 14 89

The drive attached, FYI, is a WD136AA (13.6 GB) configured as master and connected to its
first host adapter port.  The data on it is useless so I don't care if it is nuked.

So at this point I suppose the card doesn't behave like the baseline card used to develop the siimage.c
module.
The failure occurs in siimage_ratemask inside siimage.c:
/**
 *      siimage_ratemask        -       Compute available modes
 *      @drive: IDE drive
 *
 *      Compute the available speeds for the devices on the interface.
 *      For the CMD680 this depends on the clocking mode (scsc), for the
 *      SI3312 SATA controller life is a bit simpler. Enforce UDMA33
 *      as a limit if there is no 80pin cable present.
 */

static byte siimage_ratemask (ide_drive_t *drive)
{
        ide_hwif_t *hwif        = HWIF(drive);
        u8 mode = 0, scsc = 0;
        unsigned long base = (unsigned long) hwif->hwif_data;

        if (hwif->mmio)
                scsc = hwif->INB(base + 0x4A);
        else
                pci_read_config_byte(hwif->pci_dev, 0x8A, &scsc);

        if(is_sata(hwif))
        {
                if(strstr(drive->id->model, "Maxtor"))
                        return 3;
                return 4;
        }

        if ((scsc & 0x30) == 0x10)      /* 133 */
                mode = 4;
        else if ((scsc & 0x30) == 0x20) /* 2xPCI */
                mode = 4;
        else if ((scsc & 0x30) == 0x00) /* 100 */
                mode = 3;
        else    /* Disabled ? */
                BUG();

        if (!eighty_ninty_three(drive))
                mode = min(mode, (u8)1);
        return mode;
}

Apparently it reaches the BUG(); line.

To understand why, I added a printk messages to display the value of 'base' and 'scsc', rebuilt the module
and rebooted the system.  The resulting output (truncated the BUG() output to keep this email from reaching the
stars):
SiI680: 100% native mode on irq 10
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
hde: 377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377377, ATA DISK drive
hwif->INB(base=0xd2e45c00 + 0x4A) = 0xff
------------[ cut here ]------------
kernel BUG at drivers/ide/pci/siimage.c:221!

The value of 0xff doesn't match any of the if() statements which attempt to determine the speed. (PCI bus speed?)

Yesterday I tried putting a "return 4;" right before the "if ((scsc & 0x30) == 0x10) /* 133 */" statement.
The kernel booted, it detected the drive, however there were tons of block I/O errors for /dev/hde, and it detected
the drive as some ungodly-huge size, well over a thousand terabytes.  So clearly something else is incompatible with
the driver, besides this mere siimage_ratemask() function.

I appreciate any comments or assistance in getting this working.
Thanks
-Eric
