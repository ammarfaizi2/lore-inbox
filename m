Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318175AbSGYBNR>; Wed, 24 Jul 2002 21:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318200AbSGYBNR>; Wed, 24 Jul 2002 21:13:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11537 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318175AbSGYBNQ>; Wed, 24 Jul 2002 21:13:16 -0400
Date: Wed, 24 Jul 2002 18:17:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Greg KH <greg@kroah.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810_audio.c cli/sti fix
In-Reply-To: <20020725003735.GA12682@kroah.com>
Message-ID: <Pine.LNX.4.44.0207241815120.4293-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Wed, 24 Jul 2002, Greg KH wrote:
>
> Here's a small patch to get the i810_audio.c driver working again.

Hmm..

> @@ -2814,15 +2814,15 @@
>  		}
>  		dmabuf->count = dmabuf->dmasize;
>  		outb(31,card->iobase+dmabuf->write_channel->port+OFF_LVI);
> -		save_flags(flags);
> -		cli();
> +		local_irq_save(flags);
> +		local_irq_disable();

First off, "local_irq_save()" does both the save and the disable (the same
way "spin_lock_irqsave()" does), it's the "local_save_flags(") that is
equivalent to the old plain save_flags. So this should just be

	local_irq_save(flags);

However, I also wonder if the code doesn't want any SMP locking? Is it ok
to just make it a non-spinlock local interrupt disable, and if so, why?

		Linus

