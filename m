Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWAIJgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWAIJgb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 04:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWAIJgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 04:36:31 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:32670 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751203AbWAIJgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 04:36:31 -0500
Date: Mon, 9 Jan 2006 10:36:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrea Arcangeli <andrea@cpushare.com>
Subject: [patch] make CONFIG_SECCOMP default=n
Message-ID: <20060109093633.GA20877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i was profiling the scheduler on x86 and noticed some overhead related 
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

	Ingo

--

turn SECCOMP off by default - it adds runtime per-context-switch 
overhead on x86, and bloats the kernel.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----
 arch/i386/Kconfig    |    2 +-
 arch/mips/Kconfig    |    2 +-
 arch/powerpc/Kconfig |    2 +-
 arch/ppc/Kconfig     |    2 +-
 arch/sparc64/Kconfig |    2 +-
 arch/x86_64/Kconfig  |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

Index: linux/arch/i386/Kconfig
===================================================================
--- linux.orig/arch/i386/Kconfig
+++ linux/arch/i386/Kconfig
@@ -637,7 +637,7 @@ config REGPARM
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
-	default y
+	default n
 	help
 	  This kernel feature is useful for number crunching applications
 	  that may need to compute untrusted bytecode during their
Index: linux/arch/mips/Kconfig
===================================================================
--- linux.orig/arch/mips/Kconfig
+++ linux/arch/mips/Kconfig
@@ -1787,7 +1787,7 @@ config BINFMT_ELF32
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS && BROKEN
-	default y
+	default n
 	help
 	  This kernel feature is useful for number crunching applications
 	  that may need to compute untrusted bytecode during their
Index: linux/arch/powerpc/Kconfig
===================================================================
--- linux.orig/arch/powerpc/Kconfig
+++ linux/arch/powerpc/Kconfig
@@ -666,7 +666,7 @@ endif
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
-	default y
+	default n
 	help
 	  This kernel feature is useful for number crunching applications
 	  that may need to compute untrusted bytecode during their
Index: linux/arch/ppc/Kconfig
===================================================================
--- linux.orig/arch/ppc/Kconfig
+++ linux/arch/ppc/Kconfig
@@ -1127,7 +1127,7 @@ endif
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
-	default y
+	default n
 	help
 	  This kernel feature is useful for number crunching applications
 	  that may need to compute untrusted bytecode during their
Index: linux/arch/sparc64/Kconfig
===================================================================
--- linux.orig/arch/sparc64/Kconfig
+++ linux/arch/sparc64/Kconfig
@@ -64,7 +64,7 @@ endchoice
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
-	default y
+	default n
 	help
 	  This kernel feature is useful for number crunching applications
 	  that may need to compute untrusted bytecode during their
Index: linux/arch/x86_64/Kconfig
===================================================================
--- linux.orig/arch/x86_64/Kconfig
+++ linux/arch/x86_64/Kconfig
@@ -466,7 +466,7 @@ config PHYSICAL_START
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
-	default y
+	default n
 	help
 	  This kernel feature is useful for number crunching applications
 	  that may need to compute untrusted bytecode during their
