Return-Path: <linux-kernel-owner+w=401wt.eu-S1754934AbXABTkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934AbXABTkp (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 14:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754928AbXABTkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 14:40:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:7144 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933AbXABTko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 14:40:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=XRZSJAVATPgBu1y7XahG1r5qUqs4zKVeKMmYXtjnFLgO9SS8WX1KZoOYIbg8w65D3NKUh6gGtR80wOMdNHKEWMA/MCDFt+9rC8xlPycqk6zV1NJjHjDiTW+OaYfFxZ9LjHdqaPlM213Q3aJd/w4BBDEK8yLxglTuNsC9m3iDZ6U=
Message-ID: <e9c3a7c20701021140l4f3b55edkbab86fe9bf6e7810@mail.gmail.com>
Date: Tue, 2 Jan 2007 12:40:40 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
To: "Miklos Szeredi" <miklos@szeredi.hu>, davem@davemloft.net,
       arjan@infradead.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, akpm@osdl.org, James.Bottomley@steeleye.com
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
In-Reply-To: <20070101234559.GE30535@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061230.212338.92583434.davem@davemloft.net>
	 <20061231092318.GA1702@flint.arm.linux.org.uk>
	 <1167557242.20929.647.camel@laptopd505.fenrus.org>
	 <20061231.014756.112264804.davem@davemloft.net>
	 <20061231100007.GC1702@flint.arm.linux.org.uk>
	 <E1H0zkD-0003uw-00@dorka.pomaz.szeredi.hu>
	 <20061231173743.GD1702@flint.arm.linux.org.uk>
	 <E1H1VQu-0005oJ-00@dorka.pomaz.szeredi.hu>
	 <20070101234559.GE30535@flint.arm.linux.org.uk>
X-Google-Sender-Auth: 6eecd4b653498c7d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/1/07, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Mon, Jan 01, 2007 at 11:15:04PM +0100, Miklos Szeredi wrote:
> > > > > I'm willing to do that - and I guess this means we can probably do this
> > > > > instead of walking the list of VMAs for the shared mapping, thereby
> > > > > hitting both anonymous and shared mappings with the same code?
> > > >
> > > > But for the get_user_pages() case there's no point, is there?  The VMA
> > > > and the virtual address is already available, so trying to find it
> > > > again through RMAP doesn't much make sense.
> > > >
> > > > Users of get_user_pages() don't care about any other mappings (maybe
> > > > ptrace does, I don't know) only about one single user mapping and one
> > > > kernel mapping.
> > > >
> > > > So using flush_dcache_page() there is an overkill, trying to teach it
> > > > about anonymous pages is not the real solution, flush_dcache_page()
> > > > was never meant to be used on anything but file mapped pages.
> > >
> > > It's not actually.  For flush_anon_page() we currently have to flush the
> > > user mapping and the kernel mapping.  For flush_dcache_page(), it's
> > > exactly the same - we have to flush the kernel mapping and the user
> > > mapping.
> >
> > I was never advocating flush_anon_page().  I was suggesting a _new_
> > cache operation:
> >
> >    flush_kernel_user_page(page, vma, virt_addr)
> >
> > which flushes the kernel mapping and the given user mapping.  Just
> > like flush_dcache_page() but without needing to find the user
> > mapping(s).
>
> There's a problem with defining cache coherency macros to that extent.
> You take away flexibility to efficiently implement them on various
> platforms which you didn't think about (eg, in the above case it's
> perfectly fine for VIVT, but not really VIPT.)
>
> > However the cache flushing in kmap/kunmap idea might be cleaner and
> > better.
>
> It has the significant advantage that, unlike the flush* calls, they
> can't really be forgotten by folk programming on cache alias-free
> hardware.  That's a _very_ persuasive argument for this proposed
> interface.
>
If the interface is going to change it seems like an opportunity to
add some helper routines for the dma to user case?  Russell
illuminated some of the mines on the field in this thread:
http://marc.theaimsgroup.com/?l=linux-arm-kernel&m=116669504732601&w=2,
but I think the concerns can be addressed.

I think it is important to note that I am talking specifically about
the offloaded memcpy (i.e. NET_DMA) case and not the capability to
mmap a general purpose dma region.  Since the dma transfer is kernel
initiated (versus device initiated) the modified dma api could
properly manage cache coherency.

I was at a loss at how to handle the MAP_SHARED case, but if those
mappings are non-virtually cacheable by default, as DavidM suggested,
then that particular problem goes away.

Now it sounds like the data corruption problem I ran into on ARM will
go away with the anonymous memory handling changes to the
get_user_pages path.  However, get_user_pages is overkill for the dma
memcpy case since it can optimize for transfer size and direction.

A rough sketch of the interface would be something like the following
struct dma_addr_user {
   dma_addr_t dma;
   void *user;
};
struct dma_addr_user *dma_map_single_user(struct device *dev, void
*kernel_addr, size_t size, enum dma_data_direction dir, void
*user_addr)

Comments?
