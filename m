Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265804AbUFINoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265804AbUFINoU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 09:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266092AbUFINoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 09:44:20 -0400
Received: from holomorphy.com ([207.189.100.168]:38020 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265804AbUFINnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 09:43:04 -0400
Date: Wed, 9 Jun 2004 06:42:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@fsmlabs.com>, Eric BEGOT <eric_begot@yahoo.fr>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc3-mm1
Message-ID: <20040609134229.GI1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@fsmlabs.com>,
	Eric BEGOT <eric_begot@yahoo.fr>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040609015001.31d249ca.akpm@osdl.org> <40C6F3C3.9040401@yahoo.fr> <Pine.LNX.4.58.0406090910170.1838@montezuma.fsmlabs.com> <20040609133653.GH1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040609133653.GH1444@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 06:36:53AM -0700, William Lee Irwin III wrote:
> As curious as I am as to whether that works, I'm also curious as to
> whether it's the culprit in this case. Eric, could you also describe your
> system? A dmesg from a working kernel would also help.

Also, this patch never went across lkml. Here is a public post, for
open review's and completeness' sake.


-- wli

From: William Lee Irwin III <wli@holomorphy.com>

The following patch appears sound according to an audit to ensure that all
of the codepaths where it was introduced were called after the APIC
fixmappings were set up.

This patch introduces get_physical_broadcast(), which checks the version ID
of the local APIC to determine whether it's a serial APIC or xAPIC, and
returns the correct physical broadcast ID.  It replaces all uses of
APIC_BROADCAST_ID and IO_APIC_MAX_ID with this in order to ensure.  It also
changes the checks during MP table parsing so the APIC ID is checked in
tandem with the version number.

I'm holding out for some kind of testing to get an idea of whether this
covers the cases or introduces regressions, or whatever.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/kernel/io_apic.c                  |   27 +++++++++++-----
 25-akpm/arch/i386/kernel/mpparse.c                  |   32 ++++++++++++++++++--
 25-akpm/arch/i386/mach-visws/mpparse.c              |   12 ++++++-
 25-akpm/include/asm-i386/genapic.h                  |    2 -
 25-akpm/include/asm-i386/mach-bigsmp/mach_apic.h    |    1 
 25-akpm/include/asm-i386/mach-bigsmp/mach_mpspec.h  |    5 ---
 25-akpm/include/asm-i386/mach-default/mach_apic.h   |    6 ---
 25-akpm/include/asm-i386/mach-default/mach_mpspec.h |    5 ---
 25-akpm/include/asm-i386/mach-es7000/mach_apic.h    |    1 
 25-akpm/include/asm-i386/mach-es7000/mach_mpspec.h  |    5 ---
 25-akpm/include/asm-i386/mach-generic/mach_apic.h   |    1 
 25-akpm/include/asm-i386/mach-generic/mach_mpspec.h |    5 ---
 25-akpm/include/asm-i386/mach-numaq/mach_apic.h     |    1 
 25-akpm/include/asm-i386/mach-numaq/mach_mpspec.h   |    5 ---
 25-akpm/include/asm-i386/mach-summit/mach_apic.h    |    1 
 25-akpm/include/asm-i386/mach-summit/mach_mpspec.h  |    5 ---
 25-akpm/include/asm-i386/mach-visws/mach_apic.h     |    1 
 25-akpm/include/asm-i386/mpspec_def.h               |    1 
 18 files changed, 59 insertions(+), 57 deletions(-)

diff -puN arch/i386/kernel/io_apic.c~apic-enumeration-fixes arch/i386/kernel/io_apic.c
--- 25/arch/i386/kernel/io_apic.c~apic-enumeration-fixes	2004-06-04 01:40:58.080435800 -0700
+++ 25-akpm/arch/i386/kernel/io_apic.c	2004-06-04 01:40:58.237411936 -0700
@@ -722,6 +722,17 @@ static int __init ioapic_pirq_setup(char
 
 __setup("pirq=", ioapic_pirq_setup);
 
+static int get_physical_broadcast(void)
+{
+	unsigned int lvr, version;
+	lvr = apic_read(APIC_LVR);
+	version = GET_APIC_VERSION(lvr);
+	if (version >= 0x14)
+		return 0xff;
+	else
+		return 0xf;
+}
+
 /*
  * Find the IRQ entry number of a certain pin.
  */
@@ -1326,7 +1337,7 @@ void __init print_IO_APIC(void)
 	printk(KERN_DEBUG ".......    : physical APIC id: %02X\n", reg_00.bits.ID);
 	printk(KERN_DEBUG ".......    : Delivery Type: %X\n", reg_00.bits.delivery_type);
 	printk(KERN_DEBUG ".......    : LTS          : %X\n", reg_00.bits.LTS);
-	if (reg_00.bits.ID >= APIC_BROADCAST_ID)
+	if (reg_00.bits.ID >= get_physical_broadcast())
 		UNEXPECTED_IO_APIC();
 	if (reg_00.bits.__reserved_1 || reg_00.bits.__reserved_2)
 		UNEXPECTED_IO_APIC();
@@ -1647,7 +1658,7 @@ static void __init setup_ioapic_ids_from
 		
 		old_id = mp_ioapics[apic].mpc_apicid;
 
-		if (mp_ioapics[apic].mpc_apicid >= APIC_BROADCAST_ID) {
+		if (mp_ioapics[apic].mpc_apicid >= get_physical_broadcast()) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID is %d in the MPC table!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
 			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
@@ -1668,10 +1679,10 @@ static void __init setup_ioapic_ids_from
 					mp_ioapics[apic].mpc_apicid)) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
-			for (i = 0; i < APIC_BROADCAST_ID; i++)
+			for (i = 0; i < get_physical_broadcast(); i++)
 				if (!physid_isset(i, phys_id_present_map))
 					break;
-			if (i >= APIC_BROADCAST_ID)
+			if (i >= get_physical_broadcast())
 				panic("Max APIC ID exceeded!\n");
 			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
 				i);
