Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbULDEUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbULDEUq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 23:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbULDEUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 23:20:46 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:39870 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262528AbULDEUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 23:20:31 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: Sam Ravnborg <sam@mars.opasia.dk>
Subject: Re: uml fixes to kbuild
Date: Sat, 4 Dec 2004 05:23:40 +0100
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
References: <20040911182720.GB8380@mars.ravnborg.org> <200411040039.14071.blaisorblade_spam@yahoo.it> <20041104203341.GA8103@mars.opasia.dk>
In-Reply-To: <20041104203341.GA8103@mars.opasia.dk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412040523.40952.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 21:33, Sam Ravnborg wrote:
> On Thu, Nov 04, 2004 at 01:39:13AM +0200, BlaisorBlade wrote:
> > On Saturday 11 September 2004 20:27, Sam Ravnborg wrote:
> >
> > General kbuild issues:
> > 1) LDFLAGS_name.o should be applied even when linking modules - this is a
> > general issue, which I hit hard also in UML (but even in other cases).
> > Actually, the UML use of this is probably not needed (libpcap.a is too
> > screwed up, so I'll need to patch it - they define a common symbol called
> > "vmap" conflicting with the kernel one, which could easily be static but
> > isn't).
>
> That's inconsistent. I will fix that.

Thanks. Have you done it? I've not seen that in the last big merge I've seen.

Also, about localversion, I posted a patch to refuse a file name ending in 
"~" (which you merged promptly in "the last big merge"). It's possible to 
extend it to everything having a "~" in the middle, like patch-scripts and 
quilt backup files (and maybe even Emacs backups, though I don't use Emacs)?

I don't think that there are good reasons to let it as-is, i.e. nobody created 
a "localversion-~thispatch" with the ~ as a real part of the name and not as 
a backup marker.

> > UML-specific issues:
> >

> For klibc I have similar requirments.
> I envision making support for:
>
> uobj-y := bugs.o ptrace_user.o ...
> obj-y  := checksum.o fault.o ...

> But right now I cannot see how to tell kbuild to link it all together.
> I want to create some infrastructure I can share with klibc.

Basically, uobj-y, for UML purpose, should also share the MODVERSIONS 
postprocessing and anything such.

The only change is to avoid using normal CFLAGS. When I coded it first, I was 
using a "if file not in USER_OBJS then add kernel cflags". Now, the ugly 
thing of that old patch is double listing the objects, but anyway it's near 
to what I'd like.

A CFLAGS_$@_no_kernel_flags would maybe help, but then you need a foreach, and 
you must update the make version in Documentation/Changes. The needed version 
was released in 2002, so I hope it's not a problem to require the update, but 
you decide. Not sure if this "foreach loop" is needed... 

> > 3) building with O=<somewhere>, which breaks because there is also
> > arch/um/include (containing also generated headers). This is needed
> > because those headers are common to both user- and kernel-space files.
> > However, that contains also generated headers, and there are also some
> > other include files inside arch/um/kernel/{tt,skas}/include.
> >
> > One particular problem, about this, is that -Iarch/um/include is turned
> > in -I$(srctree)/arch/um/include, which does not make sense for UML since
> > it needs to include some generated headers being kept in arch/um/include.
> >
> > The arch/um/include headers cannot be moved into include/asm-um because
> > they are needed from userspace files.
>
> To rephrase.
> A way to let an architecture generate .h files that is not saved in
> include/asm. I will give it some more thoughts.

This is simpler, probably
Ideas:
1)
CFLAGS += $(call add_include_path)

after defining it someway to be -I srcpath (or -I a folder including the 
symlink, if some particular section is requested - I refer to include2 with 
the "asm" symlink)  -I objpath, and to mkdir -p the needed folders - it's 
like

# Use LINUXINCLUDE when you must reference the include/ directory.
# Needed to be compatible with the O= option
LINUXINCLUDE    := -Iinclude \
                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)

only abstracted a bit.

Also, I'm happy to see this advanced handling, which I want to look:

# Prefix -I with $(srctree) if it is not an absolute path
addtree = $(if $(filter-out -I/%,$(1)),$(patsubst -I%,-I$(srctree)/%,$(1))) 
$(1)
# Find all -I options and call addtree
flags = $(foreach o,$($(1)),$(if $(filter -I%,$(o)),$(call addtree,$(o)),
$(o)))

Last time I looked, it was just "Prefix -I with $(srctree)", without the 
"absolute path" clause, and I was too shy to fix it :-(. So it might be 
easier to do!
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

