Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266123AbTGLQCV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbTGLQCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:02:21 -0400
Received: from fmr03.intel.com ([143.183.121.5]:1260 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id S266123AbTGLP6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 11:58:41 -0400
Date: Sat, 12 Jul 2003 09:13:21 -0700
From: Dely Sy <dlsy@unix-os.sc.intel.com>
Message-Id: <200307121613.h6CGDLM28357@unix-os.sc.intel.com>
To: linux-kernel@vger.kernel.org
Subject: [Patch] 3/4 PCI Hot-plug driver patch for 2.5.74 kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 3 of 4 PCI Hot-plug driver patch for 2.5.74 kernel

diff -Nru a/drivers/pci/hotplug/cpqphp_hpc.c b/drivers/pci/hotplug/cpqphp_hpc.c
--- a/drivers/pci/hotplug/cpqphp_hpc.c	1969-12-31 16:00:00.000000000 -0800
+++ b/drivers/pci/hotplug/cpqphp_hpc.c	2003-07-07 09:32:22.000000000 -0700
@@ -0,0 +1,1203 @@
+/*
+ * Compaq PCI Hot Plug Driver
+ *
+ * Copyright (c) 1995,2001 Compaq Computer Corporation
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <dely.l.sy@intel.com>
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/pci.h>
+#include <linux/delay.h>  /* for delays */
+#include <asm/system.h>
+#include "cpqphp.h"
+
+#ifdef DEBUG
+#define DBG_K_TRACE_ENTRY      ((unsigned int)0x00000001)	/* On function entry */
+#define DBG_K_TRACE_EXIT       ((unsigned int)0x00000002)	/* On function exit */
+#define DBG_K_INFO             ((unsigned int)0x00000004)	/* Info messages */
+#define DBG_K_ERROR            ((unsigned int)0x00000008)	/* Error messages */
+#define DBG_K_TRACE            (DBG_K_TRACE_ENTRY|DBG_K_TRACE_EXIT)
+#define DBG_K_STANDARD         (DBG_K_INFO|DBG_K_ERROR|DBG_K_TRACE)
+/* Redefine this flagword to set debug level */
+#define DEBUG_LEVEL            DBG_K_STANDARD
+
+#define DEFINE_DBG_BUFFER     char __dbg_str_buf[256];
+
+#define DBG_PRINT( dbg_flags, args... )                  \
+	do {                                             \
+	  if ( DEBUG_LEVEL & ( dbg_flags ) )             \
+	  {                                              \
+	    int len;                                     \
+	    len = sprintf( __dbg_str_buf, "%s:%d: %s: ", \
+		  __FILE__, __LINE__, __FUNCTION__ );    \
+	    sprintf( __dbg_str_buf + len, args );        \
+	    printk( KERN_NOTICE "%s\n", __dbg_str_buf ); \
+	  }                                              \
+	} while (0)
+
+#define DBG_ENTER_ROUTINE	DBG_PRINT (DBG_K_TRACE_ENTRY, "%s", "[Entry]");
+#define DBG_LEAVE_ROUTINE	DBG_PRINT (DBG_K_TRACE_EXIT, "%s", "[Exit]");
+#else
+#define DEFINE_DBG_BUFFER
+#define DBG_ENTER_ROUTINE
+#define DBG_LEAVE_ROUTINE
+#endif				/* DEBUG */
+
+struct ctrl_reg {		/* offset */
+	u8 slot_RST;		/* 0x00 */	
+	u8 slot_enable;		/* 0x01 */
+	u16 misc;		/* 0x02 */
+	u32 led_control;	/* 0x04 */
+	u32 int_input_clear;	/* 0x08 */
+	u32 int_mask;		/* 0x0a */
+	u8 reserved0;		/* 0x10 */
+	u8 reserved1;		/* 0x11 */
+	u8 reserved2;		/* 0x12 */
+	u8 gen_output_AB;	/* 0x13 */
+	u32 non_int_input;	/* 0x14 */
+	u32 reserved3;		/* 0x18 */
+	u32 reserved4;		/* 0x1a */
+	u32 reserved5;		/* 0x20 */
+	u8 reserved6;		/* 0x24 */
+	u8 reserved7;		/* 0x25 */
+	u16 reserved8;		/* 0x26 */
+	u8 slot_mask;		/* 0x28 */
+	u8 reserved9;		/* 0x29 */
+	u8 reserved10;		/* 0x2a */
+	u8 reserved11;		/* 0x2b */
+	u8 slot_SERR;		/* 0x2c */
+	u8 slot_power;		/* 0x2d */
+	u8 reserved12;		/* 0x2e */
+	u8 reserved13;		/* 0x2f */
+	u8 next_curr_freq;	/* 0x30 */
+	u8 reset_freq_mode;	/* 0x31 */
+
+} __attribute__ ((packed));
+
+/* offsets to the controller registers based on the above structure layout */
+enum ctrl_offsets {
+	SLOT_RST = 		offsetof(struct ctrl_reg, slot_RST),
+	SLOT_ENABLE =		offsetof(struct ctrl_reg, slot_enable),
+	MISC =			offsetof(struct ctrl_reg, misc),
+	LED_CONTROL =		offsetof(struct ctrl_reg, led_control),
+	INT_INPUT_CLEAR =	offsetof(struct ctrl_reg, int_input_clear),
+	INT_MASK = 		offsetof(struct ctrl_reg, int_mask),
+	CTRL_RESERVED0 = 	offsetof(struct ctrl_reg, reserved0),
+	CTRL_RESERVED1 =	offsetof(struct ctrl_reg, reserved1),
+	CTRL_RESERVED2 =	offsetof(struct ctrl_reg, reserved1),
+	GEN_OUTPUT_AB = 	offsetof(struct ctrl_reg, gen_output_AB),
+	NON_INT_INPUT = 	offsetof(struct ctrl_reg, non_int_input),
+	CTRL_RESERVED3 =	offsetof(struct ctrl_reg, reserved3),
+	CTRL_RESERVED4 =	offsetof(struct ctrl_reg, reserved4),
+	CTRL_RESERVED5 =	offsetof(struct ctrl_reg, reserved5),
+	CTRL_RESERVED6 =	offsetof(struct ctrl_reg, reserved6),
+	CTRL_RESERVED7 =	offsetof(struct ctrl_reg, reserved7),
+	CTRL_RESERVED8 =	offsetof(struct ctrl_reg, reserved8),
+	SLOT_MASK = 		offsetof(struct ctrl_reg, slot_mask),
+	CTRL_RESERVED9 = 	offsetof(struct ctrl_reg, reserved9),
+	CTRL_RESERVED10 =	offsetof(struct ctrl_reg, reserved10),
+	CTRL_RESERVED11 =	offsetof(struct ctrl_reg, reserved11),
+	SLOT_SERR =		offsetof(struct ctrl_reg, slot_SERR),
+	SLOT_POWER =		offsetof(struct ctrl_reg, slot_power),
+	CTRL_RESERVED12 =	offsetof(struct ctrl_reg, reserved12),
+	CTRL_RESERVED13 =	offsetof(struct ctrl_reg, reserved13),
+	NEXT_CURR_FREQ =	offsetof(struct ctrl_reg, next_curr_freq),
+	RESET_FREQ_MODE =	offsetof(struct ctrl_reg, reset_freq_mode),
+};
+
+
+struct sema_struct {
+	struct semaphore crit_sect;
+	int owner_id;
+	int count;
+};
+
+struct php_ctlr_state_s {
+	struct php_ctlr_state_s *pnext;
+	struct pci_dev *pci_dev;
+	unsigned int irq;
+	struct sema_struct hwlock;
+	unsigned long flags;	/* spinlock's */
+	u32 ctrl_int_comp;		/* interrupt comparator */
+	u32 first_device_num;
+	u32 num_slots;
+	u16 ctlrcap;
+	php_intr_callback_t switch_change_callback;
+	php_intr_callback_t presence_change_callback;
+	php_intr_callback_t power_fault_callback;
+	void *callback_instance_id;
+	void *creg;				/* Ptr to controller register space */
+};
+
+
+spinlock_t hpc_event_lock;
+
+DEFINE_DBG_BUFFER		/* Debug string buffer for entire HPC defined here */
+static struct php_ctlr_state_s *php_ctlr_list_head = 0;	/* HPC state linked list */
+static int ctlr_seq_num = 0;	/* Controller sequenc # */
+
+static irqreturn_t hpc_isr(int IRQ, void *dev_id, struct pt_regs *regs);
+
+static wait_queue_head_t delay_wait_q_head;
+
+/* delay in jiffies to wait */
+static void longdelay(int delay)
+{
+	init_waitqueue_head(&delay_wait_q_head);
+
+	interruptible_sleep_on_timeout(&delay_wait_q_head, delay);
+}
+
+static void cpqhpc_set_SOGO (struct slot *slot)
+{
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+	u16 misc;
+
+	misc = readw(php_ctlr->creg + MISC);
+	misc = (misc | 0x0001) & 0xFFFB;
+	writew(misc, php_ctlr->creg + MISC);
+}
+
+static int cpqhpc_wait_for_SOBS (struct slot *slot)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	int retval = 0;
+
+	DBG_ENTER_ROUTINE 
+
+	add_wait_queue(&slot->ctrl->queue, &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
+	schedule_timeout(2*HZ);
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(&slot->ctrl->queue, &wait);
+	if (signal_pending(current))
+		retval =  -EINTR;
+
+	DBG_LEAVE_ROUTINE 
+	return retval;
+}
+
+static void hpc_update_hpc(struct slot *slot)
+{
+	cpqhpc_set_SOGO(slot);
+	cpqhpc_wait_for_SOBS(slot);
+}
+
+static int hpc_get_attention_status(struct slot *slot, u8 *status)
+{
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+	u32 led_control;
+
+	DBG_ENTER_ROUTINE 
+
+	led_control = readl(php_ctlr->creg + LED_CONTROL);
+	led_control &= (0x01010000L << slot->hp_slot);
+	*status = led_control ? 1 : 0;
+
+	DBG_LEAVE_ROUTINE 
+	return 0;
+}
+
+static int hpc_get_power_status(struct slot * slot, u8 *status)
+{
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+	u8 slot_enable;
+
+	DBG_ENTER_ROUTINE 
+
+	slot_enable = readb(php_ctlr->creg + SLOT_ENABLE);
+	slot_enable &= (0x01L << slot->hp_slot);
+	*status = slot_enable ? 1 : 0;
+
+	DBG_LEAVE_ROUTINE 
+	return 0;
+}
+
+static int hpc_get_latch_status(struct slot *slot, u8 *status)
+{
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+	u32 latch_status;
+
+	DBG_ENTER_ROUTINE 
+
+	latch_status = (readl(php_ctlr->creg + INT_INPUT_CLEAR) & (0x01L << slot->hp_slot));
+	*status = (latch_status == 0) ? 1 : 0;
+
+	DBG_LEAVE_ROUTINE 
+	return 0;
+}
+
+static int hpc_get_adapter_status(struct slot *slot, u8 *status)
+{
+	u8 presence_save = 0;
+	u32 tempdword;
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+
+	DBG_ENTER_ROUTINE 
+
+	tempdword = readl(php_ctlr->creg + INT_INPUT_CLEAR);
+	presence_save = (u8) ((((~tempdword) >> 23) | ((~tempdword) >> 15)) >> slot->hp_slot) & 0x02;
+
+	*status = (presence_save != 0) ? 1 : 0;
+
+	DBG_LEAVE_ROUTINE 
+	return 0;
+}
+
+static int hpc_query_power_fault(struct slot * slot)
+{
+	u32 status;
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+	u32 tempdword;
+
+	DBG_ENTER_ROUTINE 
+
+	tempdword = readl(php_ctlr->creg + INT_INPUT_CLEAR);
+	status = (tempdword & (0x00000100 << slot->hp_slot));
+
+	DBG_LEAVE_ROUTINE
+	/* Note: Logic 0 => fault */
+	return status ? 0 : 1;
+}
+
+/*
+ * change to call set_led_state()
+ */
+
+static void hpc_set_attention_status(struct slot *slot, u8 status)
+{
+	struct php_ctlr_state_s *php_ctlr =(struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+	u32 led_control;
+	
+	switch (status) {
+	case 0:
+		led_control = readl(php_ctlr->creg + LED_CONTROL);
+		led_control &= ~(0x01010000L << slot->hp_slot);
+		writel(led_control, php_ctlr->creg + LED_CONTROL);
+		break;
+	case 1:
+		led_control = readl(php_ctlr->creg + LED_CONTROL);
+		led_control |= (0x01010000L << slot->hp_slot);
+		writel(led_control, php_ctlr->creg + LED_CONTROL);
+		break;
+	}
+}
+
+static void hpc_green_led_on(struct slot * slot)
+{
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+	u32 led_control;
+	
+	led_control = readl(php_ctlr->creg + LED_CONTROL);
+	led_control |= 0x0101L << slot->hp_slot;
+	writel(led_control, php_ctlr->creg + LED_CONTROL);
+
+}
+
+static void hpc_green_led_off(struct slot * slot)
+{
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+	u32 led_control;
+	
+	led_control = readl(php_ctlr->creg + LED_CONTROL);
+	led_control &= ~(0x0101L << slot->hp_slot);
+	writel(led_control, php_ctlr->creg + LED_CONTROL);
+
+}
+
+static void hpc_green_led_blink(struct slot * slot)
+{
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+	u32 led_control;
+	
+	led_control = readl(php_ctlr->creg + LED_CONTROL);
+	led_control &= ~(0x0101L << slot->hp_slot);
+	led_control |= (0x0001L << slot->hp_slot);
+	writel(led_control, php_ctlr->creg + LED_CONTROL);
+
+}
+
+/*
+ * 0: all 4 variables set
+ * 1: no physical_slot_num
+ */
+int phphpc_get_ctlr_slot_config(struct controller *ctrl,
+	int *num_ctlr_slots,	/* number of slots in this HPC			*/
+	int *first_device_num,	/* PCI dev num of the first slot in this HPC	*/
+	int *physical_slot_num,	/* phy slot num of the first slot in this HPC	*/
+	int *updown,		/* physical_slot_num increament: 1 or -1	*/
+	int *flags)
+{
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) ctrl->hpc_ctlr_handle;
+
+	DBG_ENTER_ROUTINE 
+
+	* first_device_num = php_ctlr->first_device_num;
+	*num_ctlr_slots = php_ctlr->num_slots;
+
+	/* this HPC does not conform to SHPC and provides no physical_slot_num. */
+	*physical_slot_num = -1;
+
+	*updown = 1;		/* could be -1 in SHPC */
+	*flags = 1;
+	DBG_LEAVE_ROUTINE 
+	return 0;
+}
+
+static void hpc_release_ctlr(struct controller *ctrl)
+{
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) ctrl->hpc_ctlr_handle;
+	struct php_ctlr_state_s *p, *p_prev;
+
+	DBG_ENTER_ROUTINE 
+
+	if (php_ctlr->irq) {
+		free_irq(php_ctlr->irq, ctrl);
+		php_ctlr->irq = 0;
+	}
+
+	if (php_ctlr->pci_dev) {
+		iounmap((void *) pci_resource_start(php_ctlr->pci_dev, 0));
+		release_mem_region(pci_resource_start(php_ctlr->pci_dev, 0), pci_resource_len(php_ctlr->pci_dev, 0));
+		php_ctlr->pci_dev = 0;
+	}
+
+	p = php_ctlr_list_head;
+	p_prev = NULL;
+	while (p) {
+		if (p == php_ctlr) {
+			if (p_prev)
+				p_prev->pnext = p->pnext;
+			else
+				php_ctlr_list_head = p->pnext;
+			break;
+		} else {
+			p_prev = p;
+			p = p->pnext;
+		}
+	}
+
+	kfree(php_ctlr);
+
+	DBG_LEAVE_ROUTINE
+}
+
+static int hpc_power_on_slot(struct slot * slot)
+{
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+	u8 slot_enable;
+
+	DBG_ENTER_ROUTINE 
+
+	slot_enable = readb(php_ctlr->creg + SLOT_ENABLE);
+	slot_enable |= (0x01 << slot->hp_slot);
+	writeb(slot_enable, php_ctlr->creg + SLOT_ENABLE);
+
+	DBG_LEAVE_ROUTINE
+	return 0;
+}
+
+static int hpc_power_off_slot(struct slot * slot)
+{
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+	u8 slot_enable;
+
+	DBG_ENTER_ROUTINE 
+
+	slot_enable = readb(php_ctlr->creg + SLOT_ENABLE);
+	slot_enable &= ~(0x01 << slot->hp_slot);
+	writeb(slot_enable, php_ctlr->creg + SLOT_ENABLE);
+
+	DBG_LEAVE_ROUTINE
+
+	return 0;
+}
+
+static void hpc_enable_msl_interrupt(struct slot *slot)
+{
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+	u32 rc;
+	u16 misc;
+
+	DBG_ENTER_ROUTINE 
+
+	if (php_ctlr->creg) {
+		rc = readb(php_ctlr->creg + SLOT_ENABLE);
+		
+		writeb(rc, php_ctlr->creg + SLOT_SERR);
+		writel(0xFFFFFFC0L | ~rc, php_ctlr->creg + INT_MASK);
+			
+		misc = readw(php_ctlr->creg + MISC);
+		misc &= 0xFFFD;
+		writew(misc, php_ctlr->creg + MISC);
+	}
+
+	DBG_LEAVE_ROUTINE
+}
+
+static u32 hpc_get_slot_capability(struct slot *slot)
+{
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+	u32 slot_state = 0, temp;
+	u8 slot_enable;
+
+	DBG_ENTER_ROUTINE 
+
+	temp = readl(php_ctlr->creg + INT_INPUT_CLEAR);
+
+	/* Check presence */
+	slot_state |= ((((~temp) >> 23) | ((~temp) >> 15)) >> slot->hp_slot) & 0x02;
+	/* Check the switch state */
+	slot_state |= ((~temp & 0xFF) >> slot->hp_slot) & 0x01;
+	/* Check the slot enable */
+	slot_enable = readb(php_ctlr->creg + SLOT_ENABLE);
+	slot_state |= ((slot_enable << 2) >> slot->hp_slot) & 0x04;
+
+	return slot_state;
+
+	DBG_LEAVE_ROUTINE
+}
+
+static irqreturn_t hpc_isr(int IRQ, void *dev_id, struct pt_regs *regs)
+{
+	struct controller *ctrl = (struct controller *)dev_id;
+	struct php_ctlr_state_s *php_ctlr;
+	u8 schedule_flag = 0;
+	u32 Diff;
+	u32 temp_dword;
+	u16 misc;
+	u8 reset;
+
+	if (!ctrl || !(php_ctlr = ctrl->hpc_ctlr_handle) || !php_ctlr->creg)
+		return IRQ_NONE;
+
+	/* Check to see if it was our interrupt */
+	misc = readw(php_ctlr->creg + MISC);
+	if (!(misc & 0x000C))
+		return IRQ_NONE;
+
+	if (misc & 0x0004) {
+		/* Serial Output interrupt Pending */
+		misc |= 0x0004;	/* Clear the interrupt */
+		writew(misc, php_ctlr->creg + MISC);
+		misc = readw(php_ctlr->creg + MISC);	/* Read to clear posted writes */
+		wake_up_interruptible(&ctrl->queue);
+	}
+
+	if (misc & 0x0008) {
+		/* General-interrupt-input interrupt Pending */
+		Diff = readl(php_ctlr->creg + INT_INPUT_CLEAR) ^ php_ctlr->ctrl_int_comp;
+
+		php_ctlr->ctrl_int_comp = readl(php_ctlr->creg + INT_INPUT_CLEAR);
+
+		writel(Diff, php_ctlr->creg + INT_INPUT_CLEAR);	/* Clear the interrupt */
+
+		/* Read it back to clear any posted writes */
+		temp_dword = readl(php_ctlr->creg + INT_INPUT_CLEAR);
+
+		if (!Diff)
+			writel(0xFFFFFFFF, php_ctlr->creg + INT_INPUT_CLEAR);	/* Clear all interrupts */
+
+		if (php_ctlr->switch_change_callback)
+			schedule_flag += php_ctlr->switch_change_callback(
+				(Diff & 0xFFL), php_ctlr->callback_instance_id);
+		if (php_ctlr->presence_change_callback)
+			schedule_flag += php_ctlr->presence_change_callback(
+				((Diff & 0xFFFF0000L) >> 16), php_ctlr->callback_instance_id);
+		if (php_ctlr->power_fault_callback)
+			schedule_flag += php_ctlr->power_fault_callback(
+				((Diff & 0xFF00L) >> 8), php_ctlr->callback_instance_id);
+	}
+
+	/* Setting bus speed is applicable only to Compaq HPC with rev >= 0x13 
+	 * or with subsystem_device == PCI_SUB_HPC_ID4 
+	 */
+	if ((ctrl->pci_dev->subsystem_vendor == PCI_VENDOR_ID_COMPAQ) && 
+		((ctrl->rev >= 0x13) || (ctrl->pci_dev->subsystem_device == PCI_SUB_HPC_ID4))) {
+		reset = readb(php_ctlr->creg + RESET_FREQ_MODE);
+		if (reset & 0x40) {
+			/* Bus reset has completed */
+			reset &= 0xCF;
+			writeb(reset, php_ctlr->creg + RESET_FREQ_MODE);
+			reset = readb(php_ctlr->creg + RESET_FREQ_MODE);
+			wake_up_interruptible(&ctrl->queue);
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+int phphpc_get_ctrl_cap(struct controller *ctrl, u16 * pctlrcap, u8 * prev)
+{
+	u16 vendor_id;
+	u16 subsystem_vid;
+	u16 subsystem_did;
+	u32 rc;
+	u8 bus_cap;
+	struct pci_dev *pdev;
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) ctrl->hpc_ctlr_handle;
+
+	DBG_ENTER_ROUTINE 
+
+	if (!ctrl->hpc_ctlr_handle) {
+		err("Process %d: Invalid HPC controller handle!\n", current->pid);
+		return -1;
+	}
+
+	if (!pctlrcap) {
+		err("Process %d: Invalid HPC ctrlcap pointer passed in!\n", current->pid);
+		return -1;
+	}
+
+	if (!prev) {
+		err("Process %d: Invalid HPC rev pointer passed in!\n", current->pid);
+		return -1;
+	}
+
+	dbg("Pass in ctlrcap = %x\n", *pctlrcap);
+
+	if (!php_ctlr->pci_dev) {
+		err("Process %d: Invalid HPC controller pci_dev!\n", current->pid);
+		return -1;
+	}
+
+	pdev = php_ctlr->pci_dev;
+
+	/* Need to read VID early b/c it's used to differentiate CPQ and INTC discovery */
+	vendor_id = pdev->vendor;
+	if ((vendor_id != PCI_VENDOR_ID_COMPAQ) && (vendor_id != PCI_VENDOR_ID_INTEL)) {
+		err ("%s: HPC controller(vendor=%x) not supported by this driver!\n", __FUNCTION__, vendor_id);
+		return -1;
+	}
+
+	rc = pci_read_config_byte(pdev, PCI_REVISION_ID, prev);
+	dbg("Vendor ID: %x revision: %x\n", vendor_id, *prev);
+	if (rc || ((vendor_id == PCI_VENDOR_ID_COMPAQ) && (!(*prev)))) {
+		err("%s: Unsupported revision of HPC controller found!\n", __FUNCTION__);
+		return -1;
+	}
+
+	/*
+	 *  Check for the proper subsytem ID's
+	 *  Intel uses a different SSID programming model than Compaq.  For Intel, each
+	 *  SSID bit identifies a PHP capability.
+	 *  Also Intel HPC's may have RID=0.
+	 */
+	if ((*prev > 2) || (vendor_id == PCI_VENDOR_ID_INTEL)) {
+		subsystem_vid = pdev->subsystem_vendor;
+		subsystem_did = pdev->subsystem_device;
+		dbg("Sub-Vendor ID: %x, Sub-Device ID: %x\n", subsystem_vid, subsystem_did);
+		if ((subsystem_vid != PCI_VENDOR_ID_COMPAQ) && (subsystem_vid != PCI_VENDOR_ID_INTEL)) {
+			err("%s: HPC controller not supported by this driver!\n", __FUNCTION__);
+			return -1;
+		}
+
+		/* Set Default values of "0" for everything */
+		*pctlrcap = 0;
+		
+		/* 
+		 * Interpretation of bit pattern in *pctlrcap
+		 * Based on Intel PHPC SSVID/SID Programming Model
+		 * Bit 0 Speed_capability:       0 = 33MHz, 1 = 66MHz
+		 * Bit 1 Push_button :           0 = pushbutton present, 1 = no pushbutton
+		 * Bit 2 Slot_switch_type:       0 = switch present, 1 = no switch
+		 * Bit 3 DeFeature PHP:          0 = PHP not supported, 1 = PHP supported
+		 * Bit 4 Alternate_base_address: 0 = not supported, 1 = supported
+		 * Bit 5 PCI_config_space: Index/data access to working registers
+		 *                               0 = not supported, 1 = supported
+		 * Bit 6 PCIX_speed: 0 = 100Mhz PCI-X if Bit 7 is 1 and Bit 0 is 0,
+		 *                        66MHz PCI_X if Bit 7 is 1 and Bit 0 is 1
+		 *                   1 = 133MHz PCI-X if Bit 7 is 1
+		 * Bit 7 PCIX_support:           0 = conventional PCI, 1 = PCI-X
+		 * Bit 8-15  Reserved
+		 */
+		if (subsystem_vid == PCI_VENDOR_ID_COMPAQ) {
+			switch ( *prev >= 0x13) { 
+			case 0: 
+				if (subsystem_did == PCI_SUB_HPC_ID) {
+					*pctlrcap = 0x2A;	/* sw, 33, no pb, no pcix	*/
+					break;
+				} else if (subsystem_did == PCI_SUB_HPC_ID2) {
+					*pctlrcap = 0x28;	/* sw, 33, pb, no pcix	*/
+					break;
+				} else if (subsystem_did == PCI_SUB_HPC_ID_INTC) {
+					*pctlrcap = 0x2A;	/* sw, 33, no pb, no pcix	*/
+					break;
+				} else if (subsystem_did == PCI_SUB_HPC_ID3) {
+					*pctlrcap = 0x29;	/* sw, 66, pb, no pcix	*/
+					break;
+				} else if (subsystem_did == PCI_SUB_HPC_ID4) {
+					*pctlrcap = 0xA8;	/* sw, 100, pb, pcix	*/
+					break;
+				} else {
+					err("%s: unsupported Sub-Device ID: %x\n", __FUNCTION__, subsystem_did);
+					php_ctlr->ctlrcap = 0;
+					return -1;
+				}
+			case 1:	/* True for CIOBX */
+				pci_read_config_byte(pdev, 0x41, &bus_cap);
+				if (bus_cap & 0x80) {
+					*pctlrcap = 0xE8;	/* sw, 133, pb, pcix	*/
+					break;
+				} else if (bus_cap & 0x40) {
+					*pctlrcap = 0xA8;	/* sw, 100, pb, pcix	*/
+					break;
+				} else if (bus_cap & 0x20) {
+					*pctlrcap = 0xA9;	/* sw, 66, pb, pcix	*/
+					break;
+				} else if (bus_cap & 0x10) {
+					*pctlrcap = 0x29;	/* sw, 100, pb, no pcix	*/
+					break;
+				} else {
+					*pctlrcap = 0xA9;	/* default to sw, 66, pb, pcix	*/
+					break;
+				}
+			}
+		} else if (subsystem_vid == PCI_VENDOR_ID_INTEL) {
+			*pctlrcap = subsystem_did;
+		} else
+			err("%s: unsupported Sub-Vendor ID: %x\n", __FUNCTION__, subsystem_vid);
+
+		php_ctlr->ctlrcap = *pctlrcap;
+	}
+
+	dbg("ctlrcap = %x\n", *pctlrcap);
+
+	DBG_LEAVE_ROUTINE 
+	return 0;
+}
+
+static int hpc_get_max_bus_speed (struct slot *slot, enum pci_bus_speed *value)
+{
+	enum pci_bus_speed bus_speed = PCI_SPEED_UNKNOWN;
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+
+	DBG_ENTER_ROUTINE 
+	if (!slot->ctrl->hpc_ctlr_handle) {
+		err("%s: Invalid HPC controller handle!\n", __FUNCTION__);
+		return -1;
+	}
+
+	/* PCI-X support */
+	if (php_ctlr->ctlrcap & 0x0080) {
+		/* Frequency of operation in PCI-X mode */
+		if (php_ctlr->ctlrcap & 0x0040) {
+			bus_speed = PCI_SPEED_133MHz_PCIX;
+		} else {
+			if (php_ctlr->ctlrcap & 0x0001)
+				bus_speed = PCI_SPEED_66MHz_PCIX;
+			else
+				bus_speed = PCI_SPEED_100MHz_PCIX;
+		}
+	} else {
+		if (php_ctlr->ctlrcap & 0x0001)
+			bus_speed = PCI_SPEED_66MHz;
+		else
+			bus_speed = PCI_SPEED_33MHz;
+	}
+
+	*value = bus_speed;
+
+	dbg("Supported bus speed = %d\n", bus_speed);
+	DBG_LEAVE_ROUTINE 
+	return 0;
+}
+
+static int hpc_get_adapter_speed(struct slot *slot, enum pci_bus_speed *value)
+{
+	u8 adapter_speed = PCI_SPEED_UNKNOWN;
+	u8 m66cap, pcixcap1, pcixcap2;
+	u8 temp_byte;
+
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+
+	DBG_ENTER_ROUTINE 
+	if (!slot->ctrl->hpc_ctlr_handle) {
+		err("%s: Invalid HPC controller handle!\n", __FUNCTION__);
+		return -1;
+	}
+
+	if (slot->hp_slot >= php_ctlr->num_slots) {
+		err("%s: Invalid HPC slot number!\n", __FUNCTION__);
+		return -1;
+	}
+
+	down(&slot->ctrl->crit_sect);
+
+	/* turn on board without attaching to the bus */
+	temp_byte = readb(php_ctlr->creg + SLOT_POWER);
+	temp_byte |= (0x01 << slot->hp_slot);
+	writeb(temp_byte, php_ctlr->creg + SLOT_POWER);
+
+	hpc_update_hpc(slot);
+
+	/* Change bits in slot power register to force another shift out */
+	/* NOTE: this is to work around the timer bug */
+	temp_byte = readb(php_ctlr->creg + SLOT_POWER);
+	writeb(0x00, php_ctlr->creg + SLOT_POWER);
+	writeb(temp_byte, php_ctlr->creg + SLOT_POWER);
+
+	hpc_update_hpc(slot);
+
+	longdelay(6 * (HZ / 10));
+
+	m66cap = readl(php_ctlr->creg + NON_INT_INPUT) & 0xff;
+	pcixcap1 = (readl(php_ctlr->creg + NON_INT_INPUT) >> 8) & 0xff;
+	pcixcap2 = (readl(php_ctlr->creg + NON_INT_INPUT) >> 16) & 0xff;
+	dbg("m66cap = %x\n", m66cap);
+
+	if (php_ctlr->ctlrcap & PCIXSupport) {
+		if ((pcixcap1 >> slot->hp_slot) & 1) {
+			if ((pcixcap2 >> slot->hp_slot) & 1)
+				adapter_speed = PCI_SPEED_133MHz_PCIX;
+			else
+				adapter_speed = PCI_SPEED_66MHz_PCIX;
+		} else {
+			if ((m66cap >> slot->hp_slot) & 1)
+				adapter_speed = PCI_SPEED_66MHz;
+			else
+				adapter_speed = PCI_SPEED_33MHz;
+		}
+	} else {
+		if ((m66cap >> slot->hp_slot) & 1)
+			adapter_speed = PCI_SPEED_66MHz;
+		else
+			adapter_speed = PCI_SPEED_33MHz;
+	}
+
+	/* turn off board without attaching to the bus */
+	temp_byte = readb(php_ctlr->creg + SLOT_POWER);
+	temp_byte &= ~(0x01 << slot->hp_slot);
+	writeb(temp_byte, php_ctlr->creg + SLOT_POWER);
+
+	hpc_update_hpc(slot);
+
+	/* Done with exclusive hardware access */
+	up(&slot->ctrl->crit_sect);
+
+	*value = adapter_speed;
+	dbg("Adapter speed = %d\n", adapter_speed);
+	DBG_LEAVE_ROUTINE 
+	return 0;
+}
+
+static int hpc_get_cur_bus_speed (struct slot *slot, enum pci_bus_speed *value)
+{
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+	u32 pci_misc_config;
+	enum pci_bus_speed bus_speed = PCI_SPEED_UNKNOWN;
+	u16 temp_word;
+	u32 temp_dword;
+	struct pci_dev *dev;
+	u8 curr_freq;
+	struct controller *ctrl;
+
+	DBG_ENTER_ROUTINE 
+	if (!slot->ctrl->hpc_ctlr_handle || !php_ctlr->pci_dev) {
+		err("%s: Invalid HPC controller handle!\n", __FUNCTION__);
+		return -1;
+	}
+
+	ctrl = slot->ctrl;
+
+	if ((php_ctlr->pci_dev->vendor == PCI_VENDOR_ID_INTEL) &&
+		(php_ctlr->pci_dev->device == PCI_INTC_P64H2_DID)) {
+
+		/*
+		 * For P64H2 hpc, bus speed is determined by P64H2_HUB
+		 * Let's find P64H2_HUB on this bus.
+		 */
+		dev = pci_find_subsys(PCI_VENDOR_ID_INTEL, PCI_INTC_P64H2_HUB_PCI, PCI_ANY_ID, PCI_ANY_ID, NULL);
+		if (dev == NULL)
+			info("Can't find VID-0x8086 DID-0x1460\n");
+
+		while (dev != NULL) {
+			pci_read_config_word(dev, 0x40, &temp_word);
+			pci_read_config_dword(dev, 0x18, &temp_dword);
+			dbg("%s: bus=%x dev=%x, CNF=%x, BNUM=%x\n", __FUNCTION__, dev->bus->number, PCI_SLOT(dev->devfn), temp_word, temp_dword);
+			if (((temp_dword & 0x0000ff00) >> 8) == php_ctlr->pci_dev->bus->number) {
+				if ((temp_word & 0x0100) == 0x0100) {
+					if ((temp_word & 0x00c0) == 0x00c0)
+						bus_speed = PCI_SPEED_133MHz_PCIX;
+					else if ((temp_word & 0x0080) == 0x0080)
+						bus_speed = PCI_SPEED_100MHz_PCIX;
+					else if ((temp_word & 0x0040) == 0x0040)
+						bus_speed = PCI_SPEED_66MHz_PCIX;
+				} else {
+					if ((temp_word & 0x0040) == 0x0040)
+						bus_speed = PCI_SPEED_66MHz;
+					else if ((temp_word & 0x00c0) == 0)
+						bus_speed = PCI_SPEED_33MHz;
+				}
+				break;
+			}
+			dev = pci_find_subsys(PCI_VENDOR_ID_INTEL, PCI_INTC_P64H2_HUB_PCI, PCI_ANY_ID, PCI_ANY_ID, dev);
+		}
+	} else {
+		if (php_ctlr->ctlrcap & PCIXSupport) {
+			if ((ctrl->pci_dev->subsystem_vendor == PCI_VENDOR_ID_COMPAQ) && 
+				((ctrl->rev >= 0x13) || (ctrl->pci_dev->subsystem_device == PCI_SUB_HPC_ID4))) {
+				/* for Compaq CIOBX or PCI_SUB_HPC_ID4 */
+				curr_freq = readb(php_ctlr->creg + NEXT_CURR_FREQ);
+				if ((curr_freq & 0xB0) == 0xB0)
+					bus_speed = PCI_SPEED_133MHz_PCIX;
+				else if ((curr_freq & 0xA0) == 0xA0)
+					bus_speed = PCI_SPEED_100MHz_PCIX;
+				else if ((curr_freq & 0x90) == 0x90)
+					bus_speed = PCI_SPEED_66MHz_PCIX;
+				else if ((curr_freq & 0x10) == 0x10)
+					bus_speed = PCI_SPEED_66MHz;
+				else bus_speed = PCI_SPEED_33MHz;
+			} else {  /* all others */
+
+				pci_read_config_dword(php_ctlr->pci_dev, 0x40, &pci_misc_config);
+				/* Read HPC PCI Misc. Configuration at offset 40h */
+
+				dbg("HPC PCI Misc Config = %x\n", pci_misc_config);
+
+				if (pci_misc_config & 0x00200000) {	/* Bit 21 of PCI Misc. Config. */
+					if (readw(php_ctlr->creg + MISC) & 0x8000) {	/* Bit 31 - 133 MHZ Prescale indicator */
+						if (readw(php_ctlr->creg + MISC) & 0x0040)	/* Bit 22 - frequency range bit */
+							bus_speed = PCI_SPEED_133MHz_PCIX;
+						else
+							bus_speed = PCI_SPEED_100MHz_PCIX;
+					} else
+						bus_speed = PCI_SPEED_66MHz_PCIX;
+				} else {
+					if (readw(php_ctlr->creg + MISC) & 0x0800)	/* Bit 27 - 66MHZ Prescale indicator */
+						bus_speed = PCI_SPEED_66MHz;
+					else
+						bus_speed = PCI_SPEED_33MHz;
+				}
+			}
+		} else {
+			if (readw(php_ctlr->creg + MISC) & 0x0800)	/* Bit 27 - 66MHZ Prescale indicator */
+				bus_speed = PCI_SPEED_66MHz;
+			else
+				bus_speed = PCI_SPEED_33MHz;
+		}
+	}
+
+	*value = bus_speed;
+	dbg("Current bus speed = %d\n", bus_speed);
+	DBG_LEAVE_ROUTINE 
+	return 0;
+}
+
+static int hpc_set_controller_speed (struct slot *slot, enum pci_bus_speed value)
+{
+	struct slot *p_slot;
+	struct controller *ctrl;
+	u8 reg, adapter_speed;
+	u8 slot_power, hp_slot;
+	u16 reg16;
+	u32 leds;
+
+	struct php_ctlr_state_s *php_ctlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+
+	DBG_ENTER_ROUTINE 
+	if (!slot->ctrl->hpc_ctlr_handle) {
+		err("%s: Invalid HPC controller handle!\n", __FUNCTION__);
+		return -1;
+	}
+	
+	ctrl = slot->ctrl;
+	hp_slot = slot->hp_slot;
+	slot_power = readb(php_ctlr->creg + SLOT_POWER);
+	leds = readl(php_ctlr->creg + LED_CONTROL);
+	adapter_speed = value;
+
+	/* We don't allow freq/mode changes if we find another adapter running
+	 * in another slot on this controller */
+	for(p_slot = ctrl->slot; p_slot; p_slot = p_slot->next) {
+		if (p_slot->device == (hp_slot + ctrl->slot_device_offset)) 
+			continue;
+		if (!p_slot->hotplug_slot && !p_slot->hotplug_slot->info) 
+			continue;
+		if (p_slot->hotplug_slot->info->adapter_status == 0) 
+			continue;
+		/* If another adapter is running on the same segment but at a
+		 * lower speed/mode, we allow the new adapter to function at
+		 * this rate if supported */
+		if (ctrl->speed < adapter_speed) 
+			return 0;
+
+		return 1;
+	}
+	
+	/* We try to set the max speed supported by both the adapter and
+	 * controller */
+	if (ctrl->speed_capability < adapter_speed) {
+		if (ctrl->speed == ctrl->speed_capability)
+			return 0;
+		adapter_speed = ctrl->speed_capability;
+	}
+
+	writel(0x0L, php_ctlr->creg + LED_CONTROL);
+	writeb(0x00, php_ctlr->creg + SLOT_ENABLE);
+	
+	hpc_update_hpc(slot);
+	
+	if (adapter_speed != PCI_SPEED_133MHz_PCIX)
+		reg = 0xF5;
+	else
+		reg = 0xF4;	
+	pci_write_config_byte(ctrl->pci_dev, 0x41, reg);
+	
+	reg16 = readw(php_ctlr->creg + NEXT_CURR_FREQ);
+	reg16 &= ~0x000F;
+	switch(adapter_speed) {
+		case(PCI_SPEED_133MHz_PCIX): 
+			reg = 0x75;
+			reg16 |= 0xB; 
+			break;
+		case(PCI_SPEED_100MHz_PCIX):
+			reg = 0x74;
+			reg16 |= 0xA;
+			break;
+		case(PCI_SPEED_66MHz_PCIX):
+			reg = 0x73;
+			reg16 |= 0x9;
+			break;
+		case(PCI_SPEED_66MHz):
+			reg = 0x73;
+			reg16 |= 0x1;
+			break;
+		default: /* 33MHz PCI 2.2 */
+			reg = 0x71;
+			break;
+			
+	}
+	reg16 |= 0xB << 12;
+	writew(reg16, php_ctlr->creg + NEXT_CURR_FREQ);
+	
+	mdelay(5); 
+	
+	/* Reenable interrupts */
+	writel(0, php_ctlr->creg + INT_MASK);
+
+	pci_write_config_byte(ctrl->pci_dev, 0x41, reg); 
+	
+	/* Restart state machine */
+	reg = ~0xF;
+	pci_read_config_byte(ctrl->pci_dev, 0x43, &reg);
+	pci_write_config_byte(ctrl->pci_dev, 0x43, reg);
+	
+	/* Only if mode change...*/
+	if (((ctrl->speed == PCI_SPEED_66MHz) && (adapter_speed == PCI_SPEED_66MHz_PCIX)) ||
+		((ctrl->speed == PCI_SPEED_66MHz_PCIX) && (adapter_speed == PCI_SPEED_66MHz))) 
+		hpc_update_hpc(slot);	
+
+	mdelay(1100);
+	
+	/* Restore LED/Slot state */
+	writel(leds, php_ctlr->creg + LED_CONTROL);
+	writeb(slot_power, php_ctlr->creg + SLOT_ENABLE);
+	
+	hpc_update_hpc(slot);
+
+	ctrl->speed = adapter_speed;
+	slot = cpqhp_find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
+
+	info("Successfully changed frequency/mode for adapter in slot %d\n", 
+			slot->number);
+	return 0;
+}
+
+static struct hpc_ops cpqphp_hpc_ops = {
+	.power_on_slot			= hpc_power_on_slot,
+	.power_off_slot			= hpc_power_off_slot,
+	.set_attention_status		= hpc_set_attention_status,
+	.get_power_status		= hpc_get_power_status,
+	.get_attention_status		= hpc_get_attention_status,
+	.get_latch_status		= hpc_get_latch_status,
+	.get_adapter_status		= hpc_get_adapter_status,
+
+	.get_max_bus_speed		= hpc_get_max_bus_speed,
+	.get_cur_bus_speed		= hpc_get_cur_bus_speed,
+	.get_adapter_speed		= hpc_get_adapter_speed,
+	.set_controller_speed	= hpc_set_controller_speed,
+
+	.get_slot_capability	= hpc_get_slot_capability,
+	.query_power_fault		= hpc_query_power_fault,
+	.green_led_on			= hpc_green_led_on,
+	.green_led_off			= hpc_green_led_off,
+	.green_led_blink		= hpc_green_led_blink,
+
+	.enable_msl_interrupt	= hpc_enable_msl_interrupt,
+	.update_hpc				= hpc_update_hpc,
+	.release_ctlr			= hpc_release_ctlr,
+};
+
+int phphpc_init(struct controller * ctrl,
+		struct pci_dev * pdev,
+		php_intr_callback_t switch_change_callback,
+		php_intr_callback_t presence_change_callback,
+		php_intr_callback_t power_fault_callback)
+{
+	struct php_ctlr_state_s *php_ctlr, *p;
+	void *instance_id = ctrl;
+	unsigned long psw;
+	int rc;
+	u16 temp_word, misc;
+	static int first = 1;
+
+	DBG_ENTER_ROUTINE
+	php_ctlr = (struct php_ctlr_state_s *) kmalloc(sizeof(struct php_ctlr_state_s), GFP_KERNEL);
+
+	if (!php_ctlr) {	/* allocate controller state data */
+		err("%s: HPC controller memory allocation error!\n", __FUNCTION__);
+		goto abort;
+	}
+
+	memset(php_ctlr, 0, sizeof(struct php_ctlr_state_s));
+
+	php_ctlr->pci_dev = pdev;	/* save pci_dev in context */
+
+	if (first) {
+		spin_lock_init(&hpc_event_lock);
+		first = 0;
+	}
+
+	dbg("pdev = %p: b:d:f:irq=0x%x:%x:%x:%x\n", pdev, pdev->bus->number, PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn), pdev->irq);
+	for ( rc = 0; rc < DEVICE_COUNT_RESOURCE; rc++)
+		if (pci_resource_len(pdev, rc) > 0)
+			dbg("pci resource[%d] start=0x%lx(len=0x%lx)\n", rc,
+				pci_resource_start(pdev, rc), pci_resource_len(pdev, rc));
+	info("HPC vendor_id %x device_id %x ss_vid %x ss_did %x\n", pdev->vendor, pdev->device, pdev->subsystem_vendor, pdev->subsystem_device);
+
+	if (!request_mem_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0), MY_NAME)) {
+		err("%s: cannot reserve MMIO region\n", __FUNCTION__);
+		goto abort_free_ctlr;
+	}
+
+	php_ctlr->creg = (struct ctrl_reg *)
+		ioremap(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
+	if (!php_ctlr->creg) {
+		err("%s: cannot remap MMIO region %lx @ %lx\n", __FUNCTION__, pci_resource_len(pdev, 0), pci_resource_start(pdev, 0));
+		release_mem_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
+		goto abort_free_ctlr;
+	}
+
+	init_MUTEX(&ctrl->crit_sect);
+	/* setup wait queue */
+	init_waitqueue_head(&ctrl->queue);
+
+	/* find the IRQ */
+	php_ctlr->irq = pdev->irq;
+	dbg("HPC interrupt = %d\n", php_ctlr->irq);
+
+	/* Save interrupt callback info */
+	php_ctlr->switch_change_callback = switch_change_callback;
+	php_ctlr->presence_change_callback = presence_change_callback;
+	php_ctlr->power_fault_callback = power_fault_callback;
+	php_ctlr->callback_instance_id = instance_id;
+
+	/* return PCI Controller Info */
+	php_ctlr->first_device_num = readb(php_ctlr->creg + SLOT_MASK) >> 4;
+	php_ctlr->num_slots = readb(php_ctlr->creg + SLOT_MASK) & 0xF;
+
+	/* Mask all general input interrupts */
+	writel(0xFFFFFFFFL, php_ctlr->creg + INT_MASK);
+
+	/*Disable interrupts */
+	spin_lock_irqsave(&hpc_event_lock, psw);
+
+	/*this code installs the interrupt handler */
+	rc = request_irq(php_ctlr->irq, hpc_isr, SA_SHIRQ, MY_NAME, (void *) ctrl);
+	dbg("%s: request_irq %d for hpc%d (returns %d)\n", __FUNCTION__, php_ctlr->irq, ctlr_seq_num, rc);
+
+	if ((php_ctlr->pci_dev->vendor == PCI_VENDOR_ID_INTEL) &&
+		(php_ctlr->pci_dev->device == PCI_INTC_P64H2_DID)) {
+		/*
+		 *  If this is the Intel Tiger IA64 platform, Read the ABAR config
+		 *  space register and clear bit 14 to assure HPC uses normal
+		 *  interrupts, NOT SCI interrupt.
+		 */
+		rc = pci_read_config_word(pdev, 0x80, &temp_word);
+		dbg("ABAR reads %x\n", temp_word);
+		temp_word = temp_word & 0xBFFF;
+		rc |= pci_write_config_word(pdev, 0x80, temp_word);
+		pci_read_config_word(pdev, 0x80, &temp_word);
+		if (rc || (temp_word & ~0xBFFF))
+			err("Unable to set ABAR[%x] rc = %d\n", temp_word, rc);
+		else
+			dbg("ABAR set to %x\n", temp_word);
+	}
+
+	/* Re-enable interrupts */
+	spin_unlock_irqrestore(&hpc_event_lock, psw);
+
+	/* Enable Shift Out interrupt and clear it, also */
+	/* enable SERR on power fault */
+	misc = readw(php_ctlr->creg + MISC);
+	misc |= 0x6006;
+	writew(misc, php_ctlr->creg + MISC);
+
+	/* Changed 05/05/97 to clear all interrupts at start */
+	writel(0xFFFFFFFF, php_ctlr->creg + INT_INPUT_CLEAR);	
+
+	php_ctlr->ctrl_int_comp = readl(php_ctlr->creg + INT_INPUT_CLEAR);
+
+	writel(0x0L, php_ctlr->creg + INT_MASK);
+	/*
+	 *  Initialize the per slot SERR for unexpected switch open to 0
+	 *  If the bit is et to 1, slot switch interrupt causes the SERR# pin
+	 *  to be asserted.
+	 */
+	writeb(0, php_ctlr->creg + SLOT_SERR);
+
+	/*  Add this HPC instance into the HPC list */
+	/*  TO DO:  Do we need to spinlock this? */
+	if (php_ctlr_list_head == 0) {
+		php_ctlr_list_head = php_ctlr;
+		p = php_ctlr_list_head;
+		p->pnext = 0;
+	} else {
+		p = php_ctlr_list_head;
+
+		while (p->pnext)
+			p = p->pnext;
+
+		p->pnext = php_ctlr;
+	}
+
+	ctlr_seq_num++;
+	ctrl->hpc_ctlr_handle = php_ctlr;
+	ctrl->hpc_ops = &cpqphp_hpc_ops;
+
+	DBG_LEAVE_ROUTINE
+	return 0;
+
+	/* We end up here for the many possible ways to fail this API.  */
+abort_free_ctlr:
+	kfree(php_ctlr);
+abort:
+	DBG_LEAVE_ROUTINE
+	return -1;
+}
diff -Nru a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
--- a/drivers/pci/hotplug/cpqphp_pci.c	2003-07-02 13:56:02.000000000 -0700
+++ b/drivers/pci/hotplug/cpqphp_pci.c	2003-07-07 09:32:23.000000000 -0700
@@ -36,50 +36,9 @@
 #include <linux/pci.h>
 #include "../pci.h"
 #include "cpqphp.h"
