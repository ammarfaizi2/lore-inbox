Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbSKUROw>; Thu, 21 Nov 2002 12:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbSKUROw>; Thu, 21 Nov 2002 12:14:52 -0500
Received: from packet.digeo.com ([12.110.80.53]:37052 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266888AbSKUROu>;
	Thu, 21 Nov 2002 12:14:50 -0500
Message-ID: <3DDD162B.BAC88F94@digeo.com>
Date: Thu, 21 Nov 2002 09:21:47 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Bill Davidsen <davidsen@tmr.com>, Aaron Lehmann <aaronl@vitelus.com>,
       Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
References: <3DD0E037.1FC50147@digeo.com> <Pine.LNX.3.96.1021112150713.25274B-100000@gatekeeper.tmr.com> <3DDC1480.402A0E5B@digeo.com> <20021121000811.GQ23425@holomorphy.com> <3DDC8330.FE066815@digeo.com> <20021121132014.GC9883@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2002 17:21:50.0941 (UTC) FILETIME=[7AA820D0:01C29182]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Wed, Nov 20, 2002 at 10:54:40PM -0800, Andrew Morton wrote:
>  > > I think this merits some investigation. I, for one, am a big user of
>  > > SIGIO in userspace C programs...
>  > OK, got it back to 119000.  Each signal was calling copy_*_user 24 times.
>  > This gets it down to six.
> 
> Good eyes. But.. this also applies to 2.4 (which should also then
> get faster). So the gap between 2.4 & 2.5 must be somewhere else ?

But 2.4 already inlines the usercopy functions.   With this benchmark,
the cost of the function call is visible.   Same with the dir_rtn_1
test - it is performing zillions of 3, 7, 10-byte copies into userspace.

The usercopy functions got themselves optimised for large copies and
cache footprint.  Maybe we should inline them again.  Maybe it doesn't
matter much.

> Also maybe we can do something about that multiple memcpy in copy_fpu_fxsave()
> In fact, that looks a bit fishy. We copy 10 bytes each memcpy, but
> advance the to ptr 5 bytes each iteration. What gives here ?
> 

We'd buy a bit by arranging for the in-kernel copy of the fp state
to have the same layout as the hardware.  That way it can be done in
a single big, fast, well-aligned slurp.  But for some reason that code has
to convert into and out of a different representation.

But the real low-hanging fruit here is the observation that the
test application doesn't use floating point!!!

Maybe we need to take an fp trap now and then to "poll" the application
to see if it is still using float.
