Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274190AbRISVMz>; Wed, 19 Sep 2001 17:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274193AbRISVMp>; Wed, 19 Sep 2001 17:12:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27222 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S274189AbRISVMb>; Wed, 19 Sep 2001 17:12:31 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: phillips@bonn-fries.net (Daniel Phillips),
        rfuller@nsisoftware.com (Rob Fuller), linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <E15jnIB-0003gh-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Sep 2001 15:03:21 -0600
In-Reply-To: <E15jnIB-0003gh-00@the-village.bc.nu>
Message-ID: <m1iteegag6.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > On September 17, 2001 06:03 pm, Eric W. Biederman wrote:
> > > In linux we have avoided reverse maps (unlike the BSD's) which tends
> > > to make the common case fast at the expense of making it more
> > > difficult to handle times when the VM system is under extreme load and
> > > we are swapping etc.
> > 
> > What do you suppose is the cost of the reverse map?  I get the impression you
> 
> > think it's more expensive than it is.
> 
> We can keep the typical page table cost lower than now (including reverse
> maps) just by doing some common sense small cleanups to get the page struct
> down to 48 bytes on x86

I have to admit the first time I looked at reverse maps our struct page
was much lighter weight, then now (64 bytes x86 UP).  And our cost per
page was noticeably fewer bytes than the BSDs. average_mem_per_page =
sizeof(struct page) + sizeof(pte_t) + sizeof(reverse_pte_t)*average_user_per_page.
But struct page has grown pretty significantly since then, and could
use a cleanup.  

So I figure it is worth going through and computing the costs of
reverse page tables and not, dismissing them out of hand.  But the
fact that the linux VM could get good performance in most
circumstances without reverse page tables has always enchanted me.  

That added to the fact that last time someone ran the numbers linux
was considerably faster than the BSD for mm type operations when not
swapping.  And this is the common case.

I admit reverse page tables make it easier under a high load to get
good paging performance, as the algorithms are more straigh forward.
But I have not seen the argument that not having reverse maps make it
undoable.  In fact previous versions of linux seem to put the proof
that you can get at least reasonable swapping under load without
reverse page tables.

There is also the cache thrashing case.  While scaning page table
entries it is probably impossible to prevent cache thrashing, but
reverse page tables look like they make it worse.

With respect to the current VM the primary complaint I have heard is
that anonymous pages are not in the page cache so cannot be aged.  At
least that was the complaint that started this thread.  For adding
pages to the page cache we currently have conflicting tensions.  Do we
want it in the page cache to age better or do we not want to allocate
the swap space yet?

So my suggestion was to look at getting anonymous pages backed by what
amounts to a shared memory segment.  In that vein.  By using an extent
based data structure we can get the cost down under the current 8 bits
per page that we have for the swap counts, and make allocating swap
pages faster.  And we want to cluster related swap pages anyway so
an extent based system is a natural fit.

If we loose the requirement that swapped out pages need to be in the
page tables.  It becomes a trivial issue to drop page tables with all of
their pages swapped out.  Plus there are a million other special cases
we can remove from the current VM.

So right now I can see a bigger benefit from anonymouse pages with a
``backing store'' then I can from reverse maps.

Eric



