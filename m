Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVGZNf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVGZNf5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 09:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVGZNf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 09:35:57 -0400
Received: from [194.90.237.34] ([194.90.237.34]:4460 "EHLO mtlex01.yok.mtl.com")
	by vger.kernel.org with ESMTP id S261772AbVGZNfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 09:35:55 -0400
Date: Tue, 26 Jul 2005 16:35:53 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Hugh Dickins <hugh@veritas.com>
Cc: Roland Dreier <roland@topspin.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH repost] PROT_DONTCOPY: ifiniband uverbs fork support
Message-ID: <20050726133553.GA22276@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050719165542.GB16028@mellanox.co.il> <20050725171928.GC12206@mellanox.co.il> <Pine.LNX.4.61.0507261312460.16985@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507261312460.16985@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hugh!
Thanks for the comments.

Quoting Hugh Dickins <hugh@veritas.com>:
> Subject: Re: [PATCH repost] PROT_DONTCOPY: ifiniband uverbs fork support
> 
> On Mon, 25 Jul 2005, Michael S. Tsirkin wrote:
> > 
> > This patch adds PROT_DONTCOPY to mmap and mprotect, to set VM_DONTCOPY on vma.
> > This is needed for infiniband userspace i/o, where we need to protect against
> >   - the child process accessing the parent hardware page
> >   - the parent registered address (on which the driver did get_user_pages)
> >     getting remapped to another page by COW
> > One can imagine other uses, e.g. combined with mlock for real-time or security.
> 
> I don't much like it, but it does solve a real problem in an efficient way.
> 
> Partly I don't like it because of "PROT_DONTCOPY" itself: I'm queasy
> about protection flags which are not protection flags, though I find
> you're not the first to go down that road.

Yes. Compare with PROT_GROWSDOWN and such.

> Is the patch tested?  I've not tried, but suspect the newflags shift
> and mask won't work for it.

I tested this patch. I didnt test all thinkable configurations of
flags though - what do you mean by "newflags shift and mask"?

> And I don't look forward to your adding
> VM_MAYDONTCOPY - ugh!

We already have VM_DONTCOPY. Why would we need VM_MAYDONTCOPY and what
would it do?

>
>
> > @@ -246,7 +246,7 @@ sys_mprotect(unsigned long start, size_t
> >  			goto out;
> >  		}
> >  
> > -		newflags = vm_flags | (vma->vm_flags & ~(VM_READ | VM_WRITE | VM_EXEC));
> > +		newflags = vm_flags | (vma->vm_flags & ~(VM_READ | VM_WRITE | VM_EXEC | VM_DONTCOPY));
> >  
> >  		if ((newflags & ~(newflags >> 4)) & 0xf) {
> >  			error = -EACCES;
> 
> I rather think it would all be more cleanly handled by dropping the mmap
> and mprotect changes,

Well, mmap would be much better off if VM_DONTCOPY is set atomically, since
a process may fork after mmap is called but before madvise.

> adding an madvise instead.

I'm not opposed to this, on principle. But see below.

> Though you may object
> that madvise is for optional behaviours, and this should be mandatory.

What about a new system call?
Or a flag for mprotect that effectively turns it into a new system call?
Something like PROT_EXTENDED?

> The other reason I dislike the patch is that the problem it fixes is
> an old one, and I'd much rather have get_user_pages fix it for itself,

Please note that the problem this attempts to solve is not limited
to pages locked by get_user_pages: in an infiniband userspace initiator,
a hardware page is mapped into process memory and must not be inherited
by a child processes, otherwise hardware protection breaks.

> than ask the developer to do some additional magic to get around it.
>
> But I've failed to work out a simple efficient alternative, which won't
> burden the vast majority of get_user_pages usages which never hit the
> issue.

They dont hit it if they keep the mm semaphore, or if they only lock
pages for read.

> So your way is probably appropriate, but I'd prefer madvise.

The difficulty with changing get_user_pages, as I see it, is that
you wont be able to get away with a single DONTCOPY bit - you'll need
a full reference count for each page, no less.

> (Sorry, I won't be able to discuss further for a couple of days.)
> 
> Hugh
> 

Well, madvise currently cant break/merge VMAs, which is required
for VM_DONTCOPY. And it seems like making madvise do this opens
a whole cans of worms.

Hugh, so the patch is likely to be bigger in the madvise approach.
Considering this, and the fact that a full solution has to add
a flag to mmap, anyway, do you still think madvise is really the best way
to do it?


Regarding solving the problem automagically by get_user_pages:

What about a new VM_COPYONFORK flag, to trigger the old unix
behaviour of copying the vma on fork and a flag for get_user_pages that sets it?
Only users that dont keep the mm semaphore around
the get_user_pages/put_page operation would use this flag, others
would be unaffected. The flag will stay on until the VMA is destroyed.

MST


-- 
MST
