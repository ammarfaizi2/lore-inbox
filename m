Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267726AbUHEOSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267726AbUHEOSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 10:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267729AbUHEOP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 10:15:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41614 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267726AbUHEOO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 10:14:58 -0400
Date: Thu, 5 Aug 2004 16:14:00 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Automatically enable bigsmp on big HP machines
Message-ID: <20040805141400.GB21161@devserv.devel.redhat.com>
References: <20040805143837.4a6dce7e.ak@suse.de> <1091711039.2790.1.camel@laptop.fenrus.com> <20040805153443.106c8915.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805153443.106c8915.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 03:34:43PM +0200, Andi Kleen wrote:
> On Thu, 05 Aug 2004 15:03:59 +0200
> Arjan van de Ven <arjanv@redhat.com> wrote:
> 
> > On Thu, 2004-08-05 at 14:38, Andi Kleen wrote:
> > > This enables apic=bigsmp automatically on some big HP machines that need it. 
> > > This makes them boot without kernel parameters on a generic arch kernel.
> > 
> > is it possible for this to use the new dmi infrastructure, eg not add it
> > to dmi_scan.c but to the place where it's used ?
> 
> Certainly. Feel free to post a patch for that.

like this:

diff -purN linux-2.6.7/arch/i386/kernel/io_apic.c linux/arch/i386/kernel/io_apic.c
--- linux-2.6.7/arch/i386/kernel/io_apic.c	2004-08-05 15:44:59.833222984 +0200
+++ linux/arch/i386/kernel/io_apic.c	2004-08-05 15:59:03.350832972 +0200
@@ -1714,7 +1714,7 @@ static void __init setup_ioapic_ids_from
 		reg_00.raw = io_apic_read(apic, 0);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 		if (reg_00.bits.ID != mp_ioapics[apic].mpc_apicid)
-			panic("could not set ID!\n");
+			printk("could not set ID!\n");
 		else
 			printk(" ok.\n");
 	}
diff -purN linux-2.6.7/arch/i386/mach-generic/bigsmp.c linux/arch/i386/mach-generic/bigsmp.c
--- linux-2.6.7/arch/i386/mach-generic/bigsmp.c	2004-06-16 07:19:02.000000000 +0200
+++ linux/arch/i386/mach-generic/bigsmp.c	2004-08-05 15:58:37.960789061 +0200
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/init.h>
+#include <linux/dmi.h>
 #include <asm/mach-bigsmp/mach_apic.h>
 #include <asm/mach-bigsmp/mach_apicdef.h>
 #include <asm/mach-bigsmp/mach_ipi.h>
@@ -18,10 +18,35 @@
 #include <asm/mach-bigsmp/mach_ipi.h>
 #include <asm/mach-default/mach_mpparse.h>
 
-int dmi_bigsmp; /* can be set by dmi scanners */
+static int dmi_bigsmp; /* can be set by dmi scanners */
+
+static __init int hp_ht_bigsmp(struct dmi_system_id *d) 
+{ 
+#ifdef CONFIG_X86_GENERICARCH
+	printk(KERN_NOTICE "%s detected: force use of apic=bigsmp\n", d->ident);
+	dmi_bigsmp = 1;
+#endif
+	return 0;
+} 
+
+
+static struct dmi_system_id __initdata bigsmp_dmi_table[] = {
+	{ hp_ht_bigsmp, "HP ProLiant DL760 G2", {
+		DMI_MATCH(DMI_BIOS_VENDOR, "HP"),
+		DMI_MATCH(DMI_BIOS_VERSION, "P44-"),
+	}},
+
+	{ hp_ht_bigsmp, "HP ProLiant DL740", {
+		DMI_MATCH(DMI_BIOS_VENDOR, "HP"),
+		DMI_MATCH(DMI_BIOS_VERSION, "P47-"),
+	 }},
+	 { }	 
+};
+
 
 static __init int probe_bigsmp(void)
 { 
+	dmi_check_system(bigsmp_dmi_table);
 	return dmi_bigsmp; 
 } 
 
