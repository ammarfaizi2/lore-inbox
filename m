Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWJQS0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWJQS0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWJQS0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:26:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38099 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751234AbWJQS0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:26:11 -0400
Date: Tue, 17 Oct 2006 11:22:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc2-mm1
Message-Id: <20061017112221.515b12a3.akpm@osdl.org>
In-Reply-To: <4534E773.9060600@shadowen.org>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	<4534E773.9060600@shadowen.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006 15:23:47 +0100
Andy Whitcroft <apw@shadowen.org> wrote:

> Seeing this on a couple of x86_64's so far, probabally widespread:
> 
> BUG: warning at fs/inode.c:1389/i_size_write()
> 
> elm3b6:
> 
> Call Trace:
>  [<ffffffff8028207d>] i_size_write+0x51/0x73
>  [<ffffffff8028ddfb>] generic_commit_write+0x35/0x49
>  [<ffffffff802e78d1>] ext2_commit_chunk+0x32/0x6d
>  [<ffffffff802e86a0>] ext2_make_empty+0x160/0x179
>  [<ffffffff802eb734>] ext2_mkdir+0xb5/0x121
>  [<ffffffff80278926>] vfs_mkdir+0x6a/0xaa
>  [<ffffffff80278a12>] sys_mkdirat+0xac/0xfd
>  [<ffffffff80272607>] vfs_stat+0x14/0x16
>  [<ffffffff8021b703>] sys32_stat64+0x1a/0x34
>  [<ffffffff80278a76>] sys_mkdir+0x13/0x15
>  [<ffffffff8021b212>] ia32_sysret+0x0/0xa

hmm, bummer.  This use of generic_commit_write() with i_mutex not held is
OK.  Other uses of generic_commit_write() with i_mutex not held are not OK.

> 
> BUG: warning at fs/inode.c:1389/i_size_write()
> 
> bl6-13:
> 
> Call Trace:
>  [<ffffffff80298a44>] i_size_write+0x45/0x57
>  [<ffffffff802a116b>] simple_commit_write+0x3b/0x47
>  [<ffffffff8028d96b>] __page_symlink+0xb5/0x150
>  [<ffffffff8030b742>] ramfs_symlink+0x4d/0xb7
>  [<ffffffff8028e547>] vfs_symlink+0xd4/0x144
>  [<ffffffff80290d4e>] sys_symlinkat+0x86/0xd2
>  [<ffffffff808e3c33>] do_header+0x70/0x1d2
>  [<ffffffff808e2bd5>] do_symlink+0x4b/0x7b
>  [<ffffffff808e2a55>] write_buffer+0x1d/0x2b
>  [<ffffffff808e2acf>] flush_window+0x6c/0xca
>  [<ffffffff808e3097>] inflate_codes+0x38f/0x3ec
>  [<ffffffff808e428a>] inflate_dynamic+0x4f5/0x541
>  [<ffffffff808e479a>] unpack_to_rootfs+0x4c4/0x923
>  [<ffffffff808e4c83>] populate_rootfs+0x8a/0xde
>  [<ffffffff8020715a>] init+0x114/0x346
>  [<ffffffff8020a925>] child_rip+0xa/0x15
>  [<ffffffff803e0d6e>] acpi_ds_init_one_object+0x0/0x82
>  [<ffffffff803e0d6e>] acpi_ds_init_one_object+0x0/0x82
>  [<ffffffff80207046>] init+0x0/0x346
>  [<ffffffff8020a91b>] child_rip+0x0/0x15
> 

Ditto.

Is a shame, because this is a nasty bug.
