Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317501AbSFRRLO>; Tue, 18 Jun 2002 13:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317504AbSFRRLN>; Tue, 18 Jun 2002 13:11:13 -0400
Received: from h-64-105-35-162.SNVACAID.covad.net ([64.105.35.162]:47757 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317501AbSFRRLD>; Tue, 18 Jun 2002 13:11:03 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 18 Jun 2002 10:10:59 -0700
Message-Id: <200206181710.KAA00594@baldur.yggdrasil.com>
To: kai@tp1.ruhr-uni-bochum.de
Subject: Re: Various kbuild problems in 2.5.22
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Kai Germaschewski wrote:
>On Tue, 18 Jun 2002, Adam J. Richter wrote:

>> 	No, "make -k" still will not build bzImage if a module
>> fails to compile.
>> 
>> 	Also, I do not understand why this is "intentional."  Normally,
>> if one does a "make" of a file in a source tree, build problems with
>> unneeded files do not effect it.

>Yes, but they are not unneeded files, otherwise we wouldn't even try to 
>build them. The point is, the semantics of bzImage changed: It now means 
>"build bzImage and modules".  That's the common case. If you really only 
>want bzImage and no modules, you have to tell make by using
>"make KBUILD_MODULES= bzImage" (I could allow for phrasing the latter as
>"make bzImage nomodules", but that's only cosmetical)

	The standard for make is that if you name the target, it
builds the target.  If I want to make bzImage and modules, I should type
"make bzImage modules".

      I agree with making the common case easier to build, but I would
happy to have "make bzImage modules" be activatable by "make all" or
"make" (or both).


>> >> 	3. make include/linux/modversios.h aborts if any .c file has
>> >> a #error or #include's a .h that is not present (for example, because
>> >> the .h is built by the process, as is the case with one scsi driver).
>> 
>> >The fact that it aborts is intentional.
>> 
>> 	We have adopted a convention of putting #error into lots
>> of device drivers to encourage people to port them.  Linus has
>> also recently integrated chagnes to support compiling with "all
>> modules" and "all yes" configurations.  This change makes that
>> facility useless.

>IMO these options (all yes/mod)  are there to find files which don't
>compile, be it for an explicit #error or other reasons - and they serve
>this purpose, they now flag those files already at "make dep" time if
>you're using modversions.

>Of course I could go ahead if I get an error during module version
>generation, but then I'd get the exact same error later when compiling. So
>I don't see the point.

	The point is that people should be able to select "make
everything a module", build and install the kernel, and let the hot
plugging system worry about what modules to load.  If you believe in
custom kernel configuartions for each user, that is your choice, but
please do not impede those of us who just build everything.

       If I want to the kernel to build to continue even when a module
fails to compile, I should be able to do that by just using "-k".  Not
being able to build include/linux/modversions.h prevents me from doing
that.

	If the current behavior were the default, but "make -k
include/linux/modversions.h" would build modversions.h, that would be
acceptable, by the way.  As things stand under 2.5.22, I have to
comment out all of the #error calls to get the kernel to compile, and
that is particularly annoying because I like to go through the
#error's later and occasionally donate some of my time to trying to
fix a driver.


>Module versions used to be fragile, exactly for
>reasons like this. If this step goes wrong, just silently ignoring that
>fact will get you in trouble later.

      The error message is being printed, so it is not silent.
Building modversions.h will not get you into any trouble later on that
the subsequent compilation failuer will miss.


>> 	I do not think it improves anyone's prioritization to
>> require everyone to either make custom kernel configurations or
>> give top priority to fixing random drivers ahead of whatever
>> else depends on their getting the new kernel to build.

>Well, normally people carry their .config along and adapt it as necessary.

       Well, I like to have a single complete kernel build that
cover most hardware and let user level run time configuration
take care of the rest.  Given that most Linux users are not kernel
developers, getting the souce and recompiling will be a lot more
practical if more generic kernel configurations are not prevented
by your system.

>Apart from that, "make modules_install" never worked in the case of 
>failed builds, did it? - so it boils down to: you need a buildable .config 
>to build and test a kernel.

	Before, if some modules did not build, "make -k modules_install"
would still install all of the modules that did build.

>> >That it doesn't build the .h in that case is a bug. Which driver is it?
>> 
>> 	53c700.  The generated header file is drivers/scsi/53c700_d.h.

>Okay, I fixed that here.

>> >> 	4. "make -k modules" will not build perfectly buildable modules
>> >> in a directory that has a subdirectory where a compile error occurs.

>Actually, I tried and don't see this happening.

	For example, when I attempted to build a kernel with every
tristate set to "module" (except for romfs and the ramdisk), the
following sound drivers did not compile, because they needed
<linux/init.h>:

		sound/isa/ad1848/ad1848_lib.c.
		sound/pci/korg1212/korg1212.c,
		sound/pci/cs46xx/cs46xx.c

	With these modules not compiling, "make -k modules" did
not build sound/soundcore.o even though there was no real
dependency problem.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

