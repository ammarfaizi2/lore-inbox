Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbTKCGig (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 01:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbTKCGig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 01:38:36 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:48388 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S261930AbTKCGie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 01:38:34 -0500
Date: Mon, 3 Nov 2003 08:38:15 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide write cache issue? [Re: Something corrupts raid5 disks slightly during reboot]
Message-ID: <20031103063815.GV4640@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
References: <20031102082827.GO4868@niksula.cs.hut.fi> <Pine.LNX.4.10.10311022124480.23682-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10311022124480.23682-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 02, 2003 at 09:34:30PM -0800, you [Andre Hedrick] wrote:
>
> >   - How long can the unwritten data linger in the drive cache if the drive
> >     is otherwise idle? (Without an explicit flush and with write caching
> >     enabled.)
> 
> Basically forever, until a read is issued to a range of lba's which starts
> smaller than the uncommitted contents's lba, and includes the content in
> question.  Or if a flush cache or disable write-back cache is issued.

Huh. Sounds stunning.

I mean if the drive is otherwise idle, why would it hold the data in cache
without trying to write it onto platter? But I'll take your word for it.
 
> >     I had unmounted the fs an raidstopped the md minutes before the boot.
> 
> The problem imho, is a break down of fundamental cascading callers.
> 
> Unmount MD -> flush MD
> 
> 	MD is a fakie device :-/
> 
> MD fakie calls for flush of R_DEV's
> 
> Likewise unloading or stopping MD operations should repeat regardless of
> mount or not.

Yep. You wouldn't happen to know if it could make difference if the md
consists of raw devices (hdb,hdc,hdg) instead of partitions (hdc1,hb1,hdg1)
wrt. how and when the IDE flushes get triggered? Is there code that does it
for partitions but is lacking for whole devices? 

(The other MDs on the same box that consist of partitions do not get
corrupted, but they are on Maxtors, not Samsungs.)
 
> >   - Can this corruption happen on warmboot or only on poweroff?
> 
> Given POST (assume x86 for only a brief moment) will issue execute

x86 in this case, yes.

> diagnositics to hunt for signatures on the ribbon, that basically wacks
> the content.  Cool cycle obviously wacks the buffer.

Ack.
 
> >   - What kind of corruption can one see the if boot takes place "too fast"
> >     and drive hasn't got enough time to flush its cache?
> 
> erm, I am lost with the above.
> Flush Cache is a hold and wait on completion, period.
> However, a cache error at this point is a wasted effort to attempt
> recovery.

I meant: if the drive does not flush it cache before reboot, is it likely to
see the sectors either up-to-date or having the old data? Or can one see
half-written or otherwise corrupted sectors?

The corruption I saw didn't look like the sector just had the old data, but
I'm not sure.

Then again, this may very well be something completely unrelated to ide
write caching.
 
> Not sure I helped or not ...

Yes you did, thanks!


-- v --

v@iki.fi
