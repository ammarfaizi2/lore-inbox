Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312279AbSEENcb>; Sun, 5 May 2002 09:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312296AbSEENca>; Sun, 5 May 2002 09:32:30 -0400
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:3804 "EHLO
	pc3-camc5-0-cust13.cam.cable.ntl.com") by vger.kernel.org with ESMTP
	id <S312279AbSEENc1>; Sun, 5 May 2002 09:32:27 -0400
Date: Sun, 5 May 2002 14:29:02 +0100
Message-Id: <200205051329.g45DT2V19004@pc3-camc5-0-cust13.cam.cable.ntl.com>
From: arjan@fenrus.demon.nl
cc: linux-kernel@vger.kernel.org
To: Ken Van Eyndonck <Ken.vaneyndonck@planetinternet.be>
Subject: Re: apm dell I8K 2.4.18
In-Reply-To: <20020505125344.01C4E36BA0@yoda.planetinternet.be>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-31 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020505125344.01C4E36BA0@yoda.planetinternet.be> you wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> hi
> 
> i'm fairly new to linux but i'm eager to learn.
> i'm running suse 7.3 on a dell inspiron 8000.
> i used to run suse 7.1 (2.2.??) and the apm worked "fine" as far as i could 
> tell
> now i cant suspend or un/plug the ac power while linux is running.

for Dell i 8000 laptops 2 things are important:
1) Compile the kernel without IO APIC support
2) Apply the patch below 

with that it works at least for the guy next to me at work ;)



diff -urN Linux/arch/i386/kernel/dmi_scan.c linux/arch/i386/kernel/dmi_scan.c
--- Linux/arch/i386/kernel/dmi_scan.c	Thu Apr 11 11:14:41 2002
+++ linux/arch/i386/kernel/dmi_scan.c	Thu Apr 11 11:15:28 2002
@@ -499,6 +499,22 @@
 }
 
 /*
+ * Dell Inspiron 8000 APM BIOS fails to correctly save and restore the
+ * config space of some PCI devices.
+ */
+
+static __init int broken_apm_pci_restore(struct dmi_blacklist *d)
+{
+#ifdef CONFIG_PCI
+	extern int pci_bridge_force_restore;
+
+	printk(KERN_WARNING "%s detected. Forcing restore of PCI configuration space on APM resume.\n", d->ident);
+	pci_bridge_force_restore = 1;
+#endif
+	return 0;
+}
+
+/*
  *	Process the DMI blacklists
  */
  
@@ -779,6 +795,16 @@
 			MATCH(DMI_SYS_VENDOR, "IBM"),
 			NO_MATCH, NO_MATCH, NO_MATCH
 			} },
+	{ broken_apm_pci_restore, "Dell Inspiron 8000", {	/* Work around broken Dell BIOS */
+			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			MATCH(DMI_PRODUCT_NAME, "Inspiron 8000"),
+			NO_MATCH, NO_MATCH
+			} },
+	{ broken_apm_pci_restore, "Dell Inspiron 8100", {	/* Work around broken Dell BIOS */
+			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			MATCH(DMI_PRODUCT_NAME, "Inspiron 8100"),
+			NO_MATCH, NO_MATCH
+			} },
 
 	{ NULL, }
 };
diff -urN Linux/drivers/pci/Makefile linux/drivers/pci/Makefile
--- Linux/drivers/pci/Makefile	Thu Apr 11 11:14:25 2002
+++ linux/drivers/pci/Makefile	Thu Apr 11 11:15:28 2002
@@ -13,7 +13,7 @@
 
 export-objs := pci.o
 
-obj-$(CONFIG_PCI) += pci.o quirks.o compat.o names.o
+obj-$(CONFIG_PCI) += pci.o quirks.o compat.o names.o bridge.o 
 obj-$(CONFIG_PROC_FS) += proc.o
 
 ifndef CONFIG_SPARC64
