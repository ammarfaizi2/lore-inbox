Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSH0EJR>; Tue, 27 Aug 2002 00:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSH0EJR>; Tue, 27 Aug 2002 00:09:17 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:10447 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293680AbSH0EJQ> convert rfc822-to-8bit;
	Tue, 27 Aug 2002 00:09:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: "Grover, Andrew" <andrew.grover@intel.com>, Andi Kleen <ak@suse.de>
Subject: [PATCH] ACPI tweak for 2.5.31 Summit NUMA patch with dynamic IRQ balancing
Date: Mon, 26 Aug 2002 21:13:19 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <EDC461A30AC4D511ADE10002A5072CAD0236DDD5@orsmsx119.jf.intel.com>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DDD5@orsmsx119.jf.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208262113.19040.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 August 2002 12:05 am, Grover, Andrew wrote:
> > From: James Cleverdon [mailto:jamesclv@us.ibm.com]

[ Snip discussion of full vs. HT-only ACPI support ]

This patch works together with my 2.5.31 Summit patch to boot a x440 with 
ACPI's CPU enumeration-only turned on.

As always, comments and corrections welcome:

--- t31/arch/i386/kernel/mpparse.c.df	Thu Aug 22 17:57:45 2002
+++ t31/arch/i386/kernel/mpparse.c	Mon Aug 26 19:46:01 2002
@@ -240,10 +240,23 @@
 	}
 }
 
+static int __init ioapic_dup_check(unsigned long apicaddr)
+{
+	register int	i;
+
+	for (i = nr_ioapics; --i >= 0; ) {
+		if (mp_ioapics[i].mpc_apicaddr == apicaddr)
+			return 1;	/* Got a dup. */
+	}
+	return 0;			/* No dup. */
+}
+
 static void __init MP_ioapic_info (struct mpc_config_ioapic *m)
 {
 	if (!(m->mpc_flags & MPC_APIC_USABLE))
 		return;
+	if (ioapic_dup_check(m->mpc_apicaddr))
+		return;
 
 	printk("I/O APIC #%d Version %d at 0x%lX.\n",
 		m->mpc_apicid, m->mpc_apicver, m->mpc_apicaddr);
@@ -691,10 +704,8 @@
 	 * ACPI supports both logical (e.g. Hyper-Threading) and physical 
 	 * processors, where MPS only supports physical.
 	 */
-	if (acpi_lapic && acpi_ioapic) {
+	if (acpi_lapic && acpi_ioapic)
 		printk(KERN_INFO "Using ACPI (MADT) for SMP configuration information\n");
-		return;
-	}
 	else if (acpi_lapic)
 		printk(KERN_INFO "Using ACPI for processor (LAPIC) configuration 
information\n");
 
@@ -949,6 +960,8 @@
 {
 	int			idx = 0;
 
+	if (ioapic_dup_check(address))
+		return;
 	if (nr_ioapics >= MAX_IO_APICS) {
 		printk(KERN_ERR "ERROR: Max # of I/O APICs (%d) exceeded "
 			"(found %d)\n", MAX_IO_APICS, nr_ioapics);
--- t31/arch/i386/kernel/acpi.c.df	Mon Aug 26 21:06:40 2002
+++ t31/arch/i386/kernel/acpi.c	Mon Aug 26 20:33:22 2002
@@ -364,18 +368,18 @@
 		return result;
 	}
 
+#ifndef CONFIG_ACPI_HT_ONLY
 	result = acpi_table_parse_madt(ACPI_MADT_LAPIC_NMI, acpi_parse_lapic_nmi);
 	if (result < 0) {
 		printk(KERN_ERR PREFIX "Error parsing LAPIC NMI entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
 		return result;
 	}
+#endif /*!CONFIG_ACPI_HT_ONLY*/
 
 	acpi_lapic = 1;
 
 #endif /*CONFIG_X86_LOCAL_APIC*/
 
 #ifdef CONFIG_X86_IO_APIC
+#ifndef CONFIG_ACPI_HT_ONLY
 
 	/* 
 	 * I/O APIC 
@@ -413,11 +420,14 @@
 
 	acpi_ioapic = 1;
 
+#endif /*!CONFIG_ACPI_HT_ONLY*/
 #endif /*CONFIG_X86_IO_APIC*/
 
 #ifdef CONFIG_X86_LOCAL_APIC


-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

