Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbUA0Wbt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 17:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265143AbUA0Wbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 17:31:49 -0500
Received: from colin2.muc.de ([193.149.48.15]:10249 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264366AbUA0Wbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 17:31:47 -0500
Date: 27 Jan 2004 23:30:09 +0100
Date: Tue, 27 Jan 2004 23:30:09 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, eric@cisu.net, stoffel@lucent.com,
       Valdis.Kletnieks@vt.edu, bunk@fs.tum.de, cova@ferrara.linux.it,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-ID: <20040127223009.GA81095@colin2.muc.de>
References: <200401232253.08552.eric@cisu.net> <200401261326.09903.eric@cisu.net> <20040126115614.351393f2.akpm@osdl.org> <200401262343.35633.eric@cisu.net> <20040126215056.4e891086.akpm@osdl.org> <20040127162043.GA98702@colin2.muc.de> <20040127125447.31631e14.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040127125447.31631e14.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've moved the enabling of -funit-at-a-time out of Makefile and down into
> arch/i386/Makefile, and I changed to require gcc-3.4 or higher.
> 
> So if you want to use -funit-at-a-time on gcc-3.3/hammer you can do so.

Please undo that and apply this patch instead. It fixes the bug that
broke booting with older gcc 3.3-hammer compilers (confirmed by
two people on l-k). It was plain luck that it worked with the other
compilers. 

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
