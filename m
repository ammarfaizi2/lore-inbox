Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265516AbSKOMoz>; Fri, 15 Nov 2002 07:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266115AbSKOMoz>; Fri, 15 Nov 2002 07:44:55 -0500
Received: from are.twiddle.net ([64.81.246.98]:40837 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S265516AbSKOMox>;
	Fri, 15 Nov 2002 07:44:53 -0500
Date: Fri, 15 Nov 2002 04:51:46 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: in-kernel linking issues
Message-ID: <20021115045146.A23944@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
References: <p73wunfv5b0.fsf@oldwotan.suse.de> <20021115084757.A640A2C145@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021115084757.A640A2C145@lists.samba.org>; from rusty@rustcorp.com.au on Fri, Nov 15, 2002 at 07:44:40PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One more thing:

Are you really REALLY sure you don't want to load ET_DYN or ET_EXEC
files (aka shared libraries or executables) instead of ET_REL files
(aka .o files)?

If you load ET_DYN or ET_EXEC objects, then a lot of the ugliness
wrt linking can be left to the linker, where it belongs.  You'd only
need to process the dynamic relocations remaining in the object.
Which would avoid the problems I mentioned earlier today wrt section
layout, and would also avoid the effort to create .got sections and
the like.

The .init bits could be allocated to their own segment via linker
script widgetry.  E.g.

	PHDRS {
	  core PT_LOAD;
	  init PT_LOAD;
	  rel  PT_LOAD;
	  dyn  PT_DYNAMIC;
	}
	
	SECTIONS
	{
	  .text : { *(.text) } :core
	  .rodata : { *(.rodata) *(.rodata.*) } :core
	  .data : { *(.data) CONSTRUCTORS } :core
	  .got : { *(.got.plt) *(.got) } :core
	  .sdata : { *(.sdata) } :core
	  .sbss : { *(.sbss) *(.scommon) } :core
	  .bss : { *(.bss) *(.dynbss) *(COMMON) } :core
	
	  .init.text ALIGN(PAGE_SIZE) : { *(.init.text) } :init
	  .init.data : { *(.init.data) } :init
	
	  .hash : { *(.hash) } :rel
	  .dynsym : { *(.dynsym) } :rel
	  .dynstr : { *(.dynstr) } :rel
	  .rel.dyn : { *(.rel*) } :rel
	  .dynamic : { *(.dynamic) } :rel :dyn
	}

to be used like so

	ld -T z.ld -shared -o z.so z.o

Now we've got things nicely collected into three program headers:

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  LOAD           0x001000 0x00000000 0x00000000 0x00020 0x00024 RWE 0x1000
  LOAD           0x002000 0x00001000 0x00001000 0x00014 0x00014 RWE 0x1000
  LOAD           0x002014 0x00001014 0x00001014 0x002a4 0x002a4 RW  0x1000
  DYNAMIC        0x002240 0x00001240 0x00001240 0x00078 0x00078 RW  0x4

 Section to Segment mapping:
  Segment Sections...
   00     .text .got .bss 
   01     .init.text .init.data 
   02     .hash .dynsym .dynstr .rel.dyn .dynamic 
   03     .dynamic 

The first segment contains the core sections, as you've got them now.
The second contains the init sections, which can be freed after running
the module init routine, and the third contains all of the dynamic
linking information, which can be discarded almost immediately.
(Though perhaps it's just as easy to discard it with the .init segment.)

This does reduce the freedom to allocate the init sections completely
separately from the core sections, but that seems a small price to pay
for the extreme reduction in complexity for the in-kernel loader.

Thoughts?


r~
