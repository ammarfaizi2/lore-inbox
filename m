Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265641AbUA0Tdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265648AbUA0Tdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:33:38 -0500
Received: from user-119ahgg.biz.mindspring.com ([66.149.70.16]:18082 "EHLO
	mail.home") by vger.kernel.org with ESMTP id S265641AbUA0TcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:32:02 -0500
From: Eric <eric@cisu.net>
To: Andi Kleen <ak@muc.de>
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - REALLY SOLVED
Date: Tue, 27 Jan 2004 13:31:11 -0600
User-Agent: KMail/1.5.94
Cc: Andrew Morton <akpm@osdl.org>, stoffel@lucent.com, Valdis.Kletnieks@vt.edu,
       bunk@fs.tum.de, cova@ferrara.linux.it, linux-kernel@vger.kernel.org
References: <200401232253.08552.eric@cisu.net> <200401270037.43676.eric@cisu.net> <20040127181554.GA41917@colin2.muc.de>
In-Reply-To: <20040127181554.GA41917@colin2.muc.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401271331.11812.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 January 2004 12:15, Andi Kleen wrote:
> On Tue, Jan 27, 2004 at 12:37:43AM -0600, Eric wrote:
> > On Monday 26 January 2004 23:50, Andrew Morton wrote:
> > > Eric <eric@cisu.net> wrote:
> > > > YES. I finally have a working 2.6.2-rc1-mm3 booted kernel.
> > > >  Lets review folks---
> > > >  	reverted -funit-at-a-time
> > > >  	patched test_wp_bit so exception tables are sorted sooner
> > > >  	reverted md-partition patch
> > >
> > > The latter two are understood, but the `-funit-at-a-time' problem is
> > > not.
> > >
> > > Can you plesae confirm that restoring only -funit-at-a-time again
> > > produces a crashy kernel?  And that you are using a flavour of gcc-3.3?
> > >  If so, I guess we'll need to only enable it for gcc-3.4 and later.
> >
> > Yes, confirmed. My  version of gcc, I just sent you adding the
> > -funit-at-a-time hung after uncompressing the kernel. I booted a
> > secondary kernel, recompiled without it and all was fine again. Confirmed
> > non-boot for 2.6.2-rc1-mm3 but without a doubt for all kernels previous
> > where -funit-at-a-time is active in the makefile.
>
> Ok, found it. This patch should fix it.  The top level asm in process.c
> assumed that the section was .text, but that is not guaranteed in a
> funit-at-a-time compiler. It ended up in the setup section and messed up
> the argument parsing.  This bug could have hit with any compiler,
> it was just plain luck that it worked with newer gcc 3.3 and 3.4.
>
> Please test if it fixes your problem.

Yes. Confirmed. Lets review again.
 -removed -funit from makefile
 patched to fix exception table sorting
reverted md-partition-patch
BOOTS
add -funit again
FAILS
leave -funit active in makefile
patch with patch below
BOOTS

This patch is confirmed to fix the boot with -funit-at-a-time with 
2.6.2-rc1-mm2 with  gcc(below)

Thanks so much for everyones attention in the matter.

bot403@eric:~> gcc -v
Reading specs from /usr/lib/gcc-lib/i486-suse-linux/3.3/specs
Configured with: ../configure --enable-threads=posix --prefix=/usr 
--with-local-prefix=/usr/local --infodir=/usr/share/info 
--mandir=/usr/share/man --libdir=/usr/lib 
--enable-languages=c,c++,f77,objc,java,ada --disable-checking --enable-libgcj 
--with-gxx-include-dir=/usr/include/g++ --with-slibdir=/lib 
--with-system-zlib --enable-shared --enable-__cxa_atexit i486-suse-linux
Thread model: posix
gcc version 3.3 20030226 (prerelease) (SuSE Linux)

> Andrew, please merge it if the bug is confirmed to be fixed.
>
> -Andi
>
> diff -u linux-2.6.2rc1mm3-test/arch/i386/kernel/process.c-o
> linux-2.6.2rc1mm3-test/arch/i386/kernel/process.c ---
> linux-2.6.2rc1mm3-test/arch/i386/kernel/process.c-o	2004-01-27
> 02:26:39.000000000 +0100 +++
> linux-2.6.2rc1mm3-test/arch/i386/kernel/process.c	2004-01-27
> 19:09:41.131460832 +0100 @@ -253,13 +253,15 @@
>   * the "args".
>   */
>  extern void kernel_thread_helper(void);
> -__asm__(".align 4\n"
> +__asm__(".section .text\n"
> +	".align 4\n"
>  	"kernel_thread_helper:\n\t"
>  	"movl %edx,%eax\n\t"
>  	"pushl %edx\n\t"
>  	"call *%ebx\n\t"
>  	"pushl %eax\n\t"
> -	"call do_exit");
> +	"call do_exit\n"
> +	".previous");
>
>  /*
>   * Create a kernel thread

-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
