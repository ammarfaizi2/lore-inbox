Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266793AbUJRQA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbUJRQA1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 12:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266805AbUJRQA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 12:00:26 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:56744 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266793AbUJRQAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 12:00:12 -0400
Date: Mon, 18 Oct 2004 08:59:17 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: page fault scalability patch V10: [2/7] defer/omit taking
 page_table_lock
In-Reply-To: <20041015200041.GD4937@logos.cnet>
Message-ID: <Pine.LNX.4.58.0410180844001.15060@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0409201348070.4628@schroedinger.engr.sgi.com>
 <20040920205752.GH4242@wotan.suse.de> <200409211841.25507.vda@port.imtp.ilyichevsk.odessa.ua>
 <20040921154542.GB12132@wotan.suse.de> <41527885.8020402@myrealbox.com>
 <20040923090345.GA6146@wotan.suse.de> <Pine.LNX.4.58.0409271204180.31769@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0410151201020.26697@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0410151203521.26697@schroedinger.engr.sgi.com>
 <20041015200041.GD4937@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, Marcelo Tosatti wrote:

> The comment above, which is a few lines down on do_swap_page() is now
> bogus (the "while we released the page table lock").

Ok. I also modified the second occurence of that comment.

> >  	if (write_access) {
> >  		/* Allocate our own private page. */
> >  		pte_unmap(page_table);
> > -		spin_unlock(&mm->page_table_lock);
> >
> >  		if (unlikely(anon_vma_prepare(vma)))
> >  			goto no_mem;
> > @@ -1434,30 +1428,39 @@
> >  			goto no_mem;
> >  		clear_user_highpage(page, addr);
> >
> > -		spin_lock(&mm->page_table_lock);
> > +		lock_page(page);
>
> Question: Why do you need to hold the pagelock now?
>
> I can't seem to figure that out myself.

Hmm.. I cannot see a good reason for it either. The page is new
and thus no references can exist yet. Removed.

> > +	if (write_access) {
> > +		/*
> > +		 * The following two functions are safe to use without
> > +		 * the page_table_lock but do they need to come before
> > +		 * the cmpxchg?
> > +		 */
>
> They do need to come after AFAICS - from the point they are in the reverse map
> and the page is on the LRU try_to_unmap() can come in and try to
> unmap the pte (now that we dont hold page_table_lock anymore).

Ahh. Thanks.

> > -			return do_no_page(mm, vma, address, write_access, pte, pmd);
> > +			return do_no_page(mm, vma, address, write_access, pte, pmd, entry);
> >  		if (pte_file(entry))
> > -			return do_file_page(mm, vma, address, write_access, pte, pmd);
> > +			return do_file_page(mm, vma, address, write_access, pte, pmd, entry);
> >  		return do_swap_page(mm, vma, address, pte, pmd, entry, write_access);
> >  	}
>
> I wonder what happens if kswapd, through try_to_unmap_one(), unmap's the
> pte right here ?
>
> Aren't we going to proceed with the "pte_mkyoung(entry)" of a potentially
> now unmapped pte? Isnt that case possible now?

The pte value is saved in entry. If the pte is umapped then its value is
changed. Thus the cmpxchg will fail and the page fault handler will return
without doing anything.

try_to_unmap_one was modified to handle the pte's in an atomic way using
ptep_xchg.

