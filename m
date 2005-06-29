Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbVF2LrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbVF2LrU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 07:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVF2LrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 07:47:20 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:12258 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262556AbVF2LrL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 07:47:11 -0400
Date: Wed, 29 Jun 2005 17:17:02 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: gdb@sources.redhat.com, dan@debian.org, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, bunk@stusta.de,
       alexn@dsv.su.se
Subject: Re: [Fastboot] Re: [-mm patch] i386: enable REGPARM by default
Message-ID: <20050629114702.GD3771@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20050624200916.GJ6656@stusta.de> <20050624132826.4cdfb63c.akpm@osdl.org> <20050627132941.GD3764@in.ibm.com> <20050627140029.GB29121@nevyn.them.org> <20050628045111.GB4296@in.ibm.com> <20050628112412.GB5652@in.ibm.com> <200506281959.j5SJxaeM022138@elgar.sibelius.xs4all.nl> <20050629083452.GC3771@in.ibm.com> <8824.192.87.1.200.1120039619.squirrel@192.87.1.200>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8824.192.87.1.200.1120039619.squirrel@192.87.1.200>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In this case I am building linux kernel with debug info (-g) and -mregparm
> > is not specified. So parameters should be passed on stack. Following
> > is the effective command line to build kernel/sysfs.c. I am not sure if
> > any of the below mentioned options are going to affect the gdb results.
> >
> >   gcc -m32 -Wp,-MD,kernel/.ksysfs.o.d  -nostdinc -isystem
> > /usr/lib/gcc/i386-redhat-linux/3.4.3/include -D__KERNEL__ -Iinclude
> > -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
> > -fno-common -ffreestanding -O2     -fomit-frame-pointer -g -pipe
> > -msoft-float -mpreferred-stack-boundary=2 -fno-unit-at-a-time
> > -march=i686 -mtune=pentium4 -Iinclude/asm-i386/mach-default
> > -Wdeclaration-after-statement     -DKBUILD_BASENAME=ksysfs
> > -DKBUILD_MODNAME=ksysfs -c -o kernel/ksysfs.o kernel/ksysfs.c
> 
> -O2 will have some effect.  The compiler might optimize away variables
> (including function arguments) and doesn't always record that fact in
> the debug information.
> 
> But the real killer here is probably -fomit-frame-pointer.  Last time I
> looked GCC didn't generate the correct debug information in that case.
> I didn't really look into this, but it seemed as if GCC blindly produces
> location descriptions relative to the frame pointer even though there no
> longer is a frame pointer.  GCC 4.0 or 4.1 might have this fixed.
> 
> >
> >> Repeating what Daniel said before, by using "regparm", function
> >> arguments are now passed in registers instead of on the stack.  It's
> >> extremely unlikely that these function arguments will stay in those
> >> registers for ever, especially since you've only got a handfull of
> >> them on the i386.
> >
> > Sorry for the confusion. In the last mail all the results were reported
> > with REGPARM disabled. I wanted to make sure that first normal case works
> > fine and then discuss the REGPARM case later.
> 
> If you're prepared to do some more tests, you might want to check out
> what happens if you leave out -O2 and -fomit-frame-pointer, and then add
> back only -O2

I built another kernel with -fno-omit-frame-pointer and output seems to
have worsen a lot now. I am not able to build a kernel without -02. There
seems to be some dependencies which I am sorting out.

With frame pointer support, following is the command line.

gcc -m32 -Wp,-MD,kernel/.ksysfs.o.d  -nostdinc -isystem /usr/lib/gcc/i386-redhat-linux/3.4.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -O2     -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -pipe -msoft-float -mpreferred-stack-boundary=2 -fno-unit-at-a-time -march=i686 -mtune=pentium4 -Iinclude/asm-i386/mach-default -Wdeclaration-after-statement     -DKBUILD_BASENAME=ksysfs -DKBUILD_MODNAME=ksysfs -c -o kernel/ksysfs.o kernel/ksysfs.c

And the gdb trace has worsened. Trace is not even showing all the calls
as it was showing when kernel was built with -fomit-frame-pointer.


#0  crash_get_current_regs (regs=0xec3b5e34) at arch/i386/kernel/crash.c:103
#1  0xc0114077 in crash_save_self (saved_regs=0xec3b5e34)
    at arch/i386/kernel/crash.c:134
#2  0xec3b5f04 in ?? ()
#3  0x00000014 in ?? ()
#4  0xec3b5e98 in ?? ()
#5  0xc013d7e6 in crash_kexec (regs=0x2) at kernel/kexec.c:1059
#6  0xecb29c80 in ?? ()
#7  0xecb29c80 in ?? ()
#8  0x00000000 in ?? ()

Thanks
Vivek
