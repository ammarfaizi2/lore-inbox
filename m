Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292960AbSB0Vsc>; Wed, 27 Feb 2002 16:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292991AbSB0VsO>; Wed, 27 Feb 2002 16:48:14 -0500
Received: from mailhost.nmt.edu ([129.138.4.52]:10758 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S292980AbSB0Vpj>;
	Wed, 27 Feb 2002 16:45:39 -0500
Date: Wed, 27 Feb 2002 14:45:04 -0700 (MST)
From: "adam@mailhost.nmt.edu" <adam@nmt.edu>
To: alan@lxorguk.ukuu.org.uk
cc: linux-kernel@vger.kernel.org
Subject: 3ware driver update for 2.5.6-pre2 (new DMA mapping)
Message-ID: <Pine.GSO.4.44.0202271442180.15357-100000@rainbow.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Please apply this patch for kernel 2.5.6-pre2 for the 3ware driver to
support the new DMA mapping code, and several other fixes.

Thanks.

--
Adam Radford
Software Engineer
3ware, Inc.

diff -Naur linux-2.5.6-pre1/drivers/scsi/3w-xxxx.c linux-2.5.6-pre2/drivers/scsi/3w-xxxx.c
--- linux-2.5.6-pre1/drivers/scsi/3w-xxxx.c	Tue Feb 19 18:11:00 2002
+++ linux-2.5.6-pre2/drivers/scsi/3w-xxxx.c	Wed Feb 27 11:53:49 2002
@@ -6,7 +6,7 @@
    		     Arnaldo Carvalho de Melo <acme@conectiva.com.br>
                      Brad Strand <linux@3ware.com>

-   Copyright (C) 1999-2001 3ware Inc.
+   Copyright (C) 1999-2002 3ware Inc.

    Kernel compatablity By: 	Andre Hedrick <andre@suse.com>
    Non-Copyright (C) 2000	Andre Hedrick <andre@suse.com>
@@ -106,17 +106,41 @@
                  Add entire aen code string list.
    1.02.00.010 - Cleanup queueing code, fix jbod thoughput.
                  Fix get_param for specific units.
+   1.02.00.011 - Fix bug in tw_aen_complete() where aen's could be lost.
+                 Fix tw_aen_drain_queue() to display useful info at init.
+                 Set tw_host->max_id for 12 port cards.
+                 Add ioctl support for raw command packet post from userspace
+                 with sglist fragments (parameter and io).
+   1.02.00.012 - Fix read capacity to under report by 1 sector to fix get
+                 last sector ioctl.
+   1.02.00.013 - Fix bug where more AEN codes weren't coming out during
+                 driver initialization.
+                 Improved handling of PCI aborts.
+   1.02.00.014 - Fix bug in tw_findcards() where AEN code could be lost.
+                 Increase timeout in tw_aen_drain_queue() to 30 seconds.
+   1.02.00.015 - Re-write raw command post with data ioctl method.
+                 Remove raid5 bounce buffers for raid5 for 6XXX for kernel 2.5
+                 Add tw_map/unmap_scsi_sg/single_data() for kernel 2.5
+                 Replace io_request_lock with host_lock for kernel 2.5
+                 Set max_cmd_len to 16 for 3dm for kernel 2.5
+   1.02.00.016 - Set host->max_sectors back up to 256.
+   1.02.00.017 - Modified pci parity error handling/clearing from config space
+                 during initialization.
+   1.02.00.018 - Better handling of request sense opcode and sense information
+                 for failed commands.  Add tw_decode_sense().
+                 Replace all mdelay()'s with scsi_sleep().
+   1.02.00.019 - Revert mdelay's and scsi_sleep's, this caused problems on
+                 some SMP systems.
+   1.02.00.020 - Add pci_set_dma_mask(), rewrite kmalloc()/virt_to_bus() to
+                 pci_alloc/free_consistent().
 */

-#error Please convert me to Documentation/DMA-mapping.txt
-
 #include <linux/module.h>

 MODULE_AUTHOR ("3ware Inc.");
 MODULE_DESCRIPTION ("3ware Storage Controller Linux Driver");
 MODULE_LICENSE("GPL");

-
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/time.h>
@@ -148,14 +172,17 @@
 static void tw_copy_mem_info(TW_Info *info, char *data, int len);
 static void tw_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
 static int tw_halt(struct notifier_block *nb, ulong event, void *buf);
+static int tw_map_scsi_sg_data(struct pci_dev *pdev, Scsi_Cmnd *cmd);
+static u32 tw_map_scsi_single_data(struct pci_dev *pdev, Scsi_Cmnd *cmd);
+static void tw_unmap_scsi_data(struct pci_dev *pdev, Scsi_Cmnd *cmd);

 /* Notifier block to get a notify on system shutdown/halt/reboot */
 static struct notifier_block tw_notifier = {
-  tw_halt, NULL, 0
+	tw_halt, NULL, 0
 };

 /* Globals */
-char *tw_driver_version="1.02.00.010";
+char *tw_driver_version="1.02.00.020";
 TW_Device_Extension *tw_device_extension_list[TW_MAX_SLOT];
 int tw_device_extension_count = 0;

@@ -166,6 +193,7 @@
 {
 	TW_Param *param;
 	unsigned short aen;
+	int error = 0;

 	dprintk(KERN_WARNING "3w-xxxx: tw_aen_complete()\n");
 	if (tw_dev->alignment_virtual_address[request_id] == NULL) {
@@ -184,12 +212,15 @@
 			if ((tw_aen_string[aen & 0xff][strlen(tw_aen_string[aen & 0xff])-1]) == '#') {
 				printk(KERN_WARNING "3w-xxxx: scsi%d: AEN: %s%d.\n", tw_dev->host->host_no, tw_aen_string[aen & 0xff], aen >> 8);
 			} else {
-				printk(KERN_WARNING "3w-xxxx: scsi%d: AEN: %s.\n", tw_dev->host->host_no, tw_aen_string[aen & 0xff]);
+				if (aen != 0x0)
+					printk(KERN_WARNING "3w-xxxx: scsi%d: AEN: %s.\n", tw_dev->host->host_no, tw_aen_string[aen & 0xff]);
 			}
-		} else
+		} else {
 			printk(KERN_WARNING "3w-xxxx: scsi%d: Received AEN %d.\n", tw_dev->host->host_no, aen);
+		}
 	}
-	tw_dev->aen_count++;
+	if (aen != 0x0)
+		tw_dev->aen_count++;

 	/* Now queue the code */
 	tw_dev->aen_queue[tw_dev->aen_tail] = aen;
@@ -205,8 +236,18 @@
 			tw_dev->aen_head = tw_dev->aen_head + 1;
 		}
 	}
-	tw_dev->state[request_id] = TW_S_COMPLETED;
-	tw_state_request_finish(tw_dev, request_id);
+
+	if (aen != TW_AEN_QUEUE_EMPTY) {
+		error = tw_aen_read_queue(tw_dev, request_id);
+		if (error) {
+			printk(KERN_WARNING "3w-xxxx: scsi%d: Error completing AEN.\n", tw_dev->host->host_no);
+			tw_dev->state[request_id] = TW_S_COMPLETED;
+			tw_state_request_finish(tw_dev, request_id);
+		}
+	} else {
+		tw_dev->state[request_id] = TW_S_COMPLETED;
+		tw_state_request_finish(tw_dev, request_id);
+	}

 	return 0;
 } /* End tw_aen_complete() */
@@ -237,10 +278,11 @@
 	status_reg_addr = tw_dev->registers.status_reg_addr;
 	response_que_addr = tw_dev->registers.response_que_addr;

