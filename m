Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267697AbTBLTM2>; Wed, 12 Feb 2003 14:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267729AbTBLTM2>; Wed, 12 Feb 2003 14:12:28 -0500
Received: from ztxmail01.ztx.compaq.com ([161.114.1.205]:38407 "EHLO
	ztxmail01.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S267697AbTBLTMO>; Wed, 12 Feb 2003 14:12:14 -0500
Date: Wed, 12 Feb 2003 13:22:37 +0600
From: steve cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: Re: [PATCH] 2.5.60 make cciss driver compile
Message-ID: <20030212072237.GI1032@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Remove udelay in command polling routine
* extend timeout to 20 seconds (need for certain multiport storage box)
* Remove unneeded init time code in cciss_scsi.c (thus allowing removal
   of udelay in command polling code.)
(patch 9 of 11)
-- steve

--- linux-2.5.60/drivers/block/cciss.c~20_sec_timeout	2003-02-12 10:13:14.000000000 +0600
+++ linux-2.5.60-scameron/drivers/block/cciss.c	2003-02-12 10:13:14.000000000 +0600
@@ -1236,24 +1236,25 @@ free_err:
 /*
  *   Wait polling for a command to complete.
  *   The memory mapped FIFO is polled for the completion.
- *   Used only at init time, interrupts disabled.
+ *   Used only at init time, interrupts from the HBA are disabled.
  */
 static unsigned long pollcomplete(int ctlr)
 {
-        unsigned long done;
-        int i;
+	unsigned long done;
+	int i;
 
-        /* Wait (up to 2 seconds) for a command to complete */
+	/* Wait (up to 20 seconds) for a command to complete */
 
-        for (i = 200000; i > 0; i--) {
-                done = hba[ctlr]->access.command_completed(hba[ctlr]);
-                if (done == FIFO_EMPTY) {
-                        udelay(10);     /* a short fixed delay */
-                } else
-                        return (done);
-        }
-        /* Invalid address to tell caller we ran out of time */
-        return 1;
+	for (i = 20 * HZ; i > 0; i--) {
+		done = hba[ctlr]->access.command_completed(hba[ctlr]);
+		if (done == FIFO_EMPTY) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(1);
+		} else
+			return (done);
+	}
+	/* Invalid address to tell caller we ran out of time */
+	return 1;
 }
 /*
  * Send a command to the controller, and wait for it to complete.  
@@ -2402,7 +2403,7 @@ static int __init cciss_init_one(struct 
 
 	cciss_getgeometry(i);
 
-	cciss_find_non_disk_devices(i);	/* find our tape drives, if any */
+	cciss_scsi_setup(i);
 
 	/* Turn the interrupts on so we can service requests */
 	hba[i]->access.set_intr_mask(hba[i], CCISS_INTR_ON);
--- linux-2.5.60/drivers/block/cciss_scsi.c~20_sec_timeout	2003-02-12 10:13:14.000000000 +0600
+++ linux-2.5.60-scameron/drivers/block/cciss_scsi.c	2003-02-12 10:13:14.000000000 +0600
@@ -201,14 +201,12 @@ scsi_cmd_free(ctlr_info_t *h, CommandLis
 }
 
 static int
