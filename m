Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTEFW4X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 18:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbTEFWzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 18:55:45 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:26042 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262063AbTEFWwp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 18:52:45 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10522624132138@kroah.com>
Subject: [PATCH] PCI hotplug changes for 2.5.69
In-Reply-To: <20030506230539.GA4007@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 6 May 2003 16:06:53 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.889.392.1, 2003/03/19 13:30:05-08:00, torben.mathiasen@hp.com

[PATCH] PCI Hotplug: cpqphp 66/100/133MHz PCI-X support

After being put on hold for a while (needed fixes to CCISS driver, etc) I
attached a patch that adds pci-x support to the cpqphp driver in 2.5.65.

Changes:
	Adds 66/100/133MHz PCI-X support.
	Adds support for dynamically chaning frequency and mode.
	Changes code to also blink the power LED when powering down.
	Uses the IRQ from PCI config space if the ROM resource table doesn't
	provide one (would previously use the same interrupt as the hotplug
	controller which would lead to bad things when trying to update routing
	tables). Dan Zink should have the credit for this fix.
	Changes find_slot() to cpqhp_find_slot().
	Uses sysfs to display speed/freq.
	Some documentation updates.


 drivers/hotplug/cpqphp.h      |  203 ++++++++++++++++++++++++++++++++++++++++--
 drivers/hotplug/cpqphp_core.c |   57 ++++++++++-
 drivers/hotplug/cpqphp_ctrl.c |  148 ++++++++++++++++--------------
 drivers/hotplug/cpqphp_pci.c  |    5 -
 4 files changed, 334 insertions(+), 79 deletions(-)


diff -Nru a/drivers/hotplug/cpqphp.h b/drivers/hotplug/cpqphp.h
--- a/drivers/hotplug/cpqphp.h	Tue May  6 15:56:19 2003
+++ b/drivers/hotplug/cpqphp.h	Tue May  6 15:56:19 2003
@@ -30,7 +30,7 @@
 
 #include "pci_hotplug.h"
 #include <asm/io.h>		/* for read? and write? functions */
-
+#include <linux/delay.h>	/* for delays */
 
 #if !defined(CONFIG_HOTPLUG_PCI_COMPAQ_MODULE)
 	#define MY_NAME	"cpqphp.o"
@@ -145,6 +145,10 @@
 	u8	reserved11;		/* 0x2b */
 	u8	slot_SERR;		/* 0x2c */
 	u8	slot_power;		/* 0x2d */
+	u8	reserved12;		/* 0x2e */
+	u8	reserved13;		/* 0x2f */
+	u8	next_curr_freq;		/* 0x30 */
+	u8	reset_freq_mode;	/* 0x31 */
 } __attribute__ ((packed));
 
 /* offsets to the controller registers based on the above structure layout */
@@ -172,6 +176,8 @@
 	CTRL_RESERVED11 =	offsetof(struct ctrl_reg, reserved11),
 	SLOT_SERR =		offsetof(struct ctrl_reg, slot_SERR),
 	SLOT_POWER =		offsetof(struct ctrl_reg, slot_power),
+	NEXT_CURR_FREQ =	offsetof(struct ctrl_reg, next_curr_freq),
+	RESET_FREQ_MODE =	offsetof(struct ctrl_reg, reset_freq_mode),
 };
 
 struct hrt {
@@ -299,6 +305,7 @@
 	struct slot *slot;
 	u8 next_event;
 	u8 interrupt;
+	u8 cfgspc_irq;
 	u8 bus;				/* bus number for the pci hotplug controller */
 	u8 rev;
 	u8 slot_device_offset;
@@ -343,6 +350,7 @@
 #define PCI_SUB_HPC_ID2			0xA2F8
 #define PCI_SUB_HPC_ID3			0xA2F9
 #define PCI_SUB_HPC_ID_INTC		0xA2FA
+#define PCI_SUB_HPC_ID4			0xA2FD
 
 #define INT_BUTTON_IGNORE		0
 #define INT_PRESENCE_ON			1
@@ -435,7 +443,7 @@
 extern void	cpqhp_destroy_resource_list	(struct resource_lists * resources);
 extern int	cpqhp_configure_device		(struct controller* ctrl, struct pci_func* func);
 extern int	cpqhp_unconfigure_device	(struct pci_func* func);
-
+extern struct slot *cpqhp_find_slot		(struct controller *ctrl, u8 device);
 
 /* Global variables */
 extern int cpqhp_debug;
@@ -563,6 +571,7 @@
 	u32 led_control;
 	
 	led_control = readl(ctrl->hpc_reg + LED_CONTROL);
+	led_control &= ~(0x0101L << slot);
 	led_control |= (0x0001L << slot);
 	writel(led_control, ctrl->hpc_reg + LED_CONTROL);
 }
