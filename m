Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVGGRro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVGGRro (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVGGRrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:47:43 -0400
Received: from mail.tyan.com ([66.122.195.4]:49933 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261321AbVGGRqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:46:17 -0400
Message-ID: <3174569B9743D511922F00A0C94314230AF978B4@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@suse.de>
Cc: Peter Buckingham <peter@pantasys.com>, linux-kernel@vger.kernel.org,
       "'discuss@x86-64.org'" <discuss@x86-64.org>
Subject: RE: 2.6.13-rc2 with dual way dual core ck804 MB
Date: Thu, 7 Jul 2005 10:50:59 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C5831C.6F2473B0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C5831C.6F2473B0
Content-Type: text/plain

Andi,

Can you look at the patch? It could solve the timing problem.

I also move your ext_apic_id patch into 2.6.13 manaully. 

YH

> -----Original Message-----
> From: YhLu 
> Sent: Wednesday, July 06, 2005 5:51 PM
> To: Andi Kleen
> Cc: 'Peter Buckingham'; linux-kernel@vger.kernel.org; 
> 'discuss@x86-64.org'
> Subject: RE: 2.6.13-rc2 with dual way dual core ck804 MB
> 
> andi,
> 
> please refer the patch, it will move cpu_set(, 
> cpu_callin_map) from smi_callin to start_secondary.
> 
> --- 
> /home/yhlu/xx1/linux-2.6.13-rc2/arch/x86_64/kernel/smpboot.c.o
> rig   2005-07-06 18:41:16.789767168 -0700
> +++ 
> /home/yhlu/xx1/linux-2.6.13-rc2/arch/x86_64/kernel/smpboot.c  
>       2005-07-06 18:45:11.923021480 -0700
> @@ -442,7 +442,7 @@
>         /*
>          * Allow the master to continue.
>          */
> -       cpu_set(cpuid, cpu_callin_map);
> +//     cpu_set(cpuid, cpu_callin_map); // moved to 
> start_secondary by yhlu
>  }
> 
>  static inline void set_cpu_sibling_map(int cpu) @@ -529,8 +529,11 @@
>         /* Wait for TSC sync to not schedule things before.
>            We still process interrupts, which could see an 
> inconsistent
>            time in that window unfortunately. */
> +
>         tsc_sync_wait();
> 
> +       cpu_set(smp_processor_id(), cpu_callin_map); // moved from 
> + smp_callin by yhlu
> +
>         cpu_idle();
>  }
> 
> the other solution will be change cpu_callin_map to 
> cpu_online_map in do_boot_cpu
> 
>                 /*
>                  * allow APs to start initializing.
>                  */
>                 Dprintk("Before Callout %d.\n", cpu);
>                 cpu_set(cpu, cpu_callout_map);
>                 Dprintk("After Callout %d.\n", cpu);
> 
>                 /*
>                  * Wait 5s total for a response
>                  */
>                 for (timeout = 0; timeout < 50000; timeout++) {
>                         if (cpu_isset(cpu, cpu_callin_map)) 
> --------------------------> cpu_online_map
>                                 break;  /* It has booted */
>                         udelay(100);
>                 }
> 
>                 if (cpu_isset(cpu, cpu_callin_map)) { 
> --------------------------------> cpu_online_map
>                         /* number CPUs logically, starting 
> from 1 (BSP is 0) */
>                         Dprintk("CPU has booted.\n");
>                 } else {
>                         boot_error = 1;
>                         if (*((volatile unsigned char 
> *)phys_to_virt(SMP_TRAMPOLINE_BASE))
>                                         == 0xA5)
>                                 /* trampoline started but...? */
>                                 printk("Stuck ??\n");
>                         else
>                                 /* trampoline code not run */
>                                 printk("Not responding.\n"); 
> #if APIC_DEBUG
>                         inquire_remote_apic(apicid); #endif
>                 }
> 
> 
> the result will be
> 
> Booting processor 1/1 rip 6000 rsp ffff81013ff89f58 
> Initializing CPU#1 masked ExtINT on CPU#1 Calibrating delay 
> using timer specific routine.. 4422.98 BogoMIPS (lpj=8845965)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 1(2) -> Node 0 -> Core 1
>  stepping 00
> CPU 1: Syncing TSC to CPU 0.
> sync_master: 1 smp_processor_id() = 00, boot_cpu_id= 00
> sync_master: 2 smp_processor_id() = 00, boot_cpu_id= 00 CPU 
> 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 
> 595 cycles) ---------------------> it is in right place.
> Booting processor 2/2 rip 6000 rsp ffff81023ff1df58 
> Initializing CPU#2 masked ExtINT on CPU#2 Calibrating delay 
> using timer specific routine.. 4422.99 BogoMIPS (lpj=8845997)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 2(2) -> Node 1 -> Core 0
>  stepping 00
> CPU 2: Syncing TSC to CPU 0.
> sync_master: 1 smp_processor_id() = 00, boot_cpu_id= 00
> sync_master: 1 smp_processor_id() = 01, boot_cpu_id= 00
> sync_master: 2 smp_processor_id() = 00, boot_cpu_id= 00 CPU 
> 2: synchronized TSC with CPU 0 (last diff -4 cycles, maxerr 
> 1097 cycles) Booting processor 3/3 rip 6000 rsp 
> ffff81013ff53f58 Initializing CPU#3 masked ExtINT on CPU#3 
> Calibrating delay using timer specific routine.. 4423.03 
> BogoMIPS (lpj=8846075)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 3(2) -> Node 1 -> Core 1
>  stepping 00
> CPU 3: Syncing TSC to CPU 0.
> sync_master: 1 smp_processor_id() = 00, boot_cpu_id= 00
> sync_master: 1 smp_processor_id() = 01, boot_cpu_id= 00
> sync_master: 1 smp_processor_id() = 02, boot_cpu_id= 00
> sync_master: 2 smp_processor_id() = 00, boot_cpu_id= 00 CPU 
> 3: synchronized TSC with CPU 0 (last diff -4 cycles, maxerr 
> 1097 cycles) Brought up 4 CPUs
> 
> 
> > -----Original Message-----
> > From: YhLu
> > Sent: Wednesday, July 06, 2005 3:25 PM
> > To: Andi Kleen
> > Cc: Peter Buckingham; linux-kernel@vger.kernel.org
> > Subject: 2.6.13-rc2 with dual way dual core ck804 MB
> > 
> > andi,
> > 
> > the core1/node0 take a long while to get TSC synchronized. Is it 
> > normal?
> > i guess
> > "CPU 1: synchronized TSC with CPU 0"  should be just after "CPU 1: 
> > Syncing TSC to CPU0"
> > 
> > YH
> > 
> > 
> > cpu 1: setting up apic clock
> > cpu 1: enabling apic timer
> > CPU 1: Syncing TSC to CPU 0.
> > CPU has booted.
> > waiting for cpu 1
> > 
> > cpu 2: setting up apic clock
> > cpu 2: enabling apic timer
> > CPU 2: Syncing TSC to CPU 0.
> > CPU 2: synchronized TSC with CPU 0 (last diff -4 cycles, 
> maxerr 1097 
> > cycles) CPU has booted.
> > waiting for cpu 2
> > 
> > cpu 3: setting up apic clock
> > cpu 3: enabling apic timer
> > CPU 3: Syncing TSC to CPU 0.
> > CPU 3: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 1087 
> > cycles) CPU has booted.
> > waiting for cpu 3
> > 
> > testing NMI watchdog ... CPU#1: NMI appears to be stuck (1->1)!
> > checking if image is initramfs...<6>CPU 1: synchronized TSC 
> with CPU 0 
> > (last diff 0 cycles, maxerr 595 cycles) it isn't (no cpio magic); 
> > looks like an initrd
> > 
> > 
> > the
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in the body of a message to majordomo@vger.kernel.org 
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 


