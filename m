Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbTIDRMU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbTIDRML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:12:11 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:65408 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S265228AbTIDRMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:12:05 -0400
Date: Thu, 4 Sep 2003 19:11:56 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, rossb@google.com
Subject: Re: LBA48 on PDC20265 (again and again...)
Message-ID: <20030904171156.GA23116@vana.vc.cvut.cz>
References: <BFC117A6765@vcnet.vc.cvut.cz> <200309031520.49352.bzolnier@elka.pw.edu.pl> <200309031549.52113.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309031549.52113.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 03:49:52PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 03 of September 2003 15:20, Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> >
> > There was a recent threads on this issue:
> > "IDE bug - was: Re: uncorrectable ext2 errors"
> > and "Promise IDE patches".
> >
> > One of conclusions was that there is no reason not to enable LBA48
> > on PDC20265.  I will send Jan's patches to Linus.  Thanks for verifying
> > this.
> 
> I've just sent patch removing these 2 lines to Linus and actually I was
> thinking about Ross Biro's patch when writing this.  Can you test?
> 
> Newer kernels will lock up when a drive command (SMART, hdparm -I, etc.)
> is issued to a drive connected to a Promise 20265 or 20267 controller
> while the controller is in DMA mode.  The problem appears to be that
> tune_chipset incorrectly clears the high PIO bit thinking that it is a
> "PIO force on" bit.  The documentation I have access to does not seem to
> mention a PIO force bit.  Not changing that bit seems to fix the problem
> with drive commands on a promise controller.
>

According to my tests this bit makes no difference. For primary master
register B should be register 0x61 in PCI config space. When disk/adapter are
operating in UDMA5, values shown below are used - 0x24 in register B, and
disk accesses, and hdparm -i/-I and ide-smart -d /dev/hde works fine.
When I change this value to 0x34, I see no change in behavior, everything
still works.

000000 5a 10 30 0d 07 00 10 02 02 00 80 01 00 20 00 00
000010 01 98 00 00 01 94 00 00 01 90 00 00 01 88 00 00
000020 01 84 00 00 00 00 80 ca 00 00 00 00 5a 10 33 4d
000030 00 00 00 00 58 00 00 00 00 00 00 00 0a 01 00 00
000040 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000050 be 33 00 00 00 00 00 00 01 00 01 00 00 00 00 00
000060 f1 24 41 00 c4 f3 4f 00 04 f3 4f 00 31 24 41 00
000070 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Only problem I found is that if I do 'hdparm -p0 /dev/hde' followed by
'hdparm -d1 -X69 /dev/hde', IDE activity leds goes on, and kernel locks up.
I tried UP kernel with spinlock debugging, and I have enabled (APIC) NMI
watchdog, but it did no change - machine still locks up, and there is no
NMI watchdog message for at least one minute (NMI count in /proc/interrupts
increases, so I assume that it should work).

So I have no idea whether this Ross's patch should be applied or not. I see
no difference in behavior.

But it looks suspicious to me that PIO tuning clears lower 3 bits of 
register B, but then it sets bit 3 (for PIO1/2) or bit 4 (for PIO0). 

It means that if we use PIO3 after DMA mode, we use value 0x06 for TB, but if
we'll use PIO3 after PIO0 and PIO1 mode, we use value 0x1E for TB... Does
not look good to me. 

I think that these masks should match, and we should use 0xF0/0x0F for register
A and 0xE0/0x1F for register B (instead of 0xF0/0x07 we use currently). Otherwise
value of bits 4 & 3 or register B is almost random, and depends on previously
used mode, and thus Ross's patch is step in good direction.

					Best regards,
						Petr Vandrovec

