Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319468AbSH2Wb5>; Thu, 29 Aug 2002 18:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319462AbSH2Wau>; Thu, 29 Aug 2002 18:30:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9229 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319456AbSH2WaD>; Thu, 29 Aug 2002 18:30:03 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] low-latency zap_page_range()
Date: Thu, 29 Aug 2002 22:37:02 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <akm7me$3s1$1@penguin.transmeta.com>
References: <3D6E844C.4E756D10@zip.com.au> <1030653602.939.2677.camel@phantasy> <3D6E8B25.425263D5@zip.com.au> <20020829213830.GG888@holomorphy.com>
X-Trace: palladium.transmeta.com 1030660454 12107 127.0.0.1 (29 Aug 2002 22:34:14 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 29 Aug 2002 22:34:14 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020829213830.GG888@holomorphy.com>,
William Lee Irwin III  <wli@holomorphy.com> wrote:
>Robert Love wrote:
>>> unless we
>>> wanted to unconditionally drop the locks and let preempt just do the
>>> right thing and also reduce SMP lock contention in the SMP case.
>
>On Thu, Aug 29, 2002 at 01:59:17PM -0700, Andrew Morton wrote:
>> That's an interesting point.  page_table_lock is one of those locks
>> which is occasionally held for ages, and frequently held for a short
>> time.
>> I suspect that yes, voluntarily popping the lock during the long holdtimes
>> will allow other CPUs to get on with stuff, and will provide efficiency
>> increases.  (It's a pretty lame way of doing that though).
>> But I don't recall seeing nasty page_table_lock spintimes on
>> anyone's lockmeter reports, so...
>
>You will. There are just bigger fish to fry at the moment.

You will NOT.

The page_table_lock protects against page stealing of the VM and
concurrent page-faults, nothing else.  There is no way you can get
contention on it under any reasonable load that doesn't involve heavy
out-of-memory behaviour, simply because

 - the lock is per-mm
 - all "regular" paths that care about this also get the mmap semaphore

In short, that spinlock has _zero_ scalability impact.  You can
theoretically get contention on it without memory pressure only by
having hundreds of threads page-faulting at the same time (getting a
read-lock on the mmap semaphore), but by then your performance has
nothing to do with the spinlock, and everything to do with the page
faults themselves. 

(In fact, I can almost guarantee that most of the long hold-times are
for exit(), not for munmap().  And in that case the spinlock cannot get
any non-pagestealer contention at all, since nobody else is using the
MM)

			Linus
