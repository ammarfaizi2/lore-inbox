Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261191AbSJCPaf>; Thu, 3 Oct 2002 11:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261706AbSJCPae>; Thu, 3 Oct 2002 11:30:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:783 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261191AbSJCPac>; Thu, 3 Oct 2002 11:30:32 -0400
Date: Thu, 3 Oct 2002 08:37:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jaroslav Kysela <perex@suse.cz>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA fixes #1
In-Reply-To: <Pine.LNX.4.33.0210031207110.521-100000@pnote.perex-int.cz>
Message-ID: <Pine.LNX.4.44.0210030828050.2066-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Oct 2002, Jaroslav Kysela wrote:
> 
> You can import this changeset into BK by piping this whole message to:
> '| bk receive [path to repository]' or apply the patch as usual.

Don't even bother with the BK patches, I've never had them apply
successfulyl for me, because your BK tree contains ChangeSets that simply
do not exist in mine. As a result, your BK patches refuse to apply. Please 
read the BK usage documentation.

Note that BK really only helps if you are careful, and I can synchronize 
with your BK tree. The fact that your BK tree contains non-alsa stuff 
already means that I cannot sync with it, which makes it pretty much 
unusable. But even if that was fixed, what is all the OLD_USB crap, and 
stuff like this:

> ChangeSet@1.676, 2002-10-03 12:03:21+02:00, perex@suse.cz
>   ALSA compilation update
>     - save_flags/cli/restore_flags removal

Don't even bother fixing compilation, if the end result is patches like

> @@ -140,20 +139,18 @@
>  	snd_printdd("sgalaxy - setting up IRQ/DMA for WSS\n");
>  #endif
>  
> -	save_flags(flags);
> -	cli();
> +	/* FIXME: this is really bogus --jk */
> +	/* the irq line is not allocated (thus locked) for this device at the moment */
> +	disable_irq(irq);
>  
>          /* initialize IRQ for WSS codec */
>          tmp = interrupt_bits[irq % 16];
> -        if (tmp < 0) {
> -		restore_flags(flags);
> +        if (tmp < 0)
>                  return -EINVAL;
> -	}
>          outb(tmp | 0x40, port);
>          tmp1 = dma_bits[dma % 4];
>          outb(tmp | tmp1, port);
>  
> -	restore_flags(flags);
>  	return 0;
>  }
>  

It's BETTER to not compile, than have obviously totally bogus code that 
will break _other_ devices in the tree. 

You're disabling (and never re-enabling) an interrupt that isn't even 
YOURS, for chrissake! Which just means that if that irq happens to be 
shared with the harddisk, for example, you just killed the whole machine!

Please, don't do crap like this. Sure, it may be an ISA driver, and if it
has the right irq you may hope that it isn't shared (technically illegal
in ISA, but certainly done nonetheless), but the old code didn't do 
anything even _nearly_ that broken, and the trival spinlock replacement 
should have worked quite as well as the old code ever did.

This, btw, is one reason why I don't like hidden CVS trees that are worked 
on by people that don't know or care about the rest of the kernel - 
because the end result ends up often being total crap, that is hidden by 
large merges. I noticed this one only because the patch was of a 
reasonable size, and I _shudder_ to think of what horrible things the big 
broken merges have caused.

Yes, I'm frustrated. What can we do about things like this? I'll apply the 
patch without the obviously horribly broken part, please don't 
re-introduce it later.

		Linus

