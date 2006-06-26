Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWFZQ0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWFZQ0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWFZQ0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:26:51 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59914 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750767AbWFZQ0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:26:50 -0400
Date: Mon, 26 Jun 2006 18:26:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: [2.6 patch] let CONFIG_SECCOMP default to n
Message-ID: <20060626162649.GV23314@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

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
- 27 Apr 2006
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

