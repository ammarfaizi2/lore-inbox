Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289058AbSBSAXf>; Mon, 18 Feb 2002 19:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289084AbSBSAXZ>; Mon, 18 Feb 2002 19:23:25 -0500
Received: from dsl-213-023-040-169.arcor-ip.net ([213.23.40.169]:26769 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289058AbSBSAXF>;
	Mon, 18 Feb 2002 19:23:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [RFC] Page table sharing
Date: Tue, 19 Feb 2002 01:27:42 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>, dmccr@us.ibm.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Robert Love <rml@tech9.net>, Rik van Riel <riel@conectiva.com.br>,
        mingo@redhat.com, Andrew Morton <akpm@zip.com.au>,
        manfred@colorfullife.com, wli@holomorphy.com
In-Reply-To: <Pine.LNX.4.21.0202182358190.1021-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.21.0202182358190.1021-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16cy8E-0000xp-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 19, 2002 01:03 am, Hugh Dickins wrote:
> On Tue, 19 Feb 2002, Daniel Phillips wrote:
> > On February 18, 2002 08:04 pm, Hugh Dickins wrote:
> > > On Mon, 18 Feb 2002, Daniel Phillips wrote:
> > > > On February 18, 2002 09:09 am, Hugh Dickins wrote:
> > > > > Since copy_page_range would not copy shared page tables, I'm wrong to
> > > > > point there.  But __pte_alloc does copy shared page tables (to unshare
> > > > > them), and needs them to be stable while it does so: so locking against
> > > > > swap_out really is required.  It also needs locking against read faults,
> > > > > and they against each other: but there I imagine it's just a matter of
> > > > > dropping the write arg to __pte_alloc, going back to pte_alloc again.
> > 
> > I'm not sure what you mean here, you're not suggesting we should unshare the
> > page table on read fault are you?
> 
> I am.  But I can understand that you'd prefer not to do it that way.
> Hugh

No, that's not nearly studly enough ;-)

Since we have gone to all the trouble of sharing the page table, we should
swap in/out for all sharers at the same time.  That is, keep it shared, saving
memory and cpu.

Now I finally see what you were driving at: before, we could count on the
mm->page_table_lock for exclusion on read fault, now we can't, at least not
when ptb->count is great than one[1].  So let's come up with something nice as
a substitute, any suggestions?

[1] I think that's a big, broad hint.

-- 
Daniel
