Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281419AbRKEXDW>; Mon, 5 Nov 2001 18:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281416AbRKEXDO>; Mon, 5 Nov 2001 18:03:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46606 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281424AbRKEXDB>; Mon, 5 Nov 2001 18:03:01 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [Ext2-devel] disk throughput
Date: Mon, 5 Nov 2001 22:59:42 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9s75ku$7u2$1@penguin.transmeta.com>
In-Reply-To: <20011104193232.A16679@mikef-linux.matchmail.com> <-0700"> <m1wv15ufn1.fsf@mo.optusnet.com.au> <3BE70717.54F3084A@zip.com.au>
X-Trace: palladium.transmeta.com 1005001356 4617 127.0.0.1 (5 Nov 2001 23:02:36 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 5 Nov 2001 23:02:36 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BE70717.54F3084A@zip.com.au>,
Andrew Morton  <akpm@zip.com.au> wrote:
>>         if ( 0 && ..
>> use something like
>>         if ((last_time + 100) < jiffes && ...
>>                 last_time = jiffies;
>> which would in theory use the old behaviour for sparodic mkdirs
>> and the new behaviour for things like 'untar' et al.
>> 
>
>I agree - that's a pretty sane heuristic.
>
>It would allow us to preserve the existing semantics for the
>slowly-accreting case.  If they're still valid.

I don't particularly like behaviour that changes over time, so I would
much rather just state clearly that the current inode allocation
strategy is obviously complete crap. Proof: simple real-world
benchmarks, along with some trivial thinking about seek latencies.

In particular, the way it works now, it will on purpose try to spread
out inodes over the whole disk. Every new directory will be allocated in
the group that has the most free inodes, which obviously on average
means that you try to fill up all groups equally.

Which makes _no_ sense. There is no advantage to trying to spread things
out, only clear disadvantages.

Instead of trying to make this time-dependent, let's just realize that
spreading things out is stupid. It might make more sense to say

 - if we create a new directory
 - AND the group we're currently in is getting filled up
 - AND there is another group that is clearly emptier,
 - THEN do we switch groups.

None of this stupid "if this group has more inodes than the average"
crap. 

But I'd rather have the "if (0 && .." than something that depends on
time. But if people want to have something that is in the _spirit_ of
the old code, then make it something like the above, which only switches
groups if there is a need and a clear win from it.

		Linus