diff -urN Linux/drivers/pci/bridge.c linux/drivers/pci/bridge.c
--- Linux/drivers/pci/bridge.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/pci/bridge.c	Thu Apr 11 11:15:28 2002
@@ -0,0 +1,149 @@
+
+/*
+ *	Copyright (c) 2001 Red Hat, Inc. All rights reserved.
+ *
+ *	This software may be freely redistributed under the terms
+ * 	of the GNU public license.
+ * 
+ *	You should have received a copy of the GNU General Public License
+ *	along with this program; if not, write to the Free Software
+ *	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * 	Author: Arjan van de Ven <arjanv@redhat.com>
+ *
+ */
+
+
+/*
+ * Generic PCI driver for PCI bridges for powermanagement purposes
+ *
+ */
+
+#include <linux/config.h> 
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+
+static struct pci_device_id bridge_pci_table[] __devinitdata = {
+        {/* handle all PCI bridges */
+	class:          ((PCI_CLASS_BRIDGE_PCI << 8) | 0x00),
+	class_mask:     ~0,
+	vendor:         PCI_ANY_ID,
+	device:         PCI_ANY_ID,
+	subvendor:      PCI_ANY_ID,
+	subdevice:      PCI_ANY_ID,
+	},
+        {0,},
+};
+
+static int bridge_probe(struct pci_dev *pdev, const struct pci_device_id *id);
+static int pci_bridge_save_state_bus(struct pci_bus *bus, int force);
+int pci_generic_resume_compare(struct pci_dev *pdev);
+
+int pci_bridge_force_restore = 0;
+
+
+
+
+static int __init bridge_setup(char *str)
+{
+	if (!strcmp(str,"force"))
+		pci_bridge_force_restore = 1;
+	else if (!strcmp(str,"noforce"))
+		pci_bridge_force_restore = 0;
+	return 0;
+}
+
+__setup("resume=",bridge_setup);
+
+
+static int pci_bridge_save_state_bus(struct pci_bus *bus, int force)
+{
+	struct list_head *list;
+	int error = 0;
+
+	list_for_each(list, &bus->children) {
+		error = pci_bridge_save_state_bus(pci_bus_b(list),force);
+		if (error) return error;
+	}
+	list_for_each(list, &bus->devices) {
+		pci_generic_suspend_save(pci_dev_b(list),0);
+	}
+	return 0;
+}
+
+
+static int pci_bridge_restore_state_bus(struct pci_bus *bus, int force)
+{
+	struct list_head *list;
+	int error = 0;
+	static int printed_warning=0;
+
+	list_for_each(list, &bus->children) {
+		error = pci_bridge_restore_state_bus(pci_bus_b(list),force);
+		if (error) return error;
+	}
+	list_for_each(list, &bus->devices) {
+		if (force)
+			pci_generic_resume_restore(pci_dev_b(list));
+		else {
+			error = pci_generic_resume_compare(pci_dev_b(list));
+			if (error && !printed_warning++) { 
+				printk(KERN_WARNING "resume warning: bios doesn't restore PCI state properly\n");
+				printk(KERN_WARNING "resume warning: if resume failed, try booting with resume=force\n");
+			}
+			if (error)
+				return error;
+		}
+	}
+	return 0;
+}
+
+static int bridge_suspend(struct pci_dev *dev, u32 force)
+{
+	pci_generic_suspend_save(dev,force);
+	if (dev->subordinate)
+		pci_bridge_save_state_bus(dev->subordinate,force);
+	return 0;
+}
+
+static int bridge_resume(struct pci_dev *dev)
+{
+
+	pci_generic_resume_restore(dev);
+	if (dev->subordinate)
+		pci_bridge_restore_state_bus(dev->subordinate,pci_bridge_force_restore);
+	return 0;
+}
+
+
+MODULE_DEVICE_TABLE(pci, bridge_pci_table);
+static struct pci_driver bridge_ops = {
+        name:           "PCI Bridge",   
+        id_table:       bridge_pci_table,
+        probe:          bridge_probe,    
+        suspend: 	bridge_suspend,
+        resume: 	bridge_resume
+};
+
+static int __devinit bridge_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	return 0;
+}
+
+static int __init bridge_init(void) 
+{
+        pci_register_driver(&bridge_ops);
+        return 0;
+}
+
+static void __exit bridge_exit(void)
+{
+        pci_unregister_driver(&bridge_ops);
+} 
+
+
+module_init(bridge_init)
+module_exit(bridge_exit)
+
diff -urN Linux/drivers/pci/pci.c linux/drivers/pci/pci.c
--- Linux/drivers/pci/pci.c	Thu Apr 11 11:14:40 2002
+++ linux/drivers/pci/pci.c	Thu Apr 11 11:15:28 2002
@@ -357,6 +357,48 @@
 	return 0;
 }
 
+int 
+pci_compare_state(struct pci_dev *dev, u32 *buffer)
+{
+	int i;
+	unsigned int temp;
+
+	if (buffer) {
+		for (i = 0; i < 16; i++) {
+			pci_read_config_dword(dev,i*4,&temp);
+			if (temp!=buffer[i])
+				return 1;
+		}
+	}
+	return 0;
+}
+
+int pci_generic_suspend_save(struct pci_dev *pdev, u32 state)
+{
+	if (pdev)
+		pci_save_state(pdev,pdev->saved_state);
+	return 0;
+}
+
+int pci_generic_resume_restore(struct pci_dev *pdev)
+{
+	if (pdev)
+		pci_restore_state(pdev,pdev->saved_state);
+	return 0;		
+}
+
+int pci_generic_resume_compare(struct pci_dev *pdev)
+{
+	int retval=0;
+	if (pdev)
+		retval = pci_compare_state(pdev,pdev->saved_state);
+	return retval;		
+}
+
+EXPORT_SYMBOL(pci_generic_suspend_save);
+EXPORT_SYMBOL(pci_generic_resume_restore);
+EXPORT_SYMBOL(pci_generic_resume_compare);
+
 /**
  * pci_enable_device - Initialize device before it's used by a driver.
  * @dev: PCI device to be initialized
diff -urN Linux/include/linux/pci.h linux/include/linux/pci.h
--- Linux/include/linux/pci.h	Thu Apr 11 11:14:40 2002
+++ linux/include/linux/pci.h	Thu Apr 11 11:15:28 2002
@@ -378,6 +378,7 @@
 
 	char		name[80];	/* device name */
 	char		slot_name[8];	/* slot name */
+	u32		saved_state[16]; /* for saving the config space before suspend */
 	int		active;		/* ISAPnP: device is active */
 	int		ro;		/* ISAPnP: read only */
 	unsigned short	regs;		/* ISAPnP: supported registers */
@@ -570,6 +571,8 @@
 int pci_restore_state(struct pci_dev *dev, u32 *buffer);
 int pci_set_power_state(struct pci_dev *dev, int state);
 int pci_enable_wake(struct pci_dev *dev, u32 state, int enable);
+int pci_generic_suspend_save(struct pci_dev *pdev, u32 state);
+int pci_generic_resume_restore(struct pci_dev *pdev);
 
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
 
