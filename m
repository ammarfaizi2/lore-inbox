Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbTDVDKb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 23:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbTDVDKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 23:10:31 -0400
Received: from franka.aracnet.com ([216.99.193.44]:50924 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262770AbTDVDKa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 23:10:30 -0400
Date: Mon, 21 Apr 2003 20:22:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 67-mjb2 vs 68-mjb1 (sdet degredation)
Message-ID: <147950000.1050981750@[10.10.2.4]>
In-Reply-To: <20030421144631.4987db46.akpm@digeo.com>
References: <1425480000.1050959528@flay>
 <20030421144631.4987db46.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Seem to loose about 2-3% on SDET syncing with 2.5.68. Not much change
>> apart from 67-68 changes. The merge of the ext2 alloc stuff has made
>> such a dramatic improvment for virgin 67-68, it's hard to see if
>> there was any degredation in mainline ;-) I had those in my tree before
>> though, so there should be much less change.
>> 
>> Just wondering if you can recognise / guess the problem from the
>> profiles, else I'll poke at it some more (will probably just work out
>> what's hitting .text.lock.filemap).
>> 
> 
> erk.  Looks like the rwlock->spinlock conversion of mapping->page_lock.
> 
> That was a small (1%?) win on small SMP, and looks to be a small lose on
> big SMP.  No real surprise there.
> 
> Here's a backout patch.  Does it fix it up?

Yeah, that fixes it. Ho hum ... I wonder if we can find something that
works well for both cases? I guess the options would be:

1. Some way to make the rwlock mechanism itself faster.
2. Try to fix the contention itself somehow for this instance.

Not sure if 1 is fundamentally futile or not, but would obviously be better
(more general) if it's possible ;-)

       121    26.2% __down
       115  2875.0% find_trylock_page
        37    17.9% __wake_up
        36     3.5% atomic_dec_and_lock
        24     8.6% path_release
        22    14.0% .text.lock.attr
        21     1.8% copy_page_range
        16     1.3% page_remove_rmap
        16     6.2% free_pages_and_swap_cache
        14     2.6% .text.lock.dcache
        14     9.2% number
        14    10.1% .text.lock.highmem
        12    21.1% dentry_open
        12     5.5% file_move
        11    11.0% flush_signal_handlers
        10    14.3% generic_fillattr
        10     3.4% schedule
        10     6.8% __fput
...
       -10    -1.4% __copy_to_user_ll
       -10    -5.8% fd_install
       -10    -1.5% path_lookup
       -10   -41.7% release_blocks
       -11    -5.8% __read_lock_failed
       -12    -4.5% proc_pid_stat
       -12    -0.8% zap_pte_range
       -12   -26.7% kunmap_high
       -13   -29.5% d_lookup
       -14    -9.8% __brelse
       -14    -8.9% kmap_atomic
       -14   -10.3% exit_notify
       -16    -7.5% filemap_nopage
       -17   -10.7% grab_block
       -19    -8.9% d_alloc
       -20   -11.2% __find_get_block
       -99    -0.3% default_idle
      -100   -23.3% do_no_page
      -171   -18.8% find_get_page
      -432  -100.0% .text.lock.filemap
      -484    -0.8% total

