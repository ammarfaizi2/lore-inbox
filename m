Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265140AbUAMT5Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 14:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbUAMT5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 14:57:24 -0500
Received: from [193.138.115.2] ([193.138.115.2]:33547 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265140AbUAMT5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 14:57:15 -0500
Date: Tue, 13 Jan 2004 20:54:08 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jakub Jelinek <jakub@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Eric Youngdale <eric@andante.org>
Subject: Re: [PATCH] stronger ELF sanity checks v2
In-Reply-To: <20040113173509.GM31589@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.56.0401131915370.3148@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0401130228490.2265@jju_lnx.backbone.dif.dk>
 <20040113173509.GM31589@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Jan 2004, Jakub Jelinek wrote:

> On Tue, Jan 13, 2004 at 02:55:07AM +0100, Jesper Juhl wrote:
> >
> > +	if ((elf_ex.e_version != EV_CURRENT) ||
> > +	    (elf_ex.e_version != elf_ex.e_ident[EI_VERSION]) ||
>
> Why are you checking elf_ex.e_ident[EI_VERSION] again?
> You previously checked that elf_ex.e_version == EV_CURRENT and
> elf_ex.e_ident[EI_VERSION] == EV_CURRENT.
>
Right, that's completely redundant. My brain must have been out for lunch
for a while there.


> Also, comment about e_version increasing is not needed IMHO.
> There is no ELF version bumping anywhere on the horizon.
>
Ok, the comment should probably go the way of the Dodo then.


> > +	    /* how can we check e_entry? any guarenteed invalid entry points? */
> > +	    /* need to come up with valid checks for e_phoff & e_shoff */
>
> Why?
>

For much the same reasons that I want to check everything else. If
all the information in the ELF header is not valid then I'd consider the
binary corrupt. If a file claims to be an ELF binary, then it should be a
/valid/ ELF binary, and the more we can do to ensure that the better.

As I see it, if a binary contains invalid information then either the
tools that created the binary are corrupt or something has
(incorrectly) modified the binary since its creation.
In both cases I see no reason why the kernel should not throw out the
binary as early as possible.

I tried to outline my reasons for doing this in a previous mail to lkml,
but I'll repeat them here for your convenience.

"
- Correctness. If it's invalid it /should/ fail, and as early as possible.

 - Stability. Who knows when it'll crash and what damage it may have done
before it crashes?

 - Least amount of surprise for the user. If a binary has become corrupted
the user is likely to want to be told it's bad when loading it (if
possible), rather than being left wondering about strange crashes during
runtime.

 - Security 1. Is it not plausible that someone may try to play tricks on
the kernel with invalid binaries? Isn't it safer just rejecting them if we
*know* they are bad?

 - Security 2. If a virus/worm/trojan/whatever attempts to infect a binary
and does not do a perfect job of fixing up the ELF header, section table
headers etc, then with the current code we would in some cases still run
the binary. If we enforce as many sanity checks as possible such an
infected binary will likely fail to run.
"

To that I'll add "defensive programming". In my experience it's never wise
to trust sources you don't have 100% control over, and I don't think that
there is any source as un trust worthy as userspace from the kernels
perspective. So, we are given a binary to load and execute from an
un-trusted source and I think it's prudent to be as thorough as possible
in validating that binary in as many ways as we possibly can before
executing it.
It doesn't matter if the kernel actually uses the information it
validates. If the kernel detects anything at all to be out of place that
it has in its power to properly validate then that binary should not be
deemed fit to execute. I think that's a fairly pragmatic and wise
approach.


> > +	    /* e_flags is checked by elf_check_arch */
> > +	    (elf_ex.e_ehsize != sizeof(Elf_Ehdr)) ||
>
> This belongs to elflint, not kernel.
>
> > +	    /* e_phentsize checked below */
> > +	    /* how can we check e_phnum, e_shentsize & e_shnum ? */
> > +	    /* check for e_shstrndx needs to improve */
> > +	    ((elf_ex.e_shstrndx == SHN_UNDEF) && (elf_ex.e_shnum != 0)))
>
> Kernel has no business looking at sections.  It doesn't use them,
> why should it care?
>
It should care becourse if something (anything that the kernel can
validate) is wrong with the binary then it's suspicious and either the
binary is simply broken (and to be nice to the user we should fail early)
or someone is trying to load a binary that might be attempting to do
something it shouldn't and for safety reasons we should reject it to avoid
it causing trouble later on.  The earlier you catch potential problems and
react to them the less chance they have of potentially damaging something.


> >  	/* Now read in all of the header information */
> > @@ -506,6 +547,14 @@ static int load_elf_binary(struct linux_
> >  	if (retval < 0)
> >  		goto out_free_ph;
> >
> > +	/* p_filesz must not exceed p_memsz.
> > +	   if it does then the binary is corrupt, hence -ENOEXEC
> > +	 */
> > +	if (elf_phdata->p_filesz > elf_phdata->p_memsz) {
> > +		retval = -ENOEXEC;
> > +		goto out_free_ph;
> > +	}
> > +
> >  	files = current->files;		/* Refcounted so ok */
> >  	if(unshare_files() < 0)
> >  		goto out_free_ph;
>
> Why special case first Phdr (which btw doesn't have to be PT_LOAD)?
>
I'm not trying to special case anything. I'm simply working slowly and
making small changes at a time. So what is a special case at the moment
will hopefully evolve into just the first of several similar checks in the
future.
Reason 1: The more changes I make at a time the harder it is to
track down a change which breaks something.
Reason 2: I don't know everything about ELF yet, nor everything that goes
on when loading a binary. I'm learning as I go along and I only want to
make changes that I feel fairly confident are correct.


> >  #define elf_check_arch(x) \
> > -	(((x)->e_machine == EM_386) || ((x)->e_machine == EM_486))
> > +	((((x)->e_machine == EM_386) || ((x)->e_machine == EM_486)) && ((x)->e_flags == 0))
>
> Why?  This seems unnecessary.
>

According to http://x86.ddj.com/ftp/manuals/tools/elf.pdf Book II section
1-2 :

"The ELF header's e_flags member holds bit flags associated with the file.
The Intel architecture defines no flags; so this member contains zero."

So, it's documented that for Intel binaries this flag should be zero, thus
any Intel binary where this flag does not contain zero has been corrupted
(or not generated properly), hence the check. All valid binaries should
pass the check fine, but invalid binaries may fail it - which is the
point.


-- Jesper Juhl

