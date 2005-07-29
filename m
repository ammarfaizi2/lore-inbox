Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbVG2Qdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbVG2Qdj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 12:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVG2Qbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 12:31:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49882 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262654AbVG2QYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 12:24:09 -0400
Date: Fri, 29 Jul 2005 09:23:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Steven Rostedt <rostedt@goodmis.org>,
       "Maciej W. Rozycki" <macro@linux-mips.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do
 the work)
In-Reply-To: <1122631385.8317.26.camel@baythorne.infradead.org>
Message-ID: <Pine.LNX.4.58.0507290910090.3307@g5.osdl.org>
References: <1122473595.29823.60.camel@localhost.localdomain> 
 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <1122513928.29823.150.camel@localhost.localdomain> 
 <1122519999.29823.165.camel@localhost.localdomain> 
 <1122521538.29823.177.camel@localhost.localdomain> 
 <1122522328.29823.186.camel@localhost.localdomain>  <42E8564B.9070407@yahoo.com.au>
  <1122551014.29823.205.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0507280823210.3227@g5.osdl.org>  <1122565640.29823.242.camel@localhost.localdomain>
  <Pine.LNX.4.61L.0507281725010.31805@blysk.ds.pg.gda.pl> 
 <1122569848.29823.248.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0507281018170.3227@g5.osdl.org> <1122631385.8317.26.camel@baythorne.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Jul 2005, David Woodhouse wrote:
>
> On Thu, 2005-07-28 at 10:25 -0700, Linus Torvalds wrote:
> > Basic rule: inline assembly is _better_ than random compiler extensions. 
> > It's better to have _one_ well-documented extension that is very generic 
> > than it is to have a thousand specialized extensions.
> 
> Counterexample: FR-V and its __builtin_read8() et al.

There are arguably always counter-examples, but your arguments really are 
pretty theoretical.

Very seldom does compiler extensions end up being (a) timely enough and 
(b) semantically close enough to be really useful.

> Builtins can also allow the compiler more visibility into what's going
> on and more opportunity to optimise.

Absolutely. In theory. In practice, not so much. All the opportunity to 
optimize often ends up being lost in semantic clashes, or just because 
people can't use the extension because it hasn't been there since day one.

The fact is, inline asms are pretty rare even when we are talking about
every single possible assembly combination. They are even less common when
we're talking about just _one_ specific case of them (like something like
__builtin_ffs()).

What does this mean? It has two results: (a) instruction-level scheduling 
and register allocation just isn't _that_ important, and the generic "asm" 
register scheduling is really plenty good enough. The fact that in theory 
you might get better results if the compiler knew exactly what was going 
on is just not relevant: in practice it's simply not _true_. The other 
result is: (b) the compiler people don't end up seeing something like the 
esoteric builtins as a primary thing, so it's not like they'd be tweaking 
and regression-testing everything _anyway_.

So I argue very strongly that __builtin_xxx() is _wrong_, unless you have 
very very strong reasons for it:

 - truly generic and _very_ important stuff: __builtin_memcpy() is
   actually very much worth it, since it's all over, and it's so generic 
   that the compiler has a lot of choice in how to do it.

 - stuff where the architecture (or the compiler) -really- sucks with
   inline asms, and has serious problems, and the thing is really 
   important. Your FR-V example _might_ fall into this category (or it 
   might not), and ia64 has the problem with instruction packing and
   scheduling and so __builtin's have a bigger advantage.

Basically, on most normal architectures, there's seldom any reason at
_all_ to use builtins except for things like memcpy. On x86, I think the
counter-example might be if you want to schedule MMX code from C - which
is a special case because it doesn't follow my "rule (a)" above. But we 
don't do that in the kernel, really, or we just schedule it out-of-line.

			Linus
