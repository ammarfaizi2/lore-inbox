Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbUDATdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 14:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbUDATda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 14:33:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:21962 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263092AbUDATaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 14:30:55 -0500
Date: Thu, 1 Apr 2004 11:30:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm2
Message-Id: <20040401113043.17fe8279.akpm@osdl.org>
In-Reply-To: <16492.7681.332798.230663@alkaid.it.uu.se>
References: <20040323232511.1346842a.akpm@osdl.org>
	<16492.7681.332798.230663@alkaid.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> On 23 Mar 2004, Andrew Morton wrote:
>  > Changes since 2.6.5-rc2-mm1:
> ...
>  > -nmi_watchdog-local-apic-fix.patch
>  > -nmi-1-hz-2.patch
>  > 
>  >  I think these were causing kgdb to malfunction.
> 
> Any concrete evidence about this? I fail to see how
> the updated nmi-1-hz patch I wrote could affect kgdb
> in a way that wouldn't also happen on UP w/o the patch.
> 
> IOW, I'm more suspicious about the other patch to
> signal LAPIC NMIs on both threads on HT P4.

Which patch is that?



I'm not so sure about this problem.  What I was seeing was that gdb would
get confused about the stack backtraces.  For example:

Bad:

(gdb) thread 32
[Switching to thread 32 (Thread 1399)]#0  0xc036f071 in schedule () at kernel/sched.c:1059
1059            return prev;
(gdb) bt
#0  0xc036f071 in schedule () at kernel/sched.c:1059
#1  0xc036f569 in schedule_timeout (timeout=-837222592) at kernel/timer.c:1042
#2  0xd0afe041 in ?? ()
#3  0xce18ffd0 in ?? ()
#4  0xce18ffd8 in ?? ()
#5  0xce18e000 in ?? ()
#6  0xcd5eb160 in ?? ()
#7  0xcd5eb08c in ?? ()
#8  0xcd5eb040 in ?? ()


Good:

(gdb) thread 80
[Switching to thread 80 (Thread 1777)]#0  get_request_wait (q=0xcfc8e800, rw=1)
    at drivers/block/ll_rw_blk.c:1644
1644                            ioc = get_io_context(GFP_NOIO);
(gdb) bt
#0  get_request_wait (q=0xcfc8e800, rw=1) at drivers/block/ll_rw_blk.c:1644
#1  0xc025e4a4 in __make_request (q=0xcfc8e800, bio=0xc4e50580) at drivers/block/ll_rw_blk.c:2246
#2  0xc025e820 in generic_make_request (bio=0xc4e50580) at drivers/block/ll_rw_blk.c:2418
#3  0xc025e8b6 in submit_bio (rw=0, bio=0xc4e50580) at drivers/block/ll_rw_blk.c:2445
#4  0xc01799cf in mpage_bio_submit (rw=0, bio=0x0) at fs/mpage.c:95
#5  0xc017a68a in mpage_writepage (bio=0xc4e50580, page=0xc111b7f0, 
    get_block=0xc01c9298 <ext2_get_block>, last_block_in_bio=0xc87d7b80, ret=0x0, wbc=0x0)
    at fs/mpage.c:552
#6  0xc017a947 in mpage_writepages (mapping=0xc7382c0c, wbc=0xc87d7c74, 
    get_block=0xc01c9298 <ext2_get_block>) at fs/mpage.c:685
#7  0xc01c9701 in ext2_writepages (mapping=0x0, wbc=0x0) at fs/ext2/inode.c:671
#8  0xc0143407 in do_writepages (mapping=0x0, wbc=0x0) at mm/page-writeback.c:445
#9  0xc0178fa5 in __sync_single_inode (inode=0xc7382b70, wbc=0xc87d7c74) at fs/fs-writeback.c:167
#10 0xc0179153 in __writeback_single_inode (inode=0xc7382b70, wbc=0xc87d7c74) at fs/fs-writeback.c:222
#11 0xc0179340 in sync_sb_inodes (sb=0xce6f1000, wbc=0xc87d7c74) at fs/fs-writeback.c:315
#12 0xc017943a in writeback_inodes (wbc=0xc87d7c74) at fs/fs-writeback.c:361
#13 0xc0142ef2 in balance_dirty_pages (mapping=0x0) at mm/page-writeback.c:182
#14 0xc0143047 in balance_dirty_pages_ratelimited (mapping=0x0) at mm/page-writeback.c:231
#15 0xc0140427 in generic_file_aio_write_nolock (iocb=0xc87d7ea8, iov=0xc87d7f6c, nr_segs=1, 
    ppos=0xce9c1da0) at mm/filemap.c:1888
#16 0xc0140607 in generic_file_write_nolock (file=0x0, iov=0xc87d7f6c, nr_segs=3363667624, ppos=0x0)
    at mm/filemap.c:1923
#17 0xc0140709 in generic_file_write (file=0xce9c1d80, buf=0x0, count=0, ppos=0xce9c1da0)
    at mm/filemap.c:1959
#18 0xc015ab17 in vfs_write (file=0xce9c1d80, buf=0x804b3a0 '\001' <repeats 200 times>..., count=65475, 
    pos=0xce9c1da0) at fs/read_write.c:258
#19 0xc015abd0 in sys_write (fd=0, buf=0x0, count=0) at fs/read_write.c:295
#20 0xc0108d21 in sysenter_past_esp () at arch/i386/kernel/semaphore.c:177



Also the whole machine would wedge when doing a `cont' when the system was
under load.

I'll bring the patches back, let them bake for a while.

Could you take a look at the kgdb stub's MNI usage, see if you can spot any
nasty interactions?

