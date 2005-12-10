Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbVLJE0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbVLJE0M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 23:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVLJE0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 23:26:11 -0500
Received: from mx1.suse.de ([195.135.220.2]:40093 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964910AbVLJE0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 23:26:10 -0500
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
References: <1134154208.14363.8.camel@mindpipe> <439A0746.80208@mnsu.edu>
	<1134173138.18432.41.camel@mindpipe> <439A201D.7030103@mnsu.edu>
	<1134179410.18432.66.camel@mindpipe>
From: Andi Kleen <ak@suse.de>
Date: 10 Dec 2005 01:56:56 -0700
In-Reply-To: <1134179410.18432.66.camel@mindpipe>
Message-ID: <p73oe3ppbxj.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:
> > 
> > Yes, some commands NEED the -m64 and and WILL NOT work with -m64.
> > 
> 
> Aha!  I disabled CONFIG_IA32_EMULATION and it works perfectly.
> 
> So all that's needed to build an x86_64 kernel with the i386 Ubuntu 5.10
> toolchain:
> 
>  - edit Makefile: add -m64 to CFLAGS and AFLAGS

I guess I can add that.

I'm surprised someone does such a weird setup. Only the very early
x86-64 distributions set up the gccs like this until it was noticed
that a gcc compiled for 64bit targets run noticeable slower on 32bit
and needs more memory. That's because it does everything with long
long internally then and gcc's code generation for long long is not
exactly great. So it's normally better to use a separate cross 
compiler for 64bit to keep the 32bit compilations running faster.

Ubuntu seems didn't pay attention to history and just repated that
mistake. In addition they don't seem to be very fond of contributing
changes back - normally one would expect the distribution maintainer
to submit a patch like this if they set up their gcc in non
traditional this way. 

But you're the first to bring this problem to my attention.

>  - disable CONFIG_IA32_EMULATION

I just tried it here. Adding -m64 to CFLAGS/AFLAGS on a native
64bit biarch toolchain and it compiled without problems. It ends
up with -m64 -m32 for the 32bit vsyscall files, but that seems
to DTRT at least in gcc 4.

I'm not sure what's going wrong. If you use a freshly unmodified tree
and apply the appended patch does it work for you?

-Andi

Pass -m64 by default

This might help on distributions that use a 32bit biarch compiler.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/Makefile
===================================================================
--- linux.orig/arch/x86_64/Makefile
+++ linux/arch/x86_64/Makefile
@@ -31,6 +31,7 @@ cflags-$(CONFIG_MK8) += $(call cc-option
 cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
 CFLAGS += $(cflags-y)
 
+CFLAGS += -m64
 CFLAGS += -mno-red-zone
 CFLAGS += -mcmodel=kernel
 CFLAGS += -pipe
@@ -52,6 +53,8 @@ CFLAGS += $(call cc-option,-funit-at-a-t
 # prevent gcc from generating any FP code by mistake
 CFLAGS += $(call cc-option,-mno-sse -mno-mmx -mno-sse2 -mno-3dnow,)
 
+AFLAGS += -m64
+
 head-y := arch/x86_64/kernel/head.o arch/x86_64/kernel/head64.o arch/x86_64/kernel/init_task.o
 
 libs-y 					+= arch/x86_64/lib/