-	if (tw_poll_status(tw_dev, TW_STATUS_ATTENTION_INTERRUPT, 15)) {
+	if (tw_poll_status(tw_dev, TW_STATUS_ATTENTION_INTERRUPT, 30)) {
 		dprintk(KERN_WARNING "3w-xxxx: tw_aen_drain_queue(): No attention interrupt for card %d.\n", tw_device_extension_count);
 		return 1;
 	}
+	tw_clear_attention_interrupt(tw_dev);

 	/* Initialize command packet */
 	if (tw_dev->command_packet_virtual_address[request_id] == NULL) {
@@ -288,7 +330,7 @@
 	do {
 		/* Post command packet */
 		outl(command_que_value, command_que_addr);
-
+
 		/* Now poll for completion */
 		for (i=0;i<imax;i++) {
 			mdelay(5);
@@ -311,8 +353,7 @@
 				if (command_packet->status != 0) {
 					if (command_packet->flags != TW_AEN_TABLE_UNDEFINED) {
 						/* Bad response */
-						dprintk(KERN_WARNING "3w-xxxx: tw_aen_drain_queue(): Bad response, status = 0x%x, flags = 0x%x.\n", command_packet->status, command_packet->flags);
-						tw_decode_error(tw_dev, command_packet->status, command_packet->flags, command_packet->byte3.unit);
+						tw_decode_sense(tw_dev, request_id, 0);
 						return 1;
 					} else {
 						/* We know this is a 3w-1x00, and doesn't support aen's */
@@ -326,7 +367,7 @@
 				queue = 0;
 				switch (aen_code) {
 					case TW_AEN_QUEUE_EMPTY:
-						dprintk(KERN_NOTICE "3w-xxxx: tw_aen_drain_queue(): Found TW_AEN_QUEUE_EMPTY.\n");
+						dprintk(KERN_WARNING "3w-xxxx: AEN: %s.\n", tw_aen_string[aen & 0xff]);
 						if (first_reset != 1) {
 							continue;
 						} else {
@@ -334,51 +375,28 @@
 						}
 						break;
 					case TW_AEN_SOFT_RESET:
-						dprintk(KERN_NOTICE "3w-xxxx: tw_aen_drain_queue(): Found TW_AEN_SOFT_RESET.\n");
 						if (first_reset == 0) {
 							first_reset = 1;
 						} else {
+							printk(KERN_WARNING "3w-xxxx: AEN: %s.\n", tw_aen_string[aen & 0xff]);
+							tw_dev->aen_count++;
 							queue = 1;
 						}
 						break;
-					case TW_AEN_DEGRADED_MIRROR:
-						dprintk(KERN_NOTICE "3w-xxxx: tw_aen_drain_queue(): Found TW_AEN_DEGRADED_MIRROR.\n");
-						queue = 1;
-						break;
-					case TW_AEN_CONTROLLER_ERROR:
-						dprintk(KERN_NOTICE "3w-xxxx: tw_aen_drain_queue(): Found TW_AEN_CONTROLLER_ERROR.\n");
-						queue = 1;
-						break;
-					case TW_AEN_REBUILD_FAIL:
-						dprintk(KERN_NOTICE "3w-xxxx: tw_aen_drain_queue(): Found TW_AEN_REBUILD_FAIL.\n");
-						queue = 1;
-						break;
-					case TW_AEN_REBUILD_DONE:
-						dprintk(KERN_NOTICE "3w-xxxx: tw_aen_drain_queue(): Found TW_AEN_REBUILD_DONE.\n");
-						queue = 1;
-						break;
-					case TW_AEN_QUEUE_FULL:
-						dprintk(KERN_NOTICE "3w-xxxx: tw_aen_drain_queue(): Found TW_AEN_QUEUE_FULL.\n");
-						queue = 1;
-						break;
-					case TW_AEN_APORT_TIMEOUT:
-						printk(KERN_WARNING "3w-xxxx: Received drive timeout AEN on port %d, check drive and drive cables.\n", aen >> 8);
-						queue = 1;
-						break;
-					case TW_AEN_DRIVE_ERROR:
-						printk(KERN_WARNING "3w-xxxx: Received drive error AEN on port %d, check/replace cabling, or possible bad drive.\n", aen >> 8);
-						queue = 1;
-						break;
-					case TW_AEN_SMART_FAIL:
-						printk(KERN_WARNING "3w-xxxx: Received S.M.A.R.T. threshold AEN on port %d, check drive/cooling, or possible bad drive.\n", aen >> 8);
-						queue = 1;
-						break;
-					case TW_AEN_SBUF_FAIL:
-						printk(KERN_WARNING "3w-xxxx: Received SBUF integrity check failure AEN, reseat card or bad card.\n");
-						queue = 1;
-						break;
 					default:
-						dprintk(KERN_WARNING "3w-xxxx: tw_aen_drain_queue(): Unknown AEN code 0x%x.\n", aen_code);
+						if (aen == 0x0ff) {
+							printk(KERN_WARNING "3w-xxxx: AEN: AEN queue overflow.\n");
+						} else {
+							if ((aen & 0x0ff) < TW_AEN_STRING_MAX) {
+								if ((tw_aen_string[aen & 0xff][strlen(tw_aen_string[aen & 0xff])-1]) == '#') {
+									printk(KERN_WARNING "3w-xxxx: AEN: %s%d.\n", tw_aen_string[aen & 0xff], aen >> 8);
+								} else {
+									printk(KERN_WARNING "3w-xxxx: AEN: %s.\n", tw_aen_string[aen & 0xff]);
+								}
+							} else
+								printk(KERN_WARNING "3w-xxxx: Received AEN %d.\n", aen);
+						}
+						tw_dev->aen_count++;
 						queue = 1;
 				}

@@ -488,40 +506,44 @@
 	return 0;
 } /* End tw_aen_read_queue() */

-/* This function will allocate memory and check if it is 16 d-word aligned */
-int tw_allocate_memory(TW_Device_Extension *tw_dev, int request_id, int size, int which)
+/* This function will allocate memory */
+int tw_allocate_memory(TW_Device_Extension *tw_dev, int size, int which)
 {
-	u32 *virt_addr = kmalloc(size, GFP_ATOMIC);
+	int i;
+	dma_addr_t dma_handle;
+	u32 *cpu_addr = NULL;

 	dprintk(KERN_NOTICE "3w-xxxx: tw_allocate_memory()\n");

-	if (!virt_addr) {
-		printk(KERN_WARNING "3w-xxxx: tw_allocate_memory(): kmalloc() failed.\n");
-		return 1;
-	}
+	for (i=0;i<TW_Q_LENGTH;i++) {
+		cpu_addr = pci_alloc_consistent(tw_dev->tw_pci_dev, size, &dma_handle);
+		if (cpu_addr == NULL) {
+			printk(KERN_WARNING "3w-xxxx: pci_alloc_consistent() failed.\n");
+			return 1;
+		}

-	if ((u32)virt_addr % TW_ALIGNMENT) {
-		kfree(virt_addr);
-		printk(KERN_WARNING "3w-xxxx: tw_allocate_memory(): Found unaligned address.\n");
-		return 1;
-	}
+		if ((u32)cpu_addr % (tw_dev->tw_pci_dev->device == TW_DEVICE_ID ? TW_ALIGNMENT_6000 : TW_ALIGNMENT_7000)) {
+			printk(KERN_WARNING "3w-xxxx: Couldn't allocate correctly aligned memory.\n");
+			return 1;
+		}

-	switch(which) {
-	case 0:
-		tw_dev->command_packet_virtual_address[request_id] = virt_addr;
-		tw_dev->command_packet_physical_address[request_id] = virt_to_bus(virt_addr);
-		break;
-	case 1:
-		tw_dev->alignment_virtual_address[request_id] = virt_addr;
-		tw_dev->alignment_physical_address[request_id] = virt_to_bus(virt_addr);
-		break;
-	case 2:
-		tw_dev->bounce_buffer[request_id] = virt_addr;
-		break;
-	default:
-		printk(KERN_WARNING "3w-xxxx: tw_allocate_memory(): case slip in tw_allocate_memory()\n");
-		return 1;
+		switch(which) {
+		case 0:
+			tw_dev->command_packet_virtual_address[i] = cpu_addr;
+			tw_dev->command_packet_physical_address[i] = dma_handle;
+			memset(tw_dev->command_packet_virtual_address[i], 0, size);
+			break;
+		case 1:
+			tw_dev->alignment_virtual_address[i] = cpu_addr;
+			tw_dev->alignment_physical_address[i] = dma_handle;
+			memset(tw_dev->alignment_virtual_address[i], 0, size);
+			break;
+		default:
+			printk(KERN_WARNING "3w-xxxx: tw_allocate_memory(): case slip in tw_allocate_memory()\n");
+			return 1;
+		}
 	}
+
 	return 0;
 } /* End tw_allocate_memory() */

@@ -548,8 +570,10 @@
 	status_reg_addr = tw_dev->registers.status_reg_addr;
 	status_reg_value = inl(status_reg_addr);

-	if (TW_STATUS_ERRORS(status_reg_value) || tw_check_bits(status_reg_value))
+	if (TW_STATUS_ERRORS(status_reg_value) || tw_check_bits(status_reg_value)) {
+		tw_decode_bits(tw_dev, status_reg_value);
 		return 1;
+	}

 	return 0;
 } /* End tw_check_errors() */
@@ -614,37 +638,62 @@
 	dprintk(KERN_WARNING "3w-xxxx: tw_decode_bits()\n");
 	switch (status_reg_value & TW_STATUS_UNEXPECTED_BITS) {
 	case TW_STATUS_PCI_PARITY_ERROR:
-		printk(KERN_WARNING "3w-xxxx: PCI Parity Error: Reseat card, move card, or buggy device on the bus.\n");
+		printk(KERN_WARNING "3w-xxxx: PCI Parity Error: clearing.\n");
 		outl(TW_CONTROL_CLEAR_PARITY_ERROR, tw_dev->registers.control_reg_addr);
-		pci_write_config_word(tw_dev->tw_pci_dev, PCI_STATUS, TW_PCI_CLEAR_PARITY_ERRORS);
 		break;
 	case TW_STATUS_MICROCONTROLLER_ERROR:
 		printk(KERN_WARNING "3w-xxxx: Microcontroller Error.\n");
 		break;
+	case TW_STATUS_PCI_ABORT:
+		printk(KERN_WARNING "3w-xxxx: PCI Abort: clearing.\n");
+		outl(TW_CONTROL_CLEAR_PCI_ABORT, tw_dev->registers.control_reg_addr);
+		pci_write_config_word(tw_dev->tw_pci_dev, PCI_STATUS, TW_PCI_CLEAR_PCI_ABORT);
+		break;
   }
 } /* End tw_decode_bits() */

-/* This function will print readable messages from flags and status values */
-void tw_decode_error(TW_Device_Extension *tw_dev, unsigned char status, unsigned char flags, unsigned char unit)
+/* This function will return valid sense buffer information for failed cmds */
+void tw_decode_sense(TW_Device_Extension *tw_dev, int request_id, int fill_sense)
 {
-	dprintk(KERN_WARNING "3w-xxxx: tw_decode_error()\n");
-	switch (status) {
-	case 0xc7:
-		switch (flags) {
-		case 0x1b:
-			printk(KERN_WARNING "3w-xxxx: scsi%d: Drive timeout on unit %d, check drive and drive cables.\n", tw_dev->host->host_no, unit);
-			break;
-		case 0x51:
-			printk(KERN_WARNING "3w-xxxx: scsi%d: Unrecoverable drive error on unit %d, check/replace cabling, or possible bad drive.\n", tw_dev->host->host_no, unit);
-			break;
-		default:
-			printk(KERN_WARNING "3w-xxxx: scsi%d: Controller error: status = 0x%x, flags = 0x%x, unit #%d.\n", tw_dev->host->host_no, status, flags, unit);
+	int i, found=0;
+	TW_Command *command;
+
+        dprintk(KERN_WARNING "3w-xxxx: tw_decode_sense()\n");
+	command = (TW_Command *)tw_dev->command_packet_virtual_address[request_id];
+
+	printk(KERN_WARNING "3w-xxxx: scsi%d: Command failed: status = 0x%x, flags = 0x%x, unit #%d.\n", tw_dev->host->host_no, command->status, command->flags, command->byte3.unit);
+
+	/* Attempt to return intelligent sense information */
+	if (fill_sense) {
+		if ((command->status == 0xc7) || (command->status == 0xcb)) {
+			for (i=0;i<(sizeof(tw_sense_table)/sizeof(tw_sense_table[0]));i++) {
+				if (command->flags == tw_sense_table[i][0]) {
+					found=1;
+
+					/* Valid bit and 'current errors' */
+					tw_dev->srb[request_id]->sense_buffer[0] = (0x1 << 7 | 0x70);
+
+					/* Sense key */
+					tw_dev->srb[request_id]->sense_buffer[2] = tw_sense_table[i][1];
+
+					/* Additional sense length */
+					tw_dev->srb[request_id]->sense_buffer[7] = 0xa; /* 10 bytes */
+
+					/* Additional sense code */
+					tw_dev->srb[request_id]->sense_buffer[12] = tw_sense_table[i][2];
+
+					/* Additional sense code qualifier */
+					tw_dev->srb[request_id]->sense_buffer[13] = tw_sense_table[i][3];
+
+					tw_dev->srb[request_id]->result = (DID_OK << 16) | (CHECK_CONDITION << 1);
+				}
+			}
 		}
-		break;
-	default:
-		printk(KERN_WARNING "3w-xxxx: scsi%d: Controller error: status = 0x%x, flags = 0x%x, unit #%d.\n", tw_dev->host->host_no, status, flags, unit);
+		/* If no table match, error so we get a reset */
+		if (found == 0)
+			tw_dev->srb[request_id]->result = (DID_RESET << 16);
 	}
-} /* End tw_decode_error() */
+} /* End tw_decode_sense() */

 /* This function will disable interrupts on the controller */
 void tw_disable_interrupts(TW_Device_Extension *tw_dev)
@@ -691,11 +740,22 @@
 	u32 control_reg_value, control_reg_addr;

 	control_reg_addr = tw_dev->registers.control_reg_addr;
+	control_reg_value = (TW_CONTROL_ENABLE_INTERRUPTS |
+			     TW_CONTROL_UNMASK_RESPONSE_INTERRUPT);
+	outl(control_reg_value, control_reg_addr);
+} /* End tw_enable_interrupts() */
+
+/* This function will enable interrupts on the controller */
+void tw_enable_and_clear_interrupts(TW_Device_Extension *tw_dev)
+{
+	u32 control_reg_value, control_reg_addr;
+
+	control_reg_addr = tw_dev->registers.control_reg_addr;
 	control_reg_value = (TW_CONTROL_CLEAR_ATTENTION_INTERRUPT |
 			     TW_CONTROL_UNMASK_RESPONSE_INTERRUPT |
 			     TW_CONTROL_ENABLE_INTERRUPTS);
 	outl(control_reg_value, control_reg_addr);
-} /* End tw_enable_interrupts() */
+} /* End tw_enable_and_clear_interrupts() */

 /* This function will find and initialize all cards */
 int tw_findcards(Scsi_Host_Template *tw_host)
@@ -716,6 +776,13 @@
 		while ((tw_pci_dev = pci_find_device(TW_VENDOR_ID, device[i], tw_pci_dev))) {
 			if (pci_enable_device(tw_pci_dev))
 				continue;
+
+			/* We only need 32-bit addressing for 5,6,7xxx cards */
+			if (pci_set_dma_mask(tw_pci_dev, 0xffffffff)) {
+				printk(KERN_WARNING "3w-xxxx: No suitable DMA available.\n");
+				continue;
+			}
+
 			/* Prepare temporary device extension */
 			tw_dev=(TW_Device_Extension *)kmalloc(sizeof(TW_Device_Extension), GFP_ATOMIC);
 			if (tw_dev == NULL) {
@@ -724,6 +791,9 @@
 			}
 			memset(tw_dev, 0, sizeof(TW_Device_Extension));

+			/* Save pci_dev struct to device extension */
+			tw_dev->tw_pci_dev = tw_pci_dev;
+
 			error = tw_initialize_device_extension(tw_dev);
 			if (error) {
 				printk(KERN_WARNING "3w-xxxx: tw_findcards(): Couldn't initialize device extension for card %d.\n", numcards);
@@ -738,8 +808,6 @@
 			tw_dev->registers.status_reg_addr = pci_resource_start(tw_pci_dev, 0) + 0x4;
 			tw_dev->registers.command_que_addr = pci_resource_start(tw_pci_dev, 0) + 0x8;
 			tw_dev->registers.response_que_addr = pci_resource_start(tw_pci_dev, 0) + 0xC;
-			/* Save pci_dev struct to device extension */
-			tw_dev->tw_pci_dev = tw_pci_dev;

 			/* Check for errors and clear them */
 			status_reg_value = inl(tw_dev->registers.status_reg_addr);
@@ -763,14 +831,14 @@

 				error = tw_aen_drain_queue(tw_dev);
 				if (error) {
-					printk(KERN_WARNING "3w-xxxx: tw_findcards(): No attention interrupt for card %d.\n", numcards);
+					printk(KERN_WARNING "3w-xxxx: AEN drain failed for card %d.\n", numcards);
 					tries++;
 					continue;
 				}

 				/* Check for controller errors */
 				if (tw_check_errors(tw_dev)) {
-					printk(KERN_WARNING "3w-xxxx: tw_findcards(): Controller errors found, soft resetting card %d.\n", numcards);
+					printk(KERN_WARNING "3w-xxxx: Controller errors found, retrying for card %d.\n", numcards);
 					tries++;
 					continue;
 				}
@@ -778,7 +846,7 @@
 				/* Empty the response queue */
 				error = tw_empty_response_que(tw_dev);
 				if (error) {
-					printk(KERN_WARNING "3w-xxxx: tw_findcards(): Couldn't empty response queue for card %d.\n", numcards);
+					printk(KERN_WARNING "3w-xxxx: Couldn't empty response queue, retrying for card %d.\n", numcards);
 					tries++;
 					continue;
 				}
@@ -788,7 +856,7 @@
 			}

 			if (tries >= TW_MAX_RESET_TRIES) {
-				printk(KERN_WARNING "3w-xxxx: tw_findcards(): Controller error or no attention interrupt: giving up for card %d.\n", numcards);
+				printk(KERN_WARNING "3w-xxxx: Controller errors, card not responding, check all cabling for card %d.\n", numcards);
 				tw_free_device_extension(tw_dev);
 				kfree(tw_dev);
 				continue;
@@ -818,7 +886,7 @@

 			error = tw_initconnection(tw_dev, TW_INIT_MESSAGE_CREDITS);
 			if (error) {
-				printk(KERN_WARNING "3w-xxxx: tw_findcards(): Couldn't initconnection for card %d.\n", numcards);
+				printk(KERN_WARNING "3w-xxxx: Connection initialization failed for card %d.\n", numcards);
 				release_region((tw_dev->tw_pci_dev->resource[0].start), TW_IO_ADDRESS_RANGE);
 				tw_free_device_extension(tw_dev);
 				kfree(tw_dev);
@@ -827,29 +895,28 @@

 			/* Calculate max cmds per lun, and setup queues */
 			if (tw_dev->num_units > 0) {
-				if ((tw_dev->num_raid_five > 0) && (tw_dev->tw_pci_dev->device == TW_DEVICE_ID)) {
-					tw_host->cmd_per_lun = (TW_MAX_BOUNCEBUF-1)/tw_dev->num_units;
-					tw_dev->free_head = TW_Q_START;
-					tw_dev->free_tail = TW_MAX_BOUNCEBUF - 1;
-					tw_dev->free_wrap = TW_MAX_BOUNCEBUF - 1;
-				} else {
-					tw_host->cmd_per_lun = (TW_Q_LENGTH-1)/tw_dev->num_units;
-					tw_dev->free_head = TW_Q_START;
-					tw_dev->free_tail = TW_Q_LENGTH - 1;
-					tw_dev->free_wrap = TW_Q_LENGTH - 1;
-				}
+				tw_host->cmd_per_lun = (TW_Q_LENGTH-1)/tw_dev->num_units;
+				tw_dev->free_head = TW_Q_START;
+				tw_dev->free_tail = TW_Q_LENGTH - 1;
+				tw_dev->free_wrap = TW_Q_LENGTH - 1;
 			}

-		/* Register the card with the kernel SCSI layer */
+			/* Register the card with the kernel SCSI layer */
 			host = scsi_register(tw_host, sizeof(TW_Device_Extension));
 			if (host == NULL) {
-				printk(KERN_WARNING "3w-xxxx: tw_findcards(): scsi_register() failed for card %d.\n", numcards-1);
+				printk(KERN_WARNING "3w-xxxx: tw_findcards(): scsi_register() failed for card %d.\n", numcards);
 				release_region((tw_dev->tw_pci_dev->resource[0].start), TW_IO_ADDRESS_RANGE);
 				tw_free_device_extension(tw_dev);
 				kfree(tw_dev);
 				continue;
 			}

+			/* Set max target id's */
+			host->max_id = TW_MAX_UNITS;
+
+			/* Set max cdb size in bytes */
+			host->max_cmd_len = 16;
+
 			/* Set max sectors per io */
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,7)
 			host->max_sectors = TW_MAX_SECTORS;
@@ -874,7 +941,7 @@
 				tw_device_extension_count = numcards;
 				tw_dev2->host = host;
 			} else {
-				printk(KERN_WARNING "3w-xxxx: tw_findcards(): Bad scsi host data for card %d.\n", numcards-1);
+				printk(KERN_WARNING "3w-xxxx: tw_findcards(): Bad scsi host data for card %d.\n", numcards);
 				scsi_unregister(host);
 				release_region((tw_dev->tw_pci_dev->resource[0].start), TW_IO_ADDRESS_RANGE);
 				tw_free_device_extension(tw_dev);
@@ -924,15 +991,10 @@
 	/* Free command packet and generic buffer memory */
 	for (i=0;i<TW_Q_LENGTH;i++) {
 		if (tw_dev->command_packet_virtual_address[i])
-			kfree(tw_dev->command_packet_virtual_address[i]);
+			pci_free_consistent(tw_dev->tw_pci_dev, sizeof(TW_Sector), tw_dev->command_packet_virtual_address[i], tw_dev->command_packet_physical_address[i]);

 		if (tw_dev->alignment_virtual_address[i])
-			kfree(tw_dev->alignment_virtual_address[i]);
-
-	}
-	for (i=0;i<TW_MAX_BOUNCEBUF;i++) {
-		if (tw_dev->bounce_buffer[i])
-			kfree(tw_dev->bounce_buffer[i]);
+			pci_free_consistent(tw_dev->tw_pci_dev, sizeof(TW_Sector), tw_dev->alignment_virtual_address[i], tw_dev->alignment_physical_address[i]);
 	}
 } /* End tw_free_device_extension() */

@@ -1015,8 +1077,7 @@
 			}
 			if (command_packet->status != 0) {
 				/* bad response */
-				dprintk(KERN_WARNING "3w-xxxx: tw_initconnection(): Bad response, status = 0x%x, flags = 0x%x.\n", command_packet->status, command_packet->flags);
-				tw_decode_error(tw_dev, command_packet->status, command_packet->flags, command_packet->byte3.unit);
+				tw_decode_sense(tw_dev, request_id, 0);
 				return 1;
 			}
 			break;	/* Response was okay, so we exit */
@@ -1028,57 +1089,33 @@
 /* This function will initialize the fields of a device extension */
 int tw_initialize_device_extension(TW_Device_Extension *tw_dev)
 {
-	int i, imax;
+	int i, error=0;

 	dprintk(KERN_NOTICE "3w-xxxx: tw_initialize_device_extension()\n");
-	imax = TW_Q_LENGTH;

-	for (i=0; i<imax; i++) {
-		/* Initialize command packet buffers */
-		tw_allocate_memory(tw_dev, i, sizeof(TW_Sector), 0);
-		if (tw_dev->command_packet_virtual_address[i] == NULL) {
-			printk(KERN_WARNING "3w-xxxx: tw_initialize_device_extension(): Bad command packet virtual address.\n");
-			return 1;
-		}
-		memset(tw_dev->command_packet_virtual_address[i], 0, sizeof(TW_Sector));
-
-		/* Initialize generic buffer */
-		tw_allocate_memory(tw_dev, i, sizeof(TW_Sector), 1);
-		if (tw_dev->alignment_virtual_address[i] == NULL) {
-			printk(KERN_WARNING "3w-xxxx: tw_initialize_device_extension(): Bad alignment virtual address.\n");
-			return 1;
-		}
-		memset(tw_dev->alignment_virtual_address[i], 0, sizeof(TW_Sector));
+	/* Initialize command packet buffers */
+	error = tw_allocate_memory(tw_dev, sizeof(TW_Command), 0);
+	if (error) {
+		printk(KERN_WARNING "3w-xxxx: Command packet memory allocation failed.\n");
+		return 1;
+	}

-		tw_dev->free_queue[i] = i;
-		tw_dev->state[i] = TW_S_INITIAL;
-		tw_dev->ioctl_size[i] = 0;
-		tw_dev->aen_queue[i] = 0;
+	/* Initialize generic buffer */
+	error = tw_allocate_memory(tw_dev, sizeof(TW_Sector), 1);
+	if (error) {
+		printk(KERN_WARNING "3w-xxxx: Generic memory allocation failed.\n");
+		return 1;
 	}

-	for (i=0;i<TW_MAX_UNITS;i++) {
-		tw_dev->is_unit_present[i] = 0;
-		tw_dev->is_raid_five[i] = 0;
+	for (i=0;i<TW_Q_LENGTH;i++) {
+		tw_dev->free_queue[i] = i;
+		tw_dev->state[i] = TW_S_INITIAL;
 	}

-	tw_dev->num_units = 0;
-	tw_dev->num_aborts = 0;
-	tw_dev->num_resets = 0;
-	tw_dev->posted_request_count = 0;
-	tw_dev->max_posted_request_count = 0;
-	tw_dev->max_sgl_entries = 0;
-	tw_dev->sgl_entries = 0;
-	tw_dev->host = NULL;
 	tw_dev->pending_head = TW_Q_START;
 	tw_dev->pending_tail = TW_Q_START;
-	tw_dev->aen_head = 0;
-	tw_dev->aen_tail = 0;
-	tw_dev->sector_count = 0;
-	tw_dev->max_sector_count = 0;
-	tw_dev->aen_count = 0;
-	tw_dev->num_raid_five = 0;
 	spin_lock_init(&tw_dev->tw_lock);
-	tw_dev->flags = 0;
+
 	return 0;
 } /* End tw_initialize_device_extension() */

@@ -1089,14 +1126,13 @@
 	unsigned char request_id = 0;
 	TW_Command *command_packet;
 	TW_Param *param;
-	int i, j, imax, num_units = 0, num_raid_five = 0;
+	int i, imax, num_units = 0;
 	u32 status_reg_addr, status_reg_value;
 	u32 command_que_addr, command_que_value;
 	u32 response_que_addr;
 	TW_Response_Queue response_queue;
 	u32 param_value;
 	unsigned char *is_unit_present;
-	unsigned char *raid_level;

 	dprintk(KERN_NOTICE "3w-xxxx: tw_initialize_units()\n");

@@ -1168,8 +1204,7 @@
 			}
 			if (command_packet->status != 0) {
 				/* bad response */
-				dprintk(KERN_WARNING "3w-xxxx: tw_initialize_units(): Bad response, status = 0x%x, flags = 0x%x.\n", command_packet->status, command_packet->flags);
-				tw_decode_error(tw_dev, command_packet->status, command_packet->flags, command_packet->byte3.unit);
+				tw_decode_sense(tw_dev, request_id, 0);
 				return 1;
 			}
 			found = 1;
@@ -1205,109 +1240,6 @@
 		return 1;
 	}

-	/* Find raid 5 arrays */
-	for (j=0;j<TW_MAX_UNITS;j++) {
-		if (tw_dev->is_unit_present[j] == 0)
-			continue;
-		command_packet = (TW_Command *)tw_dev->command_packet_virtual_address[request_id];
-		if (command_packet == NULL) {
-			printk(KERN_WARNING "3w-xxxx: tw_initialize_units(): Bad command packet virtual address.\n");
-			return 1;
-		}
-		memset(command_packet, 0, sizeof(TW_Sector));
-		command_packet->byte0.opcode      = TW_OP_GET_PARAM;
-		command_packet->byte0.sgl_offset  = 2;
-		command_packet->size              = 4;
-		command_packet->request_id        = request_id;
-		command_packet->byte3.unit        = 0;
-		command_packet->byte3.host_id     = 0;
-		command_packet->status            = 0;
-		command_packet->flags             = 0;
-		command_packet->byte6.block_count = 1;
-
-		/* Now setup the param */
-		if (tw_dev->alignment_virtual_address[request_id] == NULL) {
-			printk(KERN_WARNING "3w-xxxx: tw_initialize_units(): Bad alignment virtual address.\n");
-			return 1;
-		}
-		param = (TW_Param *)tw_dev->alignment_virtual_address[request_id];
-		memset(param, 0, sizeof(TW_Sector));
-		param->table_id = 0x300+j; /* unit summary table */
-		param->parameter_id = 0x6; /* unit descriptor */
-		param->parameter_size_bytes = 0xc;
-		param_value = tw_dev->alignment_physical_address[request_id];
-		if (param_value == 0) {
-			printk(KERN_WARNING "3w-xxxx: tw_initialize_units(): Bad alignment physical address.\n");
-			return 1;
-		}
-
-		command_packet->byte8.param.sgl[0].address = param_value;
-		command_packet->byte8.param.sgl[0].length = sizeof(TW_Sector);
-
-		/* Post the command packet to the board */
-		command_que_value = tw_dev->command_packet_physical_address[request_id];
-		if (command_que_value == 0) {
-			printk(KERN_WARNING "3w-xxxx: tw_initialize_units(): Bad command packet physical address.\n");
-			return 1;
-		}
-		outl(command_que_value, command_que_addr);
-
-		/* Poll for completion */
-		imax = TW_POLL_MAX_RETRIES;
-		for(i=0; i<imax; i++) {
-			mdelay(5);
-			status_reg_value = inl(status_reg_addr);
-			if (tw_check_bits(status_reg_value)) {
-				dprintk(KERN_WARNING "3w-xxxx: tw_initialize_units(): Unexpected bits.\n");
-				tw_decode_bits(tw_dev, status_reg_value);
-				return 1;
-			}
-			if ((status_reg_value & TW_STATUS_RESPONSE_QUEUE_EMPTY) == 0) {
-				response_queue.value = inl(response_que_addr);
-				request_id = (unsigned char)response_queue.u.response_id;
-				if (request_id != 0) {
-					/* unexpected request id */
-					printk(KERN_WARNING "3w-xxxx: tw_initialize_units(): Unexpected request id.\n");
-					return 1;
-				}
-				if (command_packet->status != 0) {
-					/* bad response */
-					dprintk(KERN_WARNING "3w-xxxx: tw_initialize_units(): Bad response, status = 0x%x, flags = 0x%x.\n", command_packet->status, command_packet->flags);
-					tw_decode_error(tw_dev, command_packet->status, command_packet->flags, command_packet->byte3.unit);
-					return 1;
-				}
-				found = 1;
-				break;
-			}
-		}
-		if (found == 0) {
-			/* response never received */
-			printk(KERN_WARNING "3w-xxxx: tw_initialize_units(): No response.\n");
-			return 1;
-		}
-
-		param = (TW_Param *)tw_dev->alignment_virtual_address[request_id];
-		raid_level = (unsigned char *)&(param->data[1]);
-		if (*raid_level == 5) {
-			dprintk(KERN_WARNING "3w-xxxx: Found unit %d to be a raid5 unit.\n", j);
-			tw_dev->is_raid_five[j] = 1;
-			num_raid_five++;
-		}
-	}
-	tw_dev->num_raid_five = num_raid_five;
-
-	/* Now allocate raid5 bounce buffers */
-	if ((num_raid_five != 0) && (tw_dev->tw_pci_dev->device == TW_DEVICE_ID)) {
-		for (i=0;i<TW_MAX_BOUNCEBUF;i++) {
-			tw_allocate_memory(tw_dev, i, sizeof(TW_Sector)*TW_MAX_SECTORS, 2);
-			if (tw_dev->bounce_buffer[i] == NULL) {
-				printk(KERN_WARNING "3w-xxxx: Bounce buffer allocation failed.\n");
-				return 1;
-			}
-			memset(tw_dev->bounce_buffer[i], 0, sizeof(TW_Sector)*TW_MAX_SECTORS);
-		}
-	}
-
 	return 0;
 } /* End tw_initialize_units() */

@@ -1332,13 +1264,18 @@

 	if (tw_dev->tw_pci_dev->irq == irq) {
 		spin_lock(&tw_dev->tw_lock);
-		dprintk(KERN_NOTICE "3w-xxxx: tw_interrupt()\n");
+		dprintk(KERN_WARNING "3w-xxxx: tw_interrupt()\n");

 		/* Read the registers */
 		status_reg_addr = tw_dev->registers.status_reg_addr;
 		response_que_addr = tw_dev->registers.response_que_addr;
 		status_reg_value = inl(status_reg_addr);

+		if (tw_check_bits(status_reg_value)) {
+			dprintk(KERN_WARNING "3w-xxxx: tw_interrupt(): Unexpected bits.\n");
+			tw_decode_bits(tw_dev, status_reg_value);
+		}
+
 		/* Check which interrupt */
 		if (status_reg_value & TW_STATUS_HOST_INTERRUPT)
 			do_host_interrupt=1;
@@ -1403,17 +1340,18 @@
 				command_packet = (TW_Command *)tw_dev->command_packet_virtual_address[request_id];
 				error = 0;
 				if (command_packet->status != 0) {
-					dprintk(KERN_WARNING "3w-xxxx: tw_interrupt(): Bad response, status = 0x%x, flags = 0x%x, unit = 0x%x.\n", command_packet->status, command_packet->flags, command_packet->byte3.unit);
-					tw_decode_error(tw_dev, command_packet->status, command_packet->flags, command_packet->byte3.unit);
-					error = 1;
+					/* Bad response */
+					if (tw_dev->srb[request_id] != 0)
+						tw_decode_sense(tw_dev, request_id, 1);
+					error = 3;
 				}
 				if (tw_dev->state[request_id] != TW_S_POSTED) {
 					printk(KERN_WARNING "3w-xxxx: scsi%d: Received a request id (%d) (opcode = 0x%x) that wasn't posted.\n", tw_dev->host->host_no, request_id, command_packet->byte0.opcode);
 					error = 1;
 				}
 				if (TW_STATUS_ERRORS(status_reg_value)) {
-				  tw_decode_bits(tw_dev, status_reg_value);
-				  error = 1;
+					tw_decode_bits(tw_dev, status_reg_value);
+					error = 1;
 				}
 				dprintk(KERN_NOTICE "3w-xxxx: tw_interrupt(): Response queue request id: %d.\n", request_id);
 				/* Check for internal command */
@@ -1428,7 +1366,7 @@
 						dprintk(KERN_WARNING "3w-xxxx: tw_interrupt(): Unexpected bits.\n");
 						tw_decode_bits(tw_dev, status_reg_value);
 					}
-		} else {
+				} else {
 				switch (tw_dev->srb[request_id]->cmnd[0]) {
 					case READ_10:
 					case READ_6:
@@ -1455,18 +1393,23 @@
 						tw_dev->srb[request_id]->result = (DID_BAD_TARGET << 16);
 						tw_dev->srb[request_id]->scsi_done(tw_dev->srb[request_id]);
 					}
-					if (error) {
+					if (error == 1) {
 						/* Tell scsi layer there was an error */
 						dprintk(KERN_WARNING "3w-xxxx: tw_interrupt(): Scsi Error.\n");
 						tw_dev->srb[request_id]->result = (DID_RESET << 16);
-					} else {
+					}
+					if (error == 0) {
 						/* Tell scsi layer command was a success */
 						tw_dev->srb[request_id]->result = (DID_OK << 16);
 					}
-					tw_dev->state[request_id] = TW_S_COMPLETED;
-					tw_state_request_finish(tw_dev, request_id);
-					tw_dev->posted_request_count--;
-					tw_dev->srb[request_id]->scsi_done(tw_dev->srb[request_id]);
+					if (error != 2) {
+						tw_dev->state[request_id] = TW_S_COMPLETED;
+						tw_state_request_finish(tw_dev, request_id);
+						tw_dev->posted_request_count--;
+						tw_dev->srb[request_id]->scsi_done(tw_dev->srb[request_id]);
+
+						tw_unmap_scsi_data(tw_dev->tw_pci_dev, tw_dev->srb[request_id]);
+					}
 					status_reg_value = inl(status_reg_addr);
 					if (tw_check_bits(status_reg_value)) {
 						dprintk(KERN_WARNING "3w-xxxx: tw_interrupt(): Unexpected bits.\n");
@@ -1479,19 +1422,22 @@
 	}
 	spin_unlock_irqrestore(tw_dev->host->host_lock, flags);
 	clear_bit(TW_IN_INTR, &tw_dev->flags);
-}	/* End tw_interrupt() */
+} /* End tw_interrupt() */

 /* This function handles ioctls from userspace to the driver */
 int tw_ioctl(TW_Device_Extension *tw_dev, int request_id)
 {
 	unsigned char opcode;
-	int bufflen;
+	int bufflen, error = 0;
 	TW_Param *param;
-	TW_Command *command_packet;
+	TW_Command *command_packet, *command_save;
 	u32 param_value;
 	TW_Ioctl *ioctl = NULL;
 	TW_Passthru *passthru = NULL;
-	int tw_aen_code;
+	int tw_aen_code, i, use_sg;
+	char *data_ptr;
+	int total_bytes = 0;
+	dma_addr_t dma_handle;

 	ioctl = (TW_Ioctl *)tw_dev->srb[request_id]->request_buffer;
 	if (ioctl == NULL) {
@@ -1598,7 +1544,7 @@
 				printk(KERN_WARNING "3w-xxxx: tw_ioctl(): Passthru size (%ld) too big.\n", passthru->sg_list[0].length);
 				return 1;
 			}
-			passthru->sg_list[0].address = virt_to_bus(tw_dev->alignment_virtual_address[request_id]);
+			passthru->sg_list[0].address = tw_dev->alignment_physical_address[request_id];
 			tw_post_command_packet(tw_dev, request_id);
 			return 0;
 		case TW_CMD_PACKET:
@@ -1612,6 +1558,161 @@
 				printk(KERN_WARNING "3w-xxxx: tw_ioctl(): ioctl->data NULL.\n");
 				return 1;
 			}
+		case TW_CMD_PACKET_WITH_DATA:
+			dprintk(KERN_WARNING "3w-xxxx: tw_ioctl(): caught TW_CMD_PACKET_WITH_DATA.\n");
+			command_save = (TW_Command *)tw_dev->alignment_virtual_address[request_id];
+			if (command_save == NULL) {
+				printk(KERN_WARNING "3w-xxxx: scsi%d: tw_ioctl(): Bad alignment virtual address.\n", tw_dev->host->host_no);
+				return 1;
+			}
+			if (ioctl->data != NULL) {
+				/* Copy down the command packet */
+				memcpy(command_packet, ioctl->data, sizeof(TW_Command));
+				memcpy(command_save, ioctl->data, sizeof(TW_Command));
+				command_packet->request_id = request_id;
+
+				/* Now deal with the two possible sglists */
+				if (command_packet->byte0.sgl_offset == 2) {
+					use_sg = command_packet->size - 3;
+					for (i=0;i<use_sg;i++)
+						total_bytes+=command_packet->byte8.param.sgl[i].length;
+					tw_dev->ioctl_data[request_id] = pci_alloc_consistent(tw_dev->tw_pci_dev, total_bytes, &dma_handle);
+
+					if (!tw_dev->ioctl_data[request_id]) {
+						printk(KERN_WARNING "3w-xxxx: scsi%d: tw_ioctl(): kmalloc failed for request_id %d.\n", tw_dev->host->host_no, request_id);
+						return 1;
+					}
+
+					/* Copy param sglist into the kernel */
+					data_ptr = tw_dev->ioctl_data[request_id];
+					for (i=0;i<use_sg;i++) {
+						if ((u32 *)command_packet->byte8.param.sgl[i].address != NULL) {
+							error = copy_from_user(data_ptr, (u32 *)command_packet->byte8.param.sgl[i].address, command_packet->byte8.param.sgl[i].length);
+							if (error) {
+								printk(KERN_WARNING "3w-xxxx: scsi%d: Error copying param sglist from userspace.\n", tw_dev->host->host_no);
+								goto tw_ioctl_bail;
+							}
+						} else {
+							printk(KERN_WARNING "3w-xxxx: scsi%d: tw_ioctl(): Bad param sgl address.\n", tw_dev->host->host_no);
+							tw_dev->srb[request_id]->result = (DID_RESET << 16);
+							goto tw_ioctl_bail;
+						}
+						data_ptr+=command_packet->byte8.param.sgl[i].length;
+					}
+					command_packet->size = 4;
+					command_packet->byte8.param.sgl[0].address = dma_handle;
+					command_packet->byte8.param.sgl[0].length = total_bytes;
+				}
+				if (command_packet->byte0.sgl_offset == 3) {
+					use_sg = command_packet->size - 4;
+					for (i=0;i<use_sg;i++)
+						total_bytes+=command_packet->byte8.io.sgl[i].length;
+					tw_dev->ioctl_data[request_id] = pci_alloc_consistent(tw_dev->tw_pci_dev, total_bytes, &dma_handle);
+
+					if (!tw_dev->ioctl_data[request_id]) {
+						printk(KERN_WARNING "3w-xxxx: scsi%d: tw_ioctl(): pci_alloc_consistent() failed for request_id %d.\n", tw_dev->host->host_no, request_id);
+						return 1;
+					}
+					if (command_packet->byte0.opcode == TW_OP_WRITE) {
+						/* Copy io sglist into the kernel */
+						data_ptr = tw_dev->ioctl_data[request_id];
+						for (i=0;i<use_sg;i++) {
+							if ((u32 *)command_packet->byte8.io.sgl[i].address != NULL) {
+								error = copy_from_user(data_ptr, (u32 *)command_packet->byte8.io.sgl[i].address, command_packet->byte8.io.sgl[i].length);
+								if (error) {
+									printk(KERN_WARNING "3w-xxxx: scsi%d: Error copying io sglist from userspace.\n", tw_dev->host->host_no);
+									goto tw_ioctl_bail;
+								}
+							} else {
+								printk(KERN_WARNING "3w-xxxx: scsi%d: tw_ioctl(): Bad io sgl address.\n", tw_dev->host->host_no);
+								tw_dev->srb[request_id]->result = (DID_RESET << 16);
+								goto tw_ioctl_bail;
+							}
+							data_ptr+=command_packet->byte8.io.sgl[i].length;
+						}
+					}
+					command_packet->size = 5;
+					command_packet->byte8.io.sgl[0].address = dma_handle;
+					command_packet->byte8.io.sgl[0].length = total_bytes;
+				}
+
+				spin_unlock_irq(tw_dev->host->host_lock);
+				spin_unlock_irq(&tw_dev->tw_lock);
+
+				/* Finally post the command packet */
+				tw_post_command_packet(tw_dev, request_id);
+
+				mdelay(TW_IOCTL_WAIT_TIME);
+				spin_lock_irq(&tw_dev->tw_lock);
+				spin_lock_irq(tw_dev->host->host_lock);
+
+				if (signal_pending(current)) {
+					dprintk(KERN_WARNING "3w-xxxx: scsi%d: tw_ioctl(): Signal pending, aborting ioctl().\n", tw_dev->host->host_no);
+					tw_dev->srb[request_id]->result = (DID_OK << 16);
+					goto tw_ioctl_bail;
+				}
+
+				tw_dev->srb[request_id]->result = (DID_OK << 16);
+				/* Now copy up the param or io sglist to userspace */
+				if (command_packet->byte0.sgl_offset == 2) {
+					use_sg = command_save->size - 3;
+					data_ptr = phys_to_virt(command_packet->byte8.param.sgl[0].address);
+					for (i=0;i<use_sg;i++) {
+						if ((u32 *)command_save->byte8.param.sgl[i].address != NULL) {
+							error = copy_to_user((u32 *)command_save->byte8.param.sgl[i].address, data_ptr, command_save->byte8.param.sgl[i].length);
+							if (error) {
+								printk(KERN_WARNING "3w-xxxx: scsi%d: Error copying param sglist to userspace.\n", tw_dev->host->host_no);
+								goto tw_ioctl_bail;
+							}
+							dprintk(KERN_WARNING "3w-xxxx: scsi%d: Copied %ld bytes to pid %d.\n", tw_dev->host->host_no, command_save->byte8.param.sgl[i].length, current->pid);
+							data_ptr+=command_save->byte8.param.sgl[i].length;
+						} else {
+							printk(KERN_WARNING "3w-xxxx: scsi%d: tw_ioctl(): Bad param sgl address.\n", tw_dev->host->host_no);
+							tw_dev->srb[request_id]->result = (DID_RESET << 16);
+							goto tw_ioctl_bail;
+						}
+					}
+				}
+				if (command_packet->byte0.sgl_offset == 3) {
+					use_sg = command_save->size - 4;
+					if (command_packet->byte0.opcode == TW_OP_READ) {
+						data_ptr = phys_to_virt(command_packet->byte8.io.sgl[0].address);
+						for(i=0;i<use_sg;i++) {
+							if ((u32 *)command_save->byte8.io.sgl[i].address != NULL) {
+								error = copy_to_user((u32 *)command_save->byte8.io.sgl[i].address, data_ptr, command_save->byte8.io.sgl[i].length);
+								if (error) {
+									printk(KERN_WARNING "3w-xxxx: scsi%d: Error copying io sglist to userspace.\n", tw_dev->host->host_no);
+									goto tw_ioctl_bail;
+								}
+								dprintk(KERN_WARNING "3w-xxxx: scsi%d: Copied %ld bytes to pid %d.\n", tw_dev->host->host_no, command_save->byte8.io.sgl[i].length, current->pid);
+								data_ptr+=command_save->byte8.io.sgl[i].length;
+							} else {
+								printk(KERN_WARNING "3w-xxxx: scsi%d: tw_ioctl(): Bad io sgl address.\n", tw_dev->host->host_no);
+								tw_dev->srb[request_id]->result = (DID_RESET << 16);
+								goto tw_ioctl_bail;
+							}
+						}
+					}
+				}
+
+			tw_ioctl_bail:
+
+				/* Free up sglist memory */
+				if (tw_dev->ioctl_data[request_id])
+					pci_free_consistent(tw_dev->tw_pci_dev, total_bytes, tw_dev->ioctl_data[request_id], dma_handle);
+				else
+					printk(KERN_WARNING "3w-xxxx: scsi%d: tw_ioctl(): Error freeing ioctl data.\n", tw_dev->host->host_no);
+
+				/* Now complete the io */
+				tw_dev->state[request_id] = TW_S_COMPLETED;
+				tw_state_request_finish(tw_dev, request_id);
+				tw_dev->posted_request_count--;
+				tw_dev->srb[request_id]->scsi_done(tw_dev->srb[request_id]);
+				return 0;
+			} else {
+				printk(KERN_WARNING "3w-xxxx: tw_ioctl(): ioctl->data NULL.\n");
+				return 1;
+			}
 		default:
 			printk(KERN_WARNING "3w-xxxx: Unknown ioctl 0x%x.\n", opcode);
 			tw_dev->state[request_id] = TW_S_COMPLETED;
@@ -1655,6 +1756,7 @@
 	TW_Param *param;
 	TW_Ioctl *ioctl = NULL;
 	TW_Passthru *passthru = NULL;
+	TW_Command *command_packet;

 	ioctl = (TW_Ioctl *)tw_dev->srb[request_id]->request_buffer;
 	dprintk(KERN_NOTICE "3w-xxxx: tw_ioctl_complete()\n");
@@ -1663,6 +1765,13 @@
 		printk(KERN_WARNING "3w-xxxx: tw_ioctl_complete(): Request buffer NULL.\n");
 		return 1;
 	}
