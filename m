Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSFPKSu>; Sun, 16 Jun 2002 06:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316079AbSFPKSt>; Sun, 16 Jun 2002 06:18:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52837 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S316070AbSFPKSs>; Sun, 16 Jun 2002 06:18:48 -0400
To: Andi Kleen <ak@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org,
        Richard Brunner <richard.brunner@amd.com>, mark.langsdorf@amd.com
Subject: Re: another new version of pageattr caching conflict fix for 2.4
In-Reply-To: <20020613221533.A2544@wotan.suse.de>
	<20020613210339.B21542@redhat.com>
	<20020614032429.A19018@wotan.suse.de>
	<20020613213724.C21542@redhat.com>
	<20020614040025.GA2093@inspiron.birch.net>
	<20020614001726.D21542@redhat.com>
	<20020614062754.A11232@wotan.suse.de>
	<20020614112849.A22888@redhat.com>
	<20020614181328.A18643@wotan.suse.de>
	<20020614173133.GH2314@inspiron.paqnet.com>
	<20020614200537.A5418@wotan.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Jun 2002 04:08:49 -0600
Message-ID: <m17kkzv8lq.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Fri, Jun 14, 2002 at 12:31:33PM -0500, Andrea Arcangeli wrote:
> > On Fri, Jun 14, 2002 at 06:13:28PM +0200, Andi Kleen wrote:
> > > +#ifdef CONFIG_HIGHMEM
> > > +	/* Hopefully not be mapped anywhere else. */
> > > +	if (page >= highmem_start_page) 
> > > +		return 0;
> > > +#endif
> > 
> > there's no hope here. If you don't want to code it right because nobody
> > is exercising such path and flush both any per-cpu kmap-atomic slot and
> > the page->virtual, please place a BUG() there or any more graceful
> > failure notification.
> 
> Ok done. 
> 
> I also removed the DRM change because it was buggy. I'm not 100% yet
> it is even a problem. Needs more investigation.
> 
> BTW there is another corner case that was overlooked:  
> mmap of /dev/kmem, /proc/kcore, /dev/mem. To handle this correctly 
> the mmap functions would need to always walk the kernel page table
> and force the correct caching attribute in the user mapping.
> But what to do when there is already an existing mapping to user space?

Don't allow the change_page_attr if page->count > 1 is an easy solution,
and it probably suffices.  Beyond that anything mmaped can be found
by walking into the backing address space, and then through the
vm_area_structs found with i_mmap && i_mmap_shared.  Of course the
vm_area_structs may possibly need to break because of the multiple
page protections.

> > > +int change_page_attr(struct page *page, int numpages, pgprot_t prot)
> > > +{
> > 
> > this API not the best, again I would recommend something on these lines:
> 
> Hmm: i would really prefer to do the allocation in the caller.
> If you want your API you could do  just do it as a simple wrapper to
> the existing function (with the new numpages it would be even 
> efficient) 

Using pgprot_t to convey the cacheablity of a page appears to be an
abuse.  At the very least we need a PAGE_CACHE_MASK, to find just
the cacheability attributes.

And we should really consider using the other cacheability page
attributes on x86, not just cache enable/disable.  Using just mtrr's
is limiting in that you don't always have enough of them, and that
sometimes valid ram is mapped uncacheable, because of the mtrr
alignment restrictions. 

Eric
