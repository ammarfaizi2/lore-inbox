Return-Path: <linux-kernel-owner+w=401wt.eu-S1423027AbWLUSzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423027AbWLUSzW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 13:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423029AbWLUSzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 13:55:22 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4089 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423027AbWLUSzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 13:55:21 -0500
Date: Thu, 21 Dec 2006 18:55:12 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
Message-ID: <20061221185512.GH3958@flint.arm.linux.org.uk>
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20061221152621.GB3958@flint.arm.linux.org.uk> <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu> <20061221171739.GE3958@flint.arm.linux.org.uk> <E1GxS8x-0000q5-00@dorka.pomaz.szeredi.hu> <20061221181156.GG3958@flint.arm.linux.org.uk> <E1GxSgF-0000uV-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GxSgF-0000uV-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 07:30:11PM +0100, Miklos Szeredi wrote:
> > > > > Yes, note the flush_dcache_page() call in fuse_copy_finish().  That
> > > > > could be replaced by the flush_kernel_dcache_page() (added by James
> > > > > Bottomley together with flush_anon_page()) when all relevant
> > > > > architectures have defined it.
> > > > 
> > > > I should say that flush_anon_page() in its current form is going to be
> > > > problematic for ARM.  It is passed:
> > > > 
> > > > 1. the struct page
> > > > 2. the virtual address in process memory for the page
> > > > 
> > > > It is not passed the mm or vma.  This means that we have no idea whether
> > > > the virtual address is in the currently mapped VM space or not.  The
> > > > common use of get_area_pages() is to get pages from other address
> > > > spaces.
> > > 
> > > I'm not sure I understand.  flush_anon_page() needs only to flush the
> > > mapping for the given virtual address, no?
> > 
> > Yes, but that virtual /user/ address is meaningless without knowing
> > which process address space it belongs to.
> > 
> > > It's always mapped at that address (since it was just accessed through
> > > that).
> > 
> > No.  Consider ptrace() (invoked by gdb) reading data from another
> > processes address space to obtain structure data or instructions.
> > 
> > > Any other mappings
> > > of the anonymous page are irrelevant, they don't need to be flushed.
> > 
> > Again, incorrect.  Consider if the page you're accessing is a file-
> > backed page, and is mapped into a process using a shared mapping.
> > Because you've written to the file, those shared mappings need to see
> > that write, and the interface for achieving that is flush_dcache_page().
> > If not, data loss can occur.
> 
> Yes, for file backed pages.  But flush_anon_page() only needs to deal
> with anonymous (not file backed) pages.

Ignore my final paragraph, it was clearly wrong; I was thinking about
the flush after you've written to the page.

However, I continue to assert that I require the VMA to implement
flush_anon_page() since a userspace address without knowing which
userspace it corresponds with is utterly useless for cache maintainence
purposes.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
