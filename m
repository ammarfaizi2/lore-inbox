Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267756AbUG3Rmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267756AbUG3Rmu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 13:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267763AbUG3Rmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 13:42:50 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6539 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267762AbUG3Rmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 13:42:45 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-M5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Scott Wood <scott@timesys.com>, wli@holomorphy.com
In-Reply-To: <20040730064431.GA17777@elte.hu>
References: <1090732537.738.2.camel@mindpipe>
	 <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <1091141622.30033.3.camel@mindpipe>  <20040730064431.GA17777@elte.hu>
Content-Type: text/plain
Message-Id: <1091209384.800.48.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 30 Jul 2004 13:43:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 02:44, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:

> shrink_list() itself is preemptable once every iteration so that
> function alone shouldnt be able to generate a 2msec latency.
> 
> a strong suspect is add_to_swap(), it could be looping. Could you do a
> 'echo m > /proc/sysrq-trigger' and send me the results? In particular
> are there any significant 'race' counts in the 'Swap cache:' stats?
> 
> the other possible suspect is get_swap_page() - it's called from
> add_to_swap() and has the potential to introduce latencies (it does
> bitmap scans, etc.) - but it never shows up in your xrun logs, which is
> a bit weird.
> 
> (could you perhaps also try wli's latency printing patch? That prints
> out latencies closer to where they really happen.)
> 
> plus it seems the latency is related to certain VM activities - you
> still cannot name any particular reproducer workload - it just happens
> occasionally, right?
> 

I think iozone -a or one of the sysbench tests triggers this one.  But
it also happened a few times overnight.  I will try to reproduce it
today.  You are referring to wli's 'preempt timing' patch, correct?

Also, I sent another report of XRUNS related to msync().  I have
narrowed this down a bit.  This one happens whenever 'apt-get update'
replaces its package lists.  Presumably it mmaps the files in
/var/lib/apt/lists and then calls msync at the end to write them out,
which triggers the XRUN.

Here are the results of 'echo m > /proc/sysrq-trigger':

SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:       12064kB (0kB HighMem)
Active:70285 inactive:41081 dirty:24 writeback:0 unstable:0 free:3016 slab:5405 mapped:34481 pagetables:233
DMA free:3352kB min:20kB low:40kB high:60kB active:5288kB inactive:2128kB present:16384kB
protections[]: 10 348 348
Normal free:8712kB min:676kB low:1352kB high:2028kB active:275852kB inactive:162196kB present:475072kB
protections[]: 0 338 338
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
protections[]: 0 0 0
DMA: 382*4kB 52*8kB 2*16kB 1*32kB 1*64kB 0*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 3352kB
Normal: 188*4kB 159*8kB 82*16kB 100*32kB 8*64kB 3*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 8712kB
HighMem: empty
Swap cache: add 3, delete 1, find 0/0, race 0+0
Free swap:       499916kB
122864 pages of RAM
0 pages of HIGHMEM
2054 reserved pages
96028 pages shared
2 pages swap cached

Looks like no significant races.

Lee


