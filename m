Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264803AbTE1Q5T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 12:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264804AbTE1Q5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 12:57:19 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:53155 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264803AbTE1Q5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 12:57:11 -0400
Message-ID: <3ED4ED6B.2010503@us.ibm.com>
Date: Wed, 28 May 2003 10:10:03 -0700
From: Mingming Cao <cmm@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>, bzzz@tmi.comex.ru
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, cmm@us.ibm.com
Subject: Re: 2.5.70-mm1
References: <20030527004255.5e32297b.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.70-mm1.gz
> 
>   Will appear soon at
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm1/
> 
> . A number of fixes against the ext3 work which Alex and I have been doing.
>   This code is stable now.  I'm using it on my main SMP desktop machine.
> 
>   These are major changes to a major filesystem.  I would ask that
>   interested parties now subject these patches to stresstesting and to
>   performance testing.  The performance gains on SMP will be significant.
> 

I have run 50 fsx tests overnight on a 8 way PIII SMP box.  Each fsx 
test reads/writes on it's own ext3 filesystem.  The 50 filesystems  
spread over 10 disks.

Some kernel oops happened during the test. One fsx test becomes 
unresponsive. The kernek did not hang.  Here are the three kinds of 
oops.  The first and the last kind happened only once, the second kind 
of oops happened several times.

====================================================================

Unable to handle kernel NULL pointer dereference at virtual address 00000018
  printing eip:
