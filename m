Return-Path: <linux-kernel-owner+w=401wt.eu-S932975AbWLSW0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932975AbWLSW0f (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 17:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932977AbWLSW0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 17:26:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41043 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932975AbWLSW0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 17:26:34 -0500
Date: Tue, 19 Dec 2006 14:26:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Michal Sabala <lkml@saahbs.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 mmap hangs unrelated apps
Message-Id: <20061219142624.230b28c0.akpm@osdl.org>
In-Reply-To: <1166219054.5761.56.camel@lade.trondhjem.org>
References: <20061215023014.GC2721@prosiaczek>
	<1166199855.5761.34.camel@lade.trondhjem.org>
	<20061215175030.GG6220@prosiaczek>
	<1166211884.5761.49.camel@lade.trondhjem.org>
	<20061215210642.GI6220@prosiaczek>
	<1166219054.5761.56.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006 16:44:14 -0500
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> However it is true that the
> trace you sent indicated that XFree86 was hanging in iput().

We know what the bug is, don't we?

> > XFree86       D 00000003     0  2471   2453                     (NOTLB)
> >        c4871c0c 00003082 c86b72bc 00000003 cb7c94a4 0000001d 3b67f3ff c0146dd2 
> >        c1184180 cb3e7110 00000000 001ec7ff a60f8097 00000089 c02e1e60 cb3e7000 
> >        c1184180 00000000 c1180030 c4871c18 c028c7d8 c4871c5c c01435b6 c01435f3 
> > Call Trace:
> >  [<c0146dd2>] free_pages_bulk+0x1d/0x1d4
> >  [<c028c7d8>] io_schedule+0x26/0x30
> >  [<c01435b6>] sync_page+0x0/0x40
> >  [<c01435f3>] sync_page+0x3d/0x40
> >  [<c028c9ce>] __wait_on_bit_lock+0x2c/0x52
> >  [<c0143c13>] __lock_page+0x6a/0x72
> >  [<c012ec77>] wake_bit_function+0x0/0x3c
> >  [<c012ec77>] wake_bit_function+0x0/0x3c
> >  [<c0149d2f>] pagevec_lookup+0x17/0x1d
> >  [<c014a085>] truncate_inode_pages_range+0x20a/0x260
> >  [<c014a0e4>] truncate_inode_pages+0x9/0xc
> >  [<c0172c8a>] generic_delete_inode+0xb6/0x10f
> >  [<c0172e73>] iput+0x5f/0x61
> >  [<c01706bd>] dentry_iput+0x68/0x83
> >  [<c01707d8>] dput+0x100/0x118
> >  [<ccb6c334>] put_nfs_open_context+0x67/0x88 [nfs]
> >  [<ccb701ed>] nfs_release_request+0x38/0x47 [nfs]
> >  [<ccb736dd>] nfs_wait_on_requests_locked+0x62/0x98 [nfs]
> >  [<ccb74c32>] nfs_sync_inode_wait+0x4a/0x130 [nfs]
> >  [<ccb6b639>] nfs_release_page+0x0/0x30 [nfs]
> >  [<ccb6b655>] nfs_release_page+0x1c/0x30 [nfs]
> >  [<c015f37c>] try_to_release_page+0x34/0x46
> >  [<c014aa8b>] shrink_page_list+0x263/0x350
> >  [<c0104db8>] do_IRQ+0x48/0x50
> >  [<c01036c6>] common_interrupt+0x1a/0x20
> >  [<c014acd7>] shrink_inactive_list+0x9b/0x248
> >  [<c014b2fd>] shrink_zone+0xb5/0xd0
> >  [<c014b382>] shrink_zones+0x6a/0x7e
> >  [<c014b48e>] try_to_free_pages+0xf8/0x1da
> >  [<c0147a18>] __alloc_pages+0x17c/0x278
> >  [<c014f555>] do_anonymous_page+0x45/0x150
> >  [<c014f9f7>] __handle_mm_fault+0xda/0x1bf
> >  [<c0115849>] do_page_fault+0x1c4/0x4bc
> >  [<c01021b7>] restore_sigcontext+0x10c/0x15f
> >  [<c0115685>] do_page_fault+0x0/0x4bc
> >  [<c0103809>] error_code+0x39/0x40
> 
> nfs_release_page() was called with a locked page.  It's doing a bunch of
> stuff which results in a call to truncate_inode_pages(), which will run
> lock_page(), which is deadlocky.

Now, arguably the VM shouldn't be calling try_to_release_page() with
__GFP_FS when it's holding a lock on a page.

But otoh, NFS should never be running lock_page() within nfs_release_page()
against the page which was passed into nfs_release_page().  It'll deadlock
for sure.

So we could alter the VM to not pass in __GFP_FS in this situation, but
nfs_release_page() would still be deadlocky.