+
+	command_packet = (TW_Command *)tw_dev->command_packet_virtual_address[request_id];
+	if (command_packet == NULL) {
+		printk(KERN_WARNING "3w-xxxx: scsi%d: tw_ioctl_complete(): Bad command packet virtual address.\n", tw_dev->host->host_no);
+		return 1;
+	}
+
 	dprintk(KERN_NOTICE "3w-xxxx: tw_ioctl_complete(): Request_bufflen = %d\n", tw_dev->srb[request_id]->request_bufflen);

 	ioctl = (TW_Ioctl *)buff;
@@ -1671,6 +1780,9 @@
 			passthru = (TW_Passthru *)ioctl->data;
 			memcpy(buff, tw_dev->alignment_virtual_address[request_id], passthru->sector_count * 512);
 			break;
+		case TW_CMD_PACKET_WITH_DATA:
+			dprintk(KERN_WARNING "3w-xxxx: tw_ioctl_complete(): caught TW_CMD_PACKET_WITH_DATA.\n");
+			return 2; /* Special case for isr to not complete io */
 		default:
 			memset(buff, 0, tw_dev->srb[request_id]->request_bufflen);
 			param = (TW_Param *)tw_dev->alignment_virtual_address[request_id];
@@ -1684,6 +1796,40 @@
 	return 0;
 } /* End tw_ioctl_complete() */

