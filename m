Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261379AbTCTLUY>; Thu, 20 Mar 2003 06:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261380AbTCTLUY>; Thu, 20 Mar 2003 06:20:24 -0500
Received: from mailout.zma.compaq.com ([161.114.64.103]:14354 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S261379AbTCTLUN>; Thu, 20 Mar 2003 06:20:13 -0500
Date: Thu, 20 Mar 2003 12:32:58 +0100
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: Greg KH <greg@kroah.com>
Cc: Torben Mathiasen <torben.mathiasen@hp.com>, linux-kernel@vger.kernel.org,
       john.cagle@hp.com, dan.zink@hp.com, stephen.cameron@hp.com
Subject: Re: [PATCH] cpqphp 66/100/133MHz PCI-X support for 2.5.65
Message-ID: <20030320113258.GA1069@tmathiasen>
References: <20030319115704.GE4925@tmathiasen> <20030319213001.GB16463@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <20030319213001.GB16463@kroah.com>
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.21-pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 19 2003, Greg KH wrote:
> I'd be glad to take it now if you have it.
>

Cool. Its attached. Patch against 2.4.21pre5 but also applies to current BK.

Thanks,
Torben

--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.21pre5-pcix-1.diff"

diff -urN -X exclude linux-2.4.21pre5/drivers/hotplug/cpqphp.h linux-2.4.21pre5-pcix/drivers/hotplug/cpqphp.h
--- linux-2.4.21pre5/drivers/hotplug/cpqphp.h	Thu Nov 28 17:53:12 2002
+++ linux-2.4.21pre5-pcix/drivers/hotplug/cpqphp.h	Wed Mar 19 11:23:32 2003
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
@@ -345,6 +351,7 @@
 #define PCI_SUB_HPC_ID2			0xA2F8
 #define PCI_SUB_HPC_ID3			0xA2F9
 #define PCI_SUB_HPC_ID_INTC		0xA2FA
+#define PCI_SUB_HPC_ID4			0xA2FD
 
 #define INT_BUTTON_IGNORE		0
 #define INT_PRESENCE_ON			1
@@ -460,6 +467,7 @@
 extern void	cpqhp_destroy_resource_list	(struct resource_lists * resources);
 extern int	cpqhp_configure_device		(struct controller* ctrl, struct pci_func* func);
 extern int	cpqhp_unconfigure_device	(struct pci_func* func);
+extern struct slot *cpqhp_find_slot 		(struct controller *ctrl, u8 device);
 
 
 /* Global variables */
@@ -473,8 +481,6 @@
 
 
 
-/* inline functions */
-
 
 /* Inline functions to check the sanity of a pointer that is passed to us */
 static inline int slot_paranoia_check (struct slot *slot, const char *function)
@@ -588,6 +594,7 @@
 	u32 led_control;
 	
 	led_control = readl(ctrl->hpc_reg + LED_CONTROL);
+	led_control &= ~(0x0101L << slot);
 	led_control |= (0x0001L << slot);
 	writel(led_control, ctrl->hpc_reg + LED_CONTROL);
 }
@@ -629,14 +636,62 @@
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
+	u8 curr_freq;
 	u16 misc;
 	
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
 	misc = readw(ctrl->hpc_reg + MISC);
 	return (misc & 0x0800) ? PCI_SPEED_66MHz : PCI_SPEED_33MHz;
 }
 
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
+
+	if (temp_dword & (0x01 << hp_slot))
+		return PCI_SPEED_66MHz;
+
+	return PCI_SPEED_33MHz;
+}
 
 static inline void enable_slot_power (struct controller *ctrl, u8 slot)
 {
@@ -744,5 +799,136 @@
 	return retval;
 }
 
-#endif
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
 
+	info("Successfully changed frequency/mode for adapter in slot %d\n", 
+			slot->number);
+	return 0;
+}
+
+#endif
diff -urN -X exclude linux-2.4.21pre5/drivers/hotplug/cpqphp_core.c linux-2.4.21pre5-pcix/drivers/hotplug/cpqphp_core.c
--- linux-2.4.21pre5/drivers/hotplug/cpqphp_core.c	Thu Nov 28 17:53:12 2002
+++ linux-2.4.21pre5-pcix/drivers/hotplug/cpqphp_core.c	Thu Mar 20 05:15:43 2003
@@ -24,6 +24,9 @@
  *
  * Send feedback to <greg@kroah.com>
  *
+ * Jan 12, 2003 -	Added 66/100/133MHz PCI-X support, 
+ * 			Torben Mathiasen <torben.mathiasen@hp.com>
+ *
  */
 
 #include <linux/config.h>
@@ -53,7 +56,7 @@
 static u8 power_mode;
 static int debug;
 
-#define DRIVER_VERSION	"0.9.6"
+#define DRIVER_VERSION	"0.9.7"
 #define DRIVER_AUTHOR	"Dan Zink <dan.zink@compaq.com>, Greg Kroah-Hartman <greg@kroah.com>"
 #define DRIVER_DESC	"Compaq Hot Plug PCI Controller Driver"
 
@@ -829,6 +832,7 @@
 	u8 hp_slot = 0;
 	u8 device;
 	u8 rev;
+	u8 bus_cap;
 	u16 temp_word;
 	u16 vendor_id;
 	u16 subsystem_vid;
@@ -890,6 +894,39 @@
 
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
@@ -933,8 +970,18 @@
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
@@ -1023,7 +1070,7 @@
 	info("Initializing the PCI hot plug controller residing on PCI bus %d\n", pdev->bus->number);
 
 	dbg ("Hotplug controller capabilities:\n");
