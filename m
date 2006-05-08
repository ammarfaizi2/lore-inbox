Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWEHTAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWEHTAK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 15:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWEHTAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 15:00:10 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:2688 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1750730AbWEHTAI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 15:00:08 -0400
Date: Mon, 8 May 2006 12:03:12 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [git patches] kbuild fixes for -rc
Message-ID: <20060508190312.GB2697@moss.sous-sol.org>
References: <20060508050809.GA2247@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060508050809.GA2247@mars.ravnborg.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

* Sam Ravnborg (sam@ravnborg.org) wrote:
> commit c8d8b837ebe4b4f11e1b0c4a2bdc358c697692ed
> Author: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Date:   Tue Apr 25 01:53:43 2006 +0900
> 
>     kbuild: fix modpost segfault for 64bit mipsel kernel
>     
>     64bit mips has different r_info layout.  This patch fixes modpost
>     segfault for 64bit little endian mips kernel.
>     
>     Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>     Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

This one breaks building 32-bit x86 kernels on x86_64 box.  Hmm, actually,
breaks 32-bit x86 build...period.

<snip>
> @@ -709,10 +709,17 @@ static void check_sec_ref(struct module 
>  		for (rela = start; rela < stop; rela++) {
>  			Elf_Rela r;
>  			const char *secname;
> +			unsigned int r_sym;
>  			r.r_offset = TO_NATIVE(rela->r_offset);
> -			r.r_info   = TO_NATIVE(rela->r_info);
> +			if (hdr->e_ident[EI_CLASS] == ELFCLASS64 &&
> +			    hdr->e_machine == EM_MIPS) {
> +				r_sym = ELF64_MIPS_R_SYM(rela->r_info);

$ make ARCH=i386 bzImage
  HOSTCC  scripts/mod/modpost.o
/home/chrisw/hg/linux/linux-2.6/scripts/mod/modpost.c: In function ‘check_sec_ref’:
/home/chrisw/hg/linux/linux-2.6/scripts/mod/modpost.c:716: error: cast to union type from type not present in union

Perhaps something at compile time keyed from mk_elfconfig, and drop the
change to modpost.c?

As in, mk_elfconfig can generate:
"#define KERNEL_ELFMACHINE EM_$MACHINE"

And modpost.h can define:
#if KERNELCLASS == ELF32CLASS
...
#define ELF_R_SYM ELF32_R_SYM
...
#else
#if KERNEL_ELFMACHINE == EM_MIPS
/* Mips specific relocation stuff */
...
#define ELF_R_SYM ELF64_MIPS_R_SYM
#else
#define ELF_R_SYM ELF64_R_SYM
#endif
...
#endif

thanks,
-chris
