Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVDETkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVDETkO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 15:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVDEThm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 15:37:42 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:18238 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261954AbVDETex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 15:34:53 -0400
Message-ID: <4252E827.4080807@google.com>
Date: Tue, 05 Apr 2005 12:33:59 -0700
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC/Patch 2.6.11] Take control of PCI Master Abort Mode
Content-Type: multipart/mixed;
 boundary="------------060001020209090305090208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060001020209090305090208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Currently Linux 2.6 assumes the BIOS (or firmware) sets the master abort 
mode flag on PCI bridge chips in a coherent fashion.  This is not always 
the case and the consequences of getting this flag incorrect can cause 
hardware to fail or silent data corruption.  This patch lets the user 
override the BIOS master abort setting at boot time and the distro 
maintainer to set a default according to their target audience.

The comments in the patch are probably a bit too verbose, but I think it 
is a good patch to start discussions around.  If it is decided that 
something should be done about this problem, this patch could be 
included in a -mm release and migrate into Linus's kernel as appropriate.

This incarnation of the patch has had minimal testing.  For our internal 
kernels, we always force the master abort mode to 1 and then let the 
device drivers for hardware we know can't handle target aborts switch 
the master abort mode to 0. This does not seem appropriate for general 
release.

Some background for those who do not spend most of their waking hours 
exploring buses and what can go wrong.

The master abort flag tells a PCI bridge what to do when a bus master 
behind the bridge requests the bus and the bridge is unable to get the 
bus.  With the flag clear, for master reads the bridge returns all 
0xff's (hence silent data corruption) and for master writes, it throws 
the data away.  With the bit set, the bridge sends a target abort to the 
master.  This can only happen when the system is heavily loaded.

The problem with always setting the bit is that some PCI hardware, 
notably some Intel E-1000 chips (Ethernet controller: Intel Corporation: 
Unknown device 1076) cannot properly handle the target abort bit.  In 
the case of the E-1000 chip, the driver must reset the chip to recover. 
This usually leads to the machine being off the network for several 
seconds, or sometimes even minutes, which can be bad for servers.

I even have a single motherboard with both a device that cannot handle 
the target abort and an IDE controller that can handle the target abort 
behind the same bridge.  For this motherboard, I have to choose the 
lesser of two evils, network hiccups or potential data corruption.
For the record, I have seen both occur.  Other people may make wish to 
make a different choice than we did, hence this patch allows the user to 
choose the mode at runtime.

	Ross







--------------060001020209090305090208
Content-Type: text/plain;
 name="master-abort.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="master-abort.patch"

diff -ur linux-2.6.11/drivers/pci/Kconfig linux-2.6.11-new/drivers/pci/Kconfig
--- linux-2.6.11/drivers/pci/Kconfig	2005-03-01 23:37:51.000000000 -0800
+++ linux-2.6.11-new/drivers/pci/Kconfig	2005-04-01 07:19:32.000000000 -0800
@@ -47,3 +47,38 @@
 
 	  When in doubt, say Y.
 
+choice
+	prompt "Enable PCI Master Abort Mode"
+	depends on PCI
+	default PCI_MASTER_ABORT_DEFAULT
+	help
+	  On PCI systems, when a bus is unavailable to a bus master, a 
+	  master abort occurs.  Older bridges satisfy the master request
+	  with all 0xFF's.  This can lead to silent data corruption.  Newer
+	  bridges can send a target abort to the bus master.  Some PCI
+	  hardware cannot handle the target abort.  Some x86 BIOSes configure
+          the buses in a suboptimal way.  This option allows you to override
+	  the BIOS setting.  If unsure chose default.  This choice can be
+	  overridden at boot time with the pci_enable_master_abort={default,
+	  enable, disable}
+
+config PCI_MASTER_ABORT_DEFAULT
+	bool "Default"
+	help
+	  Choose this option if you are unsure, or believe your
+	  firmware does the right thing.
+
+config PCI_MASTER_ABORT_ENABLE
+	bool "Enable"
+	help
+	  Choose this option if it is more important for you to prevent
+	  silent data loss than to have more hardware configurations work.
+
+
+config PCI_MASTER_ABORT_DISABLE
+	bool "Disable"
+	help
+	  Choose this option if it is more important for you to have more
+	  hardware configurations work than to prevent silent data loss.
+
+endchoice
diff -ur linux-2.6.11/drivers/pci/probe.c linux-2.6.11-new/drivers/pci/probe.c
--- linux-2.6.11/drivers/pci/probe.c	2005-03-01 23:38:13.000000000 -0800
+++ linux-2.6.11-new/drivers/pci/probe.c	2005-04-05 12:07:53.000000000 -0700
@@ -28,6 +28,15 @@
 
 LIST_HEAD(pci_devices);
 
