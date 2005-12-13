Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbVLMOdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbVLMOdX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 09:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVLMOdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 09:33:23 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:4565 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964936AbVLMOdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 09:33:22 -0500
Subject: [PATCH -RT] fix i386 RWSEM_GENERIC_SPINLOCK (was: Re:
	2.6.15-rc5-rt1 will not compile)
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, david singleton <dsingleton@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20051213081502.GB10088@elte.hu>
References: <1133189789.5228.7.camel@mindpipe>
	 <20051128160052.GA29540@elte.hu> <1133217651.4678.2.camel@mindpipe>
	 <1133230103.5640.0.camel@mindpipe> <20051129072922.GA21696@elte.hu>
	 <20051129093231.GA5028@elte.hu> <1134090316.11053.3.camel@mindpipe>
	 <1134174330.18432.46.camel@mindpipe> <1134409469.15074.1.camel@mindpipe>
	 <1134424143.24145.6.camel@localhost.localdomain>
	 <20051213081502.GB10088@elte.hu>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 09:32:44 -0500
Message-Id: <1134484364.24145.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-13 at 09:15 +0100, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Looks like Ingo has a generic rwsem to work with, but if your arch 
> > turns on CONFIG_RWSEM_XCHGADD_ALGORITHM, it will compile lib/rwsem.c 
> > which won't compile as you've seen.
> > 
> > Try out this patch: I changed the Makefile, instead of going to each 
> > and every arch and change its Kconfig to do it properly.
> 
> i rather went for fixing up the Kconfig, that makes things easier to 
> follow. If it turns out to be lots of duplicate stuff we could create a 
> lib/Kconfig.rwsem that architectures can include.
> 

OK, scratch my last patch.  I'll submit this arch per arch.  Starting
with i386.  Each arch does it differently, so a generic lib/Konfig.rwsem
wouldn't work, since each arch has a different dependency.

-- Steve

Quick note:

I originally had:  default y if !(RWSEM_GENERIC_SPINLOCK || PREEMPT_RT || M386)
But then I realized that RWSEM_GENERIC_SPINLOCK was dependent on 
(PREEMPT_RT || M386) so I thought it was redundant to keep the three,
since RWSEM_GENERIC_SPINLOCK itself satisfies the dependencies.


Index: linux-2.6.15-rc5-rt1/arch/i386/Kconfig
===================================================================
--- linux-2.6.15-rc5-rt1.orig/arch/i386/Kconfig	2005-12-12 16:31:25.000000000 -0500
+++ linux-2.6.15-rc5-rt1/arch/i386/Kconfig	2005-12-13 09:14:33.000000000 -0500
@@ -245,8 +245,7 @@
 
 config RWSEM_XCHGADD_ALGORITHM
 	bool
-	depends on !RWSEM_GENERIC_SPINLOCK && !PREEMPT_RT
-	default y
+	default y if !RWSEM_GENERIC_SPINLOCK
 
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors"
Index: linux-2.6.15-rc5-rt1/arch/i386/Kconfig.cpu
===================================================================
--- linux-2.6.15-rc5-rt1.orig/arch/i386/Kconfig.cpu	2005-12-12 16:31:20.000000000 -0500
+++ linux-2.6.15-rc5-rt1/arch/i386/Kconfig.cpu	2005-12-13 09:10:54.000000000 -0500
@@ -229,11 +229,6 @@
 	depends on M386
 	default y
 
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	depends on !M386
-	default y
-
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
Index: linux-2.6.15-rc5-rt1/arch/i386/defconfig
===================================================================
--- linux-2.6.15-rc5-rt1.orig/arch/i386/defconfig	2005-10-27 20:02:08.000000000 -0400
+++ linux-2.6.15-rc5-rt1/arch/i386/defconfig	2005-12-13 09:05:21.000000000 -0500
@@ -81,7 +81,7 @@
 CONFIG_X86_CMPXCHG=y
 CONFIG_X86_XADD=y
 CONFIG_X86_L1_CACHE_SHIFT=7
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 CONFIG_X86_WP_WORKS_OK=y
 CONFIG_X86_INVLPG=y
 CONFIG_X86_BSWAP=y


