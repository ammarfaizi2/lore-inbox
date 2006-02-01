Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422870AbWBASws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422870AbWBASws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422874AbWBASws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:52:48 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49055 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1422871AbWBASws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:52:48 -0500
Date: Wed, 1 Feb 2006 19:52:47 +0100
From: Jan Kara <jack@suse.cz>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Another Assertion failure in journal_start()
Message-ID: <20060201185247.GK6547@atrey.karlin.mff.cuni.cz>
References: <43DF445F.6060704@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DF445F.6060704@tls.msk.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> Just hit our main server, while doing kernel compile
> (producing a .deb using custom script which does quite
> some usage of symlinks - hence sys_symlink() operation
> is in call trace) -- that particular filesystem stopped
> working, while the rest of the system was still operational.
> 
> It's 2.6.15.1 kernel running on an athlon-1.3GHz, pretty
> old but pretty stable box, with ECC memory.  The filesystem
> in question is on top of a raid0 array out of 4 scsi drives
> (it's used as a "staging area" for various temporary stuff,
> incl. compiles and whatnot).
> 
> Any clues about this one?
> 
> Note it's the first time I encountered an error like this
> one, but I did quite alot of kernel compiles on this box
> already since last boot (I'm experimenting with Xen on
> another box, this box is used as a "compiling server").
> So I can hardly say the problem is "easily reproduceable".
  The trace you provided is good enough so that I don't need to
reproduce the problem :). The bug is in ext3 - the problem is that we
start a transaction and then do something that needs to allocate memory
but we don't set GFP_NOFS. As we are low on memory we try to shrink
caches and remove some inode on different filesystem from memory. We
recurse back into the fs code which finds out we have already started
transaction on different fs and BUGs.
  The right solution probably is to pass gfp flags to page_symlink().
I'll write a patch.

								Honza

> BTW... What's this strange "kernel BUG at <bad filename>:17407!" ?
> I've seen similar stuff already on another machine, and it does
> not look right...  Also, the "[ cut here ]" line seems to be
> misplaced.
  Strange. I don't know...

> Assertion failure in journal_start() at fs/jbd/transaction.c:270: "handle->h_transaction->t_journal == journal"
> ------------[ cut here ]------------
> kernel BUG at <bad filename>:17407!
> invalid operand: 0000 [#1]
> Modules linked in: sr_mod cdrom ide_generic nfsd exportfs lockd nfs_acl sunrpc autofs4 quota_v2 raid0 via82cxxx ide_core raid5 xor 8139too mii crc32 rtc ext3 jbd mbcache raid1 md_mod sd_mod aic7xxx scsi_transport_spi scsi_mod
> CPU:    0
> EIP:    0060:[<f0868483>]    Not tainted VLI
> EFLAGS: 00010296   (2.6.15-i686)
> EIP is at journal_start+0x63/0xc0 [jbd]
> eax: 00000076   ebx: cac77748   ecx: c02933ac   edx: c02933ac
> esi: f0870587   edi: 0000010e   ebp: 0000001f   esp: c6f68d78
> ds: 007b   es: 007b   ss: 0068
> Process perl (pid: 9232, threadinfo=c6f68000 task=ea83d050)
> Stack: f086eee0 f086ea02 f0870587 0000010e f086efa0 e3940a68 e7e1b920 c6f68dd4
>        f08e3cea e3940a68 e7e1b920 c0167a91 c6f68dd4 e3940a70 e3940a68 c0167b0b
>        c2ced198 c2ced190 00000080 00000080 c0167d98 00000002 00000080 c6914310
> Call Trace:
>  [<f08e3cea>] ext3_dquot_drop+0x2a/0x60 [ext3]
>  [<c0167a91>] clear_inode+0xe1/0x120
>  [<c0167b0b>] dispose_list+0x3b/0xb0
>  [<c0167d98>] prune_icache+0x98/0x170
>  [<c0167e84>] shrink_icache_memory+0x14/0x40
>  [<c013f84f>] shrink_slab+0x16f/0x1d0
>  [<c014074a>] try_to_free_pages+0xda/0x1a0
>  [<c0139d37>] __alloc_pages+0x137/0x2c0
>  [<c0135c44>] find_or_create_page+0x84/0xa0
>  [<c01608de>] page_symlink+0x2e/0x124
>  [<f08e082f>] ext3_symlink+0x19f/0x1e0 [ext3]
>  [<c015f969>] vfs_symlink+0x89/0x110
>  [<c015fa64>] sys_symlink+0x74/0xc0
>  [<c0150fb2>] vfs_read+0xf2/0x150
>  [<c01512b7>] sys_read+0x47/0x80
>  [<c0102e99>] syscall_call+0x7/0xb
> Code: 86 f0 b9 02 ea 86 f0 b8 a0 ef 86 f0 89 4c 24 04 bf 0e 01 00 00 be 87 05 87 f0 89 7c 24 0c 89 74 24 08 89 44 24 10 e8 6d 0e 8b cf <0f> 0b ff 43 08 89 d8 8b 5c 24 14 8b 74 24 18 8b 7c 24 1c 83 c4
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
