Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265904AbSKBJLM>; Sat, 2 Nov 2002 04:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265902AbSKBJLM>; Sat, 2 Nov 2002 04:11:12 -0500
Received: from [202.88.171.30] ([202.88.171.30]:41865 "EHLO dikhow.hathway.com")
	by vger.kernel.org with ESMTP id <S265905AbSKBJLK>;
	Sat, 2 Nov 2002 04:11:10 -0500
Date: Sat, 2 Nov 2002 14:43:06 +0530
From: Dipankar Sarma <woofwoof@hathway.com>
To: Andrew Morton <akpm@digeo.com>
Cc: dipankar@in.ibm.com, Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@math.psu.edu>, LKML <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@au1.ibm.com>,
       Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: dcache_rcu [performance results]
Message-ID: <20021102144306.A6736@dikhow>
Reply-To: woofwoof@hathway.com
References: <20021030161912.E2613@in.ibm.com> <20021031162330.B12797@in.ibm.com> <3DC32C03.C3910128@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC32C03.C3910128@digeo.com>; from akpm@digeo.com on Fri, Nov 01, 2002 at 05:36:03PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 05:36:03PM -0800, Andrew Morton wrote:
> Dipankar Sarma wrote:
> > [ dcache-rcu ]
> > Anton (Blanchard) did some benchmarking with this
> > in a 24-way ppc64 box and the results showed why we need this patch.
> > Here are some performace comparisons based on a multi-user benchmark
> > that Anton ran with vanilla 2.5.40 and 2.5.40-mm.
> > 
> > http://lse.sourceforge.net/locking/dcache/summary.png
> > 
> simulates lots of developers doing developer things on a multiuser
> machine.  Lots of compiling, groffing, etc.
> 
> Why does the removal of `ps' from the test script make such a huge
> difference?  That's silly, and we should fix it.

I have uploaded the profiles from Anton's benchmark runs -

http://lse.sourceforge.net/locking/dcache/results/2.5.40/200-base.html
http://lse.sourceforge.net/locking/dcache/results/2.5.40/200-base-nops.html
http://lse.sourceforge.net/locking/dcache/results/2.5.40/200-mm.html
http://lse.sourceforge.net/locking/dcache/results/2.5.40/200-mm-nops.html

A quick comparison of base and base-nops profiles show this -

base :

Hits Percentage Function
75185 100.00 total
11215 14.92 path_lookup <1.html>
8578 11.41 atomic_dec_and_lock <2.html>
5763 7.67 do_lookup <3.html>
5745 7.64 proc_pid_readlink <4.html>
4344 5.78 page_remove_rmap <5.html>
2144 2.85 page_add_rmap <6.html>
1587 2.11 link_path_walk <7.html>
1531 2.04 proc_check_root <8.html>
1461 1.94 save_remaining_regs <9.html>
1345 1.79 inode_change_ok <10.html>
1236 1.64 ext2_free_blocks <11.html>
1215 1.62 ext2_new_block <12.html>
1067 1.42 d_lookup <13.html>

base-no-ps :

Hits Percentage Function
50895 100.00 total
8222 16.15 page_remove_rmap <1.html>
3837 7.54 page_add_rmap <2.html>
2222 4.37 save_remaining_regs <3.html>
1618 3.18 release_pages <4.html>
1533 3.01 pSeries_flush_hash_range <5.html>
1446 2.84 do_page_fault <6.html>
1343 2.64 find_get_page <7.html>
1273 2.50 copy_page <8.html>
1228 2.41 copy_page_range <9.html>
1186 2.33 path_lookup <10.html>
1186 2.33 pSeries_insert_hpte <11.html>
1171 2.30 atomic_dec_and_lock <12.html>
1152 2.26 zap_pte_range <13.html>
841 1.65 do_generic_file_read <14.html>

Clearly dcache_lock is the killer when 'ps' command is used in
the benchmark. My guess (without looking at 'ps' code) is that
it has to open/close a lot of files in /proc and that increases
the number of acquisitions of dcache_lock. Increased # of acquisition
add to cache line bouncing and contention.

I should add that this is a general trend we see in all workloads
that do a lot of open/closes and so much so that performance is very
sensitive to how close to / your application's working directory
is. You would get much better system time if you compile a kernel
in /linux as compared to say /home/fs01/users/akpm/kernel/linux ;-)

> And it appears that dcache-rcu made a ~10% difference on a 24-way PPC64,
> yes?  That is nice, and perhaps we should take that, but it is not a
> tremendous speedup.

Hmm.. based on Anton's graph it looked more like ~25% difference for
60 or more scripts. At 200 scripts it is ~27.6%. Without the ps
command, it seems more like ~4%.


Thanks
Dipankar
