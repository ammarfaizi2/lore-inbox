Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264485AbUAMRgW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 12:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbUAMRgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 12:36:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39895 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264485AbUAMRf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 12:35:28 -0500
Date: Tue, 13 Jan 2004 12:35:09 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Eric Youngdale <eric@andante.org>, Eric Youngdale <ericy@cais.com>
Subject: Re: [PATCH] stronger ELF sanity checks v2
Message-ID: <20040113173509.GM31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Pine.LNX.4.56.0401130228490.2265@jju_lnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0401130228490.2265@jju_lnx.backbone.dif.dk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 02:55:07AM +0100, Jesper Juhl wrote:
> 
> -	if (elf_ex.e_type != ET_EXEC && elf_ex.e_type != ET_DYN)
> +	/* check all remaining entries in e_ident[] */
> +	if ((elf_ex.e_ident[EI_CLASS] != ELF_CLASS) ||
> +	    (elf_ex.e_ident[EI_DATA] != ELF_DATA) ||
> +	    (elf_ex.e_ident[EI_VERSION] != EV_CURRENT)) /* see comment for e_version */
> +	    /* we don't check anything in e_ident[EI_PAD]
> +	       the ELF spec states that when reading object files, these
> +	       bytes should be ignored - reserved for future use.
> +	     */
>  		goto out;
> -	if (!elf_check_arch(&elf_ex))
> +
> +	/* check remaining ELF header fields */
> +	    /*
> +	      The value 1 for e_version signifies the original file format;
> +	      extensions will create new versions with higher numbers. The
> +	      value of EV_CURRENT, though being 1 currently, will change as
> +	      necessary to reflect the current version number.
> +	      This needs to be kept in mind when new ELF versions come out and
> +	      we want to support both new and old versions.
> +	     */
> +	if ((elf_ex.e_version != EV_CURRENT) ||
> +	    (elf_ex.e_version != elf_ex.e_ident[EI_VERSION]) ||

Why are you checking elf_ex.e_ident[EI_VERSION] again?
You previously checked that elf_ex.e_version == EV_CURRENT and
elf_ex.e_ident[EI_VERSION] == EV_CURRENT.

Also, comment about e_version increasing is not needed IMHO.
There is no ELF version bumping anywhere on the horizon.

> +	    /* how can we check e_entry? any guarenteed invalid entry points? */
> +	    /* need to come up with valid checks for e_phoff & e_shoff */

Why?

> +	    /* e_flags is checked by elf_check_arch */
> +	    (elf_ex.e_ehsize != sizeof(Elf_Ehdr)) ||

This belongs to elflint, not kernel.

> +	    /* e_phentsize checked below */
> +	    /* how can we check e_phnum, e_shentsize & e_shnum ? */
> +	    /* check for e_shstrndx needs to improve */
> +	    ((elf_ex.e_shstrndx == SHN_UNDEF) && (elf_ex.e_shnum != 0)))

Kernel has no business looking at sections.  It doesn't use them,
why should it care?

>  		goto out;
> -	if (!bprm->file->f_op||!bprm->file->f_op->mmap)
> +
> +	if (!bprm->file->f_op || !bprm->file->f_op->mmap)
>  		goto out;
> 
>  	/* Now read in all of the header information */
> @@ -506,6 +547,14 @@ static int load_elf_binary(struct linux_
>  	if (retval < 0)
>  		goto out_free_ph;
> 
> +	/* p_filesz must not exceed p_memsz.
> +	   if it does then the binary is corrupt, hence -ENOEXEC
> +	 */
> +	if (elf_phdata->p_filesz > elf_phdata->p_memsz) {
> +		retval = -ENOEXEC;
> +		goto out_free_ph;
> +	}
> +
>  	files = current->files;		/* Refcounted so ok */
>  	if(unshare_files() < 0)
>  		goto out_free_ph;

Why special case first Phdr (which btw doesn't have to be PT_LOAD)?

>  /* This is really simpleminded and specialized - we are loading an
> diff -up linux-2.6.1-mm2-orig/include/asm-i386/elf.h linux-2.6.1-mm2-juhl/include/asm-i386/elf.h
> --- linux-2.6.1-mm2-orig/include/asm-i386/elf.h	2004-01-09 07:59:46.000000000 +0100
> +++ linux-2.6.1-mm2-juhl/include/asm-i386/elf.h	2004-01-11 00:29:33.000000000 +0100
> @@ -35,9 +35,11 @@ typedef struct user_fxsr_struct elf_fpxr
> 
>  /*
>   * This is used to ensure we don't load something for the wrong architecture.
> + *
> + * Include a check of e_flags - Jesper Juhl <juhl-lkml@dif.dk>
>   */
>  #define elf_check_arch(x) \
> -	(((x)->e_machine == EM_386) || ((x)->e_machine == EM_486))
> +	((((x)->e_machine == EM_386) || ((x)->e_machine == EM_486)) && ((x)->e_flags == 0))

Why?  This seems unnecessary.

	Jakub