-#include "cpqphp_nvram.h"
-#include "../../../arch/i386/pci/pci.h"	/* horrible hack showing how processor dependent we are... */
-
-
-u8 cpqhp_nic_irq;
-u8 cpqhp_disk_irq;
-
-static u16 unused_IRQ;
-
-/*
- * detect_HRT_floating_pointer
- *
- * find the Hot Plug Resource Table in the specified region of memory.
- *
- */
-static void *detect_HRT_floating_pointer(void *begin, void *end)
-{
-	void *fp;
-	void *endp;
-	u8 temp1, temp2, temp3, temp4;
-	int status = 0;
-
-	endp = (end - sizeof(struct hrt) + 1);
-
-	for (fp = begin; fp <= endp; fp += 16) {
-		temp1 = readb(fp + SIG0);
-		temp2 = readb(fp + SIG1);
-		temp3 = readb(fp + SIG2);
-		temp4 = readb(fp + SIG3);
-		if (temp1 == '$' &&
-		    temp2 == 'H' &&
-		    temp3 == 'R' &&
-		    temp4 == 'T') {
-			status = 1;
-			break;
-		}
-	}
-
-	if (!status)
-		fp = NULL;
-
-	dbg("Discovered Hotplug Resource Table at %p\n", fp);
-	return fp;
-}
+#ifndef CONFIG_IA64
+#include "../arch/i386/pci/pci.h"    /* horrible hack showing how processor dependant we are... */
+#endif
 
 
 int cpqhp_configure_device (struct controller* ctrl, struct pci_func* func)  
