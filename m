Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUDLVDL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 17:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbUDLVDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 17:03:11 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:65251 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263085AbUDLVDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 17:03:01 -0400
Date: Mon, 12 Apr 2004 14:14:18 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Hugh Dickins <hugh@veritas.com>, Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
Message-ID: <69200000.1081804458@flay>
In-Reply-To: <Pine.LNX.4.58.0404121531580.15512@red.engin.umich.edu>
References: <Pine.LNX.4.44.0404122006050.10504-100000@localhost.localdomain> <Pine.LNX.4.58.0404121531580.15512@red.engin.umich.edu>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 12 Apr 2004, Hugh Dickins wrote:
>> On Mon, 12 Apr 2004, Martin J. Bligh wrote:
>> > 
>> > If it were just a list, maybe RCU would be appropriate. It might be
>> > rather write-heavy though ? I think I played with an rwsem instead
>> > of a sem in the past too (though be careful if you try this, as for
>> > no good reason the return codes are inverted ;-()
>> 
>> Yes, I think all the common paths have to write, in case the
>> uncommon paths (truncation and swapout) want to read: the wrong
>> way round for any kind of read-write optimization, isn't it?

But isn't objrmap a big read case? ;-)

> In common workloads e.g., add libc mapping using  __vma_prio_tree_insert,
> mostly you do not add new nodes to the tree. Instead, you just add to
> a vm_set list. I am currently considering using rwsem to optimize
> such cases. Similarly __vma_prio_tree_remove can also be optimized
> in some common cases. I don't know whether it will help. Let us see...

Sounds interesting ... so basically you're breaking out the locking of
the tree itself separately?

M.

PS. In the diffprofiles, I observed that Andrea had killed one of the large
remaining lock entries (.text.lock.filemap). Turns out he'd turned the
locking in find_get_page from "spin_lock(&mapping->page_lock)" into
"spin_lock_irq(&mapping->tree_lock)", and I'm using readprofile, which
doesn't profile with irqs off, so it's not really disappeared, just hidden.
Not sure which sub-patch that comes from, and it turned out to be a bit of
a dead end, but whilst I'm there, I thought I'd point out this was contended,
and show the diffprofile with and without spinline for aa5:

     22210  246777.8% find_trylock_page
      2538    36.4% atomic_dec_and_lock
      1249   146.6% grab_block
      1042    99.6% kmap_high
       882  29400.0% find_get_pages
       868    69.1% file_kill
       744    30.9% file_move
       499   236.5% proc_pid_readlink
       433    82.8% d_instantiate
       389   110.2% kunmap_high
       319    52.4% ext2_new_block
       303    27.2% d_alloc
       220    44.9% prune_dcache
       206     3.1% __wake_up
       195    26.4% new_inode
       194    71.6% d_delete
       161    33.5% d_path
       146    53.9% group_reserve_blocks
       124    11.4% __mark_inode_dirty
       117    13.9% __find_get_block_slow
       116    45.7% __insert_inode_hash
       113     8.3% page_address
       106     5.0% proc_pid_stat
...
      -216  -100.0% .text.lock.namespace
      -244    -1.1% __down
      -352  -100.0% .text.lock.inode
      -684  -100.0% .text.lock.base
      -887   -96.3% find_get_pages_tag
     -1269  -100.0% .text.lock.highmem
     -1523  -100.0% .text.lock.file_table
     -1535  -100.0% .text.lock.dcache
     -1549    -0.2% total
     -2834  -100.0% .text.lock.dec_and_lock
     -2915    -0.6% default_idle
    -21908   -99.8% find_get_page

(SDET 128 on the 16-way NUMA-Q).
(this basically shows who was taking the locks we see in profiles).
Still not quite sure why inlining the spinlocks did this, to be honest:

     22210  246777.8% find_trylock_page
    -21908   -99.8% find_get_page

as neither seems to call the other. Humpf.


