Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268745AbUJECxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268745AbUJECxp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 22:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268750AbUJECxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 22:53:45 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:61326 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S268745AbUJECxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 22:53:40 -0400
Date: Tue, 05 Oct 2004 11:53:47 +0900 (JST)
Message-Id: <20041005.115347.95910198.taka@valinux.co.jp>
To: marcelo.tosatti@cyclades.com
Cc: iwamoto@valinux.co.jp, haveblue@us.ibm.com, akpm@osdl.org,
       linux-mm@kvack.org, piggin@cyberone.com.au, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20041004172427.GL16374@logos.cnet>
References: <20041003140723.GD4635@logos.cnet>
	<20041004.033559.71092746.taka@valinux.co.jp>
	<20041004172427.GL16374@logos.cnet>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marcelo

> > > > > Why's that? You can copy anonymous pages without adding them to swap (thats
> > > > > what the patch I posted does).
> > > > 
> > > > The reason is to guarantee that any anonymous page can be migrated anytime.
> > > > I want to block newly occurred accesses to the page during the migration
> > > > because it can't be migrated if there remain some references on it by
> > > > system calls, direct I/O and page faults.
> > > 
> > > It would be nice if we could block pte faults in a way such to not need
> > > adding each anonymous page to swap. It can be too costly if you have a lot memory
> > > and it makes the whole operation dependable on swap size (if you dont have enough
> > > swap, you're dead).
> > > 
> > > Maybe hold mm->page_table_lock (might be too costly in terms of CPU time, but since
> > > migration is not a common operation anyway), or create a semaphore? 
> > 
> > I think the problem of the holding mm->page_table_lock approach is
> > that it doesn't allow the migration code blocked. the semaphore
> > approach would be better.
> 
> OK, I think the problem is that can be more than one thread with different address 
> spaces (ie different "current->mm", after fork) accessing the page.

Yes. 

> Adding a waitqueue to "anon_vma" structure (to be slept at do_swap_page time, 
> and awake after copy-page-and-flags/unlock), can be do the job I think.
> 
> > I have another idea that each anonymous page can detach its swap entry
> > after its migration. 
> 
> Yes thats a nice idea.

I'll do it in a week.

> > It can be done by remove_exclusive_swap_page()
> > if the page is remapped to the same spaces forcibly by
> > touch_unmapped_address() I made.
> 
> touch_unmapped_address() ?

I've made two functions.

record_unmapped_address() holds mm and address where a target page
has been mapped. touch_unmapped_address() remaps the page again.

> > > > Your approach will work fine on most of anonymous pages, which aren't
> > > > heavily accessed. I think it will be enough for memory defragmentation.
> > > 
> > > Yes...
> > > 
> > > > > 3) At migrate_page_common you assume additional page references 
> > > > > (page_migratable returning -EAGAIN) means the code should try to writeout 
> > > > > the page.
> > > > > 
> > > > > Is that assumption always valid?
> > > > 
> > > > -EAGAIN means that the page may require to be written back 
> > > 
> > > But why is it needed to writeout pages? We shouldnt need to. At least
> > > from what I can understand.
> > 
> > The migration code allows each filesystem to implement its own
> > migration code or just use migrate_page_buffer() or
> > migrate_page_common(). 
> > 
> > migrate_page_common() is a default function if filesystem doesn't
> > implement anything. The function is the most generic and it tries
> > to writeback pages only if they are dirty and have buffers.
> 
> The thing is: What is the point of writing out pages?

It was the easiest way to handle pages with buffers when Iwamoto
and I started to implement it. We thought it was slow but it would
work for all kinds of filesystems.

> We're just trying to migrate pages to another zone. 
> 
> If its under writeout, wait, if its dirty, just move it to the other
> zone.
> 
> Can you enlight me?

Yes, I also realize that.
migrate_page_buffer() will do this, but I'm not certain it will work
for all kinds of filesystems. I guess there might be some exceptions.
We may need a special operation to handle pages on a filesystem,
which has releasepage method.


Thanks,
Hirokazu Takahashi.


