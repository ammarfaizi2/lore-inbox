Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266978AbTAOTJw>; Wed, 15 Jan 2003 14:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266977AbTAOTJw>; Wed, 15 Jan 2003 14:09:52 -0500
Received: from packet.digeo.com ([12.110.80.53]:45472 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266972AbTAOTIt>;
	Wed, 15 Jan 2003 14:08:49 -0500
Date: Wed, 15 Jan 2003 11:18:34 -0800
From: Andrew Morton <akpm@digeo.com>
To: Robert Macaulay <robert_macaulay@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.57 IO slowdown with CONFIG_PREEMPT enabled
Message-Id: <20030115111834.41881823.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0301151106340.21210-100000@ping.us.dell.com>
References: <Pine.LNX.4.44.0301151106340.21210-100000@ping.us.dell.com>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2003 19:17:36.0580 (UTC) FILETIME=[C34CC840:01C2BCCA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Macaulay <robert_macaulay@dell.com> wrote:
>
> In between 2.5.56 and 2.5.57 IO speeds have dropped if CONFIG_PREEMPT is 
> set. 
> 
> The machine is a 4 processor Xeon with 8GB of RAM. The external storage is
> attached to the machine via qlogic 2200 HBAs using the qlogicfc driver.  
> The filesystems on the external devices is reiserfs, mounted with noatime
> as the only change from defaults. The config file is attached below. The
> same config was used for both 2.5.56 and 2.5.57. The config has
> preemptable kernel enabled. I know preemption will lower your throughput,
> but it was enabled in 2.5.56, and speed was good.
> 

I cannot reproduce this :(

Machine is a quad pIII Xeon, 4G of RAM (IDE starts bouncing above 4G),
writing four disks (2xIDE, 2xSCSI).

With CONFIG_PREEMPT=y:

 3  1  1   1656   3224   3908 218564    0    0     0 76308 1545   705  1 86 13
 3  1  1   1656   3784   3996 217920    0    0     0 74676 1529   736  0 86 14
 3  1  1   1656   3024   4104 218388    0    0     0 71320 1538   614  0 86 13
 4  0  2   1656   2496   3948 219104    0    0     0 73992 1536   687  0 88 12
 3  1  1   1680   3652   4004 218004    0   24     0 74040 1524   647  0 88 12
 3  1  1   1680   2972   4032 218596   32    0    48 78136 1547   688  0 87 13

oprofile says:

c01685f4 164      0.49068     mpage_writepages
c01e6a14 177      0.529575    journal_mark_dirty
c014c79c 182      0.544535    __block_prepare_write
c01ca90c 190      0.568471    balance_leaf
c01e676c 205      0.61335     do_journal_begin_r
c0131bf4 237      0.709093    generic_file_aio_write_nolock
c01de9b8 251      0.75098     is_leaf
c014c044 290      0.867666    __find_get_block
c01d03f0 442      1.32244     reiserfs_get_block
c01dec24 978      2.92613     search_by_key
c01dc8a0 1836     5.49322     leaf_paste_in_buffer
c01f88f8 2963     8.86515     __copy_from_user_ll
c0108a88 6235     18.6548     poll_idle
c011ad8c 11403    34.1172     __preempt_spin_lock

OK, that's similar to yours.  Disabling preemption:

c01dccd0 576      0.490213    reiserfs_restore_prepared_buffer
c01dbf94 605      0.514894    journal_mark_dirty
c01dbcec 615      0.523404    do_journal_begin_r
c0147a9c 628      0.534468    __block_prepare_write
c01d3f58 637      0.542128    is_leaf
c012f004 658      0.56        generic_file_aio_write_nolock
c01c8828 873      0.742979    reiserfs_commit_write
c01473c4 1376     1.17106     __find_get_block
c01c5b90 1651     1.40511     reiserfs_get_block
c01d41c4 3496     2.97532     search_by_key
c01d1e40 6264     5.33106     leaf_paste_in_buffer
c01edc18 10115    8.60851     __copy_from_user_ll
c0108a58 21450    18.2553     poll_idle
c01c8afc 38908    33.1132     .text.lock.inode

And the I/O rate is the same.  So all we've done here is to move the lock
contention from kernel/sched.c to fs/reiserfs/inode.c.  It'll be
lock_kernel().

So hm.  Confused.  Could you please:

- double check everything.

- try booting with mem=4G?  It could be that something broke and there is
  bounce buffering happening above 4G - the regular kernel profiler often
  will not show this.

- remove the cpu_relax() call from kernel/sched.c:__preempt_spin_lock()

Thanks.


BTW: here is ext2:

 0  4  2    704 136696  13980 3904276    0    0     0 104848 1680   310  1 99  0
 0  4  2    704  30336  14084 4009228    0    0     0 100836 1680   273  0 100  0
 0  4  3   1716   5532   9848 4038584    0 1012     8 99888 1682   342  1 97  3
 2  2  3   1716   5132   9956 4038788    0    0     0 97392 1685   307  0 100  0
 1  3  3   1716   4996  10052 4038832    0    0     0 97276 1689   310  1 99  0
 0  4  3   1716   8252  10160 4035436    0    0     4 100644 1691   321  0 98  2
 2  2  3   1716   5176  10256 4038020    0    0     8 102432 1683   333  2 98  1
 1  3  3   1716   7124  10348 4035804    0    0     0 112740 1691   354  0 100  0

c0134bcc 193      0.337094    __set_page_dirty_nobuffers
c0120bc0 194      0.338841    current_kernel_time
c019890c 249      0.434904    ext2_get_branch
c014c044 261      0.455863    __find_get_block
c0131bf4 265      0.46285     generic_file_aio_write_nolock
c01681bc 280      0.489049    mpage_writepage
c023ab18 300      0.523981    ide_outb
c01685f4 307      0.536207    mpage_writepages
c01305a4 314      0.548433    unlock_page
c0198cd8 372      0.649736    ext2_get_block
c01f88f8 8907     15.557      __copy_from_user_ll
c0108a88 39147    68.3743     poll_idle

So sweet.


