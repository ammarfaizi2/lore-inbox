Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268941AbTB0Baw>; Wed, 26 Feb 2003 20:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269149AbTB0Baw>; Wed, 26 Feb 2003 20:30:52 -0500
Received: from franka.aracnet.com ([216.99.193.44]:25799 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268941AbTB0Bav>; Wed, 26 Feb 2003 20:30:51 -0500
Date: Wed, 26 Feb 2003 17:40:56 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ion Badulescu <ionut@badula.org>, Linus Torvalds <torvalds@transmeta.com>
cc: Mikael Pettersson <mikpe@user.it.uu.se>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       mingo@redhat.com
Subject: Re: [BUG] 2.5.63: ESR killed my box!
Message-ID: <13610000.1046310055@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0302261931130.6844-100000@moisil.badula.org>
References: <Pine.LNX.4.44.0302261931130.6844-100000@moisil.badula.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Works for me, but I'm curious if it works for Rusty. We're still not sure 
> if he's hitting the same bug... but I guess it's rather early morning in 
> .au. :-)
> 
> Oh, and 2.4 needs the same fix -- and if Mikael's original BUG_ON() is 
> undesirable then we should probably also remove this code from 2.4's 
> apic.c:setup_local_APIC()
> 
>         if (!clustered_apic_mode && 
>             !test_bit(GET_APIC_ID(apic_read(APIC_ID)),
> &phys_cpu_present_map))                 BUG();
> 
> because it's essentially the same test as the BUG_ON(), at least for the 
> UP case.

Also from smpboot.c / mpparse.c. Untested patch below (sorry, don't have a
box to hand that uses phys apicids to boot).

diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/kernel/mpparse.c
nonzero_apicid2/arch/i386/kernel/mpparse.c
--- virgin/arch/i386/kernel/mpparse.c	Tue Feb 25 23:03:43 2003
+++ nonzero_apicid2/arch/i386/kernel/mpparse.c	Wed Feb 26 17:39:39 2003
@@ -162,7 +162,8 @@ void __init MP_processor_info (struct mp
 
 	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
 		Dprintk("    Bootup CPU\n");
-		boot_cpu_physical_apicid = m->mpc_apicid;
+		if (m->mpc_apicid != hard_smp_processor_id())
+			printk "Warning: MP table lies about boot cpu\n";
 		boot_cpu_logical_apicid = apicid;
 	}
 
diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/kernel/smpboot.c
nonzero_apicid2/arch/i386/kernel/smpboot.c
--- virgin/arch/i386/kernel/smpboot.c	Sat Feb 15 16:11:40 2003
+++ nonzero_apicid2/arch/i386/kernel/smpboot.c	Wed Feb 26 17:37:12 2003
@@ -951,6 +951,7 @@ static void __init smp_boot_cpus(unsigne
 	print_cpu_info(&cpu_data[0]);
 
 	boot_cpu_logical_apicid = logical_smp_processor_id();
+	boot_cpu_physical_apicid = hard_smp_processor_id();
 
 	current_thread_info()->cpu = 0;
 	smp_tune_scheduling();
@@ -1008,9 +1009,6 @@ static void __init smp_boot_cpus(unsigne
 	connect_bsp_APIC();
 	setup_local_APIC();
 	map_cpu_to_logical_apicid();
-
-	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_physical_apicid)
-		BUG();
 
 	setup_portio_remap();
 

