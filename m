Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275172AbRJFOMB>; Sat, 6 Oct 2001 10:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275173AbRJFOLw>; Sat, 6 Oct 2001 10:11:52 -0400
Received: from [195.223.140.107] ([195.223.140.107]:52474 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S275172AbRJFOLb>;
	Sat, 6 Oct 2001 10:11:31 -0400
Date: Sat, 6 Oct 2001 16:11:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM deadlock in 2.4.11-pre4 (yes, it's me again :-)
Message-ID: <20011006161148.Z724@athlon.random>
In-Reply-To: <20011006120832.4773192e.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20011006120832.4773192e.skraw@ithnet.com>; from skraw@ithnet.com on Sat, Oct 06, 2001 at 12:08:32PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 06, 2001 at 12:08:32PM +0200, Stephan von Krawczynski wrote:
> Hello,
> 
> the time has come again for my monthly stress-testing of new kernels :-)
> I installed 2.4.11-pre4 and ran it for a day. It was really strange for me to
> see _no_ alloc failures at all, and that's why I gave it a closer look (alan
> fooled me once by deleting the printk, which made the problem "disappear" too
> :-). And here it is (from page_alloc.c):
> 
>  rebalance:
>         page = balance_classzone(classzone, gfp_mask, order, &freed);
>         if (page)
>                 return page;  
> 
>         zone = zonelist->zones;
>         if (likely(freed)) {
>                 for (;;) {
>                         zone_t *z = *(zone++);
>                         if (!z)
>                                 break;
> 
>                         if (zone_free_pages(z, order) > z->pages_min) {
>                                 page = rmqueue(z, order);
>                                 if (page)
>                                         return page;   
>                         }
>                 }
>                 goto rebalance;
>         } else {
>                 /* 
>                  * Check that no other task is been killed meanwhile,
>                  * in such a case we can succeed the allocation.
>                  */
>                 for (;;) {
>                         zone_t *z = *(zone++);
>                         if (!z)
>                                 break;
> 
>                         if (zone_free_pages(z, order) > z->pages_min) {
>                                 page = rmqueue(z, order);
>                                 if (page)
>                                         return page;
>                         }
>                 }
> 
>                 goto rebalance;
>         }
> 
>         printk(KERN_NOTICE "%s __alloc_pages: %u-order allocation failed
> (gfp=0x%x/%i) from %p\n",
>                current->comm, order, gfp_mask, !!(current->flags &
> PF_MEMALLOC), __builtin_return_address(0));
> /* my stuff :-) */
>         if (order==0)
>                 show_trace(NULL);
>         return NULL;
> }
> 
> 
> As you can see I patched some more info output on certain alloc-failures. But
> unfortunately I did not read the lines above - up to now. As you can see the
> printk cannot be reached at all, because both if-cases jump to rebalance - not
> matter how comes.
> When I wrote the first version of this posting, I wrote: this looks like a
> possible deadlock to me, because it cycles forever when no pages are found. I
> proved myself right this time, because when I tried to send the mail and
> started a CD burn at the background, the host froze. As you may remember the CD
> burns always gave me alloc-failures during startup in earlier kernel versions.
> So it is pretty obvious I reached the deadlock this time.

You may want to read the email I sent yesterday (attached).

> Another thing I would like to kindly ask: what is the difference in the two if
> branches? As I cannot read really well (already proven in another thread :-), I

Obviously no difference, but that's nothing compared to the deadlock.

> am very willing to accept any explanation on this code ;-)
> If someone else has asked the whole thing before: shoot me.
> 
> Regards,
> Stephan


Andrea

--6TrnltStXW4iwmi0
Content-Type: message/rfc822
Content-Disposition: inline

Date: Fri, 5 Oct 2001 14:06:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: 2.4.11pre4 and oom
Message-ID: <20011005140600.G724@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc

as far I can tell the oom patch you included in pre4 can deadlock the
machine during oom. Obviously, think if the oom-selected task is looping
trying to free memory, it won't care about the signal you sent to it.
This ignoring the fact it can be in D state and the fact oom() cannot
know know when we're oom or not by only looking at the incomplete stats
anyways.

Now it's obvious you don't care and that most people won't notice the
problem (and the problem is always been in -ac VM too most probably for
ages and again nobody is complaining) and that it is going to cure the
oom faliures and that we could just ignore any seldom oom deadlock
bugreport with Ben's argument that people shouldn't run oom in first
place, but despite of this I prefer not to take that route in -aa
because I strongly believe that people is allowed to run oom without
turning down the machine, infact I also dislike the PF_MEMALLOC logic
that doesn't mathematically "guarantee" that there's enough memory to
"release memory", there should be proper reservation done by each
filesystem that can be involved in the ram freeing (like we do with
highmem), but ok, that's invasive change so I'm living with PF_MEMALLOC
for now, let's assume there's really enough memory in the pf_memalloc
reserved pool.

Andrea

--6TrnltStXW4iwmi0--
