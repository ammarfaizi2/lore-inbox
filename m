Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273524AbRIQKV1>; Mon, 17 Sep 2001 06:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273561AbRIQKVI>; Mon, 17 Sep 2001 06:21:08 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:53766 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S273524AbRIQKU6>; Mon, 17 Sep 2001 06:20:58 -0400
Date: Mon, 17 Sep 2001 12:21:20 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Forced umount (was lazy umount)
Message-ID: <20010917122120.C13815@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010917000325.A25189@vitelus.com> <Pine.GSO.4.21.0109170416340.20053-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109170416340.20053-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001, Alexander Viro wrote:

> > On Mon, Sep 17, 2001 at 09:57:47AM +0300, Ville Herva wrote:
> > > > Basically, I want a 'kill -KILL' for filesystems.

Me, too, similarly.

> Look at it that way: we have two actions that need to be done upon umount.
> 	1) detach it from the mountpoint(s)
> 	2) shut it down
> 
> For the latter we need to have no active IO on that fs _and_ nothing
> that could initiate such IO.  We can separate #1 and #2, letting fs
> shutdown happen when it's no longer busy.  That's what MNT_DETACH
> does.
> 
> What you are asking for is different - you want fs-wide revoke().
> That's all nice and dandy, but it's an independent problem and it
> will take a _lot_ of work.  Including work in fs drivers.  It _is_
> worth doing, but it's 2.5 stuff (along with normal revoke(2)).

Well, I think there's another way, not sure if that's feasible, but it
looks so:

You say "no active IO and nothing that initiates that". So add a
MNT_KILLBUSY flag that sends SIGKILL to all process that have resources
on the file system and wake them from "D" state. That way, processes
holding resources will be nuked right away, and the kernel can let go of
the file system.

Possibly needed: Patch other parts of the kernel to allow SIGKILL to
kill a process in 'D' state, interrupting its operations.

FreeBSD can do umount -f for anything except /, not sure how it
implements that, never looked at the source. unmount(2) says "Active
special devices continue to work, but any further accesses to any other
active files result in errors even if the filesystem is later
remounted."

That'd be ok for me, it'd be some sort of a stale local file handle for
the processes that got their filesystem pulled from beneath their feet,
and it's probably the only way to prevent corruption. 

Newly connected processes after a mount should be unaffected by all this
and behave as though the file system had never been (lazily or forcibly)
unmounted before.

However, thanks for the first step in the right way.

-- 
Matthias Andree

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin
