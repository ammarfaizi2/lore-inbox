Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280192AbRKIVxs>; Fri, 9 Nov 2001 16:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280195AbRKIVxi>; Fri, 9 Nov 2001 16:53:38 -0500
Received: from pc-62-31-92-151-az.blueyonder.co.uk ([62.31.92.151]:50671 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S280192AbRKIVx3>; Fri, 9 Nov 2001 16:53:29 -0500
Date: Fri, 9 Nov 2001 21:52:08 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Using %cr2 to reference "current"
Message-ID: <20011109215207.A10891@kushida.jlokier.co.uk>
In-Reply-To: <Pine.LNX.4.33.0111060918380.2194-100000@penguin.transmeta.com> <E161Ap8-0001Gf-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E161Ap8-0001Gf-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Nov 06, 2001 at 06:19:46PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> True enough, but then we can go to
> 
> 	andl %%esp, %0
> 	movl (%%eax), %%eax
> 
> which doesnt really change the cost much, lets us colour the task structs
> nicely, and lets us colour the stack somewhat by offseting esp from the base
> - and all in standard instructions

A variant lets you put the pointer at the top of the stack, where it can
sometimes share a cache line with the freshly pushed context:

	movl $0x1ffc,%0
	orl %esp,%0
	movl (%0), %0

This works because GCC keeps the stack aligned to 4 bytes at all times,
I believe.

Both this simple sequence, and Alan's code, suffer from the problem that
the pointer itself is not cache-coloured, but it is a lot better than
having the whole context and task state on the same colour.

This perhaps be improved using Linus' idea of shifting upper address
bits to colour the pointer as well.

-- Jamie

