Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbUKRB3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbUKRB3J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 20:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbUKRB1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 20:27:55 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:11509 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262705AbUKRB0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 20:26:45 -0500
Subject: Re: [patch 2] Xen core patch : arch_free_page return value
From: Dave Hansen <haveblue@us.ibm.com>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Keir.Fraser@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
In-Reply-To: <E1CUaxA-0006Fa-00@mta1.cl.cam.ac.uk>
References: <E1CUaxA-0006Fa-00@mta1.cl.cam.ac.uk>
Content-Type: text/plain
Message-Id: <1100741201.12373.276.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 17 Nov 2004 17:26:41 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-17 at 17:19, Ian Pratt wrote:
> > On Wed, 2004-11-17 at 15:48, Ian Pratt wrote:
> > > This patch adds a return value to the existing arch_free_page function
> > > that indicates whether the normal free routine still has work to
> > > do. The only architecture that currently uses arch_free_page is arch
> > > 'um'. arch-xen needs this for 'foreign pages' - pages that don't
> > > belong to the page allocator but are instead managed by custom
> > > allocators.
> > 
> > But, you're modifying page allocator functions to do this.  Why would
> > you call __free_pages_ok() on a page that didn't belong to the page
> > allocator?
> 
> Pages that have been allocated by our custom allocators get passed
> into standard linux subsystems where we get no control over how
> they're freed.

OK, then how are they allocated?  Are they only allocated by your
special drivers or in your architecture?

I think allowing this is weird:

        foo = special_zen_malloc();
        bar = kmalloc();
        kfree(foo);
        kfree(bar);
        
Shoudn't it be

	special_zen_free(free);?
        
BTW, your arch-specific definition of PG_foreign is a little goofy.  If
you need the bit, then put it in page-flags.h now.  The memory hotplug
people have an evil plan to consume all unused bits in page->flags
(determined at compile-time) and that little gem will certainly break
it.  

It's great that you contained stuff to your architecture, but little
bits like the page-flags thing don't make me think you've done it for
real, only hacked around it :)

-- Dave