@@ -93,7 +52,7 @@
 
 	/* No pci device, we need to create it then */
 	if (func->pci_dev == NULL) {
-		dbg("INFO: pci_dev still null\n");
+		dbg("%s: pci_dev still null. do pci_scan_slot\n", __FUNCTION__);
 
 		num = pci_scan_slot(ctrl->pci_dev->bus, PCI_DEVFN(func->device, func->function));
 		if (num)
@@ -118,29 +77,37 @@
 
 int cpqhp_unconfigure_device(struct pci_func* func) 
 {
+	int rc = 0;
 	int j;
-	
+
+
 	dbg("%s: bus/dev/func = %x/%x/%x\n", __FUNCTION__, func->bus, func->device, func->function);
 
 	for (j=0; j<8 ; j++) {
 		struct pci_dev* temp = pci_find_slot(func->bus, (func->device << 3) | j);
-		if (temp)
+		if (temp) {
 			pci_remove_bus_device(temp);
+		}
 	}
-	return 0;
+	return rc;
 }
 
 static int PCI_RefinedAccessConfig(struct pci_bus *bus, unsigned int devfn, u8 offset, u32 *value)
 {
 	u32 vendID = 0;
+	int rc;
+
+	rc = pci_bus_read_config_dword (bus, devfn, PCI_VENDOR_ID, &vendID);
 
-	if (pci_bus_read_config_dword (bus, devfn, PCI_VENDOR_ID, &vendID) == -1)
+	if (rc == -1)
 		return -1;
 	if (vendID == 0xffffffff)
 		return -1;
-	return pci_bus_read_config_dword (bus, devfn, offset, value);
-}
 
+	rc = pci_bus_read_config_dword (bus, devfn, offset, value);
+
+	return rc;
+}
 
 /*
  * cpqhp_set_irq
@@ -151,6 +118,7 @@
  */
 int cpqhp_set_irq (u8 bus_num, u8 dev_num, u8 int_pin, u8 irq_num)
 {
+#if defined(CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM) && defined(CONFIG_X86)
 	int rc;
 	u16 temp_word;
 	struct pci_dev fakedev;
@@ -166,60 +134,53 @@
 	if (!rc)
 		return !rc;
 
-	// set the Edge Level Control Register (ELCR)
+	/* set the Edge Level Control Register (ELCR) */
 	temp_word = inb(0x4d0);
 	temp_word |= inb(0x4d1) << 8;
 
 	temp_word |= 0x01 << irq_num;
 
-	// This should only be for x86 as it sets the Edge Level Control Register
+	/* This should only be for x86 as it sets the Edge Level Control Register */
 	outb((u8) (temp_word & 0xFF), 0x4d0);
 	outb((u8) ((temp_word & 0xFF00) >> 8), 0x4d1);
-
+#endif
 	return 0;
 }
 
 
