Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbTAWBya>; Wed, 22 Jan 2003 20:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbTAWBy3>; Wed, 22 Jan 2003 20:54:29 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:60629 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264818AbTAWBy0>; Wed, 22 Jan 2003 20:54:26 -0500
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Greg Ungerer <gerg@snapgear.com>, <linux-kernel@vger.kernel.org>
Subject: Re: common RODATA in vmlinux.lds.h (2.5.59)
References: <Pine.LNX.4.44.0301221014250.9969-100000@chaos.physics.uiowa.edu>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 23 Jan 2003 11:03:10 +0900
In-Reply-To: <Pine.LNX.4.44.0301221014250.9969-100000@chaos.physics.uiowa.edu>
Message-ID: <buoznpspqqp.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> writes:
> > Actually as far as I can see, my suggested alternative is _less_ complex
> > than the current RODATA.
> 
> I don't see that. Your suggestion has two macros, RODATA_CONTENTS and 
> RODATA_SECTION, and arch/*/vmlinux.lds.S would use one or the other. 

Well, actually I was also suggesting that there really shouldn't be
RODATA_SECTION at all, and every linker script should just use
RODATA_CONTENTS embedded in an existing section of their choice or in a
trivial .rodata section, e.g:

   .rodata { RODATA_CONTENTS }

> Surely you agree that all arch/*/vmlinux.lds.S using the same one would be 
> simpler?

No, in fact I don't think it would -- your suggestion is that there
should be a single macro affected by all sorts of `magic defines' that
somehow change its behavior (e.g. LOAD_OFFSET, and the
output-memory-area defines you mentioned to solve my output memory
region problem).  This sort of structure seems very confusing to me,
even if it's superficially simpler (by having only a `single macro').

Not having the macro(s) create output sections makes the result a _lot_
easier to understand, since there's not all this behind-the-scenes
tweaking going on by the macro, it's all pretty straight-forward.

> I suppose the major reasons for multiple output sections is consistency 
> with the default ld script

Why is this important?

> and alignment in particular.

This is more important problem with my scheme:

> the only way to ensure that in your solution is . = ALIGN(x) beforehand,
> where it's however necessary to know the requirements of __ksymtab. This 
> means magic numbers which are not even constant for different archs and of 
> course it's also fragile, if someone changes the struct which is put into 
> __ksymtab, they most likely don't remember to change all the magic numbers 
> in arch/*/vmlinux.lds.S.

I see your point, but is this really a problem in practice?  I suspect
that about 99% of the time you can get away with simply being a bit
conservative, e.g., aligning to an 8- or 16-byte boundary (I would be
very surprised if there's an arch that aligns structs more than that,
for obvious reasons).

> You want to use sections as an abstraction for different parts of the 
> image, like text/rodata vs data.

Um, no I don't.  I just want to control where the output sections go,
e.g., into RAM or ROM, and how the load-time and run-time addresses are
related.  Most of the time I don't care what the output sections are,
as long as I can control their disposition.

> However, let me claim the sections are not the right tool for the job,
> instead that's why ELF segments exist.  Just declaring two MEMORY
> regions, e.g. rom/ram and putting text/rodata sections into rom, the
> rest into ram will give you a vmlinux with two segments, exactly what
> you need. (There's two ways to do that, using MEMORY or PHDRS -
> whatever works better for you)

I'm not sure what you mean by `segments' (the GNU ld linker script
documentation is dreadful), but I'll try to look them up and see if they
can help me solve my problem.

> All of this can, AFAICS, be nicely handled by additional
> "{TEXT,RODATA,DATA}_MEM" macros which allow the arch to specify
> regions as necessary.

That sounds clumsy to me, because it adds lots of `parameters' to the
common macros -- I'd prefer a solution where the macros can be as much
of a black-box as possible -- but it will probably work.

Thanks,

-Miles
-- 
Fast, small, soon; pick any 2.
