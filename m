Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWAUCBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWAUCBU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 21:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWAUCBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 21:01:20 -0500
Received: from alpha.polcom.net ([83.143.162.52]:57990 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1030269AbWAUCBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 21:01:19 -0500
Date: Sat, 21 Jan 2006 03:01:10 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Valdis.Kletnieks@vt.edu
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: set_bit() is broken on i386?
In-Reply-To: <200601210132.k0L1WbIP006348@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.63.0601210245280.8060@alpha.polcom.net>
References: <200601201955_MC3-1-B649-DCF5@compuserve.com>
 <200601210132.k0L1WbIP006348@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2006, Valdis.Kletnieks@vt.edu wrote:

> On Fri, 20 Jan 2006 19:53:14 EST, Chuck Ebbert said:
>> /*
>>  * setbit.c -- test the Linux set_bit() function
>>  *
>>  * Compare the output of this program with and without the
>>  * -finline-functions option to GCC.
>>  *
>>  * If they are not the same, set_bit is broken.
>>  *
>>  * Result on i386 with gcc 3.3.2 (Fedora Core 2):
>>  *
>>  * [me@d2 t]$ gcc -O2 -o setbit.ex setbit.c ; ./setbit.ex
>>  * 00010001
>>  * [me@d2 t]$ gcc -O2 -o setbit.ex -finline-functions setbit.c ; ./setbit.ex
>>  * 00000001
>
> It certainly seems to be gcc version dependent (and I'd not be surprised if the
> exact combo of -O2, -Os, and -mfoo and -fwhatever flags as well).  Trond is
> probably right that a memory clobber will force gcc to DTIT (Do The Intended
> Thing, which may be different from a DTRT) regardless of what gcc's code generator
> decides to do....
>
> % gcc -v
> Using built-in specs.
> Target: i386-redhat-linux
> Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-libgcj-multifile --enable-languages=c,c++,objc,obj-c++,java,fortran,ada --enable-java-awt=gtk --disable-dssi --with-java-home=/usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/jre --host=i386-redhat-linux
> Thread model: posix
> gcc version 4.1.0 20060117 (Red Hat 4.1.0-0.15)
> % gcc -O2 -o setbit.ex setbit.c ; ./setbit.ex
> 00000001
> % gcc -O2 -o setbit.ex -finline-functions setbit.c ; ./setbit.ex
> 00000001
>
> Fedora Core -devel tree as of this morning (so sort-of FC5 test2).

This is what I am getting under Gentoo with different gcc's:

$ export CC=gcc-3.4.5; $CC --version; rm ./setbit.ex; $CC -O2 -o setbit.ex 
setbit.c ; ./setbit.ex; rm ./setbit.ex; $CC -O2 -o setbit.ex 
-finline-functions setbit.c ; ./setbit.ex
gcc-3.4.5 (GCC) 3.4.5 (Gentoo 3.4.5, ssp-3.4.5-1.0, pie-8.7.9)
Copyright (C) 2004 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR 
PURPOSE.

00000001
00000001


$ export CC=gcc-4.0.2; $CC --version; rm ./setbit.ex; $CC -O2 -o setbit.ex 
setbit.c ; ./setbit.ex; rm ./setbit.ex; $CC -O2 -o setbit.ex 
-finline-functions setbit.c ; ./setbit.ex
gcc-4.0.2 (GCC) 4.0.2 (Gentoo 4.0.2-r3, pie-8.7.8)
Copyright (C) 2005 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR 
PURPOSE.

00000001
00000001


$ export CC=gcc-4.1.0-beta20060113; $CC --version; rm ./setbit.ex; $CC -O2 
-o setbit.ex setbit.c ; ./setbit.ex; rm ./setbit.ex; $CC -O2 -o setbit.ex 
-finline-functions setbit.c ; ./setbit.ex
gcc-4.1.0-beta20060113 (GCC) 4.1.0-beta20060113  (prerelease)
Copyright (C) 2005 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR 
PURPOSE.

00000001
00000001


And on some really old and not upgraded server (with Gentoo too of 
course):

$ export CC=gcc32; $CC --version; rm ./setbit.ex; $CC -O2 -o setbit.ex 
setbit.c ; ./setbit.ex; rm ./setbit.ex; $CC -O2 -o setbit.ex 
-finline-functions setbit.c ; ./setbit.ex
gcc (GCC) 3.3.5-20050130 (Gentoo 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, 
pie-8.7.7.1)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR 
PURPOSE.

00010001
00000001


So either this problem is present only on gcc < 3.4 or Gentoo patched it 
somehow in newer versions...


Thanks,

Grzegorz Kulewski

