Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVGGAxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVGGAxu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVGGAxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 20:53:46 -0400
Received: from mail.tyan.com ([66.122.195.4]:23558 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262423AbVGGAvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 20:51:31 -0400
Message-ID: <3174569B9743D511922F00A0C94314230AF97867@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@suse.de>
Cc: Peter Buckingham <peter@pantasys.com>, linux-kernel@vger.kernel.org,
       "'discuss@x86-64.org'" <discuss@x86-64.org>
Subject: RE: 2.6.13-rc2 with dual way dual core ck804 MB
Date: Wed, 6 Jul 2005 17:56:17 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andi,

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
-       cpu_set(cpuid, cpu_callin_map);
+//     cpu_set(cpuid, cpu_callin_map); // moved to start_secondary by yhlu
 }

 static inline void set_cpu_sibling_map(int cpu)
@@ -529,8 +529,11 @@
        /* Wait for TSC sync to not schedule things before.
           We still process interrupts, which could see an inconsistent
           time in that window unfortunately. */
+
        tsc_sync_wait();

+       cpu_set(smp_processor_id(), cpu_callin_map); // moved from
smp_callin by yhlu
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
                                break;  /* It has booted */
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
> Cc: Peter Buckingham; linux-kernel@vger.kernel.org
> Subject: 2.6.13-rc2 with dual way dual core ck804 MB
> 
> andi,
> 
> the core1/node0 take a long while to get TSC synchronized. Is 
> it normal?
> i guess
> "CPU 1: synchronized TSC with CPU 0"  should be just after 
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
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
