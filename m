Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbULUKlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbULUKlG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 05:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbULUKlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 05:41:06 -0500
Received: from mx2.elte.hu ([157.181.151.9]:50389 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261731AbULUKlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 05:41:03 -0500
Date: Tue, 21 Dec 2004 11:40:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] XFS crash using Realtime Preemption patch
Message-ID: <20041221104042.GA31843@elte.hu>
References: <Pine.LNX.4.60-041.0412182025220.5487@unix49.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60-041.0412182025220.5487@unix49.andrew.cmu.edu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nathaniel W. Filardo <nwf@andrew.cmu.edu> wrote:

> Hello all.
> 
> Using 2.6.10-rc3-mm1-V0.7.33-04 and TCFQ ver 17, I get the following
> crash while trying to sync the portage tree, though the system seems
> stable under interactive load (read: an rm command went OK prior to
> this crash).
> 
> Machine is a 933MHz transmeta laptop with IDE disk.
> 
> Any more information you need?
> --nwf;
> 
> kernel BUG at kernel/rt.c:1210!

Seems like an XFS bug at first sight. The BUG() means that an up_write()
was done while a down_read() was active for the lock. Does XFS really do
this? Initialization/destruction bugs can possibly cause such messages
too.

Here's the call sequence:

> EIP is at up_write+0x8c/0xa0
>  [<c01d2d5c>] xfs_iunlock+0x7c/0xa0 (32)
>  [<c01d728c>] xfs_iflush+0x1cc/0x440 (12)
>  [<c01d85a0>] xfs_inode_item_push+0x10/0x20 (60)
>  [<c01ebd0a>] xfs_trans_push_ail+0x1aa/0x1e0 (8)
>  [<c01ddadd>] xlog_grant_push_ail+0x14d/0x180 (68)
>  [<c01dc9fc>] xfs_log_reserve+0x9c/0xc0 (60)
>  [<c01f7569>] kmem_zone_alloc+0x39/0xa0 (8)
>  [<c01ea89a>] xfs_trans_reserve+0x8a/0x1e0 (20)
>  [<c01d56f6>] xfs_itruncate_finish+0x1a6/0x390 (40)
>  [<c01ecd6b>] xfs_trans_ijoin+0x2b/0x80 (96)
>  [<c01f266a>] xfs_inactive+0x3ea/0x4c0 (20)
>  [<c0144f30>] truncate_inode_pages_range+0x100/0x350 (20)
>  [<c02023e0>] vn_rele+0x50/0xe0 (24)
>  [<c0202467>] vn_rele+0xd7/0xe0 (24)
>  [<c017154a>] dput+0x8a/0x2a0 (4)
>  [<c0200bbf>] linvfs_clear_inode+0xf/0x20 (20)
>  [<c01738d8>] clear_inode+0x158/0x160 (8)
>  [<c0145197>] truncate_inode_pages+0x17/0x20 (12)
>  [<c017483f>] generic_delete_inode+0xef/0x110 (12)
>  [<c013100a>] atomic_dec_and_spin_lock+0x1a/0x70 (8)
>  [<c01749f7>] iput+0x57/0x90 (16)
>  [<c016a5a1>] sys_unlink+0xc1/0x120 (24)
>  [<c0102fb3>] syscall_call+0x7/0xb (84)
