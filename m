Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263165AbTDBVpN>; Wed, 2 Apr 2003 16:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263167AbTDBVpN>; Wed, 2 Apr 2003 16:45:13 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:20387 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S263165AbTDBVpL>; Wed, 2 Apr 2003 16:45:11 -0500
Date: Wed, 02 Apr 2003 15:56:33 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.66-mm2] Fix page_convert_anon locking issues
Message-ID: <80300000.1049320593@baldur.austin.ibm.com>
In-Reply-To: <20030402132939.647c74a6.akpm@digeo.com>
References: <8910000.1049303582@baldur.austin.ibm.com>
 <20030402132939.647c74a6.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, April 02, 2003 13:29:39 -0800 Andrew Morton
<akpm@digeo.com> wrote:

> I am unable to convince myself that this is correct.  It's playing with
> pmd and pte pages which can be freed, reallocated and filled with random
> stuff. I really don't see how that can work, but am willing to be taught.
> 
> Because we hold i_shared_sem we know that the pgd layer is stable and that
> the mm's aren't going away.

The sequence is the following:

1.  take a copy of the reference to the page (the pgd or pmd entry)
2.  validate the copy
3.  establish a pointer into the page
4.  pull the data from the page (pmd or pte entry)
5.  validate the original reference again
6.  use the data

This guarantees that the data is from a page that's still valid, since the
pgd or pmd entry are cleared when the page is released.  We're helped by
the fact that for an invalid page we can simply return failure.

> Is it not possible to take each mm's page_table_lock?  There's a ranking
> problem with pte_chain_lock(), but that can presumably be resolved by
> doing a trylock on the page_table_lock and if that fails, restart the
> whole operation.

It is possible, but would be much more painful.

> But then again, why is it not possible to just do:
> 
> 	list_for_each_entry(vma, &mapping->i_mmap, shared) {
> 		if (!pte_chain)
> 			pte_chain = pte_chain_alloc(GFP_KERNEL);
> 		spin_lock(&mm->page_table_lock);
> 		pte = find_pte(vma, page, NULL);
> 		if (pte)
> 			pte_chain = page_add_rmap(page, pte, pte_chain);
> 		spin_unlock(&mm->page_table_lock);
> 	}
> 
> 	pte_chain_free(pte_chain);
> 	up(&mapping->i_shared_sem);
> 
> ?

Because the page is in transition from !PageAnon to PageAnon.  We have to
hold the pte_chain lock during the entire transition in case someone else
tries to do something like page_remove_rmap, which would break.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

