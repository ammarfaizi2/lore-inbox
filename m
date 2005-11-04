Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVKDQsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVKDQsl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVKDQsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:48:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42456 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750702AbVKDQsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:48:40 -0500
Date: Fri, 4 Nov 2005 08:48:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, aherrman@de.ibm.com
Subject: Re: [PATCH resubmit] do_mount: reduce stack consumption
Message-Id: <20051104084829.714c5dbb.akpm@osdl.org>
In-Reply-To: <20051104105026.GA12476@osiris.boeblingen.de.ibm.com>
References: <20051104105026.GA12476@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>
> From: Andreas Herrmann <aherrman@de.ibm.com>
> 
> This is a resubmit of Andreas' patch that reduces stackframe usage in
> do_mount. Problem is that without this patch we get a kernel stack
> overflow if we run with 4k stacks (s390 31 bit mode).
> See original stack back trace below and Andreas' patch and analysis
> here:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0410.3/1844.html
> 
>     <4>Call Trace:
>     <4>([<000000000014ade6>] buffered_rmqueue+0x36a/0x3b4)
>     <4> [<000000000014aed6>] __alloc_pages+0xa6/0x350
>     <4> [<000000000014b258>] __get_free_pages+0x38/0x74
>     <4> [<000000000014f9fe>] kmem_getpages+0x32/0x140
>     <4> [<0000000000150396>] cache_alloc_refill+0x3ae/0x58c
>     <4> [<000000000014feb0>] __kmalloc+0xc0/0xe8
>     <4> [<00000000002acc64>] zfcp_mempool_alloc+0x24/0x34
>     <4> [<00000000001494ea>] mempool_alloc+0x56/0x1e8
>     <4> [<00000000002bfb46>] zfcp_fsf_req_create+0x56/0x5d8
>     <4> [<00000000002c0cf0>] zfcp_fsf_send_fcp_command_task+0x44/0x5c4
>     <4> [<00000000002afbda>] zfcp_scsi_command_async+0x7a/0x1f8
>     <4> [<00000000002afe68>] zfcp_scsi_queuecommand+0x44/0x54
>     <4> [<000000000024f458>] scsi_dispatch_cmd+0x234/0x3c0
>     <4> [<0000000000255fb2>] scsi_request_fn+0x2c6/0x67c
>     <4> [<000000000023f3ea>] __generic_unplug_device+0x52/0x60
>     <4> [<000000000023d392>] __elv_add_request+0x8a/0x98
>     <4> [<0000000000240c5e>] __make_request+0x306/0x62c
>     <4> [<0000000000241074>] generic_make_request+0xf0/0x21c
>     <4> [<0000000010831380>] __map_bio+0x70/0x160 [dm_mod]
>     <4> [<000000001083173e>] __split_bio+0x1e6/0x538 [dm_mod]
>     <4> [<0000000010831ba8>] dm_request+0x118/0x25c [dm_mod]
>     <4> [<0000000000241074>] generic_make_request+0xf0/0x21c
>     <4> [<0000000010831380>] __map_bio+0x70/0x160 [dm_mod]
>     <4> [<000000001083173e>] __split_bio+0x1e6/0x538 [dm_mod]
>     <4> [<0000000010831ba8>] dm_request+0x118/0x25c [dm_mod]
>     <4> [<0000000000241074>] generic_make_request+0xf0/0x21c
>     <4> [<0000000010831380>] __map_bio+0x70/0x160 [dm_mod]
>     <4> [<000000001083173e>] __split_bio+0x1e6/0x538 [dm_mod]
>     <4> [<0000000010831ba8>] dm_request+0x118/0x25c [dm_mod]
>     <4> [<0000000000241074>] generic_make_request+0xf0/0x21c
>     <4> [<000000000024121a>] submit_bio+0x7a/0x154
>     <4> [<00000000001736e6>] submit_bh+0x106/0x184
>     <4> [<000000000017514e>] __block_write_full_page+0x23a/0x58c
>     <4> [<000000000017558e>] block_write_full_page+0xee/0x108
>     <4> [<000000000017a908>] blkdev_writepage+0x24/0x38
>     <4> [<00000000001a0f76>] mpage_writepages+0x1da/0x9d0
>     <4> [<000000000017a4fa>] generic_writepages+0x22/0x30
>     <4> [<000000000014cc1e>] do_writepages+0x36/0x54
>     <4> [<0000000000144fe2>] __filemap_fdatawrite+0x5a/0x6c
>     <4> [<0000000000145016>] filemap_fdatawrite+0x22/0x30
>     <4> [<0000000000171244>] sync_blockdev+0x30/0x5c
>     <4> [<00000000001df074>] journal_recover+0x88/0xbc
>     <4> [<00000000001e2876>] journal_load+0x52/0xcc
>     <4> [<00000000001d37b4>] ext3_fill_super+0x1a48/0x1d38
>     <4> [<0000000000179faa>] get_sb_bdev+0x13a/0x208
>     <4> [<00000000001d3bd6>] ext3_get_sb+0x22/0x34
>     <4> [<000000000017a32e>] do_kern_mount+0x86/0x1f4
>     <4> [<000000000019aaf4>] do_mount+0x1c8/0x8e4
>     <4> [<000000000019b7ba>] sys_mount+0xce/0x1dc
>     <4> [<000000000010f9a6>] sysc_do_restart+0xe/0x12

I'd call that a device mapper bug.  If you were to increase the stacking
from 4-deep to 5-deep, it will crash the kernel, patched or not.

I'm (very) surprised that DM doesn't perform its stacking iteratively.

Eliminating the 36-byte `struct clone_info' in __split_bio() would be most
effective here.


