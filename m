Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262959AbVCQBvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262959AbVCQBvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 20:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbVCQBvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 20:51:31 -0500
Received: from fire.osdl.org ([65.172.181.4]:41145 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262959AbVCQBv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 20:51:27 -0500
Date: Wed, 16 Mar 2005 17:51:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oom with 2.6.11
Message-Id: <20050316175109.3c160d4d.akpm@osdl.org>
In-Reply-To: <4238DD01.9060500@g-house.de>
References: <422DC2F1.7020802@g-house.de>
	<2cd57c9005031102595dfe78e6@mail.gmail.com>
	<4231B4E9.3080005@g-house.de>
	<42332F9C.7090703@g-house.de>
	<4238DD01.9060500@g-house.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau <evil@g-house.de> wrote:
>
> unfortunately i've hit OOM again, this time with "#define DEBUG" enabled
>  in mm/oom_kill.c:
> 
>  http://nerdbynature.de/bits/sheep/2.6.11/oom/oom_2.6.11.3.txt
> 
>  by "Mar 16 18:32" pppd died again and OOM kicked in 30min later.
>  (there are a *lot* messages of a shell script named "check-route.sh". it's
>  a little script which runs every minute or so to check if my default route
>  is still ok and if ping to the outside world are possible. definitely not
>  a memory hog, but noisy)
> 
>  since tracking the "most memory consuming applications" did not reveal any
>  hints [1], i have monitored /proc/slabinfo and /proc/meminfo this time:
> 
>  http://nerdbynature.de/bits/sheep/2.6.11/oom/daily_stats-2.6.11.3.gz
> 
>  as stated before, i was suspecting pppd to be the bad guy here, and yes: i
>  downgraded pppd to an earlier version and pppd (and the system) survived 2
>  terminations of my dial-up ISP. yesterday i've upgraded back again to
>  current pppd (debian/unstable) and the OOM problem returned. yes, i'll bug
>  the debian people now (hello!), but grepping for "ppp" in
>  daily_stats-2.6.11.3.gz gives no hits. so "pppd" does not get *any* points
>  from mm/oom_kill.c and thus no attempts are made to kill it (it is always
>  only kill'able with "-9").

The oom-killer tries to be nicer to processes which are running as root.

> furthermore, i thought /proc/slabinfo coud give
>  me some hints about *where* all the memory went in. scrolling down this
>  file to the bottom, where "SwapFree" shows "0 kB" i don't see any alarming
>  numbers in the "slabinfo" right above "meminfo".

MemTotal:       256372 kB
MemFree:          3280 kB
Buffers:           608 kB
Cached:           3256 kB
SwapCached:        664 kB
Active:         105020 kB
Inactive:        20364 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       256372 kB
LowFree:          3280 kB
SwapTotal:      784468 kB
SwapFree:            0 kB
Dirty:              12 kB
Writeback:           0 kB
Mapped:         130332 kB
Slab:            61424 kB
CommitLimit:    912652 kB
Committed_AS:  1323548 kB
PageTables:      51668 kB
VmallocTotal:   778184 kB
VmallocUsed:      3464 kB
VmallocChunk:   774492 kB

Some application went berzerk, used up all the swap and then oomed the box.

You could perhaps run `top -d1' then hit M so the output is sorted by
bloatiness, then try to catch the culprit.

But it would be better to have some app which prints the N most
memory-hungry processes every second and simply scrolls that up the screen. 
I'm not aware of such a thing, but it could be cooked up via
/proc/N/cmdline and /proc/N/statm.

