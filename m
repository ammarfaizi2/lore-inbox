Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265669AbUAICa3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 21:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266410AbUAICa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 21:30:28 -0500
Received: from [193.138.115.2] ([193.138.115.2]:5893 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265669AbUAICaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 21:30:06 -0500
Date: Fri, 9 Jan 2004 03:27:14 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity
 checking
In-Reply-To: <Pine.LNX.4.56.0401090236390.11276@jju_lnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.56.0401090323580.11276@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0401090236390.11276@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Arrgh, sorry for the re-post/reply to self, people. I accidentilly send
the original mail from the wrong email addr. which I don't usually follow
up on, so please reply to this mail and the juhl-lkml@dif.dk addr.

Sorry for the trouble...
Seems I have to screw /something/ up every time I post to lkml :(

-- Jesper Juhl


On Fri, 9 Jan 2004, Jesper Juhl wrote:

>
> The current Linux kernel does only very basic sanity checking on ELF
> binaries.
> In my oppinion, any attempt to load an invalid/corrupted binary should
> fail as early as possible. Currently Linux will assign a PID to a lot of
> different variants of broken ELF binaries, so I took it upon myself to fix
> that up a bit.
>
> Why bother checking validity of a binary too closely?
>
> Well, the reasons I can thing of include
>
> - Correctness. If it's invalid it /should/ fail, and as early as possible.
>
> - Stability. Who knows when it'll crash and what damage it may have
> done before it crashes?
>
> - Least amount of surprise for the user. If a binary has become corrupted
> the user is likely to want to be told it's bad when loading it (if
> possible), rather than being left wondering about strange crashes during
> runtime.
>
> - Security 1. Is it not plausible that someone may try to play tricks on
> the kernel with invalid binaries? Isn't it safer just rejecting them if we
> *know* they are bad?
>
> - Security 2. If a virus/worm/trojan/whatever attempts to infect a binary
> and does not do a perfect job of fixing up the ELF header, section table
> headers etc, then with the current code we would in some cases still run
> the binary. If we enforce as many sanity checks as possible such an
> infected binary willlikely fail to run.
>
>
> The patch below only implements two additional sanity checks, and they are
> very weak. This code is not intended to be merged in its current form, I
> only did it as proof that more valid sanity checks are possible (well, you
> probably already knew that), and to prove that I /do/ have a basic
> understanding of the ELF format.. well, consider it flame detergent, code
> talks, BS walks - tends to be the norm on LKML ;)
>
> The two checks I've implemented in this patch simply check that e_version
> is not EV_NONE (Invalid version), and that e_ident[EI_CLASS] is not
> ELFCLASSNONE (Invalid class). No binaries looking like that should ever
> exist, so they are valid (albeit not very strong) sanity checks.
>
>
> What I would like to know at this point is whether adding additional
> checks to load_elf_binary() in binfmt_elf is worthwhile and desirable, or
> if there's some (unknown to me) very good reason to only do the very basic
> checks that are currently done?
> If there's an interrest in seeing strong sanity checks done in ELF binary
> loading, then I'll attempt to expand my patch to implement whatever sanity
> checks the ELF spec allows for (and ofcourse re-do the checks below right
> so they check for the exact valid value and reject anything else instead
> of just test for a single 'known to be invalid' value).
> Initially I'd be dealing with i386 only, as that's all I can actually test
> with, but I can get access to x86-64 hardware as well and I would do my
> very best to do this for all archs.
>
> In order to test my current code I've done the following:
>
> Test if it compiles without errors/warnings
>    - it does.
>
> Test if a kernel with this patch applied boots and is able to run a basic
> Linux distribution
>    - it boots and currently runs my Slackware 9.1 install just fine.
>
> Create a minimal test program that is easily modifyable with a hex editor
> to create test-case binaries that /should/ fail the sanity check.
>    - I've been using the minimal program below and it does fail if
>      modified to contain the 'tested for, invalid' header fields.
>
>
> ; Test program start - original code from
> ; http://www.muppetlabs.com/~breadbox/software/tiny/teensy.html
>
>                org     0x08048000
>
>   ehdr:                                                 ; Elf32_Ehdr
>                 db      0x7F, "ELF", 1, 1, 1            ;   e_ident
>         times 9 db      0
>                 dw      2                               ;   e_type
>                 dw      3                               ;   e_machine
>                 dd      1                               ;   e_version
>                 dd      _start                          ;   e_entry
>                 dd      phdr - $$                       ;   e_phoff
>                 dd      0                               ;   e_shoff
>                 dd      0                               ;   e_flags
>                 dw      ehdrsize                        ;   e_ehsize
>                 dw      phdrsize                        ;   e_phentsize
>                 dw      1                               ;   e_phnum
>                 dw      0                               ;   e_shentsize
>                 dw      0                               ;   e_shnum
>                 dw      0                               ;   e_shstrndx
>
>   ehdrsize      equ     $ - ehdr
>
>   phdr:                                                 ; Elf32_Phdr
>                 dd      1                               ;   p_type
>                 dd      0                               ;   p_offset
>                 dd      $$                              ;   p_vaddr
>                 dd      $$                              ;   p_paddr
>                 dd      filesize                        ;   p_filesz
>                 dd      filesize                        ;   p_memsz
>                 dd      5                               ;   p_flags
>                 dd      0x1000                          ;   p_align
>
>   phdrsize      equ     $ - phdr
>
>   _start:
>                 xor     bl, bl
>                 xor     eax, eax
>                 inc     eax
>                 int     0x80
>
>   filesize      equ     $ - $$
>
> ; Test program end
>
>
> Here's the patch I've created to implement the two additional, weak,
> sanity checks - patch against 2.6.1-rc1-mm2 :
>
>
> --- linux-2.6.1-rc1-mm2-orig/fs/binfmt_elf.c    2003-12-31 05:47:13.000000000 +0100
> +++ linux-2.6.1-rc1-mm2/fs/binfmt_elf.c 2004-01-09 01:41:05.000000000 +0100
> @@ -482,11 +482,14 @@ static int load_elf_binary(struct linux_
>         /* First of all, some simple consistency checks */
>         if (memcmp(elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
>                 goto out;
> -
> +       if (elf_ex.e_ident[EI_CLASS] == ELFCLASSNONE)
> +               goto out;
>         if (elf_ex.e_type != ET_EXEC && elf_ex.e_type != ET_DYN)
>                 goto out;
>         if (!elf_check_arch(&elf_ex))
>                 goto out;
> +       if (elf_ex.e_version == EV_NONE)
> +               goto out;
>         if (!bprm->file->f_op||!bprm->file->f_op->mmap)
>                 goto out;
>
>
> Any and all comments are welcome - what do you think, should we have safer
> binary loading in 2.6.x?
>
>
> -- Jesper Juhl
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
