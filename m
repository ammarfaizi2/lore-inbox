Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWGYJEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWGYJEo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 05:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWGYJEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 05:04:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23240 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751450AbWGYJEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 05:04:43 -0400
Date: Tue, 25 Jul 2006 02:04:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: "bibo, mao" <bibo.mao@intel.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: Question about ext3 jbd module
Message-Id: <20060725020431.c05cc73a.akpm@osdl.org>
In-Reply-To: <44C5D0EA.50507@intel.com>
References: <44C5D0EA.50507@intel.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006 08:06:02 +0000
"bibo, mao" <bibo.mao@intel.com> wrote:

> Hi, 
>    When I run LTP stress test on my IA64 box based on ditribution
> kernel version, kernel will crash within three days, I think this 
> problem should exist in recent kernel also, but I does not trigger
> this. The problem is in function journal_dirty_metadata(),
> there is one sentence like this: 
> 	struct journal_head *jh = bh2jh(bh);
> >From my debug result, jh is NULL at this point, I do not know whether
> it is because of contention or kernel forgets to consider NULL pointer
> condition.
> 
> I wrote one patch, after this patch LTP stress test does not crash, but
> I am not familiar filesystem, I do not know whether it is the root cause
> or what negative influence this patch will bring out.
> 
> Thanks
> bibo,mao
> 
> --- linux-2.6.9/fs/jbd/transaction.c.orig       2006-06-30 14:05:58.000000000 +0800
> +++ linux-2.6.9/fs/jbd/transaction.c    2006-07-07 02:56:32.000000000 +0800
> @@ -1104,13 +1104,15 @@ int journal_dirty_metadata(handle_t *han
>  {
>         transaction_t *transaction = handle->h_transaction;
>         journal_t *journal = transaction->t_journal;
> -       struct journal_head *jh = bh2jh(bh);
> +       struct journal_head *jh;
> 
> -       jbd_debug(5, "journal_head %p\n", jh);
> -       JBUFFER_TRACE(jh, "entry");
>         if (is_handle_aborted(handle))
>                 goto out;
> 
> +       jh = journal_add_journal_head(bh);
> +       jbd_debug(5, "journal_head %p\n", jh);
> +       JBUFFER_TRACE(jh, "entry");
> +
>         jbd_lock_bh_state(bh);
> 
>         /*
> @@ -1154,6 +1156,7 @@ int journal_dirty_metadata(handle_t *han
>         spin_unlock(&journal->j_list_lock);
>  out_unlock_bh:
>         jbd_unlock_bh_state(bh);
> +       journal_put_journal_head(jh);
>  out:
>         JBUFFER_TRACE(jh, "exit");
>         return 0;
> 

That's a worry.  We've attached a journal_head and we've done
do_get_write_access() and we're now proceeding to journal the buffer as
metadata but someone has presumably gone and run
__journal_try_to_free_buffer() against the thing and has stolen our
journal_head.

Simply reattaching a new journal_head is most likely wrong - we'll lose
whatever state was supposed to be in the old one (like, which journal list
this bh+jh is on).

Somewhere, somehow, that journal_head has passed through a state which
permitted __journal_try_to_free_buffer() to free it while appropriate locks
were not held.  I wonder where.

Your diff headers claim to be against 2.6.9.  Is that so?

Would it be correct to assume that there was some page replacement pressure
happening at the time?

It looks like a big box - can you describe it a bit please?

> Pid: 28417, CPU 13, comm:              inode02
> psr : 0000121008126010 ifs : 800000000000040d ip  : [<a000000200134721>]    Not tainted
> ip is at journal_dirty_metadata+0x2c1/0x5e0 [jbd]
> unat: 0000000000000000 pfs : 0000000000000917 rsc : 0000000000000003
> rnat: 0000000000000000 bsps: 0000000000000000 pr  : 005965a026595569
> ldrs: 0000000000000000 ccv : 0000000000060011 fpsr: 0009804c8a70033f
> csd : 0000000000000000 ssd : 0000000000000000
> b0  : a0000002001d3350 b6  : a000000100589f20 b7  : a0000001001fee60
> f6  : 1003e0000000000000000 f7  : 1003e0000000000000080
> f8  : 1003e00000000000008c1 f9  : 1003effffffffffffc0a0
> f10 : 100049c8d719c0533ddf0 f11 : 1003e00000000000008c1
> r1  : a000000200330000 r2  : a000000200158630 r3  : a000000200158630
> r8  : e0000001d885631c r9  : 0000000000000000 r10 : e0000001bede66e0
> r11 : 0000000000000010 r12 : e0000001a8a67d40 r13 : e0000001a8a60000
> r14 : 0000000000060011 r15 : 0000000000000000 r16 : e0000001fef76e80
> r17 : e0000001e3e34b38 r18 : 0000000000000020 r19 : 0000000000060011
> r20 : 00000000000e0011 r21 : 0000000000060011 r22 : 0000000000000000
> r23 : 0000000000000000 r24 : 0000000000000000 r25 : e0000001e6cc8090
> r26 : e0000001d88561e0 r27 : 0000000044bc2661 r28 : e0000001d8856078
> r29 : 000000007c6fe61a r30 : e0000001e6cc80e8 r31 : e0000001d8856080
> 
> Call Trace:
>  [<a000000100016b20>] show_stack+0x80/0xa0
>                                 sp=e0000001a8a67750 bsp=e0000001a8a61360
>  [<a000000100017430>] show_regs+0x890/0x8c0
>                                 sp=e0000001a8a67920 bsp=e0000001a8a61318
>  [<a00000010003dbf0>] die+0x150/0x240
>                                 sp=e0000001a8a67940 bsp=e0000001a8a612d8
>  [<a00000010003dd20>] die_if_kernel+0x40/0x60
>                                 sp=e0000001a8a67940 bsp=e0000001a8a612a8
>  [<a00000010003f930>] ia64_fault+0x1450/0x15a0
>                                 sp=e0000001a8a67940 bsp=e0000001a8a61250
>  [<a00000010000f540>] ia64_leave_kernel+0x0/0x260
>                                 sp=e0000001a8a67b70 bsp=e0000001a8a61250
>  [<a000000200134720>] journal_dirty_metadata+0x2c0/0x5e0 [jbd]
>                                 sp=e0000001a8a67d40 bsp=e0000001a8a611e0
>  [<a0000002001d3350>] ext3_mark_iloc_dirty+0x750/0xc00 [ext3]
>                                 sp=e0000001a8a67d40 bsp=e0000001a8a61150
>  [<a0000002001d3a90>] ext3_mark_inode_dirty+0xb0/0xe0 [ext3]
>                                 sp=e0000001a8a67d40 bsp=e0000001a8a61128
>  [<a0000002001ce3d0>] ext3_new_inode+0x1670/0x1a80 [ext3]
>                                 sp=e0000001a8a67d60 bsp=e0000001a8a61068
>  [<a0000002001df5e0>] ext3_mkdir+0x120/0x940 [ext3]
>                                 sp=e0000001a8a67da0 bsp=e0000001a8a61008
>  [<a000000100148250>] vfs_mkdir+0x250/0x380
>                                 sp=e0000001a8a67db0 bsp=e0000001a8a60fb0
>  [<a0000001001484f0>] sys_mkdir+0x170/0x280
>                                 sp=e0000001a8a67db0 bsp=e0000001a8a60f30
>  [<a00000010000f3e0>] ia64_ret_from_syscall+0x0/0x20
> 
