Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315941AbSFESyd>; Wed, 5 Jun 2002 14:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315943AbSFESyc>; Wed, 5 Jun 2002 14:54:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28679 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315941AbSFESya>; Wed, 5 Jun 2002 14:54:30 -0400
Date: Wed, 5 Jun 2002 11:53:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] 4KB stack + irq stack for x86
In-Reply-To: <20020605144357.A4697@redhat.com>
Message-ID: <Pine.LNX.4.33.0206051150320.10556-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Jun 2002, Benjamin LaHaise wrote:
> 
> Ah, you're right.  If anyone uses current_thread_info from IRQ context 
> it will set the flags in the wrong structure.  However, it actually 
> works because nobody does that currently: all of the _thread_flag users 
> appear to be coming in from task context.  Mostly that's luck as I 
> didn't change the smp ipis to switch stacks, so the only place that 
> is an interrupt and needs to access the actual thread data, does.

Hmm..

How about just making the interrupt code (ie do_IRQ()) or in the flags 
into the "parent" flags.

All of the flags should be "sticky one-bits", so just oring them should do 
the right thing.

That way we don't have to add nasty BUG checks to the code, and since 
we're already dirtying both cache-lines the extra overhead should 
literally be just the cost of doing one locked "orl".

			Linus

