Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753356AbWKFUOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356AbWKFUOa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbWKFUO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:14:29 -0500
Received: from palrel13.hp.com ([156.153.255.238]:19620 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S1753179AbWKFUO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:14:28 -0500
Date: Mon, 6 Nov 2006 14:14:27 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, jens.axboe@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 3/12] repost: cciss: increase number of commands on controller
Message-ID: <20061106201427.GC17847@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 3/11

This patch removes #define NR_CMDS and replaces it w/hba[i]->nr_cmds. Most
Smart Array controllers can support up to 1024 commands but the E200 family
can only support 128. To prevent annoying "fifo full" messages we define
nr_cmds on a per controller basis by adding it the product table.
Please consider this for inclusion.

Thanks,
mikem

Signed-off-by: Mike Miller <mike.miller@hp.com>

--------------------------------------------------------------------------------
---

 drivers/block/cciss.c |   74 +++++++++++++++++++++++++-------------------------
 drivers/block/cciss.h |    2 +
 2 files changed, 40 insertions(+), 36 deletions(-)

diff -puN drivers/block/cciss.c~cciss_nr_cmds_for_lx2619-rc2 drivers/block/cciss.c
--- linux-2.6/drivers/block/cciss.c~cciss_nr_cmds_for_lx2619-rc2	2006-11-06 13:15:45.000000000 -0600
+++ linux-2.6-root/drivers/block/cciss.c	2006-11-06 13:15:45.000000000 -0600
@@ -93,28 +93,29 @@ MODULE_DEVICE_TABLE(pci, cciss_pci_devic
 /*  board_id = Subsystem Device ID & Vendor ID
  *  product = Marketing Name for the board
  *  access = Address of the struct of function pointers
+ *  nr_cmds = Number of commands supported by controller
  */
 static struct board_type products[] = {
-	{0x40700E11, "Smart Array 5300", &SA5_access},
-	{0x40800E11, "Smart Array 5i", &SA5B_access},
-	{0x40820E11, "Smart Array 532", &SA5B_access},
-	{0x40830E11, "Smart Array 5312", &SA5B_access},
-	{0x409A0E11, "Smart Array 641", &SA5_access},
-	{0x409B0E11, "Smart Array 642", &SA5_access},
-	{0x409C0E11, "Smart Array 6400", &SA5_access},
-	{0x409D0E11, "Smart Array 6400 EM", &SA5_access},
-	{0x40910E11, "Smart Array 6i", &SA5_access},
-	{0x3225103C, "Smart Array P600", &SA5_access},
-	{0x3223103C, "Smart Array P800", &SA5_access},
-	{0x3234103C, "Smart Array P400", &SA5_access},
-	{0x3235103C, "Smart Array P400i", &SA5_access},
-	{0x3211103C, "Smart Array E200i", &SA5_access},
-	{0x3212103C, "Smart Array E200", &SA5_access},
-	{0x3213103C, "Smart Array E200i", &SA5_access},
-	{0x3214103C, "Smart Array E200i", &SA5_access},
-	{0x3215103C, "Smart Array E200i", &SA5_access},
-	{0x3233103C, "Smart Array E500", &SA5_access},
-	{0xFFFF103C, "Unknown Smart Array", &SA5_access},
+	{0x40700E11, "Smart Array 5300", &SA5_access, 512},
+	{0x40800E11, "Smart Array 5i", &SA5B_access, 512},
+	{0x40820E11, "Smart Array 532", &SA5B_access, 512},
+	{0x40830E11, "Smart Array 5312", &SA5B_access, 512},
+	{0x409A0E11, "Smart Array 641", &SA5_access, 512},
+	{0x409B0E11, "Smart Array 642", &SA5_access, 512},
+	{0x409C0E11, "Smart Array 6400", &SA5_access, 512},
+	{0x409D0E11, "Smart Array 6400 EM", &SA5_access, 512},
+	{0x40910E11, "Smart Array 6i", &SA5_access, 512},
+	{0x3225103C, "Smart Array P600", &SA5_access, 512},
+	{0x3223103C, "Smart Array P800", &SA5_access, 512},
+	{0x3234103C, "Smart Array P400", &SA5_access, 512},
+	{0x3235103C, "Smart Array P400i", &SA5_access, 512},
+	{0x3211103C, "Smart Array E200i", &SA5_access, 120},
+	{0x3212103C, "Smart Array E200", &SA5_access, 120},
+	{0x3213103C, "Smart Array E200i", &SA5_access, 120},
+	{0x3214103C, "Smart Array E200i", &SA5_access, 120},
+	{0x3215103C, "Smart Array E200i", &SA5_access, 120},
+	{0x3233103C, "Smart Array E500", &SA5_access, 512},
+	{0xFFFF103C, "Unknown Smart Array", &SA5_access, 120},
 };
 
 /* How long to wait (in milliseconds) for board to go into simple mode */
@@ -125,7 +126,6 @@ static struct board_type products[] = {
 #define MAX_CMD_RETRIES 3
 
 #define READ_AHEAD 	 1024
-#define NR_CMDS		 384	/* #commands that can be outstanding */
 #define MAX_CTLR	32
 
 /* Originally cciss driver only supports 8 major numbers */
@@ -404,8 +404,8 @@ static CommandList_struct *cmd_alloc(ctl
 	} else {		/* get it out of the controllers pool */
 
 		do {
-			i = find_first_zero_bit(h->cmd_pool_bits, NR_CMDS);
-			if (i == NR_CMDS)
+			i = find_first_zero_bit(h->cmd_pool_bits, h->nr_cmds);
+			if (i == h->nr_cmds)
 				return NULL;
 		} while (test_and_set_bit
 			 (i & (BITS_PER_LONG - 1),
@@ -1247,7 +1247,7 @@ static void cciss_check_queues(ctlr_info
 	 * in case the interrupt we serviced was from an ioctl and did not
 	 * free any new commands.
 	 */
-	if ((find_first_zero_bit(h->cmd_pool_bits, NR_CMDS)) == NR_CMDS)
+	if ((find_first_zero_bit(h->cmd_pool_bits, h->nr_cmds)) == h->nr_cmds)
 		return;
 
 	/* We have room on the queue for more commands.  Now we need to queue
@@ -1266,7 +1266,7 @@ static void cciss_check_queues(ctlr_info
 		/* check to see if we have maxed out the number of commands
 		 * that can be placed on the queue.
 		 */
-		if ((find_first_zero_bit(h->cmd_pool_bits, NR_CMDS)) == NR_CMDS) {
+		if ((find_first_zero_bit(h->cmd_pool_bits, h->nr_cmds)) == h->nr_cmds) {
 			if (curr_queue == start_queue) {
 				h->next_to_run =
 				    (start_queue + 1) % (h->highest_lun + 1);
@@ -2134,7 +2134,7 @@ static int add_sendcmd_reject(__u8 cmd, 
 
 	/* We've sent down an abort or reset, but something else
 	   has completed */
-	if (srl->ncompletions >= (NR_CMDS + 2)) {
+	if (srl->ncompletions >= (hba[ctlr]->nr_cmds + 2)) {
 		/* Uh oh.  No room to save it for later... */
 		printk(KERN_WARNING "cciss%d: Sendcmd: Invalid command addr, "
 		       "reject list overflow, command lost!\n", ctlr);
@@ -2671,7 +2671,7 @@ static irqreturn_t do_cciss_intr(int irq
 			a1 = a;
 			if ((a & 0x04)) {
 				a2 = (a >> 3);
-				if (a2 >= NR_CMDS) {
+				if (a2 >= h->nr_cmds) {
 					printk(KERN_WARNING
 					       "cciss: controller cciss%d failed, stopping.\n",
 					       h->ctlr);
@@ -2954,6 +2954,7 @@ static int cciss_pci_init(ctlr_info_t *c
 		if (board_id == products[i].board_id) {
 			c->product_name = products[i].product_name;
 			c->access = *(products[i].access);
+			c->nr_cmds = products[i].nr_cmds;
 			break;
 		}
 	}
@@ -2973,6 +2974,7 @@ static int cciss_pci_init(ctlr_info_t *c
 		if (subsystem_vendor_id == PCI_VENDOR_ID_HP) {
 			c->product_name = products[i-1].product_name;
 			c->access = *(products[i-1].access);
+			c->nr_cmds = products[i-1].nr_cmds;
 			printk(KERN_WARNING "cciss: This is an unknown "
 				"Smart Array controller.\n"
 				"cciss: Please update to the latest driver "
@@ -3280,15 +3282,15 @@ static int __devinit cciss_init_one(stru
 	       hba[i]->intr[SIMPLE_MODE_INT], dac ? "" : " not");
 
 	hba[i]->cmd_pool_bits =
-	    kmalloc(((NR_CMDS + BITS_PER_LONG -
+	    kmalloc(((hba[i]->nr_cmds + BITS_PER_LONG -
 		      1) / BITS_PER_LONG) * sizeof(unsigned long), GFP_KERNEL);
 	hba[i]->cmd_pool = (CommandList_struct *)
 	    pci_alloc_consistent(hba[i]->pdev,
-		    NR_CMDS * sizeof(CommandList_struct),
+		    hba[i]->nr_cmds * sizeof(CommandList_struct),
 		    &(hba[i]->cmd_pool_dhandle));
 	hba[i]->errinfo_pool = (ErrorInfo_struct *)
 	    pci_alloc_consistent(hba[i]->pdev,
-		    NR_CMDS * sizeof(ErrorInfo_struct),
+		    hba[i]->nr_cmds * sizeof(ErrorInfo_struct),
 		    &(hba[i]->errinfo_pool_dhandle));
 	if ((hba[i]->cmd_pool_bits == NULL)
 	    || (hba[i]->cmd_pool == NULL)
@@ -3299,7 +3301,7 @@ static int __devinit cciss_init_one(stru
 #ifdef CONFIG_CISS_SCSI_TAPE
 	hba[i]->scsi_rejects.complete =
 	    kmalloc(sizeof(hba[i]->scsi_rejects.complete[0]) *
-		    (NR_CMDS + 5), GFP_KERNEL);
+		    (hba[i]->nr_cmds + 5), GFP_KERNEL);
 	if (hba[i]->scsi_rejects.complete == NULL) {
 		printk(KERN_ERR "cciss: out of memory");
 		goto clean4;
@@ -3313,7 +3315,7 @@ static int __devinit cciss_init_one(stru
 	/* command and error info recs zeroed out before
 	   they are used */
 	memset(hba[i]->cmd_pool_bits, 0,
-	       ((NR_CMDS + BITS_PER_LONG -
+	       ((hba[i]->nr_cmds + BITS_PER_LONG -
 		 1) / BITS_PER_LONG) * sizeof(unsigned long));
 
 #ifdef CCISS_DEBUG
@@ -3382,11 +3384,11 @@ static int __devinit cciss_init_one(stru
 	kfree(hba[i]->cmd_pool_bits);
 	if (hba[i]->cmd_pool)
 		pci_free_consistent(hba[i]->pdev,
-				    NR_CMDS * sizeof(CommandList_struct),
+				    hba[i]->nr_cmds * sizeof(CommandList_struct),
 				    hba[i]->cmd_pool, hba[i]->cmd_pool_dhandle);
 	if (hba[i]->errinfo_pool)
 		pci_free_consistent(hba[i]->pdev,
-				    NR_CMDS * sizeof(ErrorInfo_struct),
+				    hba[i]->nr_cmds * sizeof(ErrorInfo_struct),
 				    hba[i]->errinfo_pool,
 				    hba[i]->errinfo_pool_dhandle);
 	free_irq(hba[i]->intr[SIMPLE_MODE_INT], hba[i]);
@@ -3453,9 +3455,9 @@ static void __devexit cciss_remove_one(s
 		}
 	}
 
-	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof(CommandList_struct),
+	pci_free_consistent(hba[i]->pdev, hba[i]->nr_cmds * sizeof(CommandList_struct),
 			    hba[i]->cmd_pool, hba[i]->cmd_pool_dhandle);
-	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof(ErrorInfo_struct),
+	pci_free_consistent(hba[i]->pdev, hba[i]->nr_cmds * sizeof(ErrorInfo_struct),
 			    hba[i]->errinfo_pool, hba[i]->errinfo_pool_dhandle);
 	kfree(hba[i]->cmd_pool_bits);
 #ifdef CONFIG_CISS_SCSI_TAPE
diff -puN drivers/block/cciss.h~cciss_nr_cmds_for_lx2619-rc2 drivers/block/cciss.h
--- linux-2.6/drivers/block/cciss.h~cciss_nr_cmds_for_lx2619-rc2	2006-11-06 13:15:45.000000000 -0600
+++ linux-2.6-root/drivers/block/cciss.h	2006-11-06 13:15:45.000000000 -0600
@@ -60,6 +60,7 @@ struct ctlr_info 
 	__u32	board_id;
 	void __iomem *vaddr;
 	unsigned long paddr;
+	int 	nr_cmds; /* Number of commands allowed on this controller */
 	CfgTable_struct __iomem *cfgtable;
 	int	interrupts_enabled;
 	int	major;
@@ -282,6 +283,7 @@ struct board_type {
 	__u32	board_id;
 	char	*product_name;
 	struct access_method *access;
+	int nr_cmds; /* Max cmds this kind of ctlr can handle. */
 };
 
 #define CCISS_LOCK(i)	(&hba[i]->lock)
_