-/*
- * WTF??? This function isn't in the code, yet a function calls it, but the 
- * compiler optimizes it away?  strange.  Here as a placeholder to keep the 
- * compiler happy.
- */
-static int PCI_ScanBusNonBridge (u8 bus, u8 device)
-{
-	return 0;
-}
 
-static int PCI_ScanBusForNonBridge(struct controller *ctrl, u8 bus_num, u8 * dev_num)
+static int PCI_ScanBusForNonBridge(struct controller *ctrl, u8 * bus_num, u8 * dev_num)
 {
 	u8 tdevice;
 	u32 work;
 	u8 tbus;
+	struct pci_bus lpci_bus, *pci_bus;
 
-	ctrl->pci_bus->number = bus_num;
+	memcpy(&lpci_bus, ctrl->pci_bus, sizeof(lpci_bus));
+	pci_bus = &lpci_bus;
+	pci_bus->number = *bus_num;
 
-	for (tdevice = 0; tdevice < 0xFF; tdevice++) {
-		//Scan for access first
-		if (PCI_RefinedAccessConfig(ctrl->pci_bus, tdevice, 0x08, &work) == -1)
+	for (tdevice = 0; tdevice < 0x100; tdevice++) {
+		if (PCI_RefinedAccessConfig (pci_bus, tdevice, 0x08, &work) == -1)
 			continue;
-		dbg("Looking for nonbridge bus_num %d dev_num %d\n", bus_num, tdevice);
-		//Yep we got one. Not a bridge ?
+		dbg("Looking for nonbridge bus_num %d dev_num %d\n", *bus_num, tdevice);
 		if ((work >> 8) != PCI_TO_PCI_BRIDGE_CLASS) {
 			*dev_num = tdevice;
 			dbg("found it !\n");
 			return 0;
 		}
 	}
-	for (tdevice = 0; tdevice < 0xFF; tdevice++) {
-		//Scan for access first
-		if (PCI_RefinedAccessConfig(ctrl->pci_bus, tdevice, 0x08, &work) == -1)
+	for (tdevice = 0; tdevice < 0x100; tdevice++) {
+		if (PCI_RefinedAccessConfig (pci_bus, tdevice, 0x08, &work) == -1)
 			continue;
-		dbg("Looking for bridge bus_num %d dev_num %d\n", bus_num, tdevice);
-		//Yep we got one. bridge ?
+		dbg("Looking for bridge bus_num %d dev_num %d\n", *bus_num, tdevice);
 		if ((work >> 8) == PCI_TO_PCI_BRIDGE_CLASS) {
-			pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(tdevice, 0), PCI_SECONDARY_BUS, &tbus);
-			dbg("Recurse on bus_num %d tdevice %d\n", tbus, tdevice);
-			if (PCI_ScanBusNonBridge(tbus, tdevice) == 0)
+			pci_bus_read_config_byte(pci_bus, tdevice, PCI_SECONDARY_BUS, &tbus);
+
+			dbg("Found a new bus %d on bus %d device %d\n", tbus, *bus_num, tdevice);
+			dbg("Recurse on the new bus %d\n", tbus);
+			*bus_num = tbus;
+			if (PCI_ScanBusForNonBridge(ctrl, bus_num, dev_num) == 0)  
 				return 0;
 		}
 	}
@@ -227,75 +188,59 @@
 	return -1;
 }
 
-
-static int PCI_GetBusDevHelper(struct controller *ctrl, u8 *bus_num, u8 *dev_num, u8 slot, u8 nobridge)
+static int PCI_GetBusDevHelper(struct controller *ctrl, u8 * bus_num, u8 * dev_num,
+			       struct slot *slot, u8 nobridge)
 {
-	struct irq_routing_table *PCIIRQRoutingInfoLength;
-	long len;
 	long loop;
 	u32 work;
+	u8 tbus, tdevice;
+	struct pci_bus lpci_bus, *pci_bus;
+	memcpy(&lpci_bus, ctrl->pci_bus, sizeof(lpci_bus));
+	pci_bus = &lpci_bus;
+
+	dbg("GetBusDev: bus %d dev %d func %d\n", *bus_num, *dev_num >> 3, *dev_num & 0x7);
+	for (loop = 0; loop < 8; ++loop) {
+		tbus = slot->bus;
+		tdevice = slot->device << 3 | loop;
+
+		*bus_num = tbus;
+		*dev_num = tdevice;
+		pci_bus->number = tbus;
 
-	u8 tbus, tdevice, tslot;
+		pci_bus_read_config_dword(pci_bus, *dev_num, PCI_VENDOR_ID, &work);
 
-	PCIIRQRoutingInfoLength = pcibios_get_irq_routing_table();
-	if (!PCIIRQRoutingInfoLength)
-		return -1;
+		if (!nobridge || (work == 0xffffffff)) {
+			dbg("GetBusDev: nodev bus %d dev %d func %d\n", *bus_num, *dev_num >> 3, *dev_num & 0x7);
+			return 0;
+		}
 
-	len = (PCIIRQRoutingInfoLength->size -
-	       sizeof(struct irq_routing_table)) / sizeof(struct irq_info);
-	// Make sure I got at least one entry
-	if (len == 0) {
-		if (PCIIRQRoutingInfoLength != NULL)
-			kfree(PCIIRQRoutingInfoLength );
-		return -1;
-	}
+		dbg("bus_num %d dev_num %d func_num %d\n", *bus_num, *dev_num >> 3, *dev_num & 0x7);
 
-	for (loop = 0; loop < len; ++loop) {
-		tbus = PCIIRQRoutingInfoLength->slots[loop].bus;
-		tdevice = PCIIRQRoutingInfoLength->slots[loop].devfn;
-		tslot = PCIIRQRoutingInfoLength->slots[loop].slot;
+		pci_bus_read_config_dword(pci_bus, *dev_num, PCI_CLASS_REVISION, &work);
 
-		if (tslot == slot) {
-			*bus_num = tbus;
-			*dev_num = tdevice;
-			ctrl->pci_bus->number = tbus;
-			pci_bus_read_config_dword (ctrl->pci_bus, *dev_num, PCI_VENDOR_ID, &work);
-			if (!nobridge || (work == 0xffffffff)) {
-				if (PCIIRQRoutingInfoLength != NULL)
-					kfree(PCIIRQRoutingInfoLength );
-				return 0;
-			}
+		dbg("work >> 8 (%x) = BRIDGE (%x)\n", work >> 8, PCI_TO_PCI_BRIDGE_CLASS);
 
-			dbg("bus_num %d devfn %d\n", *bus_num, *dev_num);
-			pci_bus_read_config_dword (ctrl->pci_bus, *dev_num, PCI_CLASS_REVISION, &work);
-			dbg("work >> 8 (%x) = BRIDGE (%x)\n", work >> 8, PCI_TO_PCI_BRIDGE_CLASS);
-
-			if ((work >> 8) == PCI_TO_PCI_BRIDGE_CLASS) {
-				pci_bus_read_config_byte (ctrl->pci_bus, *dev_num, PCI_SECONDARY_BUS, &tbus);
-				dbg("Scan bus for Non Bridge: bus %d\n", tbus);
-				if (PCI_ScanBusForNonBridge(ctrl, tbus, dev_num) == 0) {
-					*bus_num = tbus;
-					if (PCIIRQRoutingInfoLength != NULL)
-						kfree(PCIIRQRoutingInfoLength );
-					return 0;
-				}
-			} else {
-				if (PCIIRQRoutingInfoLength != NULL)
-					kfree(PCIIRQRoutingInfoLength );
-				return 0;
-			}
+		if ((work >> 8) == PCI_TO_PCI_BRIDGE_CLASS) {
 
-		}
+			pci_bus_read_config_byte(pci_bus, *dev_num, PCI_SECONDARY_BUS, &tbus);
+
+			dbg("Scan bus for Non Bridge: bus %d\n", tbus);
+			*bus_num = tbus;
+			if (PCI_ScanBusForNonBridge(ctrl, bus_num, dev_num) == 0)
+				return 0;
+			else
+				dbg("no Non Bridge under bus %d\n", tbus);
+		} else
+			return 0;
 	}
-	if (PCIIRQRoutingInfoLength != NULL)
-		kfree(PCIIRQRoutingInfoLength );
+
+	dbg("GetBusDev: fail bus %d dev %d func %d\n", *bus_num, *dev_num >> 3, *dev_num & 0x7);
 	return -1;
 }
 
-
-int cpqhp_get_bus_dev (struct controller *ctrl, u8 * bus_num, u8 * dev_num, u8 slot)
+int cpqhp_get_bus_dev (struct controller *ctrl, u8 * bus_num, u8 * dev_num, struct slot *slot)
 {
-	return PCI_GetBusDevHelper(ctrl, bus_num, dev_num, slot, 0);	//plain (bridges allowed)
+	return PCI_GetBusDevHelper(ctrl, bus_num, dev_num, slot, 0);	/*plain (bridges allowed) */
 }
 
 
@@ -311,9 +256,9 @@
  *
  * returns 0 if success
  */
-int cpqhp_save_config(struct controller *ctrl, int busnumber, int is_hot_plug)
+int cpqhp_save_config(struct controller *ctrl, int busnumber, int num_ctlr_slots, int first_device_num)
 {
-	long rc;
+	int rc;
 	u8 class_code;
 	u8 header_type;
 	u32 ID;
@@ -329,36 +274,46 @@
 	int cloop = 0;
 	int stop_it;
 	int index;
+	int is_hot_plug = num_ctlr_slots || first_device_num;
+	struct pci_bus lpci_bus, *pci_bus;
+	memcpy(&lpci_bus, ctrl->pci_bus, sizeof(lpci_bus));
+	pci_bus = &lpci_bus;
 
-	//              Decide which slots are supported
+	dbg("%s: num_ctlr_slots = %d, first_device_num = %d\n", __FUNCTION__, num_ctlr_slots, first_device_num);
 
+	/*  Decide which slots are supported */
 	if (is_hot_plug) {
-		//*********************************
-		// is_hot_plug is the slot mask
-		//*********************************
-		FirstSupported = is_hot_plug >> 4;
-		LastSupported = FirstSupported + (is_hot_plug & 0x0F) - 1;
+		/*********************************
+		 is_hot_plug is the slot mask
+		 *********************************/
+		FirstSupported = first_device_num;
+		LastSupported = FirstSupported + num_ctlr_slots - 1;
 	} else {
 		FirstSupported = 0;
 		LastSupported = 0x1F;
 	}
 
-	//     Save PCI configuration space for all devices in supported slots
-	ctrl->pci_bus->number = busnumber;
+	dbg("FirstSupported = %d, LastSupported = %d\n", FirstSupported, LastSupported);
+
+	/* Save PCI configuration space for all devices in supported slots */
+	pci_bus->number = busnumber;
 	for (device = FirstSupported; device <= LastSupported; device++) {
 		ID = 0xFFFFFFFF;
-		rc = pci_bus_read_config_dword (ctrl->pci_bus, PCI_DEVFN(device, 0), PCI_VENDOR_ID, &ID);
+		rc = pci_bus_read_config_dword(pci_bus, PCI_DEVFN(device, 0), PCI_VENDOR_ID, &ID);
 
-		if (ID != 0xFFFFFFFF) {	  //  device in slot
-			rc = pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(device, 0), 0x0B, &class_code);
+		if (ID != 0xFFFFFFFF) {	  /*  device in slot */
+			rc = pci_bus_read_config_byte(pci_bus, PCI_DEVFN(device, 0), 0x0B, &class_code);
+			
 			if (rc)
 				return rc;
 
-			rc = pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(device, 0), PCI_HEADER_TYPE, &header_type);
+			rc = pci_bus_read_config_byte(pci_bus, PCI_DEVFN(device, 0), PCI_HEADER_TYPE, &header_type);
 			if (rc)
 				return rc;
 
-			// If multi-function device, set max_functions to 8
+			dbg("class_code = %x, header_type = %x\n", class_code, header_type);
+
+			/* If multi-function device, set max_functions to 8 */
 			if (header_type & 0x80)
 				max_functions = 8;
 			else
@@ -369,33 +324,36 @@
 			do {
 				DevError = 0;
 
-				if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {   // P-P Bridge
-					//  Recurse the subordinate bus
-					//  get the subordinate bus number
-					rc = pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(device, function), PCI_SECONDARY_BUS, &secondary_bus);
+				if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {   /* P-P Bridge */
+					/*  Recurse the subordinate bus
+					    get the subordinate bus number */
+					rc = pci_bus_read_config_byte(pci_bus, PCI_DEVFN(device, function), PCI_SECONDARY_BUS, &secondary_bus);
 					if (rc) {
 						return rc;
 					} else {
 						sub_bus = (int) secondary_bus;
 
-						// Save secondary bus cfg spc
-						// with this recursive call.
-						rc = cpqhp_save_config(ctrl, sub_bus, 0);
+						/* Save secondary bus cfg spc
+						   with this recursive call. */
+						rc = cpqhp_save_config(ctrl, sub_bus, 0, 0);
 						if (rc)
 							return rc;
-						ctrl->pci_bus->number = busnumber;
 					}
 				}
 
 				index = 0;
 				new_slot = cpqhp_slot_find(busnumber, device, index++);
-				while (new_slot && 
-				       (new_slot->function != (u8) function))
-					new_slot = cpqhp_slot_find(busnumber, device, index++);
 
+				dbg("new_slot = %p\n", new_slot);
+
+				while (new_slot && (new_slot->function != (u8) function)) {
+					new_slot = cpqhp_slot_find(busnumber, device, index++);
+					dbg("new_slot = %p\n", new_slot);
+				}
 				if (!new_slot) {
-					// Setup slot structure.
+					/* Setup slot structure. */
 					new_slot = cpqhp_slot_create(busnumber);
+					dbg("new_slot = %p\n", new_slot);
 
 					if (new_slot == NULL)
 						return(1);
@@ -406,12 +364,15 @@
 				new_slot->function = (u8) function;
 				new_slot->is_a_board = 1;
 				new_slot->switch_save = 0x10;
-				// In case of unsupported board
+				/* In case of unsupported board */
 				new_slot->status = DevError;
 				new_slot->pci_dev = pci_find_slot(new_slot->bus, (new_slot->device << 3) | new_slot->function);
+				dbg("new_slot->pci_dev = %p\n", new_slot->pci_dev);
 
 				for (cloop = 0; cloop < 0x20; cloop++) {
-					rc = pci_bus_read_config_dword (ctrl->pci_bus, PCI_DEVFN(device, function), cloop << 2, (u32 *) & (new_slot-> config_space [cloop]));
+					rc = pci_bus_read_config_dword(pci_bus, PCI_DEVFN(device, function), cloop << 2, (u32 *) & (new_slot->config_space [cloop]));
+
+					/*dbg("new_slot->config_space[%x] = %x\n", cloop, new_slot->config_space[cloop]); */
 					if (rc)
 						return rc;
 				}
@@ -420,35 +381,40 @@
 
 				stop_it = 0;
 
-				//  this loop skips to the next present function
-				//  reading in Class Code and Header type.
+				/*  this loop skips to the next present function
+				    reading in Class Code and Header type. */
 
 				while ((function < max_functions)&&(!stop_it)) {
-					rc = pci_bus_read_config_dword (ctrl->pci_bus, PCI_DEVFN(device, function), PCI_VENDOR_ID, &ID);
-					if (ID == 0xFFFFFFFF) {	 // nothing there.
+					rc = pci_bus_read_config_dword(pci_bus, PCI_DEVFN(device, function), PCI_VENDOR_ID, &ID);
+
+					if (ID == 0xFFFFFFFF) {  /* nothing there. */
 						function++;
-					} else {  // Something there
-						rc = pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(device, function), 0x0B, &class_code);
+						dbg("Nothing there\n");
+					} else {  /* Something there */
+
+						rc = pci_bus_read_config_byte(pci_bus, PCI_DEVFN(device, function), 0x0B, &class_code);
 						if (rc)
 							return rc;
 
-						rc = pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(device, function), PCI_HEADER_TYPE, &header_type);
+						rc = pci_bus_read_config_byte(pci_bus, PCI_DEVFN(device, function), PCI_HEADER_TYPE, &header_type);
 						if (rc)
 							return rc;
 
+						dbg("class_code = %x, header_type = %x\n", class_code, header_type);
 						stop_it++;
 					}
 				}
 
 			} while (function < max_functions);
-		}		// End of IF (device in slot?)
+		}		/* End of IF (device in slot?) */
 		else if (is_hot_plug) {
-			// Setup slot structure with entry for empty slot
+			/* Setup slot structure with entry for empty slot */
 			new_slot = cpqhp_slot_create(busnumber);
 
 			if (new_slot == NULL) {
 				return(1);
 			}
+			dbg("new_slot = %p\n", new_slot);
 
 			new_slot->bus = (u8) busnumber;
 			new_slot->device = (u8) device;
@@ -457,7 +423,7 @@
 			new_slot->presence_save = 0;
 			new_slot->switch_save = 0;
 		}
-	}			// End of FOR loop
+	}			/* End of FOR loop */
 
 	return(0);
 }
