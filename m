Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbUA0Xsr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 18:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbUA0Xsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 18:48:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:65468 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265263AbUA0Xpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 18:45:55 -0500
Date: Tue, 27 Jan 2004 15:45:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: ak@muc.de, eric@cisu.net, stoffel@lucent.com, Valdis.Kletnieks@vt.edu,
       bunk@fs.tum.de, cova@ferrara.linux.it, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-Id: <20040127154538.08b9e9d9.akpm@osdl.org>
In-Reply-To: <20040127232950.GA63863@colin2.muc.de>
References: <200401232253.08552.eric@cisu.net>
	<200401261326.09903.eric@cisu.net>
	<20040126115614.351393f2.akpm@osdl.org>
	<200401262343.35633.eric@cisu.net>
	<20040126215056.4e891086.akpm@osdl.org>
	<20040127162043.GA98702@colin2.muc.de>
	<20040127125447.31631e14.akpm@osdl.org>
	<20040127223009.GA81095@colin2.muc.de>
	<20040127151644.1fb378c2.akpm@osdl.org>
	<20040127232950.GA63863@colin2.muc.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> > I'll turn it on for gcc-3.3 and higher.  We can change that if someone has
> > tested earlier compilers.
> 
> Earlier compilers never supported -funit-at-a-time. The option 
> was first implemented in gcc 3.3-hammer and later merged into 3.4.

OK, then let's use check-gcc again.

> > Also, I do think this should remain a per-arch decision.  Other
> > architectures could well have similar problems to this and we don't want to
> > be mysteriously breaking their kernels for them.
> 
> That's fine by me. While you're at it could you enable it for x86-64 too?

yup.


diff -puN arch/i386/Makefile~use-funit-at-a-time arch/i386/Makefile
--- 25/arch/i386/Makefile~use-funit-at-a-time	Tue Jan 27 15:40:09 2004
+++ 25-akpm/arch/i386/Makefile	Tue Jan 27 15:42:26 2004
@@ -73,6 +73,10 @@ cflags-$(CONFIG_X86_ELAN)	:= -march=i486
 GCC_VERSION			:= $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
 cflags-$(CONFIG_REGPARM) 	+= $(shell if [ $(GCC_VERSION) -ge 0300 ] ; then echo "-mregparm=3"; fi ;)
 
+# Enable unit-at-a-time mode when possible. It shrinks the
+# kernel considerably.
+CFLAGS += $(call check_gcc,-funit-at-a-time,)
+
 CFLAGS += $(cflags-y)
 
 # Default subarch .c files
diff -puN arch/x86_64/Makefile~use-funit-at-a-time arch/x86_64/Makefile
--- 25/arch/x86_64/Makefile~use-funit-at-a-time	Tue Jan 27 15:42:34 2004
+++ 25-akpm/arch/x86_64/Makefile	Tue Jan 27 15:44:44 2004
@@ -52,7 +52,10 @@ CFLAGS += -Wno-sign-compare
 ifneq ($(CONFIG_DEBUG_INFO),y)
 CFLAGS += -fno-asynchronous-unwind-tables
 endif
-#CFLAGS += $(call check_gcc,-funit-at-a-time,)
+
+# Enable unit-at-a-time mode when possible. It shrinks the
+# kernel considerably.
+CFLAGS += $(call check_gcc,-funit-at-a-time,)
 
 head-y := arch/x86_64/kernel/head.o arch/x86_64/kernel/head64.o arch/x86_64/kernel/init_task.o
 

_

