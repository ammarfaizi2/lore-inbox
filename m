Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276746AbRJHBeE>; Sun, 7 Oct 2001 21:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276749AbRJHBdz>; Sun, 7 Oct 2001 21:33:55 -0400
Received: from zok.SGI.COM ([204.94.215.101]:50873 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S276746AbRJHBdn>;
	Sun, 7 Oct 2001 21:33:43 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.11-pre4 remove spurious kernel recompiles 
In-Reply-To: Your message of "Mon, 08 Oct 2001 03:20:23 +0200."
             <20011008032022.M726@athlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Oct 2001 11:34:04 +1000
Message-ID: <32255.1002504844@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001 03:20:23 +0200, 
Andrea Arcangeli <andrea@suse.de> wrote:
>On Mon, Oct 08, 2001 at 10:42:56AM +1000, Keith Owens wrote:
>> IOW a check for Makefile timestamp is both overkill (it recompiles too
>> much) and incomplete (it does not detect command line overrides).  BTW,
>> kbuild 2.5 gets this right.
>
>That sounds fine. Of course the only regression could be the build time.
>Do you have a benchmark on the build time with kbuild 2.5 applied to
>2.4.10 compared to the build time of 2.4.10?

kbuild 2.5 build times vary from 10% faster to 100% slower, depending
on the number of objects being compiled.  There are some O(n^2)
algorithms in kbuild 2.5, I know where they are and how to fix them, it
just takes time that I don't have right now.  At the moment I am
concentrating on correctness for kbuild 2.5.  MEC mantra:

  Correctness comes first. 
  Then maintainability. 
  Then speed.

>> module.h currently uses the full UTS_RELEASE which includes
>> EXTRAVERSION but that is spurious, modutils ignores EXTRAVERSION when
>> loading a module.  modutils only cares about VERSION, PATCHLEVEL and
>> SUBLEVEL.
>
>Well again EXTRAVERSION was just an example, SUBLEVEL was the same
>problem as EXTRAVERSION for me, I mean after you apply an -ac patch that
>for example goes backwards in the SUBLEVEL, do you recompile everything
>or do you just run make after your Makefile patch is applied to the
>kernel?

Changing VERSION, PATCHLEVEL or SUBLEVEL requires a recompile of
anything that tests LINUX_VERSION_CODE, including everything that
includes module.h.  That already occurs because the timestamp of
include/linux/version.h changes.  I pointed this out in the patch
notes.

My patch to the Makefile does not (cannot) change the dependencies on
LINUX_VERSION_CODE.  I am removing the spurious recompiles caused by
changing EXTRAVERSION and by changing lines in the top level Makefile
that do not directly affect objects.  With my patch only the required
objects are rebuilt.

BTW, how can you apply a -ac patch that sets SUBLEVEL backwards?  -ac
patches are against the Linus tree with the same VERSION, PATCHLEVEL
and SUBLEVEL.

