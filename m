Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266147AbUFIOtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbUFIOtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 10:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265787AbUFIOtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 10:49:04 -0400
Received: from holomorphy.com ([207.189.100.168]:61316 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266150AbUFIOsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 10:48:17 -0400
Date: Wed, 9 Jun 2004 07:48:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Eric BEGOT <eric_begot@yahoo.fr>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc3-mm1
Message-ID: <20040609144809.GK1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@fsmlabs.com>,
	Eric BEGOT <eric_begot@yahoo.fr>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040609015001.31d249ca.akpm@osdl.org> <40C6F3C3.9040401@yahoo.fr> <Pine.LNX.4.58.0406090910170.1838@montezuma.fsmlabs.com> <20040609133653.GH1444@holomorphy.com> <Pine.LNX.4.58.0406090942420.1838@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406090942420.1838@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2004, William Lee Irwin III wrote:
>> As curious as I am as to whether that works, I'm also curious as to
>> whether it's the culprit in this case. Eric, could you also describe your
>> system? A dmesg from a working kernel would also help.

On Wed, Jun 09, 2004 at 09:43:58AM -0400, Zwane Mwaikambo wrote:
> I'm leaning more towards the cpumask stuff but at least eliminating your
> patch being a culprit gets us further.
> 	Zwane

A moment's reflection renders this obvious. phys_cpu_present_map needs
to be doublechecked for the invalid physical APIC ID's in
cpu_present_to_apicid() prior to waking cpus since I'm marking invalid
physical APIC ID's as present to drive the IO-APIC physical APIC ID
validity detection and cpuid validity + detection logic. Something like
this should help a bit.

I'm questioning whether the marking scheme is worth anything and if I
should just rely on bounds-checking against the dynamically-detected
physical APIC ID instead.

(a) attempt to fix zwane's numaq; m->mpc_apicid is wrong to look at.
(b) compilefix for CONFIG_ACPI_BOOT from zwane
(c) check physid's

Totally untested (compiletesting in progress).

-- wli

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
