Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWCUWLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWCUWLs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWCUWLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:11:48 -0500
Received: from sccrmhc14.comcast.net ([63.240.77.84]:60084 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932297AbWCUWLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:11:46 -0500
Date: Tue, 21 Mar 2006 16:11:43 -0600
From: Corey Minyard <minyard@acm.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] Add generic PCI handling to the IPMI driver
Message-ID: <20060321221143.GA27436@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch modifies the PCI hanling code for the IPMI driver to use
the new method of tables and registering, and adds more generic PCI
handling for IPMI.  Unfortunately, this required a rather large rework
of the way the driver did detection so it would be more event-driven.

 drivers/char/ipmi/ipmi_si_intf.c |  916 ++++++++++++++++++++-------------------
 drivers/char/ipmi/ipmi_si_sm.h   |    3 
 2 files changed, 483 insertions(+), 436 deletions(-)

Index: linux-2.6.16/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_si_intf.c
@@ -52,6 +52,7 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/notifier.h>
+#include <linux/sem.h>
 #include <linux/kthread.h>
 #include <asm/irq.h>
 #ifdef CONFIG_HIGH_RES_TIMERS
@@ -109,6 +110,7 @@ enum si_intf_state {
 enum si_type {
     SI_KCS, SI_SMIC, SI_BT
 };
+static char *si_to_str[] = { "KCS", "SMIC", "BT" };
 
 struct ipmi_device_id {
 	unsigned char device_id;
@@ -147,6 +149,9 @@ struct smi_info
 	int (*irq_setup)(struct smi_info *info);
 	void (*irq_cleanup)(struct smi_info *info);
 	unsigned int io_size;
+	char *addr_source; /* ACPI, PCI, SMBIOS, hardcode, default. */
+	void (*addr_source_cleanup)(struct smi_info *info);
+	void *addr_source_data;
 
 	/* Per-OEM handler, called from handle_flags().
 	   Returns 1 when handle_flags() needs to be re-run
@@ -224,8 +229,12 @@ struct smi_info
 	unsigned long incoming_messages;
 
         struct task_struct *thread;
+
+	struct list_head link;
 };
 
+static int try_smi_init(struct smi_info *smi);
+
 static struct notifier_block *xaction_notifier_list;
 static int register_xaction_notifier(struct notifier_block * nb)
 {
@@ -974,15 +983,12 @@ static struct ipmi_smi_handlers handlers
    a default IO port, and 1 ACPI/SPMI address.  That sets SI_MAX_DRIVERS */
 
 #define SI_MAX_PARMS 4
-#define SI_MAX_DRIVERS ((SI_MAX_PARMS * 2) + 2)
-static struct smi_info *smi_infos[SI_MAX_DRIVERS] =
-{ NULL, NULL, NULL, NULL };
+static LIST_HEAD(smi_infos);
+static DECLARE_MUTEX(smi_infos_lock);
+static int smi_num; /* Used to sequence the SMIs */
 
 #define DEVICE_NAME "ipmi_si"
 
-#define DEFAULT_KCS_IO_PORT	0xca2
-#define DEFAULT_SMIC_IO_PORT	0xca9
-#define DEFAULT_BT_IO_PORT	0xe4
 #define DEFAULT_REGSPACING	1
 
 static int           si_trydefaults = 1;
@@ -1053,32 +1059,17 @@ MODULE_PARM_DESC(slave_addrs, "Set the d
 		 " by interface number.");
 
 
+#define IPMI_IO_ADDR_SPACE  0
 #define IPMI_MEM_ADDR_SPACE 1
-#define IPMI_IO_ADDR_SPACE  2
+static char *addr_space_to_str[] = { "I/O", "memory" };
 
-#if defined(CONFIG_ACPI) || defined(CONFIG_DMI) || defined(CONFIG_PCI)
-static int is_new_interface(int intf, u8 addr_space, unsigned long base_addr)
+static void std_irq_cleanup(struct smi_info *info)
 {
-	int i;
-
-	for (i = 0; i < SI_MAX_PARMS; ++i) {
-		/* Don't check our address. */
-		if (i == intf)
-			continue;
-		if (si_type[i] != NULL) {
-			if ((addr_space == IPMI_MEM_ADDR_SPACE &&
-			     base_addr == addrs[i]) ||
-			    (addr_space == IPMI_IO_ADDR_SPACE &&
-			     base_addr == ports[i]))
-				return 0;
-		}
-		else
-			break;
-	}
-
-	return 1;
+	if (info->si_type == SI_BT)
+		/* Disable the interrupt in the BT interface. */
+		info->io.outputb(&info->io, IPMI_BT_INTMASK_REG, 0);
+	free_irq(info->irq, info);
 }
-#endif
 
 static int std_irq_setup(struct smi_info *info)
 {
@@ -1110,88 +1101,78 @@ static int std_irq_setup(struct smi_info
 		       DEVICE_NAME, info->irq);
 		info->irq = 0;
 	} else {
+		info->irq_cleanup = std_irq_cleanup;
 		printk("  Using irq %d\n", info->irq);
 	}
 
 	return rv;
 }
 
-static void std_irq_cleanup(struct smi_info *info)
-{
-	if (! info->irq)
-		return;
-
-	if (info->si_type == SI_BT)
-		/* Disable the interrupt in the BT interface. */
-		info->io.outputb(&info->io, IPMI_BT_INTMASK_REG, 0);
-	free_irq(info->irq, info);
-}
-
 static unsigned char port_inb(struct si_sm_io *io, unsigned int offset)
 {
-	unsigned int *addr = io->info;
+	unsigned int addr = io->addr_data;
 
-	return inb((*addr)+(offset*io->regspacing));
+	return inb(addr + (offset * io->regspacing));
 }
 
 static void port_outb(struct si_sm_io *io, unsigned int offset,
 		      unsigned char b)
 {
-	unsigned int *addr = io->info;
+	unsigned int addr = io->addr_data;
 
-	outb(b, (*addr)+(offset * io->regspacing));
+	outb(b, addr + (offset * io->regspacing));
 }
 
 static unsigned char port_inw(struct si_sm_io *io, unsigned int offset)
 {
-	unsigned int *addr = io->info;
+	unsigned int addr = io->addr_data;
 
-	return (inw((*addr)+(offset * io->regspacing)) >> io->regshift) & 0xff;
+	return (inw(addr + (offset * io->regspacing)) >> io->regshift) & 0xff;
 }
 
 static void port_outw(struct si_sm_io *io, unsigned int offset,
 		      unsigned char b)
 {
-	unsigned int *addr = io->info;
+	unsigned int addr = io->addr_data;
 
-	outw(b << io->regshift, (*addr)+(offset * io->regspacing));
+	outw(b << io->regshift, addr + (offset * io->regspacing));
 }
 
 static unsigned char port_inl(struct si_sm_io *io, unsigned int offset)
 {
-	unsigned int *addr = io->info;
+	unsigned int addr = io->addr_data;
 
-	return (inl((*addr)+(offset * io->regspacing)) >> io->regshift) & 0xff;
+	return (inl(addr + (offset * io->regspacing)) >> io->regshift) & 0xff;
 }
 
 static void port_outl(struct si_sm_io *io, unsigned int offset,
 		      unsigned char b)
 {
-	unsigned int *addr = io->info;
+	unsigned int addr = io->addr_data;
 
-	outl(b << io->regshift, (*addr)+(offset * io->regspacing));
+	outl(b << io->regshift, addr+(offset * io->regspacing));
 }
 
 static void port_cleanup(struct smi_info *info)
 {
-	unsigned int *addr = info->io.info;
-	int           mapsize;
+	unsigned int addr = info->io.addr_data;
+	int          mapsize;
 
-	if (addr && (*addr)) {
+	if (addr) {
 		mapsize = ((info->io_size * info->io.regspacing)
 			   - (info->io.regspacing - info->io.regsize));
 
-		release_region (*addr, mapsize);
+		release_region (addr, mapsize);
 	}
 	kfree(info);
 }
 
 static int port_setup(struct smi_info *info)
 {
-	unsigned int *addr = info->io.info;
-	int           mapsize;
+	unsigned int addr = info->io.addr_data;
+	int          mapsize;
 
-	if (! addr || (! *addr))
+	if (! addr)
 		return -ENODEV;
 
 	info->io_cleanup = port_cleanup;
@@ -1225,51 +1206,11 @@ static int port_setup(struct smi_info *i
 	mapsize = ((info->io_size * info->io.regspacing)
 		   - (info->io.regspacing - info->io.regsize));
 
-	if (request_region(*addr, mapsize, DEVICE_NAME) == NULL)
+	if (request_region(addr, mapsize, DEVICE_NAME) == NULL)
 		return -EIO;
 	return 0;
 }
 
-static int try_init_port(int intf_num, struct smi_info **new_info)
-{
-	struct smi_info *info;
-
-	if (! ports[intf_num])
-		return -ENODEV;
-
-	if (! is_new_interface(intf_num, IPMI_IO_ADDR_SPACE,
-			      ports[intf_num]))
-		return -ENODEV;
-
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (! info) {
-		printk(KERN_ERR "ipmi_si: Could not allocate SI data (1)\n");
-		return -ENOMEM;
-	}
-	memset(info, 0, sizeof(*info));
-
-	info->io_setup = port_setup;
-	info->io.info = &(ports[intf_num]);
-	info->io.addr = NULL;
-	info->io.regspacing = regspacings[intf_num];
-	if (! info->io.regspacing)
-		info->io.regspacing = DEFAULT_REGSPACING;
-	info->io.regsize = regsizes[intf_num];
-	if (! info->io.regsize)
-		info->io.regsize = DEFAULT_REGSPACING;
-	info->io.regshift = regshifts[intf_num];
-	info->irq = 0;
-	info->irq_setup = NULL;
-	*new_info = info;
-
-	if (si_type[intf_num] == NULL)
-		si_type[intf_num] = "kcs";
-
-	printk("ipmi_si: Trying \"%s\" at I/O port 0x%x\n",
-	       si_type[intf_num], ports[intf_num]);
-	return 0;
-}
-
 static unsigned char intf_mem_inb(struct si_sm_io *io, unsigned int offset)
 {
 	return readb((io->addr)+(offset * io->regspacing));
@@ -1321,7 +1262,7 @@ static void mem_outq(struct si_sm_io *io
 
 static void mem_cleanup(struct smi_info *info)
 {
-	unsigned long *addr = info->io.info;
+	unsigned long addr = info->io.addr_data;
 	int           mapsize;
 
 	if (info->io.addr) {
@@ -1330,17 +1271,17 @@ static void mem_cleanup(struct smi_info 
 		mapsize = ((info->io_size * info->io.regspacing)
 			   - (info->io.regspacing - info->io.regsize));
 
-		release_mem_region(*addr, mapsize);
+		release_mem_region(addr, mapsize);
 	}
 	kfree(info);
 }
 
 static int mem_setup(struct smi_info *info)
 {
-	unsigned long *addr = info->io.info;
+	unsigned long addr = info->io.addr_data;
 	int           mapsize;
 
-	if (! addr || (! *addr))
+	if (! addr)
 		return -ENODEV;
 
 	info->io_cleanup = mem_cleanup;
@@ -1380,58 +1321,85 @@ static int mem_setup(struct smi_info *in
 	mapsize = ((info->io_size * info->io.regspacing)
 		   - (info->io.regspacing - info->io.regsize));
 
-	if (request_mem_region(*addr, mapsize, DEVICE_NAME) == NULL)
+	if (request_mem_region(addr, mapsize, DEVICE_NAME) == NULL)
 		return -EIO;
 
-	info->io.addr = ioremap(*addr, mapsize);
+	info->io.addr = ioremap(addr, mapsize);
 	if (info->io.addr == NULL) {
-		release_mem_region(*addr, mapsize);
+		release_mem_region(addr, mapsize);
 		return -EIO;
 	}
 	return 0;
 }
 
-static int try_init_mem(int intf_num, struct smi_info **new_info)
+
+static __devinit void hardcode_find_bmc(void)
 {
+	int             i;
 	struct smi_info *info;
 
-	if (! addrs[intf_num])
-		return -ENODEV;
+	for (i = 0; i < SI_MAX_PARMS; i++) {
+		if (! ports[i] && ! addrs[i])
+			continue;
 
-	if (! is_new_interface(intf_num, IPMI_MEM_ADDR_SPACE,
-			      addrs[intf_num]))
-		return -ENODEV;
+		info = kmalloc(sizeof(*info), GFP_KERNEL);
+		if (!info)
+			return;
+		memset(info, 0, sizeof(*info));
 
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (! info) {
-		printk(KERN_ERR "ipmi_si: Could not allocate SI data (2)\n");
-		return -ENOMEM;
-	}
-	memset(info, 0, sizeof(*info));
+		info->addr_source = "hardcoded";
 
-	info->io_setup = mem_setup;
-	info->io.info = &addrs[intf_num];
-	info->io.addr = NULL;
-	info->io.regspacing = regspacings[intf_num];
-	if (! info->io.regspacing)
-		info->io.regspacing = DEFAULT_REGSPACING;
-	info->io.regsize = regsizes[intf_num];
-	if (! info->io.regsize)
-		info->io.regsize = DEFAULT_REGSPACING;
-	info->io.regshift = regshifts[intf_num];
-	info->irq = 0;
-	info->irq_setup = NULL;
-	*new_info = info;
+		if (!si_type[i] || strcmp(si_type[i], "kcs") == 0) {
+			info->si_type = SI_KCS;
+		} else if (strcmp(si_type[i], "smic") == 0) {
+			info->si_type = SI_SMIC;
+		} else if (strcmp(si_type[i], "bt") == 0) {
+			info->si_type = SI_BT;
+		} else {
+			printk(KERN_WARNING
+			       "ipmi_si: Interface type specified "
+			       "for interface %d, was invalid: %s\n",
+			       i, si_type[i]);
+			kfree(info);
+			continue;
+		}
+
+		if (ports[i]) {
+			/* An I/O port */
+			info->io_setup = port_setup;
+			info->io.addr_data = ports[i];
+			info->io.addr_type = IPMI_IO_ADDR_SPACE;
+		} else if (addrs[i]) {
+			/* A memory port */
+			info->io_setup = mem_setup;
+			info->io.addr_data = addrs[i];
+			info->io.addr_type = IPMI_MEM_ADDR_SPACE;
+		} else {
+			printk(KERN_WARNING
+			       "ipmi_si: Interface type specified "
+			       "for interface %d, "
+			       "but port and address were not set or "
+			       "set to zero.\n", i);
+			kfree(info);
+			continue;
+		}
 
-	if (si_type[intf_num] == NULL)
-		si_type[intf_num] = "kcs";
+		info->io.addr = NULL;
+		info->io.regspacing = regspacings[i];
+		if (! info->io.regspacing)
+			info->io.regspacing = DEFAULT_REGSPACING;
+		info->io.regsize = regsizes[i];
+		if (! info->io.regsize)
+			info->io.regsize = DEFAULT_REGSPACING;
+		info->io.regshift = regshifts[i];
+		info->irq = irqs[i];
+		if (info->irq)
+			info->irq_setup = std_irq_setup;
 
-	printk("ipmi_si: Trying \"%s\" at memory address 0x%lx\n",
-	       si_type[intf_num], addrs[intf_num]);
-	return 0;
+		try_smi_init(info);
+	}
 }
 
-
 #ifdef CONFIG_ACPI
 
 #include <linux/acpi.h>
@@ -1470,6 +1438,14 @@ static u32 ipmi_acpi_gpe(void *context)
 	return ACPI_INTERRUPT_HANDLED;
 }
 
+static void acpi_gpe_irq_cleanup(struct smi_info *info)
+{
+	if (! info->irq)
+		return;
+
+	acpi_remove_gpe_handler(NULL, info->irq, &ipmi_acpi_gpe);
+}
+
 static int acpi_gpe_irq_setup(struct smi_info *info)
 {
 	acpi_status status;
@@ -1491,19 +1467,12 @@ static int acpi_gpe_irq_setup(struct smi
 		info->irq = 0;
 		return -EINVAL;
 	} else {
+		info->irq_cleanup = acpi_gpe_irq_cleanup;
 		printk("  Using ACPI GPE %d\n", info->irq);
 		return 0;
 	}
 }
 
-static void acpi_gpe_irq_cleanup(struct smi_info *info)
-{
-	if (! info->irq)
-		return;
-
-	acpi_remove_gpe_handler(NULL, info->irq, &ipmi_acpi_gpe);
-}
-
 /*
  * Defined at
  * http://h21007.www2.hp.com/dspp/files/unprotected/devresource/Docs/TechPapers/IA64/hpspmi.pdf
@@ -1546,28 +1515,12 @@ struct SPMITable {
 	s8      spmi_id[1]; /* A '\0' terminated array starts here. */
 };
 
-static int try_init_acpi(int intf_num, struct smi_info **new_info)
+static __devinit int try_init_acpi(struct SPMITable *spmi)
 {
 	struct smi_info  *info;
-	acpi_status      status;
-	struct SPMITable *spmi;
 	char             *io_type;
 	u8 		 addr_space;
 
-	if (acpi_disabled)
-		return -ENODEV;
-
-	if (acpi_failure)
-		return -ENODEV;
-
-	status = acpi_get_firmware_table("SPMI", intf_num+1,
-					 ACPI_LOGICAL_ADDRESSING,
-					 (struct acpi_table_header **) &spmi);
-	if (status != AE_OK) {
-		acpi_failure = 1;
-		return -ENODEV;
-	}
-
 	if (spmi->IPMIlegacy != 1) {
 	    printk(KERN_INFO "IPMI: Bad SPMI legacy %d\n", spmi->IPMIlegacy);
   	    return -ENODEV;
@@ -1577,47 +1530,43 @@ static int try_init_acpi(int intf_num, s
 		addr_space = IPMI_MEM_ADDR_SPACE;
 	else
 		addr_space = IPMI_IO_ADDR_SPACE;
-	if (! is_new_interface(-1, addr_space, spmi->addr.address))
-		return -ENODEV;
+
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (! info) {
+		printk(KERN_ERR "ipmi_si: Could not allocate SI data (3)\n");
+		return -ENOMEM;
+	}
+	memset(info, 0, sizeof(*info));
+
+	info->addr_source = "ACPI";
 
 	/* Figure out the interface type. */
 	switch (spmi->InterfaceType)
 	{
 	case 1:	/* KCS */
-		si_type[intf_num] = "kcs";
+		info->si_type = SI_KCS;
 		break;
-
 	case 2:	/* SMIC */
-		si_type[intf_num] = "smic";
+		info->si_type = SI_SMIC;
 		break;
-
 	case 3:	/* BT */
-		si_type[intf_num] = "bt";
+		info->si_type = SI_BT;
 		break;
-
 	default:
 		printk(KERN_INFO "ipmi_si: Unknown ACPI/SPMI SI type %d\n",
 			spmi->InterfaceType);
+		kfree(info);
 		return -EIO;
 	}
 
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (! info) {
-		printk(KERN_ERR "ipmi_si: Could not allocate SI data (3)\n");
-		return -ENOMEM;
-	}
-	memset(info, 0, sizeof(*info));
-
 	if (spmi->InterruptType & 1) {
 		/* We've got a GPE interrupt. */
 		info->irq = spmi->GPE;
 		info->irq_setup = acpi_gpe_irq_setup;
-		info->irq_cleanup = acpi_gpe_irq_cleanup;
 	} else if (spmi->InterruptType & 2) {
 		/* We've got an APIC/SAPIC interrupt. */
 		info->irq = spmi->GlobalSystemInterrupt;
 		info->irq_setup = std_irq_setup;
-		info->irq_cleanup = std_irq_cleanup;
 	} else {
 		/* Use the default interrupt setting. */
 		info->irq = 0;
@@ -1626,43 +1575,60 @@ static int try_init_acpi(int intf_num, s
 
 	if (spmi->addr.register_bit_width) {
 		/* A (hopefully) properly formed register bit width. */
-		regspacings[intf_num] = spmi->addr.register_bit_width / 8;
 		info->io.regspacing = spmi->addr.register_bit_width / 8;
 	} else {
-		regspacings[intf_num] = DEFAULT_REGSPACING;
 		info->io.regspacing = DEFAULT_REGSPACING;
 	}
-	regsizes[intf_num] = regspacings[intf_num];
-	info->io.regsize = regsizes[intf_num];
-	regshifts[intf_num] = spmi->addr.register_bit_offset;
-	info->io.regshift = regshifts[intf_num];
+	info->io.regsize = info->io.regspacing;
+	info->io.regshift = spmi->addr.register_bit_offset;
 
 	if (spmi->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 		io_type = "memory";
 		info->io_setup = mem_setup;
-		addrs[intf_num] = spmi->addr.address;
-		info->io.info = &(addrs[intf_num]);
+		info->io.addr_type = IPMI_IO_ADDR_SPACE;
 	} else if (spmi->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 		io_type = "I/O";
 		info->io_setup = port_setup;
-		ports[intf_num] = spmi->addr.address;
-		info->io.info = &(ports[intf_num]);
+		info->io.addr_type = IPMI_MEM_ADDR_SPACE;
 	} else {
 		kfree(info);
 		printk("ipmi_si: Unknown ACPI I/O Address type\n");
 		return -EIO;
 	}
+	info->io.addr_data = spmi->addr.address;
 
-	*new_info = info;
+	try_smi_init(info);
 
-	printk("ipmi_si: ACPI/SPMI specifies \"%s\" %s SI @ 0x%lx\n",
-	       si_type[intf_num], io_type, (unsigned long) spmi->addr.address);
 	return 0;
 }
+
+static __devinit void acpi_find_bmc(void)
+{
+	acpi_status      status;
+	struct SPMITable *spmi;
+	int              i;
+
+	if (acpi_disabled)
+		return;
+
+	if (acpi_failure)
+		return;
+
+	for (i = 0; ; i++) {
+		status = acpi_get_firmware_table("SPMI", i+1,
+						 ACPI_LOGICAL_ADDRESSING,
+						 (struct acpi_table_header **)
+						 &spmi);
+		if (status != AE_OK)
+			return;
+
+		try_init_acpi(spmi);
+	}
+}
 #endif
 
 #ifdef CONFIG_DMI
-typedef struct dmi_ipmi_data
+struct dmi_ipmi_data
 {
 	u8   		type;
 	u8   		addr_space;
@@ -1670,49 +1636,46 @@ typedef struct dmi_ipmi_data
 	u8   		irq;
 	u8              offset;
 	u8              slave_addr;
-} dmi_ipmi_data_t;
-
-static dmi_ipmi_data_t dmi_data[SI_MAX_DRIVERS];
-static int dmi_data_entries;
+};
 
-static int __init decode_dmi(struct dmi_header *dm, int intf_num)
+static int __devinit decode_dmi(struct dmi_header *dm,
+				struct dmi_ipmi_data *dmi)
 {
 	u8              *data = (u8 *)dm;
 	unsigned long  	base_addr;
 	u8		reg_spacing;
 	u8              len = dm->length;
-	dmi_ipmi_data_t *ipmi_data = dmi_data+intf_num;
 
-	ipmi_data->type = data[4];
+	dmi->type = data[4];
 
 	memcpy(&base_addr, data+8, sizeof(unsigned long));
 	if (len >= 0x11) {
 		if (base_addr & 1) {
 			/* I/O */
 			base_addr &= 0xFFFE;
-			ipmi_data->addr_space = IPMI_IO_ADDR_SPACE;
+			dmi->addr_space = IPMI_IO_ADDR_SPACE;
 		}
 		else {
 			/* Memory */
-			ipmi_data->addr_space = IPMI_MEM_ADDR_SPACE;
+			dmi->addr_space = IPMI_MEM_ADDR_SPACE;
 		}
 		/* If bit 4 of byte 0x10 is set, then the lsb for the address
 		   is odd. */
-		ipmi_data->base_addr = base_addr | ((data[0x10] & 0x10) >> 4);
+		dmi->base_addr = base_addr | ((data[0x10] & 0x10) >> 4);
 
-		ipmi_data->irq = data[0x11];
+		dmi->irq = data[0x11];
 
 		/* The top two bits of byte 0x10 hold the register spacing. */
 		reg_spacing = (data[0x10] & 0xC0) >> 6;
 		switch(reg_spacing){
 		case 0x00: /* Byte boundaries */
-		    ipmi_data->offset = 1;
+		    dmi->offset = 1;
 		    break;
 		case 0x01: /* 32-bit boundaries */
-		    ipmi_data->offset = 4;
+		    dmi->offset = 4;
 		    break;
 		case 0x02: /* 16-byte boundaries */
-		    ipmi_data->offset = 16;
+		    dmi->offset = 16;
 		    break;
 		default:
 		    /* Some other interface, just ignore it. */
@@ -1726,205 +1689,215 @@ static int __init decode_dmi(struct dmi_
 		 * wrong (and all that I have seen are I/O) so we just
 		 * ignore that bit and assume I/O.  Systems that use
 		 * memory should use the newer spec, anyway. */
-		ipmi_data->base_addr = base_addr & 0xfffe;
-		ipmi_data->addr_space = IPMI_IO_ADDR_SPACE;
-		ipmi_data->offset = 1;
+		dmi->base_addr = base_addr & 0xfffe;
+		dmi->addr_space = IPMI_IO_ADDR_SPACE;
+		dmi->offset = 1;
 	}
 
-	ipmi_data->slave_addr = data[6];
+	dmi->slave_addr = data[6];
 
-	if (is_new_interface(-1, ipmi_data->addr_space,ipmi_data->base_addr)) {
-		dmi_data_entries++;
-		return 0;
-	}
-
-	memset(ipmi_data, 0, sizeof(dmi_ipmi_data_t));
-
-	return -1;
-}
-
-static void __init dmi_find_bmc(void)
-{
-	struct dmi_device *dev = NULL;
-	int               intf_num = 0;
-
-	while ((dev = dmi_find_device(DMI_DEV_TYPE_IPMI, NULL, dev))) {
-		if (intf_num >= SI_MAX_DRIVERS)
-			break;
-
-		decode_dmi((struct dmi_header *) dev->device_data, intf_num++);
-	}
+	return 0;
 }
 
-static int try_init_smbios(int intf_num, struct smi_info **new_info)
+static __devinit void try_init_dmi(struct dmi_ipmi_data *ipmi_data)
 {
 	struct smi_info *info;
-	dmi_ipmi_data_t *ipmi_data = dmi_data+intf_num;
-	char            *io_type;
-
-	if (intf_num >= dmi_data_entries)
-		return -ENODEV;
-
-	switch (ipmi_data->type) {
-		case 0x01: /* KCS */
-			si_type[intf_num] = "kcs";
-			break;
-		case 0x02: /* SMIC */
-			si_type[intf_num] = "smic";
-			break;
-		case 0x03: /* BT */
-			si_type[intf_num] = "bt";
-			break;
-		default:
-			return -EIO;
-	}
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (! info) {
-		printk(KERN_ERR "ipmi_si: Could not allocate SI data (4)\n");
-		return -ENOMEM;
+		printk(KERN_ERR
+		       "ipmi_si: Could not allocate SI data\n");
+		return;
 	}
 	memset(info, 0, sizeof(*info));
 
-	if (ipmi_data->addr_space == 1) {
-		io_type = "memory";
+	info->addr_source = "SMBIOS";
+
+	switch (ipmi_data->type) {
+	case 0x01: /* KCS */
+		info->si_type = SI_KCS;
+		break;
+	case 0x02: /* SMIC */
+		info->si_type = SI_SMIC;
+		break;
+	case 0x03: /* BT */
+		info->si_type = SI_BT;
+		break;
+	default:
+		return;
+	}
+
+	switch (ipmi_data->addr_space) {
+	case IPMI_MEM_ADDR_SPACE:
 		info->io_setup = mem_setup;
-		addrs[intf_num] = ipmi_data->base_addr;
-		info->io.info = &(addrs[intf_num]);
-	} else if (ipmi_data->addr_space == 2) {
-		io_type = "I/O";
+		info->io.addr_type = IPMI_MEM_ADDR_SPACE;
+		break;
+
+	case IPMI_IO_ADDR_SPACE:
 		info->io_setup = port_setup;
-		ports[intf_num] = ipmi_data->base_addr;
-		info->io.info = &(ports[intf_num]);
-	} else {
+		info->io.addr_type = IPMI_IO_ADDR_SPACE;
+		break;
+
+	default:
 		kfree(info);
-		printk("ipmi_si: Unknown SMBIOS I/O Address type.\n");
-		return -EIO;
+		printk(KERN_WARNING
+		       "ipmi_si: Unknown SMBIOS I/O Address type: %d.\n",
+		       ipmi_data->addr_space);
+		return;
 	}
+	info->io.addr_data = ipmi_data->base_addr;
 
-	regspacings[intf_num] = ipmi_data->offset;
-	info->io.regspacing = regspacings[intf_num];
+	info->io.regspacing = ipmi_data->offset;
 	if (! info->io.regspacing)
 		info->io.regspacing = DEFAULT_REGSPACING;
 	info->io.regsize = DEFAULT_REGSPACING;
-	info->io.regshift = regshifts[intf_num];
+	info->io.regshift = 0;
 
 	info->slave_addr = ipmi_data->slave_addr;
 
-	irqs[intf_num] = ipmi_data->irq;
+	info->irq = ipmi_data->irq;
+	if (info->irq)
+		info->irq_setup = std_irq_setup;
+
+	try_smi_init(info);
+}
 
-	*new_info = info;
+static void __devinit dmi_find_bmc(void)
+{
+	struct dmi_device    *dev = NULL;
+	struct dmi_ipmi_data data;
+	int                  rv;
 
-	printk("ipmi_si: Found SMBIOS-specified state machine at %s"
-	       " address 0x%lx, slave address 0x%x\n",
-	       io_type, (unsigned long)ipmi_data->base_addr,
-	       ipmi_data->slave_addr);
-	return 0;
+	while ((dev = dmi_find_device(DMI_DEV_TYPE_IPMI, NULL, dev))) {
+		rv = decode_dmi((struct dmi_header *) dev->device_data, &data);
+		if (!rv)
+			try_init_dmi(&data);
+	}
 }
 #endif /* CONFIG_DMI */
 
 #ifdef CONFIG_PCI
 
-#define PCI_ERMC_CLASSCODE  0x0C0700
+#define PCI_ERMC_CLASSCODE		0x0C0700
+#define PCI_ERMC_CLASSCODE_MASK		0xffffff00
+#define PCI_ERMC_CLASSCODE_TYPE_MASK	0xff
+#define PCI_ERMC_CLASSCODE_TYPE_SMIC	0x00
+#define PCI_ERMC_CLASSCODE_TYPE_KCS	0x01
+#define PCI_ERMC_CLASSCODE_TYPE_BT	0x02
+
 #define PCI_HP_VENDOR_ID    0x103C
 #define PCI_MMC_DEVICE_ID   0x121A
 #define PCI_MMC_ADDR_CW     0x10
 
-/* Avoid more than one attempt to probe pci smic. */
-static int pci_smic_checked = 0;
+static void ipmi_pci_cleanup(struct smi_info *info)
+{
+	struct pci_dev *pdev = info->addr_source_data;
+
+	pci_disable_device(pdev);
+}
 
-static int find_pci_smic(int intf_num, struct smi_info **new_info)
+static int __devinit ipmi_pci_probe(struct pci_dev *pdev,
+				    const struct pci_device_id *ent)
 {
-	struct smi_info  *info;
-	int              error;
-	struct pci_dev   *pci_dev = NULL;
-	u16    		 base_addr;
-	int              fe_rmc = 0;
+	int rv;
+	int class_type = pdev->class & PCI_ERMC_CLASSCODE_TYPE_MASK;
+	struct smi_info *info;
+	int first_reg_offset = 0;
 
-	if (pci_smic_checked)
-		return -ENODEV;
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ENOMEM;
+	memset(info, 0, sizeof(*info));
 
-	pci_smic_checked = 1;
+	info->addr_source = "PCI";
 
-	pci_dev = pci_get_device(PCI_HP_VENDOR_ID, PCI_MMC_DEVICE_ID, NULL);
-	if (! pci_dev) {
-		pci_dev = pci_get_class(PCI_ERMC_CLASSCODE, NULL);
-		if (pci_dev && (pci_dev->subsystem_vendor == PCI_HP_VENDOR_ID))
-			fe_rmc = 1;
-		else
-			return -ENODEV;
-	}
+	switch (class_type) {
+	case PCI_ERMC_CLASSCODE_TYPE_SMIC:
+		info->si_type = SI_SMIC;
+		break;
 
-	error = pci_read_config_word(pci_dev, PCI_MMC_ADDR_CW, &base_addr);
-	if (error)
-	{
-		pci_dev_put(pci_dev);
-		printk(KERN_ERR
-		       "ipmi_si: pci_read_config_word() failed (%d).\n",
-		       error);
-		return -ENODEV;
+	case PCI_ERMC_CLASSCODE_TYPE_KCS:
+		info->si_type = SI_KCS;
+		break;
+
+	case PCI_ERMC_CLASSCODE_TYPE_BT:
+		info->si_type = SI_BT;
+		break;
+
+	default:
+		kfree(info);
+		printk(KERN_INFO "ipmi_si: %s: Unknown IPMI type: %d\n",
+		       pci_name(pdev), class_type);
+		return ENOMEM;
 	}
 
-	/* Bit 0: 1 specifies programmed I/O, 0 specifies memory mapped I/O */
-	if (! (base_addr & 0x0001))
-	{
-		pci_dev_put(pci_dev);
-		printk(KERN_ERR
-		       "ipmi_si: memory mapped I/O not supported for PCI"
-		       " smic.\n");
-		return -ENODEV;
+	rv = pci_enable_device(pdev);
+	if (rv) {
+		printk(KERN_ERR "ipmi_si: %s: couldn't enable PCI device\n",
+		       pci_name(pdev));
+		kfree(info);
+		return rv;
 	}
 
-	base_addr &= 0xFFFE;
-	if (! fe_rmc)
-		/* Data register starts at base address + 1 in eRMC */
-		++base_addr;
+	info->addr_source_cleanup = ipmi_pci_cleanup;
+	info->addr_source_data = pdev;
 
-	if (! is_new_interface(-1, IPMI_IO_ADDR_SPACE, base_addr)) {
-		pci_dev_put(pci_dev);
-		return -ENODEV;
-	}
+	if (pdev->subsystem_vendor == PCI_HP_VENDOR_ID)
+		first_reg_offset = 1;
 
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (! info) {
-		pci_dev_put(pci_dev);
-		printk(KERN_ERR "ipmi_si: Could not allocate SI data (5)\n");
-		return -ENOMEM;
+	if (pci_resource_flags(pdev, 0) & IORESOURCE_IO) {
+		info->io_setup = port_setup;
+		info->io.addr_type = IPMI_IO_ADDR_SPACE;
+	} else {
+		info->io_setup = mem_setup;
+		info->io.addr_type = IPMI_MEM_ADDR_SPACE;
 	}
-	memset(info, 0, sizeof(*info));
+	info->io.addr_data = pci_resource_start(pdev, 0);
 
-	info->io_setup = port_setup;
-	ports[intf_num] = base_addr;
-	info->io.info = &(ports[intf_num]);
-	info->io.regspacing = regspacings[intf_num];
-	if (! info->io.regspacing)
-		info->io.regspacing = DEFAULT_REGSPACING;
+	info->io.regspacing = DEFAULT_REGSPACING;
 	info->io.regsize = DEFAULT_REGSPACING;
-	info->io.regshift = regshifts[intf_num];
+	info->io.regshift = 0;
 
-	*new_info = info;
+	info->irq = pdev->irq;
+	if (info->irq)
+		info->irq_setup = std_irq_setup;
 
-	irqs[intf_num] = pci_dev->irq;
-	si_type[intf_num] = "smic";
+	return try_smi_init(info);
+}
 
-	printk("ipmi_si: Found PCI SMIC at I/O address 0x%lx\n",
-		(long unsigned int) base_addr);
+static void __devexit ipmi_pci_remove(struct pci_dev *pdev)
+{
+}
 
-	pci_dev_put(pci_dev);
+#ifdef CONFIG_PM
+static int ipmi_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+{
 	return 0;
 }
-#endif /* CONFIG_PCI */
 
-static int try_init_plug_and_play(int intf_num, struct smi_info **new_info)
+static int ipmi_pci_resume(struct pci_dev *pdev)
 {
-#ifdef CONFIG_PCI
-	if (find_pci_smic(intf_num, new_info) == 0)
-		return 0;
+	return 0;
+}
 #endif
-	/* Include other methods here. */
 
-	return -ENODEV;
-}
+static struct pci_device_id ipmi_pci_devices[] = {
+	{ PCI_DEVICE(PCI_HP_VENDOR_ID, PCI_MMC_DEVICE_ID) },
+	{ PCI_DEVICE_CLASS(PCI_ERMC_CLASSCODE, PCI_ERMC_CLASSCODE) }
+};
+MODULE_DEVICE_TABLE(pci, ipmi_pci_devices);
+
+static struct pci_driver ipmi_pci_driver = {
+        .name =         DEVICE_NAME,
+        .id_table =     ipmi_pci_devices,
+        .probe =        ipmi_pci_probe,
+        .remove =       __devexit_p(ipmi_pci_remove),
+#ifdef CONFIG_PM
+        .suspend =      ipmi_pci_suspend,
+        .resume =       ipmi_pci_resume,
+#endif
+};
+#endif /* CONFIG_PCI */
 
 
 static int try_get_dev_id(struct smi_info *smi_info)
@@ -2200,62 +2173,111 @@ static inline void wait_for_timer_and_th
 	del_timer_sync(&smi_info->si_timer);
 }
 
-/* Returns 0 if initialized, or negative on an error. */
-static int init_one_smi(int intf_num, struct smi_info **smi)
+struct ipmi_default_vals
 {
-	int		rv;
-	struct smi_info *new_smi;
+	int type;
+	int port;
+} __devinit ipmi_defaults[] =
+{
+	{ .type = SI_KCS, .port = 0xca2 },
+	{ .type = SI_SMIC, .port = 0xca9 },
+	{ .type = SI_BT, .port = 0xe4 },
+	{ .port = 0 }
+};
 
+static __devinit void default_find_bmc(void)
+{
+	struct smi_info *info;
+	int             i;
 
-	rv = try_init_mem(intf_num, &new_smi);
-	if (rv)
-		rv = try_init_port(intf_num, &new_smi);
-#ifdef CONFIG_ACPI
-	if (rv && si_trydefaults)
-		rv = try_init_acpi(intf_num, &new_smi);
-#endif
-#ifdef CONFIG_DMI
-	if (rv && si_trydefaults)
-		rv = try_init_smbios(intf_num, &new_smi);
-#endif
-	if (rv && si_trydefaults)
-		rv = try_init_plug_and_play(intf_num, &new_smi);
+	for (i = 0; ; i++) {
+		if (! ipmi_defaults[i].port)
+			break;
 
-	if (rv)
-		return rv;
+		info = kmalloc(sizeof(*info), GFP_KERNEL);
+		if (!info)
+			return;
+		memset(info, 0, sizeof(*info));
 
-	/* So we know not to free it unless we have allocated one. */
-	new_smi->intf = NULL;
-	new_smi->si_sm = NULL;
-	new_smi->handlers = NULL;
+		info->addr_source = NULL;
 
-	if (! new_smi->irq_setup) {
-		new_smi->irq = irqs[intf_num];
-		new_smi->irq_setup = std_irq_setup;
-		new_smi->irq_cleanup = std_irq_cleanup;
-	}
+		info->si_type = ipmi_defaults[i].type;
+		info->io_setup = port_setup;
+		info->io.addr_data = ipmi_defaults[i].port;
+		info->io.addr_type = IPMI_IO_ADDR_SPACE;
 
-	/* Default to KCS if no type is specified. */
-	if (si_type[intf_num] == NULL) {
-		if (si_trydefaults)
-			si_type[intf_num] = "kcs";
-		else {
-			rv = -EINVAL;
-			goto out_err;
+		info->io.addr = NULL;
+		info->io.regspacing = DEFAULT_REGSPACING;
+		info->io.regsize = DEFAULT_REGSPACING;
+		info->io.regshift = 0;
+
+		if (try_smi_init(info) == 0) {
+			/* Found one... */
+			printk(KERN_INFO "ipmi_si: Found default %s state"
+			       " machine at %s address 0x%lx\n",
+			       si_to_str[info->si_type],
+			       addr_space_to_str[info->io.addr_type],
+			       info->io.addr_data);
+			return;
 		}
 	}
+}
+
+static int is_new_interface(struct smi_info *info)
+{
+	struct smi_info *e;
+
+	list_for_each_entry(e, &smi_infos, link) {
+		if (e->io.addr_type != info->io.addr_type)
+			continue;
+		if (e->io.addr_data == info->io.addr_data)
+			return 0;
+	}
+
+	return 1;
+}
+
+static int try_smi_init(struct smi_info *new_smi)
+{
+	int rv;
+
+	if (new_smi->addr_source) {
+		printk(KERN_INFO "ipmi_si: Trying %s-specified %s state"
+		       " machine at %s address 0x%lx, slave address 0x%x,"
+		       " irq %d\n",
+		       new_smi->addr_source,
+		       si_to_str[new_smi->si_type],
+		       addr_space_to_str[new_smi->io.addr_type],
+		       new_smi->io.addr_data,
+		       new_smi->slave_addr, new_smi->irq);
+	}
 
-	/* Set up the state machine to use. */
-	if (strcmp(si_type[intf_num], "kcs") == 0) {
+	down(&smi_infos_lock);
+	if (! is_new_interface(new_smi)) {
+		printk(KERN_WARNING "ipmi_si: duplicate interface\n");
+		rv = -EBUSY;
+		goto out_err;
+	}
+
+	/* So we know not to free it unless we have allocated one. */
+	new_smi->intf = NULL;
+	new_smi->si_sm = NULL;
+	new_smi->handlers = NULL;
+
+	switch (new_smi->si_type) {
+	case SI_KCS:
 		new_smi->handlers = &kcs_smi_handlers;
-		new_smi->si_type = SI_KCS;
-	} else if (strcmp(si_type[intf_num], "smic") == 0) {
+		break;
+
+	case SI_SMIC:
 		new_smi->handlers = &smic_smi_handlers;
-		new_smi->si_type = SI_SMIC;
-	} else if (strcmp(si_type[intf_num], "bt") == 0) {
+		break;
+
+	case SI_BT:
 		new_smi->handlers = &bt_smi_handlers;
-		new_smi->si_type = SI_BT;
-	} else {
+		break;
+
+	default:
 		/* No support for anything else yet. */
 		rv = -EIO;
 		goto out_err;
@@ -2284,21 +2306,29 @@ static int init_one_smi(int intf_num, st
 
 	/* Do low-level detection first. */
 	if (new_smi->handlers->detect(new_smi->si_sm)) {
+		if (new_smi->addr_source)
+			printk(KERN_INFO "ipmi_si: Interface detection"
+			       " failed\n");
 		rv = -ENODEV;
 		goto out_err;
 	}
 
 	/* Attempt a get device id command.  If it fails, we probably
-           don't have a SMI here. */
+           don't have a BMC here. */
 	rv = try_get_dev_id(new_smi);
-	if (rv)
+	if (rv) {
+		if (new_smi->addr_source)
+			printk(KERN_INFO "ipmi_si: There appears to be no BMC"
+			       " at this location\n");
 		goto out_err;
+	}
 
 	setup_oem_data_handler(new_smi);
 	setup_xaction_handlers(new_smi);
 
 	/* Try to claim any interrupts. */
-	new_smi->irq_setup(new_smi);
+	if (new_smi->irq_setup)
+		new_smi->irq_setup(new_smi);
 
 	INIT_LIST_HEAD(&(new_smi->xmit_msgs));
 	INIT_LIST_HEAD(&(new_smi->hp_xmit_msgs));
@@ -2308,7 +2338,8 @@ static int init_one_smi(int intf_num, st
 
 	new_smi->interrupt_disabled = 0;
 	atomic_set(&new_smi->stop_operation, 0);
-	new_smi->intf_num = intf_num;
+	new_smi->intf_num = smi_num;
+	smi_num++;
 
 	/* Start clearing the flags before we enable interrupts or the
 	   timer to avoid racing with the timer. */
@@ -2365,9 +2396,11 @@ static int init_one_smi(int intf_num, st
 		goto out_err_stop_timer;
 	}
 
-	*smi = new_smi;
+	list_add_tail(&new_smi->link, &smi_infos);
+
+	up(&smi_infos_lock);
 
-	printk(" IPMI %s interface initialized\n", si_type[intf_num]);
+	printk(" IPMI %s interface initialized\n",si_to_str[new_smi->si_type]);
 
 	return 0;
 
@@ -2379,7 +2412,8 @@ static int init_one_smi(int intf_num, st
 	if (new_smi->intf)
 		ipmi_unregister_smi(new_smi->intf);
 
-	new_smi->irq_cleanup(new_smi);
+	if (new_smi->irq_cleanup)
+		new_smi->irq_cleanup(new_smi);
 
 	/* Wait until we know that we are out of any interrupt
 	   handlers might have been running before we freed the
@@ -2391,16 +2425,18 @@ static int init_one_smi(int intf_num, st
 			new_smi->handlers->cleanup(new_smi->si_sm);
 		kfree(new_smi->si_sm);
 	}
+	if (new_smi->addr_source_cleanup)
+		new_smi->addr_source_cleanup(new_smi);
 	if (new_smi->io_cleanup)
 		new_smi->io_cleanup(new_smi);
 
+	up(&smi_infos_lock);
+
 	return rv;
 }
 
-static __init int init_ipmi_si(void)
+static __devinit int init_ipmi_si(void)
 {
-	int  rv = 0;
-	int  pos = 0;
 	int  i;
 	char *str;
 
@@ -2425,49 +2461,48 @@ static __init int init_ipmi_si(void)
 
 	printk(KERN_INFO "IPMI System Interface driver.\n");
 
+	hardcode_find_bmc();
+
 #ifdef CONFIG_DMI
 	dmi_find_bmc();
 #endif
 
-	rv = init_one_smi(0, &(smi_infos[pos]));
-	if (rv && ! ports[0] && si_trydefaults) {
-		/* If we are trying defaults and the initial port is
-                   not set, then set it. */
-		si_type[0] = "kcs";
-		ports[0] = DEFAULT_KCS_IO_PORT;
-		rv = init_one_smi(0, &(smi_infos[pos]));
-		if (rv) {
-			/* No KCS - try SMIC */
-			si_type[0] = "smic";
-			ports[0] = DEFAULT_SMIC_IO_PORT;
-			rv = init_one_smi(0, &(smi_infos[pos]));
-		}
-		if (rv) {
-			/* No SMIC - try BT */
-			si_type[0] = "bt";
-			ports[0] = DEFAULT_BT_IO_PORT;
-			rv = init_one_smi(0, &(smi_infos[pos]));
-		}
-	}
-	if (rv == 0)
-		pos++;
-
-	for (i = 1; i < SI_MAX_PARMS; i++) {
-		rv = init_one_smi(i, &(smi_infos[pos]));
-		if (rv == 0)
-			pos++;
+#ifdef CONFIG_ACPI
+	if (si_trydefaults)
+		acpi_find_bmc();
+#endif
+
+#ifdef CONFIG_PCI
+	pci_module_init(&ipmi_pci_driver);
+#endif
+
+	if (si_trydefaults) {
+		down(&smi_infos_lock);
+		if (list_empty(&smi_infos)) {
+			/* No BMC was found, try defaults. */
+			up(&smi_infos_lock);
+			default_find_bmc();
+		} else {
+			up(&smi_infos_lock);
+		}
 	}
 
-	if (smi_infos[0] == NULL) {
+	down(&smi_infos_lock);
+	if (list_empty(&smi_infos)) {
+		up(&smi_infos_lock);
+#ifdef CONFIG_PCI
+		pci_unregister_driver(&ipmi_pci_driver);
+#endif
 		printk("ipmi_si: Unable to find any System Interface(s)\n");
 		return -ENODEV;
+	} else {
+		up(&smi_infos_lock);
+		return 0;
 	}
-
-	return 0;
 }
 module_init(init_ipmi_si);
 
-static void __exit cleanup_one_si(struct smi_info *to_clean)
+static void __devexit cleanup_one_si(struct smi_info *to_clean)
 {
 	int           rv;
 	unsigned long flags;
@@ -2475,13 +2510,17 @@ static void __exit cleanup_one_si(struct
 	if (! to_clean)
 		return;
 
+	list_del(&to_clean->link);
+
 	/* Tell the timer and interrupt handlers that we are shutting
 	   down. */
 	spin_lock_irqsave(&(to_clean->si_lock), flags);
 	spin_lock(&(to_clean->msg_lock));
 
 	atomic_inc(&to_clean->stop_operation);
-	to_clean->irq_cleanup(to_clean);
+
+	if (to_clean->irq_cleanup)
+		to_clean->irq_cleanup(to_clean);
 
 	spin_unlock(&(to_clean->msg_lock));
 	spin_unlock_irqrestore(&(to_clean->si_lock), flags);
@@ -2511,20 +2550,27 @@ static void __exit cleanup_one_si(struct
 
 	kfree(to_clean->si_sm);
 
+	if (to_clean->addr_source_cleanup)
+		to_clean->addr_source_cleanup(to_clean);
 	if (to_clean->io_cleanup)
 		to_clean->io_cleanup(to_clean);
 }
 
 static __exit void cleanup_ipmi_si(void)
 {
-	int i;
+	struct smi_info *e, *tmp_e;
 
 	if (! initialized)
 		return;
 
-	for (i = 0; i < SI_MAX_DRIVERS; i++) {
-		cleanup_one_si(smi_infos[i]);
-	}
+#ifdef CONFIG_PCI
+	pci_unregister_driver(&ipmi_pci_driver);
+#endif
+
+	down(&smi_infos_lock);
+	list_for_each_entry_safe(e, tmp_e, &smi_infos, link)
+		cleanup_one_si(e);
+	up(&smi_infos_lock);
 }
 module_exit(cleanup_ipmi_si);
 
Index: linux-2.6.16/drivers/char/ipmi/ipmi_si_sm.h
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_si_sm.h
+++ linux-2.6.16/drivers/char/ipmi/ipmi_si_sm.h
@@ -50,11 +50,12 @@ struct si_sm_io
 
 	/* Generic info used by the actual handling routines, the
            state machine shouldn't touch these. */
-	void *info;
 	void __iomem *addr;
 	int  regspacing;
 	int  regsize;
 	int  regshift;
+	int addr_type;
+	long addr_data;
 };
 
 /* Results of SMI events. */
