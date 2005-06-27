Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVF0TqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVF0TqR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVF0ToR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:44:17 -0400
Received: from ms004msg.fastwebnet.it ([213.140.2.58]:64479 "EHLO
	ms004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261251AbVF0Tnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:43:33 -0400
Date: Mon, 27 Jun 2005 21:43:15 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Andreas Kies <andikies@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A Bug in gcc or asm/string.h ?
Message-ID: <20050627214315.4b8850f5@localhost>
In-Reply-To: <200506272059.20477.andikies@t-online.de>
References: <200506270105.28782.andikies@t-online.de>
	<20050627160453.6b815e8a@localhost>
	<200506272059.20477.andikies@t-online.de>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PS: I've readded LKML to CC, since I think that this is a problem with the
ASM template


On Mon, 27 Jun 2005 20:59:20 +0200
Andreas Kies <andikies@t-online.de> wrote:

> Them it works, but that's not a solution at all. "volatile" destroys more
> or  less all optimizations.

Yes... I know, it was just to see what was the problem.


The problem is that GCC is caching in registers the value of "ptr[0]" and/or
"ptr[1]" and/or "ptr[2]".

A little better workaround would be to add "memory" to clobbered registers
in the asm template:

static inline int strcmp(const char * cs,const char * ct)
{
int d0, d1;
register int __res;
__asm__ __volatile__(
        "1:\tlodsb\n\t"
        "scasb\n\t"
        "jne 2f\n\t"
        "testb %%al,%%al\n\t"
        "jne 1b\n\t"
        "xorl %%eax,%%eax\n\t"
        "jmp 3f\n"
        "2:\tsbbl %%eax,%%eax\n\t"
        "orb $1,%%al\n"
        "3:"
        :"=a" (__res), "=&S" (d0), "=&D" (d1)
                     :"1" (cs),"2" (ct)
                     : "memory");	// <--- workaround
return __res;
}


In this way GCC puts everything is cached in register back to memory when
you call strcmp()... but you can argue that this isn't optimal.


I don't know if there is a better way... basically you need to tell GCC to
NOT cache these values.

I think that nobody hits this bug because the typical usage is different...
something like this:

	...
	char *str = "Hello!";		// or even char str[] = "Hello!";
	...
	strcmp (str, other_str);
	...

In this way "Hello!" _IS_ allocated in memory and "str" points to it.... GCC
optimizations can't hurt here (I hope ;).


CONCLUSION: I think that it should be fixed... but adding "memory" doesn't
seems The Right Thing to do.

--
	Paolo Ornati
	Linux 2.6.12.1 on x86_64