+static int tw_map_scsi_sg_data(struct pci_dev *pdev, Scsi_Cmnd *cmd)
+{
+	int use_sg;
+	int dma_dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
+
+	dprintk(KERN_WARNING "3w-xxxx: tw_map_scsi_sg_data()\n");
+
+	if (cmd->use_sg == 0)
+		return 0;
+
+	use_sg = pci_map_sg(pdev, cmd->buffer, cmd->use_sg, dma_dir);
+	cmd->SCp.phase = 2;
+	cmd->SCp.have_data_in = use_sg;
+
+	return use_sg;
+} /* End tw_map_scsi_sg_data() */
+
+static u32 tw_map_scsi_single_data(struct pci_dev *pdev, Scsi_Cmnd *cmd)
+{
+	dma_addr_t mapping;
+	int dma_dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
+
+	dprintk(KERN_WARNING "3w-xxxx: tw_map_scsi_single_data()\n");
+
+	if (cmd->request_bufflen == 0)
+		return 0;
+
+	mapping = pci_map_single(pdev, cmd->request_buffer, cmd->request_bufflen, dma_dir);
+	cmd->SCp.phase = 2;
+	cmd->SCp.have_data_in = mapping;
+
+	return mapping;
+} /* End tw_map_scsi_single_data() */
+
 /* This function will mask the command interrupt */
 void tw_mask_command_interrupt(TW_Device_Extension *tw_dev)
 {
@@ -1704,14 +1850,25 @@
 	do_gettimeofday(&before);
 	status_reg_value = inl(status_reg_addr);

+	if (tw_check_bits(status_reg_value)) {
+		dprintk(KERN_WARNING "3w-xxxx: tw_poll_status(): Unexpected bits.\n");
+		tw_decode_bits(tw_dev, status_reg_value);
+	}
+
 	while ((status_reg_value & flag) != flag) {
 		status_reg_value = inl(status_reg_addr);
+
+		if (tw_check_bits(status_reg_value)) {
+			dprintk(KERN_WARNING "3w-xxxx: tw_poll_status(): Unexpected bits.\n");
+			tw_decode_bits(tw_dev, status_reg_value);
+		}
+
 		do_gettimeofday(&timeout);
 		if (before.tv_sec + seconds < timeout.tv_sec) {
 			dprintk(KERN_WARNING "3w-xxxx: tw_poll_status(): Flag 0x%x not found.\n", flag);
 			return 1;
 		}
-		mdelay(1);
+		mdelay(5);
 	}
 	return 0;
 } /* End tw_poll_status() */
