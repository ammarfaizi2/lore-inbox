Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262817AbSJFAB4>; Sat, 5 Oct 2002 20:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262818AbSJFAB4>; Sat, 5 Oct 2002 20:01:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12040 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262817AbSJFABz>; Sat, 5 Oct 2002 20:01:55 -0400
Date: Sat, 5 Oct 2002 17:09:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Peter Osterlund <petero2@telia.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
In-Reply-To: <m2r8f47af4.fsf@p4.localdomain>
Message-ID: <Pine.LNX.4.44.0210051659530.1587-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Oct 2002, Peter Osterlund wrote:
>
> My PCMCIA network card no longer works. During boot, I see this
> message:
> 
>         ds: no socket drivers loaded
> 
> It worked in 2.5.39. Also this patch helps, although I don't
> understand why it is now needed:

The PCMCIA code does initializations in the wrong order, and
asynchronously (ie from multiple different threads). And init_pcmcia_ds()  
really depends on the actual low-level drivers having had time to
register, since the PCMCIA code never had any sane way to inform the DS 
layer that a new client driver had registered. 

Thus the delay by init_pcmcia_ds() - to give time for drivers to 
initialize. And the yenta driver needs some time.. That time apparently 
went up a bit, probably due to the tq/work changes.

The _right_ thing to do is to not have init_pcmcia_ds() depend on 
low-level drivers being initialized, but instead do that DS thing 
_early_, and then when each driver initializes it would tell the DS layer. 
But that's not how the PCMCIA code was organized..

		Linus