c01a192b
*pde = 00000000
Oops: 0000 [#1]
CPU:    4
EIP:    0060:[<c01a192b>]    Not tainted VLI
EFLAGS: 00010246
EIP is at journal_try_to_free_buffers+0x8b/0x1d0
eax: 00000000   ebx: cce57b34   ecx: c0192bf0   edx: c337dd48
esi: 00000000   edi: cce57b34   ebp: c337dd48   esp: c3a13d04
ds: 007b   es: 007b   ss: 0068
Process pdflush (pid: 36, threadinfo=c3a12000 task=c3a26ce0)
Stack: c3a13d24 c3a13d24 f7b4dc00 c05aa660 00000286 00000000 00000000 
00000000
        cce57b34 00001000 c0192c22 f7b4dc00 c337dd48 00000000 c015804c 
c337dd48
        00000000 00000000 cce57b34 c015815b c337dd48 00000000 00000001 
cce57b34
Call Trace:
  [<c0192c22>] ext3_releasepage+0x32/0x40
  [<c015804c>] try_to_release_page+0x5c/0x70
  [<c015815b>] block_invalidatepage+0xfb/0x110
  [<c0159e33>] block_write_full_page+0x53/0xe0
  [<c0192347>] walk_page_buffers+0x77/0x80
  [<c0192a46>] ext3_writepage+0x166/0x280
  [<c0191df0>] ext3_get_block+0x0/0xb0
  [<c01928c0>] bget_one+0x0/0x10
  [<c01788b8>] mpage_writepages+0x238/0x305
  [<c015d1f0>] blkdev_writepage+0x0/0x30
  [<c01928e0>] ext3_writepage+0x0/0x280
  [<c011bf8a>] default_wake_function+0x2a/0x30
  [<c013d5c6>] do_writepages+0x36/0x40
  [<c0176c94>] __sync_single_inode+0xc4/0x220
  [<c017702c>] sync_sb_inodes+0x18c/0x250
  [<c0177159>] writeback_inodes+0x69/0xa0
  [<c013d438>] wb_kupdate+0xb8/0x130
  [<c013d9f0>] __pdflush+0xd0/0x1c0
  [<c013dae0>] pdflush+0x0/0x20
  [<c013daef>] pdflush+0xf/0x20
  [<c013d380>] wb_kupdate+0x0/0x130
  [<c0107228>] kernel_thread_helper+0x0/0x18
  [<c010722d>] kernel_thread_helper+0x5/0x18

Code: ba 2b 10 19 c0 85 c0 75 e7 8b 03 a9 00 04 00 00 74 6d 8b 03 8b 73 
28 83 e0 04 0f 85 10 01 00 00 8b 03 83 e0 02 0f 85 05 01 00 00 <8b> 46 
18 85 c0 0f 85 fa 00 00 00 8b 44 24 2c f0 fe 88 c0 00 00
=======================================================================

<0>Assertion failure in journal_dirty_metadata() at 
fs/jbd/transaction.c:1111: "jh->b_transaction == 
journal->j_running_transaction"
------------[ cut here ]------------
kernel BUG at fs/jbd/transaction.c:1111!
invalid operand: 0000 [#9]
CPU:    4
EIP:    0060:[<c01a1052>]    Not tainted VLI
EFLAGS: 00010282
EIP is at journal_dirty_metadata+0x212/0x220
eax: 00000085   ebx: f5c6c2e0   ecx: 00000097   edx: c049cdfc
esi: f5ea8d30   edi: f5549ae0   ebp: f5a78200   esp: f5827b04
ds: 007b   es: 007b   ss: 0068
Process fsx (pid: 1968, threadinfo=f5826000 task=f5836ce0)
Stack: c042a2e0 c040f030 c042693b 00000457 c042c820 00002e5b 00000000 
f5c6c2e0
        00000001 c018e56b d435aaa8 f5c6c2e0 f5827b40 00000000 00001000 
00000000
        00000000 f5a78400 00002e5a f5cc8000 c018e842 f5a78400 d435aaa8 
00000000
Call Trace:
  [<c018e56b>] ext3_try_to_allocate+0x1ab/0x2b0
  [<c018e842>] ext3_new_block+0x1d2/0x580
  [<c0157d63>] __find_get_block+0x73/0x100
  [<c0191267>] ext3_alloc_block+0x37/0x40
  [<c019162a>] ext3_alloc_branch+0x4a/0x2c0
  [<c0191c1c>] ext3_get_block_handle+0x18c/0x360
  [<c015a5f1>] alloc_buffer_head+0x41/0x50
  [<c0191e54>] ext3_get_block+0x64/0xb0
  [<c0158917>] __block_prepare_write+0x227/0x4b0
  [<c0159454>] block_prepare_write+0x34/0x50
  [<c0191df0>] ext3_get_block+0x0/0xb0
  [<c0192431>] ext3_prepare_write+0x71/0x130
  [<c0191df0>] ext3_get_block+0x0/0xb0
  [<c0139ecd>] generic_file_aio_write_nolock+0x38d/0xa30
  [<c0137e21>] add_to_page_cache+0x71/0x110
  [<c0170662>] update_atime+0x92/0xf0
  [<c0138d34>] __generic_file_aio_read+0x1c4/0x210
  [<c013a6b6>] generic_file_aio_write+0x86/0xb0
  [<c018faf4>] ext3_file_write+0x44/0xe0
  [<c0155106>] do_sync_write+0xb6/0xf0
  [<c0176b76>] __mark_inode_dirty+0xf6/0x100
  [<c016001e>] cp_new_stat64+0xfe/0x110
  [<c011df10>] autoremove_wake_function+0x0/0x50
  [<c01600e7>] sys_fstat64+0x37/0x40
  [<c01551fe>] vfs_write+0xbe/0x130
  [<c01549b0>] generic_file_llseek+0x0/0xf0
  [<c0155322>] sys_write+0x42/0x70
  [<c010943f>] syscall_call+0x7/0xb

Code: 04 24 e0 a2 42 c0 c7 44 24 04 30 f0 40 c0 c7 44 24 08 3b 69 42 c0 
c7 44 24 0c 57 04 00 00 c7 44 24 10 20 c8 42 c0 e8 0e f4 f7 ff <0f> 0b 
57 04 3b 69 42 c0 e9 ff fe ff ff 90 57 b8 10 00 00 00 56
========================================================================

  <0>Assertion failure in __journal_drop_transaction() at 
fs/jbd/checkpoint.c:619: "transaction->t_updates == 0"
------------[ cut here ]------------
kernel BUG at fs/jbd/checkpoint.c:619!
invalid operand: 0000 [#6]
CPU:    7
EIP:    0060:[<c01a4e7c>]    Not tainted VLI
EFLAGS: 00010286
EIP is at __journal_drop_transaction+0x1fc/0x3db
eax: 0000006f   ebx: f4132720   ecx: 00000097   edx: c049cdfc
esi: f5b98e00   edi: 00000000   ebp: 00000000   esp: f5b87dac
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 1850, threadinfo=f5b86000 task=f7896060)
Stack: c042a2e0 c040f1de c0426b48 0000026b c0426b7c f4132720 f5b98e00 
c01a4b5a
        f5b98e00 f4132720 f602cda4 f64b64f0 c01a2c95 f64b64f0 f7252e80 
00000003
        000008be f711df3c f5b86000 00000000 00000fdc e1f62024 00000000 
00000000
Call Trace:
  [<c01a4b5a>] __journal_remove_checkpoint+0x4a/0x90
  [<c01a2c95>] journal_commit_transaction+0x745/0x1220
  [<c011df10>] autoremove_wake_function+0x0/0x50
  [<c02f96b0>] scsi_io_completion+0x160/0x4b0
  [<c011df10>] autoremove_wake_function+0x0/0x50
  [<c01161cd>] smp_apic_timer_interrupt+0xcd/0x140
  [<c011bc77>] schedule+0x207/0x4f0
  [<c01a5f96>] kjournald+0x236/0x260
  [<c011df10>] autoremove_wake_function+0x0/0x50
  [<c011df10>] autoremove_wake_function+0x0/0x50
  [<c0109352>] ret_from_fork+0x6/0x14
  [<c01a5d40>] commit_timeout+0x0/0x10
  [<c01a5d60>] kjournald+0x0/0x260
  [<c010722d>] kernel_thread_helper+0x5/0x18

Code: 04 24 e0 a2 42 c0 c7 44 24 04 de f1 40 c0 c7 44 24 08 48 6b 42 c0 
c7 44 24 0c 6b 02 00 00 c7 44 24 10 7c 6b 42 c0 e8 e4 b5 f7 ff <0f> 0b 
6b 02 48 6b 42 c0 e9 f1 fe ff ff 8d b4 26 00 00 00 00 c7

