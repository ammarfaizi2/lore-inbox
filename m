Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSKKU5G>; Mon, 11 Nov 2002 15:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbSKKU5G>; Mon, 11 Nov 2002 15:57:06 -0500
Received: from packet.digeo.com ([12.110.80.53]:21992 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261346AbSKKU5F>;
	Mon, 11 Nov 2002 15:57:05 -0500
Message-ID: <3DD01B32.4A113A71@digeo.com>
Date: Mon, 11 Nov 2002 13:03:46 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@cotse.com
CC: linux-kernel@vger.kernel.org, vs@namesys.com
Subject: Re: [BENCHMARK] 2.5.46-mm1 with contest
References: <3DCC2ABE.5DDE9882@digeo.com> <YWxhbg==.a11f3fbc6d68c50c7f190513c1d3bacf@1037045821.cotse.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2002 21:03:46.0274 (UTC) FILETIME=[D3153420:01C289C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Willis wrote:
> 
>    Attached are the slabinfo, meminfo, and output of vmstat 1.  My system
> was almost unusable at the time, so I got what I could.  I don't have
> anything in my crontab.  This morning my system had been sitting
> quietly all weekend, I did a few things, and then removed a large
> directory and untarred 2.5.47, less than a minute after which my system
> got unbearably slow.
> 
>   It should be noted that I have a 2.5.46 + reiser4 patches, which I think
> made a few changes under mm/.  I also had a reiser4 partition mounted at
> the time, with slightly under 1 million empty files in it.  I hadn't
> accessed it in a while though.
> 


MemTotal:       251332 kB
MemFree:          1748 kB
MemShared:           0 kB
Buffers:           352 kB
Cached:          30040 kB

This is presumably active mmapped memory.  executable text.

SwapCached:      41748 kB
Active:         165064 kB

That's a lot of active memory.

Inactive:          976 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       251332 kB
LowFree:          1748 kB
SwapTotal:     1028152 kB
SwapFree:       834084 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:         164592 kB

That's an awful lot of mapped memory.  Have you been altering
/proc/sys/vm/swappiness?  Has some application run berzerk
and used tons of memory?

Slab:             7592 kB
Committed_AS:   423120 kB
PageTables:       1996 kB
ReverseMaps:     69425
HugePages_Total:    15
HugePages_Free:     15
Hugepagesize:     4096 kB

You've lost 60 megabytes in hugepages!  Bill's patch (which is in .47)
changes the initial number of hugetlb pages to zero, which is rather
kinder.

So I don't _think_ there's a leak here.  It could be that your
normal workload fits OK ito 256 megs, but thrashes when it is
squeezed into 196 megs.

Suggest you do `echo 0 > /proc/sys/vm/nr_hugepages' and retest.
