Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266147AbUGTTyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbUGTTyC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUGTTxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:53:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:10922 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266208AbUGTTwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 15:52:19 -0400
Subject: Re: Processes stuck in unkillable D state (now seen in 2.6.7-mm6)
From: Chris Mason <mason@suse.com>
To: Rob Mueller <robm@fastmail.fm>, wli@holomorphy.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <009e01c46849$f2e85430$9aafc742@ROBMHP>
References: <00f601c46539$0bdf47a0$e6afc742@ROBMHP>
	 <1089377936.3956.148.camel@watt.suse.com>
	 <009e01c46849$f2e85430$9aafc742@ROBMHP>
Content-Type: text/plain
Message-Id: <1090353111.23350.8.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Jul 2004 15:51:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-12 at 15:53, Rob Mueller wrote:

> Here's the relevant stuck proc.
> 
> imapd         D E17BE6E0     0  3761      1               10291 (NOTLB)
> e11c3bc8 00000086 00000020 e17be6e0 c1372d20 00000246 00000220 f7e12380
>        00000020 c0136667 c42c6da0 00000001 00000d74 bbfe8a6a 0000040d 
> c42c6da0
>        f7f91140 e17be6e0 e17be890 f78cd9cc 00000003 f78cd9cc f78cd9cc 
> c025d2cc
> Call Trace:
>  [<c0136667>] kmem_cache_alloc+0x57/0x70
>  [<c025d2cc>] generic_unplug_device+0x2c/0x40
>  [<c037a148>] io_schedule+0x28/0x40
>  [<c012e03c>] __lock_page+0xbc/0xe0
>  [<c012dd70>] page_wake_function+0x0/0x50
>  [<c012dd70>] page_wake_function+0x0/0x50
>  [<c012f061>] filemap_nopage+0x231/0x360
>  [<c013dc18>] do_no_page+0xb8/0x3a0
>  [<c013ba7b>] pte_alloc_map+0xdb/0xf0
>  [<c013e0ae>] handle_mm_fault+0xbe/0x1a0
>  [<c025d292>] __generic_unplug_device+0x32/0x40
>  [<c0112af2>] do_page_fault+0x172/0x5ec
>  [<c014cab0>] bh_wake_function+0x0/0x40
>  [<c014cab0>] bh_wake_function+0x0/0x40
>  [<c018ec9f>] reiserfs_prepare_file_region_for_write+0x94f/0x9b0
>  [<c0112980>] do_page_fault+0x0/0x5ec
>  [<c0104b19>] error_code+0x2d/0x38
>  [<c018dc0f>] reiserfs_copy_from_user_to_file_region+0x8f/0x100
>  [<c018f2b1>] reiserfs_file_write+0x5b1/0x750
>  [<c0186675>] reiserfs_link+0xb5/0x190
>  [<c0186719>] reiserfs_link+0x159/0x190
>  [<c016134c>] dput+0x1c/0x1b0
>  [<c016134c>] dput+0x1c/0x1b0
>  [<c01581a0>] path_release+0x10/0x40
>  [<c015a9bc>] sys_link+0xcc/0xe0
>  [<c014bb9a>] vfs_write+0xaa/0xe0
>  [<c014b610>] default_llseek+0x0/0x110
>  [<c014bc4f>] sys_write+0x2f/0x50
>  [<c010406b>] syscall_call+0x7/0xb
> 
> Is that in lock_page again?
> 
> Hopefully there's some helpful information there. If the dump there isn't 
> complete, can you give me an idea why it might not be? I've set the kernel 
> buffer to 17 (128k), and the proc list was definitely small enough to fit in 
> the buffer. When I did "dmesg -s 1000000 > foo", the first part of the file 
> was still the original boot sequence. Any other suggestions on what to do?

Ugh, so the call path here is:

reiserfs_file_write -> start a transaction
copy_from_user -> fault in the page
page fault handler -> lock page

This means we're trying to lock a page with a running transaction, and
that's not allowed, since some other process on the box most likely has
that page locked and is trying to start a transaction.

That makes for 3 different deadlocks in this exact same call path
(dirty_inode, lock_page and kmap), and my patch for it has major
problems.  So, I'll talk things over with everyone during OLS and try to
work out a proper fix.

Sorry Rob, this one is non-trivial.

-chris