@@ -473,7 +439,7 @@
  */
 int cpqhp_save_slot_config (struct controller *ctrl, struct pci_func * new_slot)
 {
-	long rc;
+	int rc;
 	u8 class_code;
 	u8 header_type;
 	u32 ID;
@@ -483,17 +449,21 @@
 	int function;
 	int cloop = 0;
 	int stop_it;
+	struct pci_bus lpci_bus, *pci_bus;
+	memcpy(&lpci_bus, ctrl->pci_bus, sizeof(lpci_bus));
+	pci_bus = &lpci_bus;
+	pci_bus->number = new_slot->bus;
 
 	ID = 0xFFFFFFFF;
 
-	ctrl->pci_bus->number = new_slot->bus;
-	pci_bus_read_config_dword (ctrl->pci_bus, PCI_DEVFN(new_slot->device, 0), PCI_VENDOR_ID, &ID);
+	pci_bus_read_config_dword(pci_bus, PCI_DEVFN(new_slot->device, 0), PCI_VENDOR_ID, &ID);
+
+	if (ID != 0xFFFFFFFF) {	  /*  device in slot */
+		pci_bus_read_config_byte(pci_bus, PCI_DEVFN(new_slot->device, 0), 0x0B, &class_code);
 
-	if (ID != 0xFFFFFFFF) {	  //  device in slot
-		pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(new_slot->device, 0), 0x0B, &class_code);
-		pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(new_slot->device, 0), PCI_HEADER_TYPE, &header_type);
+		pci_bus_read_config_byte(pci_bus, PCI_DEVFN(new_slot->device, 0), PCI_HEADER_TYPE, &header_type);
 
-		if (header_type & 0x80)	// Multi-function device
+		if (header_type & 0x80)	/* Multi-function device */
 			max_functions = 8;
 		else
 			max_functions = 1;
@@ -501,49 +471,47 @@
 		function = 0;
 
 		do {
-			if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {	  // PCI-PCI Bridge
-				//  Recurse the subordinate bus
-				pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(new_slot->device, function), PCI_SECONDARY_BUS, &secondary_bus);
+			if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {	 /* PCI-PCI Bridge */
+				/*  Recurse the subordinate bus */
+				pci_bus_read_config_byte(pci_bus, PCI_DEVFN(new_slot->device, function), PCI_SECONDARY_BUS, &secondary_bus);
 
 				sub_bus = (int) secondary_bus;
 
-				// Save the config headers for the secondary bus.
-				rc = cpqhp_save_config(ctrl, sub_bus, 0);
+				/* Save the config headers for the secondary bus. */
+				rc = cpqhp_save_config(ctrl, sub_bus, 0, 0);
+
 				if (rc)
 					return(rc);
-				ctrl->pci_bus->number = new_slot->bus;
 
-			}	// End of IF
+			}	/* End of IF */
 
 			new_slot->status = 0;
 
 			for (cloop = 0; cloop < 0x20; cloop++) {
-				pci_bus_read_config_dword (ctrl->pci_bus, PCI_DEVFN(new_slot->device, function), cloop << 2, (u32 *) & (new_slot-> config_space [cloop]));
+				pci_bus_read_config_dword(pci_bus, PCI_DEVFN(new_slot->device, function), cloop << 2, (u32 *) & (new_slot->config_space [cloop]));
 			}
 
 			function++;
 
 			stop_it = 0;
 
-			//  this loop skips to the next present function
-			//  reading in the Class Code and the Header type.
+			/*  this loop skips to the next present function
+			    reading in the Class Code and the Header type. */
 
 			while ((function < max_functions) && (!stop_it)) {
-				pci_bus_read_config_dword (ctrl->pci_bus, PCI_DEVFN(new_slot->device, function), PCI_VENDOR_ID, &ID);
+				pci_bus_read_config_dword(pci_bus, PCI_DEVFN(new_slot->device, function), PCI_VENDOR_ID, &ID);
 
-				if (ID == 0xFFFFFFFF) {	 // nothing there.
+				if (ID == 0xFFFFFFFF) {	 /* nothing there. */
 					function++;
-				} else {  // Something there
-					pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(new_slot->device, function), 0x0B, &class_code);
-
-					pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(new_slot->device, function), PCI_HEADER_TYPE, &header_type);
-
+				} else {  /* Something there */
+					pci_bus_read_config_byte(pci_bus, PCI_DEVFN(new_slot->device, function), 0x0B, &class_code);
+					pci_bus_read_config_byte(pci_bus, PCI_DEVFN(new_slot->device, function), PCI_HEADER_TYPE, &header_type);
 					stop_it++;
 				}
 			}
 
 		} while (function < max_functions);
