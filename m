Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbUKKVrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbUKKVrL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 16:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbUKKVrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 16:47:10 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:64899
	"EHLO x30.random") by vger.kernel.org with ESMTP id S262369AbUKKVpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 16:45:52 -0500
Date: Thu, 11 Nov 2004 22:45:50 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Nick Piggin <piggin@cyberone.com.au>, Rik van Riel <riel@redhat.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
Message-ID: <20041111214550.GB5138@x30.random>
References: <20041111112922.GA15948@logos.cnet> <20041111154238.GD18365@x30.random> <20041111123850.GA16349@logos.cnet> <20041111165050.GA5822@x30.random> <20041111135614.GB16349@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111135614.GB16349@logos.cnet>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 11:56:14AM -0200, Marcelo Tosatti wrote:
> It does get it right. It only triggers OOM killer if _both_ 
> GFP_DMA / GFP_KERNEL are full _and_ there is a task failing 
> to allocate/free memory.

you should check for highmem too before killing the task.

> I think you missed the "task_looping_oom" variable in the patch, which is
> set as soon as a task is unable to allocate/free memory. This variable
> is set where the code used to call the OOM killer.

why do you use a global variable to pass a message from the task context
to kswapd, when you can do the real thing in the task context since the
first place?

> But still, the main idea is valid here.

Putting the oom killer in kswapd is just flawed. I recall somebody
already put it in kswapd in the old days, but that can't work right in
all scenarios.

The single fact you had to implement the task_looping_oom variable,
means you also felt the need to send some bit of info to kswapd from the
task context, then why don't you do the real thing from the task
context where you've a load of additional information to know exactly
what to do in the first place instead of adding global variables?

> I'll say this again just in case: If ZONE_DMA and ZONE_NORMAL reclaiming 
> efforts are in vain, and there is task which is looping on try_to_free_pages() 
> unable to succeed, _and_ both DMA/normal are below pages_min, the OOM 
> killer will be triggered.

the oom killer must be triggered even if only ZONE_DMA is under page_min
if somebody allocates with __GFP_NOFAIL|GFP_DMA. Those special cases
don't make much sense to me. The only one that can know what to do is
the task context, never kswapd. And I don't see the point of using the
task_looping_oom variable when you can invoke the oom killer from
page_alloc _after_ checking the watermarks again with lowmem_reserve
into the equation (something that sure kswapd can't do, unless you pass
more bits of info than just a 0 or 1 via task_looping_oom).

> (should be pages_min + higher protection).

higher protection requires you to define the classzone where the task is
allocating from, only the task context knows it.

> > Plus you're checking for all zones, but kswapd cannot know that it
> > doesn't matter if the zone dma is under pages_min, as far as there's no
> > GFP_DMA.
> 
> You mean boxes with no DMA zone?

I mean GFP_DMA as an allocation from the DMA classzone. If nobody
allocates ram passing GFP_DMA to alloc pages, nobody should worry or
notice if the GFP_DMA is under pages_min, because no allocation risk to
fail.

The oom killing must be strictly connected with a classzone allocation
failing (the single zone doesn't matter) and if nobody uses GFP_DMA it
doesn't matter if the dma zone is under pages_min.

2.4 gets all of this perfectly right and for sure it's not even remotely
attempting at killing anything from kswapd (and infact there's not a
single bugreport outstanding). all it can happen in 2.4 is some wasted
cpu while kswapd tries to do the paging, but exactly because kswapd is
purerly an helper (like 2.6 right now too and I don't want to change
this bit, since kswapd in 2.6 looks sane, much saner than the task
context itself which is the real problematic part that needs fixing),
nothing risk to go wrong (you can only argue about performance issues
when the dma zone gets pinned and under watermark[].min ;).

> If the task chooses to return -ENOMEM it wont set "task_looping_oom"
> flag. 
> 
> OK - you are right to say that "only the context of the task can choose
> to return -ENOMEM or invoke the oom killer". 
> 
> This allocator-context-only information is passed to kswapd via
>  "task_looping_oom".

what's the point of passing info to kswapd? why don't you schedule a
callback instead, why don't you use keventd instead of kswapd? I just
don't get what benefit you get from that except form complexity and
overhead. And to do it right right like this you'd need to pass more
than 1 bit of info.

I mean, one could even change the code to send the whole task
information to an userspace daemon, that will open a device driver and
issue an ioctl that eventually calls the oom killer on a certain pid, in
order to invoke the oom killer. I just don't see why to waste any effort
with non trivial message passing when the oom killer itself can be
invoked by page_alloc.c where all the watermark checks are already
implemented, without passing down information to some random kernel
daemon.

> Good luck!

thanks! ;)
