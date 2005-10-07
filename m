Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbVJGWnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbVJGWnI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 18:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030558AbVJGWnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 18:43:08 -0400
Received: from agmk.net ([217.73.31.34]:17668 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S1030556AbVJGWnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 18:43:07 -0400
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Subject: Re: [2.6] binfmt_elf bug (exposed by klibc).
Date: Sat, 8 Oct 2005 00:42:58 +0200
User-Agent: KMail/1.8.2
Cc: "Horst von Brand" <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
References: <200510071533.j97FX9Wp018589@laptop11.inf.utfsm.cl> <200510072320.18263.pluto@agmk.net> <Pine.LNX.4.61.0510071740040.13291@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0510071740040.13291@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200510080042.58408.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia piątek, 7 października 2005 23:47, linux-os (Dick Johnson) napisał:
> On Fri, 7 Oct 2005, [UTF-8] Pawe? Sikora wrote:
> > Dnia pitek, 7 padziernika 2005 18:16, linux-os (Dick Johnson) napisa:
> >> On Fri, 7 Oct 2005, [UTF-8] Pawe? Sikora wrote:
> >>> Dnia pitek, 7 padziernika 2005 17:33, Horst von Brand napisa:
> >>>> Pawe Sikora <pluto@agmk.net> wrote:
> >>>>> Dnia pitek, 7 padziernika 2005 15:46, Horst von Brand napisa:
> >>>>
> >>>> [...]
> >>>>
> >>>>>> binutils-2.16.91.0.2-4 doesn't. It looks like you are using broken
> >>>>>> tools.
> >>>>>
> >>>>> I didn't say that is (or not) a binutils bug.
> >>>>> I'm only saying that kernel is killng a valid micro application.
> >>>>
> >>>> If binutils generates an invalid executable, it is not a valid
> >>>> application.
> >>>
> >>> ehh, please look again at my first post :)
> >>> binutils-2.16 generates VALID app with .text/.interp and *without*
> >>> .bss. kernel always calls padzero() for the .bss section inside
> >>> load_elf_binary(). finally it kills a valid app. did i miss something?
> >>
> >> The executable created by this:
> >>
> >> $ cat <<EOF >xxx.S
> >> .section	.rodata
> >> hello:		.string	"Hello World!\n"
> >> STRLEN = .-hello
> >> WRITE=4
> >> EXIT=1
> >>
> >> .section	.text
> >> .global		_start
> >> .type		_start,@function
> >> _start:
> >>  	movl	$WRITE, %eax
> >>  	movl	$1, %ebx
> >>  	movl	$hello, %ecx
> >>  	movl	$STRLEN, %edx
> >>  	int	$0x80
> >>  	movl	$EXIT, %eax
> >>  	movl	$0, %ebx
> >>  	int	$0x80
> >> .end
> >> EOF
> >>
> >> $ as -o xxx.o xxx.S
> >> $ ld -o xxx xxx.o
> >> $ ./xxx
> >> Hello World!
> >> $
> >>
> >> ... does not have a .bss section. It also runs fine. The linker
> >> creates a 0 length .bss section starting at label "_end". There
> >> is no way to prevent it from happening so the kernel's zeroing
> >> the zero-length section is perfectly valid. Maybe you have
> >> executed `strip` and stripped out that section? If so, you
> >> no longer have a valid executable and the kernel should kill
> >> it.
> >
> > What????????????
> > Do you suggest that stripped executables are invalid?
>
> No, not if you don't strip out sections that are required.

Please tell me what requires these useless zero-sized .data/.bss sections?
Kernel design or something else? (e.g. some standard?)
Maybe H.J.Lu will know better as we are.

> > $ cat xxx.S
> > .section        .text
> > .global         _start
> > .type           _start,@function
> > _start:
> >        movl    $1, %eax
> >        movl    $0, %ebx
> >        int     $0x80
> > .end
> >
> > $ as xxx.S -o xxx.o; ld xxx.o -o xxx -s; objdump -x xxx
> >
> > xxx:     file format elf32-i386
> > xxx
> > architecture: i386, flags 0x00000102:
> > EXEC_P, D_PAGED
> > start address 0x08048094
> >
> > Program Header:
> >    LOAD off    0x00000000 vaddr 0x08048000 paddr 0x08048000 align 2**12
> >         filesz 0x000000a0 memsz 0x000000a0 flags r-x
> > PAX_FLAGS off  0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**2
> >         filesz 0x00000000 memsz 0x00000000 flags --- 2800
> >
> > Sections:
> > Idx Name          Size      VMA       LMA       File off  Algn
> >  0 .text         0000000c  08048094  08048094  00000094  2**2
> >                  CONTENTS, ALLOC, LOAD, READONLY, CODE
> >
> > We have a pure executable, no .data/.rodata/.bss/etc.
>
> Your executable works fine on 2.6.14 as it should.

Hmm, it's strange. On my 2.6.14rc3-git6 + binutils-2.16.91.0.3
it doesn't work (vide -EFAULT). On 2.6.13 + binutils-2.15.94.0.2.2
it works fine (executable contains zero-sized .data + .bss sections).
(btw. fs/binfmt_elf.c are the same)

> > $ strace ./xxx
> > execve("./xxx", ["./xxx"], [/* 24 vars */]) = -1 EFAULT (Bad address)
> > --- SIGSEGV (Segmentation fault) @ 0 (0) ---
> > +++ killed by SIGSEGV +++
> >
> > With hacked kernel it works pretty fine:
>
> What did you hack? Patch please.

Ugly workaround: lkml.org/lkml/2005/10/7/48/

> Did somebody accidentally 
> screw up some kernel code between 2.6.13 and 2.6.14?

I think kernel elf loader doesn't handle binaries without .bss.
Earlier binutils (<2.16) emits zero-sized .data/.bss and problem
wasn't exposed. Modern binutils doesn't emit useless zero-sized
.data/.bss sections and kernel kills these binaries.

Regards,
Paweł.

-- 
The only thing necessary for the triumph of evil
  is for good men to do nothing.
                                           - Edmund Burke
