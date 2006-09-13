Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWIMBYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWIMBYv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWIMBYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:24:51 -0400
Received: from ipx20189.ipxserver.de ([80.190.249.56]:10639 "EHLO
	ipx20189.ipxserver.de") by vger.kernel.org with ESMTP
	id S1751469AbWIMBYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:24:50 -0400
Date: Wed, 13 Sep 2006 03:24:47 +0200
From: Christian Leber <christian@leber.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] 2.6.18-rc6: hda is allready "IN USE" when booting / pi futex
Message-ID: <20060913012447.GA29749@core>
References: <20060907133357.GA30888@core> <20060912153932.GA14388@core> <20060912173455.GB6236@elte.hu> <20060912214822.GA20437@core> <20060912215510.GA14878@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912215510.GA14878@elte.hu>
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 11:55:10PM +0200, Ingo Molnar wrote:

> ok, great. Could you try the patch below ontop of 2.6.18-rc6, does it 
> 'fix' your bootup too?

Yes, it does.

> so i'm afraid you managed to trigger a race in the IDE driver that used 
> to be dormant until now... To debug such races the best method is to 
> create a 'trace' by printk-ing key points of the port/disk detection 
> mechanism. [another option would be to use the latency tracer to do a 
> _really_ finegrained trace of the incident - assuming that the bug does 
> not go away due to tracing overhead.]

I'm looking into it, but i doubt i can find the "race"

The output, when it works it looks like this:

[   11.275757] ICH2M: IDE controller at PCI slot 0000:00:1f.1
[   11.275854] ICH2M: chipset revision 3
[   11.275917] ICH2M: not 100% native mode: will probe irqs later
[   11.275999]     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
[   11.276170]     ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:pio, hdd:pio
[   11.276337] Probing IDE interface ide0...
[    2.804000] Time: acpi_pm clocksource has been installed.
[    3.056000] hda: IC25N020ATMR04-0, ATA DISK drive
[    3.504000] hdb: HL-DT-STDVD-ROM GDR8081N, ATAPI CD/DVD-ROM drive
[    3.560000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    3.560000] Probing IDE interface ide1...
[    4.136000] hda: max request size: 512KiB
[    4.156000] hda: 39070080 sectors (20003 MB) w/1740KiB Cache, CHS=16383/255/63, UDMA(100)
[    4.156000] hda: cache flushes supported
[    4.156000]  hda: hda1 hda2 hda3
[    4.216000] hdb: ATAPI 24X DVD-ROM drive, 512kB Cache, DMA
[    4.216000] Uniform CD-ROM driver Revision: 3.20
[    4.816000] usbcore: registered new driver usbfs
[    4.820000] usbcore: registered new driver hub
[    4.820000] USB Universal Host Controller Interface driver v3.0


When it fails the order is different:
(but not allways the same, of course)

hda: IC25N020ATMR04-0, ATA DISK drive              <- the disk is found before the controller?!?
ICH2M: IDE controller at PCI slot 0000:00:1f.1
ICH2M: chipset revision 3
ICH2M: not 100% native mode: will probe irqs later
ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:pio, hdd:pio
ide0: I/O resource 0x3F6-0x3F6 not free
hda: ERROR, PORTS ALREADY IN USE
ide0 ad 0x1f0-0x1f7,0x3f6 on irq 14
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v3.0
hdb: HL-DT-STDVD-ROM GDR8081N, ATAPI CD/DVD-ROM drive
ide1: I/O resource 0x376-0x376 not free
ide1: ports already in use, skipping probe
register_blkdev: cannot get major 3 for ide0


Christian Leber

-- 
  "Omnis enim res, quae dando non deficit, dum habetur et non datur,
   nondum habetur, quomodo habenda est."       (Aurelius Augustinus)
