Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbTAVQX1>; Wed, 22 Jan 2003 11:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbTAVQX1>; Wed, 22 Jan 2003 11:23:27 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:28288 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261963AbTAVQXZ>; Wed, 22 Jan 2003 11:23:25 -0500
Date: Wed, 22 Jan 2003 10:32:27 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Miles Bader <miles@gnu.org>
cc: Greg Ungerer <gerg@snapgear.com>, <linux-kernel@vger.kernel.org>
Subject: Re: common RODATA in vmlinux.lds.h (2.5.59)
In-Reply-To: <buod6mp8zyj.fsf@mcspd15.ucom.lsi.nec.co.jp>
Message-ID: <Pine.LNX.4.44.0301221014250.9969-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jan 2003, Miles Bader wrote:

> Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> writes:
> > Yes, I saw it, but on the other hand I'd like to avoid introducing
> > complexity which isn't really needed.
> 
> Actually as far as I can see, my suggested alternative is _less_ complex
> than the current RODATA.

I don't see that. Your suggestion has two macros, RODATA_CONTENTS and 
RODATA_SECTION, and arch/*/vmlinux.lds.S would use one or the other. 
Surely you agree that all arch/*/vmlinux.lds.S using the same one would be 
simpler?

> It seems to me that the absolutely most straight-forward solution is to
> have a single macro that groups input sections and symbol defs, and is
> simply embeddable into any old output section, i.e. RODATA_CONTENTS
> (note that it's actually shorter than RODATA).  Is there some reason
> why multiple output sections are actually necessary?

I suppose the major reasons for multiple output sections is consistency 
with the default ld script, and alignment in particular. Note that

	. = __start___ksymtab
	*(__ksymtab)

is broken when . isn't aligned to the requirements of *(__ksymtab) already 
- the only way to ensure that in your solution is . = ALIGN(x) beforehand,
where it's however necessary to know the requirements of __ksymtab. This 
means magic numbers which are not even constant for different archs and of 
course it's also fragile, if someone changes the struct which is put into 
__ksymtab, they most likely don't remember to change all the magic numbers 
in arch/*/vmlinux.lds.S.

Using sections allows to do instead:

	__ksymtab : {
		__start___ksymtab = . ;
		*(__ksymtab)
	}

which will align things correctly without further tricks.

You want to use sections as an abstraction for different parts of the 
image, like text/rodata vs data. However, let me claim the sections are 
not the right tool for the job, instead that's why ELF segments exist.
Just declaring two MEMORY regions, e.g. rom/ram and putting text/rodata
sections into rom, the rest into ram will give you a vmlinux with two 
segments, exactly what you need. (There's two ways to do that, using 
MEMORY or PHDRS - whatever works better for you)

> Also, I've found that defining symbols outside the sections, like RODATA
> does, to be somewhat dangerous, and have had much better luck defining
> them inside the sections whenever possible (sometimes it isn't, of
> course, but none of the RODATA symbols appear to have any problems).

Yes, you're right on that one, it's already fixed in -mm, the mainline 
fix has to wait for Linus' return ;)

> > So the important question is:  Is there a reason that v850 does things
> > differently, or could it just as well live with separate .text and
> > .rodata sections.
> 
> It's not that it _needs_ to group things inside a single output section
> (though often doing so is just simpler), but it _does_ need more control
> over the output sections than is provided by the current RODATA macro:
> at least, it needs to be able to specify which memory regions the
> various sections go, sometimes at separate link- and run-time addresses
> (i.e., a "> MEM AT> OTHER_MEM" directive following each output section).

All of this can, AFAICS, be nicely handled by additional 
"{TEXT,RODATA,DATA}_MEM" macros which allow the arch to specify regions as 
necessary.

--Kai