------_=_NextPart_000_01C5831C.6F2473B0
Content-Type: application/octet-stream;
	name="2.6.13.rc2_ext_apic_id_dual_core_timing.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="2.6.13.rc2_ext_apic_id_dual_core_timing.patch"

diff -uNr =
/home/yhlu/xx1/linux-2.6.13-rc2.orig/arch/x86_64/kernel/genapic.c =
/home/yhlu/xx1/linux-2.6.13-rc2/arch/x86_64/kernel/genapic.c=0A=
--- /home/yhlu/xx1/linux-2.6.13-rc2.orig/arch/x86_64/kernel/genapic.c	=
2005-07-05 20:46:33.000000000 -0700=0A=
+++ /home/yhlu/xx1/linux-2.6.13-rc2/arch/x86_64/kernel/genapic.c	=
2005-07-06 15:37:52.932607728 -0700=0A=
@@ -31,25 +31,20 @@=0A=
 =0A=
 extern struct genapic apic_cluster;=0A=
 extern struct genapic apic_flat;=0A=
+extern struct genapic apic_physflat;=0A=
 =0A=
 struct genapic *genapic =3D &apic_flat;=0A=
 =0A=
-=0A=
 /*=0A=
  * Check the APIC IDs in bios_cpu_apicid and choose the APIC mode.=0A=
  */=0A=
