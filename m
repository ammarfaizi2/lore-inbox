Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266522AbUAIK3Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 05:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266523AbUAIK3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 05:29:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50567 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266522AbUAIK3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 05:29:08 -0500
Date: Fri, 9 Jan 2004 05:28:51 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Jesper Juhl <juhl@dif.dk>
Cc: linux-kernel@vger.kernel.org, Eric Youngdale <ericy@cais.com>
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity checking
Message-ID: <20040109102851.GF24876@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Pine.LNX.4.56.0401090236390.11276@jju_lnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0401090236390.11276@jju_lnx.backbone.dif.dk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 03:19:12AM +0100, Jesper Juhl wrote:
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

These checks look useless for me.
If you want to check EI_CLASS or e_version, why is 0 so special and not say
157?
If you want to be sure EI_CLASS and e_version are correct, the test should
be:
	if (elf_ex.e_ident[EI_CLASS] != ELF_CLASS)
		goto out;
resp.
	if (elf_ex.e_version != EV_CURRENT)
		goto out;
Furthermore, there is load_elf_interp, which needs similar checks, otherwise
they are useless, because you can create a proper ELF binary loading
incorrect ELF interpreter.
Why not to check EI_DATA and EI_VERSION as well though?
glibc loader does:
#ifndef VALID_ELF_HEADER
# define VALID_ELF_HEADER(hdr,exp,size) (memcmp (hdr, exp, size) == 0)
# define VALID_ELF_OSABI(osabi)         (osabi == ELFOSABI_SYSV)
# define VALID_ELF_ABIVERSION(ver)      (ver == 0)
#endif
  static const unsigned char expected[EI_PAD] =
  {
    [EI_MAG0] = ELFMAG0,
    [EI_MAG1] = ELFMAG1,
    [EI_MAG2] = ELFMAG2,
    [EI_MAG3] = ELFMAG3,
    [EI_CLASS] = ELFW(CLASS),
    [EI_DATA] = byteorder,
    [EI_VERSION] = EV_CURRENT,
    [EI_OSABI] = ELFOSABI_SYSV,
    [EI_ABIVERSION] = 0
  };
      if (__builtin_expect (! VALID_ELF_HEADER (ehdr->e_ident, expected,
                                                EI_PAD), 0))
        {
...
	}
      if (__builtin_expect (ehdr->e_version, EV_CURRENT) != EV_CURRENT)
        {
          errstring = N_("ELF file version does not match current one");
          goto call_lose;
        }
      if (! __builtin_expect (elf_machine_matches_host (ehdr), 1))
        goto close_and_out;
...

Perhaps binfmt_elf.c wants to be able to load different OSABI ELF objects,
if so, it could just memcmp the first EI_OSABI bytes of e_ident and check
e_version and other fields outside of e_ident.

	Jakub
