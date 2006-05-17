Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWEQE5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWEQE5T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 00:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWEQE5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 00:57:19 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:64197 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751271AbWEQE5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 00:57:19 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Drew Moseley <dmoseley@mvista.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unnecessary warnings in smp_send_stop on i386 arch. 
In-reply-to: Your message of "Tue, 16 May 2006 19:43:05 MST."
             <200605161943.06024.dmoseley@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Date: Wed, 17 May 2006 14:56:06 +1000
Message-ID: <17725.1147841766@ocs3>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drew Moseley (on Tue, 16 May 2006 19:43:05 -0700) wrote:
>I noticed a scenario where an i386 kernel would print warning messages
>about smp_send_stop() being called with interrupts off.  This can happen
>both from panic() and from machine_restart in arch/i386/kernel/reboot.c
>if called from an interrupt handler.  To reproduce I added a sysrq handler
>that simply called panic().
>
>I noticed that the same behavior did not occur on the x86_64 architecture.
>In investigating the differences between the architectures, I found the
>patch with commit ID e6e7c2a9222016f41613d2389d230b03a36c9f20 during the
>2.6.12-rc2 timeframe which addressed this issue for the x86_64 architecture.
>
>I modified the i386/kernel/smp.c file to be functionally equivalent to the
>x86_64/kernel/smp.c file to address this issue.
>
>Comments?
>
>Drew
>
>
>
>
>
>
>Signed-off-by: Drew Moseley <dmoseley@mvista.com>
>Description:
>    Make arch/i386/kernel/smp.c functionally equivalent to 
>arch/x86_64/kernel/smp.c
>    This allows for the case of calling smp_send_stop when interrupts are 
>disabled
>    in a few isolated cases.
>
>Index: linux-2.6.10/arch/i386/kernel/smp.c
>===================================================================
>--- linux-2.6.10.orig/arch/i386/kernel/smp.c
>+++ linux-2.6.10/arch/i386/kernel/smp.c
>@@ -560,30 +560,14 @@ void dump_send_ipi(void)
>  * this function sends a 'generic call function' IPI to all other CPUs
>  * in the system.
>  */
>-
>-int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
>-                       int wait)
>-/*
>- * [SUMMARY] Run a function on all other CPUs.
>- * <func> The function to run. This must be fast and non-blocking.
>- * <info> An arbitrary pointer to pass to the function.
>- * <nonatomic> currently unused.
>- * <wait> If true, wait (atomically) until function has completed on other 
>CPUs.
>- * [RETURNS] 0 on success, else a negative status code. Does not return until
>- * remote CPUs are nearly ready to execute <<func>> or are or have executed.
>- *
>- * You must not call this function with disabled interrupts or from a
>- * hardware interrupt handler or from a bottom half handler.
>- */
>+static void __smp_call_function (void (*func) (void *info), void *info,
>+                               int nonatomic, int wait)
> {
>        struct call_data_struct data;
>        int cpus = num_online_cpus()-1;
> 
>        if (!cpus)
>-               return 0;
>-
>-       /* Can deadlock when called with interrupts disabled */
>-       WARN_ON(irqs_disabled());
>+               return;
> 
>        data.func = func;
>        data.info = info;
>@@ -592,7 +576,6 @@ int smp_call_function (void (*func) (voi
>        if (wait)
>                atomic_set(&data.finished, 0);
> 
>-       spin_lock(&call_lock);
>        call_data = &data;
>        mb();
>        
>@@ -603,11 +586,32 @@ int smp_call_function (void (*func) (voi
>        while (atomic_read(&data.started) != cpus)
>                cpu_relax();
> 
>-       if (wait)
>-               while (atomic_read(&data.finished) != cpus)
>-                       cpu_relax();
>-       spin_unlock(&call_lock);
>+       if (!wait)
>+               return;
>+
>+       while (atomic_read(&data.finished) != cpus)
>+               cpu_relax();
>+}
> 
>+/*
>+ * [SUMMARY] Run a function on all other CPUs.
>+ * <func> The function to run. This must be fast and non-blocking.
>+ * <info> An arbitrary pointer to pass to the function.
>+ * <nonatomic> currently unused.
>+ * <wait> If true, wait (atomically) until function has completed on other 
>CPUs.
>+ * [RETURNS] 0 on success, else a negative status code. Does not return until
>+ * remote CPUs are nearly ready to execute <<func>> or are or have executed.
>+ *
>+ * You must not call this function with disabled interrupts or from a
>+ * hardware interrupt handler or from a bottom half handler.
>+ * Actually there are a few legal cases, like panic.
>+ */
>+int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
>+                       int wait)
>+{
>+       spin_lock(&call_lock);
>+       __smp_call_function(func,info,nonatomic,wait);
>+       spin_unlock(&call_lock);
>        return 0;
> }
> 
>@@ -630,7 +634,15 @@ void stop_this_cpu (void * dummy)
> 
> void smp_send_stop(void)
> {
>-       smp_call_function(stop_this_cpu, NULL, 1, 0);
>+       int nolock = 0;
>+       /* Don't deadlock on the call lock in panic */
>+       if (!spin_trylock(&call_lock)) {
>+               /* ignore locking because we have paniced anyways */
>+               nolock = 1;
>+       }
>+       __smp_call_function(stop_this_cpu, NULL, 0, 0);
>+       if (!nolock)
>+               spin_unlock(&call_lock);
> 
>        local_irq_disable();
>        disable_local_APIC();

NAK this patch.  There is a real potential deadlock if you call
smp_call_function() with interrupts disabled, it has caused kernel
hangs in the past.  This patch removes the check for the potential
deadlock and will allow bad code to creep back into the kernel.  See
http://lkml.org/lkml/2004/5/2/116.  I find it quite disturbing that
x86_64 has removed that check :(