-void __init clustered_apic_check(void)=0A=
+void __init extended_apic_check(void)=0A=
 {=0A=
 	long i;=0A=
 	u8 clusters, max_cluster;=0A=
 	u8 id;=0A=
 	u8 cluster_cnt[NUM_APIC_CLUSTERS];=0A=
-=0A=
-	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD) {=0A=
-		/* AMD always uses flat mode right now */=0A=
-		genapic =3D &apic_flat;=0A=
-		goto print;=0A=
-	}=0A=
+	int num_cpus =3D 0;=0A=
 =0A=
 #if defined(CONFIG_ACPI_BUS)=0A=
 	/*=0A=
@@ -65,10 +60,19 @@=0A=
 =0A=
 	memset(cluster_cnt, 0, sizeof(cluster_cnt));=0A=
 =0A=
+        /* Count how many CPUs the BIOS told us about, but not=0A=
+          more than what the user specified */=0A=
 	for (i =3D 0; i < NR_CPUS; i++) {=0A=
 		id =3D bios_cpu_apicid[i];=0A=
-		if (id !=3D BAD_APICID)=0A=
-			cluster_cnt[APIC_CLUSTERID(id)]++;=0A=
+		if (id =3D=3D BAD_APICID)=0A=
+			continue;=0A=
+		cluster_cnt[APIC_CLUSTERID(id)]++;=0A=
+		num_cpus++;=0A=
+	}=0A=
+=0A=
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD) {=0A=
+		genapic =3D num_cpus > 8 ? &apic_physflat : &apic_flat;=0A=
+		goto print;=0A=
 	}=0A=
 =0A=
 	clusters =3D 0;=0A=
diff -uNr =
/home/yhlu/xx1/linux-2.6.13-rc2.orig/arch/x86_64/kernel/genapic_flat.c =
/home/yhlu/xx1/linux-2.6.13-rc2/arch/x86_64/kernel/genapic_flat.c=0A=
--- =
/home/yhlu/xx1/linux-2.6.13-rc2.orig/arch/x86_64/kernel/genapic_flat.c	=
2005-07-05 20:46:33.000000000 -0700=0A=
+++ /home/yhlu/xx1/linux-2.6.13-rc2/arch/x86_64/kernel/genapic_flat.c	=
2005-07-06 15:41:04.414498056 -0700=0A=
@@ -2,7 +2,7 @@=0A=
  * Copyright 2004 James Cleverdon, IBM.=0A=
  * Subject to the GNU Public License, v.2=0A=
  *=0A=
- * Flat APIC subarch code.  Maximum 8 CPUs, logical delivery.=0A=
+ * Flat APIC subarch code.  Logical delivery.=0A=
  *=0A=
  * Hacked for x86-64 by James Cleverdon from i386 architecture code =
by=0A=
  * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and=0A=
@@ -195,6 +195,53 @@=0A=
 	.phys_pkg_id =3D phys_pkg_id,=0A=
 };=0A=
 =0A=
