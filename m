Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266158AbUFIPMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266158AbUFIPMS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 11:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266160AbUFIPMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 11:12:18 -0400
Received: from [63.81.117.10] ([63.81.117.10]:65190 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S266158AbUFIPMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:12:06 -0400
Message-ID: <40C72746.8060603@xfs.org>
Date: Wed, 09 Jun 2004 10:05:42 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: nathans@sgi.com, linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in xfs
References: <20040609122647.GF21168@wohnheim.fh-wedel.de>
In-Reply-To: <20040609122647.GF21168@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 09 Jun 2004 15:12:04.0790 (UTC) FILETIME=[1F8E4560:01C44E34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> xfs is quite interesting.  No single function is particularly
> stack-hungry, but the sheer depth of the call path adds up.  Nathan,
> can you see if some bytes can be saved here and there?
> 
> 3k is not really bad yet, I just like to keep 1k of headroom for
> surprises like an extra int foo[256] in a structure.

Are you doing some form of call chain analysis to arrive
at this stack?

Actually this one is impossible, the function xfs_bmapi is
confusing you analyser, it is used for read and write
calls to map from file offsets to disk blocks. The path
you chased down from xfs_bmapi is doing a realtime
allocation, the swapext call does not do allocations,
it is in this case looking up the contents of an acl
for a permission check - xfs_bmapi in this case will
not call much of anything.

The bmapi path you did follow, for an allocation in a
realtime file, is doing a read of the realtime bitmap
inode which holds the layout of the realtime component
of the filesystem.

Once it gets to schedule it is  a little out of XFS's hands what
happens, or which stack is actually in use. I think the
path you followed out of schedule is the cleanup of the
audit structure of a dead process - it is the one doing
the panicing here. An xfs call into schedule to wait for
I/O will not be going down that path.

I think you have to be careful looking at these call chains.

Steve

> 
> stackframes for call path too long (3064):
>     size  function
>      144  xfs_ioctl
>      328  xfs_swapext
>        0  xfs_iaccess
>       16  xfs_acl_iaccess
>      104  xfs_attr_fetch
>        0  xfs_attr_node_get
>       28  xfs_da_node_lookup_int
>       68  xfs_dir2_leafn_lookup_int
>        0  xfs_da_read_buf
>      288  xfs_bmapi
>       52  xfs_rtpick_extent
>       24  xfs_trans_iget
>       32  xfs_iget
>       32  xfs_iread
>       72  xfs_itobp
>       60  xfs_imap
>       84  xfs_dilocate
>        0  xfs_inobt_lookup_le
>       16  xfs_inobt_increment
>       28  xfs_btree_readahead_core
>       20  xfs_btree_reada_bufl
>       12  pagebuf_readahead
>       16  pagebuf_get
>        0  pagebuf_iostart
>        0  xfs_bdstrat_cb
>       68  pagebuf_iorequest
>        0  pagebuf_iodone
>        0  pagebuf_iodone_work
>        0  pagebuf_rele
>        0  preempt_schedule
>       84  schedule
>       16  __put_task_struct
>       20  audit_free
>       36  audit_log_start
>       16  __kmalloc
>        0  __get_free_pages
>       28  __alloc_pages
>      284  try_to_free_pages
>        0  out_of_memory
>        0  mmput
>       16  exit_aio
>        0  __put_ioctx
>       16  do_munmap
>        0  split_vma
>       36  vma_adjust
>        0  fput
>        0  __fput
>        0  locks_remove_flock
>       12  panic
>        0  sys_sync
>        0  sync_inodes
>      308  sync_inodes_sb
>        0  do_writepages
>      128  mpage_writepages
>        4  write_boundary_block
>        0  ll_rw_block
>       28  submit_bh
>        0  bio_alloc
>       88  mempool_alloc
>      256  wakeup_bdflush
>       20  pdflush_operation
>        0  printk
>       16  release_console_sem
>       16  __wake_up
>        0  printk
>        0  vscnprintf
>       32  vsnprintf
>      112  number
> 
> Jörn
> 

