Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbVLMD2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVLMD2x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 22:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVLMD2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 22:28:53 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:62931 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932422AbVLMD2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 22:28:52 -0500
Subject: Re: 2.6.15-rc5-rt1 will not compile (was Re: 2.6.14-rt15: cannot
	build with !PREEMPT_RT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: david singleton <dsingleton@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1134426711.17058.10.camel@mindpipe>
References: <1133031912.5904.12.camel@mindpipe>
	 <1133034406.32542.308.camel@tglx.tec.linutronix.de>
	 <20051127123052.GA22807@elte.hu> <1133141224.4909.1.camel@mindpipe>
	 <20051128114852.GA3391@elte.hu> <1133189789.5228.7.camel@mindpipe>
	 <20051128160052.GA29540@elte.hu> <1133217651.4678.2.camel@mindpipe>
	 <1133230103.5640.0.camel@mindpipe> <20051129072922.GA21696@elte.hu>
	 <20051129093231.GA5028@elte.hu>  <1134090316.11053.3.camel@mindpipe>
	 <1134174330.18432.46.camel@mindpipe>  <1134409469.15074.1.camel@mindpipe>
	 <1134424143.24145.6.camel@localhost.localdomain>
	 <1134425688.17058.5.camel@mindpipe>
	 <1134426179.24145.15.camel@localhost.localdomain>
	 <1134426711.17058.10.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 22:28:00 -0500
Message-Id: <1134444480.24145.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-12 at 17:31 -0500, Lee Revell wrote:
> On Mon, 2005-12-12 at 17:22 -0500, Steven Rostedt wrote:
> > On Mon, 2005-12-12 at 17:14 -0500, Lee Revell wrote:
> > 
> > > 
> > > The patch had no effect.
> > 
> > The patch should work for krfoley though.  His errors where the same
> > that I had for i386.  I also have it working under x86_64.
> > > 
> > > In fact x86-64 does not set CONFIG_RWSEM_XCHGADD_ALGORITHM so this test
> > > in include/linux/rwsem.h causes asm/rwsem.h to be included which does
> > > not exist on x86-64:
> > 
> > Yeah OK, you have a different problem.  Did you post your .config?  You
> > can send it privately to me if you haven't already posted it.
> 
> Yes I posted the .config earlier in the thread.  Let me know if you want
> me to resend it to you.

Here Lee,

I got it to compile, but I haven't yet tried to boot it.  As a matter of
fact, I haven't booted any 2.6.15-rc5-rt1 on any of my machines.  I must
trust Ingo too much, since I started porting my kernel to his before
testing it to see if it works without my changes.  Oh well, I know what
to do tomorrow.

Well, this compiles, you can see if it boots ;-)

-- Steve

Index: linux-2.6.15-rc5-rt1/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.15-rc5-rt1.orig/arch/x86_64/Kconfig	2005-12-12 10:56:37.000000000 -0500
+++ linux-2.6.15-rc5-rt1/arch/x86_64/Kconfig	2005-12-12 21:33:56.000000000 -0500
@@ -240,7 +240,6 @@
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
-	depends on PREEMPT_RT
 	default y
 
 config RWSEM_XCHGADD_ALGORITHM
Index: linux-2.6.15-rc5-rt1/include/asm-x86_64/semaphore.h
===================================================================
--- linux-2.6.15-rc5-rt1.orig/include/asm-x86_64/semaphore.h	2005-12-12 10:56:37.000000000 -0500
+++ linux-2.6.15-rc5-rt1/include/asm-x86_64/semaphore.h	2005-12-12 22:13:08.000000000 -0500
@@ -104,6 +104,7 @@
 asmlinkage int  __compat_down_interruptible(struct compat_semaphore * sem);
 asmlinkage int  __compat_down_trylock(struct compat_semaphore * sem);
 asmlinkage void __compat_up(struct compat_semaphore * sem);
+asmlinkage int compat_sem_is_locked(struct compat_semaphore *sem);
 
 /*
  * This is ugly, but we want the default case to fall through.
@@ -199,5 +200,10 @@
 		:"D" (sem)
 		:"memory");
 }
+
+#ifndef CONFIG_PREEMPT_RT
+# include <linux/semaphore.h>
+#endif
+
 #endif /* __KERNEL__ */
 #endif
Index: linux-2.6.15-rc5-rt1/include/linux/rwsem.h
===================================================================
--- linux-2.6.15-rc5-rt1.orig/include/linux/rwsem.h	2005-12-12 10:56:37.000000000 -0500
+++ linux-2.6.15-rc5-rt1/include/linux/rwsem.h	2005-12-12 22:13:00.000000000 -0500
@@ -163,6 +163,10 @@
 {
 	compat_downgrade_write(rwsem);
 }
+static inline int rwsem_is_locked(struct compat_rw_semaphore *sem)
+{
+	return compat_rwsem_is_locked(sem);
+}
 #endif /* CONFIG_PREEMPT_RT */
 
 #endif /* __KERNEL__ */


