Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265998AbUFJCwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265998AbUFJCwp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 22:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266094AbUFJCwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 22:52:45 -0400
Received: from holomorphy.com ([207.189.100.168]:46216 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265998AbUFJCw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 22:52:27 -0400
Date: Wed, 9 Jun 2004 19:52:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Phil Brunner <pbrunner1@earthlink.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm1
Message-ID: <20040610025221.GT1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Phil Brunner <pbrunner1@earthlink.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040609015001.31d249ca.akpm@osdl.org> <40C7C310.1010009@earthlink.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <40C7C310.1010009@earthlink.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Andrew Morton wrote:
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc3/2.6.7-rc3-mm1/
>>

On Wed, Jun 09, 2004 at 07:10:24PM -0700, Phil Brunner wrote:
> Could not compile with CONFIG_X86_IO_APIC=y. Function call to 
> (undefined) mp_register_gsi in arch/i386/kernel/acpi/boot.c is the problem.
> Code in arch/i386/kernel/mpparse.c may be the appropriate function 
> definition (?).

Please apply the following 3 patches applied in order and run with them:


-- wli

--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Description: 01-physical_broadcast_fixes.patch
Content-Disposition: attachment; filename="zwane_numaq_fixes.patch"

Index: mm1-2.6.7-rc3/arch/i386/kernel/mpparse.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/i386/kernel/mpparse.c	2004-06-09 07:11:51.335601000 -0700
+++ mm1-2.6.7-rc3/arch/i386/kernel/mpparse.c	2004-06-09 07:42:04.221000000 -0700
@@ -107,7 +107,7 @@
 #ifdef CONFIG_X86_NUMAQ
 static int MP_valid_apicid(int apicid, int version)
 {
-	return hweight_long(i & 0xf) == 1 && (i >> 4) != 0xf;
+	return hweight_long(apicid & 0xf) == 1 && (apicid >> 4) != 0xf;
 }
 #else
 static int MP_valid_apicid(int apicid, int version)
@@ -207,7 +207,7 @@
 	num_processors++;
 	ver = m->mpc_apicver;
 
-	if (MP_valid_apicid(m->mpc_apicid, ver))
+	if (MP_valid_apicid(apicid, ver))
 		MP_mark_version_physids(ver);
 	else {
 		printk(KERN_WARNING "Processor #%d INVALID. (Max ID: %d).\n",
@@ -871,7 +871,7 @@
 	MP_processor_info(&processor);
 }
 
-#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI_INTERPRETER)
+#if defined(CONFIG_X86_IO_APIC) && (defined(CONFIG_ACPI_INTERPRETER) || defined(CONFIG_ACPI_BOOT))
 
 #define MP_ISA_BUS		0
 #define MP_MAX_IOAPIC_PIN	127
@@ -1103,5 +1103,5 @@
 		    active_high_low == ACPI_ACTIVE_HIGH ? 0 : 1);
 }
 
-#endif /*CONFIG_X86_IO_APIC && CONFIG_ACPI_INTERPRETER*/
+#endif /*CONFIG_X86_IO_APIC && (CONFIG_ACPI_INTERPRETER || CONFIG_ACPI_BOOT)*/
 #endif /*CONFIG_ACPI_BOOT*/
Index: mm1-2.6.7-rc3/arch/i386/kernel/io_apic.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/i386/kernel/io_apic.c	2004-06-09 07:11:51.323603000 -0700
+++ mm1-2.6.7-rc3/arch/i386/kernel/io_apic.c	2004-06-09 07:30:06.936044000 -0700
@@ -722,7 +722,7 @@
 
 __setup("pirq=", ioapic_pirq_setup);
 
-static int get_physical_broadcast(void)
+int get_physical_broadcast(void)
 {
 	unsigned int lvr, version;
 	lvr = apic_read(APIC_LVR);
Index: mm1-2.6.7-rc3/include/asm-i386/mach-default/mach_apic.h
===================================================================
--- mm1-2.6.7-rc3.orig/include/asm-i386/mach-default/mach_apic.h	2004-06-09 07:11:51.513574000 -0700
+++ mm1-2.6.7-rc3/include/asm-i386/mach-default/mach_apic.h	2004-06-09 07:42:51.696783000 -0700
@@ -79,7 +79,10 @@
 
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
-	return  mps_cpu;
+	if (mps_cpu < get_physical_broadcast())
+		return  mps_cpu;
+	else
+		return BAD_APICID;
 }
 
 static inline physid_mask_t apicid_to_cpu_present(int phys_apicid)
Index: mm1-2.6.7-rc3/include/asm-i386/mach-visws/mach_apic.h
===================================================================
--- mm1-2.6.7-rc3.orig/include/asm-i386/mach-visws/mach_apic.h	2004-06-09 07:11:51.635555000 -0700
+++ mm1-2.6.7-rc3/include/asm-i386/mach-visws/mach_apic.h	2004-06-09 07:29:30.131639000 -0700
@@ -60,7 +60,10 @@
 
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
-	return mps_cpu;
+	if (mps_cpu < get_physical_broadcast())
+		return mps_cpu;
+	else
+		return BAD_APICID;
 }
 
 static inline physid_mask_t apicid_to_cpu_present(int apicid)
