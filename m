Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVKUSkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVKUSkZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 13:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVKUSkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 13:40:25 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38745
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S932395AbVKUSkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 13:40:25 -0500
Date: Mon, 21 Nov 2005 19:40:22 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: disable tsc with seccomp
Message-ID: <20051121184022.GA5871@opteron.random>
References: <20051105134727.GF18861@opteron.random> <200511051712.09280.ak@suse.de> <20051105163134.GC14064@opteron.random> <200511051804.08306.ak@suse.de> <20051106015542.GE14064@opteron.random> <20051121164349.GE14746@opteron.random> <20051121170517.GA20775@brahms.suse.de> <20051121171616.GH14746@opteron.random> <20051121172444.GB20775@brahms.suse.de> <20051121173855.GI14746@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121173855.GI14746@opteron.random>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 04:37:44PM +0100, Andi Kleen wrote:
> It was useless, you can get exactly the same information by using
> RDPMC on perfctr 0 which always runs the NMI watchdog and counts all
> cycles too.

I can't see how you can claim that you can read stuff with rdpmc.

andrea@opteron:~> gdb ./a.out 
GNU gdb 6.3
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you
are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for
details.
This GDB was configured as "x86_64-suse-linux"...Using host libthread_db
library "/lib64/tls/libthread_db.so.1".

(gdb) r
Starting program: /home/andrea/a.out 

Program received signal SIGSEGV, Segmentation fault.
0x00000000004004bc in main ()
(gdb) dis 0x00000000004004bc
warning: bad breakpoint number at or near '0x00000000004004bc'
(gdb) disassem 0x00000000004004bc
Dump of assembler code for function main:
0x00000000004004b8 <main+0>:    push   %rbp
0x00000000004004b9 <main+1>:    mov    %rsp,%rbp
0x00000000004004bc <main+4>:    rdpmc  


I get an immediate segfault if I try to execute that instruction. infact
the PCE bitflag is _already_ zero (checked with sysrq+P). 

Perhaps you mean if you change the kernel to allow RDPMC then you have a
problem? But then it means your kernel modifications are buggy if they
break seccomp.

Please tell me how to generate a convert channel with an unmodified
2.6.15-rc2 plus the attached patch applied so I can fix it too. I also
moved the seccomp struct next to the scheduler data so the two
cachelines may be hot already and the theoretical overhead may go away
too.

And next time please bother to send me an email instead of silenty
backing out my recent patches from your tree, especially when your
backouts might decrease the security of some users of the kernel.
I was lucky that Andrew notified me about it. (thanks!)

In the below patch I also added a forced clear of the PCE just in case
somebody writes buggy kernel code (as an additional security measure so
if somebody writes buggy code like you seem to imply, seccomp still
won't break this way, the buggy code will break instead and it will
deserve it ;).

Signed-off-by: Andrea Arcangeli <andrea@cpushare.com>

diff -r 6377b3f31134 include/linux/sched.h
--- a/include/linux/sched.h	Mon Nov 21 06:06:28 2005 +0800
+++ b/include/linux/sched.h	Mon Nov 21 20:04:38 2005 +0200
@@ -713,6 +719,8 @@
 #ifdef CONFIG_SCHEDSTATS
 	struct sched_info sched_info;
 #endif
+
+	seccomp_t seccomp;
 
 	struct list_head tasks;
 	/*
@@ -810,7 +818,6 @@
 	
 	void *security;
 	struct audit_context *audit_context;
-	seccomp_t seccomp;
 
 /* Thread group tracking */
    	u32 parent_exec_id;
diff -r 6377b3f31134 arch/x86_64/kernel/process.c
--- a/arch/x86_64/kernel/process.c	Mon Nov 21 06:06:28 2005 +0800
+++ b/arch/x86_64/kernel/process.c	Mon Nov 21 20:04:38 2005 +0200
@@ -485,6 +485,33 @@
 }
 
 /*
+ * This function selects if the context switch from prev to next
+ * has to tweak the TSC disable bit in the cr4.
+ */
+static inline void disable_tsc(struct task_struct *prev_p,
+			       struct task_struct *next_p)
+{
+	struct thread_info *prev, *next;
+
+	/*
+	 * gcc should eliminate the ->thread_info dereference if
+	 * has_secure_computing returns 0 at compile time (SECCOMP=n).
+	 */
+	prev = prev_p->thread_info;
+	next = next_p->thread_info;
+
+	if (has_secure_computing(prev) || has_secure_computing(next)) {
+		/* slow path here */
+		if (has_secure_computing(prev) &&
+		    !has_secure_computing(next)) {
+			write_cr4(read_cr4() & ~X86_CR4_TSD);
+		} else if (!has_secure_computing(prev) &&
+			   has_secure_computing(next))
+			write_cr4((read_cr4() | X86_CR4_TSD) & ~X86_CR4_PCE);
+	}
+}
+
+/*
  * This special macro can be used to load a debugging register
  */
 #define loaddebug(thread,r) set_debug(thread->debugreg ## r, r)
@@ -603,6 +630,8 @@
 			memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
 		}
 	}
+
+	disable_tsc(prev_p, next_p);
 
 	return prev_p;
 }