+/* used to force master abort mode on or off at runtime.
+   PCI_MASTER_ABORT_DEFAULT means leave alone, the BIOS got it correct.
+   PCI_MASTER_ABORT_ENABLE means turn it on everywhere.
+   PCI_MASTER_ABORT_DISABLE means turn it off everywhere.
+*/
+
+static int pci_enable_master_abort=PCI_MASTER_ABORT_VAL;
+
+
 #ifdef HAVE_PCI_LEGACY
 /**
  * pci_create_legacy_files - create legacy I/O port and memory files
@@ -429,6 +438,20 @@
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
 			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 
+	/* Some BIOSes disable master abort mode, even though it's
+	   usually a good thing (prevents silent data corruption).
+	   Unfortunately some hardware (buggy e-1000 chips for
+	   example) require Master Abort Mode to be off, or they will
+	   not function properly. So we enable master abort mode
+	   unless the user told us not to.  The default value
+	   for pci_enable_master_abort is set in the config file,
+	   but can be overridden at setup time. */
+	if (pci_enable_master_abort == PCI_MASTER_ABORT_ENABLE) {
+		bctl |= PCI_BRIDGE_CTL_MASTER_ABORT;
+	} else if (pci_enable_master_abort == PCI_MASTER_ABORT_DISABLE) {
+		bctl &= ~PCI_BRIDGE_CTL_MASTER_ABORT;
+	}
+
 	pci_enable_crs(dev);
 
 	if ((buses & 0xffff00) && !pcibios_assign_all_busses() && !is_cardbus) {
@@ -932,6 +955,22 @@
 	kfree(b);
 	return NULL;
 }
+
+static int __devinit pci_enable_master_abort_setup(char *str)
+{
+	if (strcmp(str, "enable") == 0) {
+		pci_enable_master_abort = PCI_MASTER_ABORT_ENABLE;
+	} else if (strcmp(str, "disable") == 0) {
+		pci_enable_master_abort = PCI_MASTER_ABORT_DISABLE;
+	} else if (strcmp(str, "default") == 0) {
+		pci_enable_master_abort = PCI_MASTER_ABORT_DEFAULT;
+	} else {
+		printk (KERN_ERR "PCI: Unknown Master Abort Mode (%s).", str);
+	}
+}
+
+__setup("pci_enable_master_abort=", pci_enable_master_abort_setup);
+
 EXPORT_SYMBOL(pci_scan_bus_parented);
 
 #ifdef CONFIG_HOTPLUG
diff -ur linux-2.6.11/include/linux/pci.h linux-2.6.11-new/include/linux/pci.h
--- linux-2.6.11/include/linux/pci.h	2005-03-01 23:38:08.000000000 -0800
+++ linux-2.6.11-new/include/linux/pci.h	2005-04-01 07:19:18.000000000 -0800
@@ -1064,5 +1064,17 @@
 #define PCIPCI_VSFX		16
 #define PCIPCI_ALIMAGIK		32
 
+#define PCI_MASTER_ABORT_DEFAULT	0
+#define PCI_MASTER_ABORT_ENABLE		1
+#define PCI_MASTER_ABORT_DISABLE	2
+
+#if defined(CONFIG_PCI_MASTER_ABORT_ENABLE)
+#   define PCI_MASTER_ABORT_VAL PCI_MASTER_ABORT_ENABLE
+#elif defined(CONFIG_PCI_MASTER_ABORT_DISABLE)
+#   define PCI_MASTER_ABORT_VAL PCI_MASTER_ABORT_DISABLE
+#else 
+#   define PCI_MASTER_ABORT_VAL PCI_MASTER_ABORT_DEFAULT
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */

--------------060001020209090305090208--
