Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268212AbUIKREq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268212AbUIKREq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268214AbUIKREq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:04:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:38089 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268212AbUIKRDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:03:32 -0400
Date: Sat, 11 Sep 2004 10:02:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeon-pre-2
In-Reply-To: <9e47339104091109111c46db54@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org>
References: <9e47339104090919015b5b5a4d@mail.gmail.com> 
 <9e47339104091008115b821912@mail.gmail.com>  <1094829278.17801.18.camel@localhost.localdomain>
  <9e4733910409100937126dc0e7@mail.gmail.com>  <1094832031.17883.1.camel@localhost.localdomain>
  <9e47339104091010221f03ec06@mail.gmail.com>  <1094835846.17932.11.camel@localhost.localdomain>
  <9e47339104091011402e8341d0@mail.gmail.com>  <Pine.LNX.4.58.0409102254250.13921@skynet>
  <20040911132727.A1783@infradead.org> <9e47339104091109111c46db54@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Sep 2004, Jon Smirl wrote:
>
> The resource reservation conflicts are already solved in the current
> DRM code. Most of the changes are in kernel and the rest are in the
> pipeline.  DRM loads in two modes, primary where it behaves like a
> normal Linux driver and stealth where it uses the resources without
> telling the kernel. Stealth/primary mode is a transition tool until
> things get fixed. Once everything is sorted out stealth mode can be
> removed.

I _think_ Alan's argument is that this isn't about the resource 
reservation conflicts. In many ways resource reservations don't much
matter, since for PCI devices the kernel can (and does) make sure that 
nobody else stomps on that particular IO range anyway.

So to some degree the real issue is not so much about who "owns" the 
device: clearly nobody _can_ "own" it, as there are multiple drivers that 
do want to access it. So the real issue is about how to serialize the 
existing multiple "owners".

At least this is where I _think_ Alan is coming from. You're been an 
argumentative bunch, it's hard to tell in between all the flamage ;)

> Think of this as having the shared resource platform code in the DRM
> driver. This shared platform knows how to load DRM. The next step is
> to teach it how to load fbcon. Final step is to integrate the chip
> specific code from DRM and fbdev.

Again, I think you're thinking about the problem from two fundamentally 
different standpoints. 

Jon, you want to get to that "Final step is to integrate the chip specific
code from DRM and fbdev". Alan doesn't even want to get there. I think 
Alan just wants some simple infrastructure to let everybody play together.

(Hey, at this point everybody will jump at me and tell me I'm taking
lessons from Hans, and that I'm totally misrepresenting what people want.  
"Bring it on", as those stupid US politicians would say).

So look at this another way: maybe we do _not_ want to integrate any code. 
It's ok to have fbdev/fbcon/X/DRM all sharing the same device. The only 
thing we need is something to serialize the damn things with.

My personal preference for this whole mess has always been the "silly 
driver" that isn't even hardware-specific, and really does _nothing_ on 
its own. This one would be the only thing that actually reserves the IO 
regions and "owns" the card from the respect of the resources. EVERYBODY 
else would be a "stealth" driver. Not just DRM.

And the drivers would never become non-stealth. They'd stay as stealth 
drivers, and just use the silly hardware-independent thing as a way to 
serialize themselves.

So what does the hw-independent thing need to do?

 - locking. This is the first-order problem, and maybe it never even needs 
   to go beyond this stage. If DRM can say "I want to own the 
   accelerator", and others will wait for it, then that's already a big 
   step forward.

   Implementation: have a data structure with <n> different pointers to
   locks, for each independent function you can think of that somebody
   would want exclusive access over. "accelerator" "modeswitch" 
   "framebuffer" "memory alloc" whatever.

   Now, the reason why these things are _pointers_ to locks rather than 
   locks themselves is that maybe some hardware ends up sharing resources 
   between these things (maybe "modeswitch" needs the accelerator to 
   work), and then they have to use the same lock. Fine - just make the
   pointer point to that lock. The hardware-independent part doesn't even 
   need to _know_ about this: it just sets up all <n> locks as being
   independent, and then the low-level drivers can move the lock pointers 
   around since _they_ know what the rules are.

   Or something like this.

 - memory allocation. Many of these issues really are generic, and once 
   you have the locking setup done, maybe you can have a generic memory
   allocation layer for splitting up AGP memory or whatever. See the 
   "dma_declare_coherent_memory()" interfaces that James Bottomley did for 
   some SCSI devices that have on-board memory that they want to let the 
   kernel allocate as DMA'able.

   In fact, maybe the existing _general_ dma_declare_coherent_memory() 
   interfaces can be enhanced enough that the drivers can just use that
   directly. See Documentation/DMA-API.txt for some docs (it's very 
   limited right now, because nobody _needs_ any more, but it already has 
   support for "if you can't find memory directly on the card, allocate
   some from system RAM instead" kind of operations).

Anyway, please stop the flamage. It all sounds like you're arguing across 
each other. Now you can flame me instead, but please try to direct the 
flamage to specific points so that I don't get the feeling that you're 
talking about something else..

		Linus
