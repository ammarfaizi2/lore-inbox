Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUDHNcn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 09:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbUDHNcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 09:32:43 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:25047 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261752AbUDHNci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 09:32:38 -0400
Date: Thu, 08 Apr 2004 22:32:32 +0900 (JST)
Message-Id: <20040408.223232.44890168.taka@valinux.co.jp>
To: Zoltan.Menyhart@bull.net
Cc: haveblue@us.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, iwamoto@valinux.co.jp
Subject: Re: Migrate pages from a ccNUMA node to another - patch
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <4071763E.7293CFCC@nospam.org>
References: <40698501.BD3E12BF@nospam.org>
	<20040403.115833.74749140.taka@valinux.co.jp>
	<4071763E.7293CFCC@nospam.org>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > I guess aruguments src_node, mm and pte would be redundant since
> > they can be looked up from old_p with the reverse mapping scheme.
> 
> In my version 0.2, I can do with only the following arguments:
>  *		node:	Destination NUMA node
>  *		mm:	-> victim "mm_struct"
>  *		pte:	-> PTE of the page to be moved
> (If I have "mm" at hand, why not to use it ? Why not to avoid fetching the r-map
> page struct ?)
> 
> > >Notes: "pte" can be NULL if I do not know it apriori
> > >       I cannot release "mm->page_table_lock" otherwise I have to re-scan the "mm->pgd".
> > 
> > Re-schan plicy would be much better since migrating pages is heavy work.
> > I don't think that holding mm->page_table_lock for long time would be
> > good idea.
> 
> Re-scanning is "cache killer", at least on IA64 with huge user memory size.
> I have more than 512 Mbytes user memory and its PTEs do not fit into the L2 cache.
> 
> In my current design, I have the outer loops: PGD, PMD and PTE walking; and once
> I find a valid PTE, I check it against the list of max. 2048 physical addresses as
> the inner loop.
> I reversed them: walking through the list of max. 2048 physical addresses as outer
> loop and the PGD - PMD - PTE scans as inner loops resulted in 4 to 5 times slower
> migration.

I've been thinking about it.

I guess our page remap patches would be overkill for your purpose.
Point of our patches is that:
   1. Blocks new access to a specified page.
   2. Waits for the page going into quiescent state.
   3. Copies data from the page to a new page and exchanges them.

In my understanding you want to handle only anonymous pages
which don't have backing store yet. This means that you only need
step 3.

> > How do you think about following algorism:
> >   1. get mm->page_table_lock
> >   2. chose some pages.
> >   3. release mm->page_table_lock
> >   4. call remap_onepage() against each page.
> >   5. goto step1 if there remain pages to be migrated.
> 
> I want to move the most frequently used pages - at least with the HW assisted
> hot page detection.
> I take "mm->page_table_lock", I nuke the PTE. We've got a good chance that the CPU
> using the page observes a page fault almost immediately. It enters the page fault
> handler and gets blocked by "mm->page_table_lock". If I released the lock, the CPU
> could continue and realize that there is nothing to do, the page fault has already
> been repaired. In the mean time, it is me who wait for "mm->page_table_lock".

If you use the HW assisted hot page detection, just notify our remapping
functions of hot pages directly. Everything would be handled well and
pagefault handler would be blocked by PG_lock bit.

