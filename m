Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274944AbTHAB0b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 21:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274945AbTHAB0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 21:26:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:37580 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274944AbTHAB03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 21:26:29 -0400
Date: Thu, 31 Jul 2003 18:27:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Bakos <bakhos@msi.umn.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compile error for Opteron CPU with kernel 2.6.0-test2
Message-Id: <20030731182705.5b4f2b33.akpm@osdl.org>
In-Reply-To: <Pine.SGI.4.33.0307312008210.23301-100000@ir12.msi.umn.edu>
References: <20030731145954.47d6247f.akpm@osdl.org>
	<Pine.SGI.4.33.0307312008210.23301-100000@ir12.msi.umn.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Bakos <bakhos@msi.umn.edu> wrote:
>
> In file included from include/linux/topology.h:35,
>                   from include/linux/mmzone.h:294,
>                   from include/linux/gfp.h:4,
>                   from include/linux/slab.h:15,
>                   from include/linux/percpu.h:4,
>                   from include/linux/sched.h:31,
>                   from arch/x86_64/kernel/asm-offsets.c:7:
>  include/asm/topology.h: In function `pcibus_to_cpumask':
>  include/asm/topology.h:24: error: invalid operands to binary &
>  make[1]: *** [arch/x86_64/kernel/asm-offsets.s] Error 1
>  make: *** [arch/x86_64/kernel/asm-offsets.s] Error 2

urgh, OK.  We're chasing around in circles here.  And the cpumask_t patch
still isn't ready for merging.


This might fix it.

 arch/x86_64/kernel/mpparse.c  |    2 +-
 include/asm-x86_64/mpspec.h   |    2 +-
 include/asm-x86_64/topology.h |    7 +++++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff -puN include/asm-x86_64/topology.h~x86_64-cpumask_t-fix include/asm-x86_64/topology.h
--- 25/include/asm-x86_64/topology.h~x86_64-cpumask_t-fix	2003-07-31 18:20:51.000000000 -0700
+++ 25-akpm/include/asm-x86_64/topology.h	2003-07-31 18:25:11.000000000 -0700
@@ -19,9 +19,12 @@ extern cpumask_t cpu_online_map;
 #define node_to_cpu_mask(node)	(fake_node ? cpu_online_map : cpumask_of_cpu(node))
 #define node_to_memblk(node)		(node)
 
-static inline unsigned long pcibus_to_cpumask(int bus)
+static inline cpumask_t pcibus_to_cpumask(int bus)
 {
-	return mp_bus_to_cpumask[bus] & cpu_online_map;
+	cpumask_t ret;
+
+	cpus_and(ret, mp_bus_to_cpumask[bus], cpu_online_map);
+	return ret;
 }
 
 #define NODE_BALANCE_RATE 30	/* CHECKME */ 
diff -puN include/asm-x86_64/mpspec.h~x86_64-cpumask_t-fix include/asm-x86_64/mpspec.h
--- 25/include/asm-x86_64/mpspec.h~x86_64-cpumask_t-fix	2003-07-31 18:24:12.000000000 -0700
+++ 25-akpm/include/asm-x86_64/mpspec.h	2003-07-31 18:24:35.000000000 -0700
@@ -166,7 +166,7 @@ enum mp_bustype {
 };
 extern unsigned char mp_bus_id_to_type [MAX_MP_BUSSES];
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
-extern unsigned long mp_bus_to_cpumask [MAX_MP_BUSSES];
+extern cpumask_t mp_bus_to_cpumask [MAX_MP_BUSSES];
 
 extern unsigned int boot_cpu_physical_apicid;
 extern cpumask_t phys_cpu_present_map;
diff -puN arch/x86_64/kernel/mpparse.c~x86_64-cpumask_t-fix arch/x86_64/kernel/mpparse.c
--- 25/arch/x86_64/kernel/mpparse.c~x86_64-cpumask_t-fix	2003-07-31 18:24:54.000000000 -0700
+++ 25-akpm/arch/x86_64/kernel/mpparse.c	2003-07-31 18:25:45.000000000 -0700
@@ -43,7 +43,7 @@ int acpi_found_madt;
 int apic_version [MAX_APICS];
 unsigned char mp_bus_id_to_type [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
 int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
-unsigned long mp_bus_to_cpumask [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1UL };
+cpumask_t mp_bus_to_cpumask [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = CPU_MASK_ALL };
 
 int mp_current_pci_id = 0;
 /* I/O APIC entries */

_

