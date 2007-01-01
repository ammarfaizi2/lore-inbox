Return-Path: <linux-kernel-owner+w=401wt.eu-S1754771AbXAAXqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771AbXAAXqU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 18:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754788AbXAAXqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 18:46:20 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4549 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771AbXAAXqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 18:46:19 -0500
Date: Mon, 1 Jan 2007 23:45:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: davem@davemloft.net, arjan@infradead.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@osdl.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
Message-ID: <20070101234559.GE30535@flint.arm.linux.org.uk>
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>, davem@davemloft.net,
	arjan@infradead.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	akpm@osdl.org
References: <20061230.212338.92583434.davem@davemloft.net> <20061231092318.GA1702@flint.arm.linux.org.uk> <1167557242.20929.647.camel@laptopd505.fenrus.org> <20061231.014756.112264804.davem@davemloft.net> <20061231100007.GC1702@flint.arm.linux.org.uk> <E1H0zkD-0003uw-00@dorka.pomaz.szeredi.hu> <20061231173743.GD1702@flint.arm.linux.org.uk> <E1H1VQu-0005oJ-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1H1VQu-0005oJ-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01, 2007 at 11:15:04PM +0100, Miklos Szeredi wrote:
> > > > I'm willing to do that - and I guess this means we can probably do this
> > > > instead of walking the list of VMAs for the shared mapping, thereby
> > > > hitting both anonymous and shared mappings with the same code?
> > > 
> > > But for the get_user_pages() case there's no point, is there?  The VMA
> > > and the virtual address is already available, so trying to find it
> > > again through RMAP doesn't much make sense.
> > > 
> > > Users of get_user_pages() don't care about any other mappings (maybe
> > > ptrace does, I don't know) only about one single user mapping and one
> > > kernel mapping.
> > > 
> > > So using flush_dcache_page() there is an overkill, trying to teach it
> > > about anonymous pages is not the real solution, flush_dcache_page()
> > > was never meant to be used on anything but file mapped pages.
> > 
> > It's not actually.  For flush_anon_page() we currently have to flush the
> > user mapping and the kernel mapping.  For flush_dcache_page(), it's
> > exactly the same - we have to flush the kernel mapping and the user
> > mapping.
> 
> I was never advocating flush_anon_page().  I was suggesting a _new_
> cache operation:
> 
>    flush_kernel_user_page(page, vma, virt_addr)
> 
> which flushes the kernel mapping and the given user mapping.  Just
> like flush_dcache_page() but without needing to find the user
> mapping(s).

There's a problem with defining cache coherency macros to that extent.
You take away flexibility to efficiently implement them on various
platforms which you didn't think about (eg, in the above case it's
perfectly fine for VIVT, but not really VIPT.)

> However the cache flushing in kmap/kunmap idea might be cleaner and
> better.

It has the significant advantage that, unlike the flush* calls, they
can't really be forgotten by folk programming on cache alias-free
hardware.  That's a _very_ persuasive argument for this proposed
interface.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
