Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317077AbSFFSeK>; Thu, 6 Jun 2002 14:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317047AbSFFSd1>; Thu, 6 Jun 2002 14:33:27 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:2026 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S317077AbSFFSbr>; Thu, 6 Jun 2002 14:31:47 -0400
Date: Thu, 6 Jun 2002 11:31:48 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.19-pre10-ac2 
In-Reply-To: <4646.1023367891@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0206061115390.27067-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2002, Keith Owens wrote:

> On Thu, 6 Jun 2002 11:11:09 +0100 (BST),
> Matt Bernstein <matt@theBachChoir.org.uk> wrote:
> >Since when was it OK to do a parallel make dep?
>
> Arch dependent.  Parallel make dep will generate incomplete output on
> some architectures, mainly those that generate files at make dep time.
> mkdep.c only adds .h files to .[h]depend if the file exists.  With
> parallel make dep the scanning of .c files can occur before the .h
> files have been generated, resulting in an incomplete dependency tree.
> Later changes may not rebuild everything that should be rebuilt.

hmm, so i can imagine there being a race condition there somewhere... but
i just tried comparing a few "make -j3 dep" trees versus a "make dep" tree
and there weren't any differences.  (i'm building for i386).

anyhow, i think i see the problem.

in the top level Makefile there's this:

	tmp_include_depends: include/config/MARKER dummy
		$(MAKE) -r -f tmp_include_depends all

and if you look in tmp_include_depends it has all the header files on the
LHS of dependencies (it touches them all)... but there's no .PRECIOUS for
any of the header files.  so if you hit ^C while this is going on you'll
lose source files.

i believe the patch below fixes the problem... but i couldn't hit ^C at
the right time to reproduce it, so maybe there's something else going on.

btw, it doesn't appear like anything actually uses .hdepend... at least i
couldn't see a use when i grepped the tree for '\.hdepend', maybe it's
hidden somewhere.

-dean

--- linux/Makefile.orig	Thu Jun  6 10:44:29 2002
+++ linux/Makefile	Thu Jun  6 11:26:36 2002
@@ -494,6 +494,7 @@
 endif
 	(find $(TOPDIR) \( -name .depend -o -name .hdepend \) -print | xargs $(AWK) -f scripts/include_deps) > tmp_include_depends
 	sed -ne 's/^\([^ ].*\):.*/  \1 \\/p' tmp_include_depends > tmp_include_depends_1
+	(echo ""; echo ".PRECIOUS: \\"; cat tmp_include_depends_1; echo "") >> tmp_include_depends
 	(echo ""; echo "all: \\"; cat tmp_include_depends_1; echo "") >> tmp_include_depends
 	rm tmp_include_depends_1