@@ -604,14 +613,63 @@
 }
 
 
+/*
+ * get_controller_speed - find the current frequency/mode of controller.
+ *
+ * @ctrl: controller to get frequency/mode for.
+ *
+ * Returns controller speed.
+ *
+ */
 static inline u8 get_controller_speed (struct controller *ctrl)
 {
-	u16 misc;
-	
-	misc = readw(ctrl->hpc_reg + MISC);
-	return (misc & 0x0800) ? PCI_SPEED_66MHz : PCI_SPEED_33MHz;
+	u8 curr_freq;
+ 	u16 misc;
+ 	
+	if (ctrl->pcix_support) {
+		curr_freq = readb(ctrl->hpc_reg + NEXT_CURR_FREQ);
+		if ((curr_freq & 0xB0) == 0xB0) 
+			return PCI_SPEED_133MHz_PCIX;
+		if ((curr_freq & 0xA0) == 0xA0)
+			return PCI_SPEED_100MHz_PCIX;
+		if ((curr_freq & 0x90) == 0x90)
+			return PCI_SPEED_66MHz_PCIX;
+		if (curr_freq & 0x10)
+			return PCI_SPEED_66MHz;
+
+		return PCI_SPEED_33MHz;
+	}
+
+ 	misc = readw(ctrl->hpc_reg + MISC);
+ 	return (misc & 0x0800) ? PCI_SPEED_66MHz : PCI_SPEED_33MHz;
 }
