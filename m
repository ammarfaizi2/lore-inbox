Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTH3MdQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 08:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTH3MdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 08:33:16 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:61852 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261332AbTH3MdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 08:33:15 -0400
Date: Sat, 30 Aug 2003 14:33:08 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: insecure <insecure@mail.od.ua>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] gcc3 warns about type-punned pointers ?
In-Reply-To: <200308300537.49700.insecure@mail.od.ua>
Message-ID: <Pine.LNX.4.44.0308301427320.3338-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > A collateral question: why is the reason for this function ?
> > long long assignments are not atomic in gcc ?
>
> Another question: why do we do _double_ store here?
>
> static inline void __set_64bit (unsigned long long * ptr,
>                 unsigned int low, unsigned int high)
> {
>         __asm__ __volatile__ (
>                 "\n1:\t"
>                 "movl (%0), %%eax\n\t"
>                 "movl 4(%0), %%edx\n\t"
>                 "lock cmpxchg8b (%0)\n\t"
>                 "jnz 1b"
>                 : /* no outputs */
>                 :       "D"(ptr),
>                         "b"(low),
>                         "c"(high)
>                 :       "ax","dx","memory");
> }
>
> This will execute expensive locked load-compare-store operation twice
> almost always (unless previous value was already equal
> to the value we are about to store)

It doesn't double store. cmpxchg8b does:
compare memory with edx:eax
	if equal, copy copy ecx:ebx into memory, set zf = 1
	else copy memory into edx:eax, set zf = 0

> AFAIK we can safely drop that loop (jnz instruction)

No. The only possible optimization would be to move 1: label directly at
cmpxgch8b. But it won't bring much, because loop is executed only if value
was changed after read and before cmpxchg.

There is another worse problem --- jump instructions are predicted as
taken when they point backwards, so it gets mispredicted. jnz should
really point to some other section, that is linked after .text, where
unconditional jump backwards would be.

Mikulas

