Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276628AbRJHAm6>; Sun, 7 Oct 2001 20:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276634AbRJHAmt>; Sun, 7 Oct 2001 20:42:49 -0400
Received: from zok.SGI.COM ([204.94.215.101]:30648 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S276628AbRJHAmg>;
	Sun, 7 Oct 2001 20:42:36 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.11-pre4 remove spurious kernel recompiles 
In-Reply-To: Your message of "Mon, 08 Oct 2001 02:05:44 +0200."
             <20011008020544.K726@athlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Oct 2001 10:42:56 +1000
Message-ID: <29190.1002501776@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001 02:05:44 +0200, 
Andrea Arcangeli <andrea@suse.de> wrote:
>On Mon, Oct 08, 2001 at 09:29:06AM +1000, Keith Owens wrote:
>> I did not miss it.  Changing cflags is detected by the
>> .<object>.o.flags files.
>> 
>> ifeq (-D__KERNEL__ -I/build/kaos/2.4.11-pre4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586,$(strip $(subst $(comma),:,$(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_vt.o))))
>> FILES_FLAGS_UP_TO_DATE += vt.o
>> endif
>
>Ok, so the point of all those .flags is to catch per-object cflags changes.

It catches all cflags changes, from global CFLAGS, per directory cflags
and per object cflags.  I repeat, you do not need to detect changes to
the top level Makefile in order to detect cflag changes.

>CFLAGS was only an example, think if I change CC or EXTRAVERSION, but, as
>said in the earlier email, I doubt an EXTRAVERSION change would work
>without a full distclean in between anyways.

Of course it works.  EXTRAVERSION is only a human readable string used
by 15 sources (via UTS_RELEASE) and by the various logo.h files.
Changing EXTRAVERSION has no effect on executable code, it only affects
display fields.  Any other files changed at the same time as
EXTRAVERSION (say by a patch) will be recompiled, based on the
timestamp changes.  Adding a patch which changes EXTRAVERSION does not
require a full recompile, which is why the existing system is broken.

I admit that kbuild 2.4 does not correctly handle changes to CC, if you
"make CC=gcc" then "make CC=kgcc", the kernel is not rebuilt.  You must
manually make distlean or mrproper when changing CC.  Note that
overriding flags on the command line does not change the Makefile so
you cannot rely on the Makefile timestamp to detect command changes,

IOW a check for Makefile timestamp is both overkill (it recompiles too
much) and incomplete (it does not detect command line overrides).  BTW,
kbuild 2.5 gets this right.

module.h currently uses the full UTS_RELEASE which includes
EXTRAVERSION but that is spurious, modutils ignores EXTRAVERSION when
loading a module.  modutils only cares about VERSION, PATCHLEVEL and
SUBLEVEL.

