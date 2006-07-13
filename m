Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWGMByo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWGMByo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 21:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWGMByo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 21:54:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62145 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751484AbWGMByo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 21:54:44 -0400
Date: Wed, 12 Jul 2006 18:51:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: ak@suse.de, alan@lxorguk.ukuu.org.uk, arjan@infradead.org, bunk@stusta.de,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org, alan@redhat.com,
       torvalds@osdl.org
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-Id: <20060712185103.f41b51d2.akpm@osdl.org>
In-Reply-To: <20060712210732.GA10182@elte.hu>
References: <20060630014050.GI19712@stusta.de>
	<20060630045228.GA14677@opteron.random>
	<20060630094753.GA14603@elte.hu>
	<20060630145825.GA10667@opteron.random>
	<20060711073625.GA4722@elte.hu>
	<20060711141709.GE7192@opteron.random>
	<1152628374.3128.66.camel@laptopd505.fenrus.org>
	<20060711153117.GJ7192@opteron.random>
	<1152635055.18028.32.camel@localhost.localdomain>
	<p73wtain80h.fsf@verdi.suse.de>
	<20060712210732.GA10182@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 23:07:32 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> Despite good resons to apply the patch, it has not been applied yet, 
> with no explanation.

I queued the below.  Andrea claims that it'll reduce seccomp overhead to
literally zero.

But looking at it, I think it's a bit confused.  The patch needs
s/DISABLE_TSC/ENABLE_TSC/ to make it right.





From: Andrea Arcangeli <andrea@cpushare.com>

Make the TSC disable purely paranoid feature optional, so by default seccomp
returns absolutely zerocost.

Signed-off-by: Andrea Arcangeli <andrea@cpushare.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/Kconfig            |   12 ++++++++++++
 arch/i386/kernel/process.c   |    2 ++
 arch/x86_64/Kconfig          |   12 ++++++++++++
 arch/x86_64/kernel/process.c |   31 +++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+)

diff -puN arch/i386/Kconfig~add-seccomp_disable_tsc-config-option arch/i386/Kconfig
--- a/arch/i386/Kconfig~add-seccomp_disable_tsc-config-option
+++ a/arch/i386/Kconfig
@@ -737,6 +737,18 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config SECCOMP_DISABLE_TSC
+	bool "Disable the TSC for seccomp tasks"
+	depends on SECCOMP
+	default n
+	help
+	  This feature mathematically prevents covert channels
+	  for tasks running under SECCOMP. This can generate
+	  a minuscule overhead in the scheduler.
+
+	  If you care most about performance say N. Say Y only if you're
+	  paranoid about covert channels.
+
 config VGA_NOPROBE
        bool "Don't probe VGA at boot" if EMBEDDED
        default n
diff -puN arch/i386/kernel/process.c~add-seccomp_disable_tsc-config-option arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c~add-seccomp_disable_tsc-config-option
+++ a/arch/i386/kernel/process.c
@@ -572,6 +572,7 @@ handle_io_bitmap(struct thread_struct *n
 static inline void disable_tsc(struct task_struct *prev_p,
 			       struct task_struct *next_p)
 {
+#ifdef CONFIG_SECCOMP_DISABLE_TSC
 	struct thread_info *prev, *next;
 
 	/*
@@ -590,6 +591,7 @@ static inline void disable_tsc(struct ta
 			   has_secure_computing(next))
 			write_cr4(read_cr4() | X86_CR4_TSD);
 	}
+#endif
 }
 
 /*
diff -puN arch/x86_64/Kconfig~add-seccomp_disable_tsc-config-option arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig~add-seccomp_disable_tsc-config-option
+++ a/arch/x86_64/Kconfig
@@ -526,6 +526,18 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config SECCOMP_DISABLE_TSC
+	bool "Disable the TSC for seccomp tasks"
+	depends on SECCOMP
+	default n
+	help
+	  This feature mathematically prevents covert channels
+	  for tasks running under SECCOMP. This can generate
+	  a minuscule overhead in the scheduler.
+
+	  If you care most about performance say N. Say Y only if you're
+	  paranoid about covert channels.
+
 source kernel/Kconfig.hz
 
 config REORDER
diff -puN arch/x86_64/kernel/process.c~add-seccomp_disable_tsc-config-option arch/x86_64/kernel/process.c
--- a/arch/x86_64/kernel/process.c~add-seccomp_disable_tsc-config-option
+++ a/arch/x86_64/kernel/process.c
@@ -494,6 +494,35 @@ out:
 }
 
 /*
+ * This function selects if the context switch from prev to next
+ * has to tweak the TSC disable bit in the cr4.
+ */
+static inline void disable_tsc(struct task_struct *prev_p,
+			       struct task_struct *next_p)
+{
+#ifdef CONFIG_SECCOMP_DISABLE_TSC
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
+#endif
+}
+
+/*
  * This special macro can be used to load a debugging register
  */
 #define loaddebug(thread,r) set_debugreg(thread->debugreg ## r, r)
@@ -622,6 +651,8 @@ __switch_to(struct task_struct *prev_p, 
 		}
 	}
 
+	disable_tsc(prev_p, next_p);
+
 	/* If the task has used fpu the last 5 timeslices, just do a full
 	 * restore of the math state immediately to avoid the trap; the
 	 * chances of needing FPU soon are obviously high now
_

