Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbTDDVyz (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 16:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbTDDVyz (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 16:54:55 -0500
Received: from mail.casabyte.com ([209.63.254.226]:8462 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S261427AbTDDVyv (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 16:54:51 -0500
From: "Robert White" <rwhite@casabyte.com>
To: <root@chaos.analogic.com>, "Stephen Cameron" <steve.cameron@hp.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: How to speed up building of modules?
Date: Fri, 4 Apr 2003 14:05:55 -0800
Message-ID: <PEEPIDHAKMCGHDBJLHKGIECPCGAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.53.0304041601100.5000@chaos>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would add (or amplify) that if you use the target-dependent or conditional
variable assignment features of gmake you can make one Makefile that will
build a module a number of ways.

Consider this extemporaneous example (e.g. I just typed this in to this
email, you may have to play with it to get it to work correctly.)

===== BEGIN =====
OBJECTS = Driver_2.4.20.o Driver_2.4.18.o Driver_RedHat.o
all: $OBJECTS

# note the colon before the equal sign.
# you *DON'T* want the sub-values expanded here, you want them expanded
during use.
# or you could put this after all the conditional assignments
CFLAGS := $(KERNEL_INCLUDE) $(OTHER_CFLAGS) -DMODULE -D_KERNEL_

#OTHER_CFLAGS could be anything for any driver (say architecture -m686
or -m386 etc)
Driver_2.4.20.o: KERNEL_INCLUDE = -I/usr/src/linux-2.4.20/include
Driver_2.4.18.o: KERNEL_INCLUDE = -I/usr/src/linux-2.4.18/include
# etc...

#Set suitable Defaults if nothing else was set
KERNEL_INCLUDE ?= -I/usr/src/linux/include

# The generic dependencies, note that these dependencies *DON'T* look into
the
#   kernel specific directories.  They *could* with some work, but I leave
that
#   as an exercise as I am in a hurry here 8-).  (you might need "::"
instead of just ":"
$(OBJECTS): Driver.c Driver.h
	$(CC) $(CFLAGS) $< -o $@
# Finally you needed a build rule to make the target, you will use $< and $@
and such
#   Since "Driver.c" is the first prerequisite, that is what $< will always
be.
#   (yes, it could have been hard coded 8-).  $@ is the module you are
building just now.
===== END =====

In some early versions of make, you couldn't do the "all" thing because that
would have been the target for the entire make.  I don't know if this is
still true.  If it is, you probably don't need it at all because then the
first target would be the "$(OBJECTS):" line.  If make still gripes, just
make a script that uses this kind of make file in a loop, that is which
repeatedly invokes "make $TargetName" once for each target module.

Like I said, you may have to play with it.

"info make" is your friend.  Just read the whole thing or follow the various
paths to the "target dependent assignments" and "static rules" and such.

Rob.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Richard B.
Johnson
Sent: Friday, April 04, 2003 1:17 PM
To: Stephen Cameron
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to speed up building of modules?


On Fri, 4 Apr 2003, Stephen Cameron wrote:

> Hi
>
> I'm wondering if you guys know any tricks to speed up building
> of linux kernel modules.
>
> First, some background.
>
> We have to put out binary HBA driver modules for a variety
> of linux distributions for things like driver diskettes, to allow
> new drivers to be used during initial install.  (I'm thinking
> of the cciss, cpqarray and cpqfc drivers.)
>
> With all the distributions, and differnent
> offerings of distributions, and errata kernels... today, I count
> almost 40 distinct kernels we're trying to support, not counting the
> mainline development on kernel.org, and not counting multiple
> config file variations for each of those 40 or so kernels.
>
> The main catch seems to be the symbol checksums.  In order for those
> to match (and I'm not too interested in subverting those), the
> config files used during the compile need to be very similar.  That
> means building lots and lots of modules.  (Think about all the
> modules which are enabled in redhat's typical default config files.)
> This takes time.  Mulitply 3 drivers * ~40 kernels * several config
> files, and pretty soon... well, pretty soon you don't remember
> what "preety soon" means.
>
> It would be VERY nice if I could find a way to build only the modules
> I care about  and not all the rest, which add hours and hours.
> It seems that some things in the config file can be turned off without
> harm, but it's not clear how I can know whether it's safe to turn a module
> off  Also, sometimes I need to make changes to the Config.in files,
> add options, etc.  Ccache hasn't helped.  (I think because the different
> config files use different compiler flags, and otherwise the kernels
> just aren't the same.)
>
> Any ideas?
>
> Thanks,
>
> -- steve

You can create a Makefile to make only the modules you want.
All you need exists in a kernel tree that has (once) been configured
to build, at least, the modules that you want. It is trivial.
You have to remember to -DMODULE as well as -D__KERNEL__ as a
'C' compile parameter along with the other stuff on the command-line.

Understand that when somebody is designing a module, they just
build it in their own directory but, using -I on the command-line
make sure that the correct kernel headers are used (like
-I/usr/src/linux-2.4.20/include -I.).

So, a typical compile-command for a module would be to define the
correct includes and defines as CFLAGS, export those parameters, then
do make -C drivers/net 3x59x.o from inside your Makefile (to do the
3x59x.o module (it requires mii.o also).


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

