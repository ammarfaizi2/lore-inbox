Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316364AbSFPQsG>; Sun, 16 Jun 2002 12:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316372AbSFPQsF>; Sun, 16 Jun 2002 12:48:05 -0400
Received: from ns.suse.de ([213.95.15.193]:39436 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316364AbSFPQsE>;
	Sun, 16 Jun 2002 12:48:04 -0400
Date: Sun, 16 Jun 2002 18:48:01 +0200
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
       Richard Brunner <richard.brunner@amd.com>, mark.langsdorf@amd.com
Subject: Re: another new version of pageattr caching conflict fix for 2.4
Message-ID: <20020616184801.A15227@wotan.suse.de>
References: <20020614032429.A19018@wotan.suse.de> <20020613213724.C21542@redhat.com> <20020614040025.GA2093@inspiron.birch.net> <20020614001726.D21542@redhat.com> <20020614062754.A11232@wotan.suse.de> <20020614112849.A22888@redhat.com> <20020614181328.A18643@wotan.suse.de> <20020614173133.GH2314@inspiron.paqnet.com> <20020614200537.A5418@wotan.suse.de> <m17kkzv8lq.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17kkzv8lq.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2002 at 04:08:49AM -0600, Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> > On Fri, Jun 14, 2002 at 12:31:33PM -0500, Andrea Arcangeli wrote:
> > > On Fri, Jun 14, 2002 at 06:13:28PM +0200, Andi Kleen wrote:
> > > > +#ifdef CONFIG_HIGHMEM
> > > > +	/* Hopefully not be mapped anywhere else. */
> > > > +	if (page >= highmem_start_page) 
> > > > +		return 0;
> > > > +#endif
> > > 
> > > there's no hope here. If you don't want to code it right because nobody
> > > is exercising such path and flush both any per-cpu kmap-atomic slot and
> > > the page->virtual, please place a BUG() there or any more graceful
> > > failure notification.
> > 
> > Ok done. 
> > 
> > I also removed the DRM change because it was buggy. I'm not 100% yet
> > it is even a problem. Needs more investigation.
> > 
> > BTW there is another corner case that was overlooked:  
> > mmap of /dev/kmem, /proc/kcore, /dev/mem. To handle this correctly 
> > the mmap functions would need to always walk the kernel page table
> > and force the correct caching attribute in the user mapping.
> > But what to do when there is already an existing mapping to user space?
> 
> Don't allow the change_page_attr if page->count > 1 is an easy solution,
> and it probably suffices.  Beyond that anything mmaped can be found

Erm, what should it do then? Fail the AGP map ?

> by walking into the backing address space, and then through the
> vm_area_structs found with i_mmap && i_mmap_shared.  Of course the
> vm_area_structs may possibly need to break because of the multiple
> page protections.

I know that, but it seems rather racy expensive and complicated.

> 
> > > > +int change_page_attr(struct page *page, int numpages, pgprot_t prot)
> > > > +{
> > > 
> > > this API not the best, again I would recommend something on these lines:
> > 
> > Hmm: i would really prefer to do the allocation in the caller.
> > If you want your API you could do  just do it as a simple wrapper to
> > the existing function (with the new numpages it would be even 
> > efficient) 
> 
> Using pgprot_t to convey the cacheablity of a page appears to be an
> abuse.  At the very least we need a PAGE_CACHE_MASK, to find just
> the cacheability attributes.

change_page_attr is more than just cachability. You can use it e.g.
to write protect kernel pages not (if you wanted to do that for some
reason) 

The current one is fine with PAGE_KERNEL_NOCACHE, you could eventually
define PAGE_KERNEL_WRITECOMBINING too if you wanted.


> And we should really consider using the other cacheability page
> attributes on x86, not just cache enable/disable.  Using just mtrr's
> is limiting in that you don't always have enough of them, and that
> sometimes valid ram is mapped uncacheable, because of the mtrr
> alignment restrictions. 

Exposing it to user space in a more general way is tricky because
you need to avoid aliases with different caching attributes and also
change the kernel map as needed (would be surely an interesting 
project, but definitely requires more work) 

You can already use WT. DRM does that already in fact. 
Newer Intel/AMD CPUs allow to set up a more general PAT table with some
more modis, but to be honest I don't see the point in most of them,
except perhaps WC. Unfortunately there is no 'weak ordering like alpha/sparc64'
mode that could be used in the kernel :-)

-Andi
