Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269728AbRHMCYJ>; Sun, 12 Aug 2001 22:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269731AbRHMCYA>; Sun, 12 Aug 2001 22:24:00 -0400
Received: from zok.SGI.COM ([204.94.215.101]:53723 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S269728AbRHMCXx>;
	Sun, 12 Aug 2001 22:23:53 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Russell King <rmk@arm.linux.org.uk>
cc: David Woodhouse <dwmw2@infradead.org>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available. 
In-Reply-To: Your message of "Sun, 12 Aug 2001 15:56:33 +0100."
             <20010812155633.B12253@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Aug 2001 12:23:36 +1000
Message-ID: <6629.997669416@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Aug 2001 15:56:33 +0100, 
Russell King <rmk@arm.linux.org.uk> wrote:
>On Mon, Aug 13, 2001 at 12:48:14AM +1000, Keith Owens wrote:
>> No.  The aim is for a user to look at the makefile in a directory and
>> know everything that is created in that directory.  If you allow
>> creation of a file in one directory but storing it in another then you
>> have to search all makefiles to find out what is created in any
>> directory.  Horrible!
>
>Can we have a makefile in include/asm-$(ARCH) then please?
>
>I think stuff like:
>
>#include "../../../../arch/arm/constants.h"
>
>or
>
>#include "../../../../arch/arm/tools/mach-types.h"
>
>is even more disgusting.

Absolutely agree, which is why there are so many FIXME comments in the
Makefile.in files, to remove all the relative includes.  If a source
needs a non-standard include ioutside the current directory then it
should #include <foo.h> and the makefile should point to the directory
containing foo.h.  Knowledge about non-standard include files should be
in the makefile, not embedded in lots of source code.

That still leaves the question of where the generated files should be
written to.  This is getting into philosophy rather than technical, one
man's preference is another's pet hate.  My preference is not to write
to any directory under include.  At the moment kbuild 2.5 has a clean
separation between shipped files under /include and generated files
under arch/$(ARCH).  There are only 5 generated include files and they
are only present for historical reasons.

 include/linux/modversions.h
 include/linux/version.h
 include/linux/uts_release.h
 include/linux/autoconf.h
 include/linux/compile.h

Writing to include/asm is a problem for kbuild 2.5.  When using
separate source and object trees, the asm-$(ARCH) symlink cannot be
created in the source tree, users may want to generate multiple
architectures from a single source tree.  .tmp_include/src_000/asm is
created in the object tree, pointing at the relevant source directory
and gcc scans .tmp_include/src_000, not the source tree.

If you write to asm/foo.h then you are updating the source tree.  I can
work around this by creating two sets of symlinks for include paths,
one pointing to the object directory, one to the source and telling gcc
to scan the object first.  But that will make the generated commands
even longer and will slow gcc down.

My preference is to generate files in the arch subtree.  The source
code does #include <foo.h> and the makefiles have lines like this

  extra_aflags(entry.o -I arch/$(ARCH))

Yes, you have to add extra_aflags on every object that uses the
generated include file.  But you already have to specify a dependency
from the object to the generated file to ensure that parallel make
waits until the file is generated.  Doing two lines instead of one for
the affected objects is no big deal.

  $(objfile entry.o): $(objfile /arch/$(ARCH)/offsets.h)
  extra_aflags(entry.o -I arch/$(ARCH))

BTW, mach-types.h is going to be a problem wherever it is stored.
Several .h files include the generated file so all objects that include
these .h files are dependent on mach-types.h being generated first.

  include/asm-arm/arch-ebsa285/time.h:#include <asm/mach-types.h>
  include/asm-arm/arch-ebsa285/uncompress.h:#include <asm/mach-types.h>
  include/asm-arm/arch-ebsa285/irq.h:#include <asm/mach-types.h>
  include/asm-arm/arch-ebsa285/system.h:#include <asm/mach-types.h>
  include/asm-arm/arch-ebsa285/irqs.h:#include <asm/mach-types.h>
  include/asm-arm/arch-arc/ide.h:#include <asm/mach-types.h>
  include/asm-arm/arch-sa1100/uncompress.h:#include <asm/mach-types.h>
  include/asm-arm/arch-sa1100/ide.h:#include <asm/mach-types.h>
  include/asm-arm/arch-sa1100/irq.h:#include <asm/mach-types.h>
  include/asm-arm/arch-sa1100/hardware.h:#include <asm/mach-types.h>

I do not want to reinvent make dep because of the fundamental design
problems with that approach.  If any generated file depends on .config
then it must be recreated after any config changes or patches but 99.9%
of users do not do that.  We must not rely on human intervention to
update kernel files, it must be automatic.  This requires that make be
told the truth about the dependency graph.  mach-types.h is going to
require some more work, no matter where it is stored.

