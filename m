Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbTFTIp0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 04:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbTFTIp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 04:45:26 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:16071 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262444AbTFTIpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 04:45:23 -0400
Date: Fri, 20 Jun 2003 10:58:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: misty-@charter.net
Cc: Bernd Schubert <bernd-schubert@web.de>, andre@linux-ide.org,
       linux-kernel@vger.kernel.org, despair@adelphia.net
Subject: Re: Problems with IDE on GA-7VAXP motherboard
Message-ID: <20030620105853.A16743@ucw.cz>
References: <200306191429.40523.bernd-schubert@web.de> <20030619193118.GA32406@charter.net> <20030620075249.GA7833@charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030620075249.GA7833@charter.net>; from misty-@charter.net on Fri, Jun 20, 2003 at 03:52:51AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 03:52:51AM -0400, misty-@charter.net wrote:

> I believe I have nailed the problem to the wall. Your talk about the
> bios misdetecting the cable got me to thinking - I hadn't actually been
> able to see what the bios said it was configuring the disks attached to
> since lilo's menu came up microseconds later.
> 
> I still haven't bothered checking, however I believe the bios is on a
> very unhealthy volume of crack. :)
> 
> using hdparm -i /dev/hda shows the disk wasn't configured to do any pio
> mode or udma/dma mode at boot time. Strange, right?

Not very strange. Some disks even cannot report it. And, any disk if set
to PIO only may not report any mode as active, since that is only
applicable to DMA modes.

> Stranger when you do hdparm -I on the disk again and it shows the disk
> is set to use udma4 - and the disk only understands up to udma2! - now

If you use hdparm -I and the drive reports udma4, it can understand
udma4, since hdparm -I is straight from the drive's mouth.

> add in the fact I currently have a 40 wire cable connected to the disk
> and my brain starts frying :)

That's a problem I assume. If the drive can do udma3 and higher, the
chipset can do udma3 and higher, and you have a 40-wire cable and some
bad luck, the BIOS or the driver may misdetect the cable and try to
operate the drive at, most likely, udma4. This won't work, of course.

> At a suggestion of a friend, I set the disk to use mdma2 - via the line:
> 
> hdparm -Xmdma2 -d1 /dev/hda

Don't do this. If your drive supports udma, then there is no reason to
use mwdma. Ever. mwdma is not crc-protected and that can lead to drive
data corruption, namely in the case where you seem to have cabling
problems.

If you have a 40-wire cable, udma2 will work just fine on it. If you
want a slower speed, use udma1 or udma0, which is the same speed as
mwdma2, but is CRC protected and thanks to the udma signalling also more
robust.

> It worked, for all of two seconds. Remember, this is a WD drive. WD
> drives, or at least mine, like to screw up in pretty amazing ways when
> you turn dma on initially. Mine throws a screenful of CRC errors,
> causing the kernel to reset the ide channel.

CRC errors in mwdma mode? Weird. Those CRC errors must've come from the
drive itself - them not being transfer CRC errors but surface CRC
errors. That's mean the drive is dying and you should be getting them in
PIO mode as well

> Oddly, I noticed that dma
> was still on despite the fact the channel had been reset - so I checked
> with -I again, only to find out now the disk was told to use udma*3*! -
> this wasn't getting me anywhere. >D

Note that the asterisk stays even after the drive is used back in PIO
mode. The way to check if DMA is being used is hdparm /dev/hd*

> Anyway, the simple fix was to force
> it to keep settings across a reset by doing:
> 
> hdparm -Xmdma2 -k1 -d1 /dev/hda
> 
> - I am no longer getting any hda: lost interrupt messages, nor am I
> getting any errors at all about the disk losing data or getting
> confused. It's running slower than I'm used to, as I used to run it in
> ata66 mode, but MUCH faster than it was a day ago. :) All I need to do
> now is migrate the information from this disk to one of my maxtors and
> I'm all set. Finally, I can start setting this machine up. Note, I
> could get this disk to use ata66 again if I switched cables to the 80
> wire variant - but I plan on replacing this disk asap anyway.
> 
> So, to summarize: The BIOS in the Gigabyte GA-7VAXP motherboard (and
> likely all variants using the same bios) is getting confused and
> misdetecting both the cable's abilities and the hard disks abilities,
> causing linux to have a very nasty fit when you try using it without
> manually changing the settings using hdparm.
> 
> I have not tried, nor will I likely try, setting the PIO modes up with
> this motherboard as I don't need to. However, it is very likely that
> the same problem occurs with dma disabled as with dma enabled - you
> need to manually reconfigure the hard disk and disk controller using
> hdparm to the correct values, or it just basically gets all confused
> and whines.
> 
> Also note, I tested this setup after configuring with hdparm in three
> ways: First, I did a test using hdparm -t -T /dev/hda - Passed. A
> little slow, but understandable considering. Second, I did a simple
> test doing find / - this almost always caused the thing to throw a
> hda: lost interrupt before at some point or another. Passed. Finally,
> I'm currently doing a kernel compile. As I said, a P1 133 was
> outpacing this machine before. This is a AMD XP 2600+ - it's
> absolutely ludicrous for a P1 to outpace this thing, unless some
> unsane overclocker ... no, I don't want to encourage anyone. :P
> Anyway, even with the slow settings, the kernel compile is going quite
> nicely, and is going much faster than the P1 could ever hope to do.
> 
> Note that the bios in this motherboard does not support turning OFF
> dma support - the only options are 'auto' 'ata33' and 'ata66/100/133'
> - all of which don't appear to actually work. For instance, I have the
> bios set to ata33 right now as I write this, and despite this, it was
> still trying to set the disk up to use udma4!
> 
> A buggy bios a happy linux user does not make. :)
> 
>   Thank you for all your help, time and effort. It was greatly
>   appreciated.
> 
>   Tim McGrath - To unsubscribe from this list: send the line
>   "unsubscribe linux-kernel" in the body of a message to
>   majordomo@vger.kernel.org More majordomo info at
>   http://vger.kernel.org/majordomo-info.html Please read the FAQ at
>   http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
