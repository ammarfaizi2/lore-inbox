Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261502AbTC3RYM>; Sun, 30 Mar 2003 12:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261504AbTC3RYM>; Sun, 30 Mar 2003 12:24:12 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:21257 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261502AbTC3RYL>; Sun, 30 Mar 2003 12:24:11 -0500
Date: Sun, 30 Mar 2003 19:38:02 +0200
To: Tim Connors <tconnors@astro.swin.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Delaying writes to disk when there's no need
Message-ID: <20030330173802.GA5427@hh.idb.hist.no>
References: <20030326204012$188c@gated-at.bofh.it> <20030327091007$22a5@gated-at.bofh.it> <20030327113014$37b4@gated-at.bofh.it> <200303281018.h2SAIxq29603@tellurium.ssi.swin.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303281018.h2SAIxq29603@tellurium.ssi.swin.edu.au>
User-Agent: Mutt/1.5.3i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 28, 2003 at 09:18:59PM +1100, Tim Connors wrote:
> In linux.kernel, you wrote:
> > Helge Hafting (helgehaf@aitel.hist.no) wrote:
> >> Erik Hensema wrote:
> >>> In all kernels I've tested writes to disk are delayed a long time even when
> >>> there's no need to do so.
> >>> 
> >> Short answer - it is supposed to do that!
> >> 
> >>> A very simple test shows this: on an otherwise idle system, create a tar of
> >>> a NFS-mounted filesystem to a local disk. The kernel starts writing out the
> >>> data after 30 seconds, while a slow and steady stream would be much nicer
> >>> to the system, I think.
> 
> Agreed. We have a cluster which is writing on average something like
> 20 Megs/sec/node. We had to lower the write threshold from 30% to 0%,
> because with the constant writing, linux will buffer it for 30 secs,
> fill up RAM, try to empty the write-cache, stall, wash, rinse,
> repeat. Because it was being filled up at roughly the rate it was
> being emptied, once it got 30% behind, there was no catching up, so
> the realtime system would lose data. Ouch.
> 
Nothing can help you if you're getting input at the rate you
can write it.  You need ability to write at least somewhat faster
no matter how buffering is done.

> >> You're wrong then.  There's no need for a slow steady stream, why do
> >> you want that.  Of course you can set up cron to run sync at
> >> regular (short) intervals to achieve this.
> 
> Last time I checked, cron had 1 minute resolution.

If you need to sync more often than once per minute, consider
this shellscript:
for ((;;)) ; do sleep 1 ; sync ; done

[...]
> Helge's comment about /tmp files and rewriting files multiple times:
> in real life, how often does this happen? How often do you overwrite
> one file many times in 30 seconds?

_Every_ time you write a file in chunks not perfectly aligned
on block boundaries. 

> The occasional 20 kilobyte /tmp
> file perhaps, but I doubt it matters in real life. In real life, when
> writing to disk constantly (not just scientific applications - I
> believe this happens in the real world too!), waiting for 30 seconds
> is a liability!

Only if that 30-second wait makes linux buffer more than it can handle.
That may indeed be a problem, but buffering up _some_ data
before writing is still a good idea.

Helge Hafting
