Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261945AbTDAAcB>; Mon, 31 Mar 2003 19:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261947AbTDAAcB>; Mon, 31 Mar 2003 19:32:01 -0500
Received: from 130.146.174.203.mel.ntt.net.au ([203.174.146.130]:55943 "EHLO
	enki.rimspace.net") by vger.kernel.org with ESMTP
	id <S261945AbTDAAcA>; Mon, 31 Mar 2003 19:32:00 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Delaying writes to disk when there's no need
In-Reply-To: <20030331144500.17bf3a2e.akpm@digeo.com> (Andrew Morton's
 message of "Mon, 31 Mar 2003 14:45:00 -0800")
References: <slrnb843gi.2tt.usenet@bender.home.hensema.net>
	<20030328231248.GH5147@zaurus.ucw.cz>
	<slrnb8gbfp.1d6.erik@bender.home.hensema.net>
	<3E8845A8.20107@aitel.hist.no> <3E88BAF9.8040100@cyberone.com.au>
	<20030331144500.17bf3a2e.akpm@digeo.com>
From: Daniel Pittman <daniel@rimspace.net>
Date: Tue, 01 Apr 2003 10:43:22 +1000
Message-ID: <87el4ngi8l.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Mar 2003, Andrew Morton wrote:
> Nick Piggin <piggin@cyberone.com.au> wrote:
>>
>> it seems to me that
>> doing writeout whenever the disk would otherwise be idle
>> (and we have dirty memory to write out) would be a good
>> solution.
> 
> This is what the recently-removed BDI_read_active flag in
> backing_dev_info was supposed to be for. I let it go because I don't
> think it's terribly important and it's time to stop fiddling with the
> vfs writeout code and it wasn't right anyway.
> 
> Note that 2.5 starts pdflush writeout at 10% of memory dirty. Or even
> lower if there is a lot of mapped memory around. Whereas 2.4 will
> start background writeout at 30% or 40% dirty. That's a fairly
> significant tuning change.

I don't figure it's a very important thing, but even this change doesn't
resolve one of the issues I have with the default writeout scheduler.

Capturing a real-time video stream from an IEEE1394 DV stream means
writing a stead 3.5MB per second for two on two and a half hours.

Linux isn't great at this, using the default writeout policy, even as
recent as 2.5.64. The writer goes OK for a while but, eventually, blocks
on writeout for long enough to drop a frame -- more than 8/25ths of a
second.


This can be resolved by tuning the default delay before write-out start
to 5 seconds, down from 30, or by running sync every second, or by doing
fsync tricks.


I think it's a good thing that you can delay writes for a long time, in
general, but there are cases where blocking *really* sucks and on a
system that does nothing else but produce 3.5MB per second of dirty
memory and write that to disk...

Well, something that allowed only that data stream to be preemptively
written out would be good without the need for the thread-and-fsync
trick.

        Daniel

-- 
Anyone who stops learning is old, whether at twenty or eighty. Anyone who keeps
learning stays young. The greatest thing in life is to keep your mind young.
        -- Henry Ford
