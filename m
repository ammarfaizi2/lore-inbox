Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262908AbSJGHcy>; Mon, 7 Oct 2002 03:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262909AbSJGHcx>; Mon, 7 Oct 2002 03:32:53 -0400
Received: from packet.digeo.com ([12.110.80.53]:2465 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262908AbSJGHcv>;
	Mon, 7 Oct 2002 03:32:51 -0400
Message-ID: <3DA139EC.8A34A593@digeo.com>
Date: Mon, 07 Oct 2002 00:38:20 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.40-mm2 with contest
References: <1033960902.3da0fdc6839aa@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2002 07:38:21.0231 (UTC) FILETIME=[82A793F0:01C26DD4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> 
> Here are the latest results including 2.5.40-mm2 with contest v0.50
> (http://contest.kolivas.net)
> 
> ...
> 
> mem_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.19 [3]              100.0   72      33      3       1.49
> 2.5.38 [3]              107.3   70      34      3       1.60
> 2.5.39 [2]              103.1   72      31      3       1.53
> 2.5.40 [2]              102.5   72      31      3       1.53
> 2.5.40-mm1 [2]          107.7   68      29      2       1.60
> 2.5.40-mm2 [2]          165.1   44      38      2       2.46
> 

-mm2 has the "don't swap so much" knob.  By default it is set at 50%.
The VM _wants_ to reclaim lots of memory from mem_load so that
gcc has some cache to chew on.  But you the operator have said
"I know better and I don't want you to do that".

Because it is prevented from building enough cache, gcc is issuing
a ton of reads, which are hampering the swapstorm which is happening
at the other end of the disk.  It's a lose-lose.

There's not much that can be done about that really (apart from
some heavy-handed load control) - if you want to optimise for
throughput above all else,

	echo 100 > /proc/sys/vm/swappiness

(I suspect our swap performance right now is fairly poor, in terms
of block allocation, readaround, etc.  Nobody has looked at that in
some time afaik.  But tuning in there is unlikely to make a huge
difference).