+=0A=
+/* =0A=
+ * Physflat mode is used when there are more than 8 CPUs on a AMD =
system.=0A=
+ * We cannot use logical delivery in this case because the mask=0A=
+ * overflows, so use physical mode.=0A=
+ */=0A=
+=0A=
+static cpumask_t physflat_target_cpus(void)=0A=
+{=0A=
+       return cpumask_of_cpu(0);=0A=
+}=0A=
+=0A=
+static void physflat_send_IPI_mask(cpumask_t cpumask, int vector)=0A=
+{=0A=
+       send_IPI_mask_sequence(cpumask, vector);=0A=
+}=0A=
+=0A=
+static unsigned int physflat_cpu_mask_to_apicid(cpumask_t cpumask)=0A=
+{=0A=
+       int cpu;=0A=
+=0A=
+       /*=0A=
+        * We're using fixed IRQ delivery, can only return one phys =
APIC ID.=0A=
+        * May as well be the first.=0A=
+        */=0A=
+       cpu =3D first_cpu(cpumask);=0A=
+       if ((unsigned)cpu < NR_CPUS)=0A=
+               return x86_cpu_to_apicid[cpu];=0A=
+       else=0A=
+               return BAD_APICID;=0A=
+}=0A=
+=0A=
+struct genapic apic_physflat =3D  {=0A=
+       .name =3D "physical flat",=0A=
+       .int_delivery_mode =3D dest_LowestPrio,=0A=
+       .int_dest_mode =3D (APIC_DEST_PHYSICAL !=3D 0),=0A=
+       .int_delivery_dest =3D APIC_DEST_PHYSICAL | APIC_DM_LOWEST,=0A=
+       .target_cpus =3D physflat_target_cpus,=0A=
+       .apic_id_registered =3D flat_apic_id_registered,=0A=
+       .init_apic_ldr =3D flat_init_apic_ldr,/*not needed, but =
shouldn't hurt*/=0A=
+       .send_IPI_all =3D flat_send_IPI_all,=0A=
+       .send_IPI_allbutself =3D flat_send_IPI_allbutself,=0A=
+       .send_IPI_mask =3D physflat_send_IPI_mask,=0A=
+       .cpu_mask_to_apicid =3D physflat_cpu_mask_to_apicid,=0A=
+       .phys_pkg_id =3D phys_pkg_id,=0A=
+};=0A=
+=0A=
 static int __init print_ipi_mode(void)=0A=
 {=0A=
 	printk ("Using IPI %s mode\n", no_broadcast ? "No-Shortcut" :=0A=
diff -uNr =
/home/yhlu/xx1/linux-2.6.13-rc2.orig/arch/x86_64/kernel/mpparse.c =
/home/yhlu/xx1/linux-2.6.13-rc2/arch/x86_64/kernel/mpparse.c=0A=
--- /home/yhlu/xx1/linux-2.6.13-rc2.orig/arch/x86_64/kernel/mpparse.c	=
2005-07-05 20:46:33.000000000 -0700=0A=
+++ /home/yhlu/xx1/linux-2.6.13-rc2/arch/x86_64/kernel/mpparse.c	=
2005-07-06 15:32:47.211084464 -0700=0A=
@@ -341,7 +341,7 @@=0A=
 			}=0A=
 		}=0A=
 	}=0A=
-	clustered_apic_check();=0A=
+	extended_apic_check();=0A=
 	if (!num_processors)=0A=
 		printk(KERN_ERR "SMP mptable: no processors registered!\n");=0A=
 	return num_processors;=0A=
diff -uNr =
/home/yhlu/xx1/linux-2.6.13-rc2.orig/arch/x86_64/kernel/smpboot.c =
/home/yhlu/xx1/linux-2.6.13-rc2/arch/x86_64/kernel/smpboot.c=0A=
--- /home/yhlu/xx1/linux-2.6.13-rc2.orig/arch/x86_64/kernel/smpboot.c	=
2005-07-05 20:46:33.000000000 -0700=0A=
+++ /home/yhlu/xx1/linux-2.6.13-rc2/arch/x86_64/kernel/smpboot.c	=
2005-07-06 18:45:11.923021480 -0700=0A=
@@ -442,7 +442,7 @@=0A=
 	/*=0A=
 	 * Allow the master to continue.=0A=
 	 */=0A=
-	cpu_set(cpuid, cpu_callin_map);=0A=
+//	cpu_set(cpuid, cpu_callin_map); // moved to start_secondary by =
yhlu=0A=
 }=0A=
 =0A=
 static inline void set_cpu_sibling_map(int cpu)=0A=
@@ -529,8 +529,11 @@=0A=
 	/* Wait for TSC sync to not schedule things before.=0A=
 	   We still process interrupts, which could see an inconsistent=0A=
 	   time in that window unfortunately. */=0A=
+=0A=
 	tsc_sync_wait();=0A=
 =0A=
+	cpu_set(smp_processor_id(), cpu_callin_map); // moved from smp_callin =
by yhlu=0A=
+=0A=
 	cpu_idle();=0A=
 }=0A=
 =0A=

------_=_NextPart_000_01C5831C.6F2473B0--
