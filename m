Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262465AbSI3Q0a>; Mon, 30 Sep 2002 12:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262491AbSI3Q0a>; Mon, 30 Sep 2002 12:26:30 -0400
Received: from franka.aracnet.com ([216.99.193.44]:54204 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262465AbSI3Q00>; Mon, 30 Sep 2002 12:26:26 -0400
Date: Mon, 30 Sep 2002 09:29:10 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       Anton Blanchard <anton@samba.org>
Subject: Re: 2.5.39-mm1
Message-ID: <766838976.1033378149@[10.10.2.3]>
In-Reply-To: <3D9804E1.76C9D4AE@digeo.com>
References: <3D9804E1.76C9D4AE@digeo.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well that's still a 1% bottom line.  But we don't have a
> comparison which shows the effects of this patch alone.
> 
> Can you patch -R the five patches and retest sometime?
> 
> I just get the feeling that it should be doing better.

Well, I think something is indeed wrong.

Averages times of 5 kernel compiles on 16-way NUMA-Q:

2.5.38-mm1
Elapsed: 20.44s User: 192.118s System: 46.346s CPU: 1166.6%
2.5.38-mm1 + the original hot/cold stuff I sent you
Elapsed: 19.798s User: 191.61s System: 43.322s CPU: 1186.4%

Reduction in both system and elapsed time.

2.5.39-mm1 w/o hot/cold stuff
Elapsed: 19.538s User: 191.91s System: 44.746s CPU: 1210.8%
2.5.39-mm1
Elapsed: 19.532s User: 192.25s System: 42.642s CPU: 1203.2%

No change in elapsed time, system time down somewhat.

Looking at differences in averaged profiles:

Going from 38-mm1 to 38-mm1-hot (+ made things worse, - better)
Everything below 50 ticks difference excluded.

960 alloc_percpu_page
355 free_percpu_page
266 page_remove_rmap
96 file_read_actor
89 vm_enough_memory
56 page_add_rmap
-50 do_wp_page
-53 __pagevec_lru_add
-56 schedule
-73 dentry_open
-93 __generic_copy_from_user
-96 atomic_dec_and_lock
-97 get_empty_filp
-131 __fput
-144 __set_page_dirty_buffers
-147 do_softirq
-169 __alloc_pages
-187 .text.lock.file_table
-263 pgd_alloc
-323 pte_alloc_one
-396 zap_pte_range
-408 do_anonymous_page
-733 __free_pages_ok
-1301 rmqueue
-6709 default_idle
-9776 total

Going from 39-mm1 w/o hot to 39-mm1

1600 default_idle
896 buffered_rmqueue
421 free_hot_cold_page
271 page_remove_rmap
197 vm_enough_memory
161 .text.lock.file_table
132 get_empty_filp
95 __fput
90 atomic_dec_and_lock
50 filemap_nopage
-55 do_no_page
-55 __pagevec_lru_add
-62 schedule
-65 fd_install
-70 file_read_actor
-73 find_get_page
-81 d_lookup
-111 __set_page_dirty_buffers
-285 pgd_alloc
-350 pte_alloc_one
-382 do_anonymous_page
-412 zap_pte_range
-508 total
-717 __free_pages_ok
-1285 rmqueue

Which looks about the same to me? Me slightly confused. Will try
adding the original hot/cold stuff onto 39-mm1 if you like?

M.
