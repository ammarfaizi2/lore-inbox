Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbTLYFRh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 00:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbTLYFRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 00:17:36 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:23774
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263107AbTLYFRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 00:17:34 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 data loss
Date: Thu, 25 Dec 2003 16:17:30 +1100
User-Agent: KMail/1.5.3
References: <3FEA0C3C.9090601@cs.oswego.edu> <200312250934.17913.kernel@kolivas.org> <20031225020738.GA24690@bounceswoosh.org>
In-Reply-To: <20031225020738.GA24690@bounceswoosh.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312251617.30228.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Dec 2003 13:07, Eric D. Mudama wrote:
> On Thu, Dec 25 at  9:34, Con Kolivas wrote:
> >On Thu, 25 Dec 2003 09:22, Gergely Tamas wrote:
> >> I don't think this is a reiserfs bug. This was my first thought and
> >> after first hitting this bug, I've moved all my partitions from reiserfs
> >> to jfs. But I've also had this problem with it... Now I'm back to
> >> 2.4.23, and everything works fine.
> >
> >Because of the numerous reboots and hangs I've seen with experimental
> > patches I've also seen this, but it's not reiserFS fault. The problem is
> > that most drives have write caching enabled and not all of them are safe
> > with this. If you disable it with hdparm (hdparm -W 0 /dev/hd*) you'll
> > find that open files during a hard reset or power outage will prevent
> > those open files from being corrupted.
>
> Write cache off will not prevent a file from being corrupted, however,
> it should limit the corruption to a single disk operation.
>
> I don't see how the behavior you describe could be the drive's
> fault...
>
> The user stated that their system hard locked, then they went and
> rebooted it, and following the reboot they had corruption...  From
> this, there are a few possibilities:
>
> 1. The drive had been given the commands to write the data prior to the
> hang.
>
> If this was the case, the drive would happilly keep writing the data
> it had been given and was caching in the background, even while you
> continued to send (or stopped sending) data for a new command over the
> interface.  An IDE interface lockup or system lockup will not prevent
> the drive from flushing the remainder of its write cache.  (Only
> possible exception might be faulty handling of a hard reset, but all
> drives today will flush their cache when they see the reset, prior to
> processing it.) Unless the user yanked power within a few hundred
> milliseconds of the write command, I think it is unlikely that cached
> data already in the drive wasn't flushed properly.
>
> 2. The drive was in the middle of a command writing important data
> during the hang.
>
> In this case, yes, your file you were writing would probably be
> corrupt on the media, but nothing more.  Drives detect power loss, and
> immediately disable write-gate and park the actuator.  If they don't
> get the actuator parked before they run out of back-EMF from the
> momentum of the platter(s), the head will stick to the media and
> you'll probably need a chisel to get that drive to spin again.
>
> 3. The drive hadn't yet been issued the commands for the data that was
> eventually corrupted.
>
> I find this to be the most likely case, and is a situation where the
> filesystem thinks objects were moved but those updates were not
> correctly sent to the disk (due to the hang?), so it might think
> they're in the old location or something.  (I'm not a filesystem
> wizard so if I'm way off-base, my apologies)
>
> It seems to me that the problem occurred at a higher system level than
> the disk, and disabling the write cache on the drive (besides being a
> *HUGE* performance loser) will only make the window for failure
> smaller, not eliminate it entirely.
>
> Unless you are using *really* old hard drives, the write caching in
> today's drives is really quite good and definitely should be usable.
> Sure, it makes things less safe in power events, but system lockups
> shouldn't affect the drive's ability to flush its cache.  Note too
> that Gergely reported that the problem went away on his 2.4.23 system.
> I don't believe that to be a small data point.

I hardly said it was the correct solution; just what worked for me, as I had 
exactly the same issue going 2.4->2.6. I can't even recall if write caching 
was actually on in 2.4, and my write performance under video capture has not 
shown any detriment. The filesystem gods should comment. Merry Christmas.

Con

