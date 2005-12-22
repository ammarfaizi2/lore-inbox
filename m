Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbVLVSXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbVLVSXH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbVLVSXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:23:07 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:47187 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030252AbVLVSXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:23:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=t15QuYVU42urFU4ZVSBWHyehmflD8x5AFIqUqfO0+qqqFl+vbPGmZ2bXUtyi13eLsuar0CaaLNust/2LOXMR8F/D4OSeuyVyewh3pbc5yDMx2rpzleGQecyk+5+q1NB9W0PNkWMhxuYA7QYdb7mUmhDlWPUl0TopkgROQsSkIBg=
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Reply-To: pantelis.antoniou@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] genalloc != generic DEVICE memory allocator
Date: Thu, 22 Dec 2005 20:33:39 +0200
User-Agent: KMail/1.8
Cc: Andrey Volkov <avolkov@varma-el.com>,
       Jes Sorensen <jes@trained-monkey.org>,
       Pantelis Antoniou <panto@intracom.gr>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <43A98F90.9010001@varma-el.com> <yq0d5jpuoqe.fsf@jaguar.mkp.net> <43AAEE12.5030009@varma-el.com>
In-Reply-To: <43AAEE12.5030009@varma-el.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512222033.40156.pantelis.antoniou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 December 2005 20:18, Andrey Volkov wrote:
> Hi Jes,
> 
> Jes Sorensen wrote:
> >>>>>>"Andrey" == Andrey Volkov <avolkov@varma-el.com> writes:
> > 
> > 
> > Andrey> Hello Jes and all I try to use your allocator (gen_pool_xxx),
> > Andrey> idea of which is a cute nice thing. But current implementation
> > Andrey> of it is inappropriate for a _device_ (aka onchip, like
> > Andrey> framebuffer) memory allocation, by next reasons:
> > 
> > Andrey,
> > 
> > Keep in mind that genalloc was meant to be simple for basic memory
> > allocations. It was never meant to be an over complex super high
> > performance allocation mechanism.
> > 
> > Andrey>  1) Device memory is expensive resource by access time and/or
> > Andrey> size cost.  So we couldn't use (usually) this memory for the
> > Andrey> free blocks lists.
> > 
> > This really is irrelevant, the space is only used within the object
> > when it's on the free list. Ie. if all memory is handed out there's
> > no space used for this purpose.
> 
> I point out 2 reasons: ACCESS TIME was first :), let take very
> widespread case: PCI device with some onboard memory and any
> N GHz proc. - result may be terrible: each access to device mem (which
> usually uncached) will slowed down this super fast proc to 33 MHZ, i.e
> same as we made busy-wait with disabled interrupts after each read/write...
> 
> I possible awry when use 'control structures' in 2), I've in view
> allocator's control structures (size/next etc), not device specific
> control structs.
> 
> > 
> > Andrey> 3) Obvious (IMHO) workflow of mem. allocator
> > Andrey> look like: - at startup time, driver allocate some big
> > Andrey> (almost) static mem. chunk(s) for a control/data structures.
> > Andrey> - during work of the device, driver allocate many small
> > Andrey> mem. blocks with almost identical size.  such behavior lead to
> > Andrey> degeneration of buddy method and transform it to the
> > Andrey> first/best fit method (with long seek by the free node list).
> > 
> > This is only really valid for network devices, and even then it's not
> > quite so. For things like uncached allocations your observation is
> > completely off.
> 
> Could you give me some examples? Possible I overlooked something
> significant.
> 
> > 
> > For the case of more traditional devices, the control structures will
> > be allocated from one end of the block, the rest will be used for
> > packet descriptors which will be going in and out of the memory pool
> > on a regular basis. 
> 
> This was main reason why I try to modify genalloc: I needed  in
> generic allocator for both short-live strictly aligned blocks and
> long-live blocks with restriction by size.
> 
> > In most normal cases these will all be of the same
> > size and it doesn't matter where in the memory space they were
> > allocated.
> 
> And thats also why I consider that 'buddy' is not appropriate to be
> 'generic' (most cases == generic, isn't is :)?): when you're allocate
> mainly same sized blocks, 'buddy' degraded to the first-fit.
> 
> Possible solution I see in mixed first-fit with lazy coalescent for
> short lived blocks and first-fit with immediately coalescent for
> long-lived blocks. But, again, I may overlook something significant.
> And, certainly, I could overlooked someone else allocator implementation
> in some driver.
> 
> > 
> > Andrey> 4) The simple binary buddy method is far away from perfect for
> > Andrey> a device due to a big internal fragmentation. Especially for a
> > Andrey> network/mfd devices, for which, size of allocated data very
> > Andrey> often is not a power of 2.
> > 
> snip
> > 
> > Andrey> I start to modify your code to satisfy above demands, but
> > Andrey> firstly I wish to know your, or somebody else, opinion.
> > 
> > I honestly don't think the majority of your demands are valid.
> > genalloc was meant to be simple, not an ultra fast at any random
> > block size allocator. So far I don't see any reason for changing to
> > the allocation algorithm into anything much more complex - doesn't
> > mean there couldn't be a reason for doing so, but I don't think you
> > have described any so far.
> I disagree here, generic couldn't be very simple and slow, because in
> this case simply no one will be use it, and hence we'll get today's
> picture: reimplemented allocators in many drivers.
> 
> > 
> > You mentioned frame buffers, but what is the kernel supposed to do
> > with those allocation wise? If you have a frame buffer console, the
> > memory is allocated once and handed to the frame buffer driver.
> > Ie. you don't need a ton of on demand allocations for that and for
> > X, the memory management is handled in the X server, not by the
> > kernel.
> 
> For video-only device this is true, but if device is a multifunctional,
> which is frequent case in embedded systems, then kernel must control of
> device memory allocation. Currently, however, even video cards for
> desktops become more and more multifunctional (VIVO/audio etc.).
> 
> > 
> > The only thing I think would make sense to implement is to allow it to
> > use indirect descriptor blocks for the memory it manages. This is not
> > because it's wrong to use the memory for the free list, as it will
> > only be used for this when the chunk is not in use, but because access
> > to certain types of memory isn't always valid through normal direct
> > access. Ie. if one used descriptor blocks residing in normal
> > GFP_KERNEL memory, it would be possible to use the allocator to manage
> > memory sitting on the other side of a PCI bus.
> I describe above, why we couldn't/wouldn't use onboard memory for
> allocator specific data.
> 
> Pantelis, Am I answered to your question (...what are you trying to
> do...) too?
>

Yes. rheap seems to cover your cases...
 
> -- 
> Regards
> Andrey Volkov
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

Regards

Pantelis