@@ -1787,6 +1944,7 @@
 				srb = tw_dev->srb[i];
 				srb->result = (DID_RESET << 16);
 				tw_dev->srb[i]->scsi_done(tw_dev->srb[i]);
+				tw_unmap_scsi_data(tw_dev->tw_pci_dev, tw_dev->srb[i]);
 			}
 		}
 	}
@@ -1821,7 +1979,7 @@

 		error = tw_aen_drain_queue(tw_dev);
 		if (error) {
-			printk(KERN_WARNING "3w-xxxx: scsi%d: Card not responding, retrying.\n", tw_dev->host->host_no);
+			printk(KERN_WARNING "3w-xxxx: scsi%d: AEN drain failed, retrying.\n", tw_dev->host->host_no);
 			tries++;
 			continue;
 		}
@@ -1857,7 +2015,7 @@
 	}

 	/* Re-enable interrupts */
-	tw_enable_interrupts(tw_dev);
+	tw_enable_and_clear_interrupts(tw_dev);

 	return 0;
 } /* End tw_reset_sequence() */
@@ -2381,6 +2539,9 @@
 	capacity = (param_data[3] << 24) | (param_data[2] << 16) |
 		   (param_data[1] << 8) | param_data[0];

+	/* Subtract one sector to fix get last sector ioctl */
+	capacity -= 1;
+
 	dprintk(KERN_NOTICE "3w-xxxx: tw_scsiop_read_capacity_complete(): Capacity = 0x%x.\n", capacity);

 	/* Number of LBA's */
