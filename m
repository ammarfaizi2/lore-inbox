Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289655AbSBSEcO>; Mon, 18 Feb 2002 23:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289671AbSBSEcE>; Mon, 18 Feb 2002 23:32:04 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42576 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S289655AbSBSEb6>; Mon, 18 Feb 2002 23:31:58 -0500
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@transmeta.com>,
        dmccr@us.ibm.com, Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Robert Love <rml@tech9.net>,
        Rik van Riel <riel@conectiva.com.br>, mingo@redhat.com,
        Andrew Morton <akpm@zip.com.au>, manfred@colorfullife.com,
        wli@holomorphy.com
Subject: Re: [RFC] Page table sharing
In-Reply-To: <Pine.LNX.4.21.0202182358190.1021-100000@localhost.localdomain>
	<E16cy8E-0000xp-00@starship.berlin>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Feb 2002 21:27:11 -0700
In-Reply-To: <E16cy8E-0000xp-00@starship.berlin>
Message-ID: <m1heoe3xls.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net> writes:

> On February 19, 2002 01:03 am, Hugh Dickins wrote:
> > On Tue, 19 Feb 2002, Daniel Phillips wrote:
> > > On February 18, 2002 08:04 pm, Hugh Dickins wrote:
> > > > On Mon, 18 Feb 2002, Daniel Phillips wrote:
> > > > > On February 18, 2002 09:09 am, Hugh Dickins wrote:
> > > > > > Since copy_page_range would not copy shared page tables, I'm wrong to
> > > > > > point there.  But __pte_alloc does copy shared page tables (to unshare
> 
> > > > > > them), and needs them to be stable while it does so: so locking
> against
> 
> > > > > > swap_out really is required.  It also needs locking against read
> faults,
> 
> > > > > > and they against each other: but there I imagine it's just a matter of
> 
> > > > > > dropping the write arg to __pte_alloc, going back to pte_alloc again.
> > > 
> > > I'm not sure what you mean here, you're not suggesting we should unshare the
> 
> > > page table on read fault are you?
> > 
> > I am.  But I can understand that you'd prefer not to do it that way.
> > Hugh
> 
> No, that's not nearly studly enough ;-)
> 
> Since we have gone to all the trouble of sharing the page table, we should
> swap in/out for all sharers at the same time.  That is, keep it shared, saving
> memory and cpu.
> 
> Now I finally see what you were driving at: before, we could count on the
> mm->page_table_lock for exclusion on read fault, now we can't, at least not
> when ptb->count is great than one[1].  So let's come up with something nice as
> a substitute, any suggestions?
> 
> [1] I think that's a big, broad hint.

Something like:
struct mm_share {
        spinlock_t page_table_lock;
        struct list_head mm_list;
};

struct mm {
	struct list_head mm_list;
        struct mm_share *mm_share;
        .....
};

So we have an overarching structure for all of the shared mm's.  

Eric
