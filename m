Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbTJPVcu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 17:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbTJPVcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 17:32:50 -0400
Received: from [193.138.115.2] ([193.138.115.2]:28690 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S263227AbTJPVcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 17:32:48 -0400
Date: Thu, 16 Oct 2003 23:30:23 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Peter Bergner <bergner@vnet.ibm.com>
cc: linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: [BUG][PATCH] fs/binfmt_elf.c:load_elf_binary() doesn't verify
 interpreter arch
In-Reply-To: <3F8F07FA.1030006@vnet.ibm.com>
Message-ID: <Pine.LNX.4.56.0310162308550.3186@jju_lnx.backbone.dif.dk>
References: <3F8F07FA.1030006@vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Oct 2003, Peter Bergner wrote:

> In fs/binfmt_elf.c:load_elf_binary() (both 2.6 and 2.4), there is some minimal
> checking whether the interpreter it's about to load/run is a valid ELF file,
> but it fails to check whether the interpreter is of the correct arch.
> We ran into this when a borked powerpc64-linux toolchain set the interpreter
> on our 64-bit app to our 32-bit ld.so.  Executing the app caused the kernel to
> really chew up memory.  I'm assuming x86_64 and sparc64 might possibly see
> the same behavior.
>
> A patch against 2.6 is attached below for review (although it applies with some
> fuzz on 2.4).  Note I'm not sure of the history behind INTERPRETER_AOUT, so I
> added the test for INTERPRETER_ELF so as not to change it's behavior in case
> someone still relies on it.
>
> As an aside, it seems the elf_check_arch() macros should really be checking
> for more than a valid e_machine value.  I'd think checking one or more of the
> e_ident[EI_CLASS], e_ident[EI_DATA] and e_ident[EI_OSABI] values would be
> required as well, no?
>

I've been looking at binfmt_elf.c myself as well, and I've noticed that
there are a few things it doesn't check, like:

e_version
(only one ELF version exists, but why not check anyway,
might catch a corrupted executable or when new ELF versions /do/ appear
the code to reject formats not supported is in place - seems right to me
to check it - basic sanity check)

e_ehsize
(Linux seems to ignore this. It's there to validate that the ELF header
has the correct size - why not check?  Again, this might catch corrupted
executables. Seems like the prudent thing to do, to me)

I seem to remember a few other things that could be checked that currently
are not, but I can't remember those off the top of my head (I need to go
re-read ftp://tsx.mit.edu/pub/linux/packages/GCC/ELF.doc.tar.gz)

I've been thinking of trying to fix binfmt_elf.c up a bit to do as much
validation as possible (seems to me that the more checking we do the safer
we'll be - I don't se any reason /not/ to check), but I have not yet
gotten my head wrapped around enough of the code to actually write a patch
yet.

I don't really know what the purpose of this reply is other than to say
that you're not the only one approaching this, and that if you need
someone to test patches, then I don't mind doing that.. :)


Regards,

Jesper Juhl

