Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbTENPMc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 11:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbTENPMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 11:12:32 -0400
Received: from fmr03.intel.com ([143.183.121.5]:42176 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262470AbTENPKs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 11:10:48 -0400
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E50241361D9@orsmsx404.jf.intel.com>
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: linux-kernel@vger.kernel.org
Cc: "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>
Subject: RFC Proposal to enable MSI support in Linux kernel
Date: Wed, 14 May 2003 08:22:36 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RFC Proposal to enable MSI support in Linux kernel
MSI (Message Signaled Interrupt) is an optional interrupt generation
mechanism to enable any PCI/PCI-X/PCI Express device, which supports MSI by
implementing the MSI/MSI-X capability structure in its PCI capability list,
to request for service by sending an inbound Memory Write on its PCI bus.
Programming the inbound Memory Write to bypass the legacy IOxAPIC provides
some key advantages over the existing IRQ pin assertion: 1) requiring no
BIOS IRQ routing table support, 2) enabling the hardware devices to send
multiple interrupt messages on the PCI bus, and 3) last but not least,
enabling the PCI Express technology, which requires MSI support. As a
result, we propose MSI support, which is not currently available, in Linux
kernel.
The proposed MSI support in Linux kernel serves three main goals. First,
ensuring simultaneous support for APIC/SAPIC and MSI is achievable by
reserving all pre-assigned IOxAPIC vectors and configuring message data and
message address of the device's MSI/MSI-X capability structure to bypass the
legacy IOxAPIC. Second, enabling a vector-based indexing to replace the
existing IRQ-based indexing to support MSI is legacy-compatible. Last but
not least, providing MSI support to any MSI-capable devices is compatible
with all existing device drivers. Since the existing Linux kernel assigns
vectors in a non-contiguous fashion, configuring the MSI capability
structure with multiple messages is impossible. As a result, the patch
proposes a single message support for the MSI capability structure but
multiple messages support for the MSI-X capability structure. By default,
each MSI-capable device is enabled with a single message to comply with
legacy-compatibility. The patch proposes the device driver to call proposed
APIs below to request for additional messages. 
int msi_alloc_vectors(void* dev_id, int *vector, int nvec) // request one or
more additional MSI(s) 
int msi_free_vectors(void* dev_id, int *vector, int nvec) // release one or
more MSI(s)
A kernel-configured parameter CONFIG_MSI_USE_VECTOR is proposed to provide
users a choice of whether enabling MSI support at kernel built time or not.
Enabling MSI support requires users to set this parameter during
kernel-built time. In addition to this parameter, two other boot parameters,
pci_nomsi and device_nomsi=[HW], be also provided to allow users to disable
MSI system-wide or function-wide to serve as a debug purpose unless
CONFIG_MSI_USE_VECTOR is not configured at kernel-built time. Users can use
the lilo-appended line: append = "pci_nomsi" to disable the PCI subsystem at
system-wide from forcing all MSI-capable functions to use MSI mechanism or
the lilo-appended line: append = "device_nomsi=DeviceIDVendorID, etc ..." to
select a list of individual functions requesting no MSI support.
DeviceIDVendorID should be listed as hex number without prefix 0x.
The attached patch, based on Linux kernel 2.5.65, has been tested on the
SE7500WV2 system with a slot-populated Adaptec AIC79XX PCI-X SCSI HBA
DRIVER, Rev 1.0.0 <Adaptec 39320D Ultra320 SCSI adapter (aic7902)>, which
implements the MSI capability structure. This patch works with the following
configurations: CONFIG_MSI_USE_VECTOR set and CONFIG_ACPI_BOOT either set or
cleared to ensure the system working with both ACPI and non-ACPI
environments. 
The MSI patch for the proposed MSI support in Linux is attached. Any
suggestions, feedback, comments or alternative designs are welcome." 
Thanks
Email: tom.l.nguyen@intel.com
------------------------------------------
diff -X excludes -urN linux-2.5.65/arch/i386/Kconfig
2.5.65-create-vec-patch/arch/i386/Kconfig
--- linux-2.5.65/arch/i386/Kconfig      2003-03-17 16:43:43.000000000 -0500
+++ 2.5.65-create-vec-patch/arch/i386/Kconfig      2003-05-12
11:38:06.000000000 -0400
@@ -1050,6 +1050,22 @@
        This support is also available as a module.  If compiled as a
        module, it will be called scx200.
 
+config MSI_USE_VECTOR
+     bool "MSI_USE_VECTOR"
+      default n
+     help
+        MSI means Message Signaled Interrupt, which allows any MSI-capable
+        hardware device to send an inbound Memory Write on its PCI bus
+        instead of asserting IRQ signal on device IRQ pin.
+
+        This provides PCI MSI support. Enabling PCI MSI support requires 
+        users to set this parameter. Once this is set, the PCI subsystem 
+        replaces an existing IRQ-based indexing with a vector-based
indexing
+        to support MSI.
+
+        If you don't know what MSI is or enabling MSI does not serve you 
+        any goods, say N.
+
 source "drivers/pci/Kconfig"
 
 config ISA
diff -X excludes -urN linux-2.5.65/arch/i386/kernel/i386_ksyms.c
2.5.65-create-vec-patch/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.65/arch/i386/kernel/i386_ksyms.c      2003-03-17
16:44:50.000000000 -0500
+++ 2.5.65-create-vec-patch/arch/i386/kernel/i386_ksyms.c      2003-05-09
15:03:01.000000000 -0400
@@ -171,6 +171,13 @@
 EXPORT_SYMBOL(IO_APIC_get_PCI_irq_vector);
 #endif
 
+#ifdef CONFIG_MSI_USE_VECTOR
+EXPORT_SYMBOL(msi_get_pci_irq_vector);
+EXPORT_SYMBOL(msi_alloc_vectors);
+EXPORT_SYMBOL(msi_free_vectors);
+EXPORT_SYMBOL(remove_hotplug_vectors);
+#endif
+
 #ifdef CONFIG_MCA
 EXPORT_SYMBOL(machine_id);
 #endif
diff -X excludes -urN linux-2.5.65/arch/i386/kernel/i8259.c
2.5.65-create-vec-patch/arch/i386/kernel/i8259.c
--- linux-2.5.65/arch/i386/kernel/i8259.c      2003-03-17 16:44:44.000000000
-0500
+++ 2.5.65-create-vec-patch/arch/i386/kernel/i8259.c      2003-05-01
15:17:28.000000000 -0400
@@ -415,7 +415,11 @@
       * us. (some of these will be overridden and become
       * 'special' SMP interrupts)
       */
+#ifdef CONFIG_MSI_USE_VECTOR
+     for (i = 0; i < (NR_VECTORS - FIRST_EXTERNAL_VECTOR); i++) {
+#else
      for (i = 0; i < NR_IRQS; i++) {
+#endif
            int vector = FIRST_EXTERNAL_VECTOR + i;
            if (vector != SYSCALL_VECTOR) 
                  set_intr_gate(vector, interrupt[i]);
diff -X excludes -urN linux-2.5.65/arch/i386/kernel/io_apic.c
2.5.65-create-vec-patch/arch/i386/kernel/io_apic.c
--- linux-2.5.65/arch/i386/kernel/io_apic.c      2003-03-17
16:44:02.000000000 -0500
+++ 2.5.65-create-vec-patch/arch/i386/kernel/io_apic.c      2003-05-12
11:35:29.000000000 -0400
@@ -116,11 +116,25 @@
      }
 }
 
