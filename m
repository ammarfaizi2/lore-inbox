Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269262AbTGJNS3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 09:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269265AbTGJNS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 09:18:29 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:31208 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP id S269262AbTGJNSZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 09:18:25 -0400
Subject: Re: undefined reference to `xapic_support`
From: Steven Cole <elenstev@mesatop.com>
To: Geller Sandor <wildy@petra.hos.u-szeged.hu>
Cc: Max Valdez <maxvalde@fis.unam.mx>, "Martin J. Bligh" <mbligh@aracnet.com>,
       kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307101216170.30460-100000@petra.hos.u-szeged.hu>
References: <Pine.LNX.4.44.0307101216170.30460-100000@petra.hos.u-szeged.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1057843925.8754.104.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 10 Jul 2003 07:32:06 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-10 at 04:17, Geller Sandor wrote:
> On 9 Jul 2003, Max Valdez wrote:
> 
> > No, i dont need that, i tried it to see if it corrected the problem, but
> > didnt
> >
> > :-)
> > Max
> > On Wed, 2003-07-09 at 00:52, Martin J. Bligh wrote:
> > > >> CONFIG_X86_CLUSTERED_APIC=y
> > >
> > > Why? Do you really need this?
> 
> IO_APIC is broken in 2.4.22-pre3-ac1. So you cannot compile SMP kernels,
> or UP kernels with IO_APIC support.
> 
>   Geller Sandor <wildy@petra.hos.u-szeged.hu>

It's not broken if you fix it, or at least put a band-aid on it.  For
the quick and dirty, see my post here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105760102522650&w=2

For a possibly more correct fix, Adrian Bunk pointed out that the
mpparse.c updates in .21-ac4 somehow wandered off, so here is a patch
which makes the mpparse.c file exactly like the one in 21-ac4. It
compiles, it boots, it runs.. wheee.

Note that the antepenultimate hunk in this patch may revert something it
shouldn't.  Otherwise, it looks fine.

[steven@spc5 linux-2.4.22-pre3-ac1]$ grep APIC .config
CONFIG_X86_GOOD_APIC=y
# CONFIG_X86_CLUSTERED_APIC is not set
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y

Oh yeah, you might want to check the archives a little more closely next
time.  Other folks saw this too.

Steven

--- linux-2.4.22-pre3-ac1/arch/i386/kernel/mpparse.c.ac1	Mon Jul  7 14:54:29 2003
+++ linux-2.4.22-pre3-ac1/arch/i386/kernel/mpparse.c	Mon Jul  7 15:01:43 2003
@@ -78,6 +78,7 @@
 unsigned char clustered_apic_mode = CLUSTERED_APIC_NONE;
 unsigned int apic_broadcast_id = APIC_BROADCAST_ID_APIC;
 #endif
+unsigned int xapic_support = 0;
 unsigned char raw_phys_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 
 /*
@@ -238,6 +239,8 @@
 		return;
 	}
 	ver = m->mpc_apicver;
+	if (APIC_XAPIC_SUPPORT(ver))
+		xapic_support = 1;
 
 	logical_cpu_present_map |= 1 << (num_processors-1);
  	phys_cpu_present_map |= apicid_to_phys_cpu_present(m->mpc_apicid);
@@ -516,7 +519,7 @@
 	mp_bus_id_to_local = (int *)&bus_data[(max_mp_busses * sizeof(int)) * 2];
 	mp_bus_id_to_pci_bus = (int *)&bus_data[(max_mp_busses * sizeof(int)) * 3];
 	mp_irqs = (struct mpc_config_intsrc *)&bus_data[(max_mp_busses * sizeof(int)) * 4];
-	memset(mp_bus_id_to_pci_bus, -1, max_mp_busses);
+	memset(mp_bus_id_to_pci_bus, -1, max_mp_busses * sizeof(int));
 
 	/*
 	 *	Now process the configuration blocks.
@@ -587,15 +590,6 @@
 	}
 
 
-	printk("Enabling APIC mode: ");
-	if(clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
-		printk("Clustered Logical.	");
-	else if(clustered_apic_mode == CLUSTERED_APIC_XAPIC)
-		printk("Physical.	");
-	else
-		printk("Flat.	");
-	printk("Using %d I/O APICs\n",nr_ioapics);
-
 	if (!num_processors)
 		printk(KERN_ERR "SMP mptable: no processors registered!\n");
 	return num_processors;
@@ -831,6 +825,34 @@
 		BUG();
 
 	printk("Processors: %d\n", num_processors);
+	printk("xAPIC support %s present\n", (xapic_support?"is":"is not"));
+
+#ifdef CONFIG_X86_CLUSTERED_APIC
+	/*
+	 * Switch to Physical destination mode in case of generic
+	 * more than 8 CPU system, which has xAPIC support
+	 */
+#define FLAT_APIC_CPU_MAX	8
+	if ((clustered_apic_mode == CLUSTERED_APIC_NONE) &&
+	    (xapic_support) &&
+	    (num_processors > FLAT_APIC_CPU_MAX)) {
+		clustered_apic_mode = CLUSTERED_APIC_XAPIC;
+		apic_broadcast_id = APIC_BROADCAST_ID_XAPIC;
+		int_dest_addr_mode = APIC_DEST_PHYSICAL;
+		int_delivery_mode = dest_Fixed;
+		esr_disable = 1;
+	}
+#endif
+
+	printk("Enabling APIC mode: ");
+	if (clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
+		printk("Clustered Logical.	");
+	else if (clustered_apic_mode == CLUSTERED_APIC_XAPIC)
+		printk("Physical.	");
+	else
+		printk("Flat.	");
+	printk("Using %d I/O APICs\n",nr_ioapics);
+
 	/*
 	 * Only use the first configuration found.
 	 */
@@ -977,14 +999,7 @@
 
 	processor.mpc_type = MP_PROCESSOR;
 	processor.mpc_apicid = id;
-
-	/*
-	 * mp_register_lapic_address() which is called before the
-	 * current function does the fixmap of FIX_APIC_BASE.
-	 * Read in the correct APIC version from there
-	 */
-	processor.mpc_apicver = apic_read(APIC_LVR);
-	
+	processor.mpc_apicver = 0x10; /* TBD: lapic version */
 	processor.mpc_cpuflag = (enabled ? CPU_ENABLED : 0);
 	processor.mpc_cpuflag |= (boot_cpu ? CPU_BOOTPROCESSOR : 0);
 	processor.mpc_cpufeature = (boot_cpu_data.x86 << 8) | 
@@ -1205,6 +1220,8 @@
 	}
 }
 
+#ifndef CONFIG_ACPI_HT_ONLY
+
 /* Ensure the ACPI SCI interrupt level is active low, edge-triggered */
 
 extern FADT_DESCRIPTOR acpi_fadt;
@@ -1259,6 +1276,8 @@
 	io_apic_set_pci_routing(ioapic, ioapic_pin, irq);
 }
 
+#endif /*CONFIG_ACPI_HT_ONLY*/
+
 #ifdef CONFIG_ACPI_PCI
 
 void __init mp_parse_prt (void)