-	}			// End of IF (device in slot?)
+	}			/* End of IF (device in slot?) */
 	else {
 		return(2);
 	}
@@ -553,136 +521,6 @@
 
 
 /*
- * cpqhp_save_base_addr_length
- *
- * Saves the length of all base address registers for the
- * specified slot.  this is for hot plug REPLACE
- *
- * returns 0 if success
- */
-int cpqhp_save_base_addr_length(struct controller *ctrl, struct pci_func * func)
-{
-	u8 cloop;
-	u8 header_type;
-	u8 secondary_bus;
-	u8 type;
-	int sub_bus;
-	u32 temp_register;
-	u32 base;
-	u32 rc;
-	struct pci_func *next;
-	int index = 0;
-	struct pci_bus *pci_bus = ctrl->pci_bus;
-	unsigned int devfn;
-
-	func = cpqhp_slot_find(func->bus, func->device, index++);
-
-	while (func != NULL) {
-		pci_bus->number = func->bus;
-		devfn = PCI_DEVFN(func->device, func->function);
-
-		// Check for Bridge
-		pci_bus_read_config_byte (pci_bus, devfn, PCI_HEADER_TYPE, &header_type);
-
-		if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {
-			// PCI-PCI Bridge
-			pci_bus_read_config_byte (pci_bus, devfn, PCI_SECONDARY_BUS, &secondary_bus);
-
-			sub_bus = (int) secondary_bus;
-
-			next = cpqhp_slot_list[sub_bus];
-
-			while (next != NULL) {
-				rc = cpqhp_save_base_addr_length(ctrl, next);
-
-				if (rc)
-					return(rc);
-
-				next = next->next;
-			}
-			pci_bus->number = func->bus;
-
-			//FIXME: this loop is duplicated in the non-bridge case.  The two could be rolled together
-			// Figure out IO and memory base lengths
-			for (cloop = 0x10; cloop <= 0x14; cloop += 4) {
-				temp_register = 0xFFFFFFFF;
-				pci_bus_write_config_dword (pci_bus, devfn, cloop, temp_register);
-				pci_bus_read_config_dword (pci_bus, devfn, cloop, &base);
-
-				if (base) {  // If this register is implemented
-					if (base & 0x01L) {
-						// IO base
-						// set base = amount of IO space requested
-						base = base & 0xFFFFFFFE;
-						base = (~base) + 1;
-
-						type = 1;
-					} else {
-						// memory base
-						base = base & 0xFFFFFFF0;
-						base = (~base) + 1;
-
-						type = 0;
-					}
-				} else {
-					base = 0x0L;
-					type = 0;
-				}
-
-				// Save information in slot structure
-				func->base_length[(cloop - 0x10) >> 2] =
-				base;
-				func->base_type[(cloop - 0x10) >> 2] = type;
-
-			}	// End of base register loop
-
-
-		} else if ((header_type & 0x7F) == 0x00) {	  // PCI-PCI Bridge
-			// Figure out IO and memory base lengths
-			for (cloop = 0x10; cloop <= 0x24; cloop += 4) {
-				temp_register = 0xFFFFFFFF;
-				pci_bus_write_config_dword (pci_bus, devfn, cloop, temp_register);
-				pci_bus_read_config_dword (pci_bus, devfn, cloop, &base);
-
-				if (base) {  // If this register is implemented
-					if (base & 0x01L) {
-						// IO base
-						// base = amount of IO space requested
-						base = base & 0xFFFFFFFE;
-						base = (~base) + 1;
-
-						type = 1;
-					} else {
-						// memory base
-						// base = amount of memory space requested
-						base = base & 0xFFFFFFF0;
-						base = (~base) + 1;
-
-						type = 0;
-					}
-				} else {
-					base = 0x0L;
-					type = 0;
-				}
-
-				// Save information in slot structure
-				func->base_length[(cloop - 0x10) >> 2] = base;
-				func->base_type[(cloop - 0x10) >> 2] = type;
-
-			}	// End of base register loop
-
-		} else {	  // Some other unknown header type
-		}
-
-		// find the next device in this slot
-		func = cpqhp_slot_find(func->bus, func->device, index++);
-	}
-
-	return(0);
-}
-
-
-/*
  * cpqhp_save_used_resources
  *
  * Stores used resource information for existing boards.  this is
@@ -690,50 +528,62 @@
  * this function is for hot plug ADD
  *
  * returns 0 if success
+ * if disable  == 1(DISABLE_CARD),
+ *  it loops for all functions of the slot and disables them.
+ * else, it just get resources of the function and return.
  */
