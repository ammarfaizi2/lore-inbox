Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319600AbSIHMdE>; Sun, 8 Sep 2002 08:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319601AbSIHMdE>; Sun, 8 Sep 2002 08:33:04 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:48905 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S319600AbSIHMdC>; Sun, 8 Sep 2002 08:33:02 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200209081232.g88CWlBL030103@wildsau.idv.uni.linz.at>
Subject: machine_real_start: problems executing 16bit code
To: linux-kernel@vger.kernel.org (l)
Date: Sun, 8 Sep 2002 14:32:46 +0200 (MET DST)
Cc: kernel@wildsau.idv.uni.linz.at (H.Rosmanith (Kernel Mailing List))
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

<linux/arch/i386/kernel/process.c> defines machine_real_start, which allows
for the execution of 16bit real-mode code. of course, allthough in theory
it could be possible, the call is not expected to return, so it's best used
after linux has shut down.

I built a straight-forward character-device wrapper around that call to
allow a user-programm pass 16bit-code to machine_real_start. this works
okay for small fragments of code, but as soon as the code gets larger than
some amount of bytes, code *after* that amount will not be executed anymore.
I don't know what the CPU is doing after that.

I've seen that there's a 100 byte limit in process.c, so execution of the
code in this code-segment will wrap about segment-boundaries after 100 bytes.
But the behaviour is simply ... doing nothing ... can be observed even
with binary-code which is smaller than 100 bytes. I've also tried to increas
the memory reserved from 100 to 512 bytes, but still get the same behaviour.

e.g., take the following assembly program (.nasm source)
---- snip ----
BITS 16
section .text

        mov     ax,0xb800
        mov     es,ax
        xor     di,di
        cld

        mov     eax,0x21212161
foo:
        stosd
        inc     al
        jmp     foo
---- snip ----

the size of this code is 21 bytes. it will just print "a!b!c!d!...." and so
on, on the screen (textmode assumed), filling the entire screen with the
ascii-alphabet interleaved with "!", all in blue characters on green background.

this is what it's expected to do.

the next assembly program demonstrates the malfunction:
---- snip ----
BITS 16
section .text

        mov     ax,0xb800
        mov     es,ax
        xor     di,di
        cld

%macro is 0
        inc     al
        stosd
%endmacro
        mov     eax,0x21212161
        stosd
        is      ; b
        is      ; c
        is      ; d
        is      ; e
        is      ; f
        is      ; g
        is      ; h
        is      ; i
        is      ; j
        is      ; k
        is      ; l
        is      ; m
        is      ; n
        is      ; o
        mov     eax,0x21212121
        stosd
foo:
        hlt
        jmp     foo
---- snip ----

size is 84 bytes.
this is supposed to display "a!b!c!d!.....m!n!o!!!" on the screen.
however, it stops after "m!". code which is beyond that limit can not
be called (e.g. subroutines) because the never return. I've even tried
to load some code (from userspace by means of /dev/mem) to some low
location (say, segment 0x3000) and do far jmp/call to this point, but
the code never seems to get executed. I really dont know why! /dev/mem
is supposed to be physical memory-space, isn't it? Even reading back
from the location to verify the contents shows that everything has been
loaded. e.g., I lseek("/dev/mem", 0x37000, SEEK_SET) and then store
some code which only displays a "A!" in the upper left corner. then,
from machine_real_start, all I do is jmp far 3700:0000 (0xea, 0, 0, 0, 0x37),
but nothing is ever seen.

I'd have to guess where the problem is. I've never played around with
IDT, GDT and LDT, so, if I say "the problems is in the descriptor tables",
that would only be a guess. If we look at the GDT from process.c:

  : static unsigned long long
  : real_mode_gdt_entries [3] =
  : {
  :         0x0000000000000000ULL,  /* Null descriptor */
  :         0x00009a000000ffffULL,  /* 16-bit real-mode 64k code at 0x00000000 */
  :         0x000092000100ffffULL   /* 16-bit real-mode 64k data at 0x00000100 */
  : };

this seems to mean that, beside 0x0 and 0x100, which are 64k in size,
no other physical memory is mapped therefore jumping to 0x3700 will
cause a fault.

the first descriptor decodes like:

0x0000.9a00.0000.ffff
  |||| |||       +--> limit0-15
   ..  ||+----------> base0-23
   ..  ++-----------> access rights: P=1 DPL=00 S=1 TYPE=101 (code) A=0
  ||||
  ++++--------------> G,D,base24-31,limit16-19: all zero

the second descriptor differs in the type-field, TYPE=001 (data segment).

Is it possible that I just add another descriptor pointing to map some
free memory and that the 16bit code can make use of it? I've never tried
that ... and the try-and-error cycle here is rather lengthy,
since the fastes machine I have is only a K6/800.

say, I add:

  00009e000200ffffULL,

this would give me a 64k code segment at phys 0x200. but what would be
the value of the selector (CS: register). the CPU-programming guide I
have is not very clear about that. sure, the seg.regs. are an index into
the descripor tables, but a) where does the descriptor table live? (it
is in physical memory too, pointed to by some control register, correct?)
and b) how is the adress of the descriptor computed? is that a byte-offset
in the descriptor table with the value of the seg.register? but if that's
the case, values of 0 for segment register would not be possible.

thanks for any help,
h.rosmanith


