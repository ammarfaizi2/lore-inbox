Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261281AbRELQnj>; Sat, 12 May 2001 12:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261279AbRELQne>; Sat, 12 May 2001 12:43:34 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:24142
	"EHLO jet.il.steeleye.com") by vger.kernel.org with ESMTP
	id <S261277AbRELQnS>; Sat, 12 May 2001 12:43:18 -0400
Message-Id: <200105121643.LAA01160@jet.il.steeleye.com>
X-Mailer: exmh version 2.1.1 10/15/1999
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        torvalds@transmeta.com
Subject: [NEW SCSI DRIVER] for 53c700 chip and NCR_D700 card against 2.4.4
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_5367807680"
Date: Sat, 12 May 2001 11:43:04 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_5367807680
Content-Type: text/plain; charset=us-ascii

Hi All,

Attached is a driver for the NCR Dual 700 Microchannel card.  Since the chip 
engine of this card is the 53c700-66, which appeared in quite a few other SCSI 
cards as well, I've abstracted the chip function (in much the same way as the 
8390 chip function is abstracted in network cards) so that it should be easy 
to link it into any other SCSI card using it.  As you can see, the actual 
board specific code is about 150 lines.

The chip driver is full featured (sync (where supported), disconnects and tag 
command queueing).  It will drive both single ended and differential 
interfaces and uses the new SCSI error handler.

I know we have two drivers that claim to do these chips (53c7xx and 53c7,8xx) 
but if you actually compile them for this chip, they are completely broken.  
The chip itself is extremely primitive (not having the table indirect mode, 
which is the backbone of most of the later drivers) so it makes much more 
sense to give it its own driver.

The chip driver is currently I/O mapped (because the only cards I know using 
the chip are I/O mapped), but could easily be made memory mapped as well, just 
let me know.

James Bottomley
Hansen Partnership.



--==_Exmh_5367807680
Content-Type: text/plain ; name="NCR_D700-2.1.diff"; charset=us-ascii
Content-Description: NCR_D700-2.1.diff
Content-Disposition: attachment; filename="NCR_D700-2.1.diff"

Index: linux/2.4/MAINTAINERS
diff -u linux/2.4/MAINTAINERS:1.1.1.13 linux/2.4/MAINTAINERS:1.1.1.13.4.1
--- linux/2.4/MAINTAINERS:1.1.1.13	Fri May  4 11:27:28 2001
+++ linux/2.4/MAINTAINERS	Fri May 11 20:15:24 2001
@@ -81,6 +81,12 @@
 L:	linux-net@vger.kernel.org
 S:	Maintained
 
+53C700 AND 53C700-66 SCSI DRIVER
+P:	James E.J. Bottomley
+M:	James.Bottomley@HansenPartnership.com
+L:	linux-scsi@vger.kernel.org
+S:	Maintained
+
 6PACK NETWORK DRIVER FOR AX.25
 P:	Andreas Koensgen
 M:	ajk@iehk.rwth-aachen.de
@@ -877,6 +883,12 @@
 P:	Volker Lendecke
 M:	vl@kki.org
 L:	linware@sh.cvut.cz
+S:	Maintained
+
+NCR DUAL 700 SCSI DRIVER (MICROCHANNEL)
+P:	James E.J. Bottomley
+M:	James.Bottomley@HansenPartnership.com
+L:	linux-scsi@vger.kernel.org
 S:	Maintained
 
 NETFILTER
Index: linux/2.4/Documentation/Configure.help
diff -u linux/2.4/Documentation/Configure.help:1.1.1.13 linux/2.4/Documentation/Configure.help:1.1.1.13.4.1
--- linux/2.4/Documentation/Configure.help:1.1.1.13	Fri May  4 11:29:34 2001
+++ linux/2.4/Documentation/Configure.help	Fri May 11 20:15:24 2001
@@ -5934,6 +5934,15 @@
   port or memory mapped. You should know what you have. The most
   common card, Trantor T130B, uses port mapped mode.
 
+NCR Dual 700 MCA SCSI support
+CONFIG_SCSI_NCR_D700
+  This is a driver for the Microchannel Dual 700 card produced by
+  NCR and commonly used in 345x/35xx/4100 class machines.  It always
+  tries to negotiate sync and uses tag command queueing.
+
+  Unless you have an NCR manufactured machine, the chances are that you do
+  not have this SCSI card, so say N.
+
 NCR53c7,8xx SCSI support
 CONFIG_SCSI_NCR53C7xx
   This is a driver for the 53c7 and 8xx NCR family of SCSI
