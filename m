Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316640AbSFFBPo>; Wed, 5 Jun 2002 21:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSFFBPn>; Wed, 5 Jun 2002 21:15:43 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:11222 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316640AbSFFBPi>; Wed, 5 Jun 2002 21:15:38 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: lord@sgi.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        bcrl@redhat.com
Subject: Re: [RFC] 4KB stack + irq stack for x86
In-Reply-To: <20020604225539.F9111@redhat.com> <1023315323.17160.522.camel@jen.americas.sgi.com> <20020605183152.H4697@redhat.com> <20020605.161342.71552259.davem@redhat.com>
From: Andi Kleen <ak@muc.de>
Date: 06 Jun 2002 03:15:17 +0200
Message-ID: <m3d6v5mcm2.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> I agree with Ben, if things explode due to stack overflow with his
> changes they are almost certain to explode before his changes.

Things can explode anyways as handle_irq_event does __sti even when you have
zero stack left. And there can be always another interrupts. But it doesn't 
happen that often in practice as you suggest.

So either fix it completely which would be adding stack checking to 
do_IRQ (and not __sti when you have less than a few hundred bytes left) or 
ignore the case as it doesn't seem to happen in practice regularly
(at least I've never seen it and I see quite a lot of crashes) 

Interrupt stack doesn't fix the fundamental problem. It only makes it less
likely to hit. Crippling user context code for this doesn't seem to be helpful
at least for i386 (although I would prefer it for x86-64 because the 8K 
stack even without interrupts is rather tight for 64bit). But still I would
likely prefer to enlarge the x86-64 stack than to see useful software
not working because of this.

The scenario Steve outlined was rather optimistic - more pessimistic
case would be e.g:
you run NBD which calls the network stack with an complex file system on top
of it called by something else complex that does a GFP_KERNEL alloc and VM 
wants to flush a page via the NBD file system - I don't see how you'll ever 
manage to fit that into 4K.

-Andi

