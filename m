Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275378AbRIZRpC>; Wed, 26 Sep 2001 13:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275377AbRIZRol>; Wed, 26 Sep 2001 13:44:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20236 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275373AbRIZRo3>; Wed, 26 Sep 2001 13:44:29 -0400
Date: Wed, 26 Sep 2001 10:44:14 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "David S. Miller" <davem@redhat.com>, <bcrl@redhat.com>,
        <marcelo@conectiva.com.br>, <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <E15mIfQ-0001E5-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0109261036260.8445-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Sep 2001, Alan Cox wrote:

> > 	PIII:
> > 		nothing: 32 cycles
> > 		locked add: 50 cycles
> > 		cpuid: 170 cycles
> >
> > 	P4:
> > 		nothing: 80 cycles
> > 		locked add: 184 cycles
> > 		cpuid: 652 cycles
>
>
> Original core Athlon (step 2 and earlier)
>		nothing: 11 cycles
>		locked add: 22 cycles
>		cpuid: 67 cycles
>
> generic Athlon:
>		nothing: 11 cycles
>		locked add: 11 cycles
>		cpuid: 64 cycles

Do you have an actual SMP Athlon to test? I'd love to see if that "locked
add" thing is really SMP-safe - it may be that it's the old "AMD turned
off the 'lock' prefix synchronization because it doesn't matter in UP".
They used to have a bit to do that..

That said, it _can_ be real even on SMP. There's no reason why a memory
barrier would have to be as heavy as it is on some machines (even the P4
looks positively _fast_ compared to most older machines that did memory
barriers on the bus and took hundreds of much slower cycles to do it).

> Wait for AMD to publish graphs of CPUid performance for PIV versus Athlon 8)

The sad thing is, I think Intel used to suggest that people use "cpuid" as
the thing to serialize the cores. So people may actually be _using_ it for
something like semaphores. I remember that Ingo or somebody suggested we'd
use it for the Linux "mb()" macro - I _much_ prefer the saner locked zero
add into the stack, and the prediction that Intel would be more likely to
optimize for "add" than for "cpuid" certainly ended up being surprisingly
true on the P4.

		Linus

