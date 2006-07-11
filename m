Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbWGKHmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWGKHmG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWGKHmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:42:05 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:50587 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964947AbWGKHmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:42:04 -0400
Date: Tue, 11 Jul 2006 09:36:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: andrea@cpushare.com
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@osdl.org>
Subject: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060711073625.GA4722@elte.hu>
References: <20060629192121.GC19712@stusta.de> <1151628246.22380.58.camel@mindpipe> <20060629180706.64a58f95.akpm@osdl.org> <20060630014050.GI19712@stusta.de> <20060630045228.GA14677@opteron.random> <20060630094753.GA14603@elte.hu> <20060630145825.GA10667@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630145825.GA10667@opteron.random>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5082]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* andrea@cpushare.com <andrea@cpushare.com> wrote:

> On Fri, Jun 30, 2006 at 11:47:53AM +0200, Ingo Molnar wrote:
> > and both are pledged and available to GPL users. [..]
> 
> If the GPL offered any protection to my system software I would 
> consider it too, but the GPL can't protect software that runs behind 
> the corporate firewall. [...]

so you admit and confirm that you explicitly and intentionally do not 
pledge your patent to GPL users. That is troubling (and unethical) in my 
opinion and strengthens my argument that this feature should be _at a 
minimum_ be made default-off, just like hundreds of other kernel 
features are.

I'm also wondering what the upstream decision would have been, had you 
disclosed this patent licensing intention of yours. (to use the GPL-ed 
Linux kernel as a vehicle for your 'invention', while not fully living 
up to the basic quid-pro-quo.).

and i'm not really interested in marketing arguments about cpushare and 
seccomp in general. What matters to me is that this feature has been in 
the kernel for more than a year already, that nobody but you is using it 
and that _everyone_ using the default kernel options is paying the price 
in the context-switch hotpath. (The fact that in my view one of 
seccomp's obvious user-space usages is also patent-tainted without a 
fair pledge is 'just' icing on the cake.)

So i'd like to request the patch below to be included in v2.6.18.

	Ingo

---------------->
From: Ingo Molnar <mingo@elte.hu>
Subject: let CONFIG_SECCOMP default to n

I was profiling the scheduler on x86 and noticed some overhead related 
to SECCOMP, and indeed, SECCOMP runs disable_tsc() at _every_ 
context-switch:

        if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr))
                handle_io_bitmap(next, tss);

        disable_tsc(prev_p, next_p);

        return prev_p;

these are a couple of instructions in the hottest scheduler codepath!

x86_64 already removed disable_tsc() from switch_to(), but i think the 
right solution is to turn SECCOMP off by default.

besides the runtime overhead, there are a couple of other reasons as 
well why this should be done:

 - CONFIG_SECCOMP=y adds 836 bytes of bloat to the kernel:

       text    data     bss     dec     hex filename
    4185360  867112  391012 5443484  530f9c vmlinux-noseccomp
    4185992  867316  391012 5444320  5312e0 vmlinux-seccomp

 - virtually nobody seems to be using it (but cpushare.com, which seems
   pretty inactive)

 - users/distributions can still turn it on if they want it

 - http://www.cpushare.com/legal seems to suggest that it is pursuing a
   software patent to utilize the seccomp concept in a distributed 
   environment, and seems to give a promise that 'end users' will not be
   affected by that patent. How about non-end-users [i.e. server-side]?
   Has the Linux kernel become a vehicle for a propriety server-side
   feature, with every Linux user paying the price of it?

so the patch below just does the minimal common-sense change: turn it 
off by default.

Adrian Bunk:
I've removed the superfluous "default n"'s the original patch introduced.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

----

This patch was already sent on:
- 19 Apr 2006
- 11 Apr 2006
- 10 Mar 2006
- 29 Jan 2006
- 21 Jan 2006

This patch was sent by Ingo Molnar on:
- 9 Jan 2006

Index: linux/arch/i386/Kconfig
===================================================================
--- linux.orig/arch/i386/Kconfig
+++ linux/arch/i386/Kconfig
@@ -637,7 +637,6 @@ config REGPARM
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
-	default y
 	help
 	  This kernel feature is useful for number crunching applications
 	  that may need to compute untrusted bytecode during their
Index: linux/arch/mips/Kconfig
===================================================================
--- linux.orig/arch/mips/Kconfig
+++ linux/arch/mips/Kconfig
@@ -1787,7 +1787,6 @@ config BINFMT_ELF32
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS && BROKEN
-	default y
 	help
 	  This kernel feature is useful for number crunching applications
 	  that may need to compute untrusted bytecode during their
Index: linux/arch/powerpc/Kconfig
===================================================================
--- linux.orig/arch/powerpc/Kconfig
+++ linux/arch/powerpc/Kconfig
@@ -666,7 +666,6 @@ endif
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
-	default y
 	help
 	  This kernel feature is useful for number crunching applications
 	  that may need to compute untrusted bytecode during their
Index: linux/arch/ppc/Kconfig
===================================================================
--- linux.orig/arch/ppc/Kconfig
+++ linux/arch/ppc/Kconfig
@@ -1127,7 +1127,6 @@ endif
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
-	default y
 	help
 	  This kernel feature is useful for number crunching applications
 	  that may need to compute untrusted bytecode during their
Index: linux/arch/sparc64/Kconfig
===================================================================
--- linux.orig/arch/sparc64/Kconfig
+++ linux/arch/sparc64/Kconfig
@@ -64,7 +64,6 @@ endchoice
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
-	default y
 	help
 	  This kernel feature is useful for number crunching applications
 	  that may need to compute untrusted bytecode during their
Index: linux/arch/x86_64/Kconfig
===================================================================
--- linux.orig/arch/x86_64/Kconfig
+++ linux/arch/x86_64/Kconfig
@@ -466,7 +466,6 @@ config PHYSICAL_START
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
-	default y
 	help
 	  This kernel feature is useful for number crunching applications
 	  that may need to compute untrusted bytecode during their

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
