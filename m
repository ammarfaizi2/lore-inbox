Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269516AbUJSXb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269516AbUJSXb2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270111AbUJSXYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:24:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:19082 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270166AbUJSWqk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:40 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257361528@kroah.com>
Date: Tue, 19 Oct 2004 15:42:16 -0700
Message-Id: <1098225736788@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.32, 2004/10/06 12:54:50-07:00, greg@kroah.com

[PATCH] PCI Hotplug: fix __iomem warnings in the compaq pci hotplug driver

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/cpqphp.h       |    6 +++---
 drivers/pci/hotplug/cpqphp_core.c  |   34 +++++++++++++++++++---------------
 drivers/pci/hotplug/cpqphp_nvram.h |   12 ++++++------
 drivers/pci/hotplug/cpqphp_pci.c   |   12 ++++++------
 4 files changed, 34 insertions(+), 30 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpqphp.h b/drivers/pci/hotplug/cpqphp.h
--- a/drivers/pci/hotplug/cpqphp.h	2004-10-19 15:24:53 -07:00
+++ b/drivers/pci/hotplug/cpqphp.h	2004-10-19 15:24:53 -07:00
@@ -268,7 +268,7 @@
 	struct timer_list task_event;
 	u8 hp_slot;
 	struct controller *ctrl;
-	void *p_sm_slot;
+	void __iomem *p_sm_slot;
 	struct hotplug_slot *hotplug_slot;
 };
 
@@ -287,7 +287,7 @@
 	struct controller *next;
 	u32 ctrl_int_comp;
 	struct semaphore crit_sect;	/* critical section semaphore */
-	void *hpc_reg;			/* cookie for our pci controller location */
+	void __iomem *hpc_reg;		/* cookie for our pci controller location */
 	struct pci_resource *mem_head;
 	struct pci_resource *p_mem_head;
 	struct pci_resource *io_head;
@@ -405,7 +405,7 @@
 /* controller functions */
 extern void	cpqhp_pushbutton_thread		(unsigned long event_pointer);
 extern irqreturn_t cpqhp_ctrl_intr		(int IRQ, void *data, struct pt_regs *regs);
-extern int	cpqhp_find_available_resources	(struct controller *ctrl, void *rom_start);
+extern int	cpqhp_find_available_resources	(struct controller *ctrl, void __iomem *rom_start);
 extern int	cpqhp_event_start_thread	(void);
 extern void	cpqhp_event_stop_thread		(void);
 extern struct pci_func *cpqhp_slot_create	(unsigned char busnumber);
diff -Nru a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
--- a/drivers/pci/hotplug/cpqphp_core.c	2004-10-19 15:24:53 -07:00
+++ b/drivers/pci/hotplug/cpqphp_core.c	2004-10-19 15:24:53 -07:00
@@ -55,9 +55,9 @@
 struct pci_func *cpqhp_slot_list[256];
 
 /* local variables */
-static void *smbios_table;
-static void *smbios_start;
-static void *cpqhp_rom_start;
+static void __iomem *smbios_table;
+static void __iomem *smbios_start;
+static void __iomem *cpqhp_rom_start;
 static int power_mode;
 static int debug;
 
@@ -123,10 +123,10 @@
  * Returns pointer to the head of the SMBIOS tables (or NULL)
  *
  */
