Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSFISDz>; Sun, 9 Jun 2002 14:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314340AbSFISDx>; Sun, 9 Jun 2002 14:03:53 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:63915 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314325AbSFISCt>; Sun, 9 Jun 2002 14:02:49 -0400
Date: Sun, 9 Jun 2002 13:02:26 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.21: kbuild changes broke filenames with commas
In-Reply-To: <20020609175804.B8761@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0206091244500.20459-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jun 2002, Russell King wrote:

> With the latest kbuild version in 2.5.21, we are unable to build the
> following files:
> 
> linux/drivers/block/smart1,2.h
> linux/drivers/scsi/53c7,8xx.c
> linux/drivers/scsi/53c7,8xx.h
> linux/drivers/scsi/53c7,8xx.scr
> linux/arch/arm/mm/proc-arm6,7.S
> linux/arch/arm/mm/proc-arm2,3.S

Well, we're unable to build drivers/scsi/53c7,8xx.c and the two ARM files,
the others just get included, so don't affect the build. 53c7,8xxx is 
broken by BIO changes, so nobody but ARM is affected currently.

> This is because we end up passing gcc the following argument:
> 
> 	-Wp,-MD,.proc-arm6,7.o.d
> 
> which gets passed to cpp0 as:
> 
> 	-MD .proc-arm6 7.o.d
> 	              ^ space, not comma
> 
> and therefore cpp0 sees "-MD", ".proc-arm6" and "7.o.d" as separate
> arguments.
> 
> There seems to be two solutions:
> 
> 1. renaming all the above files to contain '_' instead of ','.
> 2. see if kbuild can use the DEPENDENCIES_OUTPUT environment variable

There's three way around the limitation of "-Wp" to pass arguments 
containing commas to cpp:
o Use the environment variable SUNPRO_DEPENDENCIES instead or
o Invoke cpp directly or
o Rename the generated temporary .d file by substituting ',' with
  something else.

> Kai pointed out that we've already got one exception in kbuild to fixup
> the filename for KBUILD_BASENAME (, -> _ and that's not a weird smilie!)
> so (1) is probably going to be better, and we can get rid of the special
> "comma" handling.

It would in general be saner to generally disallow source file names with 
a ',' in them. Not so much for the build system, but also for the other 
cases where we can't handle them, like e.g. KBUILD_BASENAME as used in 
include/linux/spinlock.h, or in Rusty's work, which will allow to pass
parameters to built-in modules on the kernel command line, like
<module name>.<parm>=<value>.

--Kai


