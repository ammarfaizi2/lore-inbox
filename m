Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317471AbSFRQO6>; Tue, 18 Jun 2002 12:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317473AbSFRQO5>; Tue, 18 Jun 2002 12:14:57 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:52949 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317471AbSFRQO4>; Tue, 18 Jun 2002 12:14:56 -0400
Date: Tue, 18 Jun 2002 11:14:56 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Various kbuild problems in 2.5.22
In-Reply-To: <200206181500.IAA00339@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0206181056090.5695-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Adam J. Richter wrote:

> 	No, "make -k" still will not build bzImage if a module
> fails to compile.
> 
> 	Also, I do not understand why this is "intentional."  Normally,
> if one does a "make" of a file in a source tree, build problems with
> unneeded files do not effect it.

Yes, but they are not unneeded files, otherwise we wouldn't even try to 
build them. The point is, the semantics of bzImage changed: It now means 
"build bzImage and modules". That's the common case. If you really only 
want bzImage and no modules, you have to tell make by using
"make KBUILD_MODULES= bzImage" (I could allow for phrasing the latter as
"make bzImage nomodules", but that's only cosmetical)

> >> 	3. make include/linux/modversios.h aborts if any .c file has
> >> a #error or #include's a .h that is not present (for example, because
> >> the .h is built by the process, as is the case with one scsi driver).
> 
> >The fact that it aborts is intentional.
> 
> 	We have adopted a convention of putting #error into lots
> of device drivers to encourage people to port them.  Linus has
> also recently integrated chagnes to support compiling with "all
> modules" and "all yes" configurations.  This change makes that
> facility useless.

IMO these options (all yes/mod)  are there to find files which don't
compile, be it for an explicit #error or other reasons - and they serve
this purpose, they now flag those files already at "make dep" time if
you're using modversions.

Of course I could go ahead if I get an error during module version
generation, but then I'd get the exact same error later when compiling. So
I don't see the point. Module versions used to be fragile, exactly for
reasons like this. If this step goes wrong, just silently ignoring that
fact will get you in trouble later.

> 	I do not think it improves anyone's prioritization to
> require everyone to either make custom kernel configurations or
> give top priority to fixing random drivers ahead of whatever
> else depends on their getting the new kernel to build.

Well, normally people carry their .config along and adapt it as necessary. 
If a driver stopped building, if you don't need it, disable it in your 
.config, if you need it, just ignoring the failure won't help you either. 

Apart from that, "make modules_install" never worked in the case of 
failed builds, did it? - so it boils down to: you need a buildable .config 
to build and test a kernel.

> >That it doesn't build the .h in that case is a bug. Which driver is it?
> 
> 	53c700.  The generated header file is drivers/scsi/53c700_d.h.

Okay, I fixed that here.

> >> 	4. "make -k modules" will not build perfectly buildable modules
> >> in a directory that has a subdirectory where a compile error occurs.

Actually, I tried and don't see this happening.

--Kai


