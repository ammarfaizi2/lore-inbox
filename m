Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUBNT2C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 14:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUBNT1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 14:27:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:40351 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262902AbUBNT1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 14:27:32 -0500
Subject: Re: Kernel Cross Compiling
From: "Timothy D. Witham" <wookie@osdl.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: John Cherry <cherry@osdl.org>, linux-kernel@vger.kernel.org,
       linux-gcc@vger.kernel.org
In-Reply-To: <20040214130321.GA8474@MAIL.13thfloor.at>
References: <20040213205743.GA30245@MAIL.13thfloor.at>
	 <1076747526.2095.81.camel@wookie-t23>
	 <20040214130321.GA8474@MAIL.13thfloor.at>
Content-Type: text/plain
Organization: Open Source Development Lab, Inc.
Message-Id: <1076786741.2101.0.camel@wookie-t23>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 14 Feb 2004 11:25:41 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Well it seems to me it makes more sense to extend rather
than start over.

Tim

On Sat, 2004-02-14 at 05:03, Herbert Poetzl wrote:
> On Sat, Feb 14, 2004 at 12:32:07AM -0800, Timothy D. Witham wrote:
> >  Just to point out that we (OSDL) already do this.
> > 
> > http://www.osdl.org/projects/26lnxstblztn/results/
> > 
> >   We are willing to add more but it is always willing
> > to look at adding more.
> 
> thanks, yes, I knew about that, but the thing is, I would
> like to use this as automated test (well first step of
> an automated test) for linux-vserver[1] development, and 
> for that purpose i386/ia64 and ppc/ppc64 is a good start 
> but not nearly sufficient, we currently 'support' (or at
> least try to ;) the following archs:
> 
>   alpha, i386, ia64, mips/64, hppa/64, ppc/64
>   sparc/64, s390/x, x86_64, uml
> 
> and got an officially assigned syscall number for 
> 
>   i386, s390, sparc/64, sh3/4, x86_64
> 
> but if you are interested in extending this and making
> it available for linux-vserver kernel compile tests
> too, I'm willing to help if I can ...
> 
> TIA,
> Herbert
> 
> > Tim
> > 
> > On Fri, 2004-02-13 at 12:57, Herbert Poetzl wrote:
> > > Hi Folks!
> > > 
> > > I'm currently investigating the requirements/doability
> > > of a kernel cross compiling test bed/setup, able to do
> > > automated kernel builds for different architecture,
> > > just to see if it compiles and later to verify if a 
> > > given patch breaks that compile on any of the tested
> > > archs ...
> > > 
> > > here a short status, and some issues I ran into so far,
> > > some of them with solutions, others without, and some
> > > interesting? observations ...
> > > 
> > > I would be happy if somebody who has done similar, or
> > > knows how to do it properly ;) could comment on that,
> > > and/or point out possible improvements ...
> > > 
> > > TIA,
> > > Herbert
> > > 
> > > 
> > > 1) CROSS COMPILER / TOOLCHAIN
> > > 
> > >    after reading and testing several cross build and
> > >    toolchain building howtos, I decided to do it a little 
> > >    different, because I do not need glibc to compile the 
> > >    kernel ...
> > > 
> > >    the result are two .spec files[1], or the commands 
> > >    used to build an appropriate toolchain ...
> > >    
> > >    for the binutils the required commands are:
> > > 
> > >    	configure  	    	    	    	    	\
> > > 		--disable-nls                           \
> > > 		--prefix=/usr                           \
> > > 		--mandir=/usr/share/man                 \
> > > 		--infodir=/usr/share/info               \
> > > 		--target=${CROSS_ARCH}-linux
> > >    	make
> > >    
> > >    and for the gcc (after the binutils have been
> > >    installed on the host):
> > > 
> > >    	configure  	    	    	    	    	\
> > > 		--enable-languages=c			\
> > >         	--disable-nls                           \
> > > 		--disable-threads			\
> > > 		--disable-shared			\
> > > 		--disable-checking			\
> > >         	--prefix=/usr                           \
> > >         	--mandir=/usr/share/man                 \
> > >         	--infodir=/usr/share/info               \
> > >         	--target=${CROSS_ARCH}-linux
> > >    	make  TARGET_LIBGCC2_CFLAGS='-Dinhibit_libc  \
> > > 		-D__gthr_posix_h'
> > >    
> > >    where ${CROSS_ARCH} is the target architecture you want
> > >    to compile the toochain for, in my case, this where one
> > >    of the following:
> > > 
> > >    	alpha, hppa, hppa64, i386, ia64, m68k, mips, 
> > > 	mips64, ppc, ppc64, s390, sparc, sparc64, x86_64
> > > 
> > >   PROBLEMS HERE:
> > > 
> > >    I decided to use binutils 2.14.90.0.8, and gcc 3.3.2,
> > >    but soon discovered that gcc-3.3.2 will not be able 
> > >    to build a cross compiler for some archs like the
> > >    alpha, ia64, powerpc and even i386 ;) without some
> > >    modifications[2] but with some help, I got all headers
> > >    fixed, except for the ia64, which still doesn't work
> > > 
> > > 
> > > 2) KERNEL CROSS COMPILING
> > > 
> > >    equipped with the cross compiling toolchains for all
> > >    but one of the architectures mentioned above, I wrote
> > >    a little script, which basically does nothing else 
> > >    but compiling a given kernel for all possible archs.
> > > 
> > >    basically this can be accomplished by doing:
> > > 
> > > 	make ARCH=<arch> CROSS_COMPILE=<arch>-linux-
> > > 
> > > 
> > >    the first result was harrowing:
> > > 
> > > 				2.4.25-pre  2.6.2-rc
> > >    ----------------------------------------------------
> > > 	[ARCH alpha/alpha]      succeeded.  succeeded.
> > > 	[ARCH hppa/parisc]      failed.     failed.
> > > 	[ARCH hppa64/parisc]    failed.     failed.
> > > 	[ARCH i386/i386]        succeeded.  succeeded.
> > > 	[ARCH m68k/m68k]        failed.     failed.
> > > 	[ARCH mips/mips]        failed.     failed.
> > > 	[ARCH mips64/mips]      failed.     failed.
> > > 	[ARCH ppc/ppc]          succeeded.  succeeded.
> > > 	[ARCH ppc64/ppc64]      failed.     failed.
> > > 	[ARCH s390/s390]        failed.     failed.
> > > 	[ARCH sparc/sparc]      failed.     succeeded.
> > > 	[ARCH sparc64/sparc]    failed.     failed.
> > > 	[ARCH x86_64/x86_64]    failed.     succeeded.
> > > 
> > >    so only alpha, i386 and ppc did work on the first run.
> > > 
> > >    what I discovered was, that there IS a big difference
> > >    between an empty .config file and a non exististing 
> > >    one, where latter allowed the make oldconfig to work
> > >    similar to the make defaultconfig available on 2.6,
> > >    and added some archs (see [3] for details)
> > > 
> > >   PROBLEMS & SOLUTIONS HERE:
> > > 
> > >    ppc64: 
> > > 	CROSS32_COMPILE=ppc-linux-  
> > > 	is needed to make this work as expected.
> > > 
> > >    hppa/hppa64: 
> > > 	seems not to compile without using a very big
> > > 	patch, which changes a lot inside the kernel
> > > 
> > >    mips/mips64:
> > > 	seem to use the 'obsoleted' -mcpu= option
> > > 	which results in a cc1: error: invalid option 
> > > 	`cpu=<cpu-here>'
> > > 
> > >    m68k:
> > > 	fails with a hundred errors in the includes
> > > 
> > > 
> > > 3) CONCLUSIONS
> > > 
> > >    it seems that recent kernels (2.4 and 2.6) do not support
> > >    most of the architectures they contain without heavy
> > >    patching (haven't tested for arm, sh3/4, ...)
> > > 
> > >    building cross compiler toolchains isn't that often done
> > >    otherwise it would not require such modifications, and
> > >    the documentation would be up to date ...
> > > 
> > >    it seems that with some minor patches and kernel tweaks
> > >    an automated build is in reach, although some archs seem
> > >    to break from one release to the other ...
> > > 
> > >    the non mainline branches, if they exist are some kernel
> > >    versions behind the current mainstream kernel, which 
> > >    might not mean anything ...
> > > 
> > > 
> > > 4) LINKS & REFERENCES
> > > 
> > >    [1]	http://vserver.13thfloor.at/Stuff/Cross/binutils-cross.spec
> > > 	http://vserver.13thfloor.at/Stuff/Cross/gcc-cross.spec
> > > 
> > >    [2]  http://vserver.13thfloor.at/Stuff/Cross/
> > > 		gcc-3.3.2-cross-alpha-fix.diff.bz2
> > > 		gcc-3.3.2-cross-i386-fix.diff.bz2
> > > 		gcc-3.3.2-cross-ia64-fix.diff.bz2
> > > 		gcc-3.3.2-cross-powerpc-fix.diff.bz2
> > > 
> > >    [3]  http://vserver.13thfloor.at/Stuff/Cross/compile.info
> > > 
> > >    ia64:	http://www.gelato.unsw.edu.au/kerncomp/
> > >    mips:	http://www.linux-mips.org/kernel.html
> > >    hppa:	http://www.parisc-linux.org/kernel/index.html
> > >    ppc64:	http://linuxppc64.org/
> > >    	
> > > 
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-gcc" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > -- 
> > Timothy D. Witham - Lab Director - wookie@osdl.org
> > Open Source Development Lab Inc - A non-profit corporation
> > 12725 SW Millikan Way - Suite 400 - Beaverton OR, 97005
> > (503)-626-2455 x11 (office)    (503)-702-2871     (cell)
> > (503)-626-2436     (fax)
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-gcc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Timothy D. Witham - Lab Director - wookie@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton OR, 97005
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

