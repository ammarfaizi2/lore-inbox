Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282342AbRKXB4r>; Fri, 23 Nov 2001 20:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282346AbRKXB4h>; Fri, 23 Nov 2001 20:56:37 -0500
Received: from [206.196.53.54] ([206.196.53.54]:33683 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S282342AbRKXB41>;
	Fri, 23 Nov 2001 20:56:27 -0500
Date: Fri, 23 Nov 2001 19:58:38 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3: kjournald and spun-down disks
In-Reply-To: <3BFEF71A.F32176FE@zip.com.au>
Message-ID: <Pine.LNX.4.40.0111231939000.4162-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2001, Andrew Morton wrote:

> Oliver Xymoron wrote:
> >
> > My laptop drive seems to be waking up more often today and I suspect it's
> > somehow ext3/kjournald that's to blame. Does it obey the timings in
> > /proc/sys/vm/bdflush or does it have its own flush timer?
>
> It has its own flush timer.  This is something we need to crunch
> on and think about.

Ok. I think we'll probably end up needing per-device flush timers. Flushes
to jffs should work differently than flushes to disk, or to network
attached storage (iSCSI, nbd).

> > There's a more general problem with VM on laptops which is that the system
> > doesn't have any notion of spun-down disks. Flush intervals should be
> > short when the disk is running and long when it isn't and decisions about
> > which pages to discard or swap might be improvable. Pre-emptive swap when
> > the disk is spun down is a loss..
>
> Yup.  The current VM is a bit too swap-happy, IMO.  In try_to_free_pages(),
> replace `priority = DEF_PRIORITY' with `priority = DEF_PRIORITY + 2'.
>
> Also, if we had appropriate hooks into the request layer, we could detect
> when the disk was being spun up for a read, and opporunistically flush
> out any pending writes.

I think if the disk wakes up, then the time to next flush gets shortened
from long_interval to short_interval. If short_interval makes the next
flush in the past, it happens now. But if we sleep the disk and wake it up
immediately, we don't necessarily want to trigger a flush.

> Tell me if this is joyful:

Haven't tried it yet, but I'm afraid I don't see what makes it actually
sync with the dirty buffer flush. Wouldn't it be better to export a chain
of flush funcs hung off a timer?

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

