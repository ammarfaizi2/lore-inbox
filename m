Return-Path: <linux-kernel-owner+w=401wt.eu-S1423030AbWLUTGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423030AbWLUTGG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 14:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423036AbWLUTGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 14:06:05 -0500
Received: from mail-gw3.sa.ew.hu ([212.108.200.82]:55919 "EHLO
	mail-gw3.sa.ew.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423030AbWLUTGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 14:06:04 -0500
To: rmk+lkml@arm.linux.org.uk
CC: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-reply-to: <20061221185512.GH3958@flint.arm.linux.org.uk> (message from
	Russell King on Thu, 21 Dec 2006 18:55:12 +0000)
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
References: <20061221152621.GB3958@flint.arm.linux.org.uk> <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu> <20061221171739.GE3958@flint.arm.linux.org.uk> <E1GxS8x-0000q5-00@dorka.pomaz.szeredi.hu> <20061221181156.GG3958@flint.arm.linux.org.uk> <E1GxSgF-0000uV-00@dorka.pomaz.szeredi.hu> <20061221185512.GH3958@flint.arm.linux.org.uk>
Message-Id: <E1GxTED-0000yy-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 21 Dec 2006 20:05:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > > Yes, note the flush_dcache_page() call in fuse_copy_finish().  That
> > > > > > could be replaced by the flush_kernel_dcache_page() (added by James
> > > > > > Bottomley together with flush_anon_page()) when all relevant
> > > > > > architectures have defined it.
> > > > > 
> > > > > I should say that flush_anon_page() in its current form is going to be
> > > > > problematic for ARM.  It is passed:
> > > > > 
> > > > > 1. the struct page
> > > > > 2. the virtual address in process memory for the page
> > > > > 
> > > > > It is not passed the mm or vma.  This means that we have no idea whether
> > > > > the virtual address is in the currently mapped VM space or not.  The
> > > > > common use of get_area_pages() is to get pages from other address
> > > > > spaces.
> > > > 
> > > > I'm not sure I understand.  flush_anon_page() needs only to flush the
> > > > mapping for the given virtual address, no?
> > > 
> > > Yes, but that virtual /user/ address is meaningless without knowing
> > > which process address space it belongs to.
> > > 
> > > > It's always mapped at that address (since it was just accessed through
> > > > that).
> > > 
> > > No.  Consider ptrace() (invoked by gdb) reading data from another
> > > processes address space to obtain structure data or instructions.
> > > 
> > > > Any other mappings
> > > > of the anonymous page are irrelevant, they don't need to be flushed.
> > > 
> > > Again, incorrect.  Consider if the page you're accessing is a file-
> > > backed page, and is mapped into a process using a shared mapping.
> > > Because you've written to the file, those shared mappings need to see
> > > that write, and the interface for achieving that is flush_dcache_page().
> > > If not, data loss can occur.
> > 
> > Yes, for file backed pages.  But flush_anon_page() only needs to deal
> > with anonymous (not file backed) pages.
> 
> Ignore my final paragraph, it was clearly wrong; I was thinking about
> the flush after you've written to the page.
> 
> However, I continue to assert that I require the VMA to implement
> flush_anon_page() since a userspace address without knowing which
> userspace it corresponds with is utterly useless for cache maintainence
> purposes.

I understand now.  I'm not sure how the PARISC implementation can be
correct in this light.

Miklos
