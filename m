Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266141AbUHATXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266141AbUHATXa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 15:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUHATXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 15:23:30 -0400
Received: from mra04.ex.eclipse.net.uk ([212.104.129.139]:49374 "EHLO
	mra04.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S266177AbUHATWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 15:22:49 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: PATCH: Add support for IT8212 IDE controllers
Date: Sun, 1 Aug 2004 20:22:28 +0100
User-Agent: KMail/1.6.2
References: <20040731232227.GA28455@devserv.devel.redhat.com>
In-Reply-To: <20040731232227.GA28455@devserv.devel.redhat.com>
Cc: Alan Cox <alan@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408012022.42516.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 Aug 2004 00:22, Alan Cox wrote:
> There is a messy scsi faking vendor driver for this card but this instead
> is a standard Linux IDE layer driver.
> + *  Documentation available from
> + *     http://www.ite.com.tw/pc/IT8212F_V04.pdf

A newer version than the one I have.  Looks like there's at least one newer 
chip revision than the 0x11 that I have too.

Just need to add something like this to get it to compile.

--- linux-2.6.8-rc2/include/linux/pci_ids.h.it8212	2004-08-01 
18:44:08.000000000 +0100
+++ linux-2.6.8-rc2/include/linux/pci_ids.h	2004-08-01 19:14:44.000000000 
+0100
@@ -1634,6 +1634,7 @@
 #define PCI_VENDOR_ID_ITE		0x1283
 #define PCI_DEVICE_ID_ITE_IT8172G	0x8172
 #define PCI_DEVICE_ID_ITE_IT8172G_AUDIO 0x0801
+#define	PCI_DEVICE_ID_ITE_8212		0x8212
 #define PCI_DEVICE_ID_ITE_8872		0x8872
 #define PCI_DEVICE_ID_ITE_IT8330G_0	0xe886
 
---

Some quick test results I just got.  My set up is a IT8212 PCI card running 
two UDMA133 discs in software RAID0.  I'd like to test the smart RAID some 
time, but that isn't really practical at the moment.

    IT8212: IDE controller at PCI slot 0000:00:0c.0
    ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 17
    IT8212: chipset revision 17
    IT8212: 100% native mode on irq 17

That makes sense.

        ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:pio, hdf:pio
    it8212: controller in RAID mode.

That doesn't.  I have no RAID sets defined in the IT8212 card BIOS.  BTW, the 
BIOS is an old one and should be updated.  However when I tried the updater 
claimed success, but on reboot it hadn't changed.

        ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:pio, hdh:pio
    hde: Maxtor 6Y120P0, ATA DISK drive
    it8212: selected 50MHz clock.

Nor does this as it really should be using the 66MHz clock setting.

    ide2 at 0xb000-0xb007,0xa802 on irq 17
    hde: max request size: 128KiB
    hde: recal_intr: status=0x51 { DriveReady SeekComplete Error }
    hde: recal_intr: error=0x04 { DriveStatusError }

Any idea what could be causing this?  My hacked driver doesn't get this in 
2.6.7, but then it could be a 2.6.8 problem.

    hde: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63, 
UDMA(33)

Oddly my driver reports UDMA(33) too, but that's probably bad coding as it is 
definitely running faster than that.

     /dev/ide/host2/bus0/target0/lun0: p1 p2
    hdg: Maxtor 6Y120P0, ATA DISK drive
    it8212: selected 50MHz clock.
    ide3 at 0xa400-0xa407,0xa002 on irq 17
    hdg: max request size: 128KiB
    hdg: recal_intr: status=0x51 { DriveReady SeekComplete Error }
    hdg: recal_intr: error=0x04 { DriveStatusError }
    hdg: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63, 
UDMA(33)
     /dev/ide/host2/bus1/target0/lun0: p1 p2

And the same speed problems again.

Now some speed tests with hdparm

# hdparm -Tt /dev/hd[eg] /dev/md[01]

/dev/hde:
 Timing buffer-cache reads:   3016 MB in  2.00 seconds = 1505.97 MB/sec
 Timing buffered disk reads:   86 MB in  3.02 seconds =  28.49 MB/sec

/dev/hdg:
 Timing buffer-cache reads:   3012 MB in  2.00 seconds = 1504.72 MB/sec
 Timing buffered disk reads:   86 MB in  3.02 seconds =  28.46 MB/sec

/dev/md0:
 Timing buffer-cache reads:   2928 MB in  2.00 seconds = 1462.03 MB/sec
 Timing buffered disk reads:  156 MB in  3.01 seconds =  51.90 MB/sec

/dev/md1:
 Timing buffer-cache reads:   2996 MB in  2.00 seconds = 1495.98 MB/sec
 Timing buffered disk reads:  156 MB in  3.01 seconds =  51.77 MB/sec

So I guess it actually is running at 33MHz!

Current results with my hack

# hdparm -Tt /dev/hd[eg] /dev/md[01]

/dev/hde:
 Timing buffer-cache reads:   2980 MB in  2.00 seconds = 1488.74 MB/sec
 Timing buffered disk reads:  172 MB in  3.02 seconds =  57.04 MB/sec

/dev/hdg:
 Timing buffer-cache reads:   2988 MB in  2.00 seconds = 1493.48 MB/sec
 Timing buffered disk reads:  170 MB in  3.03 seconds =  56.15 MB/sec

/dev/md0:
 Timing buffer-cache reads:   2964 MB in  2.00 seconds = 1480.74 MB/sec
 Timing buffered disk reads:  286 MB in  3.00 seconds =  95.25 MB/sec

/dev/md1:
 Timing buffer-cache reads:   2924 MB in  2.00 seconds = 1460.03 MB/sec
 Timing buffered disk reads:  290 MB in  3.01 seconds =  96.33 MB/sec

-- 
Ian.
