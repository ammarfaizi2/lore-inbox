Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293275AbSB1KTu>; Thu, 28 Feb 2002 05:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293251AbSB1KRf>; Thu, 28 Feb 2002 05:17:35 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47121 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293236AbSB1KRL>; Thu, 28 Feb 2002 05:17:11 -0500
Date: Thu, 28 Feb 2002 11:17:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Jose' Manuel Pereira" <jmp@ist.utl.pt>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18/swsusp bugs
Message-ID: <20020228101705.GE4760@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020219194154.GA2054@elf.ucw.cz> <200202201702.g1KH2YR05704@fuji.home.perso> <15477.26769.969651.333984@saladd2.ist.utl.pt> <20020222020202.GC30638@atrey.karlin.mff.cuni.cz> <15478.33963.155227.154314@saladd2.ist.utl.pt> <20020222185606.GC1351@atrey.karlin.mff.cuni.cz> <15478.49275.3087.824024@saladd2.ist.utl.pt> <20020223212820.GA943@elf.ucw.cz> <15485.22755.869916.466453@saladd2.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15485.22755.869916.466453@saladd2.ist.utl.pt>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   PM> flush_tlb_global() is not called, so vmalloc-ed areas might be wrong. 
>   PM> [reloading cr3 is not enough on machines with GLOBAL bit in cr4].
>   >> My PC has a Pentium. I'll have to fetch th Intel manuals to know what's
>   >> at stake here, sorry.
> 
>   PM> Basically Pentium+ do not do tlb flush on cr3 reload. You mostly need to
>   PM> do __flush_tlb_global() after each cr3 reload to make sure it really
>   PM> does that. This lead to random memory corruption after *many* cycles for
>   PM> me.
> 
> Alright, read the docs and indeed Pentium (I) does not have the PGE bit (does
> not support common TLB entries). Probably the Pentium MMX does support that.
> 
> Anyway, from the docs:
> 
> "* When writing to control register CR3, all non-global TLB entries are flushed "
> 
> - But the global entries don't need to be flushed, they're global exactly for
> that, right? Not right?...

Well, global entries are for things common to all processes, like
vmalloced area. But you are just booting different kernel, which has
different vmalloced areas.

>   PM> software_resume is called after mounting root. mount_root() will do
>   PM> journal replay and kernel will find disk in other state than it
>   PM> expected. Bad.
>   >> No that bad, in fact. The worst that can happen is the replay being done
>   >> twice. In a correct implementation, that is. There is always the chance
>   >> of bugs in the journal implementation...
> 
>   PM> So what happens is * kernel works, prepares some work into the journal *
>   PM> suspend/resume cycle, work in journal is actually done * kernel might be
>   PM> pretty confused here, as its disk state changed below it...
> 
> The kernel isn't confused, is just unaware that it just writes again the state
> that's in fact (well, supposedly) already on disk.

I'm not sure this is safe.

>   >> But the resume process might be started just as in the recent versions, I
>   >> guess.
> 
>   PM> ???
> 
> I mean, the "resume=/dev/bla" thing.

Okay, I wanted to make sure noone uses old swapon method.

>   PM> It does not do anything with ide driver, which might lead to data
>   PM> corruption. Imagine DMA going on during resume.
>   >> Not likely, since all processes (user and kernel) are supposed to be
>   >> stopped by (seconds before) suspend time. The only DMA activity at
>   >> suspend time is by kswapd/kflushd (forgot the name in 2.2) -- to write
>   >> the pages to the swap partition.
> 
>   PM> Well, "not likely" is right. I wanted to make sure it is "not possible".
> 
> That can probably be done by going over all disk drivers and understanding how
> they guarantee all (DMA) transactions are over. 

Yep. That's what I'm going to do.

>   >> At resume, only init and kswapd/whatever are runnable. But the swapon
>   >> that triggers resume must be called as soon as possible, of course, to
>   >> reduce the chance of having other processes started BEFORE resume and
>   >> screwing up disk state. Or starting DMA activities that might collide
>   >> w/resume!
> 
>   PM> Yep, exactly. And you can't easilly tell *when* it is "soon enough" to
>   PM> start swapon. So I killed resume-on-swapon as dangerous by design.
> 
> Alright, but provided that trying to resume from a non-suspend swap doesn't
> crash anything...

Do you stop all user processes before doing resume, for example?

>   PM> BTW usb (uhci) controllers do DMA, even if idle. Do you have uhci
>   PM> controller in your system? Network cards also do it.
> 
> Those examples are good. To prove that they don't affect the suspend/resume
> process: ;-)
> 
> - They do interrupt and start asynchronous memory transactions.
> 
> - But, they only affect their own buffers (well, with zero-copy net drivers,
> it may be more complicated than that...)

But that might be problem at resume. Imagine uhci has buffers at
0x12345678, but in image being resumed, /bin/bash is at
0x12345678. Then you have a problem.

> How about disabling interrupts except for the swap disk driver? Just a
> thought...

You don't easily know which one is it.
									Pavel
[swsusp list no longer works, doing cc to l-k.]
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
