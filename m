Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265317AbUGGTMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265317AbUGGTMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 15:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUGGTMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 15:12:49 -0400
Received: from mail-relay-2.tiscali.it ([212.123.84.92]:12782 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S265317AbUGGTMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 15:12:47 -0400
Date: Wed, 7 Jul 2004 21:12:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: mason@suse.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Unnecessary barrier in sync_page()?
Message-ID: <20040707191233.GP28479@dualathlon.random>
References: <20040707175724.GB3106@logos.cnet> <20040707182025.GJ28479@dualathlon.random> <20040707185814.GA3323@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707185814.GA3323@logos.cnet>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Wed, Jul 07, 2004 at 03:58:14PM -0300, Marcelo Tosatti wrote:
> I think this comment on i386 bitops.h can lead to 
> misunderstanding and should be changed:
> 
> /**
>  * set_bit - Atomically set a bit in memory
>  * @nr: the bit to set
>  * @addr: the address to start counting from
>  *
>  * This function is atomic and may not be reordered. 
> 
> "This function is atomic and may not be reordered (other architectures MAY reorder it)"
> 
> Or something like this. The comment as it is leads people to
> write nonportable code which assumes set_bit() cant be reordered. Like naive me did.

agreed. (as usual trusting comments more than code carries some
risk, last time I was fooled by a comment was only a few months ago too
in some device driver ;)

btw, for completeness, test_bit (the one running before sync_page) can
be reordered even in x86.

The only one that enforces ordering everywhere is test_and_set_bit (as
Linus recently reminded on the list too). And it only enforces ordering
if it returns 0. If it returns 1 no ordering is enforced (for example on
alpha) because no change was made to the memory and supposedly the code
will not be allowed to access any critical section (and in turn no need
of any barrier).

> Andrew, what you think about removing that barrier from sync_page() 
> on -mm? 
> 
> And what about changing the "may not reordered" comments on i386 bitops.h
> to "may not be reordered on i386 only, other arches do reorder it." ?

both looks correct to me, thanks.
