Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbUBVDyI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 22:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbUBVDyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 22:54:08 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:60289 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261669AbUBVDxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 22:53:52 -0500
Date: Sun, 22 Feb 2004 04:53:50 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Cc: Jim Wilson <wilson@specifixinc.com>, Judith Lebzelter <judith@osdl.org>,
       Dan Kegel <dank@kegel.com>, cliff white <cliffw@osdl.org>,
       "Timothy D. Witham" <wookie@osdl.org>
Subject: Kernel Cross Compiling [update]
Message-ID: <20040222035350.GB31813@MAIL.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jim Wilson <wilson@specifixinc.com>,
	Judith Lebzelter <judith@osdl.org>, Dan Kegel <dank@kegel.com>,
	cliff white <cliffw@osdl.org>, "Timothy D. Witham" <wookie@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks!

Here is an update to the Kernel Cross Compiling thread 
I started ten days ago ...

1) CROSS COMPILER / TOOLCHAIN

   there are different solutions for the toolchain issue:
   
     - Dan Kegel's Crosstool [1]
     - PTXdist [2]
     - my simplified approach [3]

   in one mail [Ref-A], Jim Wilson mentioned that using the 
   'inhibit_libc' trick will break the gcc in a subtly way, 
   so I decided to verify the fitness of the compiled gcc.
   
   because 'normal' checks won't work without the glibc and
   the includes, I decided to take the following approach:
     
     - build gcc 3.3.2 with Dan's crosstool, and with my 
       simplified approach.
       
     - select all tests from the test suite which contain
       tests relevant for the kernel (no floats, no (g)libc
       includes)
     
     - compile each C source into Assembler code (gcc -O2 -S)
       with both compilers (crosstool gcc version and mine)
     
     - compare the resulting Assembler code and check for
       differences
     
   the GCC testsuite contains 2854 files in the relevant 
   subdirs consistency.vlad, gcc.c-torture, gcc.dg, and
   gcc.misc-tests.
    
   after removing the non relevant tests (file matching 
   egrep '#include|float|double') 1799 C files remain.
     
   the result of the tests and comparison[4] shows that
   both compilers produce the same code, except for one
   little difference[5], which I'm unable to explain ...  

   my conclusion so far is that my approach should be
   sufficient for Kernel Cross Compiling.


2) KERNEL CROSS COMPILING

   			   linux-2.6.3-rc3     linux-2.6.3
   			   config  build       config  build

   alpha/alpha: 	   OK	   OK	       OK      OK
   arm/arm:		   FAILED  FAILED      FAILED  FAILED
   cris/cris:		   FAILED  FAILED      FAILED  FAILED
   hppa/parisc: 	   OK	   FAILED      OK      FAILED
   hppa64/parisc:	   OK	   FAILED      OK      FAILED
   i386/i386:		   OK	   OK	       OK      OK
   ia64/ia64:		   OK	   OK	       OK      OK
   m68k/m68k:		   OK	   FAILED      OK      FAILED
   mips/mips:		   OK	   FAILED      OK      FAILED
   mips64/mips: 	   OK	   FAILED      OK      FAILED
   ppc/ppc:		   OK	   FAILED      OK      FAILED
   ppc64/ppc64: 	   OK	   OK	       OK      OK
   s390/s390:		   OK	   FAILED      OK      FAILED
   sh/sh:		   OK	   FAILED      OK      FAILED
   sh64/sh:		   OK	   FAILED      OK      FAILED
   sparc/sparc: 	   OK	   FAILED      OK      FAILED
   sparc64/sparc64:	   OK	   OK	       OK      OK
   v850/v850:		   FAILED  FAILED      FAILED  FAILED
   x86_64/x86_64:	   OK	   OK	       OK      OK

   
   interesting is that some architectures (arm, chris, v850)
   do not even have an appropriate default config, where 
   others seem to require different? binutils (sh and sh64)
   but most other issues seem to be inconsistent configs or
   broken headers/code (details [6])... 
   
   mips/mips64 seems to break because of an cpu= option 
   which was depreciated in gcc some time ago, so they might
   build again if those changes are merged back into mainline
   
   hppa/hppa64 seems to require heavy patches to make them
   compile, which might be too intrusive to get into mainline
   very soon.

   				   linux-2.4.25
   			   config  dep     kernel  modules

   alpha/alpha: 	   OK	   OK	   OK	   OK
   arm/arm:		   OK	   OK	   FAILED  FAILED
   cris/cris:		   OK	   FAILED  FAILED  FAILED
   hppa/parisc: 	   OK	   OK	   FAILED  FAILED
   hppa64/parisc:	   OK	   OK	   FAILED  FAILED
   i386/i386:		   OK	   OK	   OK	   OK
   ia64/ia64:		   OK	   OK	   FAILED  FAILED
   m68k/m68k:		   OK	   OK	   OK	   OK
   mips/mips:		   OK	   OK	   FAILED  FAILED
   mips64/mips64:	   OK	   OK	   FAILED  FAILED
   ppc/ppc:		   OK	   OK	   OK	   OK
   ppc64/ppc64: 	   OK	   FAILED  FAILED  OK
   s390/s390:		   OK	   OK	   OK	   OK
   sh/sh:		   OK	   OK	   FAILED  FAILED
   sh64/sh64:		   OK	   OK	   FAILED  FAILED
   sparc/sparc: 	   OK	   OK	   FAILED  OK
   sparc64/sparc64:	   OK	   OK	   OK	   OK
   v850/v850:		   FAILED  FAILED  FAILED  FAILED
   x86_64/x86_64:	   OK	   OK	   OK	   OK


   the logs[7] for the 2.4.25 kernel build suggest similar
   reasons for similar architectures (compared to 2.6.3)

3) CONCLUSIONS

   it seems that the fast/easy way to build a cross gcc
   compiler (at least on x86 ;) is sufficient for kernel
   cross compile tests. 

   6/7 out of 19 'supported' architectures are currently 
   building with the kernel default configuration, when 
   cross compiled in an x86 host (about a third).

   
best,
Herbert



[1]  http://kegel.com/crosstool
[2]  http://www.pengutronix.de/software/ptxdist_en.html
[3]  http://vserver.13thfloor.at/Stuff/Cross/howto.info
[4]  http://vserver.13thfloor.at/Stuff/Cross/Comparison
[5]  http://vserver.13thfloor.at/Stuff/Cross/Comparison/TEST-alpha.diff
[6]  http://vserver.13thfloor.at/Stuff/Cross/LOGS-2.6.3
[7]  http://vserver.13thfloor.at/Stuff/Cross/LOGS-2.4.25

[Ref-A]

On Mon, Feb 16, 2004 at 02:50:41PM -0800, Jim Wilson wrote:
> I recommend Dan Kegel's page for anyone trying to build a cross compiler
> to linux.  See
> 		  http://kegel.com/crosstool
> This isn't very hard to follow, and it gives you a properly configured
> and built gcc/glibc for the target.
>
> I don't recommend the inhibit_libc trick for building linux crosses.
> It may work well enough for kernel builds, but it will give you a subtly
> broken gcc, and that may lead to confusion later.

