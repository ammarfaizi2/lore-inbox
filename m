Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbUA0SQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 13:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbUA0SQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 13:16:57 -0500
Received: from colin2.muc.de ([193.149.48.15]:50448 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264459AbUA0SQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 13:16:54 -0500
Date: 27 Jan 2004 19:15:54 +0100
Date: Tue, 27 Jan 2004 19:15:54 +0100
From: Andi Kleen <ak@muc.de>
To: Eric <eric@cisu.net>
Cc: Andrew Morton <akpm@osdl.org>, stoffel@lucent.com, ak@muc.de,
       Valdis.Kletnieks@vt.edu, bunk@fs.tum.de, cova@ferrara.linux.it,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - REALLY SOLVED
Message-ID: <20040127181554.GA41917@colin2.muc.de>
References: <200401232253.08552.eric@cisu.net> <200401262343.35633.eric@cisu.net> <20040126215056.4e891086.akpm@osdl.org> <200401270037.43676.eric@cisu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401270037.43676.eric@cisu.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 12:37:43AM -0600, Eric wrote:
> On Monday 26 January 2004 23:50, Andrew Morton wrote:
> > Eric <eric@cisu.net> wrote:
> > > YES. I finally have a working 2.6.2-rc1-mm3 booted kernel.
> > >  Lets review folks---
> > >  	reverted -funit-at-a-time
> > >  	patched test_wp_bit so exception tables are sorted sooner
> > >  	reverted md-partition patch
> >
> > The latter two are understood, but the `-funit-at-a-time' problem is not.
> >
> > Can you plesae confirm that restoring only -funit-at-a-time again produces
> > a crashy kernel?  And that you are using a flavour of gcc-3.3?  If so, I
> > guess we'll need to only enable it for gcc-3.4 and later.
> >
> Yes, confirmed. My  version of gcc, I just sent you adding the 
> -funit-at-a-time hung after uncompressing the kernel. I booted a secondary 
> kernel, recompiled without it and all was fine again. Confirmed non-boot for 
> 2.6.2-rc1-mm3 but without a doubt for all kernels previous where 
> -funit-at-a-time is active in the makefile.

Ok, found it. This patch should fix it.  The top level asm in process.c
assumed that the section was .text, but that is not guaranteed in a
funit-at-a-time compiler. It ended up in the setup section and messed up
the argument parsing.  This bug could have hit with any compiler,
it was just plain luck that it worked with newer gcc 3.3 and 3.4.

Please test if it fixes your problem.

Andrew, please merge it if the bug is confirmed to be fixed.

-Andi

diff -u linux-2.6.2rc1mm3-test/arch/i386/kernel/process.c-o linux-2.6.2rc1mm3-test/arch/i386/kernel/process.c
--- linux-2.6.2rc1mm3-test/arch/i386/kernel/process.c-o	2004-01-27 02:26:39.000000000 +0100
+++ linux-2.6.2rc1mm3-test/arch/i386/kernel/process.c	2004-01-27 19:09:41.131460832 +0100
@@ -253,13 +253,15 @@
  * the "args".
  */
 extern void kernel_thread_helper(void);
-__asm__(".align 4\n"
+__asm__(".section .text\n"
+	".align 4\n"
 	"kernel_thread_helper:\n\t"
 	"movl %edx,%eax\n\t"
 	"pushl %edx\n\t"
 	"call *%ebx\n\t"
 	"pushl %eax\n\t"
-	"call do_exit");
+	"call do_exit\n"
+	".previous");
 
 /*
  * Create a kernel thread
