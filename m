Return-Path: <linux-kernel-owner+w=401wt.eu-S1422993AbWLUR4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422993AbWLUR4L (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 12:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422995AbWLUR4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 12:56:11 -0500
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:47653 "EHLO
	mail-gw2.sa.eol.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422993AbWLUR4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 12:56:10 -0500
To: rmk+lkml@arm.linux.org.uk
CC: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-reply-to: <20061221171739.GE3958@flint.arm.linux.org.uk> (message from
	Russell King on Thu, 21 Dec 2006 17:17:39 +0000)
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
References: <20061221152621.GB3958@flint.arm.linux.org.uk> <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu> <20061221171739.GE3958@flint.arm.linux.org.uk>
Message-Id: <E1GxS8x-0000q5-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 21 Dec 2006 18:55:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yes, note the flush_dcache_page() call in fuse_copy_finish().  That
> > could be replaced by the flush_kernel_dcache_page() (added by James
> > Bottomley together with flush_anon_page()) when all relevant
> > architectures have defined it.
> 
> I should say that flush_anon_page() in its current form is going to be
> problematic for ARM.  It is passed:
> 
> 1. the struct page
> 2. the virtual address in process memory for the page
> 
> It is not passed the mm or vma.  This means that we have no idea whether
> the virtual address is in the currently mapped VM space or not.  The
> common use of get_area_pages() is to get pages from other address
> spaces.

I'm not sure I understand.  flush_anon_page() needs only to flush the
mapping for the given virtual address, no?  It's always mapped at that
address (since it was just accessed through that).  Any other mappings
of the anonymous page are irrelevant, they don't need to be flushed.

> If we use the supplied virtual address to perform cache maintainence of
> the userspace mapping, we might end up hitting a completely different
> processes address space, which may contain some page sensitive to such
> operations, or may not contain any page and thereby could cause a page
> fault on some ARM CPUs.

I think calling get_user_pages() from a different process' address
space simply doesn't make any sense.

Miklos