@@ -2403,8 +2564,8 @@
 {
 	TW_Command *command_packet;
 	u32 command_que_addr, command_que_value = 0;
-	u32 lba = 0x0, num_sectors = 0x0;
-	int i, count = 0;
+	u32 lba = 0x0, num_sectors = 0x0, buffaddr = 0x0;
+	int i, use_sg;
 	Scsi_Cmnd *srb;
 	struct scatterlist *sglist;

@@ -2461,45 +2622,25 @@
 	command_packet->byte8.io.lba = lba;
 	command_packet->byte6.block_count = num_sectors;

-	if ((tw_dev->is_raid_five[tw_dev->srb[request_id]->target] == 0) || (srb->cmnd[0] == READ_6) || (srb->cmnd[0] == READ_10) || (tw_dev->tw_pci_dev->device == TW_DEVICE_ID2)) {
-		/* Do this if there are no sg list entries */
-		if (tw_dev->srb[request_id]->use_sg == 0) {
-			dprintk(KERN_NOTICE "3w-xxxx: tw_scsiop_read_write(): SG = 0\n");
-			command_packet->byte8.io.sgl[0].address = virt_to_bus(tw_dev->srb[request_id]->request_buffer);
-			command_packet->byte8.io.sgl[0].length = tw_dev->srb[request_id]->request_bufflen;
-		}
-
-		/* Do this if we have multiple sg list entries */
-		if (tw_dev->srb[request_id]->use_sg > 0) {
-			for (i=0;i<tw_dev->srb[request_id]->use_sg; i++) {
-				command_packet->byte8.io.sgl[i].address = virt_to_bus(sglist[i].address);
-				command_packet->byte8.io.sgl[i].length = sglist[i].length;
-				command_packet->size+=2;
-			}
-			if (tw_dev->srb[request_id]->use_sg >= 1)
-				command_packet->size-=2;
+	/* Do this if there are no sg list entries */
+	if (tw_dev->srb[request_id]->use_sg == 0) {
+		dprintk(KERN_NOTICE "3w-xxxx: tw_scsiop_read_write(): SG = 0\n");
+		buffaddr = tw_map_scsi_single_data(tw_dev->tw_pci_dev, tw_dev->srb[request_id]);
+		command_packet->byte8.io.sgl[0].address = buffaddr;
+		command_packet->byte8.io.sgl[0].length = tw_dev->srb[request_id]->request_bufflen;
+	}
+
+	/* Do this if we have multiple sg list entries */
+	if (tw_dev->srb[request_id]->use_sg > 0) {
+		use_sg = tw_map_scsi_sg_data(tw_dev->tw_pci_dev, tw_dev->srb[request_id]);;
+		for (i=0;i<use_sg; i++) {
+			command_packet->byte8.io.sgl[i].address = sg_dma_address(&sglist[i]);
+			command_packet->byte8.io.sgl[i].length = sg_dma_len(&sglist[i]);
+			command_packet->size+=2;
 		}
-	} else {
-                /* Do this if there are no sg list entries for raid 5 */
-                if (tw_dev->srb[request_id]->use_sg == 0) {
-			dprintk(KERN_WARNING "doing raid 5 write use_sg = 0, bounce_buffer[%d] = 0x%p\n", request_id, tw_dev->bounce_buffer[request_id]);
-			memcpy(tw_dev->bounce_buffer[request_id], tw_dev->srb[request_id]->request_buffer, tw_dev->srb[request_id]->request_bufflen);
-			command_packet->byte8.io.sgl[0].address = virt_to_bus(tw_dev->bounce_buffer[request_id]);
-			command_packet->byte8.io.sgl[0].length = tw_dev->srb[request_id]->request_bufflen;
-                }
-
-                /* Do this if we have multiple sg list entries for raid 5 */
-                if (tw_dev->srb[request_id]->use_sg > 0) {
-                        dprintk(KERN_WARNING "doing raid 5 write use_sg = %d, sglist[0].length = %d\n", tw_dev->srb[request_id]->use_sg, sglist[0].length);
-                        for (i=0;i<tw_dev->srb[request_id]->use_sg; i++) {
-                                memcpy((char *)(tw_dev->bounce_buffer[request_id])+count, sglist[i].address, sglist[i].length);
-				count+=sglist[i].length;
-                        }
-                        command_packet->byte8.io.sgl[0].address = virt_to_bus(tw_dev->bounce_buffer[request_id]);
-                        command_packet->byte8.io.sgl[0].length = count;
-                        command_packet->size = 5; /* single sgl */
-                }
-        }
+		if (tw_dev->srb[request_id]->use_sg >= 1)
+			command_packet->size-=2;
+	}

 	/* Update SG statistics */
 	tw_dev->sgl_entries = tw_dev->srb[request_id]->use_sg;
@@ -2521,18 +2662,18 @@
 /* This function will handle the request sense scsi command */
 int tw_scsiop_request_sense(TW_Device_Extension *tw_dev, int request_id)
 {
-       dprintk(KERN_NOTICE "3w-xxxx: tw_scsiop_request_sense()\n");
-
-       /* For now we just zero the sense buffer */
-       memset(tw_dev->srb[request_id]->request_buffer, 0, tw_dev->srb[request_id]->request_bufflen);
-       tw_dev->state[request_id] = TW_S_COMPLETED;
-       tw_state_request_finish(tw_dev, request_id);
-
-       /* If we got a request_sense, we probably want a reset, return error */
-       tw_dev->srb[request_id]->result = (DID_ERROR << 16);
-       tw_dev->srb[request_id]->scsi_done(tw_dev->srb[request_id]);
-
-       return 0;
+	dprintk(KERN_NOTICE "3w-xxxx: tw_scsiop_request_sense()\n");
+
+	/* For now we just zero the request buffer */
+	memset(tw_dev->srb[request_id]->request_buffer, 0, tw_dev->srb[request_id]->request_bufflen);
+	tw_dev->state[request_id] = TW_S_COMPLETED;
+	tw_state_request_finish(tw_dev, request_id);
+
+	/* If we got a request_sense, we probably want a reset, return error */
+	tw_dev->srb[request_id]->result = (DID_ERROR << 16);
+	tw_dev->srb[request_id]->scsi_done(tw_dev->srb[request_id]);
+
+	return 0;
 } /* End tw_scsiop_request_sense() */

 /* This function will handle test unit ready scsi command */
@@ -2626,8 +2767,7 @@
 			}
 			if (command_packet->status != 0) {
 				/* bad response */
-				dprintk(KERN_WARNING "3w-xxxx: tw_setfeature(): Bad response, status = 0x%x, flags = 0x%x.\n", command_packet->status, command_packet->flags);
-				tw_decode_error(tw_dev, command_packet->status, command_packet->flags, command_packet->byte3.unit);
+				tw_decode_sense(tw_dev, request_id, 0);
 				return 1;
 			}
 			break; /* Response was okay, so we exit */
@@ -2671,7 +2811,7 @@
 	}

 	/* Re-enable interrupts */
