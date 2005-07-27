Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVG0U3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVG0U3v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVG0U2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:28:04 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:32578 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262164AbVG0U07 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:26:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sfYXK9Xratf2ld+5EtCLFyYXLZlKYsDwHKSWlihfnmdBlE+OR4QrDGyPq+gk+Bo9NDCXREqRY2hZ9u2Zgq5663PP6og9iwElwnOKOL7np8gsHpxQNVBGXNGfO3uy+HCEI98uE5VErktyR/x+A7ClzGPtMgo7R9p1ZX2L3tr6cv4=
Message-ID: <86802c440507271326f7d1729@mail.gmail.com>
Date: Wed, 27 Jul 2005 13:26:59 -0700
From: yhlu <yhlu.kernel@gmail.com>
Reply-To: yhlu <yhlu.kernel@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: x86-64 timing patch after 2.6.12-rc5 with 2 cpu above system
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

I verify the timing problem could happen with any x86-64 system with
more than 2 cpus. ( 2 way dual core, or four way single core).

please refer the patch, it will move cpu_set(, cpu_callin_map) from
smi_callin to start_secondary.

--- /home/yhlu/xx1/linux-2.6.13-rc2/arch/x86_64/kernel/smpboot.c.orig
2005-07-06 18:41:16.789767168 -0700
+++ /home/yhlu/xx1/linux-2.6.13-rc2/arch/x86_64/kernel/smpboot.c
2005-07-06 18:45:11.923021480 -0700
@@ -442,7 +442,7 @@
        /*
         * Allow the master to continue.
         */
- cpu_set(cpuid, cpu_callin_map);
+// cpu_set(cpuid, cpu_callin_map); // moved to start_secondary by yhlu
 }

 static inline void set_cpu_sibling_map(int cpu)
@@ -529,8 +529,11 @@
        /* Wait for TSC sync to not schedule things before.
           We still process interrupts, which could see an inconsistent
           time in that window unfortunately. */
+
        tsc_sync_wait();

+ cpu_set(smp_processor_id(), cpu_callin_map); // moved from smp_callin by yhlu
+
        cpu_idle();
 }

the other solution will be change cpu_callin_map to cpu_online_map in
do_boot_cpu

                /*
                 * allow APs to start initializing.
                 */
                Dprintk("Before Callout %d.\n", cpu);
                cpu_set(cpu, cpu_callout_map);
                Dprintk("After Callout %d.\n", cpu);

                /*
                 * Wait 5s total for a response
                 */
                for (timeout = 0; timeout < 50000; timeout++) {
                        if (cpu_isset(cpu, cpu_callin_map))
--------------------------> cpu_online_map
                                break; /* It has booted */
                        udelay(100);
                }

                if (cpu_isset(cpu, cpu_callin_map)) {
--------------------------------> cpu_online_map
                        /* number CPUs logically, starting from 1 (BSP is 0)
*/
                        Dprintk("CPU has booted.\n");
                } else {
                        boot_error = 1;
                        if (*((volatile unsigned char
*)phys_to_virt(SMP_TRAMPOLINE_BASE))
                                        == 0xA5)
                                /* trampoline started but...? */
                                printk("Stuck ??\n");
                        else
                                /* trampoline code not run */
                                printk("Not responding.\n");
#if APIC_DEBUG
                        inquire_remote_apic(apicid);
#endif
                }

the result will be

Booting processor 1/1 rip 6000 rsp ffff81013ff89f58
Initializing CPU#1
masked ExtINT on CPU#1
Calibrating delay using timer specific routine.. 4422.98 BogoMIPS
(lpj=8845965)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
 stepping 00
CPU 1: Syncing TSC to CPU 0.
sync_master: 1 smp_processor_id() = 00, boot_cpu_id= 00
sync_master: 2 smp_processor_id() = 00, boot_cpu_id= 00
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 595 cycles)
---------------------> it is in right place.
Booting processor 2/2 rip 6000 rsp ffff81023ff1df58
Initializing CPU#2
masked ExtINT on CPU#2
Calibrating delay using timer specific routine.. 4422.99 BogoMIPS
(lpj=8845997)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2(2) -> Node 1 -> Core 0
 stepping 00
CPU 2: Syncing TSC to CPU 0.
sync_master: 1 smp_processor_id() = 00, boot_cpu_id= 00
sync_master: 1 smp_processor_id() = 01, boot_cpu_id= 00
sync_master: 2 smp_processor_id() = 00, boot_cpu_id= 00
CPU 2: synchronized TSC with CPU 0 (last diff -4 cycles, maxerr 1097 cycles)
Booting processor 3/3 rip 6000 rsp ffff81013ff53f58
Initializing CPU#3
masked ExtINT on CPU#3
Calibrating delay using timer specific routine.. 4423.03 BogoMIPS
(lpj=8846075)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3(2) -> Node 1 -> Core 1
 stepping 00
CPU 3: Syncing TSC to CPU 0.
sync_master: 1 smp_processor_id() = 00, boot_cpu_id= 00
sync_master: 1 smp_processor_id() = 01, boot_cpu_id= 00
sync_master: 1 smp_processor_id() = 02, boot_cpu_id= 00
sync_master: 2 smp_processor_id() = 00, boot_cpu_id= 00
CPU 3: synchronized TSC with CPU 0 (last diff -4 cycles, maxerr 1097 cycles)
Brought up 4 CPUs

> -----Original Message-----
> From: YhLu
> Sent: Wednesday, July 06, 2005 3:25 PM
> To: Andi Kleen
> Cc: Peter Buckingham; linux-kernel_at_vger.kernel.org
> Subject: 2.6.13-rc2 with dual way dual core ck804 MB
>
> andi,
>
> the core1/node0 take a long while to get TSC synchronized. Is
> it normal?
> i guess
> "CPU 1: synchronized TSC with CPU 0" should be just after
> "CPU 1: Syncing TSC to CPU0"
>
> YH
>
>
> cpu 1: setting up apic clock
> cpu 1: enabling apic timer
> CPU 1: Syncing TSC to CPU 0.
> CPU has booted.
> waiting for cpu 1
>
> cpu 2: setting up apic clock
> cpu 2: enabling apic timer
> CPU 2: Syncing TSC to CPU 0.
> CPU 2: synchronized TSC with CPU 0 (last diff -4 cycles,
> maxerr 1097 cycles) CPU has booted.
> waiting for cpu 2
>
> cpu 3: setting up apic clock
> cpu 3: enabling apic timer
> CPU 3: Syncing TSC to CPU 0.
> CPU 3: synchronized TSC with CPU 0 (last diff 1 cycles,
> maxerr 1087 cycles) CPU has booted.
> waiting for cpu 3
>
> testing NMI watchdog ... CPU#1: NMI appears to be stuck (1->1)!
> checking if image is initramfs...<6>CPU 1: synchronized TSC
> with CPU 0 (last diff 0 cycles, maxerr 595 cycles) it isn't
> (no cpio magic); looks like an initrd
>
>
> the
