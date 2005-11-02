Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965292AbVKBWDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965292AbVKBWDI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbVKBWDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:03:08 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:25499 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965292AbVKBWDG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:03:06 -0500
Subject: Re: New bug in patch and existing Linux code - race with
	install_page() (was: Re: [PATCH] 2.6.14 patch for supporting
	madvise(MADV_REMOVE))
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, Andrea Arcangeli <andrea@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org, dvhltc@us.ibm.com,
       linux-mm <linux-mm@kvack.org>, Jeff Dike <jdike@addtoit.com>
In-Reply-To: <Pine.LNX.4.61.0511022145450.18444@goblin.wat.veritas.com>
References: <1130366995.23729.38.camel@localhost.localdomain>
	 <20051102014321.GG24051@opteron.random>
	 <1130947957.24503.70.camel@localhost.localdomain>
	 <200511022054.15119.blaisorblade@yahoo.it>
	 <1130967383.24503.112.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0511022145450.18444@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 14:02:33 -0800
Message-Id: <1130968953.24503.122.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 21:55 +0000, Hugh Dickins wrote:
> On Wed, 2 Nov 2005, Badari Pulavarty wrote:
> > On Wed, 2005-11-02 at 20:54 +0100, Blaisorblade wrote:
> > > > +       /* XXX - Do we need both i_sem and i_allocsem all the way ? */
> > > > +       down(&inode->i_sem);
> > > > +       down_write(&inode->i_alloc_sem);
> > > > +       unmap_mapping_range(mapping, offset, (end - offset), 1);
> > > In my opinion, as already said, unmap_mapping_range can be called without 
> > > these two locks, as it operates only on mappings for the file.
> > > 
> > > However currently it's called with these locks held in vmtruncate, but I think 
> > > the locks are held in that case only because we need to truncate the file, 
> > > and are hold in excess also across this call.
> > 
> > I agree, I can push down the locking only for ->truncate_range - if
> > no one has objections. (But again, it so special case - no one really
> > cares about the performance of this interface ?).
> 
> I can't remember why i_alloc_sem got introduced, and don't have time to
> work it out: something to do with direct I/O races, perhaps?  Someone
> else must advise, perhaps you will be able to drop that one.

Yep. i_alloc_sem is supposed to protect DIO races with truncate.

> But I think you'd be very unwise to drop i_sem too.  i_mmap_lock gets
> dropped whenever preemption demands here, i_sem is what's preventing
> someone else coming along and doing a concurrent truncate or remove.
> You don't want that.
> 
> Sorry, I've not yet had time to study your patch: I do intend to,
> but cannot promise when.  I fear it won't be as easy as making
> these occasional responses.

Thanks Hugh. For now, I will leave those locks alone. We can re-visit
later, if we really care about the performance of this interface.
Better be safe than sorry.

Thanks,
Badari

