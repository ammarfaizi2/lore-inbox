Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264826AbSJaKlP>; Thu, 31 Oct 2002 05:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264828AbSJaKlO>; Thu, 31 Oct 2002 05:41:14 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:60618 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264826AbSJaKlK>; Thu, 31 Oct 2002 05:41:10 -0500
Date: Thu, 31 Oct 2002 16:23:30 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Al Viro <viro@math.psu.edu>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Anton Blanchard <anton@au1.ibm.com>,
       Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: dcache_rcu [performance results]
Message-ID: <20021031162330.B12797@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20021030161912.E2613@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021030161912.E2613@in.ibm.com>; from maneesh@in.ibm.com on Wed, Oct 30, 2002 at 04:19:12PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 04:19:12PM +0530, Maneesh Soni wrote:
> Hello Viro,
> 
> Please consider forwarding the following patch ito Linus for dcache lookup 
> using Read Copy Update. The patch has been there in -mm kernel since 
> 2.5.37-mm1. The patch is stable. A couple of bugs reported are solved. It 
> helps a great deal on higher end SMP machines and there is no performance 
> regression on UP and lower end SMP machines as seen in Dipankar's kernbench 
> numbers.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103462075416638&w=2
> 

Anton (Blanchard) did some benchmarking with this
in a 24-way ppc64 box and the results showed why we need this patch.
Here are some performace comparisons based on a multi-user benchmark 
that Anton ran with vanilla 2.5.40 and 2.5.40-mm. 

http://lse.sourceforge.net/locking/dcache/summary.png

base = 2.5.40
base-nops = 2.5.40 but ps command in benchmark scripts commented out
mm = 2.5.40-mm
mm-nops = 2.5.40-mm but ps command in benchmark scripts commented out

Here is a profile output snippet of base and mm runs at 200 scripts -

base :

Hits Percentage Function
------------------------
75185 100.00 total
11215 14.92 path_lookup
8578 11.41 atomic_dec_and_lock
5763 7.67 do_lookup
5745 7.64 proc_pid_readlink
4344 5.78 page_remove_rmap
2144 2.85 page_add_rmap
1587 2.11 link_path_walk
1531 2.04 proc_check_root
1461 1.94 save_remaining_regs
1345 1.79 inode_change_ok
1236 1.64 ext2_free_blocks
1215 1.62 ext2_new_block
1067 1.42 d_lookup
1053 1.40 number
907 1.21 release_pages


mm :

Hits Percentage Function
62369 100.00 total
5802 9.30 page_remove_rmap 
4092 6.56 atomic_dec_and_lock
3887 6.23 proc_pid_readlink
3207 5.14 follow_mount
2979 4.78 page_add_rmap
2066 3.31 save_remaining_regs 
1856 2.98 d_lookup
1629 2.61 number
1235 1.98 release_pages
1168 1.87 pSeries_flush_hash_range
1154 1.85 do_page_fault
1026 1.65 copy_page
1009 1.62 path_lookup


Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
