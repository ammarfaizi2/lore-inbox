Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270988AbTHQUwO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270993AbTHQUwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:52:14 -0400
Received: from maild.telia.com ([194.22.190.101]:56262 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id S270988AbTHQUwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:52:08 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Martin Sarsale <lists@runa.sytes.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: segfault when unloading module loop in 2.6.0-test3+ck patches
References: <20030817042751.379428cf.lists@runa.sytes.net>
From: Peter Osterlund <petero2@telia.com>
Date: 17 Aug 2003 22:51:41 +0200
In-Reply-To: <20030817042751.379428cf.lists@runa.sytes.net>
Message-ID: <m28yps57oi.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm resending this because I previously had sendmail configuration
problems. Sorry if you receive this message twice.)

Martin Sarsale <lists@runa.sytes.net> writes:

> Dear all: I was playing with the crypto support, and when I tried to
> unload the module "loop" I got a segfault and after that lsmod hung
> 
> dmesg says (I'll include the hda lines in case they've something to do):
>
> Unable to handle kernel paging request at virtual address 010000bf
>  printing eip:
> c01d5564
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c01d5564>]    Not tainted
> EFLAGS: 00210202
> EIP is at kobject_del+0x34/0x80
> eax: 0100007f   ebx: d5c9f850   ecx: d5c9f850   edx: 0100007f
> esi: d4f43960   edi: d4f43a24   ebp: 00000880   esp: cf401eec
> ds: 007b   es: 007b   ss: 0068
> Process rmmod (pid: 27599, threadinfo=cf400000 task=caac72b0)
> Stack: dbfe7ab8 00200282 d654d200 d5c9f850 c01d55c3 d5c9f850 d5c9f800 c023bb8a 
>        d5c9f850 d5c9f800 c023f5de d5c9f800 d4f43960 c037b018 c0240523 d4f43960 
>        d4f43960 d4f43960 c017fc0d d4f43960 00000000 00000000 c037b018 00000000 
> Call Trace:
>  [<c01d55c3>] kobject_unregister+0x13/0x30
>  [<c023bb8a>] elv_unregister_queue+0x1a/0x40
>  [<c023f5de>] blk_unregister_queue+0x1e/0x60
>  [<c0240523>] unlink_gendisk+0x13/0x40
>  [<c017fc0d>] del_gendisk+0x6d/0xe0
>  [<dcb7a133>] cleanup_module+0x63/0x7e [loop]
>  [<c012f6f9>] sys_delete_module+0x119/0x1a0
>  [<c01427dc>] do_munmap+0x14c/0x190
>  [<c010929b>] syscall_call+0x7/0xb

I have the same problem in 2.6.0-test3-bk5 when I unload the loop
module, even when not using any crypto stuff. The patch below fixes
it:

 linux-petero/drivers/block/loop.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/block/loop.c~loop-oops-fix drivers/block/loop.c
--- linux/drivers/block/loop.c~loop-oops-fix	2003-08-17 19:19:22.000000000 +0200
+++ linux-petero/drivers/block/loop.c	2003-08-17 20:33:03.000000000 +0200
@@ -1198,6 +1198,7 @@ int __init loop_init(void)
 		lo->lo_queue = blk_alloc_queue(GFP_KERNEL);
 		if (!lo->lo_queue)
 			goto out_mem4;
+		init_timer(&lo->lo_queue->unplug_timer);
 		disks[i]->queue = lo->lo_queue;
 		init_MUTEX(&lo->lo_ctl_mutex);
 		init_MUTEX_LOCKED(&lo->lo_sem);
@@ -1237,8 +1238,8 @@ void loop_exit(void)
 	int i;
 
 	for (i = 0; i < max_loop; i++) {
-		blk_put_queue(loop_dev[i].lo_queue);
 		del_gendisk(disks[i]);
+		blk_put_queue(loop_dev[i].lo_queue);
 		put_disk(disks[i]);
 	}
 	devfs_remove("loop");

_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
