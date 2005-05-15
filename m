Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVEOQYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVEOQYW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 12:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVEOQYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 12:24:22 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:58590 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261693AbVEOQYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 12:24:09 -0400
Date: Sun, 15 May 2005 18:24:09 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
In-Reply-To: <200505151121.36243.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.58.0505151809240.26531@artax.karlin.mff.cuni.cz>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <20050515145241.GA5627@irc.pl>
 <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz>
 <200505151121.36243.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 May 2005, Gene Heskett wrote:

> On Sunday 15 May 2005 11:00, Mikulas Patocka wrote:
> >On Sun, 15 May 2005, Tomasz Torcz wrote:
> >> On Sun, May 15, 2005 at 04:12:07PM +0200, Andi Kleen wrote:
> >> > > > > However they've patched the FreeBSD kernel to
> >> > > > > "workaround?" it:
> >> > > > > ftp://ftp.freebsd.org/pub/FreeBSD/CERT/patches/SA-05:09/ht
> >> > > > >t5.patch
> >> > > >
> >> > > > That's a similar stupid idea as they did with the disk write
> >> > > > cache (lowering the MTBFs of their disks by considerable
> >> > > > factors, which is much worse than the power off data loss
> >> > > > problem) Let's not go down this path please.
> >> > >
> >> > > What wrong did they do with disk write cache?
> >> >
> >> > They turned it off by default, which according to disk vendors
> >> > lowers the MTBF of your disk to a fraction of the original
> >> > value.
> >> >
> >> > I bet the total amount of valuable data lost for FreeBSD users
> >> > because of broken disks is much much bigger than what they
> >> > gained from not losing in the rather hard to hit power off
> >> > cases.
> >>
> >>  Aren't I/O barriers a way to safely use write cache?
> >
> >FreeBSD used these barriers (FLUSH CACHE command) long time ago.
> >
> >There are rumors that some disks ignore FLUSH CACHE command just to
> > get higher benchmarks in Windows. But I haven't heart of any proof.
> > Does anybody know, what companies fake this command?
> >
> From a story I read elsewhere just a few days ago, this problem is
> virtually universal even in the umpty-bucks 15,000 rpm scsi server
> drives.  It appears that this is just another way to crank up the
> numbers and make each drive seem faster than its competition.

I've just made test on my Western Digical 40G IDE disk:

just writes without flush cache: 1min 33sec
same access pattern, but flush cache after each write: 20min 7sec (and
disk made more noise)
(this testcase does many 1-sector writes to the same or adjacent sectors,
so cache helps here a lot)

So it's likely that this disk honours cache flushing.

(but the disk contains another severe bug --- it corrupts it
cache-coherency logic when 256-sector accesses are being used --- I
asked WD about it and got no response. 256 is represented as 0 in IDE
registers --- that's probably where the bug came from).

I've also heard a lot of rumors about ignoring cache flush --- but I mean,
have anybody actually proven that some disk corrupts data this way? i.e.:

make a program that does repeatedly this:
write some sector
issue flush cache command
send a packet about what was written where

... and turn off machine while this program runs and see if disk contains
all the data from packets.

or

write many small sectors
issue flush cache
turn off power via ACPI
on next reboot see, if disk contains all the data


Note that disk can still ignore FLUSH CACHE command cached data are small
enough to be written on power loss, so small FLUSH CACHE time doesn't
prove disk cheating.

Mikulas

> My gut feeling is that if this gets enough ink to get under the drive
> makers skins, we will see the issuance of a utility from the makers
> that will re-program the drives therefore enabling the proper
> handling of the FLUSH CACHE command.  This would be an excellent
> chance IMO, to make a bit of noise if the utility comes out, but only
> runs on windows.  In that event, we hold their feet to the fire (the
> prefereable method), or a wrapper is written that allows it to run on
> any os with a bash-like shell manager.
>
> >Mikulas
> >-
> >To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
>
> --
> Cheers, Gene
> "There are four boxes to be used in defense of liberty:
>  soap, ballot, jury, and ammo. Please use in that order."
> -Ed Howdershelt (Author)
> 99.34% setiathome rank, not too shabby for a WV hillbilly
> Yahoo.com and AOL/TW attorneys please note, additions to the above
> message by Gene Heskett are:
> Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
