Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbTLNDoF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 22:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265337AbTLNDoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 22:44:05 -0500
Received: from dp.samba.org ([66.70.73.150]:33978 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265335AbTLNDn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 22:43:59 -0500
Date: Sun, 14 Dec 2003 14:40:59 +1100
From: Anton Blanchard <anton@samba.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: prepare_to_wait/waitqueue_active issues in 2.6
Message-ID: <20031214034059.GL17683@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hah this is the second time in a few weeks that we were hunting a 2.6 bug
right around the same area as you:

> Fix subtle bug in "finish_wait()", which can cause kernel stack
> corruption on SMP because of another CPU still accessing a waitqueue
> even after it was de-allocated.

> Use a careful version of the list emptiness check to make sure we
> don't de-allocate the stack frame before the waitqueue is all done.

We've been seeing unkillable tasks in a few places on ppc64:

[c000000000050378] io_schedule+0x54/0x94
[c00000000007e288] __lock_page+0xf0/0x174
[c00000000007ef64] do_generic_mapping_read+0x468/0x524
[c00000000007f37c] __generic_file_aio_read+0x1d4/0x218
[c00000000007f478] generic_file_read+0x60/0xa8
[c0000000000a7500] vfs_read+0x10c/0x174
[c0000000000a77fc] sys_read+0x50/0xa4

and

[c0000000000485f4] io_schedule+0x54/0x84
[c0000000000a0534] __wait_on_buffer+0x110/0x118
[c000000000105308] do_get_write_access+0xd8/0x83c
[c000000000105ab0] journal_get_write_access+0x44/0x74
[c0000000000f6928] ext3_reserve_inode_write+0xcc/0x130
[c0000000000f69b0] ext3_mark_inode_dirty+0x24/0x64
[c0000000000f6aa0] ext3_dirty_inode+0xb0/0xb8
[c0000000000cd3e0] __mark_inode_dirty+0x198/0x1a0
[c0000000000c4a10] update_atime+0xfc/0x104
[c00000000007263c] do_generic_mapping_read+0x414/0x73c
[c000000000072cdc] __generic_file_aio_read+0x1d4/0x208
[c000000000072d48] generic_file_aio_read+0x38/0x48
[c00000000009e77c] do_sync_read+0x7c/0xc4
[c00000000009e8d0] vfs_read+0x10c/0x164
[c0000000000aec08] kernel_read+0x38/0x5c
[c00000000002099c] do_execve32+0x1fc/0x35c
[c000000000020b6c] sys32_execve+0x70/0xdc

Taking the second example, we sleep in __wait_on_buffer:

void __wait_on_buffer(struct buffer_head * bh)
{
...
        do {
                prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
                if (buffer_locked(bh)) {
                        blk_run_queues();
                        io_schedule();
                }
        } while (buffer_locked(bh));
        finish_wait(wqh, &wait);
}

And

void wake_up_buffer(struct buffer_head *bh)
{
...
        smp_mb();
        if (waitqueue_active(wq))
                wake_up_all(wq);
}

We are doing a lockless check for waitqueue_active. Now look at
__wait_on_buffer, there is nothing to prevent the load in buffer_locked
from ending up inside prepare to write. That means we could do the check
for buffer_locked before we get put on the waitqueue.

End result is waitqueue_active returns 0 and buffer_locked returns 1.
We miss a wakeup. Game over. Ive attached a patch that forces the check
to happen after we are put on the waitqueue. Thanks to Brian Twichell
for the analysis and suggested fix for this.

__lock_page has the same problem, but it got us thinking if the other uses
of waitqueue_active are safe. 

A quick shows up a number of uses in 2.6. Looking at kswapd:

int kswapd(void *p)
{
...
	prepare_to_wait(&pgdat->kswapd_wait, &wait, TASK_INTERRUPTIBLE);
	schedule();
	finish_wait(&pgdat->kswapd_wait, &wait);
}

void wakeup_kswapd(struct zone *zone)
{
...
        if (!waitqueue_active(&zone->zone_pgdat->kswapd_wait))
                return;
        wake_up_interruptible(&zone->zone_pgdat->kswapd_wait);
}

This doesnt look safe either. The first example could be made safe
because we checked after we added ourselves to the waitqueue but before
we went to sleep. Here we go straight to sleep. There is a large window
in which we miss the wakeup because it could take a _long_ time for the
stores in prepare_to_wait to make it to the other cpu.

So at this stage I think the only valid uses of waitqueue active are
those which do one last check before sleeping (and only if the have 
a memory barrier before the check), the others are all buggy.

Thoughts?

Anton
