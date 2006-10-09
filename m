Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932612AbWJIMBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbWJIMBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 08:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWJIMBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 08:01:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:39300 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932612AbWJIMBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 08:01:07 -0400
Date: Mon, 9 Oct 2006 14:00:55 +0200
From: Nick Piggin <npiggin@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas@tungstengraphics.com>,
       linux-mm@kvack.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Arnd Bergmann <arnd@arndb.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: User switchable HW mappings & cie
Message-ID: <20061009120055.GD26824@wotan.suse.de>
References: <1160347065.5926.52.camel@localhost.localdomain> <452A35FF.50009@tungstengraphics.com> <1160394662.10229.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160394662.10229.30.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 09:51:01PM +1000, Benjamin Herrenschmidt wrote:
> 
> > I'm very much for this approach, possibly with the extension that we 
> > could have a multiple-page version as well, as populating the whole vma 
> > sometimes may be cheaper than populating each pte with a fault. That 
> > would basically be an io_remap_pfn_range() which is safe when the 
> > mmap_sem is taken in read mode (from do_no_page).
> > 
> > One problem that occurs is that the rule for ptes with non-backing 
> > struct pages
> > Which I think was introduced in 2.6.16:
> > 
> >     pfn_of_page == vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT)
> > 
> > cannot be honored, at least not with the DRM memory manager, since the 
> > graphics object will be associated with a vma and not the underlying 
> > physical address. User space will have vma->vm_pgoff as a handle to the 
> > object, which may move around in graphics memory.
> 
> That's a problem with VM_PFNMAP set indeed. get_user_pages() is a
> non-issue with VM_IO set too but I'm not sure about other code path that
> might try to hit here... though I think we don't hit that if MAP_SHARED,
> Nick ?

No, if you are MAP_SHARED then you shouldn't need to worry about that
indeed. For new code, I don't think it should be painful to avoid writing
to MAP_PRIVATE mappings.

