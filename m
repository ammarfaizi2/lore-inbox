Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTJFOPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 10:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTJFOPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 10:15:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10632 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262174AbTJFOPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 10:15:17 -0400
Date: Mon, 6 Oct 2003 16:15:16 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: PALFFY Daniel <dpalffy@rainstorm.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 deadlock, maybe ext2 related
Message-ID: <20031006141515.GA23546@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.58.0310031401310.753@rainstorm.org> <20031003132938.6f834b69.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031003132938.6f834b69.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

  I see the problem. Actually there are two ways of fixing:
1) dquot_drop() needn't call dqput() inside the lock.
2) dquot_alloc_space() can detect that it was actually called on quota
   file and exit before it tries to acquire the lock.

  I'll probably do the change 2) but I have to think a bit whether 1) is
also desirable...

						Thanks for spotting

								Honza

> PALFFY Daniel <dpalffy@rainstorm.org> wrote:
> >
> > This problem has been around since at least about test1, but this was the
> > first time i could capture a trace.
> 
> It looks like this process is the culprit:
> 
> > apache        D C278A120 77489808  9714    496                9233 (NOTLB)
> > c6befab8 00000086 c278a2a0 c278a120 c0292604 c278a120 c1e1e460 c882a040
> >        c041f460 c35d6abc c2207390 c6befac4 c7e400c0 c01f0cad c35d6ac0 c6bd1ec0
> >        c35d6ac0 c2207390 00000001 00000400 00000400 00000000 c7e400c0 c017069f
> > Call Trace:
> >  [<c0292604>] tcp_v4_rcv+0x654/0x880
> >  [<c01f0cad>] rwsem_down_read_failed+0x8d/0x130
> >  [<c017069f>] .text.lock.dquot+0xcd/0x2fe
> >  [<c02773d5>] ip_local_deliver_finish+0xc5/0x1c0
> >  [<c0277310>] ip_local_deliver_finish+0x0/0x1c0
> >  [<c0194abd>] ext2_new_block+0xad/0x5e0
> 
>   ext2_new_block
>   ->DQUOT_PREALLOC_SPACE_NODIRTY
>     ->dquot_alloc_space
>       ->down_read(dqptr_sem)
> 
> >  [<c019767f>] ext2_alloc_block+0x6f/0xb0
> >  [<c01979b4>] ext2_alloc_branch+0x34/0x230
> >  [<c0197d05>] ext2_get_block+0x155/0x390
> >  [<c026626b>] netif_receive_skb+0x17b/0x200
> >  [<c0149693>] __block_prepare_write+0x1e3/0x420
> >  [<c015e0dd>] inode_update_time+0xcd/0xe0
> >  [<c014a0b4>] block_prepare_write+0x34/0x50
> >  [<c0197bb0>] ext2_get_block+0x0/0x390
> >  [<c012ef4e>] generic_file_aio_write_nolock+0x36e/0xa90
> >  [<c0197bb0>] ext2_get_block+0x0/0x390
> >  [<c027c1c0>] ip_finish_output2+0x0/0x190
> >  [<c027c190>] dst_output+0x0/0x30
> >  [<c027a57c>] ip_queue_xmit+0x40c/0x520
> >  [<c027c190>] dst_output+0x0/0x30
> >  [<c012f6ee>] generic_file_write_nolock+0x7e/0xa0
> >  [<c0148c92>] __find_get_block+0x52/0xc0
> >  [<c0148d2b>] __getblk+0x2b/0x60
> >  [<c0148ddf>] __bread+0x1f/0x40
> >  [<c016f7d3>] dquot_free_space+0x63/0x110
> >  [<c01945f7>] ext2_free_blocks+0xe7/0x2f0
> >  [<c012f7fb>] generic_file_write+0x5b/0x80
> >  [<c0170ac6>] v1_commit_dqblk+0xa6/0x100
> >  [<c016e5de>] commit_dqblk+0x3e/0x60
> >  [<c016e955>] dqput+0x35/0xc0
> >  [<c0148a22>] mark_buffer_dirty+0x32/0x50
> >  [<c016f4ad>] dquot_drop_nolock+0x3d/0x50
> >  [<c016f4ef>] dquot_drop+0x2f/0x60
> 
>    down_write(dqptr_sem);
> 
> >  [<c019687f>] ext2_free_inode+0x14f/0x170
> >  [<c0197530>] ext2_delete_inode+0x0/0x90
> >  [<c0197530>] ext2_delete_inode+0x0/0x90
> >  [<c015dc45>] generic_delete_inode+0x85/0x120
> >  [<c015de75>] iput+0x55/0x80
> >  [<c015b5d4>] dput+0xd4/0x170
> >  [<c01473c9>] __fput+0x99/0xf0
> >  [<c0145bc9>] filp_close+0x59/0x90
> >  [<c0145c50>] sys_close+0x50/0x60
> >  [<c010906f>] syscall_call+0x7/0xb
> > 
> > 
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
