Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSEEKQl>; Sun, 5 May 2002 06:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293337AbSEEKQk>; Sun, 5 May 2002 06:16:40 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:23045 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S293203AbSEEKQj>;
	Sun, 5 May 2002 06:16:39 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Sun, 05 May 2002 02:43:04 MST."
             <20020505094304.GG2392@matchmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 May 2002 20:16:29 +1000
Message-ID: <5015.1020593789@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 May 2002 02:43:04 -0700, 
Mike Fedyk <mfedyk@matchmail.com> wrote:
>On Thu, May 02, 2002 at 04:17:36PM +0100, Alan Cox wrote:
>> The kernel release isnt useful info. Many interfaces are stable across
>> multiple kernels, many interface issues depend on things other than kernel
>> version. Lots of people apply patches and don't change the base kernel
>> version - in fact its hard to do so
>
>Changing one line in Makefile is hard?  I do that every time I patch my
>kernels.  It lets me track easily what kernels I have installed just by `ls
>/boot`, and the name shows up in my kernel .deb. :)

Not hard, just expensive.  From kbuild 2.5.

# FIXME: Current kernel source includes linux/version.h, mainly to get
# KERNEL_VERSION().  version.h also includes UTS_RELEASE which changes every
# time the kernel identifiers change.  The presence of UTS_RELEASE in version.h
# causes lots of unnecessary recompilations, very few places actually want
# UTS_RELEASE.  The new makefile generates separate linux/version.h and
# linux/uts_release.h, with version.h including utsname.h to avoid compilation
# errors.  Find all the source code that needs just UTS_RELEASE and change it to
# include uts_release.h, then remove #include <linux/uts_release.h> from the
# commands below.  KAO

There are less than 10 places in the kernel that really need
UTS_RELEASE.  Alas it is defined in version.h which is included by 99%
of the code, either directly or indirectly.  Change the top level
Makefile and 99% of the kernel gets recompiled.

I have deliberately not fixed this problem in kbuild 2.4.  The full
dependency chain goes Makefile -> version.h -> everything else.
Removing the dependency of Makefile -> version.h looks like a good
idea, but it exposes potential bugs that are currently hidden by the
extra recompiles.

Remove that dependency and other changes to Makefile such as target
changes will not cause rebuilds when they should.  kbuild 2.4 does not
have a complete list of dependencies on the top level Makefile, it
works by accident because of the chain Makefile -> version.h -> 99% of
the kernel.

All fixed in kbuild 2.5, of course.

