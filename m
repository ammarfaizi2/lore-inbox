Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUAIKxy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 05:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266487AbUAIKxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 05:53:54 -0500
Received: from [193.138.115.2] ([193.138.115.2]:42249 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S266486AbUAIKxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 05:53:51 -0500
Date: Fri, 9 Jan 2004 11:50:53 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jakub Jelinek <jakub@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity
 checking
In-Reply-To: <20040109102851.GF24876@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.56.0401091141200.12106@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0401090236390.11276@jju_lnx.backbone.dif.dk>
 <20040109102851.GF24876@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jan 2004, Jakub Jelinek wrote:

> On Fri, Jan 09, 2004 at 03:19:12AM +0100, Jesper Juhl wrote:
> > --- linux-2.6.1-rc1-mm2-orig/fs/binfmt_elf.c    2003-12-31 05:47:13.000000000 +0100
> > +++ linux-2.6.1-rc1-mm2/fs/binfmt_elf.c 2004-01-09 01:41:05.000000000 +0100
> > @@ -482,11 +482,14 @@ static int load_elf_binary(struct linux_
> >         /* First of all, some simple consistency checks */
> >         if (memcmp(elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
> >                 goto out;
> > -
> > +       if (elf_ex.e_ident[EI_CLASS] == ELFCLASSNONE)
> > +               goto out;
> >         if (elf_ex.e_type != ET_EXEC && elf_ex.e_type != ET_DYN)
> >                 goto out;
> >         if (!elf_check_arch(&elf_ex))
> >                 goto out;
> > +       if (elf_ex.e_version == EV_NONE)
> > +               goto out;
> >         if (!bprm->file->f_op||!bprm->file->f_op->mmap)
> >                 goto out;
>
> These checks look useless for me.
> If you want to check EI_CLASS or e_version, why is 0 so special and not say
> 157?

You are absolutely correct. Those tests are very weak, and (as I tried to
explain in my original mail), I did not intend the patch to be merged as
it was. I only did those (admittedly very weak) checks initially to be
able to easily verify with a test program that my checks where indeed
checking the right fields of the ELF header, and that introducing
aditional checking did not make the kernel "blow up".
I'm working on a proper patch that'll do the real checks of these ELF
header fields, as well as add additional checks.
I'll be submitting that patch as soon as it's done. I'm aiming to have
something ready during the weekend.

> Why not to check EI_DATA and EI_VERSION as well though?
> glibc loader does:

I plan to.
I just wanted to get some feedback initially. The patch was a very minor
bit of the email I send, and probably the least important bit.
I wanted to get peoples reactions to the thought of adding stronger sanity
checks. The patch was just a minor thing - the discussion about "do we
want additional checks?" was the important bit.


> Perhaps binfmt_elf.c wants to be able to load different OSABI ELF objects,
> if so, it could just memcmp the first EI_OSABI bytes of e_ident and check
> e_version and other fields outside of e_ident.
>
I'll keep that in mind. Thank you.


-- Jesper Juhl

