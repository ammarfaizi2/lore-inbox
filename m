Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262044AbTCHPbr>; Sat, 8 Mar 2003 10:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262045AbTCHPbr>; Sat, 8 Mar 2003 10:31:47 -0500
Received: from franka.aracnet.com ([216.99.193.44]:46249 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262044AbTCHPbp>; Sat, 8 Mar 2003 10:31:45 -0500
Date: Sat, 08 Mar 2003 07:41:42 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] 6/6 cacheline align files_lock
Message-ID: <393020000.1047138100@[10.10.2.4]>
In-Reply-To: <20030308073535.B24272@infradead.org>
References: <52550000.1047080176@flay> <20030308073535.B24272@infradead.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm getting a lot of cacheline bounce from .text.lock.file_table due to 
>> false sharing of the cahceline. The following patch just aligns the lock
>> in it's own cacheline.
> 
> What about fixing it's use instead?  

Seriously, I'd love to do that ... files_lock is the highest item of 
the whole kernel compile profile overall, and accounts for about 10%
of all systime.

By I inlining the spinlocks, I can see the heavy users seem to be:

      6278   166.0% get_empty_filp
      5482   239.3% __fput
      4770   254.7% file_move
    -14464  -100.0% .text.lock.file_table

It seems to lock several different things though - free lists, tty lists,
etc, etc. I could break it up to one per list, but that means taking two
locks to shift between lists, which I'd prefer not to do if possible.

Andrew was talking about something more dramatic for it, but I'm not
sure exactly what ... any suggestions on how to drive a stake through
it's heart gladly accepted.

Ironically, the latest scheduler changes *seem* to get rid of about
57% of the cost of it .... I have *no* idea why. Diffprofile between
64 and 64-bk is just wierd:

      7222    45.1% page_remove_rmap
       521    18.4% __copy_from_user_ll
       422     8.9% __copy_to_user_ll
       334   105.4% __wake_up
       248    48.5% pte_alloc_one
       243   205.9% pgd_ctor
       211     4.6% vm_enough_memory
       198     6.3% zap_pte_range
       179    29.3% kmem_cache_free
       118    12.2% clear_page_tables
        99    13.2% __pte_chain_free
        84     6.1% do_no_page
        76     6.6% release_pages
        74     9.0% strnlen_user
        67     5.6% free_hot_cold_page
        65    14.4% copy_page_range
...
       -54   -26.1% generic_file_open
       -54    -7.8% dentry_open
       -55   -16.3% do_lookup
       -61    -1.7% find_get_page
       -74   -58.7% __wake_up_sync
       -74    -8.2% current_kernel_time
       -82   -16.1% file_ra_state_init
      -127    -8.0% schedule
      -132   -19.1% fd_install
      -148    -2.2% page_add_rmap
      -246    -3.0% d_lookup
      -263    -9.3% atomic_dec_and_lock
      -407   -25.7% file_move
      -455   -20.5% __fput
      -853   -21.1% get_empty_filp
      -870    -1.9% default_idle
     -1724    -1.0% total
     -8473   -59.8% .text.lock.file_table

page_remove_rmap I'm not too worried about, as I know objrmap will kill
that already (tried to combine them last night, but got an oops, which
I'm just about to try to recreate with just virgin -bk). But *why*
things are shifting about so much from (presumably) just the scheduler
changes is a mystery to me at least. 

Any ideas?

M.
