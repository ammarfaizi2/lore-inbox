Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbVBCIis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbVBCIis (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 03:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbVBCIiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 03:38:09 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:5504 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S262742AbVBCIhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 03:37:04 -0500
Date: Thu, 03 Feb 2005 17:37:06 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: kdump on non-boot cpu
Cc: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1107412952.11609.174.camel@2fwv946.in.ibm.com>
References: <20050203140438.18E1.ODA@valinux.co.jp> <1107412952.11609.174.camel@2fwv946.in.ibm.com>
Message-Id: <20050203171700.18E7.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is not for kdump but an experience of our project(mkdump).
The dump kernel(not SMP config) boot hangs if machine_kexec()
excutes on non-boot CPU on x86_64 platform.
We don't found why. (Please let me know if you know why.)
but fix that the boot-cpu excutes machine_kexec() in the nmi handler. 
(It becomes OK after that)

See attached patch (this is only for explanation). (this is for
arch/i386/kernel/crash.c in the 2.6.11-rc2-mm1)

> Do you see a problem in the code flow somewhere?

I point some concerns in the attached patch too. (not related above)

Thanks.

On 03 Feb 2005 12:12:32 +0530
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> On Thu, 2005-02-03 at 10:42, Itsuro Oda wrote:
> > Hi,
> > 
> > I found the following in an old mail:
> > 
> > >From vgoyal at in.ibm.com  Thu Jan  6 07:20:43 2005
> > ...
> > >2. Kdump can possibly fail on SMP machines if crash occurs on non-boot
> > >cpu. Hari is finalizing the stop gap patch to handle this problem.
> > 
> > Is this finished ?  (It seems it is not in 2.6.11-rc2-mm1.)
> 
> Not yet. For the time being focus got shifted to other kdump issues. I
> am not even sure if this is a problem. See below a clip from discussions
> on fastboot.
> 
> > Hi Eric,
> > > 
> > > I had a quick look at kexec3. Had some queries.
> > > 
> > > 1. Code for relocating to boot cpu or enabling boot from non-boot cpu is
> > > required.
> > 
> > Actually I just looked and it appears this snippet from smp_boot_cpus
> > already handles that case.
> > 
> >         boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
> >         boot_cpu_logical_apicid = logical_smp_processor_id();
> >         x86_cpu_to_apicid[0] = boot_cpu_physical_apicid;
> > 
> > While looking I certainly did not see anything still in the
> > kernel that would complain if we get this wrong.
> > 
> > Although I  am not really comfortable with a capture kernel using
> > multiprocessors. 
> > 
> > Eric
> 
> 
> Do you see a problem in the code flow somewhere?
> 
> Vivek

-- 
Itsuro ODA <oda@valinux.co.jp>

---
--- crash.c     2005-01-28 23:53:30.000000000 +0900
+++ crash.c.new 2005-02-04 00:49:12.599084080 +0900
@@ -111,6 +111,26 @@

 #ifdef CONFIG_SMP
 static atomic_t waiting_for_crash_ipi;
+static int reboot_cpu = 0;
+
+static void wait_and_reboot(void)
+{
+       unsigned long msecs;
+
+       msecs = 1000; /* Wait at most a second for the other cpus to stop */
+       while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
+               mdelay(1);
+               msecs--;
+       }
+#if defined(CONFIG_X86_IO_APIC)
+       /* XXX: it is necessary... to avoid deadlock
+            - export "spinlock_t ioapic_lock"
+            - call spin_lock_init(&ioapic_lock) here
+         */
+       disable_IO_APIC();
+#endif
+       machine_kexec(...); /* XXX: needs image */
+}

 static int crash_nmi_callback(struct pt_regs *regs, int cpu)
 {
@@ -118,9 +138,13 @@
        crash_save_this_cpu(regs, cpu);
        disable_local_APIC();
        atomic_dec(&waiting_for_crash_ipi);
-       /* Assume hlt works */
-       __asm__("hlt");
-       for(;;);
+
+       if (cpu == reboot_cpu) {
+               wait_and_reboot();
+       } else {
+               __asm__("hlt");
+               for(;;);
+       }
        return 1;
 }

@@ -136,7 +160,6 @@

 static void nmi_shootdown_cpus(void)
 {
-       unsigned long msecs;
        atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);

        /* Would it be better to replace the trap vector here? */
@@ -148,19 +171,15 @@

        smp_send_nmi_allbutself();

-       msecs = 1000; /* Wait at most a second for the other cpus to stop */
-       while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
-               mdelay(1);
-               msecs--;
-       }
-
-       /* Leave the nmi callback set */
+       crash_save_self();
        disable_local_APIC();
-}
-#else
-static void nmi_shootdown_cpus(void)
-{
-       /* There are no cpus to shootdown */
+
+       if (smp_processor_id() == reboot_cpu) {
+               wait_and_reboot();
+       } else {
+               __asm__("hlt");
+               for(;;);
+       }
 }
 #endif

@@ -176,10 +195,13 @@
         */
        /* The kernel is broken so disable interrupts */
        local_irq_disable();
+#ifdef CONFIG_SMP
        nmi_shootdown_cpus();
-       lapic_shutdown();
+#else
+       lapic_shutdown();       /* XXX: this calls local_irq_enable. is it OK ? */
 #if defined(CONFIG_X86_IO_APIC)
        disable_IO_APIC();
 #endif
        crash_save_self();
+#endif
 }
---
