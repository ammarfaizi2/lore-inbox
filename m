Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130572AbRCEAVz>; Sun, 4 Mar 2001 19:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130579AbRCEAVq>; Sun, 4 Mar 2001 19:21:46 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:21114 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130552AbRCEAVg>; Sun, 4 Mar 2001 19:21:36 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <andrewm@uow.edu.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-pre1 mkdep and symlinked $TOPDIR 
In-Reply-To: Your message of "Sun, 04 Mar 2001 16:24:57 +1100."
             <3AA1D1A9.3A35557A@uow.edu.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Mar 2001 11:21:21 +1100
Message-ID: <32558.983751681@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Mar 2001 16:24:57 +1100, 
Andrew Morton <andrewm@uow.edu.au> wrote:
>I do builds in /usr/src/linux, which is a symlink
>to /usr/src/linux-akpm.  The recent `mkdep' changes
>have broken this practice most horridly.  When searching
>.hdepend, `make' doesn't recognise that nested headers
>have changed. This is because .hdepend has things like
>
>/usr/src/linux/include/asm/byteorder.h: \
>   /usr/src/linux-akpm/include/asm/types.h \

I do not see this problem in 2.4.3-pre2.

# ls -l linux 
lrwxrwxrwx   1 kaos     ocs            10 Mar  5 10:47 linux -> 2.4.3-pre2
# cd linux
# make dep
make dep
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o scripts/mkdep scripts/mkdep.c
make[1]: Entering directory `/usr/src/2.4.3-pre2/arch/i386/boot'
make[1]: Nothing to be done for `dep'.
make[1]: Leaving directory `/usr/src/2.4.3-pre2/arch/i386/boot'
scripts/mkdep -- init/*.c > .depend
scripts/mkdep -- `find /usr/src/2.4.3-pre2/include/asm /usr/src/2.4.3-pre2/include/linux /usr/src/2.4.3-pre2/include/scsi /usr/src/2.4.3-pre2/include/net -name SCCS -prune -o -follow -name \*.h ! -name modversions.h -print` > .hdepend

The find command is given the real pathname, not the symlink so the
.hdepend and .depend files all contain the real paths.  Your problem is
probably this line in the top level Makefile.

TOPDIR	:= $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)

TOPDIR must be getting set to the symlink name instead of the real
pathname.  Can you confirm what TOPDIR is being set to and why?  This
may be a shell problem.

TOPDIR	:= $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)
dummy	:= $(shell echo PWD="$$PWD" pwd=$(shell pwd) TOPDIR=$(TOPDIR) >&2)