-	dbg ("    speed_capability       %s\n", ctrl->speed_capability == PCI_SPEED_33MHz ? "33MHz" : "66Mhz");
+	dbg ("    speed_capability       %d\n", ctrl->speed_capability);
 	dbg ("    slot_switch_type       %s\n", ctrl->slot_switch_type == 0 ? "no switch" : "switch present");
 	dbg ("    defeature_PHP          %s\n", ctrl->defeature_PHP == 0 ? "PHP not supported" : "PHP supported");
 	dbg ("    alternate_base_address %s\n", ctrl->alternate_base_address == 0 ? "not supported" : "supported");
@@ -1066,11 +1113,9 @@
 		goto err_free_mem_region;
 	}
 
-	// Check for 66Mhz operation
-	// TODO: Add PCI-X support
+	// Check for 66Mhz and/or PCI-X operation
 	ctrl->speed = get_controller_speed(ctrl);
-
-
+	
 	//**************************************************
 	//
 	//              Save configuration headers for this and
diff -urN -X exclude linux-2.4.21pre5/drivers/hotplug/cpqphp_ctrl.c linux-2.4.21pre5-pcix/drivers/hotplug/cpqphp_ctrl.c
--- linux-2.4.21pre5/drivers/hotplug/cpqphp_ctrl.c	Thu Nov 28 17:53:12 2002
+++ linux-2.4.21pre5-pcix/drivers/hotplug/cpqphp_ctrl.c	Wed Mar 19 09:28:03 2003
@@ -135,9 +135,9 @@
 
 
 /*
- * find_slot
+ * cpqhp_find_slot
  */
-static inline struct slot *find_slot (struct controller * ctrl, u8 device)
+struct slot *cpqhp_find_slot (struct controller * ctrl, u8 device)
 {
 	struct slot *slot;
 
@@ -186,7 +186,7 @@
 
 			rc++;
 
-			p_slot = find_slot(ctrl, hp_slot + (readb(ctrl->hpc_reg + SLOT_MASK) >> 4));
+			p_slot = cpqhp_find_slot(ctrl, hp_slot + (readb(ctrl->hpc_reg + SLOT_MASK) >> 4));
 
 			// If the switch closed, must be a button
 			// If not in button mode, nevermind
@@ -916,6 +916,7 @@
 void cpqhp_ctrl_intr(int IRQ, struct controller * ctrl, struct pt_regs *regs)
 {
 	u8 schedule_flag = 0;
+	u8 reset;
 	u16 misc;
 	u32 Diff;
 	u32 temp_dword;
@@ -966,6 +967,15 @@
 		schedule_flag += handle_presence_change((u16)((Diff & 0xFFFF0000L) >> 16), ctrl);
 		schedule_flag += handle_power_fault((u8)((Diff & 0xFF00L) >> 8), ctrl);
 	}
+	
+	reset = readb(ctrl->hpc_reg + RESET_FREQ_MODE);
+	if (reset & 0x40) {
+		/* Bus Reset has completed */
+		reset &= 0xCF;
+		writeb(reset, ctrl->hpc_reg + RESET_FREQ_MODE);
+		reset = readb(ctrl->hpc_reg + RESET_FREQ_MODE);
+		wake_up_interruptible(&ctrl->queue);
+	}
 
 	if (schedule_flag) {
 		up(&event_semaphore);
@@ -1169,6 +1179,7 @@
 {
 	u8 hp_slot;
 	u8 temp_byte;
+	u8 adapter_speed;
 	u32 index;
 	u32 rc = 0;
 	u32 src = 8;
@@ -1186,46 +1197,47 @@
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
+		// 66MHz and/or PCI-X support check
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
@@ -1373,6 +1385,7 @@
 {
 	u8 hp_slot;
 	u8 temp_byte;
+	u8 adapter_speed;
 	int index;
 	u32 temp_register = 0xFFFFFFFF;
 	u32 rc = 0;
@@ -1383,48 +1396,50 @@
 	hp_slot = func->device - ctrl->slot_device_offset;
 	dbg(__FUNCTION__": func->device, slot_offset, hp_slot = %d, %d ,%d\n",
 	    func->device, ctrl->slot_device_offset, hp_slot);
+	
+	// Wait for exclusive access to hardware
+	down(&ctrl->crit_sect);
 
-	if (ctrl->speed == PCI_SPEED_66MHz) {
-		// Wait for exclusive access to hardware
-		down(&ctrl->crit_sect);
-
-		// turn on board without attaching to the bus
-		enable_slot_power (ctrl, hp_slot);
-
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
+	// 66MHz and/or PCI-X support check
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
 
@@ -1800,7 +1815,7 @@
 
 				func = cpqhp_slot_find(ctrl->bus, (hp_slot + ctrl->slot_device_offset), 0);
 
-				p_slot = find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
+				p_slot = cpqhp_find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
 
 				dbg("hp_slot %d, func %p, p_slot %p\n",
 				    hp_slot, func, p_slot);
@@ -1990,7 +2005,7 @@
 
 	device = func->device;
 	hp_slot = device - ctrl->slot_device_offset;
-	p_slot = find_slot(ctrl, device);
+	p_slot = cpqhp_find_slot(ctrl, device);
 	if (p_slot) {
 		physical_slot = p_slot->number;
 	}
@@ -2087,7 +2102,7 @@
 
 	device = func->device; 
 	func = cpqhp_slot_find(ctrl->bus, device, index++);
-	p_slot = find_slot(ctrl, device);
+	p_slot = cpqhp_find_slot(ctrl, device);
 	if (p_slot) {
 		physical_slot = p_slot->number;
 	}

--ZoaI/ZTpAVc4A5k6--
