Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267896AbTBLTXX>; Wed, 12 Feb 2003 14:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267902AbTBLTXX>; Wed, 12 Feb 2003 14:23:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21773 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267896AbTBLTXT>;
	Wed, 12 Feb 2003 14:23:19 -0500
Message-ID: <3E4AA154.7070307@pobox.com>
Date: Wed, 12 Feb 2003 14:32:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: akpm@digeo.com
Subject: 2.5.60-BK reproducible oops, during LTP run
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have reproduced the BUG in fs/buffer.c:2533 twice now.  Test 
conditions exactly the same, fsx-linux in one window, LTP in another window.

The machine stays alive for pings and sysrq's, but I cannot ssh into it 
nor login at the console.  sysrq-s initiates a sync of the root 
filesystem on the ATA disk but never finishes.  other sysrq's and pings 
continues to work after the sysrq-s invocation.

Call trace from BUG, each time I hit it:
EIP in submit_bh
ll_rw_block
journal_commit_transaction
schedule
default_wake_function
kjournald
commit_timeout
kjournald
kernel_thread_helper

sysrq-t bits (I note truncate and sys_sync as common elements):
* shows that LTP test "ftest08" is running
* fsx-linux stack trace:  io_schedule, __wait_on_buffer, 
free_hot_cold_page, autoremove_wake_function, autoremovce_wake_function, 
journal_invalidatepage, ext2_invalidatepage, do_invalidatepage, 
truncate_complete_page, truncate_inode_pages, vmtruncate, inode_setattr, 
ext3_setattr, notify_change, do_truncate, do_sys_ftruncate, 
sys_ftruncate, syscall_call
* ftest08 stack trace, process 0: sys_wait4, do_fork, 
default_wake_function, default_wake_function, sycall_call
* ftest08 trace, proc 1: __down, default_wake_function, __down_failed, 
.text.ock.read_write, sys_llseek, sys_sync, syscall_call
* ftest08 trace, proc 2: do_readv_writev, __down, default_wake_function, 
__down_failed, .text.lock.read_write, sys_llseek, syscall_call
* ftest08 trace, proc 3: sleep_on, default_wake_function, 
log_wait_commit, journal_stop, journal_force_commit, write_inode, 
__sync_single_inode, sync_sb_inodes, sync_inodes_sb, sync_inodes, 
sys_sync, syscall_call
* ftest08 trace, proc 4: do_writepages, __down, default_wake_function, 
__down_failed, .text.lock.read_write, sync_blockdev, sys_llseek, 
sys_sync, syscall_call
* ftest08 trace, proc 5: sleep_on, default_wake_function, 
log_wait_commit, journal_stop, journal_force_commit, ext3_force_commit, 
ext3_sync_file, sys_fsync, syscall_call


sysrq-m bits:

free pages: 5552kB (0kB highmem)
active: 48451, inactive: 9478 dirty:10 writeback:0 free:1388
DMA free: 2368kB, min 128kB, low:256kB, high:384kB, active:3776kB, 
inactive:6688kB
Normal free: 3184kB min:1020 low:2040 high:3060 active:190028 inactive:31224
swap cache: add 93, delete 92, find 24/26, race 0+0
free swap: 2096776kB
63472 pages of RAM
1471 reserved pages
27697 pages shared
1 pages swap cached


hardware bits:

via c3 cpu
gcc 3.2.2
kernel 2.5.60-bk2
one 40GB ATA/100 drive, running at ATA/100
256 MB RAM

