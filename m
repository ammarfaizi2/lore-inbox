Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVJLAmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVJLAmd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 20:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbVJLAmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 20:42:33 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:23414 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932346AbVJLAmc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 20:42:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WmEU0pBlpTd3cXS0nr+8NZCh3C4Bx58TPbGQNywseQYQyY4f/uuE1KHxPipyJxIjaiQJI8ABGom7S4oic9jEuRSTQIpJxcwnSZoL641mItiMNGEMsxMAgm8w9BhjuDztj5Q3alU1r+VD3+rgqBMMVjhGQjtARF0cegZ4qjDlUEw=
Message-ID: <2cd57c900510111742i2231b785q6b60090e963b0d76@mail.gmail.com>
Date: Wed, 12 Oct 2005 08:42:31 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: - binfmt_elf-bss-padding-fix.patch removed from -mm tree
Cc: tzachar@cs.bgu.ac.il, dan@debian.org, roland@redhat.com, pluto@agmk.net,
       linux-kernel@vger.kernel.org, jbglaw@lug-owl.de, vonbrand@inf.utfsm.cl
In-Reply-To: <200510112000.j9BK0lCF024476@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510112000.j9BK0lCF024476@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/05, akpm@osdl.org <akpm@osdl.org> wrote:
>
> The patch titled
>
>      binfmt_elf bss padding fix
>
> has been removed from the -mm tree.  Its filename is
>
>      binfmt_elf-bss-padding-fix.patch
>
> This patch was probably dropped from -mm because
> it has already been merged into a subsystem tree
> or into Linus's tree
>
>
>
> Nir Tzachar <tzachar@cs.bgu.ac.il> points out that if an ELF file specifies a
> zero-length bss at a whacky address, we cannot load that binary because
> padzero() tries to zero out the end of the page at the whacky address, and
> that may not be writeable.
>
> See also http://bugzilla.kernel.org/show_bug.cgi?id=5411
>
> So teach load_elf_binary() to skip the bss settng altogether if the elf file
> has a zero-length bss segment.
>
> Cc: Roland McGrath <roland@redhat.com>
> Cc: Daniel Jacobowitz <dan@debian.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  fs/binfmt_elf.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>
> diff -puN fs/binfmt_elf.c~binfmt_elf-bss-padding-fix fs/binfmt_elf.c
> --- devel/fs/binfmt_elf.c~binfmt_elf-bss-padding-fix    2005-10-11 08:15:14.000000000 -0700
> +++ devel-akpm/fs/binfmt_elf.c  2005-10-11 08:15:14.000000000 -0700
> @@ -905,7 +905,7 @@ static int load_elf_binary(struct linux_
>                 send_sig(SIGKILL, current, 0);
>                 goto out_free_dentry;
>         }
> -       if (padzero(elf_bss)) {
> +       if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bss))) {
>                 send_sig(SIGSEGV, current, 0);
>                 retval = -EFAULT; /* Nobody gets to see this, but.. */
>                 goto out_free_dentry;
> _


This is simply not complete. load_elf_binary() is fixed.
load_elf_library() need to be fixed too. And theoretically
load_elf_interp() too.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