@@ -2268,8 +2279,6 @@ late_initcall(io_apic_bug_finalize);
 
 #ifdef CONFIG_ACPI_BOOT
 
-#define IO_APIC_MAX_ID APIC_BROADCAST_ID
-
 int __init io_apic_get_unique_id (int ioapic, int apic_id)
 {
 	union IO_APIC_reg_00 reg_00;
@@ -2294,7 +2303,7 @@ int __init io_apic_get_unique_id (int io
 	reg_00.raw = io_apic_read(ioapic, 0);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
-	if (apic_id >= IO_APIC_MAX_ID) {
+	if (apic_id >= get_physical_broadcast()) {
 		printk(KERN_WARNING "IOAPIC[%d]: Invalid apic_id %d, trying "
 			"%d\n", ioapic, apic_id, reg_00.bits.ID);
 		apic_id = reg_00.bits.ID;
@@ -2306,12 +2315,12 @@ int __init io_apic_get_unique_id (int io
 	 */
 	if (check_apicid_used(apic_id_map, apic_id)) {
 
-		for (i = 0; i < IO_APIC_MAX_ID; i++) {
+		for (i = 0; i < get_physical_broadcast(); i++) {
 			if (!check_apicid_used(apic_id_map, i))
 				break;
 		}
 
-		if (i == IO_APIC_MAX_ID)
+		if (i == get_physical_broadcast())
 			panic("Max apic_id exceeded!\n");
 
 		printk(KERN_WARNING "IOAPIC[%d]: apic_id %d already used, "
diff -puN arch/i386/kernel/mpparse.c~apic-enumeration-fixes arch/i386/kernel/mpparse.c
--- 25/arch/i386/kernel/mpparse.c~apic-enumeration-fixes	2004-06-04 01:40:58.082435496 -0700
+++ 25-akpm/arch/i386/kernel/mpparse.c	2004-06-04 01:40:58.238411784 -0700
@@ -23,6 +23,7 @@
 #include <linux/smp_lock.h>
 #include <linux/kernel_stat.h>
 #include <linux/mc146818rtc.h>
+#include <linux/bitops.h>
 
 #include <asm/smp.h>
 #include <asm/acpi.h>
@@ -103,6 +104,31 @@ static int __init mpf_checksum(unsigned 
 static int mpc_record; 
 static struct mpc_config_translation *translation_table[MAX_MPC_ENTRY] __initdata;
 
+#ifdef CONFIG_X86_NUMAQ
+static int MP_valid_apicid(int apicid, int version)
+{
+	return hweight_long(i & 0xf) == 1 && (i >> 4) != 0xf;
+}
+#else
+static int MP_valid_apicid(int apicid, int version)
+{
+	if (version >= 0x14)
+		return apicid < 0xff;
+	else
+		return apicid < 0xf;
+}
+#endif
+
+static void MP_mark_version_physids(int version)
+{
+	int i;
+
+	for (i = 0; i < MAX_APICS; ++i) {
+		if (!MP_valid_apicid(i, version))
+			physid_set(i, phys_cpu_present_map);
+	}
+}
+
 void __init MP_processor_info (struct mpc_config_processor *m)
 {
  	int ver, apicid;
@@ -179,14 +205,16 @@ void __init MP_processor_info (struct mp
 		return;
 	}
 	num_processors++;
+	ver = m->mpc_apicver;
 
-	if (MAX_APICS - m->mpc_apicid <= 0) {
+	if (MP_valid_apicid(m->mpc_apicid, ver))
+		MP_mark_version_physids(ver);
+	else {
 		printk(KERN_WARNING "Processor #%d INVALID. (Max ID: %d).\n",
 			m->mpc_apicid, MAX_APICS);
 		--num_processors;
 		return;
 	}
-	ver = m->mpc_apicver;
 
 	tmp = apicid_to_cpu_present(apicid);
 	physids_or(phys_cpu_present_map, phys_cpu_present_map, tmp);
diff -puN arch/i386/mach-visws/mpparse.c~apic-enumeration-fixes arch/i386/mach-visws/mpparse.c
--- 25/arch/i386/mach-visws/mpparse.c~apic-enumeration-fixes	2004-06-04 01:40:58.089434432 -0700
+++ 25-akpm/arch/i386/mach-visws/mpparse.c	2004-06-04 01:40:58.239411632 -0700
@@ -57,12 +57,12 @@ void __init MP_processor_info (struct mp
 		boot_cpu_logical_apicid = logical_apicid;
 	}
 
-	if (m->mpc_apicid > MAX_APICS) {
+	ver = m->mpc_apicver;
+	if ((ver >= 0x14 && m->mpc_apicid >= 0xff) || m->mpc_apicid >= 0xf) {
 		printk(KERN_ERR "Processor #%d INVALID. (Max ID: %d).\n",
 			m->mpc_apicid, MAX_APICS);
 		return;
 	}
-	ver = m->mpc_apicver;
 
 	apic_cpus = apicid_to_cpu_present(m->mpc_apicid);
 	physids_or(phys_cpu_present_map, phys_cpu_present_map, apic_cpus);
@@ -75,6 +75,14 @@ void __init MP_processor_info (struct mp
 			m->mpc_apicid);
 		ver = 0x10;
 	}
+	if (ver >= 0x14)
+		physid_set(0xff, phys_cpu_present_map);
+	else {
+		int i;
+
+		for (i = 0xf; i < MAX_APICS; ++i)
+			physid_set(i, phys_cpu_present_map);
+	}
 	apic_version[m->mpc_apicid] = ver;
 }
 
diff -puN include/asm-i386/genapic.h~apic-enumeration-fixes include/asm-i386/genapic.h
--- 25/include/asm-i386/genapic.h~apic-enumeration-fixes	2004-06-04 01:40:58.093433824 -0700
+++ 25-akpm/include/asm-i386/genapic.h	2004-06-04 01:40:58.240411480 -0700
@@ -25,7 +25,6 @@ struct genapic { 
 	cpumask_t (*target_cpus)(void);
 	int int_delivery_mode;
 	int int_dest_mode; 
-	int apic_broadcast_id; 
 	int ESR_DISABLE;
 	int apic_destination_logical;
 	unsigned long (*check_apicid_used)(physid_mask_t bitmap, int apicid);
@@ -78,7 +77,6 @@ struct genapic { 
 	.probe = aprobe, \
 	.int_delivery_mode = INT_DELIVERY_MODE, \
 	.int_dest_mode = INT_DEST_MODE, \
-	.apic_broadcast_id = APIC_BROADCAST_ID, \
 	.no_balance_irq = NO_BALANCE_IRQ, \
 	.no_ioapic_check = NO_IOAPIC_CHECK, \
 	.ESR_DISABLE = esr_disable, \
diff -puN include/asm-i386/mach-bigsmp/mach_apic.h~apic-enumeration-fixes include/asm-i386/mach-bigsmp/mach_apic.h
--- 25/include/asm-i386/mach-bigsmp/mach_apic.h~apic-enumeration-fixes	2004-06-04 01:40:58.102432456 -0700
+++ 25-akpm/include/asm-i386/mach-bigsmp/mach_apic.h	2004-06-04 01:40:58.241411328 -0700
@@ -39,7 +39,6 @@ static inline cpumask_t target_cpus(void
 #define INT_DELIVERY_MODE dest_Fixed
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
 
-#define APIC_BROADCAST_ID     (0xff)
 static inline unsigned long check_apicid_used(physid_mask_t bitmap, int apicid)
 {
 	return 0;
diff -puN include/asm-i386/mach-bigsmp/mach_mpspec.h~apic-enumeration-fixes include/asm-i386/mach-bigsmp/mach_mpspec.h
--- 25/include/asm-i386/mach-bigsmp/mach_mpspec.h~apic-enumeration-fixes	2004-06-04 01:40:58.103432304 -0700
+++ 25-akpm/include/asm-i386/mach-bigsmp/mach_mpspec.h	2004-06-04 01:40:58.243411024 -0700
@@ -1,11 +1,6 @@
 #ifndef __ASM_MACH_MPSPEC_H
 #define __ASM_MACH_MPSPEC_H
 
-/*
- * a maximum of 16 APICs with the current APIC ID architecture.
- */
-#define MAX_APICS 16
-
 #define MAX_IRQ_SOURCES 256
 
 #define MAX_MP_BUSSES 32
diff -puN include/asm-i386/mach-default/mach_apic.h~apic-enumeration-fixes include/asm-i386/mach-default/mach_apic.h
--- 25/include/asm-i386/mach-default/mach_apic.h~apic-enumeration-fixes	2004-06-04 01:40:58.114430632 -0700
+++ 25-akpm/include/asm-i386/mach-default/mach_apic.h	2004-06-04 01:40:58.244410872 -0700
@@ -23,12 +23,6 @@ static inline cpumask_t target_cpus(void
 #define INT_DELIVERY_MODE dest_LowestPrio
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
 
-/*
- * this isn't really broadcast, just a (potentially inaccurate) upper
- * bound for valid physical APIC id's
- */
-#define APIC_BROADCAST_ID      0x0F
-
 static inline unsigned long check_apicid_used(physid_mask_t bitmap, int apicid)
 {
 	return physid_isset(apicid, bitmap);
diff -puN include/asm-i386/mach-default/mach_mpspec.h~apic-enumeration-fixes include/asm-i386/mach-default/mach_mpspec.h
--- 25/include/asm-i386/mach-default/mach_mpspec.h~apic-enumeration-fixes	2004-06-04 01:40:58.129428352 -0700
+++ 25-akpm/include/asm-i386/mach-default/mach_mpspec.h	2004-06-04 01:40:58.246410568 -0700
@@ -1,11 +1,6 @@
 #ifndef __ASM_MACH_MPSPEC_H
 #define __ASM_MACH_MPSPEC_H
 
-/*
- * a maximum of 16 APICs with the current APIC ID architecture.
- */
-#define MAX_APICS 16
-
 #define MAX_IRQ_SOURCES 256
 
 #define MAX_MP_BUSSES 32
diff -puN include/asm-i386/mach-es7000/mach_apic.h~apic-enumeration-fixes include/asm-i386/mach-es7000/mach_apic.h
--- 25/include/asm-i386/mach-es7000/mach_apic.h~apic-enumeration-fixes	2004-06-04 01:40:58.148425464 -0700
+++ 25-akpm/include/asm-i386/mach-es7000/mach_apic.h	2004-06-04 01:40:58.247410416 -0700
@@ -38,7 +38,6 @@ static inline cpumask_t target_cpus(void
 #define WAKE_SECONDARY_VIA_INIT
 #endif
 
-#define APIC_BROADCAST_ID	(0xff)
 #define NO_IOAPIC_CHECK (1)
 
 static inline unsigned long check_apicid_used(physid_mask_t bitmap, int apicid)
diff -puN include/asm-i386/mach-es7000/mach_mpspec.h~apic-enumeration-fixes include/asm-i386/mach-es7000/mach_mpspec.h
--- 25/include/asm-i386/mach-es7000/mach_mpspec.h~apic-enumeration-fixes	2004-06-04 01:40:58.149425312 -0700
+++ 25-akpm/include/asm-i386/mach-es7000/mach_mpspec.h	2004-06-04 01:40:58.249410112 -0700
@@ -1,11 +1,6 @@
 #ifndef __ASM_MACH_MPSPEC_H
 #define __ASM_MACH_MPSPEC_H
 
-/*
- * a maximum of 256 APICs with the current APIC ID architecture.
- */
-#define MAX_APICS 256
-
 #define MAX_IRQ_SOURCES 256
 
 #define MAX_MP_BUSSES 32
diff -puN include/asm-i386/mach-generic/mach_apic.h~apic-enumeration-fixes include/asm-i386/mach-generic/mach_apic.h
--- 25/include/asm-i386/mach-generic/mach_apic.h~apic-enumeration-fixes	2004-06-04 01:40:58.156424248 -0700
+++ 25-akpm/include/asm-i386/mach-generic/mach_apic.h	2004-06-04 01:40:58.250409960 -0700
@@ -6,7 +6,6 @@
 #define esr_disable (genapic->ESR_DISABLE)
 #define NO_BALANCE_IRQ (genapic->no_balance_irq)
 #define NO_IOAPIC_CHECK	(genapic->no_ioapic_check)
-#define APIC_BROADCAST_ID (genapic->apic_broadcast_id)
 #define INT_DELIVERY_MODE (genapic->int_delivery_mode)
 #define INT_DEST_MODE (genapic->int_dest_mode)
 #undef APIC_DEST_LOGICAL
diff -puN include/asm-i386/mach-generic/mach_mpspec.h~apic-enumeration-fixes include/asm-i386/mach-generic/mach_mpspec.h
--- 25/include/asm-i386/mach-generic/mach_mpspec.h~apic-enumeration-fixes	2004-06-04 01:40:58.163423184 -0700
+++ 25-akpm/include/asm-i386/mach-generic/mach_mpspec.h	2004-06-04 01:40:58.252409656 -0700
@@ -1,11 +1,6 @@
 #ifndef __ASM_MACH_MPSPEC_H
 #define __ASM_MACH_MPSPEC_H
 
-/*
- * a maximum of 256 APICs with the current APIC ID architecture.
- */
-#define MAX_APICS 256
-
 #define MAX_IRQ_SOURCES 256
 
 /* Summit or generic (i.e. installer) kernels need lots of bus entries. */
diff -puN include/asm-i386/mach-numaq/mach_apic.h~apic-enumeration-fixes include/asm-i386/mach-numaq/mach_apic.h
--- 25/include/asm-i386/mach-numaq/mach_apic.h~apic-enumeration-fixes	2004-06-04 01:40:58.165422880 -0700
+++ 25-akpm/include/asm-i386/mach-numaq/mach_apic.h	2004-06-04 01:40:58.254409352 -0700
@@ -21,7 +21,6 @@ static inline cpumask_t target_cpus(void
 #define INT_DELIVERY_MODE dest_LowestPrio
 #define INT_DEST_MODE 0     /* physical delivery on LOCAL quad */
  
-#define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid) physid_isset(apicid, bitmap)
 #define check_apicid_present(bit) physid_isset(bit, phys_cpu_present_map)
 #define apicid_cluster(apicid) (apicid & 0xF0)
diff -puN include/asm-i386/mach-numaq/mach_mpspec.h~apic-enumeration-fixes include/asm-i386/mach-numaq/mach_mpspec.h
--- 25/include/asm-i386/mach-numaq/mach_mpspec.h~apic-enumeration-fixes	2004-06-04 01:40:58.172421816 -0700
+++ 25-akpm/include/asm-i386/mach-numaq/mach_mpspec.h	2004-06-04 01:40:58.255409200 -0700
@@ -1,11 +1,6 @@
 #ifndef __ASM_MACH_MPSPEC_H
 #define __ASM_MACH_MPSPEC_H
 
-/*
- * a maximum of 256 APICs with the current APIC ID architecture.
- */
-#define MAX_APICS 256
-
 #define MAX_IRQ_SOURCES 512
 
 #define MAX_MP_BUSSES 32
diff -puN include/asm-i386/mach-summit/mach_apic.h~apic-enumeration-fixes include/asm-i386/mach-summit/mach_apic.h
--- 25/include/asm-i386/mach-summit/mach_apic.h~apic-enumeration-fixes	2004-06-04 01:40:58.187419536 -0700
+++ 25-akpm/include/asm-i386/mach-summit/mach_apic.h	2004-06-04 01:40:58.257408896 -0700
@@ -26,7 +26,6 @@ static inline cpumask_t target_cpus(void
 #define INT_DELIVERY_MODE (dest_Fixed)
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
 
-#define APIC_BROADCAST_ID     (0xFF)
 static inline unsigned long check_apicid_used(physid_mask_t bitmap, int apicid)
 {
 	return 0;
diff -puN include/asm-i386/mach-summit/mach_mpspec.h~apic-enumeration-fixes include/asm-i386/mach-summit/mach_mpspec.h
--- 25/include/asm-i386/mach-summit/mach_mpspec.h~apic-enumeration-fixes	2004-06-04 01:40:58.188419384 -0700
+++ 25-akpm/include/asm-i386/mach-summit/mach_mpspec.h	2004-06-04 01:40:58.258408744 -0700
@@ -1,11 +1,6 @@
 #ifndef __ASM_MACH_MPSPEC_H
 #define __ASM_MACH_MPSPEC_H
 
-/*
- * a maximum of 256 APICs with the current APIC ID architecture.
- */
-#define MAX_APICS 256
-
 #define MAX_IRQ_SOURCES 256
 
 /* Maximum 256 PCI busses, plus 1 ISA bus in each of 4 cabinets. */
diff -puN include/asm-i386/mach-visws/mach_apic.h~apic-enumeration-fixes include/asm-i386/mach-visws/mach_apic.h
--- 25/include/asm-i386/mach-visws/mach_apic.h~apic-enumeration-fixes	2004-06-04 01:40:58.202417256 -0700
+++ 25-akpm/include/asm-i386/mach-visws/mach_apic.h	2004-06-04 01:40:58.260408440 -0700
@@ -19,7 +19,6 @@
  #define TARGET_CPUS cpumask_of_cpu(0)
 #endif
 
-#define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid)	physid_isset(apicid, bitmap)
 #define check_apicid_present(bit)		physid_isset(bit, phys_cpu_present_map)
 
diff -puN include/asm-i386/mpspec_def.h~apic-enumeration-fixes include/asm-i386/mpspec_def.h
--- 25/include/asm-i386/mpspec_def.h~apic-enumeration-fixes	2004-06-04 01:40:58.219414672 -0700
+++ 25-akpm/include/asm-i386/mpspec_def.h	2004-06-04 01:40:58.261408288 -0700
@@ -14,6 +14,7 @@
 #define SMP_MAGIC_IDENT	(('_'<<24)|('P'<<16)|('M'<<8)|'_')
 
 #define MAX_MPC_ENTRY 1024
+#define MAX_APICS      256
 
 struct intel_mp_floating
 {
_
