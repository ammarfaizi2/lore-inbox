Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268836AbUJKLo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268836AbUJKLo3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 07:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268824AbUJKLoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 07:44:14 -0400
Received: from oceanite.ens-lyon.fr ([140.77.1.22]:41407 "EHLO
	oceanite.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S268819AbUJKLoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 07:44:01 -0400
Message-ID: <416A71FF.2040602@ens-lyon.fr>
Date: Mon, 11 Oct 2004 13:43:59 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, benoit.boissinot@ens-lyon.org
Subject: Re: 2.6.9-rc4-mm1
References: <20041011032502.299dc88d.akpm@osdl.org>
In-Reply-To: <20041011032502.299dc88d.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------000707020102030105010401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000707020102030105010401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Andrew Morton wrote:
 >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/
[...]
 > kgdb-ga.patch
 >   kgdb stub for ia32 (George Anzinger's one)
 >   kgdbL warning fix
 >   kgdb buffer overflow fix
 >   kgdbL warning fix
 >   kgdb: CONFIG_DEBUG_INFO fix
 >   x86_64 fixes
 >   correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)
 >   kgdb: fix for recent gcc
 >   kgdb warning fixes
 >   THREAD_SIZE fixes for kgdb
 >   Fix stack overflow test for non-8k stacks
 >   kgdb-ga.patch fix for i386 single-step into sysenter
 >   fix TRAP_BAD_SYSCALL_EXITS on i386
 >   add TRAP_BAD_SYSCALL_EXITS config for i386

Hi Andrew,

When compiling on my P3 with CONFIG_KGDB, I get this error :

   CC      arch/i386/kernel/traps.o
arch/i386/kernel/traps.c: Dans la fonction « do_debug »:
arch/i386/kernel/traps.c:776: error: `sysenter_past_esp' undeclared 
(first use in this function)
arch/i386/kernel/traps.c:776: error: (Each undeclared identifier is 
reported only once
arch/i386/kernel/traps.c:776: error: for each function it appears in.)
make[1]: *** [arch/i386/kernel/traps.o] Erreur 1
make: *** [arch/i386/kernel] Erreur 2

sysenter_past_esp is declared (as extern). But it seems that 
kgdb-ga.patch moved it inside of the the print_context_stack
function so that it's not visible outside anymore.

Moving "extern void sysenter_past_esp()" outside of print_context_stack
seems to fix compiling. Hope this won't break anything else.
Patch attached.

Regards
Brice Goglin



--------------000707020102030105010401
Content-Type: text/x-patch;
 name="move-sysenter_past_esp-outside.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="move-sysenter_past_esp-outside.diff"

--- arch/i386/kernel/traps.c.old	2004-10-11 13:22:01.000000000 +0200
+++ arch/i386/kernel/traps.c	2004-10-11 13:39:24.000000000 +0200
@@ -91,6 +91,10 @@
 asmlinkage void spurious_interrupt_bug(void);
 asmlinkage void machine_check(void);
 
+#ifdef CONFIG_KGDB
+extern void sysenter_past_esp(void);
+#endif
+
 static int kstack_depth_to_print = 24;
 struct notifier_block *i386die_chain;
 static spinlock_t die_notifier_lock = SPIN_LOCK_UNLOCKED;
@@ -117,7 +121,6 @@
 	unsigned long addr;
 
 #ifdef CONFIG_KGDB
-extern void sysenter_past_esp(void);
 #include <asm/kgdb.h>
 #include <linux/init.h>
 void set_intr_gate(unsigned int n, void *addr);

--------------000707020102030105010401--
