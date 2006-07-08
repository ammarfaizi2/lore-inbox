Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWGHJWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWGHJWP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 05:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWGHJWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 05:22:15 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:26852
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1751274AbWGHJWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 05:22:14 -0400
Date: Sat, 8 Jul 2006 11:23:13 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       bunk@stusta.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Message-ID: <20060708092313.GD5135@opteron.random>
References: <20060629192121.GC19712@stusta.de> <1151628246.22380.58.camel@mindpipe> <20060629180706.64a58f95.akpm@osdl.org> <20060629193525.af983237.rdunlap@xenotime.net> <1151679780.32444.21.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151679780.32444.21.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 11:03:00AM -0400, Lee Revell wrote:
> On Thu, 2006-06-29 at 19:35 -0700, Randy.Dunlap wrote:
> > On Thu, 29 Jun 2006 18:07:06 -0700 Andrew Morton wrote:
> > 
> > > Lee Revell <rlrevell@joe-job.com> wrote:
> > > >
> > > > On Thu, 2006-06-29 at 21:21 +0200, Adrian Bunk wrote:
> > > > > This patch was already sent on:
> > > > > - 26 Jun 2006
> > > > > - 27 Apr 2006
> > > > > - 19 Apr 2006
> > > > > - 11 Apr 2006
> > > > > - 10 Mar 2006
> > > > > - 29 Jan 2006
> > > > > - 21 Jan 2006 
> > > > 
> > > > 3 days ago?  That seems a bit silly.  Why didn't you just ping Andrew on
> > > > it?
> > > > 
> > > > Andrew, what's the status of this?  Can we get an ACK or a NACK before
> > > > this starts getting reposted every day? ;-)
> > > > 
> > > 
> > > I am stolidly letting the arch maintainers and the developer of this
> > > feature work out what to do.
> > 
> > Bah, options that are not Required should default to n.
> > I support Adrian's patch.
> 
> Agreed:
> 
> - Most people don't use it
> - There's a performance hit

On x86-64 SECCOMP generates absoutely zero performance hit.

The original seccomp patch for x86 also generated absolutely zero
performance hit, both pratically and theoretically too. _zero_ CPU
cycles of difference, zero cachelines.

What generates a minuscle overhead is a feature I added later on top of
SECCOMP, that disables TSC for SECCOMP tasks. I thought such minuscle
overhead wouldn't be measurable compared to all other heavyweight work
we do in the scheduler (note that unless you sell cpu through CPUShare
actively this overhead consists in two cacheline touches per context
switch), but anyway I agree it's good idea to make it optional so
there will be absolutely no reason left to leave seccomp disabled by
default anymore.

Andi thinks the feature is absolutely unnecessary, he's certainly right,
and it has been there only for paranoid reasons.

	http://www.cpushare.com/blog/CPUShare/article/26/

> Clearly should default to N.

I think the best is to add a CONFIG_SECCOMP_DISABLE_TSC obviously
defaulted to N, so seccomp returns absolutely zerocost and everybody
will be happy (me included for sure, since I agree with Andi, except I
can't be sure of it and that's the only reason why I developed the tsc
disable feature).

I strongly agree with leaving CONFIG_SECCOMP_DISABLE_TSC set to N by
default.

-------------

Make the TSC disable purely paranoid feature optional, so by default seccomp
returns absolutely zerocost.

Signed-off-by: Andrea Arcangeli <andrea@cpushare.com>

diff -r 67137165b47d arch/i386/Kconfig
--- a/arch/i386/Kconfig	Thu Jul 06 19:45:01 2006 +0200
+++ b/arch/i386/Kconfig	Sat Jul 08 11:06:49 2006 +0200
@@ -734,6 +734,18 @@ config SECCOMP
 	  defined by each seccomp mode.
 
 	  If unsure, say Y. Only embedded should say N here.
+
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
 
 source kernel/Kconfig.hz
 
diff -r 67137165b47d arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Thu Jul 06 19:45:01 2006 +0200
+++ b/arch/i386/kernel/process.c	Sat Jul 08 11:05:35 2006 +0200
@@ -572,6 +572,7 @@ static inline void disable_tsc(struct ta
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
diff -r 67137165b47d arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	Thu Jul 06 19:45:01 2006 +0200
+++ b/arch/x86_64/Kconfig	Sat Jul 08 11:06:40 2006 +0200
@@ -522,6 +522,18 @@ config SECCOMP
 
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
diff -r 67137165b47d arch/x86_64/kernel/process.c
--- a/arch/x86_64/kernel/process.c	Thu Jul 06 19:45:01 2006 +0200
+++ b/arch/x86_64/kernel/process.c	Sat Jul 08 11:05:26 2006 +0200
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
@@ -617,6 +646,8 @@ __switch_to(struct task_struct *prev_p, 
 			memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
 		}
 	}
+
+	disable_tsc(prev_p, next_p);
 
 	return prev_p;
 }

