Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130445AbRCCKrk>; Sat, 3 Mar 2001 05:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130446AbRCCKr3>; Sat, 3 Mar 2001 05:47:29 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:64443 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S130445AbRCCKrN>; Sat, 3 Mar 2001 05:47:13 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 3 Mar 2001 02:47:12 -0800
Message-Id: <200103031047.CAA02916@adam.yggdrasil.com>
To: buhr@stat.wisc.edu
Subject: Re: RFC: changing precision control setting in initial FPU context
Cc: drepper@cygnus.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	IEEE-754 floating point is available under glibc-based systems,
including most current GNU/Linux distributions, by linking with -lieee.
Your example program produces the "9 10" result you wanted when linked
this way, even when compiled with -O2 

	When not linked with "-lieee", Linux personality ELF
x86 binaries start with Precision Control set to 3, just because that
is how the x86 fninit instruction sets it.

	I thought that libieee was also available at run time for
dynamic executables by doing something like
"LD_PRELOAD=/usr/lib/libieee.so my_dynamic_exeuctable", so you could set
it in your .bashrc if you wanted, but that apparently is not the case,
at least under glibc-2.2.2.  I will have to try to figure out why this
is not available.

	I am a bit out of my depth when discussing the advantages of
occasional 80 bit precision over 64 bit, but I think that there are
situations where getting gratuitously more accurate results helps,
like getting faster convergence in some scientific numerical methods,
such as Newton's method.  (You'll still find the same point of
convergence if there is only one, but the program will run faster).
Another example would be things like 3D lighting calculations (used in
games?) where you want to produce the best images that you can within
that CPU budget.  I don't know of any sound encodings where a fully
optimized implementation would use floating point, but it's possible.
In general, I think most real uses of floating point are for "fast and
sloppy" purposes, and programs that want to use floating point and
care about exact reproducibility will link with "-lieee".

	On the other hand, if a GNU/Linux-x86 distribution did want to
change the initial floating point control word in Linux to PC=2, I think
you would still want old programs to run in their old PC=3 environment,
just in case one relied on it.  Your sys_setfpcw suggestion could do
(to set the default floating point control word without flagging the
process as one that was definitely going to use floating point), but I
think a simpler approach would be to assign a different magic number
argument setpersonality() for programs that expect to be initialized
with floating point precision control set to 2.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
