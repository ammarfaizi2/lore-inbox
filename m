Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261635AbTCaN2J>; Mon, 31 Mar 2003 08:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261638AbTCaN2J>; Mon, 31 Mar 2003 08:28:09 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:16907 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261635AbTCaN2H>; Mon, 31 Mar 2003 08:28:07 -0500
Message-ID: <3E8845A8.20107@aitel.hist.no>
Date: Mon, 31 Mar 2003 15:42:00 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: erik@hensema.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Delaying writes to disk when there's no need
References: <slrnb843gi.2tt.usenet@bender.home.hensema.net> <20030328231248.GH5147@zaurus.ucw.cz> <slrnb8gbfp.1d6.erik@bender.home.hensema.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Hensema wrote:
[...]
> Helge Hafting already pointed out that writing out the data earlier isn't
> desirable. The problem isn't in the waiting: the problem is in the writing.
> I think the current kernel tries to write too much data too fast when
> there's absolutely no reason to do so. It should probably gently write out
> small amounts of data until there is a more pressing need for memory.
> 
I don't think the problem is "writing a large chunk", rather that this
chunk is scheduled for writing a bit too late.  Memory is filling up
and the process producing data us throttled while waiting for
the write to free up pages.  Then the "huge chunk" of pages is released,
and memory is allowed to fill up for too long again.

Seem to me the correct solution is to start writing out
things long before memory gets so full that we need to
throttle the producer.

This will result in somewhat smaller chunks and a somewhat
steadier stream of data.  It will work better, but not because
the chunks are smaller. (Block devices is supposed to handle
enormous chunks with no problems, and the bandwith utilization
is generally better the bigger chunks you can get.  50M to
disk in one go isn't "pushing" anything - it is "nice".)
The reason an earlier start works better is that memory never fills up
to the point where the producer is throttled, assuming
the io system can keep up with the producer forever.
Throttling will _always_ happen when that isn't the case.

The tricky part here is knowing the bandwith of the output
device, and start writing at such a time that memory
won't have time to fill up in the case where a
producer is almost as fast as the output device.

The problem is that this depends on several things:
1. How much more memory is there (varies a lot, but
    the kernel knows this one.)
2. How fast is the output device (varies a lot, different
    areas on a disk have different speed.  Different
    disks have different speed.  The speed of nfs depends
    on network speed, network congestion,
    roundtrip time, server load, and server disk speed.
    You probably cannot get good estimates for all cases,
    particularly not nfs in a shared net.
    To get this right we need both bandwith and latency.
3. How fast is data produced?  A global estimate may
    be possible, looking at how fast memory is dirtied.
    I have no idea if such an estimate is possible per
    block device.
4. The big problem is that there may be several unrelated
    processes dirtying memory to be written to several
    very different block devices.
    For this to work automatically we need a low estimate
    for the bandwith for each block device/filesystem,
    and memory dirying rate for each.


This seems hard to solve automatically.  A specific
case of a realtime program writing near disk speed is solvable
by having an extra thread that issue a fsync whenever the
amount of written but unsynced data gets near the point
where the time necessary to write it is long enough
to fill memory with the same rate of producing data.
Of course one wants a substantial safety margin here,
perhaps an assumption that only one third or so of memory
actually will be available for caching the important stuff.

A manual solution is possible if we can have two "knobs"
for this:
1. Treshold for when to start writing out stuff
2. Treshold for when to throttle processes.

The latter may or may not be necessary, the point is that the former
should kick in long before throttling is necessary.

This is usually expressed as how many % of memory that is dirty, but
I'm not sure that is the right thing.  It assumes that 100% will be
available after cleaning, which may be way off.

Something like % of memory that is still available (free,
or instantly freeable by reclaiming clean unpinned cache)

Helge Hafting




