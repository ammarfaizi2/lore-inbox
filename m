Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267311AbTAVEX1>; Tue, 21 Jan 2003 23:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267309AbTAVEX1>; Tue, 21 Jan 2003 23:23:27 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:55981 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267311AbTAVEXZ>; Tue, 21 Jan 2003 23:23:25 -0500
To: Greg Ungerer <gerg@snapgear.com>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: common RODATA in vmlinux.lds.h (2.5.59)
References: <Pine.LNX.4.44.0301212045000.1577-100000@chaos.physics.uiowa.edu>
	<3E2E0F38.7090506@snapgear.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 22 Jan 2003 13:32:10 +0900
In-Reply-To: <3E2E0F38.7090506@snapgear.com>
Message-ID: <buoptqp954l.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Yeah, the new generic RODATA stuff is way broken on the v850 too.

Besides the over-eager use of sections, it also assumes that C symbol
names map one-to-one with `linker symbol' names, which isn't true with
the default v850 compiler.

Here's my local rewrite of include/asm-generic/vmlinux.lds.h, which
works on the v850, and seems like it should be usable by other systems
as well.

It does two things:

  (1) Separates the RODATA stuff into two macros, an input-sections-and-
      symbols macro, RODATA_CONTENTS, which can be put into any
      appropriate section, and a RODATA_SECTION macro, which simply
      defines an appropriate section using that.  I guess most archs
      could just use RODATA_SECTION in the same way they use `RODATA'
      now, but the v850 uses RODATA_CONTENTS instead.

      This assumes that the original division into lots of little
      output sections was gratuitous, and that putting everything into
      a single section is OK.

      [You might notice that this follows the macro scheme already used
      by the v850's vmlinux.lds.S file]

  (2) Adds a `CSYM' macro which is used for every symbol name that is
      exported to C.  By default this just expands to its argument, but
      an arch may define `C_SYMBOL_PREFIX' in order to add a prefix to
      all C symbols.

What do you think of this?

[To be honest, I think the stuff with `LOAD_OFFSET' is a bit of a waste;
it seems cleaner to just have archs define their own sections as
appropriate, and use RODATA_CONTENTS directly -- it's the input sections
and related symbols that are always changing (and so better centralized),
after all, not the output sections.]

Thanks,

-Miles


Here's my rewrite of include/asm-generic/vmlinux.lds.h:



--=-=-=
Content-Disposition: attachment; filename=vmlinux.lds.h
Content-Description: My rewrite of include/asm-generic/vmlinux.lds.h

#ifndef LOAD_OFFSET
#define LOAD_OFFSET 0
#endif

#ifndef C_SYMBOL_PREFIX
#define C_SYMBOL_PREFIX
#endif

#define __paste(x,y) x##y
#define _paste(x,y) __paste(x,y)
#define CSYM(name) _paste(C_SYMBOL_PREFIX,name)

/* Section contents for read-only data.  */
#define RODATA_CONTENTS							      \
		*(.rodata) *(.rodata.*)					      \
		*(__vermagic)		/* Kernel version magic */	      \
		*(.rodata1)						      \
	/* Kernel symbol table: Normal symbols */			      \
	CSYM(__start___ksymtab) = .;					      \
		*(__ksymtab)						      \
	CSYM(__stop___ksymtab) = .;					      \
	/* Kernel symbol table: GPL-only symbols */			      \
	CSYM(__start___gpl_ksymtab) = .;				      \
		*(__gpl_ksymtab)					      \
	CSYM(__stop___gpl_ksymtab) = .;					      \
	/* Kernel symbol table: strings */				      \
		*(__ksymtab_strings)

/* A standalone section containing RODATA_CONTENTS.  */
#define RODATA_SECTION							      \
	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		      \
		RODATA_CONTENTS						      \
	}

--=-=-=




-- 
Suburbia: where they tear out the trees and then name streets after them.

--=-=-=--