+#ifdef CONFIG_MSI_USE_VECTOR
+int vector_irq[NR_IRQS] = { [0 ... NR_IRQS -1] = -1};
+
+static int platform_irq(int vector)       
+{    
+     if (platform_legacy_irq(vector))
+           return vector;
+     else
+           return vector_irq[vector];
+}
+#else
+#define platform_irq(irq)       (irq)
+#endif 
+
 #define __DO_ACTION(R, ACTION, FINAL)                              \
                                                      \
 {                                                    \
      int pin;                                      \
-     struct irq_pin_list *entry = irq_2_pin + irq;              \
+     struct irq_pin_list *entry = irq_2_pin + platform_irq(irq);      \
                                                      \
      for (;;) {                                          \
            unsigned int reg;                         \
@@ -346,6 +360,11 @@
                  /* Is this an active IRQ? */
                  if (!irq_desc[j].action)
                        continue;
+#ifdef CONFIG_MSI_USE_VECTOR
+                 /* Is this an active MSI? */
+                 if (msi_desc[j])
+                       continue;
+#endif
                  if ( package_index == i )
                        IRQ_DELTA(package_index,j) = 0;
                  /* Determine the total count per processor per IRQ */
@@ -1021,6 +1040,7 @@
 
 int irq_vector[NR_IRQS] = { FIRST_DEVICE_VECTOR , 0 };
 
+#ifndef CONFIG_MSI_USE_VECTOR
 static int __init assign_irq_vector(int irq)
 {
      static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
@@ -1042,10 +1062,39 @@
       IO_APIC_VECTOR(irq) = current_vector;
      return current_vector;
 }
+#else
+extern int assign_irq_vector(int irq);
+#endif
 
 static struct hw_interrupt_type ioapic_level_irq_type;
 static struct hw_interrupt_type ioapic_edge_irq_type;
 
+#define IOAPIC_AUTO      -1
+#define IOAPIC_EDGE      0
+#define IOAPIC_LEVEL      1
+
+static inline void ioapic_register_intr(int irq, int vector, unsigned long
trigger)
+{
+#ifdef CONFIG_MSI_USE_VECTOR
+     if (!platform_legacy_irq(irq)) {
+           if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
+               trigger == IOAPIC_LEVEL)
+                 irq_desc[vector].handler = &ioapic_level_irq_type;
+           else
+                 irq_desc[vector].handler = &ioapic_edge_irq_type;
+           set_intr_gate(vector, interrupt[vector]);
+     } else 
+#endif
+     {
+           if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
+                 trigger == IOAPIC_LEVEL)
+                 irq_desc[irq].handler = &ioapic_level_irq_type;
+           else
+                 irq_desc[irq].handler = &ioapic_edge_irq_type;
+           set_intr_gate(vector, interrupt[irq]);
+     }
+}
+
 void __init setup_IO_APIC_irqs(void)
 {
      struct IO_APIC_route_entry entry;
@@ -1101,13 +1150,7 @@
            if (IO_APIC_IRQ(irq)) {
                  vector = assign_irq_vector(irq);
                  entry.vector = vector;
-
-                 if (IO_APIC_irq_trigger(irq))
-                       irq_desc[irq].handler = &ioapic_level_irq_type;
-                 else
-                       irq_desc[irq].handler = &ioapic_edge_irq_type;
-
-                 set_intr_gate(vector, interrupt[irq]);
+                 ioapic_register_intr(irq, vector, IOAPIC_AUTO);
            
                  if (!apic && (irq < 16))
                        disable_8259A_irq(irq);
@@ -1711,7 +1754,13 @@
  * operation to prevent an edge-triggered interrupt escaping meanwhile.
  * The idea is from Manfred Spraul.  --macro
  */
+#ifdef CONFIG_MSI_USE_VECTOR
+     if (!platform_legacy_irq(irq))         /* it's already the vector */
+           i = IO_APIC_VECTOR(vector_irq[irq]);
+     else
+#endif
      i = IO_APIC_VECTOR(irq);
+
      v = apic_read(APIC_TMR + ((i & ~0x1f) >> 1));
 
       ack_APIC_irq();
@@ -1795,7 +1844,15 @@
       * 0x80, because int 0x80 is hm, kind of importantish. ;)
       */
      for (irq = 0; irq < NR_IRQS ; irq++) {
+#ifdef CONFIG_MSI_USE_VECTOR
+           int tmp;
+           tmp = platform_irq(irq);
+           if (tmp == -1)
+                 continue;
+           if (IO_APIC_IRQ(tmp) && !IO_APIC_VECTOR(tmp)) {
+#else
            if (IO_APIC_IRQ(irq) && !IO_APIC_VECTOR(irq)) {
+#endif
                  /*
                   * Hmm.. We don't have an entry for this,
                   * so default to an old-fashioned 8259
@@ -2074,6 +2131,16 @@
       print_IO_APIC();
 }
 
+void restore_ioapic_irq_handler(int irq)
+{
+      spin_lock(&irq_desc[irq].lock);
+     if (IO_APIC_irq_trigger(irq))
+           irq_desc[irq].handler = &ioapic_level_irq_type;
+     else
+           irq_desc[irq].handler = &ioapic_edge_irq_type;
+      spin_unlock(&irq_desc[irq].lock);
+}
+
 /*
  *   Called after all the initialization is done. If we didnt find any
  *   APIC bugs then we can allow the modify fast path
@@ -2226,9 +2293,7 @@
            "IRQ %d)\n", ioapic, 
            mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq);
 
-      irq_desc[irq].handler = &ioapic_level_irq_type;
-
-      set_intr_gate(entry.vector, interrupt[irq]);
+      ioapic_register_intr(irq, entry.vector, IOAPIC_LEVEL);
 
      if (!ioapic && (irq < 16))
            disable_8259A_irq(irq);
diff -X excludes -urN linux-2.5.65/arch/i386/kernel/Makefile
2.5.65-create-vec-patch/arch/i386/kernel/Makefile
--- linux-2.5.65/arch/i386/kernel/Makefile      2003-03-17
16:43:44.000000000 -0500
+++ 2.5.65-create-vec-patch/arch/i386/kernel/Makefile      2003-04-18
08:08:59.000000000 -0400
@@ -29,6 +29,7 @@
 obj-$(CONFIG_MODULES)       += module.o
 obj-y                        += sysenter.o
 obj-$(CONFIG_ACPI_SRAT)       += srat.o
+obj-$(CONFIG_MSI_USE_VECTOR)      += pci_msi.o
 
 EXTRA_AFLAGS   := -traditional
 
diff -X excludes -urN linux-2.5.65/arch/i386/kernel/mpparse.c
2.5.65-create-vec-patch/arch/i386/kernel/mpparse.c
--- linux-2.5.65/arch/i386/kernel/mpparse.c      2003-03-17
16:43:50.000000000 -0500
+++ 2.5.65-create-vec-patch/arch/i386/kernel/mpparse.c      2003-04-18
07:55:06.000000000 -0400
@@ -1099,6 +1099,11 @@
            if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
                  printk(KERN_DEBUG "Pin %d-%d already programmed\n",
                        mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
+#ifdef CONFIG_MSI_USE_VECTOR
+                 if (!platform_legacy_irq(irq))
+                       entry->irq = IO_APIC_VECTOR(irq);
+                 else
+#endif
                  entry->irq = irq;
                  continue;
            }
@@ -1106,6 +1111,11 @@
            mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
 
            if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq))
+#ifdef CONFIG_MSI_USE_VECTOR
+                 if (!platform_legacy_irq(irq))
+                       entry->irq = IO_APIC_VECTOR(irq);
+                 else
+#endif
                  entry->irq = irq;
 
            printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
diff -X excludes -urN linux-2.5.65/arch/i386/kernel/pci_msi.c
2.5.65-create-vec-patch/arch/i386/kernel/pci_msi.c
--- linux-2.5.65/arch/i386/kernel/pci_msi.c      1969-12-31
19:00:00.000000000 -0500
+++ 2.5.65-create-vec-patch/arch/i386/kernel/pci_msi.c      2003-05-13
12:07:50.000000000 -0400
@@ -0,0 +1,868 @@
+/*
+ * linux/arch/i386/kernel/pci_msi.c
+ */
+
+#include <linux/mm.h>
+#include <linux/irq.h>           
+#include <linux/interrupt.h>
+#include <linux/init.h>          
+#include <linux/config.h>        
+#include <linux/ioport.h>       
+#include <linux/smp_lock.h>
+#include <linux/pci.h>
+#include <linux/proc_fs.h>
+#include <linux/acpi.h>
+
+#include <asm/errno.h>
+#include <asm/io.h>        
+#include <asm/smp.h>
+#include <asm/desc.h>            
+#include <mach_apic.h>
+
+#include <linux/pci_msi.h>
+
+_DEFINE_DBG_BUFFER
+
+static spinlock_t msi_lock = SPIN_LOCK_UNLOCKED;
+struct msi_desc_t* msi_desc[NR_IRQS] = { [0 ... NR_IRQS-1] = NULL };
+
+int pci_msi_enable = 1;
+static int nr_alloc_vectors = 0;
+static int nr_released_vectors = 0;
+
+static int __init pci_msi_clear(char *str)
+{
+      pci_msi_enable = 0;
+     return 1;
+}
+__setup("pci_nomsi", pci_msi_clear);
+
+/**
+ * create_device_nomsi_list - create a list of devices with MSI disabled
+ * argument: none
+ *
+ * description: provide a temperary workaround for a PCI/PCI-X/PCI Express 
+ * hardware device, which may require IHV investigation if there is an
issue. 
+ * It would be a good idea not to force MSI at device level, unless 
+ * system-wide boot parameter CONFIG_MSI_USE_VECTOR is disabled. 
+ * A boot parameter device_nomsi=[HW] can be used for this purpose, where
+ * [HW] is a list of devices requesting for MSI disabled at device level
+ * (apply only for MSI-capable devices).
+ **/
+u32 device_nomsi_list[DRIVER_NOMSI_MAX] = {0, };
+static int __init create_device_nomsi_list(char *str)
+{
+     int i;
+     
+     str =
get_options(str,ARRAY_SIZE(device_nomsi_list),device_nomsi_list);
+     if (!device_nomsi_list[0])  /* first item contains number of entries
*/
+           return 0;
+
+     for (i = 1;i < device_nomsi_list[0]; i++) 
+           printk(KERN_INFO "User requests no MSI for dev (D%04x-V%04x)\n",
+           (device_nomsi_list[i] >> 16), device_nomsi_list[i] & 0xffff);
+
+     return 1;
+}
+__setup("device_nomsi=", create_device_nomsi_list);
+
+static int is_msi_support_for_this_device(struct pci_dev *dev)
+{
+     int         i, enabling_msi = 1; 
+     u32         did_vid;
+
+     if (!device_nomsi_list[0]) /* number of drivers requested for no MSI
*/
+           return (enabling_msi);
+
+      did_vid = (dev->device << 16) | dev->vendor;
+
+     for (i = 1;i < device_nomsi_list[0]; i++) {
+           if (device_nomsi_list[i] == did_vid) {
+                 enabling_msi = 0; 
+                 break;
+           }
+     }
+
+     return (enabling_msi);
+}
+
+static void msi_set_mask_bit(unsigned int irq, int flag)
+{
+     struct msi_desc_t *entry;
+     
+     entry = (struct msi_desc_t *)msi_desc[irq];
+     if (!entry || !entry->dev || !entry->mask_entry_addr)
+           return;
+     switch (entry->msi_attrib.type) {
+     case PCI_CAP_ID_MSI:
+     {
+           int         pos;
+           unsigned int      mask_bits;
+           pos = *(int *)entry->mask_entry_addr;
+             entry->dev->bus->ops->read(entry->dev->bus, entry->dev->devfn,

+                       pos, 4, &mask_bits);
+           mask_bits &= ~(1);
+           mask_bits |= flag;
+             entry->dev->bus->ops->write(entry->dev->bus,
entry->dev->devfn, 
+                       pos, 4, mask_bits);
+           break;
+     }
+     case PCI_CAP_ID_MSIX:
+     {
+           int dw_off = entry->msi_attrib.entry_nr*PCI_MSIX_ENTRY_SIZE - 1;
+           *(u32*)(entry->mask_entry_addr + dw_off) = flag;
+           break;
+     }
+      default:
+           break;
+     } 
+}
+
+static void mask_MSI_irq(unsigned int irq)
+{
+      msi_set_mask_bit(irq, 1);
+}
+
+static void unmask_MSI_irq(unsigned int irq)
+{
+      msi_set_mask_bit(irq, 0);
+}
+
+static unsigned int startup_msi_irq_wo_maskbit(unsigned int irq) 
+{
+     return 0;    /* never anything pending */
+}
+static void shutdown_msi_irq_wo_maskbit(unsigned int irq) {}
+static void enable_msi_irq_wo_maskbit(unsigned int irq) {}
+static void disable_msi_irq_wo_maskbit(unsigned int irq) {}
+static void act_msi_irq_wo_maskbit(unsigned int irq) {}
+static void end_msi_irq_wo_maskbit(unsigned int irq) 
+{
+      ack_APIC_irq();   
+}
+
+static unsigned int startup_msi_irq_w_maskbit(unsigned int irq)
+{ 
+      unmask_MSI_irq(irq);
+     return 0;    /* never anything pending */
+}
+
+#define shutdown_msi_irq_w_maskbit      disable_msi_irq_w_maskbit
+#define enable_msi_irq_w_maskbit      unmask_MSI_irq
+#define disable_msi_irq_w_maskbit      mask_MSI_irq
+#define act_msi_irq_w_maskbit         mask_MSI_irq
+static void end_msi_irq_w_maskbit(unsigned int irq) 
+{
+      unmask_MSI_irq(irq);    
+      ack_APIC_irq();
+}
+
+static struct hw_interrupt_type msi_irq_w_maskbit_type = {
+     "PCI MSI",
+      startup_msi_irq_w_maskbit,
+      shutdown_msi_irq_w_maskbit,
+      enable_msi_irq_w_maskbit,
+      disable_msi_irq_w_maskbit,
+      act_msi_irq_w_maskbit,        
+      end_msi_irq_w_maskbit,  
+     NULL
+};
+
+static struct hw_interrupt_type msi_irq_wo_maskbit_type = {
+     "PCI MSI",
+      startup_msi_irq_wo_maskbit,
+      shutdown_msi_irq_wo_maskbit,
+      enable_msi_irq_wo_maskbit,
+      disable_msi_irq_wo_maskbit,
+      act_msi_irq_wo_maskbit,       
+      end_msi_irq_wo_maskbit, 
+     NULL
+};
+
+static void msi_data_init(struct msg_data *msi_data, 
+                   unsigned int vector)
+{
+      memset(msi_data, 0, sizeof(struct msg_data));
+      msi_data->vector = (u8)vector;
+      msi_data->delivery_mode = INT_DELIVERY_MODE;
+      msi_data->dest_mode = INT_DEST_MODE;
+      msi_data->trigger = 0;  
+      msi_data->delivery_status = 0;   
+}
+
+static void msi_address_init(struct msg_address *msi_address)
+{
+      memset(msi_address, 0, sizeof(struct msg_address));
+      msi_address->hi_address = (u32)0;
+      msi_address->lo_address.value = (u32)mp_lapic_addr;
+      msi_address->lo_address.u.dest_mode = INT_DEST_MODE;
+      msi_address->lo_address.u.redirection_hint = 0; 
+      msi_address->lo_address.u.ext_dest_id = 0;
+      msi_address->lo_address.u.dest_id = TARGET_CPUS;
+}
+
+static int pci_vector_resources(void)                            
+{    
+     static int res = -EINVAL;     
+     
+     if (res == -EINVAL) {
+           int i, repeat;
+           for (i = NR_REPEATS; i > 0; i--) {                       
+                 if ((FIRST_DEVICE_VECTOR + i*8) > FIRST_SYSTEM_VECTOR)
+                       continue;                           
+                 break;                                           
+           }                                               
+           i++;                                           
+           repeat = (FIRST_SYSTEM_VECTOR - FIRST_DEVICE_VECTOR)/i;       
+           res = i*repeat - NR_RESERVED_VECTORS; 
+     }
+
+     return (res + nr_released_vectors - nr_alloc_vectors);      
+}
+
+int assign_irq_vector(int irq)
+{
+     static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
+     
+     if (irq != MSI_AUTO && IO_APIC_VECTOR(irq) > 0)
+           return IO_APIC_VECTOR(irq);
+next:
+      current_vector += 8;
+     if (current_vector == SYSCALL_VECTOR)
+           goto next;
+
+     if (current_vector > FIRST_SYSTEM_VECTOR) {
+           offset++;
+           current_vector = FIRST_DEVICE_VECTOR + offset;
+     }
+
+     if (current_vector == FIRST_SYSTEM_VECTOR) 
+           panic("ran out of interrupt sources!");
+     
+      vector_irq[current_vector] = irq;
+     if (irq != MSI_AUTO)   
+           IO_APIC_VECTOR(irq) = current_vector;
+
+      nr_alloc_vectors++;
+
+     return current_vector;
+}
+
+static int assign_msi_vector(void)
+{
+     static int new_vector_avail = 1;   
+     int vector;
+      unsigned int flags;
+     
+     /* 
+     * msi_lock is provided to ensure that successful allocation of MSI
+     * vector is assigned unique among drivers.
+     */
+      spin_lock_irqsave(&msi_lock, flags);
+     if (!(pci_vector_resources() > 0)) {
+           spin_unlock_irqrestore(&msi_lock, flags);
+           return -EBUSY;
+     }
+
+     if (!new_vector_avail) {
+           /*
+           * vector_irq[] = -1 indicates that this specific vector is:
+           * - assigned for MSI (since MSI have no associated IRQ) or
+           * - assigned for legacy if less than 16, or
+           * - having no corresponding 1:1 vector-to-IOxAPIC IRQ mapping
+           * vector_irq[] = 0 indicates that this vector, previously 
+           * assigned for MSI, is freed by hotplug removed operations. 
+           * This vector will be reused for any subsequent hotplug added 
+           * operations.
+           * vector_irq[] > 0 indicates that this vector is assigned for 
+           * IOxAPIC IRQs. This vector and its value provides a 1-to-1 
+           * vector-to-IOxAPIC IRQ mapping.
+           */   
+           for (vector = 0; vector < NR_IRQS; vector++) { 
+                 if (vector_irq[vector] != 0) 
+                       continue;
+                 vector_irq[vector] = -1; 
+                 nr_released_vectors--;
+                 spin_unlock_irqrestore(&msi_lock, flags);
+                 return vector;
+           }
+           spin_unlock_irqrestore(&msi_lock, flags);
+           return -EBUSY;
+     }     
+
+     vector = assign_irq_vector(MSI_AUTO);
+     if (vector  == (FIRST_SYSTEM_VECTOR - 8))  
+           new_vector_avail = 0;
+
+      spin_unlock_irqrestore(&msi_lock, flags);
+     return vector;
+}
+
+static int get_new_vector(void)
+{
+     int vector;
+     
+     if ((vector = assign_msi_vector()) > 0)
+           set_intr_gate(vector, interrupt[vector]);
+
+     return vector;
+}
+
+#ifdef CONFIG_ACPI_BOOT
+static int find_prt_ioapic_vector(struct pci_dev *dev)
+{
+     struct list_head *node = NULL;
+     struct acpi_prt_entry *entry = NULL;
+     u32 pin;
+     int shares = 0, vector = 0;
+     
+     dev->bus->ops->read(dev->bus, dev->devfn, PCI_INTERRUPT_PIN, 1, &pin);
+     pin--;
+     vector = acpi_pci_irq_lookup(0, dev->bus->number,
PCI_SLOT(dev->devfn),
+           pin);
+     if (vector_irq[vector] == -1)
+           return -EBUSY;
+
+      list_for_each(node, &acpi_prt.entries) {
+           entry = list_entry(node, struct acpi_prt_entry, node);
+           if (entry->link.handle)
+                 continue;
+           if (entry->id.segment == 0 && entry->irq == vector) 
+                 shares++;
+     }
+     if (shares != 1) 
+           return -EBUSY;
+     
+     return vector; 
+}
+#define get_ioapic_vector      find_prt_ioapic_vector
+#else
+static int find_ioapic_vector(struct pci_dev *dev)
+{
+     int         irq = -1;
+
+     if (io_apic_assign_pci_irqs && IO_APIC_DEFINED) 
+     {
+           u32         pin = 0;
+           unsigned int       apic, intin;
+           int         i = 0, shares = 0;
+           
+           dev->bus->ops->read(dev->bus, dev->devfn, PCI_INTERRUPT_PIN, 1,
+                 &pin);
+           if (pin) {
+                 pin--;       
+                 irq = IO_APIC_get_PCI_irq_vector(
+                       dev->bus->number, PCI_SLOT(dev->devfn), pin);
+                 for (apic = 0; apic < nr_ioapics; apic++) {
+                       i += nr_ioapic_registers[apic];
+                       if (i > irq) break;
+                 }
+                 intin = irq - (i - nr_ioapic_registers[apic]);   
+                   for (i = 0; i < mp_irq_entries; i++) 
+                       if ((mp_ioapics[apic].mpc_apicid == 
+                           mp_irqs[i].mpc_dstapic) && /*MATCH APIC & */
+                          (mp_irqs[i].mpc_dstirq == intin)) /* INTIN */
+                             shares++; 
+           }
+           if (shares != 1) 
+                 return -EBUSY;
+     }
+     
+     return IO_APIC_VECTOR(irq);
+}
+#define get_ioapic_vector      find_ioapic_vector
+#endif
+
+static int get_msi_vector(struct pci_dev *dev)
+{
+     int vector;
+
+     if ((vector = get_ioapic_vector(dev)) < 0) 
+           vector = get_new_vector();
+     
+     return vector;
+}
+
+static struct msi_desc_t* alloc_msi_entry(void)
+{
+     struct msi_desc_t *entry;
+
+      entry=(struct msi_desc_t*)kmalloc(sizeof(struct
msi_desc_t),GFP_KERNEL);
+     if (!entry)
+           return NULL;
+     entry->mask_entry_addr = NULL;
+     entry->dev = NULL;
+     
+     return entry;
+}
+
+static void irq_handler_init(int pos, int mask)
+{
+      spin_lock(&irq_desc[pos].lock);
+     if (!mask)
+           irq_desc[pos].handler = &msi_irq_wo_maskbit_type;
+     else
+           irq_desc[pos].handler = &msi_irq_w_maskbit_type;
+      spin_unlock(&irq_desc[pos].lock);
+}
+
+static void enable_msi_mode(struct pci_dev *dev, int pos, int type)
+{
+     u32 control;
+                 
+     dev->bus->ops->read(dev->bus, dev->devfn, 
+           msi_control_reg(pos), 2, &control);
+     if (type == PCI_CAP_ID_MSI) {
+           /* Set enabled bits to single MSI & enable MSI_enable bit */
+           msi_enable(control, 1);
+             dev->bus->ops->write(dev->bus, dev->devfn, 
+                 msi_control_reg(pos), 2, control);
+     } else {
+           msix_enable(control);
+             dev->bus->ops->write(dev->bus, dev->devfn, 
+                 msi_control_reg(pos), 2, control);
+     }
+    if (pci_find_capability(dev, PCI_CAP_ID_PCI_EXPRESS)) {
+           /* PCI Express Endpoint device detected */
+           u32 cmd;
+             dev->bus->ops->read(dev->bus, dev->devfn, PCI_COMMAND, 2,
&cmd);
+           cmd |= PCI_COMMAND_INTX_DISABLE;
+             dev->bus->ops->write(dev->bus, dev->devfn, PCI_COMMAND, 2,
cmd);
+     }
+}
+
+/**
+ * msi_capability_init: configure device's MSI capability structure
+ * argument: dev of struct pci_dev type
+ * 
+ * description: called to configure the device's MSI capability structure
with 
+ * a single MSI, regardless of device is capable of handling multiple
messages.
+ *
+ * return:
+ * -EINVAL      : Invalid device type
+ * -ENOMEM      : Memory Allocation Error
+ * -EBUSY      : No MSI resource 
+ * > 0           : vector for entry 0
+ **/
+static int msi_capability_init(struct pci_dev *dev) 
+{
+     struct msi_desc_t *entry;
+     struct msg_address address; 
+     struct msg_data data;
+     int pos, vector, *mask_reg = NULL;
+     u32 control;
+     
+     pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
+     if (!pos)
+           return -EINVAL; 
+
+     dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos), 
+           2, &control);
+     if (control & PCI_MSI_FLAGS_ENABLE)
+           return dev->irq;
+     
+     if (is_mask_bit_support(control)) {
+           mask_reg = (int*) kmalloc(sizeof(int), GFP_KERNEL);
+           if (!mask_reg)
+                 return -ENOMEM;
+           *mask_reg = msi_mask_bits_reg(pos, is_64bit_address(control));
+     }
+     /* MSI Entry Initialization */
+     entry = alloc_msi_entry();
+     if (!entry) {
+           kfree(mask_reg);
+           return -ENOMEM;
+     }
+     if ((vector = get_msi_vector(dev)) < 0) {
+           kfree(entry);
+           kfree(mask_reg);
+           return vector;
+     }
+     entry->msi_attrib.type = PCI_CAP_ID_MSI;
+     entry->msi_attrib.entry_nr = 0;
+     entry->msi_attrib.maskbit = is_mask_bit_support(control);
+     entry->dev = dev;
+     entry->mask_entry_addr = mask_reg; 
+      irq_handler_init(vector, entry->msi_attrib.maskbit);
+      msi_desc[vector] = entry;
+     /* Configure MSI capability structure */
+      msi_address_init(&address);
+      msi_data_init(&data, vector);
+     entry->msi_attrib.current_cpu = address.lo_address.u.dest_id;
+     dev->bus->ops->write(dev->bus, dev->devfn, msi_lower_address_reg(pos),

+                       4, address.lo_address.value);
+     if (is_64bit_address(control)) {
+           dev->bus->ops->write(dev->bus, dev->devfn, 
+                 msi_upper_address_reg(pos), 4, address.hi_address);
+           dev->bus->ops->write(dev->bus, dev->devfn, 
+                 msi_data_reg(pos, 1), 2, *((u32*)&data));
+     } else
+           dev->bus->ops->write(dev->bus, dev->devfn, 
+                 msi_data_reg(pos, 0), 2, *((u32*)&data));
+     if (entry->msi_attrib.maskbit) {
+           unsigned int maskbits, temp;
+           /* All MSIs are unmasked by default, Mask them all */
+             dev->bus->ops->read(dev->bus, dev->devfn, 
+                 msi_mask_bits_reg(pos, is_64bit_address(control)), 4,
+                 &maskbits);
+           temp = (1 << multi_msi_capable(control));
+           temp = ((temp - 1) & ~temp);
+           maskbits |= temp;
+           dev->bus->ops->write(dev->bus, dev->devfn, 
+                 msi_mask_bits_reg(pos, is_64bit_address(control)), 4,
+                 maskbits);
+     }
+     /* Set MSI enabled bits  */
+      enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
+     
+     return vector;
+}
+
+/**
+ * msix_capability_init: configure device's MSI-X capability structure
+ * argument: dev of struct pci_dev type
+ * 
+ * description: called to configure the device's MSI-X capability structure

+ * with a single MSI. To request for additional MSI vectors, the device
drivers
+ * are required to utilize the following supported APIs:
+ * 1) msi_alloc_vectors(...) for requesting one or more MSIs
+ * 2) msi_free_vectors(...) for releasing one or more MSIs back to PCI
subsystem
+ *
+ * return:
+ * -EINVAL      : Invalid device type
+ * -ENOMEM      : Memory Allocation Error
+ * -EBUSY      : No MSI resource 
+ * > 0           : vector for entry 0
+ **/
+static int msix_capability_init(struct pci_dev      *dev) 
+{
+     struct msi_desc_t *entry;
+     struct msg_address address; 
+     struct msg_data data;
+     int vector = 0, pos, dev_msi_cap;
+     u32 phys_addr, table_offset, *base;
+     u32 control;
+     u8 bir;
+     
+     pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+     if (!pos)
+           return -EINVAL;  
+
+     /* Request & Map MSI-X table region */
+     dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos), 2, 
+           &control);
+     if (control & PCI_MSIX_FLAGS_ENABLE)
+           return dev->irq;
+
+      dev_msi_cap = multi_msix_capable(control);
+     dev->bus->ops->read(dev->bus, dev->devfn, 
+           msix_table_offset_reg(pos), 4, &table_offset);
+     bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
+      phys_addr = pci_resource_start (dev, bir);
+      phys_addr += (u32)(table_offset & ~PCI_MSIX_FLAGS_BIRMASK);
+     if (!request_mem_region(phys_addr, 
+           dev_msi_cap*PCI_MSIX_ENTRY_SIZE*sizeof(u32),
+           "MSI-X iomap Failure"))
+           return -ENOMEM;
+     base = (u32*)ioremap_nocache(phys_addr,
+           dev_msi_cap*PCI_MSIX_ENTRY_SIZE*sizeof(u32));
+     if (base == NULL) 
+           goto free_region; 
+     /* MSI Entry Initialization */
+     entry = alloc_msi_entry();
+     if (!entry) 
+           goto free_iomap; 
+     if ((vector = get_msi_vector(dev)) < 0)
+           goto free_entry;
+           
+     entry->msi_attrib.type = PCI_CAP_ID_MSIX;
+     entry->msi_attrib.entry_nr = 0;
+     entry->msi_attrib.maskbit = 1;
+     entry->dev = dev;
+     entry->mask_entry_addr = base; 
+      irq_handler_init(vector, 1);
+      msi_desc[vector] = entry;
+     /* Configure MSI-X capability structure */
+      msi_address_init(&address);
+      msi_data_init(&data, vector);
+     entry->msi_attrib.current_cpu = address.lo_address.u.dest_id;
+     *base = address.lo_address.value;
+     *(base + 1) = address.hi_address;
+     *(base + 2) = *((u32*)&data);
+     /* Set MSI enabled bits  */
+      enable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
+     return vector;
+
+free_entry:
+      kfree(entry);
+free_iomap:
+      iounmap((void *)base);
+free_region: 
+      release_mem_region(phys_addr, 
+      dev_msi_cap*PCI_MSIX_ENTRY_SIZE*sizeof(u32));
+
+     return ((vector < 0) ? -EBUSY : -ENOMEM);
+}
+
+/** 
+ * msi_get_pci_irq_vector: configure MSI/MSI-X capability structure
+ * argument: unsigned int irq 
+ * 
+ * description: called by PCI bus driver during PCI bus enumeration. The 
+ * decision of enabling MSI vector(s) to the function requires that all of 
+ * the following conditions must be satisfied:
+ * - The system-wide-level boot parameter CONFIG_MSI_USE_VECTOR is enabled 
+ *      This boot parameter enables MSI support to all MSI capable
functions 
+ *      by default.
+ * - The function indicates MSI support by implementing MSI/MSI-X
capability
+ *      structure in its capability list.
+ * - The function is not listed in the boot parameter "device_nomsi=". PCI 
+ *      subsystem uses this boot parameter to determine whether users want
to 
+ *   have PCI subsystem forcing the function to override its default irq 
+ *      assertion mechanism with PCI MSI mechanism.
+ * - The MSI resource pool is available.
+ *
+ * return:
+ * -EINVAL      : Invalid device type
+ * -ENOMEM      : Memory Allocation Error
+ * -EBUSY      : No MSI resource 
+ * > 0           : vector for entry 0
+ **/
+int msi_get_pci_irq_vector(void* dev_id)
+{
+     struct pci_dev *dev = (struct pci_dev*)dev_id;
+     int vector = -EINVAL;
+
+     if (!pci_msi_enable)
+           return vector;     
+     if (!is_msi_support_for_this_device(dev))
+           return vector;     
+     if ((vector = msix_capability_init(dev)) == -EINVAL)
+           return (msi_capability_init(dev));
+     
+     return vector;
+}
+
+static int msi_alloc_vector(void* dev_id)
+{
+     struct msi_desc_t *entry;
+     struct msg_address address; 
+     struct msg_data data;
+     struct pci_dev *dev = (struct pci_dev *)dev_id;
+     int i, pos, dev_msi_cap, vector;
+     u32 control;
+     u32 *base = NULL;
+      unsigned int flags;
+
+     vector = get_new_vector();
+     if (vector < 0)
+           return vector;
+
+     entry = msi_desc[dev->irq];
+     base = (u32*)entry->mask_entry_addr;
+     pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+     dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos),   
+           2, &control);
+      dev_msi_cap = multi_msix_capable(control);
+     for (i = 1; i < dev_msi_cap; i++)
+           if (*(base + i*PCI_MSIX_ENTRY_SIZE) == 0)
+                 break;
+     if (i >= dev_msi_cap) {
+           spin_lock_irqsave(&msi_lock, flags);
+           vector_irq[vector] = 0;
+           nr_released_vectors++;
+           spin_unlock_irqrestore(&msi_lock, flags);
+           return -EINVAL;
+     }
+     /* MSI Entry Initialization */
+     entry = alloc_msi_entry();
+     if (!entry) {
+           spin_lock_irqsave(&msi_lock, flags);
+           vector_irq[vector] = 0;
+           nr_released_vectors++;
+           spin_unlock_irqrestore(&msi_lock, flags);
+           return -ENOMEM;
+     }     
+     entry->msi_attrib.type = PCI_CAP_ID_MSIX;
+     entry->msi_attrib.entry_nr = i;
+     entry->msi_attrib.maskbit = 1;
+     entry->dev = dev;
+     entry->mask_entry_addr = base; 
+      irq_handler_init(vector, 1);
+      msi_desc[vector] = entry;
+     /* Configure MSI-X capability structure */
+      msi_address_init(&address);
+      msi_data_init(&data, vector);
+     entry->msi_attrib.current_cpu = address.lo_address.u.dest_id;
+     base += i*PCI_MSIX_ENTRY_SIZE;
+     *base = address.lo_address.value;
+     *(base + 1) = address.hi_address;
+     *(base + 2) = *((u32*)&data);
+     *(base + 3) = 1; /* ensure to mask it */
+     
+     return vector;
+}
+
+int msi_alloc_vectors(void* dev_id, int *vector, int nvec)
+{
+     struct msi_desc_t *entry;
+     struct pci_dev *dev = (struct pci_dev *)dev_id;
+     int i, pos, vec, alloc_vectors = 0, *vectors = (int *)vector;
+     u32 control;
+      unsigned int flags;
+
+     if (!pci_msi_enable)
+           return -EINVAL;
+     
+     entry = msi_desc[dev->irq];
+     if (!entry || entry->dev != dev ||
+        entry->msi_attrib.type != PCI_CAP_ID_MSIX)
+           return -EINVAL;
+
+     pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+     dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos),
2, &control);
+     if (nvec > multi_msix_capable(control))
+           return -EINVAL;
+     /*
+     * msi_lock is provided to ensure that enough vectors resources are
+     * available before granting.
+     */ 
+      spin_lock_irqsave(&msi_lock, flags);
+     if (nvec > pci_vector_resources()) {
+           spin_unlock_irqrestore(&msi_lock, flags);
+           return -EBUSY;
+     }
+      spin_unlock_irqrestore(&msi_lock, flags);
+     for (i = 0; i < nvec; i++) {
+           if ((vec = msi_alloc_vector(dev)) < 0)
+                 break;
+           *(vectors + i) = vec;
+           alloc_vectors++;
+     }
+     if (alloc_vectors != nvec) {
+           for (i = 0; i < alloc_vectors; i++) {
+                 vec = *(vectors + i);
+                 spin_lock_irqsave(&msi_lock, flags);
+                 vector_irq[vec] = 0;
+                 nr_released_vectors++;
+                 spin_unlock_irqrestore(&msi_lock, flags);
+                 if (msi_desc[vec] != NULL) {
+                       msi_desc[vec]->dev = NULL; 
+                       msi_desc[vec]->mask_entry_addr = NULL; 
+                       kfree(msi_desc[vec]);
+                 }
+           }
+           return -EBUSY;
+     }
+
+     return alloc_vectors;
+}
+
+static int msi_free_vector(void* dev_id, int vector)
+{
+     struct msi_desc_t *entry;
+     struct pci_dev *dev = (struct pci_dev *)dev_id;
+     int offset;
+     u32 *tbl_addr;
+      unsigned int flags;
+
+     entry = msi_desc[vector];
+     if (!entry || entry->dev != dev || 
+        entry->msi_attrib.type != PCI_CAP_ID_MSIX)
+           return -EINVAL;
+
+      tbl_addr = (u32*)entry->mask_entry_addr;
+     offset = entry->msi_attrib.entry_nr*PCI_MSIX_ENTRY_SIZE - 1;
+      *(tbl_addr + offset) = 1;      /* mask this entry */
+     entry->mask_entry_addr = NULL;
+     entry->dev = NULL;
+      kfree(entry);
+      msi_desc[vector] = NULL;
+      spin_lock_irqsave(&msi_lock, flags);
+      vector_irq[vector] = 0;  
+      nr_released_vectors++;
+      spin_unlock_irqrestore(&msi_lock, flags);
+     
+     return 0;
+}
+
+int msi_free_vectors(void* dev_id, int *vector, int nvec)
+{
+     struct msi_desc_t *entry;
+     struct pci_dev *dev = (struct pci_dev *)dev_id;
+     int i;
+
+     if (!pci_msi_enable)
+           return -EINVAL;
+     
+     entry = msi_desc[dev->irq];
+     if (!entry || entry->dev != dev || 
+        entry->msi_attrib.type != PCI_CAP_ID_MSIX)
+           return -EINVAL;
+
+     for (i = 0; i < nvec; i++) {
+           msi_free_vector(dev, *(vector + i)); 
+     }
+
+     return 0;
+}
+
+/**
+ * msi_hp_free_vectors: reclaim all MSI previous assigned to this device
+ * argument: device pointer of type struct pci_dev 
+ *
+ * description: used during hotplug removed, from which device is
hot-removed;
+ * PCI subsystem reclaims associated MSI to unused state, which may be used

+ * later on.
+ **/ 
+void remove_hotplug_vectors(void* dev_id)
+{
+     struct msi_desc_t *entry;
+     struct pci_dev *dev = (struct pci_dev *)dev_id;
+     int type;
+     void *mask_entry_addr;
+      unsigned int flags;
+
+     if (!pci_msi_enable)
+           return;
+     
+     entry = msi_desc[dev->irq];
+     if (!entry || entry->dev != dev)
+           return;
+           
+     if (get_ioapic_vector(dev) > 0)
+           restore_ioapic_irq_handler(dev->irq);
+     type = entry->msi_attrib.type;
+      mask_entry_addr = entry->mask_entry_addr;
+     entry->mask_entry_addr = NULL;
+     entry->dev = NULL;
+      kfree(entry);
+      msi_desc[dev->irq] = NULL;
+      spin_lock_irqsave(&msi_lock, flags);
+      vector_irq[dev->irq] = 0;  
+      nr_released_vectors++;
+      spin_unlock_irqrestore(&msi_lock, flags);
+     if (type == PCI_CAP_ID_MSIX) {
+           int i, pos, dev_msi_cap;
+           u32 phys_addr, table_offset;
+           u32 control;
+           u8 bir;
+
+           pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+           dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos),
2, &control);
+           dev_msi_cap = multi_msix_capable(control);
+           dev->bus->ops->read(dev->bus, dev->devfn, 
+                 msix_table_offset_reg(pos), 4, &table_offset);
+           bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
+           phys_addr = pci_resource_start (dev, bir);
+           phys_addr += (u32)(table_offset & ~PCI_MSIX_FLAGS_BIRMASK);
+           for (i = 0; i < NR_IRQS; i++) 
+                 if (msi_desc[i]->dev == dev)
+                       msi_free_vector(dev, i);
+           *(u32*)(mask_entry_addr + 3) = 1;
+           iounmap(mask_entry_addr);
+           release_mem_region(phys_addr, 
+           dev_msi_cap*PCI_MSIX_ENTRY_SIZE*sizeof(u32));
+     } else
+           kfree(mask_entry_addr);
+}
diff -X excludes -urN linux-2.5.65/arch/i386/pci/irq.c
2.5.65-create-vec-patch/arch/i386/pci/irq.c
--- linux-2.5.65/arch/i386/pci/irq.c    2003-03-17 16:44:50.000000000 -0500
+++ 2.5.65-create-vec-patch/arch/i386/pci/irq.c     2003-05-12
12:42:50.000000000 -0400
@@ -712,40 +712,61 @@
      }
 
       pci_for_each_dev(dev) {
+           int irq;
            pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-#ifdef CONFIG_X86_IO_APIC
-           /*
-           * Recalculate IRQ numbers if we use the I/O APIC.
-           */
-           if (io_apic_assign_pci_irqs)
+#ifdef CONFIG_MSI_USE_VECTOR
+           if ((irq = msi_get_pci_irq_vector(dev)) > 0) {
+                     dev->irq = irq;
+                     printk(KERN_INFO "PCI->MSI
vector:(B%d,I%d,P%d)->%d\n", 
+                 dev->bus->number, PCI_SLOT(dev->devfn), pin-1, irq);
+           } else
+#endif     
            {
-                 int irq;
-
-                 if (pin) {
-                       pin--;            /* interrupt pins are numbered
starting from 1 */
-                       irq = IO_APIC_get_PCI_irq_vector(dev->bus->number,
PCI_SLOT(dev->devfn), pin);
+#ifdef CONFIG_X86_IO_APIC
+                 /*
+                  * Recalculate IRQ numbers if we use the I/O APIC.
+                  */
+                     if (io_apic_assign_pci_irqs)
+                     {
+                       if (pin) {
+                             pin--;      /* interrupt pins are numbered
starting from 1 */
+                             irq = IO_APIC_get_PCI_irq_vector(
+                                   dev->bus->number, 
+                                   PCI_SLOT(dev->devfn), pin);
      /*
       * Busses behind bridges are typically not listed in the MP-table.
       * In this case we have to look up the IRQ based on the parent bus,
       * parent slot, and pin number. The SMP code detects such bridged
       * busses itself so we should get into this branch reliably.
       */
-                       if (irq < 0 && dev->bus->parent) { /* go back to the
bridge */
-                             struct pci_dev * bridge = dev->bus->self;
+                             if (irq < 0 && dev->bus->parent) { 
+                                   /* go back to the bridge */
+                                   struct pci_dev * bridge = 
+                                               dev->bus->self;
+
+                                   pin = (pin + PCI_SLOT(
+                                         dev->devfn)) % 4;
+                                   irq = IO_APIC_get_PCI_irq_vector
(bridge->bus->number, 
+                                         PCI_SLOT(bridge->devfn),
+                                         pin);
+                                   if (irq >= 0)
+                                         printk(KERN_WARNING "PCI: using
PPB(B%d,I%d,P%d) to get irq %d\n", 
+                                         bridge->bus->number, 
+                                         PCI_SLOT(bridge->devfn),
+                                                pin, irq);
+                             }
+                             if (irq >= 0) {
+#ifdef CONFIG_MSI_USE_VECTOR
+                                   if (!platform_legacy_irq(irq))
+                                         irq = IO_APIC_VECTOR(irq);
+#endif
 
-                             pin = (pin + PCI_SLOT(dev->devfn)) % 4;
-                             irq =
IO_APIC_get_PCI_irq_vector(bridge->bus->number, 
-                                         PCI_SLOT(bridge->devfn), pin);
-                             if (irq >= 0)
-                                   printk(KERN_WARNING "PCI: using
PPB(B%d,I%d,P%d) to get irq %d\n", 
-                                         bridge->bus->number,
PCI_SLOT(bridge->devfn), pin, irq);
-                       }
-                       if (irq >= 0) {
-                             printk(KERN_INFO "PCI->APIC IRQ transform:
(B%d,I%d,P%d) -> %d\n",
+                                   printk(KERN_INFO "PCI->APIC IRQ
transform: (B%d,I%d,P%d) -> %d\n",
                                    dev->bus->number, PCI_SLOT(dev->devfn),
pin, irq);
-                             dev->irq = irq;
+                                   dev->irq = irq;
+                             }
                        }
-                 }
+                     }
            }
 #endif
            /*
diff -X excludes -urN linux-2.5.65/Documentation/kernel-parameters.txt
2.5.65-create-vec-patch/Documentation/kernel-parameters.txt
--- linux-2.5.65/Documentation/kernel-parameters.txt    2003-03-17
16:44:51.000000000 -0500
+++ 2.5.65-create-vec-patch/Documentation/kernel-parameters.txt
2003-05-12 12:40:29.000000000 -0400
@@ -36,6 +36,7 @@
      MCA      MCA bus support is enabled.
      MDA      MDA console support is enabled.
      MOUSE      Appropriate mouse support is enabled.
+     MSI      Message Signal Interrupt.
      MTD      MTD support is nebaled.
      NET      Appropriate network support is enabled.
      NFS      Appropriate NFS support is enabled.
@@ -255,6 +256,13 @@
                  Format: <area>[,<node>]
                  See also Documentation/networking/decnet.txt.
 
+      device_nomsi=      [HW]
+                 Format: DeviceIDVendorID in hex format without prefix 0x
+                 To select a list of individual MSI-capable functions
+                 requesting no MSI support at function-wide. This
+                 option does not provide any benefits if a configured 
+                 parameter CONFIG_MSI_USE_VECTOR is set to N.
+
      devfs=            [DEVFS]
                  See Documentation/filesystems/devfs/boot-options.
  
@@ -679,6 +687,11 @@
                  See header of drivers/block/paride/pcd.c.
                  See also Documentation/paride.txt.
 
+      pci_nomsi   If user sets a configured parameter MSI_USE_VECTOR
+                 during kernel built, then he/she can use this append 
+                 option to disable MSI system-wide support from PCI 
+                 subsystem during boot.
+
       pci=option[,option...]        [PCI] various PCI subsystem options:
            off               [IA-32] don't probe for the PCI bus
            bios              [IA-32] force use of PCI BIOS, don't access
diff -X excludes -urN linux-2.5.65/drivers/acpi/pci_irq.c
2.5.65-create-vec-patch/drivers/acpi/pci_irq.c
--- linux-2.5.65/drivers/acpi/pci_irq.c 2003-03-17 16:44:05.000000000 -0500
+++ 2.5.65-create-vec-patch/drivers/acpi/pci_irq.c  2003-05-12
13:18:50.000000000 -0400
@@ -327,6 +327,15 @@
            return_VALUE(-ENODEV);
      }
 
+#ifdef CONFIG_MSI_USE_VECTOR   
+     if ((irq = msi_get_pci_irq_vector(dev)) > 0) {
+               dev->irq = irq;
+               printk(KERN_INFO "PCI->MSI VEC
transform:(B%d,I%d,P%d)->%d\n", 
+                 dev->bus->number, PCI_SLOT(dev->devfn), pin, irq);
+           return_VALUE(dev->irq);
+     }
+#endif
+     
      /* 
       * First we check the PCI IRQ routing table (PRT) for an IRQ.  PRT
       * values override any BIOS-assigned IRQs set during boot.
diff -X excludes -urN linux-2.5.65/include/asm-i386/hw_irq.h
2.5.65-create-vec-patch/include/asm-i386/hw_irq.h
--- linux-2.5.65/include/asm-i386/hw_irq.h     2003-03-17 16:44:50.000000000
-0500
+++ 2.5.65-create-vec-patch/include/asm-i386/hw_irq.h     2003-05-12
12:41:25.000000000 -0400
@@ -40,6 +40,7 @@
 extern asmlinkage void error_interrupt(void);
 extern asmlinkage void spurious_interrupt(void);
 extern asmlinkage void thermal_interrupt(struct pt_regs);
+#define platform_legacy_irq(irq)      ((irq) < 16)
 #endif
 
 extern void mask_irq(unsigned int irq);
@@ -57,6 +58,15 @@
 extern int IO_APIC_get_PCI_irq_vector(int bus, int slot, int fn);
 extern void send_IPI(int dest, int vector);
 
+#ifdef CONFIG_MSI_USE_VECTOR
+#include <linux/pci_msi.h>
+extern struct msi_desc_t* msi_desc[NR_IRQS];
+extern int msi_get_pci_irq_vector(void *dev);
+extern int msi_alloc_vectors(void *dev, int *vector, int nvec);
+extern int msi_free_vectors(void *dev, int *vector, int nvec);
+extern void remove_hotplug_vectors(void *dev);
+#endif
+
 extern unsigned long io_apic_irqs;
 
 extern atomic_t irq_err_count;
diff -X excludes -urN
linux-2.5.65/include/asm-i386/mach-default/irq_vectors.h
2.5.65-create-vec-patch/include/asm-i386/mach-default/irq_vectors.h
--- linux-2.5.65/include/asm-i386/mach-default/irq_vectors.h      2003-03-17
16:43:49.000000000 -0500
+++ 2.5.65-create-vec-patch/include/asm-i386/mach-default/irq_vectors.h
2003-05-07 16:50:33.000000000 -0400
@@ -77,8 +77,13 @@
  * the usable vector space is 0x20-0xff (224 vectors)
  */
 #ifdef CONFIG_X86_IO_APIC
+#ifndef CONFIG_MSI_USE_VECTOR
 #define NR_IRQS 224
 #else
+#define NR_VECTORS 256
+#define NR_IRQS FIRST_SYSTEM_VECTOR
+#endif
+#else
 #define NR_IRQS 16
 #endif
 
diff -X excludes -urN linux-2.5.65/include/linux/pci.h
2.5.65-create-vec-patch/include/linux/pci.h
--- linux-2.5.65/include/linux/pci.h    2003-03-17 16:44:05.000000000 -0500
+++ 2.5.65-create-vec-patch/include/linux/pci.h     2003-04-18
08:49:32.000000000 -0400
@@ -36,6 +36,7 @@
 #define  PCI_COMMAND_WAIT 0x80      /* Enable address/data stepping */
 #define  PCI_COMMAND_SERR  0x100      /* Enable SERR */
 #define  PCI_COMMAND_FAST_BACK      0x200      /* Enable back-to-back
writes */
+#define  PCI_COMMAND_INTX_DISABLE 0x400 /* INTx Emulation Disable */
 
 #define PCI_STATUS        0x06      /* 16 bits */
 #define  PCI_STATUS_CAP_LIST      0x10      /* Support Capability List */
@@ -198,6 +199,8 @@
 #define  PCI_CAP_ID_MSI          0x05      /* Message Signalled Interrupts
*/
 #define  PCI_CAP_ID_CHSWP  0x06      /* CompactPCI HotSwap */
 #define  PCI_CAP_ID_PCIX   0x07      /* PCI-X */
+#define  PCI_CAP_ID_PCI_EXPRESS 0x10
+#define  PCI_CAP_ID_MSIX   0x11      /* MSI-X */
 #define PCI_CAP_LIST_NEXT 1      /* Next capability in the list */
 #define PCI_CAP_FLAGS           2      /* Capability defined flags (16
bits) */
 #define PCI_CAP_SIZEOF          4
@@ -275,11 +278,13 @@
 #define  PCI_MSI_FLAGS_QSIZE      0x70      /* Message queue size
configured */
 #define  PCI_MSI_FLAGS_QMASK      0x0e      /* Maximum queue size available
*/
 #define  PCI_MSI_FLAGS_ENABLE      0x01      /* MSI feature enabled */
+#define  PCI_MSI_FLAGS_MASKBIT      0x100      /* 64-bit mask bits allowed
*/
 #define PCI_MSI_RFU       3      /* Rest of capability flags */
 #define PCI_MSI_ADDRESS_LO      4      /* Lower 32 bits */
 #define PCI_MSI_ADDRESS_HI      8      /* Upper 32 bits (if
PCI_MSI_FLAGS_64BIT set) */
 #define PCI_MSI_DATA_32         8      /* 16 bits of data for 32-bit
devices */
 #define PCI_MSI_DATA_64         12      /* 16 bits of data for 64-bit
devices */
+#define PCI_MSI_MASK_BIT  16      /* Mask bits register */
 
 /* CompactPCI Hotswap Register */
 
diff -X excludes -urN linux-2.5.65/include/linux/pci_msi.h
2.5.65-create-vec-patch/include/linux/pci_msi.h
--- linux-2.5.65/include/linux/pci_msi.h      1969-12-31 19:00:00.000000000
-0500
+++ 2.5.65-create-vec-patch/include/linux/pci_msi.h 2003-05-12
12:55:13.000000000 -0400
@@ -0,0 +1,147 @@
+/*
+ *      linux/include/asm/pci_msi.h
+ *
+ */
+
+#ifndef _ASM_PCI_MSI_H
+#define _ASM_PCI_MSI_H
+
+#include <linux/pci.h>
+
+#define MSI_AUTO -1
+#define NR_REPEATS      23
+#define NR_RESERVED_VECTORS 3
/*FIRST_DEVICE_VECTOR,FIRST_SYSTEM_VECTOR,0x80 */    
+extern int vector_irq[NR_IRQS];
+extern void (*interrupt[NR_IRQS])(void);
+extern void restore_ioapic_irq_handler(int irq);
+
+#ifdef CONFIG_X86_IO_APIC
+#define IO_APIC_DEFINED               1
+#else
+#define IO_APIC_DEFINED               0
+#endif
+
+#ifndef INT_DEST_MODE
+#define INT_DEST_MODE                 1
+#endif
+
+#ifndef TARGET_CPUS
+#ifdef CONFIG_SMP
+#define TARGET_CPUS             0xf
+#else
+#define TARGET_CPUS             0x01
+#endif
+#endif
+
+#define DRIVER_NOMSI_MAX        32
+/*
+ * MSI-X Address Register
+ */
+#define PCI_MSIX_FLAGS_QSIZE          0x7FF
+#define PCI_MSIX_FLAGS_ENABLE         (1 << 15)
+#define PCI_MSIX_FLAGS_BIRMASK        (7 << 0)
+#define PCI_MSIX_FLAGS_BITMASK        (1 << 0)
+
+#define PCI_MSIX_ENTRY_SIZE           4      /* number of dwords */
+
+#define msi_control_reg(base)         (base + PCI_MSI_FLAGS)
+#define msi_lower_address_reg(base)   (base + PCI_MSI_ADDRESS_LO)
+#define msi_upper_address_reg(base)   (base + PCI_MSI_ADDRESS_HI)
+#define msi_data_reg(base, is64bit)      \
+     ( (is64bit == 1) ? base+PCI_MSI_DATA_64 : base+PCI_MSI_DATA_32 )
+#define msi_mask_bits_reg(base, is64bit) \
+     ( (is64bit == 1) ? base+PCI_MSI_MASK_BIT : base+PCI_MSI_MASK_BIT-4)
+#define msi_disable(control)          (control & ~PCI_MSI_FLAGS_ENABLE)
+#define multi_msi_capable(control) \
+     (1 << ((control & PCI_MSI_FLAGS_QMASK) >> 1))
+#define multi_msi_enable(control, num) \
+      control |= (((num >> 1) << 4) & PCI_MSI_FLAGS_QSIZE);
+#define is_64bit_address(control)      (control & PCI_MSI_FLAGS_64BIT)    
+#define is_mask_bit_support(control)      (control & PCI_MSI_FLAGS_MASKBIT)
+#define msi_enable(control, num) multi_msi_enable(control, num); \
+      control |= PCI_MSI_FLAGS_ENABLE
+ 
+#define msix_control_reg        msi_control_reg
+#define msix_table_offset_reg(base)   (base + 0x04)
+#define msix_pba_offset_reg(base)     (base + 0x08)
+#define msix_enable(control)          control |= PCI_MSIX_FLAGS_ENABLE
+#define msix_disable(control)         (control & ~PCI_MSIX_FLAGS_ENABLE)
+#define msix_table_size(control)       ((control & PCI_MSIX_FLAGS_QSIZE)+1)
+#define multi_msix_capable            msix_table_size
+#define msix_unmask(address)          (address & ~PCI_MSIX_FLAGS_BITMASK)
+#define msix_mask(address)            (address | PCI_MSIX_FLAGS_BITMASK)  
+#define msix_is_pending(address)       (address & PCI_MSIX_FLAGS_PENDMASK)
+
+#define _DEFINE_DBG_BUFFER      char __dbg_str_buf[256];
+#define _DBG_K_TRACE_ENTRY      ((unsigned int)0x00000001)
+#define _DBG_K_TRACE_EXIT      ((unsigned int)0x00000002)
+#define _DBG_K_INFO       ((unsigned int)0x00000004)
+#define _DBG_K_ERROR            ((unsigned int)0x00000008)
+#define _DBG_K_TRACE      (_DBG_K_TRACE_ENTRY | _DBG_K_TRACE_EXIT)
+
+#define _DEBUG_LEVEL      (_DBG_K_INFO | _DBG_K_ERROR | _DBG_K_TRACE)
+#define _DBG_PRINT( dbg_flags, args... )         \
+if ( _DEBUG_LEVEL & (dbg_flags) )                 \
+{                                        \
+     int len;                          \
+     len = sprintf(__dbg_str_buf, "%s:%d: %s ",    \
+           __FILE__, __LINE__, __FUNCTION__ );    \
+      sprintf(__dbg_str_buf + len, args);            \
+      printk(KERN_INFO "%s\n", __dbg_str_buf);   \
+}
+
+#define MSI_FUNCTION_TRACE_ENTER      \
+      _DBG_PRINT (_DBG_K_TRACE_ENTRY, "%s", "[Entry]");
+#define MSI_FUNCTION_TRACE_EXIT       \
+      _DBG_PRINT (_DBG_K_TRACE_EXIT, "%s", "[Entry]");
+     
+
+/*
+ * MSI Defined Data Structures
+ */
+
+extern unsigned long mp_lapic_addr;
+extern char __dbg_str_buf[256];
+
+struct msg_data {  
+     __u32      vector      :  8,       
+      delivery_mode      :  3,      /*      000b: FIXED
+                            001b: lowest priority
+                             111b: ExtINT */   
+      dest_mode   :  1,      /* 0: physical, 1: logical */  
+      reserved_1  :  2,
+      trigger           :  1,      /* 0: edge, 1: level */    
+      delivery_status      :  1,      /* 0: idle, 1: pending */  
+      reserved_2  : 16;
+} __attribute__ ((packed));
+
+struct msg_address {
+     union {
+           struct { __u32
+                 reserved_1        :  2,       
+                 dest_mode         :  1,      /* 0: physical, 
+                                            1: logical */  
+                 redirection_hint        :  1,        /* 0: to FSB, 
+                                            1: redirection */ 
+                 ext_dest_id       :  8,   /* Extended Dest. ID */ 
+                 dest_id                 :  8,      /* Destination ID */ 
+                 reserved_2        : 12;      /* 0xFEE */
+            }u;
+             __u32  value;
+      }lo_address;
+     __u32       hi_address;
+} __attribute__ ((packed));
+
+struct msi_desc_t {
+     struct {
+           __u32      type      : 5, /* {0: unused, 5h:MSI, 11h:MSI-X}
*/
+                 maskbit     : 1, /* mask-pending bit supported ?    */
+                 reserved: 2, /* reserved                */
+                 entry_nr: 8, /* specific enabled entry             */
+                 current_cpu: 16;/* current destination cpu   */
+      }msi_attrib;
+     void *mask_entry_addr;
+     struct pci_dev *dev;
+};
+
+#endif /* _ASM_PCI_MSI_H */
 
