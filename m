Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTH3NJa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 09:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTH3NJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 09:09:30 -0400
Received: from mrt-lx1.iram.es ([150.214.224.59]:17105 "EHLO mrt-lx1.iram.es")
	by vger.kernel.org with ESMTP id S261670AbTH3NJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 09:09:28 -0400
Date: Sat, 30 Aug 2003 13:09:14 +0000
From: Gabriel Paubert <paubert@iram.es>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: insecure <insecure@mail.od.ua>, "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] gcc3 warns about type-punned pointers ?
Message-ID: <20030830130914.A3041@mrt-lx1.iram.es>
References: <200308300537.49700.insecure@mail.od.ua> <Pine.LNX.4.44.0308301427320.3338-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308301427320.3338-100000@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 02:33:08PM +0200, Mikulas Patocka wrote:
> > > A collateral question: why is the reason for this function ?
> > > long long assignments are not atomic in gcc ?
> >
> > Another question: why do we do _double_ store here?
> >
> > static inline void __set_64bit (unsigned long long * ptr,
> >                 unsigned int low, unsigned int high)
> > {
> >         __asm__ __volatile__ (
> >                 "\n1:\t"
> >                 "movl (%0), %%eax\n\t"
> >                 "movl 4(%0), %%edx\n\t"
> >                 "lock cmpxchg8b (%0)\n\t"
> >                 "jnz 1b"
> >                 : /* no outputs */
> >                 :       "D"(ptr),
> >                         "b"(low),
> >                         "c"(high)
> >                 :       "ax","dx","memory");
> > }
> >
> > This will execute expensive locked load-compare-store operation twice
> > almost always (unless previous value was already equal
> > to the value we are about to store)
> 
> It doesn't double store. cmpxchg8b does:
> compare memory with edx:eax
> 	if equal, copy copy ecx:ebx into memory, set zf = 1
> 	else copy memory into edx:eax, set zf = 0
> 
> > AFAIK we can safely drop that loop (jnz instruction)
> 
> No. The only possible optimization would be to move 1: label directly at
> cmpxgch8b. But it won't bring much, because loop is executed only if value
> was changed after read and before cmpxchg.

Indeed.

> 
> There is another worse problem --- jump instructions are predicted as
> taken when they point backwards, so it gets mispredicted. jnz should
> really point to some other section, that is linked after .text, where
> unconditional jump backwards would be.

On Pentium IV, you can prefix the jump instruction to alter the default 
prediction (the encoding reuses one of the segment overides prefixes).

	Regards,
	Gabriel
