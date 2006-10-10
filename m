Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWJJRxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWJJRxQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWJJRxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:53:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63161 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964881AbWJJRxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:53:15 -0400
Date: Tue, 10 Oct 2006 10:52:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
Message-Id: <20061010105236.2ef0268b.akpm@osdl.org>
In-Reply-To: <20061010121327.GA2431@wotan.suse.de>
References: <20061007105758.14024.70048.sendpatchset@linux.site>
	<20061007105853.14024.95383.sendpatchset@linux.site>
	<20061010121003.GA19322@infradead.org>
	<20061010121327.GA2431@wotan.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 14:13:27 +0200
Nick Piggin <npiggin@suse.de> wrote:

> On Tue, Oct 10, 2006 at 01:10:03PM +0100, Christoph Hellwig wrote:
> > On Sat, Oct 07, 2006 at 03:06:32PM +0200, Nick Piggin wrote:
> > > +/*
> > > + * fault_data is filled in the the pagefault handler and passed to the
> > > + * vma's ->fault function. That function is responsible for filling in
> > > + * 'type', which is the type of fault if a page is returned, or the type
> > > + * of error if NULL is returned.
> > > + */
> > > +struct fault_data {
> > > +	struct vm_area_struct *vma;
> > > +	unsigned long address;
> > > +	pgoff_t pgoff;
> > > +	unsigned int flags;
> > > +
> > > +	int type;
> > > +};
> > >  
> > >  /*
> > >   * These are the virtual MM functions - opening of an area, closing and
> > > @@ -203,6 +221,7 @@ extern pgprot_t protection_map[16];
> > >  struct vm_operations_struct {
> > >  	void (*open)(struct vm_area_struct * area);
> > >  	void (*close)(struct vm_area_struct * area);
> > > +	struct page * (*fault)(struct fault_data * data);
> > 
> > Please pass the vma as an explicit first argument so that all vm_operations
> > operate on a vma.  It's also much cleaner to have the separate between the
> > the object operated on (the vma) and all the fault details (struct fault_data).
> 
> Hmm... I agree it is more consistent, but OTOH if we're passing a
> structure I thought it may as well just go in there. But I will
> change unless anyone comes up with an objection.

I'd agree that it's more attractive to have the vma* in the argument list,
but it presumably adds runtime cost: cycles and stack depth.  I don't how
much though.
