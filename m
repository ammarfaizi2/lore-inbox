Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbTJOLpg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 07:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTJOLpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 07:45:36 -0400
Received: from web80703.mail.yahoo.com ([66.163.170.60]:16742 "HELO
	web80703.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262795AbTJOLpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 07:45:17 -0400
Message-ID: <20031015114516.1047.qmail@web80703.mail.yahoo.com>
Date: Wed, 15 Oct 2003 13:45:16 +0200 (CEST)
From: =?iso-8859-1?q?Hartmut=20Zybell?= <u_zybell@yahoo.de>
Subject: Re: ld-Script needed OR (predicted) Architecture of Kernel 3.0 ;-)
To: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0310141319320.1406@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- "Richard B. Johnson" <root@chaos.analogic.com>
schrieb: > From u_zybell@yahoo.de Tue Oct 14 11:42:18
2003
> To: root@chaos.analogic.com
> From: "[iso-8859-1] Hartmut Zybell"
> <u_zybell@yahoo.de>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: ld-Script needed OR (predicted)
> Architecture of Kernel 3.0 ;-)
> 
>  --- "Richard B. Johnson" <root@chaos.analogic.com>
> schrieb: > On Tue, 14 Oct 2003, [iso-8859-1] Hartmut
> Zybell
> >> wrote:
> >>
> >> > First things first: Please CC me, because I'm
> not
> >> > subscribed.
> >> >
> >> > I need a ld-Script to construct an elf-File
> that
> >> is a
> >> > tar-File too. Can
> >> > anyone help me? Especially the Checksum is
> tricky.
> >> >
> >> [SNIPPED....]
> >>
> >> I don't think you are aware that the kernel is
> >> compressed,
> >> then expanded when installed. It therefore has
> all
> >> the good
> >> attributes of a `tar.gz` file without any of the
> bad
> >> ones.
> >>
> >>
> > Of course I'm aware. But what bad ones do you
> mean?
> 
> The wasted space of the header(s) themselves, plus
> the fact
> that it can't be updated, only re-written from
> scratch.
> 
Sorry for the misunderstanding. I meant the
*uncompressed* image should look like a tar-file.
The compressed one *would* be a tar.gz-file (because
the kernel is compressed with gzip)
> >> Also, we have a module loader and unloader that
> >> allows modules
> >> to be inserted and removed from a running system.
> 
> > Can you remove modules from a running system, that
> > are compiled into the kernel? For instance the
> > Filesystem driver, that were used to boot and is
> > not longer needed because / has another filesystem
> > than
> > /initrd.
> 
> 
> Drivers that are compiled into the kernel are not
> modules.
See below. Very below.
> Once the linking occurs, all information necessary
> to
> replace such code is lost.
> [SNIP]
> information is gone. You can't re-do it.
> 
That was meant to be a rhetoric question to illustrate
why my approach could be usefull. Your answer
illustrates the point I was trying (apparently
unsuccessful) to explain in my first example. 
The ld-script should include this information into
the binary headers that follow the tar headers.
Then tar would extract a .o file with exactly the
same information (although possibly at other
fileoffsets) in it.
> Make a 'C' program with a single variable:
>[SNIP]
> the offsets that are fixed up by either the linker,
> for static linking, or the loader for dynamic.
> 
> Modules relocate at run-time. They are entirely
> different
> than the statically-linked built-in code, even
> though
> both are generated from the same source and create
> nearly indentical object files. The module objects
> contain relocation tables (part of ELF object
> format)
> that allow code to be put anywhere (on certain
> bounadries) and
> then fixed up by the loader. The final fixup
> resolves
> all the relative offsets.
> 
I want the ld-script so that the relocation tables
stay in the static file. Because the kernel is loaded
contigously into the memory these tables and their
associated tar headers are first loaded too. Because I
don't need them in RAM I want the ld-script to make
them
a multiple of 8K long (and fill up with zeros because
of
the compression) so that a fixup routine can copy the
start of a new module over the end of the last page of
the previous module and alias that page in the page
table to both modules and then free up some memory.
> >> There are
> >> even experimental systems that allow the whole
> >> kernel to be
> >> changed without (apparent) re-booting.
> >>
> >> A file with a 'tar' header is useful for
> recovering
> >> a
> >> directory tree, intact, as it was initially
> >> backed-up.
> >> It has no usefulness in the kernel where the
> content
> >> of a file (or files) are located into various
> >> offsets
> >> in RAM. This is done by the linker and 'helper
> code'
> >> within the kernel itself.
> 
> > I seem to have misread here. I *don't* want to
> change
> > the kernel with tar, as you seem to assume. Thats
> why
> > I'm asking for an ld-script. I want to be able to
> > *extract* (READ-ONLY) modules from a kernelfile
> that
> > are compiled into this (not currently running)
> kernel
> > to insert them into the currently running kernel
> to
> > update it. And I want to do it *with* the current
> > module loader.
> 
> You need the original object files. You can't take
> portions of the statically-linked kernel. You need
> these original object files because they contain
> the required relocation information. Once they get
> linked into the kernel, the essential information
> is lost.
That to avoid is the whole idea. See my rant about a
hypothethical module loader in my first post. That
should make a Driver seem a loaded module in memory.
> 
> You can store these object files anyway you want.
I want tar because the ar header conflicts with the
ELF header. The tar header does not.
> The usual way to store them is to use `ar`. The
> existing module loader doesn't know how to extract
> the object files from an archive, but you could
> make a simple script to do it.
> 
I seem to have included such a command into my first
post.
> >
> >> You can readily run an install-system without any
> >> runtime libraries and/or you can use temporary
> ones.
> >> This is currently done for every major
> distribution.
> >>
> > Of course it's done. You have 2 files: one
> staticaly
> > linked to run at install time, one binary archive
> > (descendent of tar) to install into the system.
> > If I could make the binary do double duty as
> install
> > archive, I could save 50% space. Thats a lot on a
> > floppy based install. And make no mistake: Even
> CDROM
> > (not all, I know!) boot from a floppy image.
> 
>[SNIP]
> to attempting to mount it. It's all there, it all
works
> and it doesn't waste the 50% space you claim above.
I wasn't writing about the boot image. I meant the
root
image for install. For instance you need a staticaly
linked mount to use and you need a dynamic one to
install.



__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Logos und Klingeltöne fürs Handy bei http://sms.yahoo.de