-int cpqhp_save_used_resources (struct controller *ctrl, struct pci_func * func)
+int cpqhp_save_used_resources (struct controller *ctrl, struct pci_func *func, int disable)
 {
 	u8 cloop;
 	u8 header_type;
 	u8 secondary_bus;
 	u8 temp_byte;
-	u8 b_base;
-	u8 b_length;
 	u16 command;
 	u16 save_command;
-	u16 w_base;
-	u16 w_length;
+	u16 w_base, w_length;
 	u32 temp_register;
 	u32 save_base;
-	u32 base;
+	u32 base, length;
+	u64 base64 = 0;
 	int index = 0;
-	struct pci_resource *mem_node;
-	struct pci_resource *p_mem_node;
+	unsigned int devfn;
+	struct pci_resource *mem_node = NULL;
+	struct pci_resource *p_mem_node = NULL;
+	struct pci_resource *t_mem_node;
 	struct pci_resource *io_node;
 	struct pci_resource *bus_node;
-	struct pci_bus *pci_bus = ctrl->pci_bus;
-	unsigned int devfn;
+	struct pci_bus lpci_bus, *pci_bus;
+	memcpy(&lpci_bus, ctrl->pci_bus, sizeof(lpci_bus));
+	pci_bus = &lpci_bus;
 
-	func = cpqhp_slot_find(func->bus, func->device, index++);
+	if (disable)
+		func = cpqhp_slot_find(func->bus, func->device, index++);
 
 	while ((func != NULL) && func->is_a_board) {
 		pci_bus->number = func->bus;
 		devfn = PCI_DEVFN(func->device, func->function);
 
-		// Save the command register
+		/* Save the command register */
 		pci_bus_read_config_word (pci_bus, devfn, PCI_COMMAND, &save_command);
 
-		// disable card
-		command = 0x00;
-		pci_bus_write_config_word (pci_bus, devfn, PCI_COMMAND, command);
+		if (disable) {
+			/* disable card */
+			command = 0x00;
+
+			pci_bus_write_config_word(pci_bus, devfn, PCI_COMMAND, command);
+		}
 
-		// Check for Bridge
+		/* Check for Bridge */
 		pci_bus_read_config_byte (pci_bus, devfn, PCI_HEADER_TYPE, &header_type);
 
-		if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {	  // PCI-PCI Bridge
-			// Clear Bridge Control Register
-			command = 0x00;
-			pci_bus_write_config_word (pci_bus, devfn, PCI_BRIDGE_CONTROL, command);
+		if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {     /* PCI-PCI Bridge */
+			dbg("Save_used_res of PCI bridge b:d=0x%x:%x, sc=0x%x\n", func->bus, func->device, save_command);
+			if (disable) {
+				/* Clear Bridge Control Register */
+				command = 0x00;
+				pci_bus_write_config_word(pci_bus, devfn, PCI_BRIDGE_CONTROL, command);
+			}
+
 			pci_bus_read_config_byte (pci_bus, devfn, PCI_SECONDARY_BUS, &secondary_bus);
 			pci_bus_read_config_byte (pci_bus, devfn, PCI_SUBORDINATE_BUS, &temp_byte);
 
@@ -741,661 +591,290 @@
 			if (!bus_node)
 				return -ENOMEM;
 
-			bus_node->base = secondary_bus;
-			bus_node->length = temp_byte - secondary_bus + 1;
+			bus_node->base = (ulong)secondary_bus;
+			bus_node->length = (ulong)(temp_byte - secondary_bus + 1);
 
 			bus_node->next = func->bus_head;
 			func->bus_head = bus_node;
 
-			// Save IO base and Limit registers
-			pci_bus_read_config_byte (pci_bus, devfn, PCI_IO_BASE, &b_base);
-			pci_bus_read_config_byte (pci_bus, devfn, PCI_IO_LIMIT, &b_length);
+			/* Save IO base and Limit registers */
+			pci_bus_read_config_byte (pci_bus, devfn, PCI_IO_BASE, &temp_byte);
+			base = temp_byte;
+			pci_bus_read_config_byte (pci_bus, devfn, PCI_IO_LIMIT, &temp_byte);
+			length = temp_byte;
 
-			if ((b_base <= b_length) && (save_command & 0x01)) {
+			if ((base <= length) && (!disable || (save_command & PCI_COMMAND_IO))) {
 				io_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
 				if (!io_node)
 					return -ENOMEM;
 
-				io_node->base = (b_base & 0xF0) << 8;
-				io_node->length = (b_length - b_base + 0x10) << 8;
+				io_node->base = (ulong)(base & PCI_IO_RANGE_MASK) << 8;
+				io_node->length = (ulong)(length - base + 0x10) << 8;
 
 				io_node->next = func->io_head;
 				func->io_head = io_node;
 			}
 
-			// Save memory base and Limit registers
+			/* Save memory base and Limit registers */
 			pci_bus_read_config_word (pci_bus, devfn, PCI_MEMORY_BASE, &w_base);
 			pci_bus_read_config_word (pci_bus, devfn, PCI_MEMORY_LIMIT, &w_length);
 
-			if ((w_base <= w_length) && (save_command & 0x02)) {
+			if ((w_base <= w_length) && (!disable || (save_command & PCI_COMMAND_MEMORY))) {
 				mem_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
 				if (!mem_node)
 					return -ENOMEM;
 
-				mem_node->base = w_base << 16;
-				mem_node->length = (w_length - w_base + 0x10) << 16;
+				mem_node->base = (ulong)w_base << 16;
+				mem_node->length = (ulong)(w_length - w_base + 0x10) << 16;
 
 				mem_node->next = func->mem_head;
 				func->mem_head = mem_node;
 			}
-
-			// Save prefetchable memory base and Limit registers
+			/* Save prefetchable memory base and Limit registers */
 			pci_bus_read_config_word (pci_bus, devfn, PCI_PREF_MEMORY_BASE, &w_base);
 			pci_bus_read_config_word (pci_bus, devfn, PCI_PREF_MEMORY_LIMIT, &w_length);
 
-			if ((w_base <= w_length) && (save_command & 0x02)) {
+			if ((w_base <= w_length) && (!disable || (save_command & PCI_COMMAND_MEMORY))) {
 				p_mem_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
 				if (!p_mem_node)
 					return -ENOMEM;
 
-				p_mem_node->base = w_base << 16;
-				p_mem_node->length = (w_length - w_base + 0x10) << 16;
+				p_mem_node->base = (ulong)w_base << 16;
+				p_mem_node->length = (ulong)(w_length - w_base + 0x10) << 16;
 
 				p_mem_node->next = func->p_mem_head;
 				func->p_mem_head = p_mem_node;
 			}
-			// Figure out IO and memory base lengths
-			for (cloop = 0x10; cloop <= 0x14; cloop += 4) {
+
+			/* Figure out IO and memory base lengths
+			   P2P BAR is not for children though... */
+			for (cloop = PCI_BASE_ADDRESS_0; cloop <= PCI_BASE_ADDRESS_1; cloop += 4) {
 				pci_bus_read_config_dword (pci_bus, devfn, cloop, &save_base);
 
 				temp_register = 0xFFFFFFFF;
 				pci_bus_write_config_dword (pci_bus, devfn, cloop, temp_register);
-				pci_bus_read_config_dword (pci_bus, devfn, cloop, &base);
+				pci_bus_read_config_dword (pci_bus, devfn, cloop, &temp_register);
 
-				temp_register = base;
+				if (!disable) {
+					pci_bus_write_config_dword (pci_bus, devfn, cloop, save_base);
+				}
 
-				if (base) {  // If this register is implemented
-					if (((base & 0x03L) == 0x01)
-					    && (save_command & 0x01)) {
-						// IO base
-						// set temp_register = amount of IO space requested
-						temp_register = base & 0xFFFFFFFE;
-						temp_register = (~temp_register) + 1;
-
-						io_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
-						if (!io_node)
-							return -ENOMEM;
-
-						io_node->base =
-						save_base & (~0x03L);
-						io_node->length = temp_register;
+				if (!temp_register)
+					continue;
 
-						io_node->next = func->io_head;
-						func->io_head = io_node;
+				base = temp_register;
+
+				if ((base & PCI_BASE_ADDRESS_SPACE_IO) && (!disable || (save_command & PCI_COMMAND_IO))) {
+					/* IO base */
+					/* set temp_register = amount of IO space requested */
+					base = base & 0xFFFFFFFCL;
+					base = (~base) + 1;
+
+					io_node = (struct pci_resource *) kmalloc(sizeof (struct pci_resource), GFP_KERNEL);
+					if (!io_node)
+						return -ENOMEM;
+
+					io_node->base = (ulong)save_base & PCI_BASE_ADDRESS_IO_MASK;
+					io_node->length = (ulong)base;
+					dbg("sur: IO bar=0x%x(length=0x%x)\n", io_node->base, io_node->length);
+
+					io_node->next = func->io_head;
+					func->io_head = io_node;
+				} else {  /* map Memory */
+					int prefetchable = 1;
+					char *res_type_str = "PMEM";
+					u32 temp_register2;
+
+					t_mem_node = (struct pci_resource *) kmalloc(sizeof (struct pci_resource), GFP_KERNEL);
+					if (!t_mem_node)
+						return -ENOMEM;
+
+					if (!(base & PCI_BASE_ADDRESS_MEM_PREFETCH) && (!disable || (save_command & PCI_COMMAND_MEMORY))) {
+						prefetchable = 0;
+						mem_node = t_mem_node;
+						res_type_str++;
 					} else
-						if (((base & 0x0BL) == 0x08)
-						    && (save_command & 0x02)) {
-						// prefetchable memory base
-						temp_register = base & 0xFFFFFFF0;
-						temp_register = (~temp_register) + 1;
-
-						p_mem_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
-						if (!p_mem_node)
-							return -ENOMEM;
+						p_mem_node = t_mem_node;
 
-						p_mem_node->base = save_base & (~0x0FL);
-						p_mem_node->length = temp_register;
+					base = base & 0xFFFFFFF0L;
+					base = (~base) + 1;
 
-						p_mem_node->next = func->p_mem_head;
-						func->p_mem_head = p_mem_node;
-					} else
-						if (((base & 0x0BL) == 0x00)
-						    && (save_command & 0x02)) {
-						// prefetchable memory base
-						temp_register = base & 0xFFFFFFF0;
-						temp_register = (~temp_register) + 1;
-
-						mem_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
-						if (!mem_node)
-							return -ENOMEM;
+					switch (temp_register & PCI_BASE_ADDRESS_MEM_TYPE_MASK) {
+					case PCI_BASE_ADDRESS_MEM_TYPE_32:
+						if (prefetchable) {
+							p_mem_node->base = (ulong)save_base & PCI_BASE_ADDRESS_MEM_MASK;
+							p_mem_node->length = (ulong)base;
+							dbg("sur: 32 %s bar=0x%x(length=0x%x)\n", res_type_str, p_mem_node->base, p_mem_node->length);
+
+							p_mem_node->next = func->p_mem_head;
+							func->p_mem_head = p_mem_node;
+						} else {
+							mem_node->base = (ulong)save_base & PCI_BASE_ADDRESS_MEM_MASK;
+							mem_node->length = (ulong)base;
+							dbg("sur: 32 %s bar=0x%x(length=0x%x)\n", res_type_str, mem_node->base, mem_node->length);
+
+							mem_node->next = func->mem_head;
+							func->mem_head = mem_node;
+						}
+						break;
+					case PCI_BASE_ADDRESS_MEM_TYPE_64:
+						pci_bus_read_config_dword(pci_bus, devfn, cloop+4, &temp_register2);
+
+						base64 = temp_register2;
+						base64 = (base64 << 32) | save_base;
+
+						if (temp_register2) {
+							dbg("sur: 64 %s high dword of base64(0x%x:%x) masked to 0\n", res_type_str, temp_register2, (u32)base64);
+							base64 &= 0x00000000FFFFFFFFL;
+						}
+
+						if (prefetchable) {
+							p_mem_node->base = base64 & PCI_BASE_ADDRESS_MEM_MASK;
+							p_mem_node->length = base;
+							dbg("sur: 64 %s base=0x%x(len=0x%x)\n", res_type_str, p_mem_node->base, p_mem_node->length);
+
+							p_mem_node->next = func->p_mem_head;
+							func->p_mem_head = p_mem_node;
+						} else {
+							mem_node->base = base64 & PCI_BASE_ADDRESS_MEM_MASK;
+							mem_node->length = base;
+							dbg("sur: 64 %s base=0x%x(len=0x%x)\n", res_type_str, mem_node->base, mem_node->length);
+
+							mem_node->next = func->mem_head;
+							func->mem_head = mem_node;
+						}
+						cloop += 4;
+						break;
+					default:
+						dbg("asur: reserved BAR type=0x%x\n", temp_register);
+						break;
 
-						mem_node->base = save_base & (~0x0FL);
-						mem_node->length = temp_register;
+					}
+				} 
+			}	/* End of base register loop */
+		} else if ((header_type & 0x7F) == PCI_HEADER_TYPE_NORMAL) {
+			dbg("Save_used_res of PCI adapter b:d=0x%x:%x, sc=0x%x\n", func->bus, func->device, save_command);
 
-						mem_node->next = func->mem_head;
-						func->mem_head = mem_node;
-					} else
-						return(1);
-				}
-			}	// End of base register loop
-		} else if ((header_type & 0x7F) == 0x00) {	  // Standard header
-			// Figure out IO and memory base lengths
-			for (cloop = 0x10; cloop <= 0x24; cloop += 4) {
+			/* Figure out IO and memory base lengths */
+			for (cloop = PCI_BASE_ADDRESS_0; cloop <= PCI_BASE_ADDRESS_5; cloop += 4) {
 				pci_bus_read_config_dword (pci_bus, devfn, cloop, &save_base);
 
 				temp_register = 0xFFFFFFFF;
-				pci_bus_write_config_dword (pci_bus, devfn, cloop, temp_register);
-				pci_bus_read_config_dword (pci_bus, devfn, cloop, &base);
-
-				temp_register = base;
-
-				if (base) {	  // If this register is implemented
-					if (((base & 0x03L) == 0x01)
-					    && (save_command & 0x01)) {
-						// IO base
-						// set temp_register = amount of IO space requested
-						temp_register = base & 0xFFFFFFFE;
-						temp_register = (~temp_register) + 1;
-
-						io_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
-						if (!io_node)
-							return -ENOMEM;
-
-						io_node->base = save_base & (~0x01L);
-						io_node->length = temp_register;
-
-						io_node->next = func->io_head;
-						func->io_head = io_node;
-					} else
-						if (((base & 0x0BL) == 0x08)
-						    && (save_command & 0x02)) {
-						// prefetchable memory base
-						temp_register = base & 0xFFFFFFF0;
-						temp_register = (~temp_register) + 1;
-
-						p_mem_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
-						if (!p_mem_node)
-							return -ENOMEM;
-
-						p_mem_node->base = save_base & (~0x0FL);
-						p_mem_node->length = temp_register;
-
-						p_mem_node->next = func->p_mem_head;
-						func->p_mem_head = p_mem_node;
-					} else
-						if (((base & 0x0BL) == 0x00)
-						    && (save_command & 0x02)) {
-						// prefetchable memory base
-						temp_register = base & 0xFFFFFFF0;
-						temp_register = (~temp_register) + 1;
-
-						mem_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
-						if (!mem_node)
-							return -ENOMEM;
-
-						mem_node->base = save_base & (~0x0FL);
-						mem_node->length = temp_register;
 
-						mem_node->next = func->mem_head;
-						func->mem_head = mem_node;
-					} else
-						return(1);
-				}
-			}	// End of base register loop
-		} else {	  // Some other unknown header type
-		}
-
-		// find the next device in this slot
-		func = cpqhp_slot_find(func->bus, func->device, index++);
-	}
-
-	return(0);
-}
-
-
-/*
- * cpqhp_configure_board
- *
- * Copies saved configuration information to one slot.
- * this is called recursively for bridge devices.
- * this is for hot plug REPLACE!
- *
- * returns 0 if success
- */
-int cpqhp_configure_board(struct controller *ctrl, struct pci_func * func)
-{
-	int cloop;
-	u8 header_type;
-	u8 secondary_bus;
-	int sub_bus;
-	struct pci_func *next;
-	u32 temp;
-	u32 rc;
-	int index = 0;
-	struct pci_bus *pci_bus = ctrl->pci_bus;
-	unsigned int devfn;
-
-	func = cpqhp_slot_find(func->bus, func->device, index++);
-
-	while (func != NULL) {
-		pci_bus->number = func->bus;
-		devfn = PCI_DEVFN(func->device, func->function);
-
-		// Start at the top of config space so that the control
-		// registers are programmed last
-		for (cloop = 0x3C; cloop > 0; cloop -= 4) {
-			pci_bus_write_config_dword (pci_bus, devfn, cloop, func->config_space[cloop >> 2]);
-		}
-
-		pci_bus_read_config_byte (pci_bus, devfn, PCI_HEADER_TYPE, &header_type);
-
-		// If this is a bridge device, restore subordinate devices
-		if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {	  // PCI-PCI Bridge
-			pci_bus_read_config_byte (pci_bus, devfn, PCI_SECONDARY_BUS, &secondary_bus);
-
-			sub_bus = (int) secondary_bus;
-
-			next = cpqhp_slot_list[sub_bus];
-
-			while (next != NULL) {
-				rc = cpqhp_configure_board(ctrl, next);
-
-				if (rc)
-					return rc;
-
-				next = next->next;
-			}
-		} else {
-
-			// Check all the base Address Registers to make sure
-			// they are the same.  If not, the board is different.
-
-			for (cloop = 16; cloop < 40; cloop += 4) {
-				pci_bus_read_config_dword (pci_bus, devfn, cloop, &temp);
+				pci_bus_write_config_dword (pci_bus, devfn, cloop, temp_register);
+				pci_bus_read_config_dword (pci_bus, devfn, cloop, &temp_register);
 
-				if (temp != func->config_space[cloop >> 2]) {
-					dbg("Config space compare failure!!! offset = %x\n", cloop);
-					dbg("bus = %x, device = %x, function = %x\n", func->bus, func->device, func->function);
-					dbg("temp = %x, config space = %x\n\n", temp, func->config_space[cloop >> 2]);
-					return 1;
+				if (!disable) {
+					pci_bus_write_config_dword (pci_bus, devfn, cloop, save_base);
 				}
-			}
-		}
-
-		func->configured = 1;
-
-		func = cpqhp_slot_find(func->bus, func->device, index++);
-	}
-
-	return 0;
-}
 
+				if (!temp_register)
+					continue;
 
-/*
- * cpqhp_valid_replace
- *
- * this function checks to see if a board is the same as the
- * one it is replacing.  this check will detect if the device's
- * vendor or device id's are the same
- *
- * returns 0 if the board is the same nonzero otherwise
- */
-int cpqhp_valid_replace(struct controller *ctrl, struct pci_func * func)
-{
-	u8 cloop;
-	u8 header_type;
-	u8 secondary_bus;
-	u8 type;
-	u32 temp_register = 0;
-	u32 base;
-	u32 rc;
-	struct pci_func *next;
-	int index = 0;
-	struct pci_bus *pci_bus = ctrl->pci_bus;
-	unsigned int devfn;
-
-	if (!func->is_a_board)
-		return(ADD_NOT_SUPPORTED);
-
-	func = cpqhp_slot_find(func->bus, func->device, index++);
-
-	while (func != NULL) {
-		pci_bus->number = func->bus;
-		devfn = PCI_DEVFN(func->device, func->function);
-
-		pci_bus_read_config_dword (pci_bus, devfn, PCI_VENDOR_ID, &temp_register);
-
-		// No adapter present
-		if (temp_register == 0xFFFFFFFF)
-			return(NO_ADAPTER_PRESENT);
-
-		if (temp_register != func->config_space[0])
-			return(ADAPTER_NOT_SAME);
-
-		// Check for same revision number and class code
-		pci_bus_read_config_dword (pci_bus, devfn, PCI_CLASS_REVISION, &temp_register);
-
-		// Adapter not the same
-		if (temp_register != func->config_space[0x08 >> 2])
-			return(ADAPTER_NOT_SAME);
-
-		// Check for Bridge
-		pci_bus_read_config_byte (pci_bus, devfn, PCI_HEADER_TYPE, &header_type);
-
-		if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {	  // PCI-PCI Bridge
-			// In order to continue checking, we must program the
-			// bus registers in the bridge to respond to accesses
-			// for it's subordinate bus(es)
-
-			temp_register = func->config_space[0x18 >> 2];
-			pci_bus_write_config_dword (pci_bus, devfn, PCI_PRIMARY_BUS, temp_register);
-
-			secondary_bus = (temp_register >> 8) & 0xFF;
-
-			next = cpqhp_slot_list[secondary_bus];
-
-			while (next != NULL) {
-				rc = cpqhp_valid_replace(ctrl, next);
-
-				if (rc)
-					return(rc);
-
-				next = next->next;
-			}
-
-		}
-		// Check to see if it is a standard config header
-		else if ((header_type & 0x7F) == PCI_HEADER_TYPE_NORMAL) {
-			// Check subsystem vendor and ID
-			pci_bus_read_config_dword (pci_bus, devfn, PCI_SUBSYSTEM_VENDOR_ID, &temp_register);
-
-			if (temp_register != func->config_space[0x2C >> 2]) {
-				// If it's a SMART-2 and the register isn't filled
-				// in, ignore the difference because
-				// they just have an old rev of the firmware
-
-				if (!((func->config_space[0] == 0xAE100E11)
-				      && (temp_register == 0x00L)))
-					return(ADAPTER_NOT_SAME);
-			}
-			// Figure out IO and memory base lengths
-			for (cloop = 0x10; cloop <= 0x24; cloop += 4) {
-				temp_register = 0xFFFFFFFF;
-				pci_bus_write_config_dword (pci_bus, devfn, cloop, temp_register);
-				pci_bus_read_config_dword (pci_bus, devfn, cloop, &base);
-				if (base) {	  // If this register is implemented
-					if (base & 0x01L) {
-						// IO base
-						// set base = amount of IO space requested
-						base = base & 0xFFFFFFFE;
-						base = (~base) + 1;
+				base = temp_register;
+
+				if ((base & PCI_BASE_ADDRESS_SPACE_IO) && (!disable || (save_command & PCI_COMMAND_IO))) {
+					/* IO base */
+					/* set temp_register = amount of IO space requested */
+					base = base & 0xFFFFFFFCL;
+					base = (~base) + 1;
+
+					io_node = (struct pci_resource *) kmalloc(sizeof (struct pci_resource), GFP_KERNEL);
+					if (!io_node)
+						return -ENOMEM;
+
+					io_node->base = (ulong)save_base & PCI_BASE_ADDRESS_IO_MASK;
+					io_node->length = (ulong)base;
+					dbg("sur adapter: IO bar=0x%x(length=0x%x)\n", io_node->base, io_node->length);
+
+					io_node->next = func->io_head;
+					func->io_head = io_node;
+				} else {  /* map Memory */
+					int prefetchable = 1;
+					char *res_type_str = "PMEM";
+					u32 temp_register2;
+
+					t_mem_node = (struct pci_resource *) kmalloc(sizeof (struct pci_resource), GFP_KERNEL);
+					if (!t_mem_node)
+						return -ENOMEM;
+
+					if (!(base & PCI_BASE_ADDRESS_MEM_PREFETCH) && (!disable || (save_command & PCI_COMMAND_MEMORY))) {
+						prefetchable = 0;
+						mem_node = t_mem_node;
+						res_type_str++;
+					} else
+						p_mem_node = t_mem_node;
 
-						type = 1;
-					} else {
-						// memory base
-						base = base & 0xFFFFFFF0;
-						base = (~base) + 1;
+					base = base & 0xFFFFFFF0L;
+					base = (~base) + 1;
 
-						type = 0;
+					switch (temp_register & PCI_BASE_ADDRESS_MEM_TYPE_MASK) {
+					case PCI_BASE_ADDRESS_MEM_TYPE_32:
+						if (prefetchable) {
+							p_mem_node->base = (ulong)save_base & PCI_BASE_ADDRESS_MEM_MASK;
+							p_mem_node->length = (ulong)base;
+							dbg("sur adapter: 32 %s bar=0x%x(length=0x%x)\n", res_type_str, p_mem_node->base, p_mem_node->length);
+
+							p_mem_node->next = func->p_mem_head;
+							func->p_mem_head = p_mem_node;
+						} else {
+							mem_node->base = (ulong)save_base & PCI_BASE_ADDRESS_MEM_MASK;
+							mem_node->length = (ulong)base;
+							dbg("sur adapter: 32 %s bar=0x%x(length=0x%x)\n", res_type_str, mem_node->base, mem_node->length);
+
+							mem_node->next = func->mem_head;
+							func->mem_head = mem_node;
+						}
+						break;
+					case PCI_BASE_ADDRESS_MEM_TYPE_64:
+						pci_bus_read_config_dword(pci_bus, devfn, cloop+4, &temp_register2);
+
+						base64 = temp_register2;
+						base64 = (base64 << 32) | save_base;
+
+						if (temp_register2) {
+							dbg("sur adapter: 64 %s high dword of base64(0x%x:%x) masked to 0\n", res_type_str, temp_register2, (u32)base64);
+							base64 &= 0x00000000FFFFFFFFL;
+						}
+
+						if (prefetchable) {
+							p_mem_node->base = base64 & PCI_BASE_ADDRESS_MEM_MASK;
+							p_mem_node->length = base;
+							dbg("sur adapter: 64 %s base=0x%x(len=0x%x)\n", res_type_str, p_mem_node->base, p_mem_node->length);
+
+							p_mem_node->next = func->p_mem_head;
+							func->p_mem_head = p_mem_node;
+						} else {
+							mem_node->base = base64 & PCI_BASE_ADDRESS_MEM_MASK;
+							mem_node->length = base;
+							dbg("sur adapter: 64 %s base=0x%x(len=0x%x)\n", res_type_str, mem_node->base, mem_node->length);
+
+							mem_node->next = func->mem_head;
+							func->mem_head = mem_node;
+						}
+						cloop += 4;
+						break;
+					default:
+						dbg("asur: reserved BAR type=0x%x\n", temp_register);
+						break;
 					}
-				} else {
-					base = 0x0L;
-					type = 0;
-				}
-
-				// Check information in slot structure
-				if (func->base_length[(cloop - 0x10) >> 2] != base)
-					return(ADAPTER_NOT_SAME);
-
-				if (func->base_type[(cloop - 0x10) >> 2] != type)
-					return(ADAPTER_NOT_SAME);
-
-			}	// End of base register loop
-
-		}		// End of (type 0 config space) else
-		else {
-			// this is not a type 0 or 1 config space header so
-			// we don't know how to do it
-			return(DEVICE_TYPE_NOT_SUPPORTED);
+				} 
+			}	/* End of base register loop */
+		} else {	/* Some other unknown header type */
+			dbg("Save_used_res of PCI unknown type b:d=0x%x:%x. skip.\n", func->bus, func->device);
 		}
 
-		// Get the next function
+		/* find the next device in this slot */
+		if (!disable)
+			break;
 		func = cpqhp_slot_find(func->bus, func->device, index++);
 	}
 
-
 	return(0);
 }
 
 
 /*
- * cpqhp_find_available_resources
- *
- * Finds available memory, IO, and IRQ resources for programming
- * devices which may be added to the system
- * this function is for hot plug ADD!
- *
- * returns 0 if success
- */  
-int cpqhp_find_available_resources (struct controller *ctrl, void *rom_start)
-{
-	u8 temp;
-	u8 populated_slot;
-	u8 bridged_slot;
-	void *one_slot;
-	struct pci_func *func = NULL;
-	int i = 10, index;
-	u32 temp_dword, rc;
-	struct pci_resource *mem_node;
-	struct pci_resource *p_mem_node;
-	struct pci_resource *io_node;
-	struct pci_resource *bus_node;
-	void *rom_resource_table;
-
-	rom_resource_table = detect_HRT_floating_pointer(rom_start, rom_start+0xffff);
-	dbg("rom_resource_table = %p\n", rom_resource_table);
-
-	if (rom_resource_table == NULL) {
-		return -ENODEV;
-	}
-	// Sum all resources and setup resource maps
-	unused_IRQ = readl(rom_resource_table + UNUSED_IRQ);
-	dbg("unused_IRQ = %x\n", unused_IRQ);
-
-	temp = 0;
-	while (unused_IRQ) {
-		if (unused_IRQ & 1) {
-			cpqhp_disk_irq = temp;
-			break;
-		}
-		unused_IRQ = unused_IRQ >> 1;
-		temp++;
-	}
-
-	dbg("cpqhp_disk_irq= %d\n", cpqhp_disk_irq);
-	unused_IRQ = unused_IRQ >> 1;
-	temp++;
-
-	while (unused_IRQ) {
-		if (unused_IRQ & 1) {
-			cpqhp_nic_irq = temp;
-			break;
-		}
-		unused_IRQ = unused_IRQ >> 1;
-		temp++;
-	}
-
-	dbg("cpqhp_nic_irq= %d\n", cpqhp_nic_irq);
-	unused_IRQ = readl(rom_resource_table + PCIIRQ);
-
-	temp = 0;
-
-	if (!cpqhp_nic_irq) {
-		cpqhp_nic_irq = ctrl->cfgspc_irq;
-	}
-
-	if (!cpqhp_disk_irq) {
-		cpqhp_disk_irq = ctrl->cfgspc_irq;
-	}
-
-	dbg("cpqhp_disk_irq, cpqhp_nic_irq= %d, %d\n", cpqhp_disk_irq, cpqhp_nic_irq);
-
-	rc = compaq_nvram_load(rom_start, ctrl);
-	if (rc)
-		return rc;
-
-	one_slot = rom_resource_table + sizeof (struct hrt);
-
-	i = readb(rom_resource_table + NUMBER_OF_ENTRIES);
-	dbg("number_of_entries = %d\n", i);
-
-	if (!readb(one_slot + SECONDARY_BUS)) {
-		return(1);
-	}
-
-	dbg("dev|IO base|length|Mem base|length|Pre base|length|PB SB MB\n");
-
-	while (i && readb(one_slot + SECONDARY_BUS)) {
-		u8 dev_func = readb(one_slot + DEV_FUNC);
-		u8 primary_bus = readb(one_slot + PRIMARY_BUS);
-		u8 secondary_bus = readb(one_slot + SECONDARY_BUS);
-		u8 max_bus = readb(one_slot + MAX_BUS);
-		u16 io_base = readw(one_slot + IO_BASE);
-		u16 io_length = readw(one_slot + IO_LENGTH);
-		u16 mem_base = readw(one_slot + MEM_BASE);
-		u16 mem_length = readw(one_slot + MEM_LENGTH);
-		u16 pre_mem_base = readw(one_slot + PRE_MEM_BASE);
-		u16 pre_mem_length = readw(one_slot + PRE_MEM_LENGTH);
-
-		dbg("%2.2x | %4.4x  | %4.4x | %4.4x   | %4.4x | %4.4x   | %4.4x |%2.2x %2.2x %2.2x\n",
-		    dev_func, io_base, io_length, mem_base, mem_length, pre_mem_base, pre_mem_length,
-		    primary_bus, secondary_bus, max_bus);
-
-		// If this entry isn't for our controller's bus, ignore it
-		if (primary_bus != ctrl->bus) {
-			i--;
-			one_slot += sizeof (struct slot_rt);
-			continue;
-		}
-		// find out if this entry is for an occupied slot
-		ctrl->pci_bus->number = primary_bus;
-		pci_bus_read_config_dword (ctrl->pci_bus, dev_func, PCI_VENDOR_ID, &temp_dword);
-		dbg("temp_D_word = %x\n", temp_dword);
-
-		if (temp_dword != 0xFFFFFFFF) {
-			index = 0;
-			func = cpqhp_slot_find(primary_bus, dev_func >> 3, 0);
-
-			while (func && (func->function != (dev_func & 0x07))) {
-				dbg("func = %p (bus, dev, fun) = (%d, %d, %d)\n", func, primary_bus, dev_func >> 3, index);
-				func = cpqhp_slot_find(primary_bus, dev_func >> 3, index++);
-			}
-
-			// If we can't find a match, skip this table entry
-			if (!func) {
-				i--;
-				one_slot += sizeof (struct slot_rt);
-				continue;
-			}
-			// this may not work and shouldn't be used
-			if (secondary_bus != primary_bus)
-				bridged_slot = 1;
-			else
-				bridged_slot = 0;
-
-			populated_slot = 1;
-		} else {
-			populated_slot = 0;
-			bridged_slot = 0;
-		}
-
-
-		// If we've got a valid IO base, use it
-
-		temp_dword = io_base + io_length;
-
-		if ((io_base) && (temp_dword < 0x10000)) {
-			io_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
-			if (!io_node)
-				return -ENOMEM;
-
-			io_node->base = io_base;
-			io_node->length = io_length;
-
-			dbg("found io_node(base, length) = %x, %x\n", io_node->base, io_node->length);
-			dbg("populated slot =%d \n", populated_slot);
-			if (!populated_slot) {
-				io_node->next = ctrl->io_head;
-				ctrl->io_head = io_node;
-			} else {
-				io_node->next = func->io_head;
-				func->io_head = io_node;
-			}
-		}
-
-		// If we've got a valid memory base, use it
-		temp_dword = mem_base + mem_length;
-		if ((mem_base) && (temp_dword < 0x10000)) {
-			mem_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
-			if (!mem_node)
-				return -ENOMEM;
-
-			mem_node->base = mem_base << 16;
-
-			mem_node->length = mem_length << 16;
-
-			dbg("found mem_node(base, length) = %x, %x\n", mem_node->base, mem_node->length);
-			dbg("populated slot =%d \n", populated_slot);
-			if (!populated_slot) {
-				mem_node->next = ctrl->mem_head;
-				ctrl->mem_head = mem_node;
-			} else {
-				mem_node->next = func->mem_head;
-				func->mem_head = mem_node;
-			}
-		}
-
-		// If we've got a valid prefetchable memory base, and
-		// the base + length isn't greater than 0xFFFF
-		temp_dword = pre_mem_base + pre_mem_length;
-		if ((pre_mem_base) && (temp_dword < 0x10000)) {
-			p_mem_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
-			if (!p_mem_node)
-				return -ENOMEM;
-
-			p_mem_node->base = pre_mem_base << 16;
-
-			p_mem_node->length = pre_mem_length << 16;
-			dbg("found p_mem_node(base, length) = %x, %x\n", p_mem_node->base, p_mem_node->length);
-			dbg("populated slot =%d \n", populated_slot);
-
-			if (!populated_slot) {
-				p_mem_node->next = ctrl->p_mem_head;
-				ctrl->p_mem_head = p_mem_node;
-			} else {
-				p_mem_node->next = func->p_mem_head;
-				func->p_mem_head = p_mem_node;
-			}
-		}
-
-		// If we've got a valid bus number, use it
-		// The second condition is to ignore bus numbers on
-		// populated slots that don't have PCI-PCI bridges
-		if (secondary_bus && (secondary_bus != primary_bus)) {
-			bus_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
-			if (!bus_node)
-				return -ENOMEM;
-
-			bus_node->base = secondary_bus;
-			bus_node->length = max_bus - secondary_bus + 1;
-			dbg("found bus_node(base, length) = %x, %x\n", bus_node->base, bus_node->length);
-			dbg("populated slot =%d \n", populated_slot);
-			if (!populated_slot) {
-				bus_node->next = ctrl->bus_head;
-				ctrl->bus_head = bus_node;
-			} else {
-				bus_node->next = func->bus_head;
-				func->bus_head = bus_node;
-			}
-		}
-
-		i--;
-		one_slot += sizeof (struct slot_rt);
-	}
-
-	// If all of the following fail, we don't have any resources for
-	// hot plug add
-	rc = 1;
-	rc &= cpqhp_resource_sort_and_combine(&(ctrl->mem_head));
-	rc &= cpqhp_resource_sort_and_combine(&(ctrl->p_mem_head));
-	rc &= cpqhp_resource_sort_and_combine(&(ctrl->io_head));
-	rc &= cpqhp_resource_sort_and_combine(&(ctrl->bus_head));
-
-	return(rc);
-}
-
-
-/*
  * cpqhp_return_board_resources
  *
  * this routine returns all resources allocated to a board to
diff -Nru a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
--- a/drivers/pci/hotplug/Kconfig	2003-07-02 13:46:17.000000000 -0700
+++ b/drivers/pci/hotplug/Kconfig	2003-07-07 09:32:25.000000000 -0700
@@ -47,11 +47,11 @@
 	  When in doubt, say N.
 
 config HOTPLUG_PCI_COMPAQ
-	tristate "Compaq PCI Hotplug driver"
-	depends on HOTPLUG_PCI && X86
+	tristate "Compaq/Intel PCI Hotplug driver"
+	depends on HOTPLUG_PCI
 	help
 	  Say Y here if you have a motherboard with a Compaq PCI Hotplug
-	  controller.
+	  controller or equivalent Intel controller.
 
 	  This code is also available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
@@ -60,9 +60,19 @@
 
 	  When in doubt, say N.
 
+config HOTPLUG_PCI_COMPAQ_PHPRM_LEGACY
+	bool "Non-ACPI: Use Hotplug Resource Table ($HRT) for resource information"
+	depends on HOTPLUG_PCI_COMPAQ
+	help
+	  Say Y here if Hotplug resource/configuration information is provided
+	  by platform BIOS $HRT, not by ACPI.
+	  Some ACPI compliant platforms may use this too if $HRT is provided.
+
+	  When in doubt, say N.
+
 config HOTPLUG_PCI_COMPAQ_NVRAM
 	bool "Save configuration into NVRAM on Compaq servers"
-	depends on HOTPLUG_PCI_COMPAQ
+	depends on HOTPLUG_PCI_COMPAQ_PHPRM_LEGACY
 	help
 	  Say Y here if you have a Compaq server that has a PCI Hotplug
 	  controller.  This will allow the PCI Hotplug driver to store the PCI
diff -Nru a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
--- a/drivers/pci/hotplug/Makefile	2003-07-02 13:51:13.000000000 -0700
+++ b/drivers/pci/hotplug/Makefile	2003-07-07 09:32:25.000000000 -0700
@@ -3,7 +3,7 @@
 #
 
 obj-$(CONFIG_HOTPLUG_PCI)		+= pci_hotplug.o
-obj-$(CONFIG_HOTPLUG_PCI_FAKE)		+= fakephp.o 
+obj-$(CONFIG_HOTPLUG_PCI_FAKE)		+= fakephp.o
 obj-$(CONFIG_HOTPLUG_PCI_COMPAQ)	+= cpqphp.o
 obj-$(CONFIG_HOTPLUG_PCI_IBM)		+= ibmphp.o
 obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
@@ -20,7 +20,8 @@
 cpqphp-objs		:=	cpqphp_core.o	\
 				cpqphp_ctrl.o	\
 				cpqphp_sysfs.o	\
-				cpqphp_pci.o
+				cpqphp_pci.o	\
+				cpqphp_hpc.o
 
 ibmphp-objs		:=	ibmphp_core.o	\
 				ibmphp_ebda.o	\
@@ -40,6 +41,13 @@
   endif
 endif
 
+ifeq ($(CONFIG_HOTPLUG_PCI_COMPAQ_PHPRM_LEGACY),y)
+    cpqphp-objs += phprm_legacy.o
+else
+    cpqphp-objs += phprm_acpi.o
+    EXTRA_CFLAGS += -D_LINUX -I$(TOPDIR)/drivers/acpi -I$(TOPDIR)/drivers/acpi/include -DPHP_ACPI
+endif
+
 ifeq ($(CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM),y)
 	cpqphp-objs += cpqphp_nvram.o
 endif

