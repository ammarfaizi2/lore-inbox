Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263036AbUK0CCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbUK0CCs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbUKZTgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:36:48 -0500
Received: from zeus.kernel.org ([204.152.189.113]:33218 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262406AbUKZTZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:25:15 -0500
Date: Thu, 25 Nov 2004 17:45:09 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bgagnon@coradiant.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@novell.com>, davem@redhat.com
Subject: Re: Memory leak in 2.4.27 kernel, using mmap raw packet sockets
Message-ID: <20041125194509.GN16633@logos.cnet>
References: <OFDDC77A23.4D34536B-ON85256F2D.00514F15-85256F2D.00517F52@coradiant.com> <20041015182352.GA4937@logos.cnet> <1097980764.13226.21.camel@localhost.localdomain> <20041125150206.GF16633@logos.cnet> <20041125203248.GD5904@dualathlon.random> <20041125171242.GL16633@logos.cnet> <20041125231313.GG5904@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125231313.GG5904@dualathlon.random>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2004 at 12:13:14AM +0100, Andrea Arcangeli wrote:
> On Thu, Nov 25, 2004 at 03:12:42PM -0200, Marcelo Tosatti wrote:
> > get_user_pages() bails out if ! VM_IO. 
> > 
> > Is that what you mean with "VM_IO enforcement" ? 
> 
> yes. It bails out if VM_IO is set (not ! clear ;)
> 
> > I thought about the BUG() to catch potential offenders, but I was
> > not sure if it was possible for a PG_reserved page to be part of VMA's 
> > which was being get_user_pages'd.
> 
> Exactly, it's much safer to go with the real fix of fixing it in
> get_user_pages. If something we should put a bugcheck there.
> 
> > Now you tell me it is possible, and thats only the ZERO page. Fine. 
> 
> Yes, and the ZERO_PAGE is actually the _only_ reserved page we must
> allow to go through. Every other reserved page must be discarded (or
> kernel-crash with BUG_ON if Alan feels confortable with the VM_IO
> enforcement). 

Oh the VM_IO enforcement has been there for ages.

> > This is what you suggests plus some extra hopefully useful debugging 
> > 
> > 
> > --- memory.c.orig	2004-11-25 14:51:00.074508952 -0200
> > +++ memory.c	2004-11-25 15:08:38.026675776 -0200
> > @@ -454,8 +454,9 @@
> >  int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
> >  		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas)
> >  {
> > -	int i;
> > +	int i, s;
> >  	unsigned int flags;
> > +	struct vm_area_struct *savevma = NULL;
> >  
> >  	/*
> >  	 * Require read or write permissions.
> > @@ -463,7 +464,7 @@
> >  	 */
> >  	flags = write ? (VM_WRITE | VM_MAYWRITE) : (VM_READ | VM_MAYREAD);
> >  	flags &= force ? (VM_MAYREAD | VM_MAYWRITE) : (VM_READ | VM_WRITE);
> > -	i = 0;
> > +	i = s = 0;
> >  
> >  	do {
> >  		struct vm_area_struct *	vma;
> > @@ -499,9 +500,13 @@
> >  				/* FIXME: call the correct function,
> >  				 * depending on the type of the found page
> >  				 */
> > -				if (!pages[i] || PageReserved(pages[i]))
> > -					goto bad_page;
> > -				page_cache_get(pages[i]);
> > +				if (!pages[i] || PageReserved(pages[i])) {
> > +					if (pages[i] != ZERO_PAGE(start)) {
> > +						savevma = vma;
> > +						goto bad_page;
> > +					}
> > +				} else
> > +					page_cache_get(pages[i]);
> >  			}
> >  			if (vmas)
> >  				vmas[i] = vma;
> > @@ -520,9 +525,15 @@
> >  	 */
> >  bad_page:
> >  	spin_unlock(&mm->page_table_lock);
> > +	s = i;
> >  	while (i--)
> >  		page_cache_release(pages[i]);
> > -	i = -EFAULT;
> > +	/* catch bad uses of PG_reserved on !VM_IO vma's */
> > +	printk(KERN_ERR "get_user_pages PG_reserved page on"
> > +			"vma:%p flags:%lx page:%d\n", savevma,
> > +			savevma->flags, s);
> > +	BUG();
> > +	i = -EFAULT;
> >  	goto out;
> >  }
> 
> Yes, however I wouldn't turn on the debugging code just in case some
> driver forgets to set VM_IO and it doesn't use remap_page_range. There's
> nothing fundamentally fatal in having a reserved page in a non VM_IO
> vma (I mean, after fixing the above bit ;).

Sure, I'll comment the BUG() off during 2.4.29-rc.

How does that sound?