Index: mm1-2.6.7-rc3/include/asm-i386/apic.h
===================================================================
--- mm1-2.6.7-rc3.orig/include/asm-i386/apic.h	2004-06-07 12:15:12.000000000 -0700
+++ mm1-2.6.7-rc3/include/asm-i386/apic.h	2004-06-09 07:29:54.104995000 -0700
@@ -41,6 +41,8 @@
 	do { } while ( apic_read( APIC_ICR ) & APIC_ICR_BUSY );
 }
 
+int get_physical_broadcast(void);
+
 #ifdef CONFIG_X86_GOOD_APIC
 # define FORCE_READ_AROUND_WRITE 0
 # define apic_read_around(x)

--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Description: 02-remove_mp_mark_version_physids.patch
Content-Disposition: attachment; filename="remove_mark_mp_version_physids.patch"

Index: mm1-2.6.7-rc3/arch/i386/kernel/mpparse.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/i386/kernel/mpparse.c	2004-06-09 07:42:04.221000000 -0700
+++ mm1-2.6.7-rc3/arch/i386/kernel/mpparse.c	2004-06-09 07:54:51.703325000 -0700
@@ -119,16 +119,6 @@
 }
 #endif
 
-static void MP_mark_version_physids(int version)
-{
-	int i;
-
-	for (i = 0; i < MAX_APICS; ++i) {
-		if (!MP_valid_apicid(i, version))
-			physid_set(i, phys_cpu_present_map);
-	}
-}
-
 void __init MP_processor_info (struct mpc_config_processor *m)
 {
  	int ver, apicid;
@@ -207,9 +197,7 @@
 	num_processors++;
 	ver = m->mpc_apicver;
 
-	if (MP_valid_apicid(apicid, ver))
-		MP_mark_version_physids(ver);
-	else {
+	if (!MP_valid_apicid(apicid, ver)) {
 		printk(KERN_WARNING "Processor #%d INVALID. (Max ID: %d).\n",
 			m->mpc_apicid, MAX_APICS);
 		--num_processors;
Index: mm1-2.6.7-rc3/arch/i386/mach-visws/mpparse.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/i386/mach-visws/mpparse.c	2004-06-09 07:11:51.380594000 -0700
+++ mm1-2.6.7-rc3/arch/i386/mach-visws/mpparse.c	2004-06-09 07:57:04.521134000 -0700
@@ -75,14 +75,6 @@
 			m->mpc_apicid);
 		ver = 0x10;
 	}
-	if (ver >= 0x14)
-		physid_set(0xff, phys_cpu_present_map);
-	else {
-		int i;
-
-		for (i = 0xf; i < MAX_APICS; ++i)
-			physid_set(i, phys_cpu_present_map);
-	}
 	apic_version[m->mpc_apicid] = ver;
 }
 

--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Description: 03-mach_default_compile.patch
Content-Disposition: attachment; filename="mach_default_compile.patch"

Index: mm1-2.6.7-rc3/include/asm-i386/mach-default/mach_apic.h
===================================================================
--- mm1-2.6.7-rc3.orig/include/asm-i386/mach-default/mach_apic.h	2004-06-09 08:08:00.000000000 -0700
+++ mm1-2.6.7-rc3/include/asm-i386/mach-default/mach_apic.h	2004-06-09 08:10:17.000000000 -0700
@@ -2,6 +2,7 @@
 #define __ASM_MACH_APIC_H
 
 #include <mach_apicdef.h>
+#include <asm/smp.h>
 
 #define APIC_DFR_VALUE	(APIC_DFR_FLAT)
 
Index: mm1-2.6.7-rc3/arch/i386/kernel/io_apic.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/i386/kernel/io_apic.c	2004-06-09 08:08:00.000000000 -0700
+++ mm1-2.6.7-rc3/arch/i386/kernel/io_apic.c	2004-06-09 08:13:05.000000000 -0700
@@ -722,17 +722,6 @@
 
 __setup("pirq=", ioapic_pirq_setup);
 
-int get_physical_broadcast(void)
-{
-	unsigned int lvr, version;
-	lvr = apic_read(APIC_LVR);
-	version = GET_APIC_VERSION(lvr);
-	if (version >= 0x14)
-		return 0xff;
-	else
-		return 0xf;
-}
-
 /*
  * Find the IRQ entry number of a certain pin.
  */
Index: mm1-2.6.7-rc3/arch/i386/kernel/apic.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/i386/kernel/apic.c	2004-06-09 08:06:44.000000000 -0700
+++ mm1-2.6.7-rc3/arch/i386/kernel/apic.c	2004-06-09 08:13:27.000000000 -0700
@@ -80,6 +80,17 @@
 	apic_write_around(APIC_LVT0, v);
 }
 
+int get_physical_broadcast(void)
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
 int get_maxlvt(void)
 {
 	unsigned int v, ver, maxlvt;

--rJwd6BRFiFCcLxzm--
