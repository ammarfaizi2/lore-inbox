Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbTEaXf2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 19:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbTEaXf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 19:35:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:702 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264501AbTEaXf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 19:35:27 -0400
Date: Sat, 31 May 2003 16:48:16 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@digeo.com,
       hch@infradead.org
Subject: Re: Always passing mm and vma down (was: [RFC][PATCH] Convert do_no_page() to a hook to avoid DFS race)
Message-ID: <20030531234816.GB1408@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20030530164150.A26766@us.ibm.com> <20030531104617.J672@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030531104617.J672@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 10:46:18AM +0200, Ingo Oeser wrote:
> On Fri, May 30, 2003 at 04:41:50PM -0700, Paul E. McKenney wrote:
> > -struct page *
> > -ia32_install_shared_page (struct vm_area_struct *vma, unsigned long address, int no_share)
> > +int
> > +ia32_install_shared_page (struct mm_struct *mm, struct vm_area_struct *vma, unsigned long address, int write_access, pmd_t *pmd)
> 
> Why do we always pass mm and vma down, even if vma->vm_mm
> contains the mm, where the vma belongs to? Is the connection
> between a vma and its mm also protected by the mmap_sem?
> 
> Is this really necessary or an oversight and we waste a lot of
> stack in a lot of places?
> 
> If we just need it for accounting: We need current->mm, if we
> need it to locate the next vma relatively to this vma, vma->vm_mm
> is the one.

Interesting point.  The original do_no_page() API does this
as well:

	static int
	do_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
		   unsigned long address, int write_access, pte_t *page_table, pmd_t *pmd)

As does do_anonymous_page().  I assumed that there were corner
cases where this one-to-one correspondence did not exist, but
must confess that I did not go looking for them.

Or is this a performance issue, avoiding a dereference and
possible cache miss?

					Thanx, Paul