-scsi_cmd_stack_setup(int ctlr)
+scsi_cmd_stack_setup(int ctlr, struct cciss_scsi_adapter_data_t *sa)
 {
 	int i;
-	struct cciss_scsi_adapter_data_t *sa;
 	struct cciss_scsi_cmd_stack_t *stk;
 	size_t size;
 
-	sa = (struct cciss_scsi_adapter_data_t *) hba[ctlr]->scsi_ctlr;
 	stk = &sa->cmd_stack; 
 	size = sizeof(struct cciss_scsi_cmd_stack_elem_t) * CMD_STACK_SIZE;
 
@@ -537,126 +535,24 @@ lookup_scsi3addr(int ctlr, int bus, int 
 	return -1;
 }
 
-
 static void 
-cciss_find_non_disk_devices(int cntl_num)
+cciss_scsi_setup(int cntl_num)
 {
-	ReportLunData_struct *ld_buff;
-	InquiryData_struct *inq_buff;
-	int return_code;
-	int i;
-	int listlength = 0;
-	int num_luns;
-	unsigned char scsi3addr[8];
-	unsigned long flags;
-	int reportlunsize = sizeof(*ld_buff) + CISS_MAX_PHYS_LUN * 8;
+	struct cciss_scsi_adapter_data_t * shba;
 
-	hba[cntl_num]->scsi_ctlr = (void *)
-		kmalloc(sizeof(struct cciss_scsi_adapter_data_t),
-			GFP_KERNEL);	
-	if (hba[cntl_num]->scsi_ctlr == NULL)
-		return;
-
-	((struct cciss_scsi_adapter_data_t *) 
-		hba[cntl_num]->scsi_ctlr)->scsi_host = NULL;
-	((struct cciss_scsi_adapter_data_t *) 
-		hba[cntl_num]->scsi_ctlr)->lock = SPIN_LOCK_UNLOCKED;
-	((struct cciss_scsi_adapter_data_t *) 
-		hba[cntl_num]->scsi_ctlr)->registered = 0;
-
-	if (scsi_cmd_stack_setup(cntl_num) != 0) {
-		printk("Trouble, returned non-zero!\n");
-		return;
-	}
-
-	ld_buff = kmalloc(reportlunsize, GFP_KERNEL);
-	if (ld_buff == NULL) {
-		printk(KERN_ERR "cciss: out of memory\n");
-		return;
-	}
-	memset(ld_buff, 0, sizeof(ReportLunData_struct));
-	inq_buff = kmalloc(sizeof( InquiryData_struct), GFP_KERNEL);
-        if (inq_buff == NULL) {
-                printk(KERN_ERR "cciss: out of memory\n");
-                kfree(ld_buff);
-                return;
-        }
-
-	/* Get the physical luns */ 
-	return_code = sendcmd(CISS_REPORT_PHYS, cntl_num, ld_buff, 
-			reportlunsize, 0, 0, 0, NULL );
-
-	if( return_code == IO_OK) {
-		unsigned char *c = &ld_buff->LUNListLength[0];
-		listlength = (c[0] << 24) | (c[1] << 16) | (c[2] << 8) | c[3];
-	} 
-	else {  /* getting report of physical luns failed */
-		printk(KERN_WARNING "cciss: report physical luns"
-			" command failed\n");
-		listlength = 0;
-	}
-
-	CPQ_TAPE_LOCK(cntl_num, flags);
 	ccissscsi[cntl_num].ndevices = 0;
-	num_luns = listlength / 8; // 8 bytes pre entry
-	/* printk("Found %d LUNs\n", num_luns); */
-
-	if (num_luns > CISS_MAX_PHYS_LUN)
-	{
-		printk(KERN_WARNING 
-			"cciss: Maximum physical LUNs (%d) exceeded.  "
-			"%d LUNs ignored.\n", CISS_MAX_PHYS_LUN, 
-			num_luns - CISS_MAX_PHYS_LUN);
-		num_luns = CISS_MAX_PHYS_LUN;
-	}
-
-	for(i=0; i<num_luns; i++) {
-		/* Execute an inquiry to figure the device type */
-		memset(inq_buff, 0, sizeof(InquiryData_struct));
-		memcpy(scsi3addr, ld_buff->LUN[i], 8); /* ugly... */
-		return_code = sendcmd(CISS_INQUIRY, cntl_num, inq_buff,
-                	sizeof(InquiryData_struct), 2, 0 ,0, scsi3addr );
-	  	if (return_code == IO_OK) {
-			if(inq_buff->data_byte[8] == 0xFF)
-			{
-			   printk(KERN_WARNING "cciss: inquiry failed\n");
-                        } else {
-			   int devtype;
-
-			   /* printk("Inquiry...\n");
-			   print_bytes((unsigned char *) inq_buff, 36, 1, 1); */
-			   devtype = (inq_buff->data_byte[0] & 0x1f);
-
-			   switch (devtype)
-			   {
-			    case 0x01: /* sequential access, (tape) */
-			    case 0x08: /* medium changer */
-					  /* this is the only kind of dev */
-					  /* we want to expose here. */
-				if (cciss_scsi_add_entry(cntl_num, -1,
-					(unsigned char *) ld_buff->LUN[i],
-					devtype) != 0) 
-						i=num_luns; // leave loop
-				break;
-			    default: 
-				break;
-			   }
-
-			}
-		}
-		else printk("cciss: inquiry failed.\n");
+	shba = (struct cciss_scsi_adapter_data_t *)
+		kmalloc(sizeof(*shba), GFP_KERNEL);	
+	if (shba == NULL)
+		return;
+	shba->scsi_host = NULL;
+	shba->lock = SPIN_LOCK_UNLOCKED;
+	shba->registered = 0;
+	if (scsi_cmd_stack_setup(cntl_num, shba) != 0) {
+		kfree(shba);
+		shba = NULL;
 	}
-#if 0
-	for (i=0;i<ccissscsi[cntl_num].ndevices;i++)
-		printk("Tape device presented at c%db%dt%dl%d\n", 
-			cntl_num, // <-- this is wrong
-			ccissscsi[cntl_num].dev[i].bus,
-			ccissscsi[cntl_num].dev[i].target,
-			ccissscsi[cntl_num].dev[i].lun);
-#endif			
-	CPQ_TAPE_UNLOCK(cntl_num, flags);
-	kfree(ld_buff);
-	kfree(inq_buff);
+	hba[cntl_num]->scsi_ctlr = (void *) shba;
 	return;
 }
 
@@ -1603,7 +1499,7 @@ cciss_proc_tape_report(int ctlr, unsigne
 
 /* If no tape support, then these become defined out of existence */
 
-#define cciss_find_non_disk_devices(cntl_num)
+#define cciss_scsi_setup(cntl_num)
 #define cciss_unregister_scsi(ctlr)
 #define cciss_register_scsi(ctlr)
 #define cciss_proc_tape_report(ctlr, buffer, pos, len)

_
