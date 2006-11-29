Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934343AbWK2GFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934343AbWK2GFG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 01:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934395AbWK2GFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 01:05:06 -0500
Received: from smtp.flash.net.br ([201.46.240.48]:52623 "EHLO
	smtp.gru.flash.tv.br") by vger.kernel.org with ESMTP
	id S934343AbWK2GFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 01:05:04 -0500
Date: Wed, 29 Nov 2006 04:01:30 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Cc: rbrito@gmail.com
Subject: The return of the dreaded "nobody cared" message with a Promise Card
Message-ID: <20061129060130.GA2913@ime.usp.br>
Reply-To: rbrito@ime.usp.br, rbrito@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew, hi Alan, hi others.

First of all, I would kindly ask you that you keep me in the Cc'ed
messages.

I'm currently finishing grades of (loads and loads) of students and I'm
having a hard time keeping up with my health problems and real life
work, let alone the traffic of lkml.

Well, let me get straight to the problem. I have an Asus A7V (Classic)
motherboard with a VIA KT133 chipset and it has the two usual VIA IDE
controllers and two extra Promise PDC20265 controllers. Right now, my
setup is the following (given advice that once Alan gave me, but he may
not recall it):

* hda: DVD+-RW burner;
* hdc: Plain CD-ROM reader;
* hde: Seagate ST3160021A (7200.??) drive;
* hdg: QUANTUM FIREBALLlct15 30 drive.

The problem is that whenever I plug the Quantum drive, I get stack
traces like this one (with a bit of context, so that you can get sense of
what I am talking about):

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ide1 at 0x170-0x177,0x376 on irq 15
PDC20265: IDE controller at PCI slot 0000:00:11.0
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
PDC20265: chipset revision 2
PDC20265: ROM enabled at 0x30000000
PDC20265: 100% native mode on irq 10
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x7400-0x7407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x7408-0x740f, BIOS settings: hdg:DMA, hdh:pio
Probing IDE interface ide2...
hde: ST3160021A, ATA DISK drive
ide2 at 0x8800-0x8807,0x8402 on irq 10
Probing IDE interface ide3...
hdg: QUANTUM FIREBALLlct15 30, ATA DISK drive
irq 10: nobody cared (try booting with the "irqpoll" option)
 [<c0103ee6>] show_trace_log_lvl+0x58/0x16a
 [<c010451d>] show_trace+0xd/0x10
 [<c010463c>] dump_stack+0x19/0x1b
 [<c0132dda>] __report_bad_irq+0x2e/0x6f
 [<c0132fba>] note_interrupt+0x19f/0x1d5
 [<c0132684>] __do_IRQ+0xb5/0xeb
 [<c0105511>] do_IRQ+0x67/0x86
 [<c01038aa>] common_interrupt+0x1a/0x20
DWARF2 unwinder stuck at common_interrupt+0x1a/0x20
Leftover inexact backtrace:
 =======================
handlers:
[<c02148d9>] (ide_intr+0x0/0x19b)
Disabling IRQ #10
Warning: Secondary channel requires an 80-pin cable for operation.
hdg reduced to Ultra33 mode.
ide3 at 0x8000-0x8007,0x7802 on irq 10
hde: max request size: 128KiB
hde: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63, UDMA(100)
hde: cache flushes supported
 hde: hde1 hde2 hde3 hde4
hdg: max request size: 128KiB
hdg: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=58168/16/63, UDMA(33)
hdg: cache flushes not supported
 hdg: hdg1 hdg2 hdg3 hdg4
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

This is what I get when I boot with a 2.6.18.3 (custom) kernel *AND*
with the irqpoll option already enabled. The kernel 2.6.19-rc6 that I
have here doesn't work at all if I pass the irqpoll option (it just
freezes right at "Uncompressing Linux" nothing is displayed at least
during a minute or so---I think that it hanged).

Since Linus Torvalds once said something to the effect that "users that
are willing to help with patches are worth their weight in gold", I
would like to contribute here. :-)

I am willing to do a git bisect to see which may be a problematic patch
or not, but the "irq 10: nobody cared (try booting with the "irqpoll"
option)" is one that I reported to Andrew quite some time ago (I thought
that it had gone away), and it didn't manifest itself until I had to
reuse this extra drive, since I am doing a work that is producing a lot
of data.

Please, if you want any further information, don't hesitate to ask. I
can test patches that are even moderately invasive, since I'm talking
backups of the vital data of my system with regularity.


Regards and thank you very much for any help, Rogério Brito.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
