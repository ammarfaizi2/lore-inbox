Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVCVS4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVCVS4f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 13:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVCVS4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 13:56:35 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:2690 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261623AbVCVS4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 13:56:15 -0500
Date: Tue, 22 Mar 2005 19:56:05 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: 2.6.12-rc1-mm1: REISER4_FS <-> 4KSTACKS
Message-ID: <20050322185605.GB27733@wohnheim.fh-wedel.de>
References: <20050321025159.1cabd62e.akpm@osdl.org> <20050322171340.GE1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050322171340.GE1948@stusta.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 March 2005 18:13:40 +0100, Adrian Bunk wrote:
> 
> REISER4_FS is the only option with a dependency on !4KSTACKS which is 
> bad since 8 kB stacks on i386 won't stay forever.
> 
> Could fix the problems with 4 kB stacks?
> 
> Running
> 
>   make checkstacks | grep reiser4
> 
> inside te kernel sources after compiling gives you hints where problems 
> might come from.

Actually, I've run the Big Ol' checkstack program on reiser4 once.
Without recursions, the code is well below 3k, but some of the
recursions look a bit daunting.  Here is the relevant output:

WARNING: recursion detected:
       8  jload_gfp
      36  eflush_del
      24  eflush_free
      36  ef_free_block
       0  reiser4_dealloc_block
      28  reiser4_dealloc_blocks
       0  sa_dealloc_blocks
      32  dealloc_blocks_bitmap
      36  load_and_lock_bnode
      20  prepare_bnode

WARNING: recursion detected:
       8  zload
      16  zload_ra
      68  formatted_readahead
       0  reiser4_get_right_neighbor
     264  reiser4_get_neighbor
     108  renew_neighbor
      44  renew_sibling_link
      48  far_next_coord

WARNING: recursion detected:
      32  reiser4_grab_space
      12  txnmgr_force_commit_all
       0  force_commit_atom_nolock
       4  txn_restart_current
       8  txn_restart
       8  txn_end
      36  commit_txnh
      16  try_commit_txnh
      28  commit_current_atom
      24  flush_current_atom
     404  jnode_flush
      88  alloc_pos_and_ancestors
      96  alloc_one_ancestor
      20  allocate_znode
      32  allocate_znode_loaded
      84  allocate_znode_update
       0  reiser4_alloc_block
      24  reiser4_alloc_blocks

stackframes for call path too long (2808):
    size  function
     460  rename_hashed
     112  safe_link_add
     108  store_black_box
      52  insert_by_key
     224  coord_by_key
      60  handle_eottl
     124  carry
      88  lock_carry_node
      72  add_tree_root
       8  zload
      16  zload_ra
      68  formatted_readahead
     264  reiser4_get_neighbor
       0  reiser4_get_parent
      28  reiser4_get_parent_flags
       8  longterm_unlock_znode
      20  forget_znode
       8  uncapture_page
      36  eflush_del
      24  eflush_free
      28  reiser4_dealloc_blocks
      32  dealloc_blocks_bitmap
      20  jinit_new
      20  jnode_get_page_locked
      16  find_or_create_page
      24  add_to_page_cache_lru
      24  add_to_page_cache
       8  radix_tree_preload
      12  kmem_cache_alloc
      52  __alloc_pages
       8  out_of_memory
       8  mmput
      16  exit_aio
      20  __put_ioctx
      40  do_munmap
      36  split_vma
      40  vma_adjust
       8  fput
       8  __fput
     208  locks_remove_flock
      20  lease_modify
      16  panic
       8  bust_spinlocks
       4  unblank_screen
      24  do_unblank_screen
      20  redraw_screen
      16  clear_selection
      24  invert_screen
       8  printk
     100  vprintk
      20  vscnprintf
      40  vsnprintf
     100  number


Jörn

-- 
People will accept your ideas much more readily if you tell them
that Benjamin Franklin said it first.
-- unknown
