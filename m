Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbUAJNp1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 08:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbUAJNp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 08:45:26 -0500
Received: from [193.138.115.2] ([193.138.115.2]:22291 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265162AbUAJNpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 08:45:24 -0500
Date: Sat, 10 Jan 2004 14:41:42 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Maciej Zenczykowski <maze@cela.pl>
cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity
 checking 
In-Reply-To: <Pine.LNX.4.44.0401092105070.1739-100000@gaia.cela.pl>
Message-ID: <Pine.LNX.4.56.0401101431340.13547@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.44.0401092105070.1739-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Jan 2004, Maciej Zenczykowski wrote:

> > I know of the document, but thank you for pointing it out, it's quite an
> > interresting read. Actually, reading that exact document ages ago was what
> > initially caused me to start reading the ELF loading code (thinking
> > "there's got to be something wrong here").
> > I've actually been planning to use some of the crazy stunts he pulls
> > with that code as validity checks of the code I want to implement (in
> > adition to specially tailored test-cases ofcourse).
>
> I think this points to an 'issue', if we're going to increase the checks
> in the ELF-loader (and thus increase the size of the minimal valid ELF
> file we can load, thus effectively 'bloating' (lol) some programs) we

Do you need smaller than this?  :

                org     0x08048000

  ehdr:                                                 ; Elf32_Ehdr
                db      0x7F, "ELF", 1, 1, 1            ;   e_ident
        times 9 db      0
                dw      2                               ;   e_type
                dw      3                               ;   e_machine
                dd      1                               ;   e_version
                dd      _start                          ;   e_entry
                dd      phdr - $$                       ;   e_phoff
                dd      0                               ;   e_shoff
                dd      0                               ;   e_flags
                dw      ehdrsize                        ;   e_ehsize
                dw      phdrsize                        ;   e_phentsize
                dw      1                               ;   e_phnum
                dw      0                               ;   e_shentsize
                dw      0                               ;   e_shnum
                dw      0                               ;   e_shstrndx

  ehdrsize      equ     $ - ehdr

  phdr:                                                 ; Elf32_Phdr
                dd      1                               ;   p_type
                dd      0                               ;   p_offset
                dd      $$                              ;   p_vaddr
                dd      $$                              ;   p_paddr
                dd      filesize                        ;   p_filesz
                dd      filesize                        ;   p_memsz
                dd      5                               ;   p_flags
                dd      0x1000                          ;   p_align

  phdrsize      equ     $ - phdr

  _start:

                mov     bl, 0
                xor     eax, eax
                inc     eax
                int     0x80

  filesize      equ     $ - $$


That's a 100% valid ELF executable, and the entire program is 91 bytes..
Sure, it doesn't do much useful, and the ELF header and program header
table is huge overhead compared to the actual program, but that overhead
is minimal in any program that does any actual work.

Also, I'm not planning to add anything that disallows anything the ELF
spec allows, so you can still pull funny tricks like have sections overlap
and in the above program put _start inside the unused padding bytes in
e_ident[EI_PAD] if you want.. still a valid program, and not something
that the checks I'm adding will prevent.

It you want *really* tiny files then, as some have suggested, anothe
format could be used.
In my oppinion, if you claim to be an ELF executable, then you should be a
*valid* ELF executable.. If you are not a valid elf file but claim to be
so, then either something corrupted you or the tools that generated you
are buggy - and you should not be allowed to even attempt to execute - for
all the reasons I gave in my original mail.


-- Jesper Juhl

