Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWGRKZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWGRKZe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWGRKZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:25:34 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:34523 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932126AbWGRKZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:25:34 -0400
Date: Tue, 18 Jul 2006 06:20:20 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] TIF_NOTSC and SECCOMP prctl
To: "andrea@cpushare.com" <andrea@cpushare.com>
Cc: "bruce@andrew.cmu.edu" <bruce@andrew.cmu.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Lee Revell <rlrevell@joe-job.com>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Message-ID: <200607180623_MC3-1-C54F-3802@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060714060932.GE18774@opteron.random>

On Fri, 14 Jul 2006 08:09:32 +0200, andrea@cpushare.com wrote:

> The below patch seems to work, I ported all my client code on top of
> prctl already. (it's a bit more painful to autodetect a kernel with
> CONFIG_SECCOMP turned off but I already adapted to it)

AFAIC the /proc method of controlling seccomp is so ugly it should
just go, but what about backwards compatibility?

I have a couple of questions:


+void disable_TSC(void)
+{
+       if (!test_and_set_thread_flag(TIF_NOTSC))
+               /*
+                * Must flip the CPU state synchronously with
+                * TIF_NOTSC in the current running context.
+                */
+               hard_disable_TSC();
+}

This gets called from sys_prctl().  Do you need to worry about preemption
between the test_and_set and TSC disable?


--- a/include/asm-i386/processor.h      Thu Jul 13 03:03:35 2006 +0700
+++ b/include/asm-i386/processor.h      Fri Jul 14 07:47:57 2006 +0200
@@ -256,6 +256,10 @@ static inline void clear_in_cr4 (unsigne
        cr4 &= ~mask;
        write_cr4(cr4);
 }
+
+extern void hard_disable_TSC(void);
+extern void disable_TSC(void);
+extern void hard_enable_TSC(void);

Maybe these should be inline?  They're really small and that way you
don't need #ifdef around the code for them.


> Reviews are welcome (then I will move into x86-64, all other archs
> supporting seccomp should require no changes despite the API
> change). Thanks.

For x86_64 you need this:

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt-current/patches/tif-flags-for-debug-regs-and-io-bitmap-in-ctxsw

But I don't think Andi plans on pushing it for 2.6.18.

-- 
Chuck
