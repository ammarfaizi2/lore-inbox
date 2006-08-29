Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWH2DoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWH2DoK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 23:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWH2DoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 23:44:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48071 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751078AbWH2DoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 23:44:08 -0400
Date: Mon, 28 Aug 2006 20:43:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: v9fs-developer@lists.sourceforge.net, trond.myklebust@fys.uio.no,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000 of 2] Invalidate_inode_pages2 changes.
Message-Id: <20060828204354.00acafcb.akpm@osdl.org>
In-Reply-To: <17651.43668.16773.512828@cse.unsw.edu.au>
References: <20060829111641.18391.patches@notabene>
	<20060828191408.f6177de4.akpm@osdl.org>
	<17651.43668.16773.512828@cse.unsw.edu.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006 12:46:44 +1000
Neil Brown <neilb@suse.de> wrote:

> On Monday August 28, akpm@osdl.org wrote:
> > On Tue, 29 Aug 2006 11:30:15 +1000
> > NeilBrown <neilb@suse.de> wrote:
> > 
> > >  I'm picking up on a conversation that was started in late March
> > >  this year, and which didn't get anywhere much.
> > >  See
> > >    http://lkml.org/lkml/2006/3/31/93
> > >  and following.
> > 
> > Nick's "possible lock_page fix for Andrea's nopage vs invalidate race?"
> > patch (linux-mm) should fix this?
> > 
> > If filemap_nopage() does lock_page(), invalidate_inode_pages2_range() is solid?
> 
> UHmm.... yes.  In that case we can remove lots of stuff from
> invalidate_inode_pages2_range as we can be sure the page won't be
> dirty or in writeback so invalidate_complete_page will be certain to
> succeed. 

I'm not sure we can remove much from invalidate_inode_pages2_range(). 
After lock_page() returns the page can be under writeback, so the
wait_on_page_writeback() is appropriate.  After the page has been unmapped
from pagetables it could have been be redirtied.

Perhaps the while() loop is no longer necessary - nobody else will be
mapping this locked page into pagetables.

> So if that goes ahead, these become moot.  But until it does, these
> would be nice to have :-)

I guess we need to repair Nick's broken wing.

> Also, the patch at
>   http://marc.theaimsgroup.com/?l=linux-mm&m=115443228617576&w=2
> appears not to set 
>   +	.vm_flags	= VM_CAN_INVLD,
> for nfs_fs_vm_operations, but maybe they are a later addition to
> nfs...

I'm hoping all that stuff can go away.  Instead, change do_page_fault to
declare a new `struct page_fault_args' thing and pass that all the way up
and down the pagefault path.  Then, ->nopage implementations can simply set
page_fault_args.i_locked_the_page, to be examined at higher levels.

page_fault_args can also be used to tell do_no_page() to rerun the fault,
which would be needed if we want to stop holding down_read(mmap_sem) while
doing synchronous disk reads.

It'd be a fairly big-but-simple patch though.

> Thinks: should I subscribe to linux-mm... only about 100 messages per
> week.... maybe :-)

And no spam!
