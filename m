Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285393AbRLGDk5>; Thu, 6 Dec 2001 22:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285400AbRLGDkv>; Thu, 6 Dec 2001 22:40:51 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:12050 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285393AbRLGDkd>; Thu, 6 Dec 2001 22:40:33 -0500
Message-ID: <3C103A1E.2524A7B7@zip.com.au>
Date: Thu, 06 Dec 2001 19:40:14 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: j-nomura@ce.jp.nec.com
CC: linux-kernel@vger.kernel.org, David Mosberger <davidm@hpl.hp.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processorinitializationcheck)
In-Reply-To: <3C0C2AAF.6141D797@zip.com.au>,
		<3C0B43DC.7A8F582A@zip.com.au>
		<20011203193235S.nomura@hpc.bs1.fc.nec.co.jp>
		<3C0C2AAF.6141D797@zip.com.au> <20011206140102Z.nomura@hpc.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

j-nomura@ce.jp.nec.com wrote:
> 
> Hi,
> excuse me for not prompt response. I've been off-line for 2 days.
> 
> > > The reason I put it in release_console_sem() is that release_console_sem()
> > > can be called from other functions than printk(), e.g. console_unblank().
> > > I agree with you that it is clearer but I think it is not sufficient.
> >
> > I really doubt if any of those paths could be called before
> > even the MMU is set up.
> 

Marcelo,

after a fairly lengthy off-list discussion, it turns out that
special-casing printk is probably the best way to proceed
to fix this one.

The problem is that the boot processor sets up the console drivers,
and is able to call them via printk(), but the application processors
at that time are not able to call printk() because the console device
driver mappings are not set up.  Undoing this inside the ia64 boot code is
complex and fragile.   Possibly the problem exists on other platforms
but hasn't been discovered yet.

So the patch defines an architecture-specific macro `arch_consoles_callable()'
which, if not defined, defaults to `1', so the impact to other platforms
(and to uniprocessor ia64) is zero.



--- linux-2.4.17-pre4/include/asm-ia64/system.h	Thu Nov 22 23:02:59 2001
+++ linux-akpm/include/asm-ia64/system.h	Wed Dec  5 23:09:15 2001
@@ -405,6 +405,10 @@ extern void ia64_load_extra (struct task
 	ia64_psr(ia64_task_regs(prev))->dfh = 1;				\
 	__switch_to(prev,next,last);						\
   } while (0)
+
+/* Return true if this CPU can call the console drivers in printk() */
+#define arch_consoles_callable() (cpu_online_map & (1UL << smp_processor_id()))
+
 #else
 # define switch_to(prev,next,last) do {						\
 	ia64_psr(ia64_task_regs(next))->dfh = (ia64_get_fpu_owner() != (next));	\
--- linux-2.4.17-pre4/kernel/printk.c	Thu Nov 22 23:02:59 2001
+++ linux-akpm/kernel/printk.c	Wed Dec  5 23:03:54 2001
@@ -38,6 +38,10 @@
 
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)
 
+#ifndef arch_consoles_callable
+#define arch_consoles_callable() (1)
+#endif
+
 /* printk's without a loglevel use this.. */
 #define DEFAULT_MESSAGE_LOGLEVEL 4 /* KERN_WARNING */
 
@@ -438,6 +442,14 @@ asmlinkage int printk(const char *fmt, .
 			log_level_unknown = 1;
 	}
 
+	if (!arch_consoles_callable()) {
+		/*
+		 * On some architectures, the consoles are not usable
+		 * on secondary CPUs early in the boot process.
+		 */
+		spin_unlock_irqrestore(&logbuf_lock, flags);
+		goto out;
+	}
 	if (!down_trylock(&console_sem)) {
 		/*
 		 * We own the drivers.  We can drop the spinlock and let
@@ -454,6 +466,7 @@ asmlinkage int printk(const char *fmt, .
 		 */
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 	}
+out:
 	return printed_len;
 }
 EXPORT_SYMBOL(printk);
