Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268067AbTAJARR>; Thu, 9 Jan 2003 19:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268068AbTAJARR>; Thu, 9 Jan 2003 19:17:17 -0500
Received: from holomorphy.com ([66.224.33.161]:40597 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268067AbTAJARP>;
	Thu, 9 Jan 2003 19:17:15 -0500
Date: Thu, 9 Jan 2003 16:25:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Chris Wood <cwood@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
Message-ID: <20030110002548.GG23814@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Chris Wood <cwood@xmission.com>,
	linux-kernel@vger.kernel.org
References: <3E1A12B5.4020505@xmission.com> <3E1A16C5.87EDE35A@digeo.com> <3E1DAEAC.4060904@xmission.com> <3E1DD913.2571469F@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1DD913.2571469F@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 12:18:27PM -0800, Andrew Morton wrote:
> These numbers are a little odd.  You seem to have only lost 200M of
> lowmem to buffer_heads.  Bill, what's your take on this?

He's really low on lowmem. It's <= 16GB or so so mem_map is near-
irrelevant, say 60MB.

My interpretation of the numbers is as follows, where pae_pmd and
kernel_stack are both guessed from pae_pgd:

       buffer_head:   166994KB   183768KB   90.87
           pae_pmd:    21576KB    21576KB  100.0 
      kernel_stack:    14384KB    14384KB  100.0 
       inode_cache:     6904KB    10377KB   66.52
              filp:     6539KB     6547KB   99.87
    vm_area_struct:     4897KB     4897KB  100.0 
         size-4096:     3924KB     4044KB   97.3 
          size-256:     2137KB     2137KB  100.0 
        signal_act:     1966KB     1966KB  100.0 
      dentry_cache:      747KB     1758KB   42.47
              sock:     1368KB     1368KB  100.0 
         size-1024:     1080KB     1080KB  100.0 
       files_cache:      738KB      738KB  100.0 
         size-2048:      624KB      684KB   91.22
           size-64:      323KB      525KB   61.69
           size-32:      158KB      445KB   35.54
          size-512:      416KB      416KB  100.0 
         mm_struct:      405KB      405KB  100.0 
          size-128:      356KB      356KB  100.0 
 skbuff_head_cache:      171KB      255KB   67.15
      ip_dst_cache:      240KB      240KB  100.0 
   file_lock_cache:      166KB      191KB   87.5 
      journal_head:       77KB      176KB   43.99
          fs_cache:      113KB      123KB   92.3 
           pae_pgd:      112KB      112KB  100.0 
   blkdev_requests:       96KB      101KB   94.81
        size-16384:       80KB       80KB  100.0 
        cdev_cache:       45KB       47KB   96.15
         arp_cache:       29KB       45KB   64.44
         size-8192:       40KB       40KB  100.0 
       names_cache:       32KB       32KB  100.0 
        size-32768:       32KB       32KB  100.0 
   tcp_bind_bucket:       21KB       28KB   77.67
          sigqueue:       26KB       26KB  100.0 
     tcp_tw_bucket:       18KB       18KB  100.0 
         uid_cache:       15KB       17KB   89.46
  tcp_open_request:       15KB       15KB  100.0 
        kmem_cache:       15KB       15KB  100.0 
   inet_peer_cache:        6KB       14KB   46.12
     size-128(DMA):        0KB        7KB    3.33
      size-32(DMA):        2KB        7KB   29.31
       ip_fib_hash:        0KB        7KB    6.25
        bdev_cache:        0KB        7KB    7.75
         mnt_cache:        1KB        7KB   15.51
     dnotify_cache:        4KB        6KB   71.68
      fasync_cache:        4KB        6KB   68.25
      revoke_table:        0KB        2KB    2.80

== grand total of 253.015MB, fragmentation included.
	+ 60MB mem_map
== grand total of 313MB or so


Either pollwait tables (invisible in 2.4 and 2.5), kernel stacks of
threads (which don't get pae_pgd's and are hence invisible in 2.4
and 2.5), or pagecache, with a much higher likelihood of pagecache.

Or there might be dark matter in the universe, and he's being bitten by 
unaccounted !__GFP_HIGHMEM allocations, e.g. stock 2.4.x pagetables,
which aren't predictable from pae_pgd etc. highpte of any flavor (aa or
otherwise) should fix that. But there's no way to guess, as there's zero
2.4.x PTE accounting or even any hints from this report, like average
RSS and VSZ (which are still underestimates, as 2.4.x pagetables are
leaked over the lifetime of the process vs. 2.5.x's reap-on-munmap()).


Bill
