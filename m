Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262964AbTDBW6S>; Wed, 2 Apr 2003 17:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263177AbTDBW6S>; Wed, 2 Apr 2003 17:58:18 -0500
Received: from [12.47.58.55] ([12.47.58.55]:2310 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S262964AbTDBW6R>;
	Wed, 2 Apr 2003 17:58:17 -0500
Date: Wed, 2 Apr 2003 15:09:03 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.66-mm2] Fix page_convert_anon locking issues
Message-Id: <20030402150903.21765844.akpm@digeo.com>
In-Reply-To: <80300000.1049320593@baldur.austin.ibm.com>
References: <8910000.1049303582@baldur.austin.ibm.com>
	<20030402132939.647c74a6.akpm@digeo.com>
	<80300000.1049320593@baldur.austin.ibm.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Apr 2003 23:09:36.0592 (UTC) FILETIME=[EE14CD00:01C2F96C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> wrote:
>
> The sequence is the following:

Boy you owe me a big fat comment on top of this one.

> 1.  take a copy of the reference to the page (the pgd or pmd entry)
> 2.  validate the copy
> 3.  establish a pointer into the page
> 4.  pull the data from the page (pmd or pte entry)
> 5.  validate the original reference again
> 6.  use the data
> 
> This guarantees that the data is from a page that's still valid, since the
> pgd or pmd entry are cleared when the page is released.  We're helped by
> the fact that for an invalid page we can simply return failure.

+	if (page_to_pfn(page) != pte_pfn(*pte))
+		goto out_unmap;
+
+	if (addr)
+		*addr = address;
+

	==>munmap here

+	return pte;

i_shared_sem won't stop that.  The pte points into thin air, and may now
point at a value which looks like our page.

> > But then again, why is it not possible to just do:
> > 
> > 	list_for_each_entry(vma, &mapping->i_mmap, shared) {
> > 		if (!pte_chain)
> > 			pte_chain = pte_chain_alloc(GFP_KERNEL);
> > 		spin_lock(&mm->page_table_lock);
> > 		pte = find_pte(vma, page, NULL);
> > 		if (pte)
> > 			pte_chain = page_add_rmap(page, pte, pte_chain);
> > 		spin_unlock(&mm->page_table_lock);
> > 	}
> > 
> > 	pte_chain_free(pte_chain);
> > 	up(&mapping->i_shared_sem);
> > 
> > ?
> 
> Because the page is in transition from !PageAnon to PageAnon.

These are file-backed pages.  So what does PageAnon really mean?

> We have to
> hold the pte_chain lock during the entire transition in case someone else
> tries to do something like page_remove_rmap, which would break.

How about setting PageAnon at the _start_ of the operation? 
page_remove_rmap() will cope with that OK.

