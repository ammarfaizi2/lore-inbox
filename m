Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVKLGEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVKLGEF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 01:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVKLGEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 01:04:05 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:27400 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932161AbVKLGED convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 01:04:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=huqBzqY5Mb1lVJ1bYHbcgfB6Wyb7Jf5F69kifY7gc5VjcZxCpWjZW9zLrajfPyhvWODkM9YUYwojlTtBEfea/8h9MC+4ac4wFb0V93spcwMGupvlyEx+X4gM+yuqNJgrozyU5KGt0PWap5rxCN7qGggduPN6m7rx+potGUg/LVY=
Message-ID: <2cd57c900511112203t3ea031ccq@mail.gmail.com>
Date: Sat, 12 Nov 2005 14:03:59 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: akpm@osdl.org
Subject: Re: i386-vmlinuxldss-distinguish-absolute-symbols.patch added to -mm tree
Cc: ebiederm@xmission.com, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200507292019.j6TKJvXU019348@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507292019.j6TKJvXU019348@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wonder why this patch
(i386-vmlinuxldss-distinguish-absolute-symbols.patch) isn't merged?
Any reason? Sam had agreed it is safe. Or simply Linus rejected it?

-- coywolf

2005/7/30, akpm@osdl.org <akpm@osdl.org>:
>
> The patch titled
>
>      i386: vmlinux.lds.S: Distinguish absolute symbols
>
> has been added to the -mm tree.  Its filename is
>
>      i386-vmlinuxldss-distinguish-absolute-symbols.patch
>
> Patches currently in -mm which might be from ebiederm@xmission.com are
>
> fix-sync_tsc-hang.patch
> reboot-remove-device_suspendpmsg_freeze-from.patch
> i386-machine_kexec-cleanup-inline-assembly.patch
> x86_64-machine_kexec-cleanup-inline-assembly.patch
> x86_64-machine_kexec-use-standard-pagetable-helpers.patch
> x86_64-io_apicc-memorize-at-bootup-where-the-i8259-is.patch
> i386-io_apicc-memorize-at-bootup-where-the-i8259-is.patch
> i386-vmlinuxldss-distinguish-absolute-symbols.patch
> forcedeth-write-back-the-misordered-mac-address.patch
> x86_64-fix-off-by-one-in-e820_mapped.patch
>
>
>
> From: Eric W. Biederman <ebiederm@xmission.com>
>
> Ld knows about 2 kinds of symbols, absolute and section relative.  Section
> relative symbols symbols change value when a section is moved and absolute
> symbols do not.
>
> Currently in the linker script we have several labels marking the beginning
> and ending of sections that are outside of sections, making them absolute
> symbols.  Having a mixture of absolute and section relative symbols refereing
> to the same data is currently harmless but it is confusing.
>
> My ultimate goal is to build a relocatable kernel.  The safest and least
> intrusive technique is to generate relocation entries so the kernel can be
> relocated at load time.  The only penalty would be an increase in the size of
> the kernel binary.  The problem is that if absolute and relocatable symbols
> are not properly specified absolute symbols will be relocated or section
> relative symbols won't be, which is fatal.
>
> The practical motivation is that when generating kernels that will run from a
> reserved area for analyzing what caused a kernel panic, it is simpler if you
> don't need to hard code the physical memory location they will run at,
> especially for the distributions.
>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  arch/i386/kernel/vmlinux.lds.S |   90 +++++++++++++++++++++++++----------------
>  1 files changed, 55 insertions(+), 35 deletions(-)
>
> diff -puN arch/i386/kernel/vmlinux.lds.S~i386-vmlinuxldss-distinguish-absolute-symbols arch/i386/kernel/vmlinux.lds.S
> --- devel/arch/i386/kernel/vmlinux.lds.S~i386-vmlinuxldss-distinguish-absolute-symbols  2005-07-29 13:18:38.000000000 -0700
> +++ devel-akpm/arch/i386/kernel/vmlinux.lds.S   2005-07-29 13:18:38.000000000 -0700
> @@ -17,21 +17,22 @@ SECTIONS
>    . = __KERNEL_START;
>    phys_startup_32 = startup_32 - LOAD_OFFSET;
>    /* read-only */
> -  _text = .;                   /* Text and read-only data */
>    .text : AT(ADDR(.text) - LOAD_OFFSET) {
> +         _text = .;            /* Text and read-only data */
>         *(.text)
>         SCHED_TEXT
>         LOCK_TEXT
>         *(.fixup)
>         *(.gnu.warning)
> -       } = 0x9090
> -
> -  _etext = .;                  /* End of text section */
> +       _etext = .;             /* End of text section */
> +  } = 0x9090
>
>    . = ALIGN(16);               /* Exception table */
> -  __start___ex_table = .;
> -  __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) { *(__ex_table) }
> -  __stop___ex_table = .;
> +  __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
> +       __start___ex_table = .;
> +       *(__ex_table)
> +       __stop___ex_table = .;
> +  }
>
>    RODATA
>
> @@ -39,13 +40,15 @@ SECTIONS
>    .data : AT(ADDR(.data) - LOAD_OFFSET) {      /* Data */
>         *(.data)
>         CONSTRUCTORS
> -       }
> +  }
>
>    . = ALIGN(4096);
> -  __nosave_begin = .;
> -  .data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) { *(.data.nosave) }
> -  . = ALIGN(4096);
> -  __nosave_end = .;
> +  .data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) {
> +       __nosave_begin = .;
> +       *(.data.nosave)
> +       . = ALIGN(4096);
> +       __nosave_end = .;
> +  }
>
>    . = ALIGN(4096);
>    .data.page_aligned : AT(ADDR(.data.page_aligned) - LOAD_OFFSET) {
> @@ -60,7 +63,9 @@ SECTIONS
>    /* rarely changed data like cpu maps */
>    . = ALIGN(32);
>    .data.read_mostly : AT(ADDR(.data.read_mostly) - LOAD_OFFSET) { *(.data.read_mostly) }
> -  _edata = .;                  /* End of data section */
> +  .data.end : AT(ADDR(.data.end) - LOAD_OFFSET) {
> +       _edata = .;             /* End of data section */
> +  }
>
>    . = ALIGN(THREAD_SIZE);      /* init_task */
>    .data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) {
> @@ -69,7 +74,9 @@ SECTIONS
>
>    /* will be freed after init */
>    . = ALIGN(4096);             /* Init code and data */
> -  __init_begin = .;
> +  .init.begin : AT(ADDR(.init.begin) - LOAD_OFFSET) {
> +       __init_begin = .;
> +  }
>    .init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
>         _sinittext = .;
>         *(.init.text)
> @@ -77,11 +84,13 @@ SECTIONS
>    }
>    .init.data : AT(ADDR(.init.data) - LOAD_OFFSET) { *(.init.data) }
>    . = ALIGN(16);
> -  __setup_start = .;
> -  .init.setup : AT(ADDR(.init.setup) - LOAD_OFFSET) { *(.init.setup) }
> -  __setup_end = .;
> -  __initcall_start = .;
> +  .init.setup : AT(ADDR(.init.setup) - LOAD_OFFSET) {
> +       __setup_start = .;
> +       *(.init.setup)
> +       __setup_end = .;
> +  }
>    .initcall.init : AT(ADDR(.initcall.init) - LOAD_OFFSET) {
> +       __initcall_start = .;
>         *(.initcall1.init)
>         *(.initcall2.init)
>         *(.initcall3.init)
> @@ -89,20 +98,20 @@ SECTIONS
>         *(.initcall5.init)
>         *(.initcall6.init)
>         *(.initcall7.init)
> +       __initcall_end = .;
>    }
> -  __initcall_end = .;
> -  __con_initcall_start = .;
>    .con_initcall.init : AT(ADDR(.con_initcall.init) - LOAD_OFFSET) {
> +       __con_initcall_start = .;
>         *(.con_initcall.init)
> +       __con_initcall_end = .;
>    }
> -  __con_initcall_end = .;
>    SECURITY_INIT
>    . = ALIGN(4);
> -  __alt_instructions = .;
>    .altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
> +       __alt_instructions = .;
>         *(.altinstructions)
> +       __alt_instructions_end = .;
>    }
> -  __alt_instructions_end = .;
>    .altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
>         *(.altinstr_replacement)
>    }
> @@ -111,18 +120,26 @@ SECTIONS
>    .exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) { *(.exit.text) }
>    .exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET) { *(.exit.data) }
>    . = ALIGN(4096);
> -  __initramfs_start = .;
> -  .init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) { *(.init.ramfs) }
> -  __initramfs_end = .;
> +  .init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) {
> +       __initramfs_start = .;
> +       *(.init.ramfs)
> +       __initramfs_end = .;
> +  }
>    . = ALIGN(32);
> -  __per_cpu_start = .;
> -  .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) { *(.data.percpu) }
> -  __per_cpu_end = .;
> +  .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) {
> +       __per_cpu_start = .;
> +       *(.data.percpu)
> +       __per_cpu_end = .;
> +  }
>    . = ALIGN(4096);
> -  __init_end = .;
> +  .init.end : AT(ADDR(.init.end) - LOAD_OFFSET) {
> +       __init_end = .;
> +  }
>    /* freed after init ends here */
>
> -  __bss_start = .;             /* BSS */
> +  .bss.start : AT(ADDR(.bss.start) - LOAD_OFFSET) {
> +       __bss_start = .;                /* BSS */
> +  }
>    .bss.page_aligned : AT(ADDR(.bss.page_aligned) - LOAD_OFFSET) {
>         *(.bss.page_aligned)
>    }
> @@ -130,13 +147,16 @@ SECTIONS
>         *(.bss)
>    }
>    . = ALIGN(4);
> -  __bss_stop = .;
> -
> -  _end = . ;
> +  .bss.end : AT(ADDR(.bss.end) - LOAD_OFFSET) {
> +       __bss_stop = .;
> +       _end = . ;
> +  }
>
>    /* This is where the kernel creates the early boot page tables */
>    . = ALIGN(4096);
> -  pg0 = .;
> +  .pg : AT(ADDR(.pg) - LOAD_OFFSET) {
> +       pg0 = .;
> +  }
>
>    /* Sections to be discarded */
>    /DISCARD/ : {
> _

--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