+ 
+
+/*
+ * get_adapter_speed - find the max supported frequency/mode of adapter.
+ *
+ * @ctrl: hotplug controller.
+ * @hp_slot: hotplug slot where adapter is installed.
+ *
+ * Returns adapter speed.
+ *
+ */
+static inline u8 get_adapter_speed (struct controller *ctrl, u8 hp_slot)
+{
+	u32 temp_dword = readl(ctrl->hpc_reg + NON_INT_INPUT);
+	dbg("slot: %d, PCIXCAP: %8x\n", hp_slot, temp_dword);
+	if (ctrl->pcix_support) {
+		if (temp_dword & (0x10000 << hp_slot))
+			return PCI_SPEED_133MHz_PCIX;
+		if (temp_dword & (0x100 << hp_slot))
+			return PCI_SPEED_66MHz_PCIX;
+	}
 
+	if (temp_dword & (0x01 << hp_slot))
+		return PCI_SPEED_66MHz;
+
+	return PCI_SPEED_33MHz;
+}
 
 static inline void enable_slot_power (struct controller *ctrl, u8 slot)
 {
@@ -718,6 +776,139 @@
 
 	dbg("%s - end\n", __FUNCTION__);
 	return retval;
+}
+
+
+/**
+ * set_controller_speed - set the frequency and/or mode of a specific
+ * controller segment.
+ *
+ * @ctrl: controller to change frequency/mode for.
+ * @adapter_speed: the speed of the adapter we want to match.
+ * @hp_slot: the slot number where the adapter is installed.
+ *
+ * Returns 0 if we successfully change frequency and/or mode to match the
+ * adapter speed.
+ * 
+ */
+static inline u8 set_controller_speed(struct controller *ctrl, u8 adapter_speed, u8 hp_slot)
+{
+	struct slot *slot;
+	u8 reg;
+	u8 slot_power = readb(ctrl->hpc_reg + SLOT_POWER);
+	u16 reg16;
+	u32 leds = readl(ctrl->hpc_reg + LED_CONTROL);
+	
+	if (ctrl->speed == adapter_speed)
+		return 0;
+	
+	/* We don't allow freq/mode changes if we find another adapter running
+	 * in another slot on this controller */
+	for(slot = ctrl->slot; slot; slot = slot->next) {
+		if (slot->device == (hp_slot + ctrl->slot_device_offset)) 
+			continue;
+		if (!slot->hotplug_slot && !slot->hotplug_slot->info) 
+			continue;
+		if (slot->hotplug_slot->info->adapter_status == 0) 
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
+	/* If the controller doesn't support freq/mode changes and the
+	 * controller is running at a higher mode, we bail */
+	if ((ctrl->speed > adapter_speed) && (!ctrl->pcix_speed_capability))
+		return 1;
+	
+	/* But we allow the adapter to run at a lower rate if possible */
+	if ((ctrl->speed < adapter_speed) && (!ctrl->pcix_speed_capability))
+		return 0;
+
+	/* We try to set the max speed supported by both the adapter and
+	 * controller */
+	if (ctrl->speed_capability < adapter_speed) {
+		if (ctrl->speed == ctrl->speed_capability)
+			return 0;
+		adapter_speed = ctrl->speed_capability;
+	}
+
+	writel(0x0L, ctrl->hpc_reg + LED_CONTROL);
+	writeb(0x00, ctrl->hpc_reg + SLOT_ENABLE);
+	
+	set_SOGO(ctrl); 
+	wait_for_ctrl_irq(ctrl);
+	
+	if (adapter_speed != PCI_SPEED_133MHz_PCIX)
+		reg = 0xF5;
+	else
+		reg = 0xF4;	
+	pci_write_config_byte(ctrl->pci_dev, 0x41, reg);
+	
+	reg16 = readw(ctrl->hpc_reg + NEXT_CURR_FREQ);
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
+	writew(reg16, ctrl->hpc_reg + NEXT_CURR_FREQ);
+	
+	mdelay(5); 
+	
+	/* Reenable interrupts */
+	writel(0, ctrl->hpc_reg + INT_MASK);
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
+			set_SOGO(ctrl);
+	
+	wait_for_ctrl_irq(ctrl);
+	mdelay(1100);
+	
+	/* Restore LED/Slot state */
+	writel(leds, ctrl->hpc_reg + LED_CONTROL);
+	writeb(slot_power, ctrl->hpc_reg + SLOT_ENABLE);
+	
+	set_SOGO(ctrl);
+	wait_for_ctrl_irq(ctrl);
+
+	ctrl->speed = adapter_speed;
+	slot = cpqhp_find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
+
+	info("Successfully changed frequency/mode for adapter in slot %d\n", 
+			slot->number);
+	return 0;
 }
 
 #endif
diff -Nru a/drivers/hotplug/cpqphp_core.c b/drivers/hotplug/cpqphp_core.c
--- a/drivers/hotplug/cpqphp_core.c	Tue May  6 15:56:19 2003
+++ b/drivers/hotplug/cpqphp_core.c	Tue May  6 15:56:19 2003
@@ -24,6 +24,9 @@
  *
  * Send feedback to <greg@kroah.com>
  *
+ * Jan 12, 2003 -	Added 66/100/133MHz PCI-X support,
+ * 			Torben Mathiasen <torben.mathiasen@hp.com>
+ *
  */
 
 #include <linux/config.h>
@@ -57,7 +60,7 @@
 static u8 power_mode;
 static int debug;
 
-#define DRIVER_VERSION	"0.9.6"
+#define DRIVER_VERSION	"0.9.7"
 #define DRIVER_AUTHOR	"Dan Zink <dan.zink@compaq.com>, Greg Kroah-Hartman <greg@kroah.com>"
 #define DRIVER_DESC	"Compaq Hot Plug PCI Controller Driver"
 
@@ -835,6 +838,7 @@
 	u8 hp_slot = 0;
 	u8 device;
 	u8 rev;
+	u8 bus_cap;
 	u16 temp_word;
 	u16 vendor_id;
 	u16 subsystem_vid;
@@ -896,6 +900,39 @@
 
 		switch (subsystem_vid) {
 			case PCI_VENDOR_ID_COMPAQ:
+				if (rev >= 0x13) { /* CIOBX */
+					ctrl->push_flag = 1;
+					ctrl->slot_switch_type = 1;		// Switch is present
+					ctrl->push_button = 1;			// Pushbutton is present
+					ctrl->pci_config_space = 1;		// Index/data access to working registers 0 = not supported, 1 = supported
+					ctrl->defeature_PHP = 1;		// PHP is supported
+					ctrl->pcix_support = 1;			// PCI-X supported
+					ctrl->pcix_speed_capability = 1;
+					pci_read_config_byte(pdev, 0x41, &bus_cap);
+					if (bus_cap & 0x80) {
+						dbg("bus max supports 133MHz PCI-X\n");
+						ctrl->speed_capability = PCI_SPEED_133MHz_PCIX;
+						break;
+					}
+					if (bus_cap & 0x40) {
+						dbg("bus max supports 100MHz PCI-X\n");
+						ctrl->speed_capability = PCI_SPEED_100MHz_PCIX;
+						break;
+					}
+					if (bus_cap & 20) {
+						dbg("bus max supports 66MHz PCI-X\n");
+						ctrl->speed_capability = PCI_SPEED_66MHz_PCIX;
+						break;
+					}
+					if (bus_cap & 10) {
+						dbg("bus max supports 66MHz PCI\n");
+						ctrl->speed_capability = PCI_SPEED_66MHz;
+						break;
+					}
+
+					break;
+				}
+
 				switch (subsystem_deviceid) {
 					case PCI_SUB_HPC_ID:
 						/* Original 6500/7000 implementation */
@@ -939,8 +976,18 @@
 						ctrl->pcix_support = 0;			// PCI-X not supported
 						ctrl->pcix_speed_capability = 0;	// N/A since PCI-X not supported
 						break;
+					case PCI_SUB_HPC_ID4:
+						/* First PCI-X implementation, 100MHz */
+						ctrl->push_flag = 1;
+						ctrl->slot_switch_type = 1;		// Switch is present
+						ctrl->speed_capability = PCI_SPEED_100MHz_PCIX;
+						ctrl->push_button = 1;			// Pushbutton is present
+						ctrl->pci_config_space = 1;		// Index/data access to working registers 0 = not supported, 1 = supported
+						ctrl->defeature_PHP = 1;		// PHP is supported
+						ctrl->pcix_support = 1;			// PCI-X supported
+						ctrl->pcix_speed_capability = 0;	
+						break;
 					default:
-						// TODO: Add SSIDs for CPQ systems that support PCI-X
 						err(msg_HPC_not_supported);
 						rc = -ENODEV;
 						goto err_free_ctrl;
@@ -1029,7 +1076,7 @@
 	info("Initializing the PCI hot plug controller residing on PCI bus %d\n", pdev->bus->number);
 
 	dbg ("Hotplug controller capabilities:\n");
-	dbg ("    speed_capability       %s\n", ctrl->speed_capability == PCI_SPEED_33MHz ? "33MHz" : "66Mhz");
+	dbg ("    speed_capability       %d\n", ctrl->speed_capability);
 	dbg ("    slot_switch_type       %s\n", ctrl->slot_switch_type == 0 ? "no switch" : "switch present");
 	dbg ("    defeature_PHP          %s\n", ctrl->defeature_PHP == 0 ? "PHP not supported" : "PHP supported");
 	dbg ("    alternate_base_address %s\n", ctrl->alternate_base_address == 0 ? "not supported" : "supported");
@@ -1082,7 +1129,6 @@
 	}
 
 	// Check for 66Mhz operation
-	// TODO: Add PCI-X support
 	ctrl->speed = get_controller_speed(ctrl);
 
 
@@ -1118,6 +1164,9 @@
 	 */
 	// The next line is required for cpqhp_find_available_resources
 	ctrl->interrupt = pdev->irq;
+
+	ctrl->cfgspc_irq = 0;
+	pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &ctrl->cfgspc_irq);
 
 	rc = cpqhp_find_available_resources(ctrl, cpqhp_rom_start);
 	ctrl->add_support = !rc;
diff -Nru a/drivers/hotplug/cpqphp_ctrl.c b/drivers/hotplug/cpqphp_ctrl.c
--- a/drivers/hotplug/cpqphp_ctrl.c	Tue May  6 15:56:19 2003
+++ b/drivers/hotplug/cpqphp_ctrl.c	Tue May  6 15:56:19 2003
@@ -136,9 +136,9 @@
 
 
 /*
- * find_slot
+ * cpqhp_find_slot
  */
-static inline struct slot *find_slot (struct controller * ctrl, u8 device)
+struct slot *cpqhp_find_slot (struct controller * ctrl, u8 device)
 {
 	struct slot *slot;
 
@@ -187,7 +187,7 @@
 
 			rc++;
 
-			p_slot = find_slot(ctrl, hp_slot + (readb(ctrl->hpc_reg + SLOT_MASK) >> 4));
+			p_slot = cpqhp_find_slot(ctrl, hp_slot + (readb(ctrl->hpc_reg + SLOT_MASK) >> 4));
 			if (!p_slot)
 				return 0;
 
@@ -919,6 +919,7 @@
 void cpqhp_ctrl_intr(int IRQ, struct controller * ctrl, struct pt_regs *regs)
 {
 	u8 schedule_flag = 0;
+	u8 reset;
 	u16 misc;
 	u32 Diff;
 	u32 temp_dword;
@@ -970,6 +971,15 @@
 		schedule_flag += handle_power_fault((u8)((Diff & 0xFF00L) >> 8), ctrl);
 	}
 
+	reset = readb(ctrl->hpc_reg + RESET_FREQ_MODE);
+	if (reset & 0x40) {
+		/* Bus reset has completed */
+		reset &= 0xCF;
+		writeb(reset, ctrl->hpc_reg + RESET_FREQ_MODE);
+		reset = readb(ctrl->hpc_reg + RESET_FREQ_MODE);
+		wake_up_interruptible(&ctrl->queue);
+	}
+
 	if (schedule_flag) {
 		up(&event_semaphore);
 		dbg("Signal event_semaphore\n");
@@ -1171,6 +1181,7 @@
 {
 	u8 hp_slot;
 	u8 temp_byte;
+	u8 adapter_speed;
 	u32 index;
 	u32 rc = 0;
 	u32 src = 8;
@@ -1188,46 +1199,46 @@
 		//*********************************
 		rc = CARD_FUNCTIONING;
 	} else {
-		if (ctrl->speed == PCI_SPEED_66MHz) {
-			// Wait for exclusive access to hardware
-			down(&ctrl->crit_sect);
-
-			// turn on board without attaching to the bus
-			enable_slot_power (ctrl, hp_slot);
+		// Wait for exclusive access to hardware
+		down(&ctrl->crit_sect);
 
-			set_SOGO(ctrl);
+		// turn on board without attaching to the bus
+		enable_slot_power (ctrl, hp_slot);
 
-			// Wait for SOBS to be unset
-			wait_for_ctrl_irq (ctrl);
+		set_SOGO(ctrl);
 
-			// Change bits in slot power register to force another shift out
-			// NOTE: this is to work around the timer bug
-			temp_byte = readb(ctrl->hpc_reg + SLOT_POWER);
-			writeb(0x00, ctrl->hpc_reg + SLOT_POWER);
-			writeb(temp_byte, ctrl->hpc_reg + SLOT_POWER);
+		// Wait for SOBS to be unset
+		wait_for_ctrl_irq (ctrl);
 
-			set_SOGO(ctrl);
+		// Change bits in slot power register to force another shift out
+		// NOTE: this is to work around the timer bug
+		temp_byte = readb(ctrl->hpc_reg + SLOT_POWER);
+		writeb(0x00, ctrl->hpc_reg + SLOT_POWER);
+		writeb(temp_byte, ctrl->hpc_reg + SLOT_POWER);
 
-			// Wait for SOBS to be unset
-			wait_for_ctrl_irq (ctrl);
+		set_SOGO(ctrl);
 
-			if (!(readl(ctrl->hpc_reg + NON_INT_INPUT) & (0x01 << hp_slot))) {
+		// Wait for SOBS to be unset
+		wait_for_ctrl_irq (ctrl);
+		
+		adapter_speed = get_adapter_speed(ctrl, hp_slot);
+		if (ctrl->speed != adapter_speed)
+			if (set_controller_speed(ctrl, adapter_speed, hp_slot))
 				rc = WRONG_BUS_FREQUENCY;
-			}
-			// turn off board without attaching to the bus
-			disable_slot_power (ctrl, hp_slot);
 
-			set_SOGO(ctrl);
+		// turn off board without attaching to the bus
+		disable_slot_power (ctrl, hp_slot);
 
-			// Wait for SOBS to be unset
-			wait_for_ctrl_irq (ctrl);
+		set_SOGO(ctrl);
 
-			// Done with exclusive hardware access
-			up(&ctrl->crit_sect);
+		// Wait for SOBS to be unset
+		wait_for_ctrl_irq (ctrl);
 
-			if (rc)
-				return(rc);
-		}
+		// Done with exclusive hardware access
+		up(&ctrl->crit_sect);
+
+		if (rc)
+			return(rc);
 
 		// Wait for exclusive access to hardware
 		down(&ctrl->crit_sect);
@@ -1375,6 +1386,7 @@
 {
 	u8 hp_slot;
 	u8 temp_byte;
+	u8 adapter_speed;
 	int index;
 	u32 temp_register = 0xFFFFFFFF;
 	u32 rc = 0;
@@ -1386,47 +1398,48 @@
 	dbg("%s: func->device, slot_offset, hp_slot = %d, %d ,%d\n",
 	    __FUNCTION__, func->device, ctrl->slot_device_offset, hp_slot);
 
-	if (ctrl->speed == PCI_SPEED_66MHz) {
-		// Wait for exclusive access to hardware
-		down(&ctrl->crit_sect);
-
-		// turn on board without attaching to the bus
-		enable_slot_power (ctrl, hp_slot);
+	// Wait for exclusive access to hardware
+	down(&ctrl->crit_sect);
 
-		set_SOGO(ctrl);
+	// turn on board without attaching to the bus
+	enable_slot_power (ctrl, hp_slot);
 
-		// Wait for SOBS to be unset
-		wait_for_ctrl_irq (ctrl);
+	set_SOGO(ctrl);
 
-		// Change bits in slot power register to force another shift out
-		// NOTE: this is to work around the timer bug
-		temp_byte = readb(ctrl->hpc_reg + SLOT_POWER);
-		writeb(0x00, ctrl->hpc_reg + SLOT_POWER);
-		writeb(temp_byte, ctrl->hpc_reg + SLOT_POWER);
+	// Wait for SOBS to be unset
+	wait_for_ctrl_irq (ctrl);
 
-		set_SOGO(ctrl);
+	// Change bits in slot power register to force another shift out
+	// NOTE: this is to work around the timer bug
+	temp_byte = readb(ctrl->hpc_reg + SLOT_POWER);
+	writeb(0x00, ctrl->hpc_reg + SLOT_POWER);
+	writeb(temp_byte, ctrl->hpc_reg + SLOT_POWER);
 
-		// Wait for SOBS to be unset
-		wait_for_ctrl_irq (ctrl);
+	set_SOGO(ctrl);
 
-		if (!(readl(ctrl->hpc_reg + NON_INT_INPUT) & (0x01 << hp_slot))) {
+	// Wait for SOBS to be unset
+	wait_for_ctrl_irq (ctrl);
+	
+	adapter_speed = get_adapter_speed(ctrl, hp_slot);
+	if (ctrl->speed != adapter_speed)
+		if (set_controller_speed(ctrl, adapter_speed, hp_slot))
 			rc = WRONG_BUS_FREQUENCY;
-		}
-		// turn off board without attaching to the bus
-		disable_slot_power (ctrl, hp_slot);
+	
+	// turn off board without attaching to the bus
+	disable_slot_power (ctrl, hp_slot);
 
-		set_SOGO(ctrl);
+	set_SOGO(ctrl);
 
-		// Wait for SOBS to be unset
-		wait_for_ctrl_irq (ctrl);
+	// Wait for SOBS to be unset
+	wait_for_ctrl_irq (ctrl);
 
-		// Done with exclusive hardware access
-		up(&ctrl->crit_sect);
+	// Done with exclusive hardware access
+	up(&ctrl->crit_sect);
 
-		if (rc)
-			return(rc);
-	}
-	p_slot = find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
+	if (rc)
+		return(rc);
+	
+	p_slot = cpqhp_find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
 
 	// turn on board and blink green LED
 
@@ -1799,7 +1812,7 @@
 				if (!func)
 					return;
 
-				p_slot = find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
+				p_slot = cpqhp_find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
 				if (!p_slot)
 					return;
 
@@ -1859,11 +1872,12 @@
 					}
 					// Wait for exclusive access to hardware
 					down(&ctrl->crit_sect);
-
+					
 					dbg("blink green LED and turn off amber\n");
+					
 					amber_LED_off (ctrl, hp_slot);
 					green_LED_blink (ctrl, hp_slot);
-
+					
 					set_SOGO(ctrl);
 
 					// Wait for SOBS to be unset
@@ -1991,7 +2005,7 @@
 
 	device = func->device;
 	hp_slot = device - ctrl->slot_device_offset;
-	p_slot = find_slot(ctrl, device);
+	p_slot = cpqhp_find_slot(ctrl, device);
 	if (p_slot) {
 		physical_slot = p_slot->number;
 	}
@@ -2090,7 +2104,7 @@
 
 	device = func->device; 
 	func = cpqhp_slot_find(ctrl->bus, device, index++);
-	p_slot = find_slot(ctrl, device);
+	p_slot = cpqhp_find_slot(ctrl, device);
 	if (p_slot) {
 		physical_slot = p_slot->number;
 	}
diff -Nru a/drivers/hotplug/cpqphp_pci.c b/drivers/hotplug/cpqphp_pci.c
--- a/drivers/hotplug/cpqphp_pci.c	Tue May  6 15:56:19 2003
+++ b/drivers/hotplug/cpqphp_pci.c	Tue May  6 15:56:19 2003
@@ -97,6 +97,7 @@
 		//this will generate pci_dev structures for all functions, but we will only call this case when lookup fails
 		func->pci_dev = pci_scan_slot(ctrl->pci_dev->bus,
 				 (func->device << 3) + (func->function & 0x7));
+
 		if (func->pci_dev == NULL) {
 			dbg("ERROR: pci_dev still null\n");
 			return 0;
@@ -1209,11 +1210,11 @@
 	temp = 0;
 
 	if (!cpqhp_nic_irq) {
-		cpqhp_nic_irq = ctrl->interrupt;
+		cpqhp_nic_irq = ctrl->cfgspc_irq;
 	}
 
 	if (!cpqhp_disk_irq) {
-		cpqhp_disk_irq = ctrl->interrupt;
+		cpqhp_disk_irq = ctrl->cfgspc_irq;
 	}
 
 	dbg("cpqhp_disk_irq, cpqhp_nic_irq= %d, %d\n", cpqhp_disk_irq, cpqhp_nic_irq);