-	tw_enable_interrupts(tw_dev);
+	tw_enable_and_clear_interrupts(tw_dev);

 	return 0;
 } /* End tw_shutdown_device() */
@@ -2719,7 +2859,7 @@
 	int id = 0;

 	dprintk(KERN_NOTICE "3w-xxxx: tw_state_request_start()\n");
-
+
 	/* Obtain next free request_id */
 	do {
 		if (tw_dev->free_head == tw_dev->free_wrap) {
@@ -2738,6 +2878,19 @@
 	return 0;
 } /* End tw_state_request_start() */

+static void tw_unmap_scsi_data(struct pci_dev *pdev, Scsi_Cmnd *cmd)
+{
+	int dma_dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
+
+	dprintk(KERN_WARNING "3w-xxxx: tw_unmap_scsi_data()\n");
+
+	if (cmd->use_sg) {
+		pci_unmap_sg(pdev, cmd->request_buffer, cmd->use_sg, dma_dir);
+	} else {
+		pci_unmap_single(pdev, cmd->SCp.have_data_in, cmd->request_bufflen, dma_dir);
+	}
+} /* End tw_unmap_scsi_data() */
+
 /* This function will unmask the command interrupt on the controller */
 void tw_unmask_command_interrupt(TW_Device_Extension *tw_dev)
 {
@@ -2749,7 +2902,6 @@
 } /* End tw_unmask_command_interrupt() */

 /* Now get things going */
-
 static Scsi_Host_Template driver_template = TWXXXX;
 #include "scsi_module.c"

diff -Naur linux-2.5.6-pre1/drivers/scsi/3w-xxxx.h linux-2.5.6-pre2/drivers/scsi/3w-xxxx.h
--- linux-2.5.6-pre1/drivers/scsi/3w-xxxx.h	Tue Feb 19 18:10:58 2002
+++ linux-2.5.6-pre2/drivers/scsi/3w-xxxx.h	Wed Feb 27 11:53:52 2002
@@ -6,7 +6,7 @@
    		     Arnaldo Carvalho de Melo <acme@conectiva.com.br>
                      Brad Strand <linux@3ware.com>

-   Copyright (C) 1999-2001 3ware Inc.
+   Copyright (C) 1999-2002 3ware Inc.

    Kernel compatablity By:	Andre Hedrick <andre@suse.com>
    Non-Copyright (C) 2000	Andre Hedrick <andre@suse.com>
@@ -62,7 +62,7 @@
 static char *tw_aen_string[] = {
 	"AEN queue empty",                      // 0x000
 	"Soft reset occurred",                  // 0x001
-	"Mirorr degraded: Unit #",              // 0x002
+	"Unit degraded: Unit #",                // 0x002
 	"Controller error",                     // 0x003
 	"Rebuild failed: Unit #",               // 0x004
 	"Rebuild complete: Unit #",             // 0x005
@@ -90,10 +90,36 @@
 	"DCB unsupported version: Port #",      // 0x028
 	"Verify started: Unit #",               // 0x029
 	"Verify failed: Port #",                // 0x02A
-	"Verify complete: Unit #"               // 0x02B
+	"Verify complete: Unit #",              // 0x02B
+	"Overwrote bad sector during rebuild: Port #",  //0x2C
+	"Encountered bad sector during rebuild: Port #" //0x2D
 };

-#define TW_AEN_STRING_MAX                      0x02C
+#define TW_AEN_STRING_MAX                      0x02E
+
+/*
+   Sense key lookup table
+   Format: ESDC/flags,SenseKey,AdditionalSenseCode,AdditionalSenseCodeQualifier
+*/
+static unsigned char tw_sense_table[][4] =
+{
+  /* Codes for newer firmware */
+                            // ATA Error                    SCSI Error
+  {0x01, 0x03, 0x13, 0x00}, // Address mark not found       Address mark not found for data field
+  {0x04, 0x0b, 0x00, 0x00}, // Aborted command              Aborted command
+  {0x10, 0x0b, 0x14, 0x00}, // ID not found                 Recorded entity not found
+  {0x40, 0x03, 0x11, 0x00}, // Uncorrectable ECC error      Unrecovered read error
+  {0x61, 0x04, 0x00, 0x00}, // Device fault                 Hardware error
+  {0x84, 0x0b, 0x47, 0x00}, // Data CRC error               SCSI parity error
+  {0xd0, 0x0b, 0x00, 0x00}, // Device busy                  Aborted command
+  {0xd1, 0x0b, 0x00, 0x00}, // Device busy                  Aborted command
+
+  /* Codes for older firmware */
+                            // 3ware Error                  SCSI Error
+  {0x09, 0x0b, 0x00, 0x00}, // Unrecovered disk error       Aborted command
+  {0x37, 0x0b, 0x04, 0x00}, // Unit offline                 Logical unit not ready
+  {0x51, 0x0b, 0x00, 0x00}  // Unspecified                  Aborted command
+};

 /* Control register bit definitions */
 #define TW_CONTROL_CLEAR_HOST_INTERRUPT	       0x00080000
@@ -108,6 +134,7 @@
 #define TW_CONTROL_DISABLE_INTERRUPTS	       0x00000040
 #define TW_CONTROL_ISSUE_HOST_INTERRUPT	       0x00000020
 #define TW_CONTROL_CLEAR_PARITY_ERROR          0x00800000
+#define TW_CONTROL_CLEAR_PCI_ABORT             0x00100000

 /* Status register bit definitions */
 #define TW_STATUS_MAJOR_VERSION_MASK	       0xF0000000
@@ -140,6 +167,7 @@
 #define TW_DEVICE_ID2 (0x1001)  /* 7000 series controller */
 #define TW_NUMDEVICES 2
 #define TW_PCI_CLEAR_PARITY_ERRORS 0xc100
+#define TW_PCI_CLEAR_PCI_ABORT     0x2000

 /* Command packet opcodes */
 #define TW_OP_NOP	      0x0
@@ -153,6 +181,7 @@
 #define TW_OP_AEN_LISTEN      0x1c
 #define TW_CMD_PACKET         0x1d
 #define TW_ATA_PASSTHRU       0x1e
+#define TW_CMD_PACKET_WITH_DATA 0x1f

 /* Asynchronous Event Notification (AEN) Codes */
 #define TW_AEN_QUEUE_EMPTY       0x0000
@@ -169,7 +198,8 @@
 #define TW_AEN_SBUF_FAIL         0x0024

 /* Misc defines */
-#define TW_ALIGNMENT			      0x200 /* 16 D-WORDS */
+#define TW_ALIGNMENT_6000		      64 /* 64 bytes */
+#define TW_ALIGNMENT_7000                     4  /* 4 bytes */
 #define TW_MAX_UNITS			      16
 #define TW_COMMAND_ALIGNMENT_MASK	      0x1ff
 #define TW_INIT_MESSAGE_CREDITS		      0x100
@@ -179,7 +209,6 @@
 #define TW_ATA_PASS_SGL_MAX                   60
 #define TW_MAX_PASSTHRU_BYTES                 4096
 #define TW_Q_LENGTH			      256
-#define TW_MAX_BOUNCEBUF                      16
 #define TW_Q_START			      0
 #define TW_MAX_SLOT			      32
 #define TW_MAX_PCI_BUSES		      255
@@ -191,12 +220,9 @@
 #define TW_MAX_AEN_TRIES                      100
 #define TW_UNIT_ONLINE                        1
 #define TW_IN_INTR                            1
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,7)
 #define TW_MAX_SECTORS                        256