Index: linux/2.4/drivers/scsi/53c700.c
diff -u /dev/null linux/2.4/drivers/scsi/53c700.c:1.1.4.2
--- /dev/null	Sat May 12 12:05:15 2001
+++ linux/2.4/drivers/scsi/53c700.c	Sat May 12 11:52:50 2001
@@ -0,0 +1,1749 @@
+/* -*- mode: c; c-basic-offset: 8 -*- */
+
+/* NCR (or Symbios) 53c700 and 53c700-66 Driver
+ *
+ * Copyright (C) 2001 by James.Bottomley@HansenPartnership.com
+**-----------------------------------------------------------------------------
+**  
+**  This program is free software; you can redistribute it and/or modify
+**  it under the terms of the GNU General Public License as published by
+**  the Free Software Foundation; either version 2 of the License, or
+**  (at your option) any later version.
+**
+**  This program is distributed in the hope that it will be useful,
+**  but WITHOUT ANY WARRANTY; without even the implied warranty of
+**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+**  GNU General Public License for more details.
+**
+**  You should have received a copy of the GNU General Public License
+**  along with this program; if not, write to the Free Software
+**  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+**
+**-----------------------------------------------------------------------------
+ */
+
+/* Notes:
+ *
+ * This driver is designed exclusively for these chips (virtually the
+ * earliest of the scripts engine chips).  They need their own drivers
+ * because they are missing so many of the scripts and snazzy register
+ * features of their elder brothers (the 710, 720 and 770).
+ *
+ * The 700 is the lowliest of the line, it can only do async SCSI.
+ * The 700-66 can at least do synchronous SCSI up to 10MHz.
+ * 
+ * The 700 chip has no host bus interface logic of its own.  However,
+ * it is usually mapped to a location with well defined register
+ * offsets.  Therefore, if you can determine the base address and the
+ * irq your board incorporating this chip uses, you can probably use
+ * this driver to run it (although you'll probably have to write a
+ * minimal wrapper for the purpose---see the NCR_D700 driver for
+ * details about how to do this).
+ *
+ *
+ * TODO List:
+ *
+ * 1. Better statistics in the proc fs
+ *
+ * 2. Implement message queue (queues SCSI messages like commands) and make
+ *    the abort and device reset functions use them.
+ * */
+
+/* CHANGELOG
+ *
+ * Version 2.1
+ *
+ * Initial modularisation from the D700.  See NCR_D700.c for the rest of
+ * the changelog.
+ * */
+#define NCR_700_VERSION "2.1"
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+#include <linux/mca.h>
+#include <asm/dma.h>
+#include <asm/system.h>
+#include <asm/spinlock.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/byteorder.h>
+#include <linux/blk.h>
+
+#ifdef MODULE
+#include <linux/module.h>
+#endif
+
+
+#include "scsi.h"
+#include "hosts.h"
+#include "constants.h"
+
+#include "53c700.h"
+
+#ifdef NCR_700_DEBUG
+#define STATIC
+#else
+#define STATIC static
+#endif
+
+#ifdef MODULE
+MODULE_AUTHOR("James Bottomley");
+MODULE_DESCRIPTION("53c700 and 53c700-66 Driver");
+#endif
+
+/* This is the script */
+#include "53c700_d.h"
+
+
+STATIC int NCR_700_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
+STATIC int NCR_700_abort(Scsi_Cmnd * SCpnt);
+STATIC int NCR_700_bus_reset(Scsi_Cmnd * SCpnt);
+STATIC int NCR_700_dev_reset(Scsi_Cmnd * SCpnt);
+STATIC int NCR_700_host_reset(Scsi_Cmnd * SCpnt);
+STATIC int NCR_700_proc_directory_info(char *, char **, off_t, int, int, int);
+STATIC void NCR_700_chip_setup(struct Scsi_Host *host);
+STATIC void NCR_700_chip_reset(struct Scsi_Host *host);
+
+static char *NCR_700_phase[] = {
+	"",
+	"after selection",
+	"before command phase",
+	"after command phase",
+	"after status phase",
+	"after data in phase",
+	"after data out phase",
+	"during data phase",
+};
+
+static char *NCR_700_condition[] = {
+	"",
+	"NOT MSG_OUT",
+	"UNEXPECTED PHASE",
+	"NOT MSG_IN",
+	"UNEXPECTED MSG",
+	"MSG_IN",
+	"SDTR_MSG RECEIVED",
+	"REJECT_MSG RECEIVED",
+	"DISCONNECT_MSG RECEIVED",
+	"MSG_OUT",
+	"DATA_IN",
+	
+};
+
+static char *NCR_700_fatal_messages[] = {
+	"unexpected message after reselection",
+	"still MSG_OUT after message injection",
+	"not MSG_IN after selection",
+	"Illegal message length received",
+};
+
+static char *NCR_700_SBCL_bits[] = {
+	"IO ",
+	"CD ",
+	"MSG ",
+	"ATN ",
+	"SEL ",
+	"BSY ",
+	"ACK ",
+	"REQ ",
+};
+
+static char *NCR_700_SBCL_to_phase[] = {
+	"DATA_OUT",
+	"DATA_IN",
+	"CMD_OUT",
+	"STATE",
+	"ILLEGAL PHASE",
+	"ILLEGAL PHASE",
+	"MSG OUT",
+	"MSG IN",
+};
+
+static __u8 NCR_700_SDTR_msg[] = {
+	0x01,			/* Extended message */
+	0x03,			/* Extended message Length */
+	0x01,			/* SDTR Extended message */
+	NCR_700_MIN_PERIOD,
+	NCR_700_MAX_OFFSET
+};
+
+struct Scsi_Host * __init
+NCR_700_detect(Scsi_Host_Template *tpnt,
+	       struct NCR_700_Host_Parameters *hostdata)
+{
+	__u32 *script = kmalloc(sizeof(SCRIPT), GFP_KERNEL);
+	__u32 pScript;
+	struct Scsi_Host *host;
+	static int banner = 0;
+	int j;
+
+	/* Fill in the missing routines from the host template */
+	tpnt->queuecommand = NCR_700_queuecommand;
+	tpnt->eh_abort_handler = NCR_700_abort;
+	tpnt->eh_device_reset_handler = NCR_700_dev_reset;
+	tpnt->eh_bus_reset_handler = NCR_700_bus_reset;
+	tpnt->eh_host_reset_handler = NCR_700_host_reset;
+	tpnt->can_queue = NCR_700_COMMAND_SLOTS_PER_HOST;
+	tpnt->sg_tablesize = NCR_700_SG_SEGMENTS;
+	tpnt->cmd_per_lun = NCR_700_MAX_TAGS;
+	tpnt->use_clustering = DISABLE_CLUSTERING;
+	tpnt->use_new_eh_code = 1;
+	tpnt->proc_info = NCR_700_proc_directory_info;
+	
+	if(tpnt->name == NULL)
+		tpnt->name = "53c700";
+	if(tpnt->proc_name == NULL)
+		tpnt->proc_name = "53c700";
+	
+
+	host = scsi_register(tpnt, 4);
+	if(script == NULL) {
+		printk(KERN_ERR "53c700: Failed to allocate script, detatching\n");
+		scsi_unregister(host);
+		return NULL;
+	}
+
+	hostdata->slots = kmalloc(sizeof(struct NCR_700_command_slot) * NCR_700_COMMAND_SLOTS_PER_HOST, GFP_KERNEL);
+	if(hostdata->slots == NULL) {
+		printk(KERN_ERR "53c700: Failed to allocate command slots, detatching\n");
+		scsi_unregister(host);
+		return NULL;
+	}
+	memset(hostdata->slots, 0, sizeof(struct NCR_700_command_slot) * NCR_700_COMMAND_SLOTS_PER_HOST);
+	for(j = 0; j < NCR_700_COMMAND_SLOTS_PER_HOST; j++) {
+		if(j == 0)
+			hostdata->free_list = &hostdata->slots[j];
+		else
+			hostdata->slots[j-1].ITL_forw = &hostdata->slots[j];
+		hostdata->slots[j].state = NCR_700_SLOT_FREE;
+	}
+	host->hostdata[0] = (__u32)hostdata;
+	memcpy(script, SCRIPT, sizeof(SCRIPT));
+	/* bus physical address of script */
+	pScript = virt_to_bus(script);
+	/* adjust all labels to be bus physical */
+	for(j = 0; j < PATCHES; j++) {
+		script[LABELPATCHES[j]] += pScript;
+	}
+	/* now patch up fixed addresses */
+	script_patch_32(script, MessageLocation,
+			virt_to_bus(&hostdata->msgout[0]));
+	script_patch_32(script, StatusAddress,
+			virt_to_bus(&hostdata->status));
+	script_patch_32(script, ReceiveMsgAddress,
+			virt_to_bus(&hostdata->msgin[0]))
+		hostdata->script = script;
+	hostdata->pScript = pScript;
+	hostdata->state = NCR_700_HOST_FREE;
+	spin_lock_init(&hostdata->lock);
+	hostdata->cmd = NULL;
+	host->max_id = 7;
+	host->max_lun = NCR_700_MAX_LUNS;
+	host->unique_id = hostdata->base;
+	host->base = hostdata->base;
+	host->hostdata[0] = (unsigned long)hostdata;
+	/* kick the chip */
+	outb(0xff, host->base + CTEST9_REG);
+	hostdata->rev = (inb(host->base + CTEST7_REG)<<4) & 0x0f;
+	hostdata->fast = (inb(host->base + CTEST9_REG) == 0);
+	if(banner == 0) {
+		printk(KERN_NOTICE "53c700: Version " NCR_700_VERSION " By James.Bottomley@HansenPartnership.com\n");
+		banner = 1;
+	}
+	printk(KERN_NOTICE "scsi%d: %s rev %d %s\n", host->host_no,
+	       hostdata->fast ? "53c700-66" : "53c700",
+	       hostdata->rev, hostdata->differential ?
+	       "(Differential)" : "");
+	/* reset the chip */
+	NCR_700_chip_reset(host);
+	outb(ASYNC_OPERATION , host->base + SXFER_REG);
+
+	return host;
+}
+
+int
+NCR_700_release(struct Scsi_Host *host)
+{
+	struct NCR_700_Host_Parameters *hostdata = 
+		(struct NCR_700_Host_Parameters *)host->hostdata[0];
+
+	kfree(hostdata->script);
+	return 1;
+}
+
+static inline __u8
+NCR_700_identify(int can_disconnect, __u8 lun)
+{
+	return IDENTIFY_BASE |
+		((can_disconnect) ? 0x40 : 0) |
+		(lun & NCR_700_LUN_MASK);
+}
+
+/*
+ * Function : static int datapath_residual (Scsi_Host *host)
+ *
+ * Purpose : return residual data count of what's in the chip.  If you
+ * really want to know what this function is doing, it's almost a
+ * direct transcription of the algorithm described in the 53c710
+ * guide, except that the DBC and DFIFO registers are only 6 bits
+ * wide.
+ *
+ * Inputs : host - SCSI host */
+static inline int
+NCR_700_data_residual (struct Scsi_Host *host) {
+	int count, synchronous;
+	unsigned int ddir;
+	
+	count = ((inb(host->base + DFIFO_REG) & 0x3f) -
+		 (inl(host->base + DBC_REG) & 0x3f)) & 0x3f;
+	
+	synchronous = inb(host->base + SXFER_REG) & 0x0f;
+	
+	/* get the data direction */
+	ddir = inb(host->base + CTEST0_REG) & 0x01;
+
+	if (ddir) {
+		/* Receive */
+		if (synchronous) 
+			count += (inb(host->base + SSTAT2_REG) & 0xf0) >> 4;
+		else
+			if (inb(host->base + SSTAT1_REG) & SIDL_REG_FULL)
+				++count;
+	} else {
+		/* Send */
+		__u8 sstat = inb(host->base + SSTAT1_REG);
+		if (sstat & SODL_REG_FULL)
+			++count;
+		if (synchronous && (sstat & SODR_REG_FULL))
+			++count;
+	}
+	return count;
+}
+
+/* print out the SCSI wires and corresponding phase from the SBCL register
+ * in the chip */
+static inline char *
+sbcl_to_string(__u8 sbcl)
+{
+	int i;
+	static char ret[256];
+
+	ret[0]='\0';
+	for(i=0; i<8; i++) {
+		if((1<<i) & sbcl) 
+			strcat(ret, NCR_700_SBCL_bits[i]);
+	}
+	strcat(ret, NCR_700_SBCL_to_phase[sbcl & 0x07]);
+	return ret;
+}
+
+static inline __u8
+bitmap_to_number(__u8 bitmap)
+{
+	__u8 i;
+
+	for(i=0; i<8 && !(bitmap &(1<<i)); i++)
+		;
+	return i;
+}
+
+/* Pull a slot off the free list */
+STATIC struct NCR_700_command_slot *
+find_empty_slot(struct NCR_700_Host_Parameters *hostdata)
+{
+	struct NCR_700_command_slot *slot = hostdata->free_list;
+
+	if(slot == NULL) {
+		/* sanity check */
+		if(hostdata->command_slot_count != NCR_700_COMMAND_SLOTS_PER_HOST)
+			printk(KERN_ERR "SLOTS FULL, but count is %d, should be %d\n", hostdata->command_slot_count, NCR_700_COMMAND_SLOTS_PER_HOST);
+		return NULL;
+	}
+
+	if(slot->state != NCR_700_SLOT_FREE)
+		/* should panic! */
+		printk(KERN_ERR "BUSY SLOT ON FREE LIST!!!\n");
+		
+
+	hostdata->free_list = slot->ITL_forw;
+	slot->ITL_forw = NULL;
+
+
+	/* NOTE: set the state to busy here, not queued, since this
+	 * indicates the slot is in use and cannot be run by the IRQ
+	 * finish routine.  If we cannot queue the command when it
+	 * is properly build, we then change to NCR_700_SLOT_QUEUED */
+	slot->state = NCR_700_SLOT_BUSY;
+	hostdata->command_slot_count++;
+	
+	return slot;
+}
+
+STATIC void 
+free_slot(struct NCR_700_command_slot *slot,
+	  struct NCR_700_Host_Parameters *hostdata)
+{
+	int hash;
+	struct NCR_700_command_slot **forw, **back;
+
+
+	if((slot->state & NCR_700_SLOT_MASK) != NCR_700_SLOT_MAGIC) {
+		printk(" SLOT %p is not MAGIC!!!\n", slot);
+	}
+	if(slot->state == NCR_700_SLOT_FREE) {
+		printk(" SLOT %p is FREE!!!\n", slot);
+	}
+	/* remove from queues */
+	if(slot->tag != NCR_700_NO_TAG) {
+		hash = hash_ITLQ(slot->cmnd->target, slot->cmnd->lun,
+				 slot->tag);
+		if(slot->ITLQ_forw == NULL)
+			back = &hostdata->ITLQ_Hash_back[hash];
+		else
+			back = &slot->ITLQ_forw->ITLQ_back;
+
+		if(slot->ITLQ_back == NULL)
+			forw = &hostdata->ITLQ_Hash_forw[hash];
+		else
+			forw = &slot->ITLQ_back->ITLQ_forw;
+
+		*forw = slot->ITLQ_forw;
+		*back = slot->ITLQ_back;
+	}
+	hash = hash_ITL(slot->cmnd->target, slot->cmnd->lun);
+	if(slot->ITL_forw == NULL)
+		back = &hostdata->ITL_Hash_back[hash];
+	else
+		back = &slot->ITL_forw->ITL_back;
+	
+	if(slot->ITL_back == NULL)
+		forw = &hostdata->ITL_Hash_forw[hash];
+	else
+		forw = &slot->ITL_back->ITL_forw;
+	
+	*forw = slot->ITL_forw;
+	*back = slot->ITL_back;
+	
+	slot->resume_offset = 0;
+	slot->cmnd = NULL;
+	slot->state = NCR_700_SLOT_FREE;
+	slot->ITL_forw = hostdata->free_list;
+	hostdata->free_list = slot;
+	hostdata->command_slot_count--;
+}
+
+
+/* This routine really does very little.  The command is indexed on
+   the ITL and (if tagged) the ITLQ lists in _queuecommand */
+STATIC void
+save_for_reselection(struct NCR_700_Host_Parameters *hostdata,
+		     Scsi_Cmnd *SCp, __u32 dsp)
+{
+	/* Its just possible that this gets executed twice */
+	if(SCp != NULL) {
+		struct NCR_700_command_slot *slot =
+			(struct NCR_700_command_slot *)SCp->host_scribble;
+
+		slot->resume_offset = dsp;
+	}
+	hostdata->state = NCR_700_HOST_FREE;
+	hostdata->cmd = NULL;
+}
+
+/* Most likely nexus is the oldest in each case */
+STATIC inline struct NCR_700_command_slot *
+find_ITL_Nexus(struct NCR_700_Host_Parameters *hostdata, __u8 pun, __u8 lun)
+{
+	int hash = hash_ITL(pun, lun);
+	struct NCR_700_command_slot *slot = hostdata->ITL_Hash_back[hash];
+	while(slot != NULL && !(slot->cmnd->target == pun &&
+				slot->cmnd->lun == lun))
+		slot = slot->ITL_back;
+	return slot;
+}
+
+STATIC inline struct NCR_700_command_slot *
+find_ITLQ_Nexus(struct NCR_700_Host_Parameters *hostdata, __u8 pun,
+		__u8 lun, __u8 tag)
+{
+	int hash = hash_ITLQ(pun, lun, tag);
+	struct NCR_700_command_slot *slot = hostdata->ITLQ_Hash_back[hash];
+
+	while(slot != NULL && !(slot->cmnd->target == pun 
+	      && slot->cmnd->lun == lun && slot->tag == tag))
+		slot = slot->ITLQ_back;
+
+#ifdef NCR_700_TAG_DEBUG
+	if(slot != NULL) {
+		struct NCR_700_command_slot *n = slot->ITLQ_back;
+		while(n != NULL && n->cmnd->target != pun
+		      && n->cmnd->lun != lun && n->tag != tag)
+			n = n->ITLQ_back;
+
+		if(n != NULL && n->cmnd->target == pun && n->cmnd->lun == lun
+		   && n->tag == tag) {
+			printk("\n\n**WARNING: DUPLICATE tag %d\n",
+			       tag);
+		}
+	}
+#endif
+	return slot;
+}
+
+
+
+/* This translates the SDTR message offset and period to a value
+ * which can be loaded into the SXFER_REG.
+ *
+ * NOTE: According to SCSI-2, the true transfer period is actually 
+ *       four times this period value (in ns) */
+STATIC inline __u8
+NCR_700_offset_period_to_sxfer(struct NCR_700_Host_Parameters *hostdata,
+			       __u8 offset, __u8 period)
+{
+	int XFERP;
+
+	XFERP = (period*4 * hostdata->clock)/1000 - 4;
+	if(offset > NCR_700_MAX_OFFSET) {
+		printk(KERN_WARNING "53c700: Offset %d exceeds maximum, setting to %d\n",
+		       offset, NCR_700_MAX_OFFSET);
+		offset = NCR_700_MAX_OFFSET;
+	}
+	if(XFERP < NCR_700_MIN_XFERP) {
+		printk(KERN_WARNING "53c700: XFERP %d is less than minium, setting to %d\n",
+		       XFERP,  NCR_700_MIN_XFERP);
+		XFERP =  NCR_700_MIN_XFERP;
+	}
+	return (offset & 0x0f) | (XFERP & 0x07)<<4;
+}
+	
+
+STATIC inline void
+NCR_700_scsi_done(struct NCR_700_Host_Parameters *hostdata,
+	       Scsi_Cmnd *SCp, int result)
+{
+	hostdata->state = NCR_700_HOST_FREE;
+	hostdata->cmd = NULL;
+
+	if(SCp != NULL) {
+		struct NCR_700_command_slot *slot = 
+			(struct NCR_700_command_slot *)SCp->host_scribble;
+
+		if(SCp->cmnd[0] == REQUEST_SENSE && SCp->cmnd[6] == NCR_700_INTERNAL_SENSE_MAGIC) {
+#ifdef NCR_700_DEBUG
+			printk(" ORIGINAL CMD %p RETURNED %d, new return is %d sense is",
+			       SCp, SCp->cmnd[7], result);
+			print_sense("53c700", SCp);
+#endif
+			if(result == 0)
+				result = SCp->cmnd[7];
+		}
+			
+		free_slot(slot, hostdata);
+
+		SCp->host_scribble = NULL;
+		SCp->result = result;
+		SCp->scsi_done(SCp);
+		if(NCR_700_get_depth(SCp->device) == 0 ||
+		   NCR_700_get_depth(SCp->device) > NCR_700_MAX_TAGS)
+			printk(KERN_ERR "Invalid depth in NCR_700_scsi_done(): %d\n",
+			       NCR_700_get_depth(SCp->device));
+		NCR_700_set_depth(SCp->device, NCR_700_get_depth(SCp->device) - 1);
+	} else {
+		printk(KERN_ERR "  SCSI DONE HAS NULL SCp\n");
+	}
+}
+
+
+STATIC void
+NCR_700_internal_bus_reset(struct Scsi_Host *host)
+{
+	/* Bus reset */
+	outb(ASSERT_RST, host->base + SCNTL1_REG);
+	udelay(50);
+	outb(0, host->base + SCNTL1_REG);
+
+}
+
+STATIC void
+NCR_700_chip_setup(struct Scsi_Host *host)
+{
+	struct NCR_700_Host_Parameters *hostdata = 
+		(struct NCR_700_Host_Parameters *)host->hostdata[0];
+
+	outb(1 << host->this_id, host->base + SCID_REG);
+	outb(0, host->base + SBCL_REG);
+	outb(0, host->base + SXFER_REG);
+
+	outb(PHASE_MM_INT | SEL_TIMEOUT_INT | GROSS_ERR_INT | UX_DISC_INT
+	     | RST_INT | PAR_ERR_INT | SELECT_INT, host->base + SIEN_REG);
+
+	outb(ABORT_INT | INT_INST_INT | ILGL_INST_INT, host->base + DIEN_REG);
+	outb(BURST_LENGTH_8, host->base + DMODE_REG);
+	outb(FULL_ARBITRATION | PARITY | AUTO_ATN, host->base + SCNTL0_REG);
+	outb(LAST_DIS_ENBL | ENABLE_ACTIVE_NEGATION|GENERATE_RECEIVE_PARITY,
+	     host->base + CTEST8_REG);
+	outb(ENABLE_SELECT, host->base + SCNTL1_REG);
+	if(hostdata->clock > 50)
+		printk(KERN_ERR "53c700: Clock speed %dMHz is too high: contact James.Bottomley@HansenPartnership.com to modify the divider\n", hostdata->clock);
+	/* Set the synchronous SCSI divider to 1 so we drive the
+	 * synchronous command clock at this speed */
+	outb(1, host->base + SBCL_REG);
+	/* set the clock bits to 0 which is a divider of 2 so the
+	 * async frequency is exactly half this speed */ 
+	outb(0x00, host->base + DCNTL_REG);
+}
+
+STATIC void
+NCR_700_chip_reset(struct Scsi_Host *host)
+{
+	/* Chip reset */
+	outb(SOFTWARE_RESET, host->base + DCNTL_REG);
+	udelay(100);
+
+	outb(0, host->base + DCNTL_REG);
+
+	mdelay(1000);
+
+	NCR_700_chip_setup(host);
+}
+
+/* The heart of the message processing engine is that the instruction
+ * immediately after the INT is the normal case (and so must be CLEAR
+ * ACK).  If we want to do something else, we call that routine in
+ * scripts and set temp to be the normal case + 8 (skipping the CLEAR
+ * ACK) so that the routine returns correctly to resume its activity
+ * */
+STATIC __u32
+process_extended_message(struct Scsi_Host *host, 
+			 struct NCR_700_Host_Parameters *hostdata,
+			 Scsi_Cmnd *SCp, __u32 dsp, __u32 dsps)
+{
+	__u32 resume_offset = dsp, temp = dsp + 8;
+	__u8 pun = 0xff, lun = 0xff;
+
+	if(SCp != NULL) {
+		pun = SCp->target;
+		lun = SCp->lun;
+	}
+
+	switch(hostdata->msgin[2]) {
+	case A_SDTR_MSG:
+		if(SCp != NULL && NCR_700_is_flag_set(SCp->device, NCR_700_DEV_BEGIN_SYNC_NEGOTIATION)) {
+			__u8 period = hostdata->msgin[3];
+			__u8 offset = hostdata->msgin[4];
+			__u8 sxfer;
+
+			if(offset != 0 && period != 0)
+				sxfer = NCR_700_offset_period_to_sxfer(hostdata, offset, period);
+			else 
+				sxfer = 0;
+			
+			if(sxfer != NCR_700_get_SXFER(SCp->device)) {
+				printk(KERN_INFO "scsi%d: (%d:%d) Synchronous at offset %d, period %dns\n",
+				       host->host_no, pun, lun,
+				       offset, period*4);
+				
+				NCR_700_set_SXFER(SCp->device, sxfer);
+			}
+			
+
+			NCR_700_set_flag(SCp->device, NCR_700_DEV_NEGOTIATED_SYNC);
+			NCR_700_clear_flag(SCp->device, NCR_700_DEV_BEGIN_SYNC_NEGOTIATION);
+			
+			outb(NCR_700_get_SXFER(SCp->device),
+			     host->base + SXFER_REG);
+
+		} else {
+			/* SDTR message out of the blue, reject it */
+			printk(KERN_WARNING "scsi%d Unexpected SDTR msg\n",
+			       host->host_no);
+			hostdata->msgout[0] = A_REJECT_MSG;
+			script_patch_16(hostdata->script, MessageCount, 1);
+			/* SendMsgOut returns, so set up the return
+			 * address */
+			resume_offset = hostdata->pScript + Ent_SendMessageWithATN;
+		}
+		break;
+	
+	case A_WDTR_MSG:
+		printk(KERN_INFO "scsi%d: (%d:%d), Unsolicited WDTR after CMD, Rejecting\n",
+		       host->host_no, pun, lun);
+		hostdata->msgout[0] = A_REJECT_MSG;
+		script_patch_16(hostdata->script, MessageCount, 1);
+		resume_offset = hostdata->pScript + Ent_SendMessageWithATN;
+
+		break;
+
+	default:
+		printk(KERN_INFO "scsi%d (%d:%d): Unexpected message %s: ",
+		       host->host_no, pun, lun,
+		       NCR_700_phase[(dsps & 0xf00) >> 8]);
+		print_msg(hostdata->msgin);
+		printk("\n");
+		/* just reject it */
+		hostdata->msgout[0] = A_REJECT_MSG;
+		script_patch_16(hostdata->script, MessageCount, 1);
+		/* SendMsgOut returns, so set up the return
+		 * address */
+		resume_offset = hostdata->pScript + Ent_SendMessageWithATN;
+	}
+	outl(temp, host->base + TEMP_REG);
+	return resume_offset;
+}
+
+STATIC __u32
+process_message(struct Scsi_Host *host,	struct NCR_700_Host_Parameters *hostdata,
+		Scsi_Cmnd *SCp, __u32 dsp, __u32 dsps)
+{
+	/* work out where to return to */
+	__u32 temp = dsp + 8, resume_offset = dsp;
+	__u8 pun = 0xff, lun = 0xff;
+
+	if(SCp != NULL) {
+		pun = SCp->target;
+		lun = SCp->lun;
+	}
+
+#ifdef NCR_700_DEBUG
+	printk("scsi%d (%d:%d): message %s: ", host->host_no, pun, lun,
+	       NCR_700_phase[(dsps & 0xf00) >> 8]);
+	print_msg(hostdata->msgin);
+	printk("\n");
+#endif
+
+	switch(hostdata->msgin[0]) {
+
+	case A_EXTENDED_MSG:
+		return process_extended_message(host, hostdata, SCp,
+						dsp, dsps);
+
+	case A_REJECT_MSG:
+		if(SCp != NULL && NCR_700_is_flag_set(SCp->device, NCR_700_DEV_BEGIN_SYNC_NEGOTIATION)) {
+			/* Rejected our sync negotiation attempt */
+			NCR_700_set_SXFER(SCp->device, 0);
+			NCR_700_set_flag(SCp->device, NCR_700_DEV_NEGOTIATED_SYNC);
+			NCR_700_clear_flag(SCp->device, NCR_700_DEV_BEGIN_SYNC_NEGOTIATION);
+		} else {
+			printk(KERN_WARNING "scsi%d (%d:%d) Unexpected REJECT Message %s\n",
+			       host->host_no, pun, lun,
+			       NCR_700_phase[(dsps & 0xf00) >> 8]);
+			/* however, just ignore it */
+		}
+		break;
+
+	case A_PARITY_ERROR_MSG:
+		printk("scsi%d (%d:%d) Parity Error!\n", host->host_no,
+		       pun, lun);
+		NCR_700_internal_bus_reset(host);
+		break;
+	case A_SIMPLE_TAG_MSG:
+		printk("scsi%d (%d:%d) SIMPLE TAG %d %s\n", host->host_no,
+		       pun, lun, hostdata->msgin[1],
+		       NCR_700_phase[(dsps & 0xf00) >> 8]);
+		/* just ignore it */
+		break;
+	default:
+		printk(KERN_INFO "scsi%d (%d:%d): Unexpected message %s: ",
+		       host->host_no, pun, lun,
+		       NCR_700_phase[(dsps & 0xf00) >> 8]);
+
+		print_msg(hostdata->msgin);
+		printk("\n");
+		/* just reject it */
+		hostdata->msgout[0] = A_REJECT_MSG;
+		script_patch_16(hostdata->script, MessageCount, 1);
+		/* SendMsgOut returns, so set up the return
+		 * address */
+		resume_offset = hostdata->pScript + Ent_SendMessageWithATN;
+
+		break;
+	}
+	outl(temp, host->base + TEMP_REG);
+	return resume_offset;
+}
+
+STATIC __u32
+process_script_interrupt(__u32 dsps, __u32 dsp, Scsi_Cmnd *SCp,
+			 struct Scsi_Host *host,
+			 struct NCR_700_Host_Parameters *hostdata)
+{
+	__u32 resume_offset = 0;
+	__u8 pun = 0xff, lun=0xff;
+
+	if(SCp != NULL) {
+		pun = SCp->target;
+		lun = SCp->lun;
+	}
+
+	if(dsps == A_GOOD_STATUS_AFTER_STATUS) {
+		DEBUG(("  COMMAND COMPLETE, status=%02x\n",
+		       hostdata->status));
+		/* check for contingent allegiance contitions */
+		if(status_byte(hostdata->status) == CHECK_CONDITION ||
+		   status_byte(hostdata->status) == COMMAND_TERMINATED) {
+			struct NCR_700_command_slot *slot =
+				(struct NCR_700_command_slot *)SCp->host_scribble;
+
+			DEBUG(("  cmd %p has status %d, requesting sense\n",
+			       SCp, hostdata->status));
+			/* we can destroy the command here because the
+			 * contingent allegiance condition will cause a 
+			 * retry which will re-copy the command from the
+			 * saved data_cmnd */
+			SCp->cmnd[0] = REQUEST_SENSE;
+			SCp->cmnd[1] = (SCp->lun & 0x7) << 5;
+			SCp->cmnd[2] = 0;
+			SCp->cmnd[3] = 0;
+			SCp->cmnd[4] = sizeof(SCp->sense_buffer);
+			SCp->cmnd[5] = 0;
+			SCp->cmd_len = 6;
+			/* Here's a quiet hack: the REQUEST_SENSE command is
+			 * six bytes, so store a flag indicating that this
+			 * was an internal sense request and the original
+			 * status at the end of the command */
+			SCp->cmnd[6] = NCR_700_INTERNAL_SENSE_MAGIC;
+			SCp->cmnd[7] = hostdata->status;
+			slot->SG[0].ins = SCRIPT_MOVE_DATA_IN | sizeof(SCp->sense_buffer);
+			slot->SG[0].pAddr = virt_to_bus(SCp->sense_buffer);
+			slot->SG[1].ins = SCRIPT_RETURN;
+			slot->SG[1].pAddr = 0;
+			slot->resume_offset = hostdata->pScript;
+			
+			/* queue the command for reissue */
+			slot->state = NCR_700_SLOT_QUEUED;
+			hostdata->state = NCR_700_HOST_FREE;
+			hostdata->cmd = NULL;
+		} else {
+			if(status_byte(hostdata->status) == GOOD &&
+			   SCp->cmnd[0] == INQUIRY && SCp->use_sg == 0) {
+				/* Piggy back the tag queueing support
+				 * on this command */
+				if(((char *)SCp->request_buffer)[7] & 0x02) {
+					printk(KERN_INFO "scsi%d: (%d:%d) Enabling Tag Command Queuing\n", host->host_no, pun, lun);
+					hostdata->tag_negotiated |= (1<<SCp->target);
+				} else {
+					hostdata->tag_negotiated &= ~(1<<SCp->target);
+				}
+			}
+			NCR_700_scsi_done(hostdata, SCp, hostdata->status);
+		}
+	} else if((dsps & 0xfffff0f0) == A_UNEXPECTED_PHASE) {
+		__u8 i = (dsps & 0xf00) >> 8;
+
+		printk(KERN_ERR "scsi%d: (%d:%d), UNEXPECTED PHASE %s (%s)\n",
+		       host->host_no, pun, lun,
+		       NCR_700_phase[i],
+		       sbcl_to_string(inb(host->base + SBCL_REG)));
+		printk("         len = %d, cmd =", SCp->cmd_len);
+		print_command(SCp->cmnd);
+
+		NCR_700_internal_bus_reset(host);
+	} else if((dsps & 0xfffff000) == A_FATAL) {
+		int i = (dsps & 0xfff);
+
+		printk(KERN_ERR "scsi%d: (%d:%d) FATAL ERROR: %s\n",
+		       host->host_no, pun, lun, NCR_700_fatal_messages[i]);
+		if(dsps == A_FATAL_ILLEGAL_MSG_LENGTH) {
+			printk(KERN_ERR "     msg begins %02x %02x\n",
+			       hostdata->msgin[0], hostdata->msgin[1]);
+		}
+		NCR_700_internal_bus_reset(host);
+	} else if((dsps & 0xfffff0f0) == A_DISCONNECT) {
+#ifdef NCR_700_DEBUG
+		__u8 i = (dsps & 0xf00) >> 8;
+
+		printk("scsi%d: (%d:%d), DISCONNECTED (%d) %s\n",
+		       host->host_no, pun, lun,
+		       i, NCR_700_phase[i]);
+#endif
+		save_for_reselection(hostdata, SCp, dsp);
+
+	} else if(dsps == A_RESELECTION_IDENTIFIED) {
+		__u8 lun = hostdata->msgin[0] & 0x1f;
+		struct NCR_700_command_slot *slot;
+		__u8 reselection_id = hostdata->reselection_id;
+
+		hostdata->reselection_id = 0xff;
+		DEBUG(("scsi%d: (%d:%d) RESELECTED!\n",
+		       host->host_no, reselection_id, lun));
+		/* clear the reselection indicator */
+		if(hostdata->msgin[1] == A_SIMPLE_TAG_MSG) {
+			slot = find_ITLQ_Nexus(hostdata, reselection_id,
+					       lun, hostdata->msgin[2]);
+		} else {
+			slot = find_ITL_Nexus(hostdata, reselection_id, lun);
+		}
+	retry:
+		if(slot == NULL) {
+			struct NCR_700_command_slot *s = find_ITL_Nexus(hostdata, reselection_id, lun);
+			printk(KERN_ERR "scsi%d: (%d:%d) RESELECTED but no saved command (MSG = %02x %02x %02x)!!\n",
+			       host->host_no, reselection_id, lun,
+			       hostdata->msgin[0], hostdata->msgin[1],
+			       hostdata->msgin[2]);
+			printk(KERN_ERR " OUTSTANDING TAGS:");
+			while(s != NULL) {
+				if(s->cmnd->target == reselection_id &&
+				   s->cmnd->lun == lun) {
+					printk("%d ", s->tag);
+					if(s->tag == hostdata->msgin[2]) {
+						printk(" ***FOUND*** \n");
+						slot = s;
+						goto retry;
+					}
+						
+				}
+				s = s->ITL_back;
+			}
+			printk("\n");
+		} else {
+			if(hostdata->state != NCR_700_HOST_BUSY)
+				printk(KERN_ERR "scsi%d: FATAL, host not busy during valid reselection!\n",
+				       host->host_no);
+			resume_offset = slot->resume_offset;
+			hostdata->cmd = slot->cmnd;
+
+			/* re-patch for this command */
+			script_patch_32_abs(hostdata->script, CommandAddress, 
+					    virt_to_bus(slot->cmnd->cmnd));
+			script_patch_16(hostdata->script,
+					CommandCount, slot->cmnd->cmd_len);
+			script_patch_32_abs(hostdata->script, SGScriptStartAddress,
+					    virt_to_bus(&slot->SG[0].ins));
+
+			/* Note: setting SXFER only works if we're
+			 * still in the MESSAGE phase, so it is vital
+			 * that ACK is still asserted when we process
+			 * the reselection message.  The resume offset
+			 * should therefore always clear ACK */
+			outb(NCR_700_get_SXFER(hostdata->cmd->device),
+			     host->base + SXFER_REG);
+			
+		}
+	} else if(dsps == A_RESELECTED_DURING_SELECTION) {
+
+		/* This section is full of debugging code because I've
+		 * never managed to reach it.  I think what happens is
+		 * that, because the 700 runs with selection
+		 * interrupts enabled the whole time that we take a
+		 * selection interrupt before we manage to get to the
+		 * reselected script interrupt */
+
+		__u8 reselection_id = inb(host->base + SFBR_REG);
+		struct NCR_700_command_slot *slot;
+		
+		/* Take out our own ID */
+		reselection_id &= ~(1<<host->this_id);
+		
+		printk("scsi%d: (%d:%d) RESELECTION DURING SELECTION, dsp=%p[%04x] state=%d, count=%d\n",
+		       host->host_no, reselection_id, lun, (void *)dsp, dsp - hostdata->pScript, hostdata->state, hostdata->command_slot_count);
+
+		{
+			/* FIXME: DEBUGGING CODE */
+			__u32 SG = (__u32)bus_to_virt(hostdata->script[A_SGScriptStartAddress_used[0]]);
+			int i;
+
+			for(i=0; i< NCR_700_COMMAND_SLOTS_PER_HOST; i++) {
+				if(SG >= (__u32)(&hostdata->slots[i].SG[0])
+				   && SG <= (__u32)(&hostdata->slots[i].SG[NCR_700_SG_SEGMENTS]))
+					break;
+			}
+			printk("IDENTIFIED SG segment as being %p in slot %p, cmd %p, slot->resume_offset=%p\n", (void *)SG, &hostdata->slots[i], hostdata->slots[i].cmnd, (void *)hostdata->slots[i].resume_offset);
+			SCp =  hostdata->slots[i].cmnd;
+		}
+
+		if(SCp != NULL) {
+			slot = (struct NCR_700_command_slot *)SCp->host_scribble;
+			/* change slot from busy to queued to redo command */
+			slot->state = NCR_700_SLOT_QUEUED;
+		}
+		hostdata->cmd = NULL;
+		
+		if(reselection_id == 0) {
+			if(hostdata->reselection_id == 0xff) {
+				printk(KERN_ERR "scsi%d: Invalid reselection during selection!!\n", host->host_no);
+				return 0;
+			} else {
+				printk(KERN_ERR "scsi%d: script reselected and we took a selection interrupt\n",
+				       host->host_no);
+				reselection_id = hostdata->reselection_id;
+			}
+		} else {
+			
+			/* convert to real ID */
+			reselection_id = bitmap_to_number(reselection_id);
+		}
+		hostdata->reselection_id = reselection_id;
+		hostdata->msgin[1] = 0;
+		if(hostdata->tag_negotiated & (1<<reselection_id)) {
+			resume_offset = hostdata->pScript + Ent_GetReselectionWithTag;
+		} else {
+			resume_offset = hostdata->pScript + Ent_GetReselectionData;
+		}
+	} else if(dsps == A_COMPLETED_SELECTION_AS_TARGET) {
+		/* we've just disconnected from the bus, do nothing since
+		 * a return here will re-run the queued command slot
+		 * that may have been interrupted by the initial selection */
+		DEBUG((" SELECTION COMPLETED\n"));
+	} else if((dsps & 0xfffff0f0) == A_MSG_IN) { 
+		resume_offset = process_message(host, hostdata, SCp,
+						dsp, dsps);
+	} else if((dsps &  0xfffff000) == 0) {
+		__u8 i = (dsps & 0xf0) >> 4, j = (dsps & 0xf00) >> 8;
+		printk(KERN_ERR "scsi%d: (%d:%d), unhandled script condition %s %s at %04x\n",
+		       host->host_no, pun, lun, NCR_700_condition[i],
+		       NCR_700_phase[j], dsp - hostdata->pScript);
+		if(SCp != NULL) {
+			print_command(SCp->cmnd);
+
+			if(SCp->use_sg) {
+				for(i = 0; i < SCp->use_sg + 1; i++) {
+					printk(" SG[%d].length = %d, move_insn=%08x, addr %08x\n", i, ((struct scatterlist *)SCp->buffer)[i].length, ((struct NCR_700_command_slot *)SCp->host_scribble)->SG[i].ins, ((struct NCR_700_command_slot *)SCp->host_scribble)->SG[i].pAddr);
+				}
+			}
+		}	       
+		NCR_700_internal_bus_reset(host);
+	} else if((dsps & 0xfffff000) == A_DEBUG_INTERRUPT) {
+		printk("scsi%d (%d:%d) DEBUG INTERRUPT %d AT %p[%04x], continuing\n",
+		       host->host_no, pun, lun, dsps & 0xfff, (void *)dsp, dsp - hostdata->pScript);
+		resume_offset = dsp;
+	} else {
+		printk(KERN_ERR "scsi%d: (%d:%d), unidentified script interrupt 0x%x at %04x\n",
+		       host->host_no, pun, lun, dsps, dsp - hostdata->pScript);
+		NCR_700_internal_bus_reset(host);
+	}
+	return resume_offset;
+}
+
+/* We run the 53c700 with selection interrupts always enabled.  This
+ * means that the chip may be selected as soon as the bus frees.  On a
+ * busy bus, this can be before the scripts engine finishes its
+ * processing.  Therefore, part of the selection processing has to be
+ * to find out what the scripts engine is doing and complete the
+ * function if necessary (i.e. process the pending disconnect or save
+ * the interrupted initial selection */
+STATIC inline __u32
+process_selection(struct Scsi_Host *host, __u32 dsp)
+{
+	__u8 id;
+	int count = 0;
+	__u32 resume_offset = 0;
+	struct NCR_700_Host_Parameters *hostdata =
+		(struct NCR_700_Host_Parameters *)host->hostdata[0];
+	Scsi_Cmnd *SCp = hostdata->cmd;
+	__u8 sbcl;
+
+	for(count = 0; count < 5; count++) {
+		id = inb(host->base + SFBR_REG);
+
+		/* Take out our own ID */
+		id &= ~(1<<host->this_id);
+		if(id != 0) 
+			break;
+		udelay(5);
+	}
+	sbcl = inb(host->base + SBCL_REG);
+	if((sbcl & SBCL_IO) == 0) {
+		/* mark as having been selected rather than reselected */
+		id = 0xff;
+	} else {
+		/* convert to real ID */
+		hostdata->reselection_id = id = bitmap_to_number(id);
+		DEBUG(("scsi%d:  Reselected by %d\n",
+		       host->host_no, id));
+	}
+	if(hostdata->state == NCR_700_HOST_BUSY && SCp != NULL) {
+		struct NCR_700_command_slot *slot =
+			(struct NCR_700_command_slot *)SCp->host_scribble;
+		DEBUG(("  ID %d WARNING: RESELECTION OF BUSY HOST, saving cmd %p, slot %p, addr %p [%04x], resume %p!\n", id, hostdata->cmd, slot, dsp, dsp - hostdata->pScript, resume_offset));
+		
+		switch(dsp - hostdata->pScript) {
+		case Ent_Disconnect1:
+		case Ent_Disconnect2:
+			save_for_reselection(hostdata, SCp, Ent_Disconnect2 + hostdata->pScript);
+			break;
+		case Ent_Disconnect3:
+		case Ent_Disconnect4:
+			save_for_reselection(hostdata, SCp, Ent_Disconnect4 + hostdata->pScript);
+			break;
+		case Ent_Disconnect5:
+		case Ent_Disconnect6:
+			save_for_reselection(hostdata, SCp, Ent_Disconnect6 + hostdata->pScript);
+			break;
+		case Ent_Disconnect7:
+		case Ent_Disconnect8:
+			save_for_reselection(hostdata, SCp, Ent_Disconnect8 + hostdata->pScript);
+			break;
+		case Ent_Finish1:
+		case Ent_Finish2:
+			process_script_interrupt(A_GOOD_STATUS_AFTER_STATUS, dsp, SCp, host, hostdata);
+			break;
+			
+		default:
+			slot->state = NCR_700_SLOT_QUEUED;
+			break;
+			}
+	}
+	hostdata->state = NCR_700_HOST_BUSY;
+	hostdata->cmd = NULL;
+	hostdata->msgin[1] = 0;
+
+	if(id == 0xff) {
+		/* Selected as target, Ignore */
+		resume_offset = hostdata->pScript + Ent_SelectedAsTarget;
+	} else if(hostdata->tag_negotiated & (1<<id)) {
+		resume_offset = hostdata->pScript + Ent_GetReselectionWithTag;
+	} else {
+		resume_offset = hostdata->pScript + Ent_GetReselectionData;
+	}
+	return resume_offset;
+}
+
+
+STATIC int
+NCR_700_start_command(Scsi_Cmnd *SCp)
+{
+	struct NCR_700_command_slot *slot =
+		(struct NCR_700_command_slot *)SCp->host_scribble;
+	struct NCR_700_Host_Parameters *hostdata =
+		(struct NCR_700_Host_Parameters *)SCp->host->hostdata[0];
+	unsigned long flags;
+	__u16 count = 1;	/* for IDENTIFY message */
+	
+	save_flags(flags);
+	cli();
+	if(hostdata->state != NCR_700_HOST_FREE) {
+		/* keep this inside the lock to close the race window where
+		 * the running command finishes on another CPU while we don't
+		 * change the state to queued on this one */
+		slot->state = NCR_700_SLOT_QUEUED;
+		restore_flags(flags);
+
+		DEBUG(("scsi%d: host busy, queueing command %p, slot %p\n",
+		       SCp->host->host_no, slot->cmnd, slot));
+		return 0;
+	}
+	hostdata->state = NCR_700_HOST_BUSY;
+	hostdata->cmd = SCp;
+	slot->state = NCR_700_SLOT_BUSY;
+	/* keep interrupts disabled until we have the command correctly
+	 * set up so we cannot take a selection interrupt */
+
+	hostdata->msgout[0] = NCR_700_identify(SCp->cmnd[0] != REQUEST_SENSE,
+					    SCp->lun);
+	/* for INQUIRY or REQUEST_SENSE commands, we cannot be sure
+	 * if the negotiated transfer parameters still hold, so
+	 * always renegotiate them */
+	if(SCp->cmnd[0] == INQUIRY || SCp->cmnd[0] == REQUEST_SENSE) {
+		NCR_700_clear_flag(SCp->device, NCR_700_DEV_NEGOTIATED_SYNC);
+	}
+
+	/* REQUEST_SENSE is asking for contingent I_T_L status.  If a
+	 * contingent allegiance condition exists, the device will
+	 * refuse all tags, so send the request sense as untagged */
+	if((hostdata->tag_negotiated & (1<<SCp->target))
+	   && (slot->tag != NCR_700_NO_TAG && SCp->cmnd[0] != REQUEST_SENSE)) {
+		hostdata->msgout[count++] = A_SIMPLE_TAG_MSG;
+		hostdata->msgout[count++] = slot->tag;
+	}
+
+	if(hostdata->fast &&
+	   NCR_700_is_flag_clear(SCp->device, NCR_700_DEV_NEGOTIATED_SYNC)) {
+		memcpy(&hostdata->msgout[count], NCR_700_SDTR_msg,
+		       sizeof(NCR_700_SDTR_msg));
+		count += sizeof(NCR_700_SDTR_msg);
+		NCR_700_set_flag(SCp->device, NCR_700_DEV_BEGIN_SYNC_NEGOTIATION);
+	}
+
+	script_patch_16(hostdata->script, MessageCount, count);
+
+
+	script_patch_ID(hostdata->script,
+			Device_ID, 1<<SCp->target);
+
+	script_patch_32_abs(hostdata->script, CommandAddress, 
+			virt_to_bus(SCp->cmnd));
+	script_patch_16(hostdata->script, CommandCount, SCp->cmd_len);
+	/* finally plumb the beginning of the SG list into the script
+	 * */
+	script_patch_32_abs(hostdata->script, SGScriptStartAddress,
+			    virt_to_bus(&slot->SG[0].ins));
+	outb(CLR_FIFO, SCp->host->base + DFIFO_REG);
+
+	/* set the synchronous period/offset */
+	if(slot->resume_offset == 0)
+		slot->resume_offset = hostdata->pScript;
+	outb(NCR_700_get_SXFER(SCp->device),
+	     SCp->host->base + SXFER_REG);
+	/* allow interrupts here so that if we're selected we can take
+	 * a selection interrupt.  The script start may not be
+	 * effective in this case, but the selection interrupt will
+	 * save our command in that case */
+	outl(slot->temp, SCp->host->base + TEMP_REG);
+	outl(slot->resume_offset, SCp->host->base + DSP_REG);
+	restore_flags(flags);
+
+	return 1;
+}
+
+void
+NCR_700_intr(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct Scsi_Host *host = (struct Scsi_Host *)dev_id;
+	struct NCR_700_Host_Parameters *hostdata =
+		(struct NCR_700_Host_Parameters *)host->hostdata[0];
+	__u8 istat;
+	__u32 resume_offset = 0;
+	__u8 pun = 0xff, lun = 0xff;
+	unsigned long flags;
+
+	/* Unfortunately, we have to take the io_request_lock here
+	 * rather than the host lock hostdata->lock because we're
+	 * looking to exclude queuecommand from messing with the
+	 * registers while we're processing the interrupt.  Since
+	 * queuecommand is called holding io_request_lock, and we have
+	 * to take io_request_lock before we call the command
+	 * scsi_done, we would get a deadlock if we took
+	 * hostdata->lock here and in queuecommand (because the order
+	 * of locking in queuecommand: 1) io_request_lock then 2)
+	 * hostdata->lock would be the reverse of taking it in this
+	 * routine */
+	spin_lock_irqsave(&io_request_lock, flags);
+	if((istat = inb(host->base + ISTAT_REG))
+	      & (SCSI_INT_PENDING | DMA_INT_PENDING)) {
+		__u32 dsps;
+		__u8 sstat0 = 0, dstat = 0;
+		__u32 dsp;
+		Scsi_Cmnd *SCp = hostdata->cmd;
+		enum NCR_700_Host_State state;
+
+		state = hostdata->state;
+		SCp = hostdata->cmd;
+
+		if(istat & SCSI_INT_PENDING) {
+			udelay(10);
+
+			sstat0 = inb(host->base + SSTAT0_REG);
+		}
+
+		if(istat & DMA_INT_PENDING) {
+			udelay(10);
+
+			dstat = inb(host->base + DSTAT_REG);
+		}
+
+		dsps = inl(host->base + DSPS_REG);
+		dsp = inl(host->base + DSP_REG);
+
+		DEBUG(("scsi%d: istat %02x sstat0 %02x dstat %02x dsp %04x[%08lx] dsps 0x%x\n",
+		       host->host_no, istat, sstat0, dstat,
+		       (dsp - (__u32)virt_to_bus(hostdata->script))/4,
+		       dsp, dsps));
+
+		if(SCp != NULL) {
+			pun = SCp->target;
+			lun = SCp->lun;
+		}
+
+		if(sstat0 & SCSI_RESET_DETECTED) {
+			Scsi_Device *SDp;
+			int i;
+
+			hostdata->state = NCR_700_HOST_BUSY;
+
+			printk(KERN_ERR "scsi%d: Bus Reset detected, executing command %p, slot %p, dsp %p[%04x]\n",
+			       host->host_no, SCp, SCp == NULL ? NULL : SCp->host_scribble, (void *)dsp, dsp - hostdata->pScript);
+
+			/* clear all the negotiated parameters */
+			for(SDp = host->host_queue; SDp != NULL; SDp = SDp->next)
+				SDp->hostdata = 0;
+			
+			/* clear all the slots and their pending commands */
+			for(i = 0; i < NCR_700_COMMAND_SLOTS_PER_HOST; i++) {
+				Scsi_Cmnd *SCp;
+				struct NCR_700_command_slot *slot =
+					&hostdata->slots[i];
+
+				if(slot->state == NCR_700_SLOT_FREE)
+					continue;
+				
+				SCp = slot->cmnd;
+				printk(KERN_ERR " failing command because of reset, slot %p, cmnd %p\n",
+				       slot, SCp);
+				free_slot(slot, hostdata);
+				SCp->host_scribble = NULL;
+				NCR_700_set_depth(SCp->device, 0);
+				/* NOTE: deadlock potential here: we
+				 * rely on mid-layer guarantees that
+				 * scsi_done won't try to issue the
+				 * command again otherwise we'll
+				 * deadlock on the
+				 * hostdata->state_lock */
+				SCp->result = DID_RESET << 16;
+				SCp->scsi_done(SCp);
+			}
+			mdelay(25);
+			NCR_700_chip_setup(host);
+
+			hostdata->state = NCR_700_HOST_FREE;
+			hostdata->cmd = NULL;
+			goto out_unlock;
+		} else if(sstat0 & SELECTION_TIMEOUT) {
+			DEBUG(("scsi%d: (%d:%d) selection timeout\n",
+			       host->host_no, pun, lun));
+			NCR_700_scsi_done(hostdata, SCp, DID_NO_CONNECT<<16);
+		} else if(sstat0 & PHASE_MISMATCH) {
+			struct NCR_700_command_slot *slot = (SCp == NULL) ? NULL :
+				(struct NCR_700_command_slot *)SCp->host_scribble;
+
+			if(dsp == Ent_SendMessage + 8 + hostdata->pScript) {
+				/* It wants to reply to some part of
+				 * our message */
+				__u32 temp = inl(host->base + TEMP_REG);
+
+				int count = (hostdata->script[Ent_SendMessage/4] & 0xffffff) - ((inl(host->base + DBC_REG) & 0xffffff) + NCR_700_data_residual(host));
+				printk("scsi%d (%d:%d) PHASE MISMATCH IN SEND MESSAGE %d remain, return %p[%04x], phase %s\n", host->host_no, pun, lun, count, (void *)temp, temp - hostdata->pScript, sbcl_to_string(inb(host->base + SBCL_REG)));
+				resume_offset = hostdata->pScript + Ent_SendMessagePhaseMismatch;
+			} else if(dsp >= virt_to_bus(&slot->SG[0].ins) &&
+				  dsp <= virt_to_bus(&slot->SG[NCR_700_SG_SEGMENTS].ins)) {
+				int data_transfer = inl(host->base + DBC_REG) & 0xffffff;
+				int SGcount = (dsp - virt_to_bus(&slot->SG[0].ins))/sizeof(struct NCR_700_SG_List);
+				int residual = NCR_700_data_residual(host);
+				int i;
+#ifdef NCR_700_DEBUG
+				printk("scsi%d: (%d:%d) Expected phase mismatch in slot->SG[%d], transferred 0x%x\n",
+				       host->host_no, pun, lun,
+				       SGcount, data_transfer);
+				print_command(SCp->cmnd);
+				if(residual) {
+					printk("scsi%d: (%d:%d) Expected phase mismatch in slot->SG[%d], transferred 0x%x, residual %d\n",
+				       host->host_no, pun, lun,
+				       SGcount, data_transfer, residual);
+				}
+#endif
+				data_transfer += residual;
+
+				if(data_transfer != 0) {
+					int count; 
+					SGcount--;
+
+					count = (slot->SG[SGcount].ins & 0x00ffffff);
+					DEBUG(("DATA TRANSFER MISMATCH, count = %d, transferred %d\n", count, count-data_transfer));
+					slot->SG[SGcount].ins &= 0xff000000;
+					slot->SG[SGcount].ins |= data_transfer;
+					slot->SG[SGcount].pAddr += (count - data_transfer);
+				}
+				/* set the executed moves to nops */
+				for(i=0; i<SGcount; i++) {
+					slot->SG[i].ins = SCRIPT_NOP;
+					slot->SG[i].pAddr = 0;
+				}
+				/* and pretend we disconnected after
+				 * the command phase */
+				resume_offset = hostdata->pScript + Ent_MsgInDuringData;
+			} else {
+				__u8 sbcl = inb(host->base + SBCL_REG);
+				printk(KERN_ERR "scsi%d: (%d:%d) phase mismatch at %04x, phase %s\n",
+				       host->host_no, pun, lun, dsp - hostdata->pScript, sbcl_to_string(sbcl));
+				NCR_700_internal_bus_reset(host);
+			}
+
+		} else if(sstat0 & SCSI_GROSS_ERROR) {
+			printk(KERN_ERR "scsi%d: (%d:%d) GROSS ERROR\n",
+			       host->host_no, pun, lun);
+			NCR_700_scsi_done(hostdata, SCp, DID_ERROR<<16);
+		} else if(dstat & SCRIPT_INT_RECEIVED) {
+			DEBUG(("scsi%d: (%d:%d) ====>SCRIPT INTERRUPT<====\n",
+			       host->host_no, pun, lun));
+			resume_offset = process_script_interrupt(dsps, dsp, SCp, host, hostdata);
+		} else if(dstat & (ILGL_INST_DETECTED)) {
+			printk(KERN_ERR "scsi%d: (%d:%d) Illegal Instruction detected at 0x%p[0x%x]!!!\n"
+			       "         Please email James.Bottomley@HansenPartnership.com with the details\n",
+			       host->host_no, pun, lun,
+			       (void *)dsp, dsp - hostdata->pScript);
+			NCR_700_scsi_done(hostdata, SCp, DID_ERROR<<16);
+		} else if(dstat & (WATCH_DOG_INTERRUPT|ABORTED)) {
+			printk(KERN_ERR "scsi%d: (%d:%d) serious DMA problem, dstat=%02x\n",
+			       host->host_no, pun, lun, dstat);
+			NCR_700_scsi_done(hostdata, SCp, DID_ERROR<<16);
+		}
+
+		
+		/* NOTE: selection interrupt processing MUST occur
+		 * after script interrupt processing to correctly cope
+		 * with the case where we process a disconnect and
+		 * then get reselected before we process the
+		 * disconnection */
+		if(sstat0 & SELECTED) {
+			/* FIXME: It currently takes at least FOUR
+			 * interrupts to complete a command that
+			 * disconnects: one for the disconnect, one
+			 * for the reselection, one to get the
+			 * reselection data and one to complete the
+			 * command.  If we guess the reselected
+			 * command here and prepare it, we only need
+			 * to get a reselection data interrupt if we
+			 * guessed wrongly.  Since the interrupt
+			 * overhead is much greater than the command
+			 * setup, this would be an efficient
+			 * optimisation particularly as we probably
+			 * only have one outstanding command on a
+			 * target most of the time */
+
+			resume_offset = process_selection(host, dsp);
+
+		}
+
+	}
+
+	if(resume_offset) {
+		if(hostdata->state != NCR_700_HOST_BUSY) {
+			printk(KERN_ERR "scsi%d: Driver error: resume at %p [%04x] with non busy host!\n",
+			       host->host_no, (void *)resume_offset, resume_offset - hostdata->pScript);
+			hostdata->state = NCR_700_HOST_BUSY;
+		}
+
+		DEBUG(("Attempting to resume at %x\n", resume_offset));
+		outb(CLR_FIFO, host->base + DFIFO_REG);
+		outl(resume_offset, host->base + DSP_REG);
+	} 
+	/* There is probably a technical no-no about this: If we're a
+	 * shared interrupt and we got this interrupt because the
+	 * other device needs servicing not us, we're still going to
+	 * check our queued commands here---of course, there shouldn't
+	 * be any outstanding.... */
+	if(hostdata->state == NCR_700_HOST_FREE) {
+		int i;
+
+		for(i = 0; i < NCR_700_COMMAND_SLOTS_PER_HOST; i++) {
+			/* fairness: always run the queue from the last
+			 * position we left off */
+			int j = (i + hostdata->saved_slot_position)
+				% NCR_700_COMMAND_SLOTS_PER_HOST;
+			
+			if(hostdata->slots[j].state != NCR_700_SLOT_QUEUED)
+				continue;
+			if(NCR_700_start_command(hostdata->slots[j].cmnd)) {
+				DEBUG(("scsi%d: Issuing saved command slot %p, cmd %p\t\n",
+				       host->host_no, &hostdata->slots[j],
+				       hostdata->slots[j].cmnd));
+				hostdata->saved_slot_position = j + 1;
+			}
+
+			break;
+		}
+	}
+ out_unlock:
+	spin_unlock_irqrestore(&io_request_lock, flags);
+}
+
+/* FIXME: Need to put some proc information in and plumb it
+ * into the scsi proc system */
+STATIC int
+NCR_700_proc_directory_info(char *proc_buf, char **startp,
+			 off_t offset, int bytes_available,
+			 int host_no, int write)
+{
+	static char buf[4096];	/* 1 page should be sufficient */
+	int len = 0;
+	struct Scsi_Host *host = scsi_hostlist;
+	struct NCR_700_Host_Parameters *hostdata;
+	Scsi_Device *SDp;
+
+	while(host != NULL && host->host_no != host_no)
+		host = host->next;
+
+	if(host == NULL)
+		return 0;
+
+	if(write) {
+		/* FIXME: Clear internal statistics here */
+		return 0;
+	}
+	hostdata = (struct NCR_700_Host_Parameters *)host->hostdata[0];
+	len += sprintf(&buf[len], "Total commands outstanding: %d\n", hostdata->command_slot_count);
+	len += sprintf(&buf[len],"\
+Target	Depth  Active  Next Tag\n\
+======	=====  ======  ========\n");
+	for(SDp = host->host_queue; SDp != NULL; SDp = SDp->next) {
+		len += sprintf(&buf[len],"%2d:%2d  %4d  %4d  %4d\n", SDp->id, SDp->lun, SDp->queue_depth, NCR_700_get_depth(SDp), SDp->current_tag);
+	}
+	if((len -= offset) <= 0)
+		return 0;
+	if(len > bytes_available)
+		len = bytes_available;
+	memcpy(proc_buf, buf + offset, len);
+	return len;
+}
+
+STATIC int
+NCR_700_queuecommand(Scsi_Cmnd *SCp, void (*done)(Scsi_Cmnd *))
+{
+	struct NCR_700_Host_Parameters *hostdata = 
+		(struct NCR_700_Host_Parameters *)SCp->host->hostdata[0];
+	__u32 move_ins;
+	struct NCR_700_command_slot *slot;
+	int hash;
+
+	if(hostdata->command_slot_count >= NCR_700_COMMAND_SLOTS_PER_HOST) {
+		/* We're over our allocation, this should never happen
+		 * since we report the max allocation to the mid layer */
+		printk(KERN_WARNING "scsi%d: Command depth has gone over queue depth\n", SCp->host->host_no);
+		return 1;
+	}
+	if(NCR_700_get_depth(SCp->device) != 0 && !(hostdata->tag_negotiated & (1<<SCp->target))) {
+		DEBUG((KERN_ERR "scsi%d (%d:%d) has non zero depth %d\n",
+		       SCp->host->host_no, SCp->target, SCp->lun,
+		       NCR_700_get_depth(SCp->device)));
+		return 1;
+	}
+	if(NCR_700_get_depth(SCp->device) >= NCR_700_MAX_TAGS) {
+		DEBUG((KERN_ERR "scsi%d (%d:%d) has max tag depth %d\n",
+		       SCp->host->host_no, SCp->target, SCp->lun,
+		       NCR_700_get_depth(SCp->device)));
+		return 1;
+	}
+	NCR_700_set_depth(SCp->device, NCR_700_get_depth(SCp->device) + 1);
+
+	/* begin the command here */
+	/* no need to check for NULL, test for command_slot_cound above
+	 * ensures a slot is free */
+	slot = find_empty_slot(hostdata);
+
+	slot->cmnd = SCp;
+
+	SCp->scsi_done = done;
+	SCp->host_scribble = (unsigned char *)slot;
+	SCp->SCp.ptr = NULL;
+	SCp->SCp.buffer = NULL;
+
+#ifdef NCR_700_DEBUG
+	printk("53c700: scsi%d, command ", SCp->host->host_no);
+	print_command(SCp->cmnd);
+#endif
+
+	if(hostdata->tag_negotiated &(1<<SCp->target)) {
+
+		struct NCR_700_command_slot *old =
+			find_ITL_Nexus(hostdata, SCp->target, SCp->lun);
+#ifdef NCR_700_TAG_DEBUG
+		struct NCR_700_command_slot *found;
+#endif
+		
+		if(old != NULL && old->tag == SCp->device->current_tag) {
+			printk(KERN_WARNING "scsi%d (%d:%d) Tag clock back to current, queueing\n", SCp->host->host_no, SCp->target, SCp->lun);
+			return 1;
+		}
+		slot->tag = SCp->device->current_tag++;
+#ifdef NCR_700_TAG_DEBUG
+		while((found = find_ITLQ_Nexus(hostdata, SCp->target, SCp->lun, slot->tag)) != NULL) {
+			printk("\n\n**ERROR** already using tag %d, but oldest is %d\n", slot->tag, (old == NULL) ? -1 : old->tag);
+			printk("  FOUND = %p, tag = %d, pun = %d, lun = %d\n",
+			       found, found->tag, found->cmnd->target, found->cmnd->lun);
+			slot->tag = SCp->device->current_tag++;
+			printk("   Tag list is: ");
+			while(old != NULL) {
+				if(old->cmnd->target == SCp->target &&
+				   old->cmnd->lun == SCp->lun)
+					printk("%d ", old->tag);
+				old = old->ITL_back;
+			}
+			printk("\n\n");
+		}
+#endif
+		hash = hash_ITLQ(SCp->target, SCp->lun, slot->tag);
+		/* link into the ITLQ hash queues */
+		slot->ITLQ_forw = hostdata->ITLQ_Hash_forw[hash];
+		hostdata->ITLQ_Hash_forw[hash] = slot;
+#ifdef NCR_700_TAG_DEBUG
+		if(slot->ITLQ_forw != NULL && slot->ITLQ_forw->ITLQ_back != NULL) {
+			printk(KERN_ERR "scsi%d (%d:%d) ITLQ_back is not NULL!!!!\n", SCp->host->host_no, SCp->target, SCp->lun);
+		}
+#endif
+		if(slot->ITLQ_forw != NULL)
+			slot->ITLQ_forw->ITLQ_back = slot;
+		else
+			hostdata->ITLQ_Hash_back[hash] = slot;
+		slot->ITLQ_back = NULL;
+	} else {
+		slot->tag = NCR_700_NO_TAG;
+	}
+	/* link into the ITL hash queues */
+	hash = hash_ITL(SCp->target, SCp->lun);
+	slot->ITL_forw = hostdata->ITL_Hash_forw[hash];
+	hostdata->ITL_Hash_forw[hash] = slot;
+#ifdef NCR_700_TAG_DEBUG
+	if(slot->ITL_forw != NULL && slot->ITL_forw->ITL_back != NULL) {
+		printk(KERN_ERR "scsi%d (%d:%d) ITL_back is not NULL!!!!\n",
+		       SCp->host->host_no, SCp->target, SCp->lun);
+	}
+#endif
+	if(slot->ITL_forw != NULL)
+		slot->ITL_forw->ITL_back = slot;
+	else
+		hostdata->ITL_Hash_back[hash] = slot;
+	slot->ITL_back = NULL;
+
+		
+	/* This is f****g ridiculous; every low level HBA driver has
+	 * to determine the direction of the commands, why isn't this
+	 * done inside the scsi_lib !!??? */
+	switch (SCp->cmnd[0]) {
+	case REQUEST_SENSE:
+		/* clear the internal sense magic */
+		SCp->cmnd[6] = 0;
+		/* fall through */
+	case INQUIRY:
+	case MODE_SENSE:
+	case READ_6:
+	case READ_10:
+	case READ_12:
+	case READ_CAPACITY:
+	case READ_BLOCK_LIMITS:
+	case READ_TOC:
+		move_ins = SCRIPT_MOVE_DATA_IN;
+		break;
+	case MODE_SELECT:
+	case WRITE_6:
+	case WRITE_10:
+	case WRITE_12:
+		move_ins = SCRIPT_MOVE_DATA_OUT;
+		break;
+	case TEST_UNIT_READY:
+	case ALLOW_MEDIUM_REMOVAL:
+	case START_STOP:
+		move_ins = 0;
+		break;
+	default:
+		/* OK, get it from the command */
+		switch(SCp->sc_data_direction) {
+		case SCSI_DATA_UNKNOWN:
+		default:
+			printk(KERN_ERR "53c700: Unknown command for data direction ");
+			print_command(SCp->cmnd);
+			
+			move_ins = 0;
+			break;
+		case SCSI_DATA_NONE:
+			move_ins = 0;
+			break;
+		case SCSI_DATA_READ:
+			move_ins = SCRIPT_MOVE_DATA_IN;
+			break;
+		case SCSI_DATA_WRITE:
+			move_ins = SCRIPT_MOVE_DATA_OUT;
+			break;
+		}
+	}
+
+	/* now build the scatter gather list */
+	if(move_ins != 0) {
+		int i;
+
+		for(i = 0; i < (SCp->use_sg ? SCp->use_sg : 1); i++) {
+			void *vPtr;
+			__u32 count;
+
+			if(SCp->use_sg) {
+				vPtr = (((struct scatterlist *)SCp->buffer)[i].address);
+				count = ((struct scatterlist *)SCp->buffer)[i].length;
+			} else {
+				vPtr = SCp->request_buffer;
+				count = SCp->request_bufflen;
+			}
+			slot->SG[i].ins = move_ins | count;
+			DEBUG((" scatter block %d: move %d[%08lx] from 0x%lx\n",
+			       i, count, slot->SG[i].move_ins, 
+			       virt_to_bus(vPtr)));
+			slot->SG[i].pAddr = virt_to_bus(vPtr);
+		}
+		slot->SG[i].ins = SCRIPT_RETURN;
+		slot->SG[i].pAddr = 0;
+		DEBUG((" SETTING %08x to %x\n",
+		       virt_to_bus(&slot->SG[i].ins), 
+		       slot->SG[i].ins));
+	}
+	slot->resume_offset = 0;
+	NCR_700_start_command(SCp);
+	return 0;
+}
+
+STATIC int
+NCR_700_abort(Scsi_Cmnd * SCp)
+{
+	struct NCR_700_command_slot *slot;
+	struct NCR_700_Host_Parameters *hostdata = 
+		(struct NCR_700_Host_Parameters *)SCp->host->hostdata[0];
+
+	printk("scsi%d (%d:%d) New error handler wants to abort command\n\t",
+	       SCp->host->host_no, SCp->target, SCp->lun);
+	print_command(SCp->cmnd);
+
+	slot = find_ITL_Nexus(hostdata, SCp->target, SCp->lun);
+	while(slot != NULL && slot->cmnd != SCp)
+		slot = slot->ITL_back;
+
+	if(slot == NULL)
+		/* no outstanding command to abort */
+		return SUCCESS;
+	if(SCp->cmnd[0] == TEST_UNIT_READY) {
+		/* FIXME: This is because of a problem in the new
+		 * error handler.  When it is in error recovery, it
+		 * will send a TUR to a device it thinks may still be
+		 * showing a problem.  If the TUR isn't responded to,
+		 * it will abort it and mark the device off line.
+		 * Unfortunately, it does no other error recovery, so
+		 * this would leave us with an outstanding command
+		 * occupying a slot.  Rather than allow this to
+		 * happen, we issue a bus reset to force all
+		 * outstanding commands to terminate here. */
+		NCR_700_internal_bus_reset(SCp->host);
+		/* still drop through and return failed */
+	}
+	return FAILED;
+
+}
+
+STATIC int
+NCR_700_bus_reset(Scsi_Cmnd * SCp)
+{
+	printk("scsi%d (%d:%d) New error handler wants BUS reset, cmd %p\n\t",
+	       SCp->host->host_no, SCp->target, SCp->lun, SCp);
+	print_command(SCp->cmnd);
+	NCR_700_internal_bus_reset(SCp->host);
+	return SUCCESS;
+}
+
+STATIC int
+NCR_700_dev_reset(Scsi_Cmnd * SCp)
+{
+	printk("scsi%d (%d:%d) New error handler wants device reset\n\t",
+	       SCp->host->host_no, SCp->target, SCp->lun);
+	print_command(SCp->cmnd);
+	
+	return FAILED;
+}
+
+STATIC int
+NCR_700_host_reset(Scsi_Cmnd * SCp)
+{
+	printk("scsi%d (%d:%d) New error handler wants HOST reset\n\t",
+	       SCp->host->host_no, SCp->target, SCp->lun);
+	print_command(SCp->cmnd);
+
+	NCR_700_internal_bus_reset(SCp->host);
+	NCR_700_chip_reset(SCp->host);
+	return SUCCESS;
+}
+
+EXPORT_SYMBOL(NCR_700_detect);
+EXPORT_SYMBOL(NCR_700_release);
+EXPORT_SYMBOL(NCR_700_intr);
Index: linux/2.4/drivers/scsi/53c700.h
diff -u /dev/null linux/2.4/drivers/scsi/53c700.h:1.1.4.1
--- /dev/null	Sat May 12 12:05:15 2001
+++ linux/2.4/drivers/scsi/53c700.h	Sat May 12 10:39:20 2001
@@ -0,0 +1,391 @@
+/* -*- mode: c; c-basic-offset: 8 -*- */
+
+/* Driver for 53c700 and 53c700-66 chips from NCR and Symbios
+ *
+ * Copyright (C) 2001 by James.Bottomley@HansenPartnership.com
+ */
+
+#ifndef _53C700_H
+#define _53C700_H
+
+/* Turn on for general debugging---too verbose for normal use */
+#undef NCR_700_DEBUG
+/* Debug the tag queues, checking hash queue allocation and deallocation
+ * and search for duplicate tags */
+#undef NCR_700_TAG_DEBUG
+
+#ifdef NCR_700_DEBUG
+#define DEBUG(x)	printk x
+#else
+#define DEBUG(x)
+#endif
+
+/* The number of available command slots */
+#define NCR_700_COMMAND_SLOTS_PER_HOST	64
+/* The maximum number of Scatter Gathers we allow */
+#define NCR_700_SG_SEGMENTS		32
+/* The maximum number of luns (make this of the form 2^n) */
+#define NCR_700_MAX_LUNS		32
+#define NCR_700_LUN_MASK		(NCR_700_MAX_LUNS - 1)
+/* Alter this with care: too many tags won't give the elevator a chance to
+ * work; too few will cause the device to operate less efficiently */
+#define NCR_700_MAX_TAGS		16
+/* magic byte identifying an internally generated REQUEST_SENSE command */
+#define NCR_700_INTERNAL_SENSE_MAGIC	0x42
+
+
+struct NCR_700_Host_Parameters;
+
+/* These are the externally used routines */
+struct Scsi_Host *NCR_700_detect(Scsi_Host_Template *, struct NCR_700_Host_Parameters *);
+int NCR_700_release(struct Scsi_Host *host);
+void NCR_700_intr(int, void *, struct pt_regs *);
+
+
+enum NCR_700_Host_State {
+	NCR_700_HOST_BUSY,
+	NCR_700_HOST_FREE,
+};
+
+struct NCR_700_SG_List {
+	/* The following is a script fragment to move the buffer onto the
+	 * bus and then link the next fragment or return */
+	#define	SCRIPT_MOVE_DATA_IN		0x09000000
+	#define	SCRIPT_MOVE_DATA_OUT		0x08000000
+	__u32	ins;
+	__u32	pAddr;
+	#define	SCRIPT_NOP			0x80000000
+	#define	SCRIPT_RETURN			0x90080000
+};
+
+/* We use device->hostdata to store negotiated parameters.  This is
+ * supposed to be a pointer to a device private area, but we cannot
+ * really use it as such since it will never be freed, so just use the
+ * 32 bits to cram the information.  The SYNC negotiation sequence looks
+ * like:
+ * 
+ * If DEV_NEGOTIATED_SYNC not set, tack and SDTR message on to the
+ * initial identify for the device and set DEV_BEGIN_SYNC_NEGOTATION
+ * If we get an SDTR reply, work out the SXFER parameters, squirrel
+ * them away here, clear DEV_BEGIN_SYNC_NEGOTIATION and set
+ * DEV_NEGOTIATED_SYNC.  If we get a REJECT msg, squirrel
+ *
+ *
+ * 0:7	SXFER_REG negotiated value for this device
+ * 8:15 Current queue depth
+ * 16	negotiated SYNC flag
+ * 17 begin SYNC negotiation flag 
+ * 18 device supports tag queueing */
+#define NCR_700_DEV_NEGOTIATED_SYNC	(1<<16)
+#define NCR_700_DEV_BEGIN_SYNC_NEGOTIATION	(1<<17)
+#define NCR_700_DEV_USES_TAG_QUEUEING	(1<<18)
+
+static inline void
+NCR_700_set_SXFER(Scsi_Device *SDp, __u8 sxfer)
+{
+	((__u32)SDp->hostdata) &= 0xffffff00;
+	((__u32)SDp->hostdata) |= sxfer & 0xff;
+}
+static inline __u8 NCR_700_get_SXFER(Scsi_Device *SDp)
+{
+	return (((__u32)SDp->hostdata) & 0xff);
+}
+static inline void
+NCR_700_set_depth(Scsi_Device *SDp, __u8 depth)
+{
+	((__u32)SDp->hostdata) &= 0xffff00ff;
+	((__u32)SDp->hostdata) |= (0xff00 & (depth << 8));
+}
+static inline __u8
+NCR_700_get_depth(Scsi_Device *SDp)
+{
+	return ((((__u32)SDp->hostdata) & 0xff00)>>8);
+}
+static inline int
+NCR_700_is_flag_set(Scsi_Device *SDp, __u32 flag)
+{
+	return (((__u32)SDp->hostdata) & flag) == flag;
+}
+static inline int
+NCR_700_is_flag_clear(Scsi_Device *SDp, __u32 flag)
+{
+	return (((__u32)SDp->hostdata) & flag) == 0;
+}
+static inline void
+NCR_700_set_flag(Scsi_Device *SDp, __u32 flag)
+{
+	((__u32)SDp->hostdata) |= (flag & 0xffff0000);
+}
+static inline void
+NCR_700_clear_flag(Scsi_Device *SDp, __u32 flag)
+{
+	((__u32)SDp->hostdata) &= ~(flag & 0xffff0000);
+}
+
+/* These represent the Nexus hashing functions.  A Nexus in SCSI terms
+ * just means the identification of an outstanding command, by ITL
+ * (Initiator Target Lun) or ITLQ (Initiator Target Lun Tag).  I'm not
+ * very keen on XOR based hashes, so these are based on number theory
+ * instead.  All you need to do is to fix your hash bucket size and
+ * then choose reasonable strides which are coprime with the chosen
+ * bucket size
+ *
+ * Note: this mathematical hash can be made very efficient, if the
+ * compiler is good at optimising: Choose the number of buckets to be
+ * 2^n and the modulo becomes a logical and with (2^n-1).
+ * Additionally, if you chose the coprimes of the form 2^n-2^n the
+ * multiplication can be done by a shift and an addition. */
+#define MAX_ITL_HASH_BUCKETS	16
+#define ITL_HASH_PRIME		7
+
+#define MAX_ITLQ_HASH_BUCKETS	64
+#define ITLQ_PUN_PRIME		7
+#define ITLQ_LUN_PRIME		3
+
+static inline int
+hash_ITL(__u8 pun, __u8 lun)
+{
+	return (pun*ITL_HASH_PRIME + lun) % MAX_ITL_HASH_BUCKETS;
+}
+
+static inline int
+hash_ITLQ(__u8 pun, __u8 lun, __u8 tag)
+{
+	return (pun*ITLQ_PUN_PRIME + lun*ITLQ_LUN_PRIME + tag) % MAX_ITLQ_HASH_BUCKETS;
+}
+
+struct NCR_700_command_slot {
+	#define NCR_700_SLOT_MASK 0xFC
+	#define NCR_700_SLOT_MAGIC 0xb8
+	#define	NCR_700_SLOT_FREE (0|NCR_700_SLOT_MAGIC) /* slot may be used */
+	#define NCR_700_SLOT_BUSY (1|NCR_700_SLOT_MAGIC) /* slot has command active on HA */
+	#define NCR_700_SLOT_QUEUED (2|NCR_700_SLOT_MAGIC) /* slot has command to be made active on HA */
+	__u8	state;
+	#define NCR_700_NO_TAG	0xdead
+	__u16	tag;
+	struct NCR_700_SG_List	SG[NCR_700_SG_SEGMENTS+1];
+	__u32	resume_offset;
+	Scsi_Cmnd	*cmnd;
+	__u32		temp;
+	/* Doubly linked ITL/ITLQ list kept in strict time order
+	 * (latest at the back) */
+	struct NCR_700_command_slot *ITL_forw;
+	struct NCR_700_command_slot *ITL_back;
+	struct NCR_700_command_slot *ITLQ_forw;
+	struct NCR_700_command_slot *ITLQ_back;
+};
+
+struct NCR_700_Host_Parameters {
+	/* These must be filled in by the calling driver */
+	int	clock;			/* board clock speed in MHz */
+	__u32	base;			/* the base for the port (copied to host) */
+	__u8	differential:1;	/* if we are differential */
+
+	/* NOTHING BELOW HERE NEEDS ALTERING */
+	__u8	fast:1;		/* if we can alter the SCSI bus clock
+                                   speed (so can negiotiate sync) */
+
+	__u32	*script;		/* pointer to script location */
+	__u32	pScript;		/* physical mem addr of script */
+
+	/* This will be the host lock.  Unfortunately, we can't use it
+	 * at the moment because of the necessity of holding the
+	 * io_request_lock */
+	spinlock_t lock;
+	enum NCR_700_Host_State state; /* protected by state lock */
+	Scsi_Cmnd *cmd;
+
+	__u8	msgout[8];
+	__u8	msgout_size;
+	__u8	tag_negotiated;
+	__u8	status;
+	__u8	msgin[8];
+	struct NCR_700_command_slot	*slots;
+	int	saved_slot_position;
+	int	command_slot_count; /* protected by state lock */
+	__u8	rev;
+	__u8	reselection_id;
+	/* flags for the host */
+
+	/* ITL list.  ALL outstanding commands are hashed here in strict
+	 * order, latest at the back */
+	struct NCR_700_command_slot *ITL_Hash_forw[MAX_ITL_HASH_BUCKETS];
+	struct NCR_700_command_slot *ITL_Hash_back[MAX_ITL_HASH_BUCKETS];
+
+	/* Only tagged outstanding commands are hashed here (also latest
+	 * at the back) */
+	struct NCR_700_command_slot *ITLQ_Hash_forw[MAX_ITLQ_HASH_BUCKETS];
+	struct NCR_700_command_slot *ITLQ_Hash_back[MAX_ITLQ_HASH_BUCKETS];
+
+	/* Free list, singly linked by ITL_forw elements */
+	struct NCR_700_command_slot *free_list;
+};
+
+/*
+ *	53C700 Register Interface - the offset from the Selected base
+ *	I/O address */
+
+#define	SCNTL0_REG			0x00
+#define		FULL_ARBITRATION	0xc0
+#define 	PARITY			0x08
+#define		ENABLE_PARITY		0x04
+#define 	AUTO_ATN		0x02
+#define	SCNTL1_REG			0x01
+#define 	SLOW_BUS		0x80
+#define		ENABLE_SELECT		0x20
+#define		ASSERT_RST		0x08
+#define		ASSERT_EVEN_PARITY	0x04
+#define	SDID_REG			0x02
+#define	SIEN_REG			0x03
+#define 	PHASE_MM_INT		0x80
+#define 	FUNC_COMP_INT		0x40
+#define 	SEL_TIMEOUT_INT		0x20
+#define 	SELECT_INT		0x10
+#define 	GROSS_ERR_INT		0x08
+#define 	UX_DISC_INT		0x04
+#define 	RST_INT			0x02
+#define 	PAR_ERR_INT		0x01
+#define	SCID_REG			0x04
+#define SXFER_REG			0x05
+#define		ASYNC_OPERATION		0x00
+#define SODL_REG                        0x06
+#define	SOCL_REG			0x07
+#define	SFBR_REG			0x08
+#define	SIDL_REG			0x09
+#define	SBDL_REG			0x0A
+#define	SBCL_REG			0x0B
+#define		SBCL_IO			0x01
+#define	DSTAT_REG			0x0C
+#define		ILGL_INST_DETECTED	0x01
+#define		WATCH_DOG_INTERRUPT	0x02
+#define		SCRIPT_INT_RECEIVED	0x04
+#define		ABORTED			0x10
+#define	SSTAT0_REG			0x0D
+#define		PARITY_ERROR		0x01
+#define		SCSI_RESET_DETECTED	0x02
+#define		UNEXPECTED_DISCONNECT	0x04
+#define		SCSI_GROSS_ERROR	0x08
+#define		SELECTED		0x10
+#define		SELECTION_TIMEOUT	0x20
+#define		FUNCTION_COMPLETE	0x40
+#define		PHASE_MISMATCH 		0x80
+#define	SSTAT1_REG			0x0E
+#define		SIDL_REG_FULL		0x80
+#define		SODR_REG_FULL		0x40
+#define		SODL_REG_FULL		0x20
+#define SSTAT2_REG                      0x0F
+#define CTEST0_REG                      0x14
+#define CTEST1_REG                      0x15
+#define CTEST2_REG                      0x16
+#define CTEST3_REG                      0x17
+#define CTEST4_REG                      0x18
+#define         DISABLE_FIFO            0x00
+#define         SLBE                    0x10
+#define         SFWR                    0x08
+#define         BYTE_LANE0              0x04
+#define         BYTE_LANE1              0x05
+#define         BYTE_LANE2              0x06
+#define         BYTE_LANE3              0x07
+#define         SCSI_ZMODE              0x20
+#define         ZMODE                   0x40
+#define CTEST5_REG                      0x19
+#define         MASTER_CONTROL          0x10
+#define         DMA_DIRECTION           0x08
+#define CTEST7_REG                      0x1B
+#define         DFP                     0x08
+#define         EVP                     0x04
+#define		DIFF			0x01
+#define CTEST6_REG                      0x1A
+#define	TEMP_REG			0x1C
+#define	DFIFO_REG			0x20
+#define		FLUSH_DMA_FIFO		0x80
+#define		CLR_FIFO		0x40
+#define	ISTAT_REG			0x21
+#define		ABORT_OPERATION		0x80
+#define		DMA_INT_PENDING		0x01
+#define		SCSI_INT_PENDING	0x02
+#define		CONNECTED		0x08
+#define CTEST8_REG                      0x22
+#define         LAST_DIS_ENBL           0x01
+#define		SHORTEN_FILTERING	0x04
+#define		ENABLE_ACTIVE_NEGATION	0x10
+#define		GENERATE_RECEIVE_PARITY	0x20
+#define CTEST9_REG                      0x23
+#define	DBC_REG				0x24
+#define	DCMD_REG			0x27
+#define	DNAD_REG			0x28
+#define	DIEN_REG			0x39
+#define 	ABORT_INT		0x10
+#define 	INT_INST_INT		0x04
+#define 	WD_INT			0x02
+#define 	ILGL_INST_INT		0x01
+#define	DCNTL_REG			0x3B
+#define		SOFTWARE_RESET		0x01
+#define 	SCRPTS_16BITS		0x20
+#define	DMODE_REG			0x34
+#define		BURST_LENGTH_1		0x00
+#define		BURST_LENGTH_2		0x40
+#define		BURST_LENGTH_4		0x80
+#define		BURST_LENGTH_8		0xC0
+#define 	BW16			32 
+#define 	MODE_286		16
+#define 	IO_XFER			8
+#define 	FIXED_ADDR		4
+
+#define DSP_REG                         0x2C
+#define DSPS_REG                        0x30
+
+/* Parameters to begin SDTR negotiations.  Empirically, I find that
+ * the 53c700-66 cannot handle an offset >8, so don't change this  */
+#define NCR_700_MAX_OFFSET	8
+#define NCR_700_MIN_XFERP	1
+#define NCR_700_MIN_PERIOD	25 /* for SDTR message, 100ns */
+
+#define script_patch_32(script, symbol, value) \
+{ \
+	int i; \
+	for(i=0; i< (sizeof(A_##symbol##_used) / sizeof(__u32)); i++) { \
+		(script)[A_##symbol##_used[i]] += (value); \
+		DEBUG((" script, patching %s at %ld to 0x%lx\n", \
+		       #symbol, A_##symbol##_used[i], (value))); \
+	} \
+}
+
+#define script_patch_32_abs(script, symbol, value) \
+{ \
+	int i; \
+	for(i=0; i< (sizeof(A_##symbol##_used) / sizeof(__u32)); i++) { \
+		(script)[A_##symbol##_used[i]] = (value); \
+		DEBUG((" script, patching %s at %ld to 0x%lx\n", \
+		       #symbol, A_##symbol##_used[i], (value))); \
+	} \
+}
+
+/* Used for patching the SCSI ID in the SELECT instruction */
+#define script_patch_ID(script, symbol, value) \
+{ \
+	int i; \
+	for(i=0; i< (sizeof(A_##symbol##_used) / sizeof(__u32)); i++) { \
+		__u32 val = (script)[A_##symbol##_used[i]]; \
+		val &= 0xff00ffff; \
+		val |= ((value) & 0xff) << 16; \
+		(script)[A_##symbol##_used[i]] = val; \
+		DEBUG((" script, patching ID field %s at %ld to 0x%lx\n", \
+		       #symbol, A_##symbol##_used[i], val)); \
+	} \
+}
+
+#define script_patch_16(script, symbol, value) \
+{ \
+	int i; \
+	for(i=0; i< (sizeof(A_##symbol##_used) / sizeof(__u32)); i++) { \
+		__u32 val = (script)[A_##symbol##_used[i]]; \
+		val &= 0xffff0000; \
+		val |= ((value) & 0xffff); \
+		(script)[A_##symbol##_used[i]] = val; \
+		DEBUG((" script, patching ID field %s at %ld to 0x%lx\n", \
+		       #symbol, A_##symbol##_used[i], val)); \
+	} \
+}
+
+#endif
Index: linux/2.4/drivers/scsi/53c700.scr
diff -u /dev/null linux/2.4/drivers/scsi/53c700.scr:1.1.4.1
--- /dev/null	Sat May 12 12:05:16 2001
+++ linux/2.4/drivers/scsi/53c700.scr	Sat May 12 10:39:20 2001
@@ -0,0 +1,404 @@
+; Script for the NCR (or symbios) 53c700 and 53c700-66 chip
+;
+; Copyright (C) 2001 James.Bottomley@HansenPartnership.com
+;;-----------------------------------------------------------------------------
+;;  
+;;  This program is free software; you can redistribute it and/or modify
+;;  it under the terms of the GNU General Public License as published by
+;;  the Free Software Foundation; either version 2 of the License, or
+;;  (at your option) any later version.
+;;
+;;  This program is distributed in the hope that it will be useful,
+;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
+;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+;;  GNU General Public License for more details.
+;;
+;;  You should have received a copy of the GNU General Public License
+;;  along with this program; if not, write to the Free Software
+;;  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+;;
+;;-----------------------------------------------------------------------------
+;
+; This script is designed to be modified for the particular command in
+; operation.  The particular variables pertaining to the commands are:
+;
+ABSOLUTE	Device_ID = 0		; ID of target for command
+ABSOLUTE	MessageCount = 0	; Number of bytes in message
+ABSOLUTE	MessageLocation = 0	; Addr of message
+ABSOLUTE	CommandCount = 0	; Number of bytes in command
+ABSOLUTE	CommandAddress = 0	; Addr of Command
+ABSOLUTE	StatusAddress = 0	; Addr to receive status return
+ABSOLUTE	ReceiveMsgAddress = 0	; Addr to receive msg
+;
+; This is the magic component for handling scatter-gather.  Each of the
+; SG components is preceeded by a script fragment which moves the
+; necessary amount of data and jumps to the next SG segment.  The final
+; SG segment jumps back to .  However, this address is the first SG script
+; segment.
+;
+ABSOLUTE	SGScriptStartAddress = 0
+
+; The following represent status interrupts we use 3 hex digits for
+; this: 0xPRS where 
+
+; P:
+ABSOLUTE	AFTER_SELECTION 	= 0x100
+ABSOLUTE	BEFORE_CMD 		= 0x200
+ABSOLUTE	AFTER_CMD 		= 0x300
+ABSOLUTE	AFTER_STATUS 		= 0x400
+ABSOLUTE	AFTER_DATA_IN		= 0x500
+ABSOLUTE	AFTER_DATA_OUT		= 0x600
+ABSOLUTE	DURING_DATA_IN		= 0x700
+
+; R:
+ABSOLUTE	NOT_MSG_OUT 		= 0x10
+ABSOLUTE	UNEXPECTED_PHASE 	= 0x20
+ABSOLUTE	NOT_MSG_IN 		= 0x30
+ABSOLUTE	UNEXPECTED_MSG		= 0x40
+ABSOLUTE	MSG_IN			= 0x50
+ABSOLUTE	SDTR_MSG_R		= 0x60
+ABSOLUTE	REJECT_MSG_R		= 0x70
+ABSOLUTE	DISCONNECT		= 0x80
+ABSOLUTE	MSG_OUT			= 0x90
+ABSOLUTE	WDTR_MSG_R		= 0xA0
+
+; S:
+ABSOLUTE	GOOD_STATUS 		= 0x1
+
+; Combinations, since the script assembler can't process |
+ABSOLUTE	NOT_MSG_OUT_AFTER_SELECTION = 0x110
+ABSOLUTE	UNEXPECTED_PHASE_BEFORE_CMD = 0x220
+ABSOLUTE	UNEXPECTED_PHASE_AFTER_CMD = 0x320
+ABSOLUTE	NOT_MSG_IN_AFTER_STATUS = 0x430
+ABSOLUTE	GOOD_STATUS_AFTER_STATUS = 0x401
+ABSOLUTE	UNEXPECTED_PHASE_AFTER_DATA_IN = 0x520
+ABSOLUTE	UNEXPECTED_PHASE_AFTER_DATA_OUT = 0x620
+ABSOLUTE	UNEXPECTED_MSG_BEFORE_CMD = 0x240
+ABSOLUTE	MSG_IN_BEFORE_CMD = 0x250
+ABSOLUTE	MSG_IN_AFTER_CMD = 0x350
+ABSOLUTE	SDTR_MSG_BEFORE_CMD = 0x260
+ABSOLUTE	REJECT_MSG_BEFORE_CMD = 0x270
+ABSOLUTE	DISCONNECT_AFTER_CMD = 0x380
+ABSOLUTE	SDTR_MSG_AFTER_CMD = 0x360
+ABSOLUTE	WDTR_MSG_AFTER_CMD = 0x3A0
+ABSOLUTE	DISCONNECT_AFTER_DATA = 0x580
+ABSOLUTE	MSG_IN_AFTER_DATA_IN = 0x550
+ABSOLUTE	MSG_IN_AFTER_DATA_OUT = 0x650
+ABSOLUTE	MSG_OUT_AFTER_DATA_IN = 0x590
+ABSOLUTE	DATA_IN_AFTER_DATA_IN = 0x5a0
+ABSOLUTE	MSG_IN_DURING_DATA_IN = 0x750
+ABSOLUTE	DISCONNECT_DURING_DATA = 0x780
+
+;
+; Other interrupt conditions
+; 
+ABSOLUTE	RESELECTED_DURING_SELECTION = 0x1000
+ABSOLUTE	COMPLETED_SELECTION_AS_TARGET = 0x1001
+ABSOLUTE	RESELECTION_IDENTIFIED = 0x1003
+;
+; Fatal interrupt conditions.  If you add to this, also add to the
+; array of corresponding messages
+;
+ABSOLUTE	FATAL = 0x2000
+ABSOLUTE	FATAL_UNEXPECTED_RESELECTION_MSG = 0x2000
+ABSOLUTE	FATAL_SEND_MSG = 0x2001
+ABSOLUTE	FATAL_NOT_MSG_IN_AFTER_SELECTION = 0x2002
+ABSOLUTE	FATAL_ILLEGAL_MSG_LENGTH = 0x2003
+
+ABSOLUTE	DEBUG_INTERRUPT	= 0x3000
+ABSOLUTE	DEBUG_INTERRUPT1 = 0x3001
+ABSOLUTE	DEBUG_INTERRUPT2 = 0x3002
+ABSOLUTE	DEBUG_INTERRUPT3 = 0x3003
+ABSOLUTE	DEBUG_INTERRUPT4 = 0x3004
+ABSOLUTE	DEBUG_INTERRUPT5 = 0x3005
+ABSOLUTE	DEBUG_INTERRUPT6 = 0x3006
+
+
+;
+; SCSI Messages we interpret in the script
+; 
+ABSOLUTE	EXTENDED_MSG		= 0x01
+ABSOLUTE	SDTR_MSG		= 0x01
+ABSOLUTE	SAVE_DATA_PTRS_MSG	= 0x02
+ABSOLUTE	RESTORE_DATA_PTRS_MSG	= 0x03
+ABSOLUTE	WDTR_MSG		= 0x03
+ABSOLUTE	DISCONNECT_MSG		= 0x04
+ABSOLUTE	REJECT_MSG		= 0x07
+ABSOLUTE	PARITY_ERROR_MSG	= 0x09
+ABSOLUTE	SIMPLE_TAG_MSG		= 0x20
+ABSOLUTE	IDENTIFY_MSG		= 0x80
+ABSOLUTE	IDENTIFY_MSG_MASK	= 0x7F
+ABSOLUTE	TWO_BYTE_MSG		= 0x20
+ABSOLUTE	TWO_BYTE_MSG_MASK	= 0x0F
+
+; This is where the script begins
+
+ENTRY	StartUp
+
+StartUp:
+	SELECT	ATN Device_ID, Reselect
+	JUMP	Finish, WHEN STATUS
+	JUMP	SendIdentifyMsg, IF MSG_OUT
+	INT	NOT_MSG_OUT_AFTER_SELECTION
+
+Reselect:
+	WAIT	RESELECT SelectedAsTarget
+	INT	RESELECTED_DURING_SELECTION, WHEN MSG_IN
+	INT	FATAL_NOT_MSG_IN_AFTER_SELECTION
+
+	ENTRY	GetReselectionData
+GetReselectionData:
+	MOVE	1, ReceiveMsgAddress, WHEN MSG_IN
+	INT	RESELECTION_IDENTIFIED
+
+	ENTRY	GetReselectionWithTag
+GetReselectionWithTag:
+	MOVE	3, ReceiveMsgAddress, WHEN MSG_IN
+	INT	RESELECTION_IDENTIFIED
+	
+	ENTRY	SelectedAsTarget
+SelectedAsTarget:
+; Basically tell the selecting device that there's nothing here
+	SET	TARGET
+	DISCONNECT
+	CLEAR	TARGET
+	INT	COMPLETED_SELECTION_AS_TARGET
+;
+; These are the messaging entries
+;
+; Send a message.  Message count should be correctly patched
+	ENTRY	SendMessage
+SendMessage:
+	MOVE	MessageCount, MessageLocation, WHEN MSG_OUT
+ResumeSendMessage:
+	RETURN,	WHEN NOT MSG_OUT
+	INT	FATAL_SEND_MSG
+
+	ENTRY	SendMessagePhaseMismatch
+SendMessagePhaseMismatch:
+	CLEAR	ACK
+	JUMP	ResumeSendMessage
+;
+; Receive a message.  Need to identify the message to
+; receive it correctly
+	ENTRY	ReceiveMessage
+ReceiveMessage:
+	MOVE	1, ReceiveMsgAddress, WHEN MSG_IN
+;
+; Use this entry if we've just tried to look at the first byte
+; of the message and want to process it further
+ProcessReceiveMessage:
+	JUMP	ReceiveExtendedMessage, IF EXTENDED_MSG
+	RETURN,	IF NOT TWO_BYTE_MSG, AND MASK TWO_BYTE_MSG_MASK
+	CLEAR	ACK
+	MOVE	1, ReceiveMsgAddress + 1, WHEN MSG_IN
+	RETURN
+ReceiveExtendedMessage:
+	CLEAR	ACK
+	MOVE	1, ReceiveMsgAddress + 1, WHEN MSG_IN
+	JUMP	Receive1Byte, IF 0x01
+	JUMP	Receive2Byte, IF 0x02
+	JUMP	Receive3Byte, IF 0x03
+	JUMP	Receive4Byte, IF 0x04
+	JUMP	Receive5Byte, IF 0x05
+	INT	FATAL_ILLEGAL_MSG_LENGTH
+Receive1Byte:
+	CLEAR	ACK
+	MOVE	1, ReceiveMsgAddress + 2, WHEN MSG_IN
+	RETURN
+Receive2Byte:
+	CLEAR	ACK
+	MOVE	2, ReceiveMsgAddress + 2, WHEN MSG_IN
+	RETURN
+Receive3Byte:
+	CLEAR	ACK
+	MOVE	3, ReceiveMsgAddress + 2, WHEN MSG_IN
+	RETURN
+Receive4Byte:
+	CLEAR	ACK
+	MOVE	4, ReceiveMsgAddress + 2, WHEN MSG_IN
+	RETURN
+Receive5Byte:
+	CLEAR	ACK
+	MOVE	5, ReceiveMsgAddress + 2, WHEN MSG_IN
+	RETURN
+;
+; Come here from the message processor to ignore the message
+;
+	ENTRY	IgnoreMessage
+IgnoreMessage:
+	CLEAR	ACK
+	RETURN
+;
+; Come here to send a reply to a message
+;
+	ENTRY	SendMessageWithATN
+SendMessageWithATN:
+	SET	ATN
+	CLEAR	ACK
+	JUMP	SendMessage
+
+SendIdentifyMsg:
+	CALL	SendMessage
+	JUMP	SendCommand
+
+IgnoreMsgBeforeCommand:
+	CLEAR	ACK
+	ENTRY	SendCommand
+SendCommand:
+	JUMP	Finish, WHEN STATUS
+	JUMP	MsgInBeforeCommand, IF MSG_IN
+	INT	UNEXPECTED_PHASE_BEFORE_CMD, IF NOT CMD
+	MOVE	CommandCount, CommandAddress, WHEN CMD
+ResumeSendCommand:
+	JUMP	Finish, WHEN STATUS
+	JUMP	MsgInAfterCmd, IF MSG_IN
+	JUMP	DataIn, IF DATA_IN
+	JUMP	DataOut, IF DATA_OUT
+	INT	UNEXPECTED_PHASE_AFTER_CMD
+
+IgnoreMsgDuringData:
+	CLEAR	ACK
+	; fall through to MsgInDuringData
+
+Entry MsgInDuringData
+MsgInDuringData:
+;
+; Could be we have nothing more to transfer
+;
+	JUMP	Finish, WHEN STATUS
+	MOVE	1, ReceiveMsgAddress, WHEN MSG_IN
+	JUMP	DisconnectDuringDataIn, IF DISCONNECT_MSG
+	JUMP	IgnoreMsgDuringData, IF SAVE_DATA_PTRS_MSG
+	JUMP	IgnoreMsgDuringData, IF RESTORE_DATA_PTRS_MSG
+	INT	MSG_IN_DURING_DATA_IN
+
+MsgInAfterCmd:
+	MOVE	1, ReceiveMsgAddress, WHEN MSG_IN
+	JUMP	DisconnectAfterCmd, IF DISCONNECT_MSG
+	JUMP	IgnoreMsgInAfterCmd, IF SAVE_DATA_PTRS_MSG
+	JUMP	IgnoreMsgInAfterCmd, IF RESTORE_DATA_PTRS_MSG
+	CALL	ProcessReceiveMessage
+	INT	MSG_IN_AFTER_CMD
+	CLEAR	ACK
+	JUMP	ResumeSendCommand
+
+IgnoreMsgInAfterCmd:
+	CLEAR	ACK
+	JUMP	ResumeSendCommand
+
+DisconnectAfterCmd:
+	CLEAR	ACK
+	WAIT	DISCONNECT
+	ENTRY	Disconnect1
+Disconnect1:
+	INT	DISCONNECT_AFTER_CMD
+	ENTRY	Disconnect2
+Disconnect2:
+; We return here after a reselection
+	CLEAR	ACK
+	JUMP	ResumeSendCommand
+
+MsgInBeforeCommand:
+	MOVE	1, ReceiveMsgAddress, WHEN MSG_IN
+	JUMP	IgnoreMsgBeforeCommand, IF SAVE_DATA_PTRS_MSG
+	JUMP	IgnoreMsgBeforeCommand, IF RESTORE_DATA_PTRS_MSG
+	CALL	ProcessReceiveMessage
+	INT	MSG_IN_BEFORE_CMD
+	CLEAR	ACK
+	JUMP	SendCommand
+
+DataIn:
+	CALL	SGScriptStartAddress
+ResumeDataIn:
+	JUMP	Finish, WHEN STATUS
+	JUMP	MsgInAfterDataIn, IF MSG_IN
+	JUMP	DataInAfterDataIn, if DATA_IN
+	INT	MSG_OUT_AFTER_DATA_IN, if MSG_OUT
+	INT	UNEXPECTED_PHASE_AFTER_DATA_IN
+
+DataInAfterDataIn:
+	INT	DATA_IN_AFTER_DATA_IN
+	JUMP	ResumeDataIn
+
+DataOut:
+	CALL	SGScriptStartAddress
+ResumeDataOut:
+	JUMP	Finish, WHEN STATUS
+	JUMP	MsgInAfterDataOut, IF MSG_IN
+	INT	UNEXPECTED_PHASE_AFTER_DATA_OUT
+
+MsgInAfterDataIn:
+	MOVE	1, ReceiveMsgAddress, WHEN MSG_IN
+	JUMP	DisconnectAfterDataIn, IF DISCONNECT_MSG
+	JUMP	IgnoreMsgAfterData, IF SAVE_DATA_PTRS_MSG
+	JUMP	IgnoreMsgAfterData, IF RESTORE_DATA_PTRS_MSG
+	CALL	ProcessReceiveMessage
+	INT	MSG_IN_AFTER_DATA_IN
+	CLEAR	ACK
+	JUMP	ResumeDataIn
+
+DisconnectDuringDataIn:
+	CLEAR	ACK
+	WAIT	DISCONNECT
+	ENTRY	Disconnect3
+Disconnect3:
+	INT	DISCONNECT_DURING_DATA
+	ENTRY	Disconnect4
+Disconnect4:
+; we return here after a reselection
+	CLEAR	ACK
+	JUMP	ResumeSendCommand
+
+
+DisconnectAfterDataIn:
+	CLEAR	ACK
+	WAIT	DISCONNECT
+	ENTRY	Disconnect5
+Disconnect5:
+	INT	DISCONNECT_AFTER_DATA
+	ENTRY	Disconnect6
+Disconnect6:
+; we return here after a reselection
+	CLEAR	ACK
+	JUMP	ResumeDataIn
+
+MsgInAfterDataOut:
+	MOVE	1, ReceiveMsgAddress, WHEN MSG_IN
+	JUMP	DisconnectAfterDataOut, if DISCONNECT_MSG
+	JUMP	IgnoreMsgAfterData, IF SAVE_DATA_PTRS_MSG
+	JUMP	IgnoreMsgAfterData, IF RESTORE_DATA_PTRS_MSG
+	CALL	ProcessReceiveMessage
+	INT	MSG_IN_AFTER_DATA_OUT
+	CLEAR	ACK
+	JUMP	ResumeDataOut
+
+IgnoreMsgAfterData:
+	CLEAR	ACK
+; Data in and out do the same thing on resume, so pick one
+	JUMP	ResumeDataIn
+
+DisconnectAfterDataOut:
+	CLEAR	ACK
+	WAIT	DISCONNECT
+	ENTRY	Disconnect7
+Disconnect7:
+	INT	DISCONNECT_AFTER_DATA
+	ENTRY	Disconnect8
+Disconnect8:
+; we return here after a reselection
+	CLEAR	ACK
+	JUMP	ResumeDataOut
+
+Finish:
+	MOVE	1, StatusAddress, WHEN STATUS
+	INT	NOT_MSG_IN_AFTER_STATUS, WHEN NOT MSG_IN
+	CALL	ReceiveMessage
+	CLEAR	ACK
+	WAIT	DISCONNECT
+	ENTRY	Finish1
+Finish1:
+	INT	GOOD_STATUS_AFTER_STATUS
+	ENTRY	Finish2
+Finish2:
+
Index: linux/2.4/drivers/scsi/Config.in
diff -u linux/2.4/drivers/scsi/Config.in:1.1.1.8 linux/2.4/drivers/scsi/Config.in:1.1.1.8.4.1
--- linux/2.4/drivers/scsi/Config.in:1.1.1.8	Fri May  4 11:29:02 2001
+++ linux/2.4/drivers/scsi/Config.in	Fri May 11 20:15:26 2001
@@ -114,6 +114,7 @@
    fi
 fi
 dep_tristate 'NCR53c406a SCSI support' CONFIG_SCSI_NCR53C406A $CONFIG_SCSI
+dep_tristate 'NCR Dual 700 MCA SCSI support' CONFIG_SCSI_NCR_D700 $CONFIG_SCSI $CONFIG_MCA
 dep_tristate 'NCR53c7,8xx SCSI support'  CONFIG_SCSI_NCR53C7xx $CONFIG_SCSI $CONFIG_PCI
 if [ "$CONFIG_SCSI_NCR53C7xx" != "n" ]; then
    bool '  always negotiate synchronous transfers' CONFIG_SCSI_NCR53C7xx_sync
Index: linux/2.4/drivers/scsi/Makefile
diff -u linux/2.4/drivers/scsi/Makefile:1.1.1.8 linux/2.4/drivers/scsi/Makefile:1.1.1.8.4.1
--- linux/2.4/drivers/scsi/Makefile:1.1.1.8	Fri May  4 11:28:52 2001
+++ linux/2.4/drivers/scsi/Makefile	Fri May 11 20:15:26 2001
@@ -25,7 +25,7 @@
   endif
 endif
 
-export-objs	:= scsi_syms.o
+export-objs	:= scsi_syms.o 53c700.o
 
 CFLAGS_aha152x.o =   -DAHA152X_STAT -DAUTOCONF
 CFLAGS_gdth.o    = # -DDEBUG_GDTH=2 -D__SERIAL__ -D__COM2__ -DGDTH_STATISTICS
@@ -71,6 +71,7 @@
 obj-$(CONFIG_SCSI_IN2000)	+= in2000.o
 obj-$(CONFIG_SCSI_GENERIC_NCR5380) += g_NCR5380.o
 obj-$(CONFIG_SCSI_NCR53C406A)	+= NCR53c406a.o
+obj-$(CONFIG_SCSI_NCR_D700)	+= NCR_D700.o 53c700.o
 obj-$(CONFIG_SCSI_SYM53C416)	+= sym53c416.o
 obj-$(CONFIG_SCSI_QLOGIC_FAS)	+= qlogicfas.o
 obj-$(CONFIG_SCSI_QLOGIC_ISP)	+= qlogicisp.o 
@@ -184,3 +185,10 @@
 sim710_u.h: sim710_d.h
 
 sim710.o : sim710_d.h
+
+53c700_d.h: 53c700.scr script_asm.pl
+	$(PERL) -s script_asm.pl -ncr7x0_family < 53c700.scr
+	mv script.h 53c700_d.h
+	mv scriptu.h 53c700_u.h
+
+53c700.o: 53c700_d.h
Index: linux/2.4/drivers/scsi/NCR_D700.c
diff -u /dev/null linux/2.4/drivers/scsi/NCR_D700.c:1.1.8.4
--- /dev/null	Sat May 12 12:05:16 2001
+++ linux/2.4/drivers/scsi/NCR_D700.c	Sat May 12 11:52:50 2001
@@ -0,0 +1,327 @@
+/* -*- mode: c; c-basic-offset: 8 -*- */
+
+/* NCR Dual 700 MCA SCSI Driver
+ *
+ * Copyright (C) 2001 by James.Bottomley@HansenPartnership.com
+**-----------------------------------------------------------------------------
+**  
+**  This program is free software; you can redistribute it and/or modify
+**  it under the terms of the GNU General Public License as published by
+**  the Free Software Foundation; either version 2 of the License, or
+**  (at your option) any later version.
+**
+**  This program is distributed in the hope that it will be useful,
+**  but WITHOUT ANY WARRANTY; without even the implied warranty of
+**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+**  GNU General Public License for more details.
+**
+**  You should have received a copy of the GNU General Public License
+**  along with this program; if not, write to the Free Software
+**  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+**
+**-----------------------------------------------------------------------------
+ */
+
+/* Notes:
+ *
+ * Most of the work is done in the chip specific module, 53c700.o
+ *
+ * TODO List:
+ *
+ * 1. Extract the SCSI ID from the voyager CMOS table (necessary to
+ *    support multi-host environments.
+ *
+ * */
+
+
+/* CHANGELOG 
+ *
+ * Version 2.1
+ *
+ * Modularise the driver into a Board piece (this file) and a chip
+ * piece 53c700.[ch] and 53c700.scr, added module options.  You can
+ * now specify the scsi id by the parameters
+ *
+ * NCR_D700=slot:<n> [siop:<n>] id:<n> ....
+ *
+ * They need to be comma separated if compiled into the kernel
+ *
+ * Version 2.0
+ *
+ * Initial implementation of TCQ (Tag Command Queueing).  TCQ is full
+ * featured and uses the clock algorithm to keep track of outstanding
+ * tags and guard against individual tag starvation.  Also fixed a bug
+ * in all of the 1.x versions where the D700_data_residue() function
+ * was returning results off by 32 bytes (and thus causing the same 32
+ * bytes to be written twice corrupting the data block).  It turns out
+ * the 53c700 only has a 6 bit DBC and DFIFO registers not 7 bit ones
+ * like the 53c710 (The 710 is the only data manual still available,
+ * which I'd been using to program the 700).
+ *
+ * Version 1.2
+ *
+ * Much improved message handling engine
+ *
+ * Version 1.1
+ *
+ * Add code to handle selection reasonably correctly.  By the time we
+ * get the selection interrupt, we've already responded, but drop off the
+ * bus and hope the selector will go away.
+ *
+ * Version 1.0:
+ *
+ *   Initial release.  Fully functional except for procfs and tag
+ * command queueing.  Has only been tested on cards with 53c700-66
+ * chips and only single ended. Features are
+ *
+ * 1. Synchronous data transfers to offset 8 (limit of 700-66) and
+ *    100ns (10MHz) limit of SCSI-2
+ *
+ * 2. Disconnection and reselection
+ *
+ * Testing:
+ * 
+ *  I've only really tested this with the 700-66 chip, but have done
+ * soak tests in multi-device environments to verify that
+ * disconnections and reselections are being processed correctly.
+ * */
+
+#define NCR_D700_VERSION "2.1"
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+#include <linux/mca.h>
+#include <asm/dma.h>
+#include <asm/system.h>
+#include <asm/spinlock.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/byteorder.h>
+#include <linux/blk.h>
+
+#ifdef MODULE
+#include <linux/module.h>
+#endif
+
+
+#include "scsi.h"
+#include "hosts.h"
+#include "constants.h"
+
+#include "53c700.h"
+#include "NCR_D700.h"
+
+#ifndef CONFIG_MCA
+#error "NCR_D700 driver only compiles for MCA"
+#endif
+
+#ifdef NCR_D700_DEBUG
+#define STATIC
+#else
+#define STATIC static
+#endif
+
+#ifdef MODULE
+
+char *NCR_D700;			/* command line from insmod */
+
+MODULE_AUTHOR("James Bottomley");
+MODULE_DESCRIPTION("NCR Dual700 SCSI Driver");
+MODULE_PARM(NCR_D700, "s");
+
+#endif
+
+static __u8 __initdata id_array[2*(MCA_MAX_SLOT_NR + 1)] =
+	{ [0 ... 2*(MCA_MAX_SLOT_NR + 1)-1] = 7 };
+
+#ifdef MODULE
+#define ARG_SEP ' '
+#else
+#define ARG_SEP ','
+#endif
+
+static int __init
+param_setup(char *string)
+{
+	char *pos = string, *next;
+	int slot = -1, siop = -1;
+
+	while(pos != NULL && (next = strchr(pos, ':')) != NULL) {
+		int val = (int)simple_strtoul(++next, NULL, 0);
+
+		if(!strncmp(pos, "slot:", 5))
+			slot = val;
+		else if(!strncmp(pos, "siop:", 5))
+			siop = val;
+		else if(!strncmp(pos, "id:", 3)) {
+			if(slot == -1) {
+				printk(KERN_WARNING "NCR D700: Must specify slot for id parameter\n");
+			} else if(slot > MCA_MAX_SLOT_NR) {
+				printk(KERN_WARNING "NCR D700: Illegal slot %d for id %d\n", slot, val);
+			} else {
+				if(siop != 0 && siop != 1) {
+					id_array[slot*2] = val;
+					id_array[slot*2 + 1] =val;
+				} else {
+					id_array[slot*2 + siop] = val;
+				}
+			}
+		}
+		if((pos = strchr(pos, ARG_SEP)) != NULL)
+			pos++;
+	}
+	return 1;
+}
+
+#ifndef MODULE
+__setup("NCR_D700=", param_setup);
+#endif
+
+/* Detect a D700 card.  Note, because of the set up---the chips are
+ * essentially connectecd to the MCA bus independently, it is easier
+ * to set them up as two separate host adapters, rather than one
+ * adapter with two channels */
+STATIC int __init
+D700_detect(Scsi_Host_Template *tpnt)
+{
+	int slot = 0;
+	int found = 0;
+	int differential;
+	int banner = 1;
+
+	if(!MCA_bus)
+		return 0;
+
+#ifdef MODULE
+	if(NCR_D700)
+		param_setup(NCR_D700);
+#endif
+
+	for(slot = 0; (slot = mca_find_adapter(NCR_D700_MCA_ID, slot)) != MCA_NOTFOUND; slot++) {
+		int irq, i;
+		int pos3j, pos3k, pos3a, pos3b, pos4;
+		__u32 base_addr, offset_addr;
+		struct Scsi_Host *host = NULL;
+
+		/* enable board interrupt */
+		pos4 = mca_read_pos(slot, 4);
+		pos4 |= 0x4;
+		mca_write_pos(slot, 4, pos4);
+
+		mca_write_pos(slot, 6, 9);
+		pos3j = mca_read_pos(slot, 3);
+		mca_write_pos(slot, 6, 10);
+		pos3k = mca_read_pos(slot, 3);
+		mca_write_pos(slot, 6, 0);
+		pos3a = mca_read_pos(slot, 3);
+		mca_write_pos(slot, 6, 1);
+		pos3b = mca_read_pos(slot, 3);
+
+		base_addr = ((pos3j << 8) | pos3k) & 0xfffffff0;
+		offset_addr = ((pos3a << 8) | pos3b) & 0xffffff70;
+
+		irq = (pos4 & 0x3) + 11;
+		if(irq >= 13)
+			irq++;
+		if(banner) {
+			printk(KERN_NOTICE "NCR D700: Driver Version " NCR_D700_VERSION "\n"
+			       "NCR D700:  Copyright (c) 2001 by James.Bottomley@HansenPartnership.com\n"
+			       "NCR D700:\n");
+			banner = 0;
+		}
+		printk(KERN_NOTICE "NCR D700: found in slot %d  irq = %d  I/O base = 0x%x\n", slot, irq, offset_addr);
+
+		tpnt->proc_name = "NCR_D700";
+
+		/*outb(BOARD_RESET, base_addr);*/
+
+		/* clear any pending interrupts */
+		(void)inb(base_addr + 0x08);
+		/* get modctl, used later for setting diff bits */
+		switch(differential = (inb(base_addr + 0x08) >> 6)) {
+		case 0x00:
+			/* only SIOP1 differential */
+			differential = 0x02;
+			break;
+		case 0x01:
+			/* Both SIOPs differential */
+			differential = 0x03;
+			break;
+		case 0x03:
+			/* No SIOPs differential */
+			differential = 0x00;
+			break;
+		default:
+			printk(KERN_ERR "D700: UNEXPECTED DIFFERENTIAL RESULT 0x%02x\n",
+			       differential);
+			differential = 0x00;
+			break;
+		}
+
+		/* plumb in both 700 chips */
+		for(i=0; i<2; i++) {
+			__u32 region = offset_addr | (0x80 * i);
+			struct NCR_700_Host_Parameters *hostdata =
+				kmalloc(sizeof(struct NCR_700_Host_Parameters),
+					GFP_KERNEL);
+			if(hostdata == NULL) {
+				printk(KERN_ERR "NCR D700: Failed to allocate host data for channel %d, detatching\n", i);
+				continue;
+			}
+			memset(hostdata, 0, sizeof(struct NCR_700_Host_Parameters));
+			request_region(region, 64, "NCR_D700");
+
+			/* Fill in the three required pieces of hostdata */
+			hostdata->base = region;
+			hostdata->differential = (((1<<i) & differential) != 0);
+			hostdata->clock = NCR_D700_CLOCK_MHZ;
+			/* and register the chip */
+			if((host = NCR_700_detect(tpnt, hostdata)) == NULL) {
+				kfree(hostdata);
+				continue;
+			}
+			host->irq = irq;
+			/* FIXME: Read this from SUS */
+			host->this_id = id_array[slot * 2 + i];
+			printk(KERN_NOTICE "NCR D700: SIOP%d, SCSI id is %d\n",
+			       i, host->this_id);
+			if(request_irq(irq, NCR_700_intr, SA_SHIRQ, "NCR_D700", host)) {
+				printk(KERN_ERR "NCR D700, channel %d: irq problem, detatching\n", i);
+				NCR_700_release(host);
+				release_region(host->base, 64);
+				continue;
+			}
+			found++;
+		}
+	}
+
+	return found;
+}
+
+
+STATIC int
+D700_release(struct Scsi_Host *host)
+{
+	struct D700_Host_Parameters *hostdata = 
+		(struct D700_Host_Parameters *)host->hostdata[0];
+
+	NCR_700_release(host);
+	kfree(hostdata);
+	free_irq(host->irq, host);
+	release_region(host->base, 64);
+	return 1;
+}
+
+
+static Scsi_Host_Template driver_template = NCR_D700_SCSI;
+
+#include "scsi_module.c"
+
Index: linux/2.4/drivers/scsi/NCR_D700.h
diff -u /dev/null linux/2.4/drivers/scsi/NCR_D700.h:1.1.8.1
--- /dev/null	Sat May 12 12:05:16 2001
+++ linux/2.4/drivers/scsi/NCR_D700.h	Sat May 12 10:39:20 2001
@@ -0,0 +1,45 @@
+/* -*- mode: c; c-basic-offset: 8 -*- */
+
+/* NCR Dual 700 MCA SCSI Driver
+ *
+ * Copyright (C) 2001 by James.Bottomley@HansenPartnership.com
+ */
+
+#ifndef _NCR_D700_H
+#define _NCR_D700_H
+
+/* Don't turn on debugging messages */
+#undef NCR_D700_DEBUG
+
+/* The MCA identifier */
+#define NCR_D700_MCA_ID		0x0092
+
+static int D700_detect(Scsi_Host_Template *);
+static int D700_release(struct Scsi_Host *host);
+
+
+/* Host template.  Note the name and proc_name are optional, all the
+ * remaining parameters shown below must be filled in.  The 53c700
+ * routine NCR_700_detect will fill in all of the missing routines */
+#define NCR_D700_SCSI {						\
+	name:				"NCR Dual 700 MCA",	\
+	proc_name:			"NCR_D700",		\
+	detect: 			D700_detect,		\
+	release:			D700_release,		\
+	this_id:			7,			\
+}
+
+
+/* Defines for the Board registers */
+#define	BOARD_RESET		0x80	/* board level reset */
+#define ADD_PARENB		0x04	/* Address Parity Enabled */
+#define DAT_PARENB		0x01	/* Data Parity Enabled */
+#define SFBK_ENB		0x10	/* SFDBK Interrupt Enabled */
+#define LED0GREEN		0x20	/* Led 0 (red 0; green 1) */
+#define LED1GREEN		0x40	/* Led 1 (red 0; green 1) */
+#define LED0RED			0xDF	/* Led 0 (red 0; green 1) */
+#define LED1RED			0xBF	/* Led 1 (red 0; green 1) */
+
+#define NCR_D700_CLOCK_MHZ	50
+
+#endif
Index: linux/2.4/drivers/scsi/README.53c700
diff -u /dev/null linux/2.4/drivers/scsi/README.53c700:1.1.4.2
--- /dev/null	Sat May 12 12:05:16 2001
+++ linux/2.4/drivers/scsi/README.53c700	Sat May 12 12:03:57 2001
@@ -0,0 +1,17 @@
+This driver supports the 53c700 and 53c700-66 chips only.  It is full
+featured and does sync (-66 only), disconnects and tag command
+queueing.
+
+Since the 53c700 must be interfaced to a bus, you need to wrapper the
+card detector around this driver.  For an example, see the
+NCR_D700.[ch] files.
+
+The comments in the 53c700.[ch] files tell you which parts you need to
+fill in to get the driver working.
+
+The driver is currently I/O mapped only, but it should be easy enough
+to memory map (just make the port reads #defines with MEM_MAPPED for
+memory mapping or nothing for I/O mapping, specify an extra rule for
+53c700-mem.o with the -DMEM_MAPPED flag and make your driver use it,
+that way the make rules will generate the correct version).
+

--==_Exmh_5367807680--


