Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWGLVNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWGLVNX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWGLVNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:13:23 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:9881 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932364AbWGLVNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:13:22 -0400
Date: Wed, 12 Jul 2006 23:07:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060712210732.GA10182@elte.hu>
References: <20060630014050.GI19712@stusta.de> <20060630045228.GA14677@opteron.random> <20060630094753.GA14603@elte.hu> <20060630145825.GA10667@opteron.random> <20060711073625.GA4722@elte.hu> <20060711141709.GE7192@opteron.random> <1152628374.3128.66.camel@laptopd505.fenrus.org> <20060711153117.GJ7192@opteron.random> <1152635055.18028.32.camel@localhost.localdomain> <p73wtain80h.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73wtain80h.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5891]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> If the TSC disabling code is taken out the runtime overhead of seccomp 
> is also very small because it's only tested in slow paths.

correct. But when i suggested to do precisely that i got a rant from 
Andrea of how super duper important it was to disable the TSC for 
seccomp ... (which argument is almost total hogwash)

so i'm going with the simpler path of making seccomp default-off. (which 
solves the problem as far as i'm concerned - i.e. no default overhead in 
the scheduler.)

but Andrea's creative arguments wrt. his decision to not pledge the 
seccomp related patent to GPL users makes me worry about whether this 
technology is untainted. We _dont_ want to make Linux reliant on 
possibly hostile patents - especially not for core default-enabled 
functionality. Basically Andrea wants us to help his project but he is 
in essence rejecting to do the same for us (for one of the most obvious 
applications of trusted bytecode: over-the-internet clustering via 
seccomp) - i find that approach fundamentally unfair. And he has not 
given a satisfactory answer either - IMO his 'GPL is not good because of 
the corporate firewall licensing backhole' argument is ridiculous [if he 
doesnt like the GPL he should write his own OS i guess, and not try to 
use a GPL-ed kernel as a vehicle for his technology]. (And he has 
injected his code into code that i authored too, which makes it doubly 
offensive to me.)

the fundamental problem is what i sense to be arrogant behavior of 
Andrea all across. I reported a performance problem months ago with two 
simple patches (the first one fixing seccomp, the second one disabling 
it by default) to get rid of the problem, and what i got was insults 
from Andrea and hours spent on writing pointless emails. Andrea is 
forcing me to invest time into this stupidity and that just increases my 
sense of being abused. I also start being of the opinion that no matter 
how good of a coder Andrea is, i dont want to deal with his code _at 
all_ if such _basic_ issues like performance regressions are so hard to 
communicate. At a minimum Andrea should apologize for all that abuse 
that i got just because i happened to cross his tracks with his 
holy-grail patent-pending technology.

another problem is the double standard Andrea's code is enjoying. 
Despite good resons to apply the patch, it has not been applied yet, 
with no explanation. Again, i request the patch below to be applied to 
the upstream kernel. If Andrea fixes the performance problem and fixes 
the patent taining issue we can turn the feature back on. Is Andrea's 
code above the rules of maintainance?

really, how much more stupid can the situation get before we get a 
resolution?

And i just wasted another 15 minutes on this ...

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
