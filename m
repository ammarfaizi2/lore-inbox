Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268940AbTBZUxj>; Wed, 26 Feb 2003 15:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268944AbTBZUxi>; Wed, 26 Feb 2003 15:53:38 -0500
Received: from franka.aracnet.com ([216.99.193.44]:17887 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268940AbTBZUxe>; Wed, 26 Feb 2003 15:53:34 -0500
Date: Wed, 26 Feb 2003 13:03:25 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ion Badulescu <ionut@badula.org>, Rusty Russell <rusty@rustcorp.com.au>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [BUG] 2.5.63: ESR killed my box!
Message-ID: <5740000.1046293404@[10.10.2.4]>
In-Reply-To: <200302262047.h1QKlcPt015577@buggy.badula.org>
References: <200302262047.h1QKlcPt015577@buggy.badula.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect the ESR is a red herring. The problem is that the kernel 
> assumes that the boot CPU is always CPU#0, and it also misprograms the 
> boot CPU's APIC.
> 
> What kind of SMP box is it (Intel/AMD)?

The boot cpu *is* always CPU#0. It may not be physical apicid 0, but that
matters not. as long as the mpstables are correct. And we should bug out if
it's not (which is pretty stupid anyway ... we know what the boot cpu ID
is, we should just warn). This is how I fixed it for kexec:

diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/kernel/smpboot.c
nonzero_apicid/arch/i386/kernel/smpboot.c
--- virgin/arch/i386/kernel/smpboot.c	Sat Feb 15 16:11:40 2003
+++ nonzero_apicid/arch/i386/kernel/smpboot.c	Wed Feb 26 13:02:10 2003
@@ -951,6 +951,7 @@ static void __init smp_boot_cpus(unsigne
 	print_cpu_info(&cpu_data[0]);
 
 	boot_cpu_logical_apicid = logical_smp_processor_id();
+	boot_cpu_physical_apicid = hard_smp_processor_id();
 
 	current_thread_info()->cpu = 0;
 	smp_tune_scheduling();



