Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312385AbSCYKE3>; Mon, 25 Mar 2002 05:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312384AbSCYKEU>; Mon, 25 Mar 2002 05:04:20 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:46853
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312382AbSCYKEF>; Mon, 25 Mar 2002 05:04:05 -0500
Date: Mon, 25 Mar 2002 02:03:27 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
cc: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18: many IDE errors
In-Reply-To: <3C9DC64F.DDC57F4D@eyal.emu.id.au>
Message-ID: <Pine.LNX.4.10.10203250143250.6920-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2002, Eyal Lebedinsky wrote:

> If I understand correctly, the basic answer is that this is not
> a driver issue, and not a general kernel (irq's etc.) either, but
> a true hardware problem.
> 
> 
> Andre Hedrick wrote:
> > 
> > It is not a case of bad cables but maybe cable routing.
> 
> I am not clear on what cable routing means. Can you elaborate?

If you have many cable (note there are random ways to construct, odd/even)
You can get crosstalk (aka 0x51/0x84 kernel noise).  These messages are
telling you the hardware checksum between the HOST and DEVICE failed.
The solution is to retry, and the driver does.

Now the problem becomes if you have to many of these your IO falls to the
floor.  Thus I architected the original auto-dma down grade solution and
shared the results w/ Intel.  They and I had the same idea but not sure
who first, but Linux (me) did it first and provide it could be done.

That is why you see a snappy reset message.

It tests for any other errors and of there are only iCRC's, the driver
intercepts the error path and redirects it to reduce the IO transfer rate.

This is all perfectly safe and legal in the standard.

We have suspend IO in there error handler, and because it is iCRC the
device is expecting a retry, but first we clean up the DMA messes.
Next we respeed the host-device pair by one transfer rate in a down grade.
End the request and or issue it to retry back to through the main loop.

It is simple but not done before until Linux, and now it is very much a
quite and the right thing to do.

Now this process repeats until the crosstalk goes away.
That is what you are seeing.

To prove it is real, you can tell your drives to jump back into mode 5.

hdparm -X69 /dev/hde /dev/hdg /dev/hdi /dev/hdk

Do a simple read w/ '-t' and watch it repeat the down grade again.
One of the things not added is a perform return based on load drops.

I hope this helps.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

PS other info below too.


> > Also, four 160GB disks eat power!
> 
> Well, these disks (4G160J8) are 5400rpm, They spin up just fine
> and according to spec they each use under 300ma@12v and 400ma@5v
> (active, 5.2W actually) which is not that much.
> 
> This is not to say that just because the power supply can deliver
> the power, the power is clean enough.

But individual lines will draw difference values.
Do you know what each line looks like when you load the system?

> > I have a box dual athlon similar setup w/ 460W ps
> > I have to wait for the PS to warm up or there is not enough juice to
> > properly spin up the last drive.  However if I replace the four 160GB's
> > with four 20GB Seagate's no problem.
> 
> A bootup is always clean, and when not stressed it can go for a long
> while
> without any errors. However once pushed I start seeing these failures.

This is system loading and if a PS becomes marginal on any line, drives
suffer.  The mode 6 clocking is very fragile and sensitive, even mode 5
had issues in the past.

> > 
> > You are going to need at least a 400W PS w/ almost no ripple to make it
> > work.  If you have this then check the cable routing.
> > 
> > Also hdparm -i /dev/hdX to see if their transfer rates are reduced.
> 
> I will check the situation. I know they come up ATA-5. Here are the
> relevant bootup messages:
> 
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> VP_IDE: IDE controller on PCI bus 00 dev 39
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA

First disable unmasking VIA it makes a mess. :-/

This (CMD649) is a good HOST and Linux can deal nicely.

> CMD649: IDE controller on PCI bus 00 dev 50
> PCI: Found IRQ 5 for device 00:0a.0
> CMD649: chipset revision 1
> CMD649: not 100% native mode: will probe irqs later
> CMD649: ROM enabled at 0xdff00000
>     ide2: BM-DMA at 0xc000-0xc007, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xc008-0xc00f, BIOS settings: hdg:pio, hdh:pio
> CMD649: IDE controller on PCI bus 00 dev 60
> PCI: Found IRQ 12 for device 00:0c.0
> CMD649: chipset revision 2
> CMD649: not 100% native mode: will probe irqs later
> CMD649: ROM enabled at 0xdfe80000
>     ide4: BM-DMA at 0xac00-0xac07, BIOS settings: hdi:pio, hdj:pio
>     ide5: BM-DMA at 0xac08-0xac0f, BIOS settings: hdk:pio, hdl:pio
> hda: WDC WD600BB-00BSA0, ATA DISK drive
> hdc: WDC WD600BB-00BSA0, ATA DISK drive
> hdd: ATAPI CD ROM DRIVE 50X MAX, ATAPI CD/DVD-ROM drive
> hde: Maxtor 4G160J8, ATA DISK drive
> hdg: Maxtor 4G160J8, ATA DISK drive
> hdi: Maxtor 4G160J8, ATA DISK drive
> hdk: Maxtor 4G160J8, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0xd000-0xd007,0xcc02 on irq 5
> ide3 at 0xc800-0xc807,0xc402 on irq 5
> ide4 at 0xbc00-0xbc07,0xb802 on irq 12
> ide5 at 0xb400-0xb407,0xb002 on irq 12
> hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=7297/255/63,
> UDMA(100)
> hdc: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63,
> UDMA(100)
> hde: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63,
> UDMA(100)
> hdg: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63,
> UDMA(100)
> hdi: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63,
> UDMA(100)
> hdk: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63,
> UDMA(100)