-#else
-#define TW_MAX_SECTORS                        128
-#endif
 #define TW_AEN_WAIT_TIME                      1000
+#define TW_IOCTL_WAIT_TIME                    (1 * HZ) /* 1 second */

 /* Macros */
 #define TW_STATUS_ERRORS(x) \
@@ -262,7 +288,6 @@
 } TW_Command;

 typedef struct TAG_TW_Ioctl {
-	int buffer;
 	unsigned char opcode;
 	unsigned short table_id;
 	unsigned char parameter_id;
@@ -345,11 +370,8 @@
 	TW_Registers		registers;
 	u32			*alignment_virtual_address[TW_Q_LENGTH];
 	u32			alignment_physical_address[TW_Q_LENGTH];
-	u32			*bounce_buffer[TW_Q_LENGTH];
 	int			is_unit_present[TW_MAX_UNITS];
-	int			is_raid_five[TW_MAX_UNITS];
 	int			num_units;
-	int			num_raid_five;
 	u32			*command_packet_virtual_address[TW_Q_LENGTH];
 	u32			command_packet_physical_address[TW_Q_LENGTH];
 	struct pci_dev		*tw_pci_dev;
@@ -381,22 +403,24 @@
 	unsigned char		aen_head;
 	unsigned char		aen_tail;
 	long			flags; /* long req'd for set_bit --RR */
+	char			*ioctl_data[TW_Q_LENGTH];
 } TW_Device_Extension;

 /* Function prototypes */
 int tw_aen_complete(TW_Device_Extension *tw_dev, int request_id);
 int tw_aen_drain_queue(TW_Device_Extension *tw_dev);
 int tw_aen_read_queue(TW_Device_Extension *tw_dev, int request_id);
-int tw_allocate_memory(TW_Device_Extension *tw_dev, int request_id, int size, int which);
+int tw_allocate_memory(TW_Device_Extension *tw_dev, int size, int which);
 int tw_check_bits(u32 status_reg_value);
 int tw_check_errors(TW_Device_Extension *tw_dev);
 void tw_clear_attention_interrupt(TW_Device_Extension *tw_dev);
 void tw_clear_host_interrupt(TW_Device_Extension *tw_dev);
 void tw_decode_bits(TW_Device_Extension *tw_dev, u32 status_reg_value);
-void tw_decode_error(TW_Device_Extension *tw_dev, unsigned char status, unsigned char flags, unsigned char unit);
+void tw_decode_sense(TW_Device_Extension *tw_dev, int request_id, int fill_sense);
 void tw_disable_interrupts(TW_Device_Extension *tw_dev);
 int tw_empty_response_que(TW_Device_Extension *tw_dev);
 void tw_enable_interrupts(TW_Device_Extension *tw_dev);
+void tw_enable_and_clear_interrupts(TW_Device_Extension *tw_dev);
 int tw_findcards(Scsi_Host_Template *tw_host);
 void tw_free_device_extension(TW_Device_Extension *tw_dev);
 int tw_initconnection(TW_Device_Extension *tw_dev, int message_credits);


