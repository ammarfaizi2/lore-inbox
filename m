Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWCOWcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWCOWcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWCOWcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:32:32 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:19901 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S932214AbWCOWcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:32:32 -0500
Date: Wed, 15 Mar 2006 17:32:20 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Jeff Garzik <jeff@garzik.org>,
       Lee Revell <rlrevell@joe-job.com>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: [patch] latency-tracing-v2.6.16.patch
Message-ID: <20060315223220.GB17817@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
	Jeff Garzik <jeff@garzik.org>, Lee Revell <rlrevell@joe-job.com>,
	Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
	john stultz <johnstul@us.ibm.com>
References: <200602280022.40769.darkray@ic3man.com> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <20060315220432.GA20926@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315220432.GA20926@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 11:04:33PM +0100, Ingo Molnar wrote:
> 
> * Bill Rugolsky Jr. <brugolsky@telemetry-investments.com> wrote:
> 
> > Here are a pair of traces from Ingo's latency tracer running on 
> > 2.6.16-rc6-git4 and 2.6.15 x86_64 SMP kernel with maxcpus=1 and 
> > report_lost_ticks. [...]
> 
> just for the record, the latency tracer can be found at:
> 
>    http://redhat.com/~mingo/latency-tracing-patches/
> 
> latency-tracing-v2.6.16.patch would be the one for current upstream 
> kernels. The codebase is the same as in the -rt tree.

Ingo, I had to add this incremental patch against 2.6.16-rc6-git4 in order to
get the 2.6.15-rc7 latency tracer working on x86_64.  Looks like the
problem is still there in latency-tracing-v2.6.16.patch.

Regards,

	Bill


--- linux-2.6.16-rc6-git4-latency/include/asm-x86_64/system.h	2006-03-15 17:19:20.000000000 -0500
+++ linux-2.6.16-rc6-git4-latency/include/asm-x86_64/system.h	2006-03-15 13:45:14.000000000 -0500
@@ -341,10 +341,8 @@
 #define local_irq_disable()	do { unsigned long flags; local_save_flags(flags); local_irq_restore((flags & ~(1 << 9)) | (1 << 18)); } while (0)
 #define local_irq_enable()	do { unsigned long flags; local_save_flags(flags); local_irq_restore((flags | (1 << 9)) & ~(1 << 18)); } while (0)
 
-#define irqs_disabled()					\
+#define irqs_disabled_flags(flags)			\
 ({							\
-	unsigned long flags;				\
-	local_save_flags(flags);			\
 	(flags & (1<<18)) || !(flags & (1<<9));		\
 })
 
@@ -354,10 +352,8 @@
 #define local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
 #define local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
 
-#define irqs_disabled()			\
+#define irqs_disabled_flags(flags)	\
 ({					\
-	unsigned long flags;		\
-	local_save_flags(flags);	\
 	!(flags & (1<<9));		\
 })
 
@@ -365,6 +361,13 @@
 #define local_irq_save(x) 	do { warn_if_not_ulong(x); __asm__ __volatile__("# local_irq_save \n\t pushfq ; popq %0 ; cli":"=g" (x): /* no input */ :"memory"); } while (0)
 #endif
 
+#define irqs_disabled()			\
+({					\
+	unsigned long flags;		\
+	local_save_flags(flags);	\
+	irqs_disabled_flags(flags);	\
+})
+
 /* used in the idle loop; sti takes one instruction cycle to complete */
 #define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
 /* used when interrupts are already enabled or to shutdown the processor */
--- linux-2.6.16-rc6-git4-latency/include/asm-x86_64/unistd.h	2006-03-15 17:19:20.000000000 -0500
+++ linux-2.6.16-rc6-git4-latency/include/asm-x86_64/unistd.h	2006-03-15 13:47:32.000000000 -0500
@@ -607,6 +607,7 @@
 __SYSCALL(__NR_unshare,	sys_unshare)
 
 #define __NR_syscall_max __NR_unshare
+#define NR_syscalls (__NR_syscall_max+1)
 
 #ifndef __NO_STUBS
 
