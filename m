Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTJWDZr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 23:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTJWDZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 23:25:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:60099 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261605AbTJWDZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 23:25:43 -0400
Date: Wed, 22 Oct 2003 20:25:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <marcelo.tosatti@cyclades.com>
Subject: Re: [BUG somewhere] 2.6.0-test8 irq.c, IRQ_INPROGRESS ?
In-Reply-To: <3F9748A3.D8B313F8@megsinet.net>
Message-ID: <Pine.LNX.4.44.0310222021410.3151-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Oct 2003, M.H.VanLeeuwen wrote:
> 
> I'm seeing an NMI Watchdog detected LOCKUP go away when I revert this patch
> previously added into test8.

Yes, the thing is buggy. 

It's not correct for "disable_irq_nosync()" users, and reverting it is the 
right thing to do. Thanks for the report.

Marcelo, please note if you played with this in 2.4.x..

		Linus

------
> diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
> --- a/arch/i386/kernel/irq.c    Fri Oct 17 14:43:50 2003
> +++ b/arch/i386/kernel/irq.c    Fri Oct 17 14:43:50 2003
> @@ -378,7 +380,7 @@
>         spin_lock_irqsave(&desc->lock, flags);
>         switch (desc->depth) {
>         case 1: {
> -               unsigned int status = desc->status & ~IRQ_DISABLED;
> +               unsigned int status = desc->status & ~(IRQ_DISABLED | IRQ_INPROGRESS);
>                 desc->status = status;
>                 if ((status & (IRQ_PENDING | IRQ_REPLAY)) == IRQ_PENDING) {
>                         desc->status = status | IRQ_REPLAY;
> 
> EIP is at .text.lock.8390+0x39/0x63 which is in ei_start_xmit() in 8390.c
> at the first spin_lock_irqsave().
> 
> I hand copied the data from the console, what else is interesting/necessary?
> 
> First notices after booting into test8 and the system went silent when starting X,
> since /home is NFS mounted go generate network and IDE activity.
> 
> Reproducible by doing all 3 of these (any 2 and the system stays alive, longer
> than I want to wait)
> 
> 1. ping flood  A->B
> 2. ping flood  B->A
> 3. find and grep for garbage from IDE on B's /dev/md/X filesystem
> 
> System B is SMP dual Celeron 466Mhz.
> 
> Eth interface:
> 
> isapnp: Scanning for PnP cards...
> isapnp: Card 'SMC EZ Card (1660)'
> isapnp: 1 Plug & Play card detected total
> pnp: Device 00:01.00 activated.
> ne.c: ISAPnP reports Generic PNP at i/o 0x220, irq 5.
> ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
> Last modified Nov 1, 2000 by Paul Gortmaker
> NE*000 ethercard probe at 0x220: 00 e0 29 3c 1f 11
> eth0: NE2000 found at 0x220, using IRQ 5.
> 
> 
> IDE interface:
> 
> PIIX4: IDE controller at PCI slot 0000:00:07.1
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
> HPT366: onboard version of chipset, pin1=1 pin2=2
> HPT366: IDE controller at PCI slot 0000:00:13.0
> HPT366: chipset revision 1
> HPT366: 100% native mode on irq 18
>     ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xe800-0xe807, BIOS settings: hdg:pio, hdh:pio
> hde: WDC WD400BB-32AUA1, ATA DISK drive
> ide2 at 0xd400-0xd407,0xd802 on irq 18
> hdg: ST340810A, ATA DISK drive
> ide3 at 0xe000-0xe007,0xe402 on irq 18
> hde: max request size: 128KiB
> hde: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
>  /dev/ide/host2/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
> hdg: max request size: 128KiB
> hdg: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
>  /dev/ide/host3/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
> 
> /proc/interrupts (currently running 2.6.0-test8)
> 
>           CPU0       CPU1
>   0:   52531411         84    IO-APIC-edge  timer
>   1:      10288          1    IO-APIC-edge  i8042
>   2:          0          0          XT-PIC  cascade
>   5:    1908410   66015823    IO-APIC-edge  NE2000
>   8:          1          0    IO-APIC-edge  rtc
>  12:      56098          1    IO-APIC-edge  i8042
>  16:    3663003          0   IO-APIC-level  r128@PCI:1:0:0
>  18:     162982     300769   IO-APIC-level  ide2, ide3
> NMI:   52531430   52531316
> LOC:   52544445   52544450
> ERR:         42
> MIS:        999
> 

