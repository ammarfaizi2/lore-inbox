Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTKCFfb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 00:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbTKCFfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 00:35:31 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:45829
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261903AbTKCFfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 00:35:23 -0500
Date: Sun, 2 Nov 2003 21:34:30 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Ville Herva <vherva@niksula.hut.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: ide write cache issue? [Re: Something corrupts raid5 disks
 slightly during reboot]
In-Reply-To: <20031102082827.GO4868@niksula.cs.hut.fi>
Message-ID: <Pine.LNX.4.10.10311022124480.23682-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Nov 2003, Ville Herva wrote:

> On Sat, Nov 01, 2003 at 10:05:31PM -0800, you [Andre Hedrick] wrote:
> > 
> > I added the flush code to flush a drive in several places but it got
> > pulled and munged.
> > 
> > The original model was to flush each time a device was closed, when any
> > partition mount point was released, and called by notifier.
> > 
> > In a minimal partition count of 1, you had at least two flush before
> > shutdown or reboot.
> > 
> > So it was not the code because I fixed it, but then again I am retiring
> > from formal maintainership.
> 
> Thanks, Andre :(.
> 
> As an^Wthe IDE expert, can you clarify a few points:
> 
>   - How long can the unwritten data linger in the drive cache if the drive
>     is otherwise idle? (Without an explicit flush and with write caching
>     enabled.)

Basically forever, until a read is issued to a range of lba's which starts
smaller than the uncommitted contents's lba, and includes the content in
question.  Or if a flush cache or disable write-back cache is issued.

>     I had unmounted the fs an raidstopped the md minutes before the boot.

The problem imho, is a break down of fundamental cascading callers.

Unmount MD -> flush MD

	MD is a fakie device :-/

MD fakie calls for flush of R_DEV's

Likewise unloading or stopping MD operations should repeat regardless of
mount or not.

>   - Can this corruption happen on warmboot or only on poweroff?

Given POST (assume x86 for only a brief moment) will issue execute
diagnositics to hunt for signatures on the ribbon, that basically wacks
the content.  Cool cycle obviously wacks the buffer.

>   - What kind of corruption can one see the if boot takes place "too fast"
>     and drive hasn't got enough time to flush its cache?

erm, I am lost with the above.
Flush Cache is a hold and wait on completion, period.
However, a cache error at this point is a wasted effort to attempt
recovery.

Not sure I helped or not ...

Cheers,

Andre

