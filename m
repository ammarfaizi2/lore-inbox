Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285454AbRLGKWn>; Fri, 7 Dec 2001 05:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284037AbRLGKW2>; Fri, 7 Dec 2001 05:22:28 -0500
Received: from pixar.pixar.com ([138.72.10.20]:64244 "EHLO pixar.pixar.com")
	by vger.kernel.org with ESMTP id <S285454AbRLGKWR>;
	Fri, 7 Dec 2001 05:22:17 -0500
Date: Fri, 7 Dec 2001 02:22:11 -0800 (PST)
From: Kiril Vidimce <vkire@pixar.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ldt allocation failed
Message-ID: <Pine.LNX.4.21.0112070220590.20941-100000@tombigbee.pixar.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ----------
Date: Fri, 07 Dec 2001 10:18:59 GMT
From: Ludo Stellingwerff <ludost@zonnet.nl>
To: Kiril Vidimce <vkire@pixar.com>
Subject: Re: ldt allocation failed

Okay,

I have found another failure path leading to the failure message:

vmalloc -> vmalloc_area_pages -> alloc_area_pmd -> pte_alloc

This pte_alloc temporarily releases a spinlock on the mm_pagetable. If 
at the same time another processor handles a vmalloc too, a race 
condition can surface. A check is done for this to happen. In that case 
a NULL allocation will be returned through the same path. This triggers 
the message.

This is a kernel bug as a more decent failure mechanism should be in 
place. Something like a retry to allocate a page table entery.

Does this make sense?
Please forward this message to the kernel list, I am not on the list 
and can't reply to the thread. 


Hope it helps,

Ludo Stellingwerff

----- Origineel Bericht -----
Van: Kiril Vidimce <vkire@pixar.com>
Datum: Vrijdag 7 December 2001 10:23
Onderwerp: Re: ldt allocation failed

> On Fri, 7 Dec 2001, Ludo Stellingwerff wrote:
> > I'm no experienced kernel hacker, but I like to try to help you.
> > 
> > I am a bit frustrated with some of the kernel people too easily 
> > yelling: 
> > "Sorry, we do not have the source to NVIDIA's driver, so we 
> cannot help 
> > you debug this problem. Please contact NVIDIA support."
> > It could well be a kernel problem, IMO.
> > 
> > It looks like you have some process eating all your 2 GB's. The 
> error 
> > message is generated within the architecture specific part of 
> the 
> > process handling. It is triggered if memory allocation failes 
> for 
> > ldt's. Sorry I still don't know what they are, but if necessary 
> I will 
> > findout:)
> > These ldt's need 65536 bytes of memmory. It seems you're machine 
> ran 
> > out of memory.
> > 
> > The 10 to 15 seconds delay in 2.4.9 seems to correspond with the 
> OOM 
> > (Out of Memory kicker). Some processes are stoped to provide 
> extra 
> > memory space.
> > In 2.4.3 the OOM didn't work IIRC.
> > 
> > Are there any processes that seem to use lot's of memory? Can 
> you 
> > reproduce the problem without the NVidia module loaded? 
> > 
> > Hope this helps,
> 
> Hi Ludo,
> 
> This seems to be happening on a variety of machines with a variety
> of software running on it. I seriously doubt it that some app
> is actually running out of memory since I had it happen even
> on a machine that basically only had netscape running on it. The
> machines have 2 GB of RAM so it would be hard to run out of memory
> just with X, Gnome and netscape running (netscape wasn't even
> really active; it happened while it was starting up).
> 
> Thanks for the mail anyway.
> 
> KV
> --
>  ___________________________________________________________________
>  Studio Tools                                        vkire@pixar.com
>  Pixar Animation Studios                        http://www.pixar.com/

