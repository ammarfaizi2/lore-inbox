Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbTIGVrL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 17:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbTIGVrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 17:47:10 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:12423 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261499AbTIGVrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 17:47:06 -0400
Date: Sun, 7 Sep 2003 23:46:58 +0200 (MEST)
Message-Id: <200309072146.h87LkwWU020877@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: jamie@shareable.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Cc: bunk@fs.tum.de, linux-kernel@vger.kernel.org, robert@schwebel.de,
       rusty@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Sep 2003 18:43:41 +0100, Jamie Lokier wrote:
>> There is to the best of my knowledge nothing in 2.6.0-test4
>> that prevents a kernel compiled for CPU type N from working
>> with CPU types >N. Just to prove it, I built a CONFIG_M486
>> 2.6.0-test4 and booted it w/o problems on P4, PIII, and K6-III.
>
>You may be right, although I wonder if there are real problems like an
>SMP Pentium kernel not setting up MTRRs when run on an SMP P3.

Only if you omit CONFIG_MTRR. MTRR support is independent of
which CPU type you chose to optimise for.

>The main problems are:
>
>	1. Optimisation.  A kernel optimised for P3 but compatible
>	   with 486 needs to use 64 byte cache line alignment, and TSC
>	   for timing, but not use any SSE instructions.

A 486 kernel will use TSC if there is one. CONFIG_TSC (derived
from configured CPU type) allows the kernel to skip checking
for _not_ having a TSC; !CONFIG_TSC only means it has to check
before using it.

>	2. The CPU types are not a total order.  Say I want a kernel
>	   that supports Athlons and a Centaur for my cluster.  What
>	   CPU setting should I use?  What CPU setting will give my the best
>	   performing kernel - and is that the same as the one for smallest
>	   kernel?

CONFIG_M586 supports both, with some performance loss for the K7,
but that's your choice.

>	3. Like 2, but for embedded systems.  I'm (hypothetically)
>	   selling a cable modem which was originally based on one
>	   CPU, but we changed to a different one because it was
>	   cheaper.  I need to send out a firmware upgrade, and it is
>	   convenient to use a kernel which can run on either model.
>	   But I don't want to compile in support for every x86,
>	   because space is tight, and I want it to run as fast as it
>	   can given that it could run on either of the two chips.

So configure for the lowest common denominator. As long as your
embedded system isn't SMP, L1 cache line size assumptions don't
matter much, so you only lose (a) gcc -march= optimisations that
aren't common to both CPU types you support, and (b) some features
(like TSC if it isn't common to both) may need a runtime test
and/or dynamic dispatch. Given your insistence on having a common
kernel, this is the best you can do.

>I'm not sure if an Athlon is "lower" than a PII or not....  Which do I
>option do I pick, to run on either of those without including
>redundant stuff for older CPUs?

K7 is PIII (or PII, but I don't think so) + some stuff.

Admittedly, the kernel could include some more performance-tweaking
CONFIG options (mainly for L1 cache size and gcc -mcpu= values),
but that's a simple thing to add if necessary.

/Mikael