-static void * detect_SMBIOS_pointer(void *begin, void *end)
+static void __iomem * detect_SMBIOS_pointer(void __iomem *begin, void __iomem *end)
 {
-	void *fp;
-	void *endp;
+	void __iomem *fp;
+	void __iomem *endp;
 	u8 temp1, temp2, temp3, temp4;
 	int status = 0;
 
@@ -232,13 +232,14 @@
  *
  * returns a pointer to an SMBIOS structure or NULL if none found
  */
-static void *get_subsequent_smbios_entry(void *smbios_start,
-			void *smbios_table, void *curr)
+static void __iomem *get_subsequent_smbios_entry(void __iomem *smbios_start,
+						void __iomem *smbios_table,
+						void __iomem *curr)
 {
 	u8 bail = 0;
 	u8 previous_byte = 1;
-	void *p_temp;
-	void *p_max;
+	void __iomem *p_temp;
+	void __iomem *p_max;
 
 	if (!smbios_table || !curr)
 		return(NULL);
@@ -282,8 +283,10 @@
  *
  * returns a pointer to an SMBIOS structure or %NULL if none found
  */
-static void *get_SMBIOS_entry(void *smbios_start, void *smbios_table, u8 type,
-			void * previous)
+static void __iomem *get_SMBIOS_entry(void __iomem *smbios_start,
+					void __iomem *smbios_table,
+					u8 type,
+					void __iomem *previous)
 {
 	if (!smbios_table)
 		return NULL;
@@ -319,8 +322,9 @@
 	kfree(slot);
 }
 
-static int ctrl_slot_setup(struct controller * ctrl, void *smbios_start,
-			void *smbios_table)
+static int ctrl_slot_setup(struct controller *ctrl,
+			void __iomem *smbios_start,
+			void __iomem *smbios_table)
 {
 	struct slot *new_slot;
 	u8 number_of_slots;
@@ -328,7 +332,7 @@
 	u8 slot_number;
 	u8 ctrl_slot;
 	u32 tempdword;
-	void *slot_entry= NULL;
+	void __iomem *slot_entry= NULL;
 	int result = -ENOMEM;
 
 	dbg("%s\n", __FUNCTION__);
diff -Nru a/drivers/pci/hotplug/cpqphp_nvram.h b/drivers/pci/hotplug/cpqphp_nvram.h
--- a/drivers/pci/hotplug/cpqphp_nvram.h	2004-10-19 15:24:53 -07:00
+++ b/drivers/pci/hotplug/cpqphp_nvram.h	2004-10-19 15:24:53 -07:00
@@ -30,26 +30,26 @@
 
 #ifndef CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM
 
-static inline void compaq_nvram_init (void *rom_start)
+static inline void compaq_nvram_init (void __iomem *rom_start)
 {
 	return;
 }
 
-static inline int compaq_nvram_load (void *rom_start, struct controller *ctrl)
+static inline int compaq_nvram_load (void __iomem *rom_start, struct controller *ctrl)
 {
 	return 0;
 }
 
-static inline int compaq_nvram_store (void *rom_start)
+static inline int compaq_nvram_store (void __iomem *rom_start)
 {
 	return 0;
 }
 
 #else
 
-extern void compaq_nvram_init	(void *rom_start);
-extern int compaq_nvram_load	(void *rom_start, struct controller *ctrl);
-extern int compaq_nvram_store	(void *rom_start);
+extern void compaq_nvram_init	(void __iomem *rom_start);
+extern int compaq_nvram_load	(void __iomem *rom_start, struct controller *ctrl);
+extern int compaq_nvram_store	(void __iomem *rom_start);
 
 #endif
 
diff -Nru a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
--- a/drivers/pci/hotplug/cpqphp_pci.c	2004-10-19 15:24:53 -07:00
+++ b/drivers/pci/hotplug/cpqphp_pci.c	2004-10-19 15:24:53 -07:00
@@ -51,10 +51,10 @@
  * find the Hot Plug Resource Table in the specified region of memory.
  *
  */
-static void *detect_HRT_floating_pointer(void *begin, void *end)
+static void __iomem *detect_HRT_floating_pointer(void __iomem *begin, void __iomem *end)
 {
-	void *fp;
-	void *endp;
+	void __iomem *fp;
+	void __iomem *endp;
 	u8 temp1, temp2, temp3, temp4;
 	int status = 0;
 
@@ -1162,12 +1162,13 @@
  *
  * returns 0 if success
  */  
-int cpqhp_find_available_resources (struct controller *ctrl, void *rom_start)
+int cpqhp_find_available_resources(struct controller *ctrl, void __iomem *rom_start)
 {
 	u8 temp;
 	u8 populated_slot;
 	u8 bridged_slot;
-	void *one_slot;
+	void __iomem *one_slot;
+	void __iomem *rom_resource_table;
 	struct pci_func *func = NULL;
 	int i = 10, index;
 	u32 temp_dword, rc;
@@ -1175,7 +1176,6 @@
 	struct pci_resource *p_mem_node;
 	struct pci_resource *io_node;
 	struct pci_resource *bus_node;
-	void *rom_resource_table;
 
 	rom_resource_table = detect_HRT_floating_pointer(rom_start, rom_start+0xffff);
 	dbg("rom_resource_table = %p\n", rom_resource_table);

