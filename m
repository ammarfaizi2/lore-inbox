Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263017AbTCSMUT>; Wed, 19 Mar 2003 07:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263012AbTCSMUI>; Wed, 19 Mar 2003 07:20:08 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:56967 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S262991AbTCSMQ7>;
	Wed, 19 Mar 2003 07:16:59 -0500
Date: Wed, 19 Mar 2003 13:27:42 +0100 (MET)
Message-Id: <200303191227.h2JCRg200889@vervain.sonytel.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k SCSI driver updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k SCSI drivers: update for the changes in 2.5.60:
  o Replace `->lun'    by `->device->lun'
  o Replace `->target' by `->device->id'
  o Replace `->host'   by `->device->host'

--- linux-2.5.x/drivers/scsi/NCR53C9x.c	Sun Mar  2 17:39:02 2003
+++ linux-m68k-2.5.x/drivers/scsi/NCR53C9x.c	Fri Feb 14 13:25:53 2003
@@ -1099,7 +1099,7 @@
 		 * disconnect.
 		 */
 		ESPMISC(("esp: Selecting device for first time. target=%d "
-			 "lun=%d\n", target, SCptr->lun));
+			 "lun=%d\n", target, SCptr->device->lun));
 		if(!SDptr->borken && !esp_dev->disconnect)
 			esp_dev->disconnect = 1;
 
@@ -1173,7 +1173,7 @@
 		if(((SDptr->scsi_level < 3) && (SDptr->type != TYPE_TAPE)) ||
 		   toshiba_cdrom_hwbug_wkaround || SDptr->borken) {
 			ESPMISC((KERN_INFO "esp%d: Disabling DISCONNECT for target %d "
-				 "lun %d\n", esp->esp_id, SCptr->target, SCptr->lun));
+				 "lun %d\n", esp->esp_id, SCptr->device->id, SCptr->device->lun));
 			esp_dev->disconnect = 0;
 			*cmdp++ = IDENTIFY(0, lun);
 		} else {
@@ -1255,8 +1255,8 @@
 		esp->dma_led_on(esp);
 
 	/* We use the scratch area. */
-	ESPQUEUE(("esp_queue: target=%d lun=%d ", SCpnt->target, SCpnt->lun));
-	ESPDISC(("N<%02x,%02x>", SCpnt->target, SCpnt->lun));
+	ESPQUEUE(("esp_queue: target=%d lun=%d ", SCpnt->device->id, SCpnt->lun));
+	ESPDISC(("N<%02x,%02x>", SCpnt->device->id, SCpnt->lun));
 
 	esp_get_dmabufs(esp, SCpnt);
 	esp_save_pointers(esp, SCpnt); /* FIXME for tag queueing */
@@ -2235,7 +2235,7 @@
 			 * state.
 			 */
 			ESPMISC(("esp: Status <%d> for target %d lun %d\n",
-				 SCptr->SCp.Status, SCptr->target, SCptr->lun));
+				 SCptr->SCp.Status, SCptr->device->id, SCptr->device->lun));
 
 			/* But don't do this when spinning up a disk at
 			 * boot time while we poll for completion as it
@@ -2246,14 +2246,14 @@
 			if(esp_should_clear_sync(SCptr) != 0)
 				esp_dev->sync = 0;
 		}
-		ESPDISC(("F<%02x,%02x>", SCptr->target, SCptr->lun));
+		ESPDISC(("F<%02x,%02x>", SCptr->device->id, SCptr->device->lun));
 		esp_done(esp, ((SCptr->SCp.Status & 0xff) |
 			       ((SCptr->SCp.Message & 0xff)<<8) |
 			       (DID_OK << 16)));
 	} else if(esp->prevmsgin == DISCONNECT) {
 		/* Normal disconnect. */
 		esp_cmd(esp, eregs, ESP_CMD_ESEL);
-		ESPDISC(("D<%02x,%02x>", SCptr->target, SCptr->lun));
+		ESPDISC(("D<%02x,%02x>", SCptr->device->id, SCptr->device->lun));
 		append_SC(&esp->disconnected_SC, SCptr);
 		esp->current_SC = NULL;
 		if(esp->issue_SC)
@@ -2811,7 +2811,7 @@
 			/* Else, there really isn't anyone there. */
 			ESPMISC(("esp: selection failure, maybe nobody there?\n"));
 			ESPMISC(("esp: target %d lun %d\n",
-				 SCptr->target, SCptr->lun));
+				 SCptr->device->id, SCptr->device->lun));
 			esp_done(esp, (DID_BAD_TARGET << 16));
 		}
 		return do_intr_end;
@@ -3084,7 +3084,7 @@
 			ESPSDTR(("soff=%2x stp=%2x cfg3=%2x\n",
 				esp_dev->sync_max_offset,
 				esp_dev->sync_min_period,
-				esp->config3[SCptr->target]));
+				esp->config3[SCptr->device->id]));
 
 			esp->snip = 0;
 		} else if(esp_dev->sync_max_offset) {
--- linux-2.5.x/drivers/scsi/53c7xx.c	Wed Feb 12 12:31:26 2003
+++ linux-m68k-2.5.x/drivers/scsi/53c7xx.c	Thu Feb 13 16:12:27 2003
@@ -1759,7 +1759,7 @@
 static void 
 NCR53c7xx_dsa_fixup (struct NCR53c7x0_cmd *cmd) {
     Scsi_Cmnd *c = cmd->cmd;
-    struct Scsi_Host *host = c->host;
+    struct Scsi_Host *host = c->device->host;
     struct NCR53c7x0_hostdata *hostdata = (struct NCR53c7x0_hostdata *)
     	host->hostdata[0];
     int i;
@@ -1784,18 +1784,18 @@
      */
 
     patch_abs_tci_data (cmd->dsa, Ent_dsa_code_template / sizeof(u32),
-    	dsa_temp_lun, c->lun);
+    	dsa_temp_lun, c->device->lun);
     patch_abs_32 (cmd->dsa, Ent_dsa_code_template / sizeof(u32),
 	dsa_temp_addr_next, virt_to_bus(&cmd->dsa_next_addr));
     patch_abs_32 (cmd->dsa, Ent_dsa_code_template / sizeof(u32),
     	dsa_temp_next, virt_to_bus(cmd->dsa) + Ent_dsa_zero -
 	Ent_dsa_code_template + A_dsa_next);
     patch_abs_32 (cmd->dsa, Ent_dsa_code_template / sizeof(u32), 
-    	dsa_temp_sync, virt_to_bus((void *)hostdata->sync[c->target].script));
+    	dsa_temp_sync, virt_to_bus((void *)hostdata->sync[c->device->id].script));
     patch_abs_32 (cmd->dsa, Ent_dsa_code_template / sizeof(u32), 
-    	dsa_sscf_710, virt_to_bus((void *)&hostdata->sync[c->target].sscf_710));
+    	dsa_sscf_710, virt_to_bus((void *)&hostdata->sync[c->device->id].sscf_710));
     patch_abs_tci_data (cmd->dsa, Ent_dsa_code_template / sizeof(u32),
-    	    dsa_temp_target, 1 << c->target);
+    	    dsa_temp_target, 1 << c->device->id);
     /* XXX - new pointer stuff */
     patch_abs_32 (cmd->dsa, Ent_dsa_code_template / sizeof(u32),
     	dsa_temp_addr_saved_pointer, virt_to_bus(&cmd->saved_data_pointer));
@@ -1856,7 +1856,7 @@
 static void 
 abnormal_finished (struct NCR53c7x0_cmd *cmd, int result) {
     Scsi_Cmnd *c = cmd->cmd;
-    struct Scsi_Host *host = c->host;
+    struct Scsi_Host *host = c->device->host;
     struct NCR53c7x0_hostdata *hostdata = (struct NCR53c7x0_hostdata *)
     	host->hostdata[0];
     unsigned long flags;
@@ -1940,7 +1940,7 @@
 	    host->host_no, c->pid);
     else if (linux_search) {
 	*linux_prev = linux_search->next;
-	--hostdata->busy[c->target][c->lun];
+	--hostdata->busy[c->device->id][c->device->lun];
     }
 
     /* Return the NCR command structure to the free list */
@@ -2287,9 +2287,9 @@
 	    hostdata->dsp_changed = 1;
 	    if (cmd && (cmd->flags & CMD_FLAG_SDTR)) {
 		printk ("scsi%d : target %d rejected SDTR\n", host->host_no, 
-		    c->target);
+		    c->device->id);
 		cmd->flags &= ~CMD_FLAG_SDTR;
-		asynchronous (host, c->target);
+		asynchronous (host, c->device->id);
 		print = 0;
 	    } 
 	    break;
@@ -2311,7 +2311,7 @@
 	if (print) {
 	    printk ("scsi%d : received message", host->host_no);
 	    if (c) 
-	    	printk (" from target %d lun %d ", c->target, c->lun);
+	    	printk (" from target %d lun %d ", c->device->id, c->device->lun);
 	    print_msg ((unsigned char *) hostdata->msg_buf);
 	    printk("\n");
 	}
@@ -2331,7 +2331,7 @@
 
 	if (cmd) {
 	    char buf[80];
-	    sprintf (buf, "scsi%d : target %d %s ", host->host_no, c->target,
+	    sprintf (buf, "scsi%d : target %d %s ", host->host_no, c->device->id,
 		(cmd->flags & CMD_FLAG_SDTR) ? "accepting" : "requesting");
 	    print_synchronous (buf, (unsigned char *) hostdata->msg_buf);
 
@@ -2346,10 +2346,10 @@
 	    if (cmd->flags & CMD_FLAG_SDTR) {
 		cmd->flags &= ~CMD_FLAG_SDTR; 
 		if (hostdata->msg_buf[4]) 
-		    synchronous (host, c->target, (unsigned char *) 
+		    synchronous (host, c->device->id, (unsigned char *) 
 		    	hostdata->msg_buf);
 		else 
-		    asynchronous (host, c->target);
+		    asynchronous (host, c->device->id);
 		hostdata->dsp = hostdata->script + hostdata->E_accept_message /
 		    sizeof(u32);
 		hostdata->dsp_changed = 1;
@@ -2357,11 +2357,11 @@
 	    } else {
 		if (hostdata->options & OPTION_SYNCHRONOUS)  {
 		    cmd->flags |= CMD_FLAG_DID_SDTR;
-		    synchronous (host, c->target, (unsigned char *) 
+		    synchronous (host, c->device->id, (unsigned char *) 
 			hostdata->msg_buf);
 		} else {
 		    hostdata->msg_buf[4] = 0;		/* 0 offset = async */
-		    asynchronous (host, c->target);
+		    asynchronous (host, c->device->id);
 		}
 		patch_dsa_32 (cmd->dsa, dsa_msgout_other, 0, 5);
 		patch_dsa_32 (cmd->dsa, dsa_msgout_other, 1, (u32) 
@@ -2545,9 +2545,9 @@
 		    host->host_no, NCR53c7x0_read8(SXFER_REG));
 	    if (c) {
 		print_insn (host, (u32 *) 
-		    hostdata->sync[c->target].script, "", 1);
+		    hostdata->sync[c->device->id].script, "", 1);
 		print_insn (host, (u32 *) 
-		    hostdata->sync[c->target].script + 2, "", 1);
+		    hostdata->sync[c->device->id].script + 2, "", 1);
 	    }
 	}
     	return SPECIFIC_INT_RESTART;
@@ -2658,7 +2658,7 @@
 	if (hostdata->options & (OPTION_DEBUG_SCRIPT|OPTION_DEBUG_INTR)) {
 	    if (c)
 		printk("scsi%d : target %d lun %d disconnecting\n", 
-		    host->host_no, c->target, c->lun);
+		    host->host_no, c->device->id, c->device->lun);
 	    else
 		printk("scsi%d : unknown target disconnecting\n",
 		    host->host_no);
@@ -2680,9 +2680,9 @@
 #endif
 	    if (c) {
 		print_insn (host, (u32 *) 
-		    hostdata->sync[c->target].script, "", 1);
+		    hostdata->sync[c->device->id].script, "", 1);
 		print_insn (host, (u32 *) 
-		    hostdata->sync[c->target].script + 2, "", 1);
+		    hostdata->sync[c->device->id].script + 2, "", 1);
 	    }
 	}
 	return SPECIFIC_INT_RESTART;
@@ -2734,8 +2734,8 @@
 	    if ((hostdata->chip / 100) == 8) {
 		scntl3 = NCR53c7x0_read8 (SCNTL3_REG_800);
 		if (c) {
-		  if (sxfer != hostdata->sync[c->target].sxfer_sanity ||
-		    scntl3 != hostdata->sync[c->target].scntl3_sanity) {
+		  if (sxfer != hostdata->sync[c->device->id].sxfer_sanity ||
+		    scntl3 != hostdata->sync[c->device->id].scntl3_sanity) {
 		   	printk ("scsi%d :  sync sanity check failed sxfer=0x%x, scntl3=0x%x",
 			    host->host_no, sxfer, scntl3);
 			NCR53c7x0_write8 (SXFER_REG, sxfer);
@@ -2746,12 +2746,12 @@
 		    host->host_no, (int) sxfer, (int) scntl3);
 	    } else {
 		if (c) {
-		  if (sxfer != hostdata->sync[c->target].sxfer_sanity) {
+		  if (sxfer != hostdata->sync[c->device->id].sxfer_sanity) {
 		   	printk ("scsi%d :  sync sanity check failed sxfer=0x%x",
 			    host->host_no, sxfer);
 			NCR53c7x0_write8 (SXFER_REG, sxfer);
 			NCR53c7x0_write8 (SBCL_REG,
-				hostdata->sync[c->target].sscf_710);
+				hostdata->sync[c->device->id].sscf_710);
 		    }
 		} else 
     	    	  printk ("scsi%d : unknown command sxfer=0x%x\n",
@@ -2807,9 +2807,9 @@
 			(DCMD_REG)) == hostdata->script + 
 		    	Ent_select_check_dsa / sizeof(u32) ?
 		    "selection" : "reselection";
-		if (c && sdid != c->target) {
+		if (c && sdid != c->device->id) {
 		    printk ("scsi%d : SDID target %d != DSA target %d at %s\n",
-			host->host_no, sdid, c->target, where);
+			host->host_no, sdid, c->device->id, where);
 		    print_lots(host);
 		    dump_events (host, 20);
 		    return SPECIFIC_INT_PANIC;
@@ -2855,7 +2855,7 @@
 		if (event->event == EVENT_RESELECT)
 		    event->lun = hostdata->reselected_identify & 0xf;
 		else if (c)
-		    event->lun = c->lun;
+		    event->lun = c->device->lun;
 		else
 		    event->lun = 255;
 		do_gettimeofday(&(event->time));
@@ -3049,7 +3049,7 @@
 
 static struct NCR53c7x0_cmd *
 allocate_cmd (Scsi_Cmnd *cmd) {
-    struct Scsi_Host *host = cmd->host;
+    struct Scsi_Host *host = cmd->device->host;
     struct NCR53c7x0_hostdata *hostdata = 
 	(struct NCR53c7x0_hostdata *) host->hostdata[0];
     u32 real;			/* Real address */
@@ -3061,8 +3061,8 @@
 	printk ("scsi%d : num_cmds = %d, can_queue = %d\n"
 		"         target = %d, lun = %d, %s\n",
 	    host->host_no, hostdata->num_cmds, host->can_queue,
-	    cmd->target, cmd->lun, (hostdata->cmd_allocated[cmd->target] &
-		(1 << cmd->lun)) ? "already allocated" : "not allocated");
+	    cmd->device->id, cmd->device->lun, (hostdata->cmd_allocated[cmd->device->id] &
+		(1 << cmd->device->lun)) ? "already allocated" : "not allocated");
 
 /*
  * If we have not yet reserved commands for this I_T_L nexus, and
@@ -3070,11 +3070,11 @@
  * being allocated under 1.3.x, or being outside of scan_scsis in
  * 1.2.x), do so now.
  */
-    if (!(hostdata->cmd_allocated[cmd->target] & (1 << cmd->lun)) &&
+    if (!(hostdata->cmd_allocated[cmd->device->id] & (1 << cmd->device->lun)) &&
 				cmd->device && cmd->device->has_cmdblocks) {
       if ((hostdata->extra_allocate + hostdata->num_cmds) < host->can_queue)
           hostdata->extra_allocate += host->cmd_per_lun;
-      hostdata->cmd_allocated[cmd->target] |= (1 << cmd->lun);
+      hostdata->cmd_allocated[cmd->device->id] |= (1 << cmd->device->lun);
     }
 
     for (; hostdata->extra_allocate > 0 ; --hostdata->extra_allocate, 
@@ -3130,7 +3130,7 @@
     local_irq_restore(flags);
     if (!tmp)
 	printk ("scsi%d : can't allocate command for target %d lun %d\n",
-	    host->host_no, cmd->target, cmd->lun);
+	    host->host_no, cmd->device->id, cmd->device->lun);
     return tmp;
 }
 
@@ -3150,7 +3150,7 @@
 static struct NCR53c7x0_cmd *
 create_cmd (Scsi_Cmnd *cmd) {
     NCR53c7x0_local_declare();
-    struct Scsi_Host *host = cmd->host;
+    struct Scsi_Host *host = cmd->device->host;
     struct NCR53c7x0_hostdata *hostdata = (struct NCR53c7x0_hostdata *)
         host->hostdata[0];	
     struct NCR53c7x0_cmd *tmp; 	/* NCR53c7x0_cmd structure for this command */
@@ -3166,7 +3166,7 @@
 #endif
     unsigned long flags;
     u32 exp_select_indirect;	/* Used in sanity check */
-    NCR53c7x0_local_setup(cmd->host);
+    NCR53c7x0_local_setup(cmd->device->host);
 
     if (!(tmp = allocate_cmd (cmd)))
 	return NULL;
@@ -3322,45 +3322,45 @@
 
     if (hostdata->options & OPTION_DEBUG_SYNCHRONOUS) {
 
-	exp_select_indirect = ((1 << cmd->target) << 16) |
-			(hostdata->sync[cmd->target].sxfer_sanity << 8);
+	exp_select_indirect = ((1 << cmd->device->id) << 16) |
+			(hostdata->sync[cmd->device->id].sxfer_sanity << 8);
 
-	if (hostdata->sync[cmd->target].select_indirect != 
+	if (hostdata->sync[cmd->device->id].select_indirect !=
 				exp_select_indirect) {
 	    printk ("scsi%d :  sanity check failed select_indirect=0x%x\n",
-		host->host_no, hostdata->sync[cmd->target].select_indirect);
+		host->host_no, hostdata->sync[cmd->device->id].select_indirect);
 	    FATAL(host);
 
 	}
     }
 
     patch_dsa_32(tmp->dsa, dsa_select, 0,
-		hostdata->sync[cmd->target].select_indirect);
+		hostdata->sync[cmd->device->id].select_indirect);
 
     /*
      * Right now, we'll do the WIDE and SYNCHRONOUS negotiations on
      * different commands; although it should be trivial to do them
      * both at the same time.
      */
-    if (hostdata->initiate_wdtr & (1 << cmd->target)) {
+    if (hostdata->initiate_wdtr & (1 << cmd->device->id)) {
 	memcpy ((void *) (tmp->select + 1), (void *) wdtr_message,
 	    sizeof(wdtr_message));
     	patch_dsa_32(tmp->dsa, dsa_msgout, 0, 1 + sizeof(wdtr_message));
 	local_irq_save(flags);
-	hostdata->initiate_wdtr &= ~(1 << cmd->target);
+	hostdata->initiate_wdtr &= ~(1 << cmd->device->id);
 	local_irq_restore(flags);
-    } else if (hostdata->initiate_sdtr & (1 << cmd->target)) {
+    } else if (hostdata->initiate_sdtr & (1 << cmd->device->id)) {
 	memcpy ((void *) (tmp->select + 1), (void *) sdtr_message, 
 	    sizeof(sdtr_message));
     	patch_dsa_32(tmp->dsa, dsa_msgout, 0, 1 + sizeof(sdtr_message));
 	tmp->flags |= CMD_FLAG_SDTR;
 	local_irq_save(flags);
-	hostdata->initiate_sdtr &= ~(1 << cmd->target);
+	hostdata->initiate_sdtr &= ~(1 << cmd->device->id);
 	local_irq_restore(flags);
     
     }
 #if 1
-    else if (!(hostdata->talked_to & (1 << cmd->target)) && 
+    else if (!(hostdata->talked_to & (1 << cmd->device->id)) &&
 		!(hostdata->options & OPTION_NO_ASYNC)) {
 
 	memcpy ((void *) (tmp->select + 1), (void *) async_message, 
@@ -3372,9 +3372,9 @@
     else 
     	patch_dsa_32(tmp->dsa, dsa_msgout, 0, 1);
 
-    hostdata->talked_to |= (1 << cmd->target);
+    hostdata->talked_to |= (1 << cmd->device->id);
     tmp->select[0] = (hostdata->options & OPTION_DISCONNECT) ? 
-	IDENTIFY (1, cmd->lun) : IDENTIFY (0, cmd->lun);
+	IDENTIFY (1, cmd->device->lun) : IDENTIFY (0, cmd->device->lun);
     patch_dsa_32(tmp->dsa, dsa_msgout, 1, virt_to_bus(tmp->select));
     patch_dsa_32(tmp->dsa, dsa_cmdout, 0, cmd->cmd_len);
     patch_dsa_32(tmp->dsa, dsa_cmdout, 1, virt_to_bus(tmp->cmnd));
@@ -3591,7 +3591,7 @@
 
 int
 NCR53c7xx_queue_command (Scsi_Cmnd *cmd, void (* done)(Scsi_Cmnd *)) {
-    struct Scsi_Host *host = cmd->host;
+    struct Scsi_Host *host = cmd->device->host;
     struct NCR53c7x0_hostdata *hostdata = 
 	(struct NCR53c7x0_hostdata *) host->hostdata[0];
     unsigned long flags;
@@ -3604,9 +3604,9 @@
 
 #ifdef VALID_IDS
     /* Ignore commands on invalid IDs */
-    if (!hostdata->valid_ids[cmd->target]) {
+    if (!hostdata->valid_ids[cmd->device->id]) {
         printk("scsi%d : ignoring target %d lun %d\n", host->host_no,
-            cmd->target, cmd->lun);
+            cmd->device->id, cmd->device->lun);
         cmd->result = (DID_BAD_TARGET << 16);
         done(cmd);
         return 0;
@@ -3616,16 +3616,16 @@
     local_irq_save(flags);
     if ((hostdata->options & (OPTION_DEBUG_INIT_ONLY|OPTION_DEBUG_PROBE_ONLY)) 
 	|| ((hostdata->options & OPTION_DEBUG_TARGET_LIMIT) &&
-	    !(hostdata->debug_lun_limit[cmd->target] & (1 << cmd->lun))) 
+	    !(hostdata->debug_lun_limit[cmd->device->id] & (1 << cmd->device->lun)))
 #ifdef LINUX_1_2
-	|| cmd->target > 7
+	|| cmd->device->id > 7
 #else
-	|| cmd->target > host->max_id
+	|| cmd->device->id > host->max_id
 #endif
-	|| cmd->target == host->this_id
+	|| cmd->device->id == host->this_id
 	|| hostdata->state == STATE_DISABLED) {
 	printk("scsi%d : disabled or bad target %d lun %d\n", host->host_no,
-	    cmd->target, cmd->lun);
+	    cmd->device->id, cmd->device->lun);
 	cmd->result = (DID_BAD_TARGET << 16);
 	done(cmd);
 	local_irq_restore(flags);
@@ -3738,7 +3738,7 @@
 	--i, ncrcurrent += 2 /* JUMP instructions are two words */);
 
     if (i > 0) {
-	++hostdata->busy[tmp->target][tmp->lun];
+	++hostdata->busy[tmp->device->id][tmp->device->lun];
 	cmd->next = hostdata->running_list;
 	hostdata->running_list = cmd;
 
@@ -3799,7 +3799,7 @@
     /* FIXME : in the future, this needs to accommodate SCSI-II tagged
        queuing, and we may be able to play with fairness here a bit.
      */
-    return hostdata->busy[cmd->target][cmd->lun];
+    return hostdata->busy[cmd->device->id][cmd->device->lun];
 }
 
 /*
@@ -3873,7 +3873,7 @@
 			    if (tmp->host_scribble) {
 				if (hostdata->options & OPTION_DEBUG_QUEUES) 
 				    printk ("scsi%d : moving command for target %d lun %d to start list\n",
-					host->host_no, tmp->target, tmp->lun);
+					host->host_no, tmp->device->id, tmp->device->lun);
 		
 
 			    	to_schedule_list (host, hostdata, 
@@ -3937,7 +3937,7 @@
 	    printk ("scsi%d : Selection Timeout\n", host->host_no);
     	    if (cmd) {
     	    	printk("scsi%d : target %d, lun %d, command ",
-    	    	    host->host_no, cmd->cmd->target, cmd->cmd->lun);
+		    host->host_no, cmd->cmd->device->id, cmd->cmd->device->lun);
     	    	print_command (cmd->cmd->cmnd);
 		printk("scsi%d : dsp = 0x%x (virt 0x%p)\n", host->host_no,
 		    NCR53c7x0_read32(DSP_REG),
@@ -3975,7 +3975,7 @@
 	fatal = 1;
 	if (cmd) {
 	    printk("scsi%d : target %d lun %d unexpected disconnect\n",
-		host->host_no, cmd->cmd->target, cmd->cmd->lun);
+		host->host_no, cmd->cmd->device->id, cmd->cmd->device->lun);
 	    print_lots (host);
 	    abnormal_finished(cmd, DID_ERROR << 16);
 	} else 
@@ -3991,7 +3991,7 @@
 	fatal = 1;
 	if (cmd && cmd->cmd) {
 	    printk("scsi%d : target %d lun %d parity error.\n",
-		host->host_no, cmd->cmd->target, cmd->cmd->lun);
+		host->host_no, cmd->cmd->device->id, cmd->cmd->device->lun);
 	    abnormal_finished (cmd, DID_PARITY << 16); 
 	} else
 	    printk("scsi%d : parity error\n", host->host_no);
@@ -4199,7 +4199,7 @@
 	if (cmd_prev_ptr)
 	    *cmd_prev_ptr = (struct NCR53c7x0_cmd *) cmd->next;
 
-	--hostdata->busy[tmp->target][tmp->lun];
+	--hostdata->busy[tmp->device->id][tmp->device->lun];
 	cmd->next = hostdata->free;
 	hostdata->free = cmd;
 
@@ -4207,7 +4207,7 @@
 
 	if (hostdata->options & OPTION_DEBUG_INTR) {
 	    printk ("scsi%d : command complete : pid %lu, id %d,lun %d result 0x%x ", 
-		  host->host_no, tmp->pid, tmp->target, tmp->lun, tmp->result);
+		  host->host_no, tmp->pid, tmp->device->id, tmp->device->lun, tmp->result);
 	    print_command (tmp->cmnd);
 	}
 
@@ -4292,8 +4292,8 @@
 	if (hostdata->options & OPTION_DEBUG_INTR) {
 	    if (cmd) {
 		printk("scsi%d : interrupt for pid %lu, id %d, lun %d ", 
-		    host->host_no, cmd->cmd->pid, (int) cmd->cmd->target,
-		    (int) cmd->cmd->lun);
+		    host->host_no, cmd->cmd->pid, (int) cmd->cmd->device->id,
+		    (int) cmd->cmd->device->lun);
 		print_command (cmd->cmd->cmnd);
 	    } else {
 		printk("scsi%d : no active command\n", host->host_no);
@@ -4671,7 +4671,7 @@
 	    hostdata->dsp = dsp + 2 /* two _words_ */;
 	    hostdata->dsp_changed = 1;
 	    printk ("scsi%d : target %d ignored SDTR and went into COMMAND OUT\n", 
-		host->host_no, cmd->cmd->target);
+		host->host_no, cmd->cmd->device->id);
 	    cmd->flags &= ~CMD_FLAG_SDTR;
 	    action = ACTION_CONTINUE;
 	    break;
@@ -5136,7 +5136,7 @@
 int 
 NCR53c7xx_abort (Scsi_Cmnd *cmd) {
     NCR53c7x0_local_declare();
-    struct Scsi_Host *host = cmd->host;
+    struct Scsi_Host *host = cmd->device->host;
     struct NCR53c7x0_hostdata *hostdata = host ? (struct NCR53c7x0_hostdata *) 
 	host->hostdata[0] : NULL;
     unsigned long flags;
@@ -5242,7 +5242,7 @@
 	    return SCSI_ABORT_NOT_RUNNING;
 	} else {
 	    printk ("scsi%d : DANGER : command running, can not abort.\n",
-		cmd->host->host_no);
+		cmd->device->host->host_no);
 	    local_irq_restore(flags);
 	    return SCSI_ABORT_BUSY;
 	}
@@ -5273,7 +5273,7 @@
  * command was ever counted as BUSY, so if we end up here we can
  * decrement the busy count if and only if it is necessary.
  */
-        --hostdata->busy[cmd->target][cmd->lun];
+        --hostdata->busy[cmd->device->id][cmd->device->lun];
     }
     local_irq_restore(flags);
     cmd->scsi_done(cmd);
@@ -5318,7 +5318,7 @@
      * each command.  
      */
     Scsi_Cmnd *nuke_list = NULL;
-    struct Scsi_Host *host = cmd->host;
+    struct Scsi_Host *host = cmd->device->host;
     struct NCR53c7x0_hostdata *hostdata = 
     	(struct NCR53c7x0_hostdata *) host->hostdata[0];
 
@@ -5388,7 +5388,7 @@
 static int 
 insn_to_offset (Scsi_Cmnd *cmd, u32 *insn) {
     struct NCR53c7x0_hostdata *hostdata = 
-	(struct NCR53c7x0_hostdata *) cmd->host->hostdata[0];
+	(struct NCR53c7x0_hostdata *) cmd->device->host->hostdata[0];
     struct NCR53c7x0_cmd *ncmd = 
 	(struct NCR53c7x0_cmd *) cmd->host_scribble;
     int offset = 0, buffers;
@@ -5418,7 +5418,7 @@
     	    	     --buffers, offset += segment->length, ++segment)
 #if 0
 		    printk("scsi%d: comparing 0x%p to 0x%p\n", 
-			cmd->host->host_no, saved, page_address(segment->page+segment->offset);
+			cmd->device->host->host_no, saved, page_address(segment->page+segment->offset);
 #else
 		    ;
 #endif
@@ -5456,7 +5456,7 @@
     int offset, i;
     char *where;
     u32 *ptr;
-    NCR53c7x0_local_setup (cmd->host);
+    NCR53c7x0_local_setup (cmd->device->host);
 
     if (check_address ((unsigned long) ncmd,sizeof (struct NCR53c7x0_cmd)) == 0)
     {
@@ -5484,15 +5484,15 @@
 
 	if (offset != -1) 
 	    printk ("scsi%d : %s data pointer at offset %d\n",
-		cmd->host->host_no, where, offset);
+		cmd->device->host->host_no, where, offset);
 	else {
 	    int size;
 	    printk ("scsi%d : can't determine %s data pointer offset\n",
-		cmd->host->host_no, where);
+		cmd->device->host->host_no, where);
 	    if (ncmd) {
-		size = print_insn (cmd->host, 
+		size = print_insn (cmd->device->host,
 		    bus_to_virt(ncmd->saved_data_pointer), "", 1);
-		print_insn (cmd->host, 
+		print_insn (cmd->device->host,
 		    bus_to_virt(ncmd->saved_data_pointer) + size * sizeof(u32),
 		    "", 1);
 	    }
@@ -5549,7 +5549,7 @@
     /* XXX Maybe we should access cmd->host_scribble->result here. RGH */
     if (cmd) {
 	printk("               result = 0x%x, target = %d, lun = %d, cmd = ",
-	    cmd->result, cmd->target, cmd->lun);
+	    cmd->result, cmd->device->id, cmd->device->lun);
 	print_command(cmd->cmnd);
     } else
 	printk("\n");
@@ -5558,11 +5558,11 @@
     if (cmd) { 
 	printk("scsi%d target %d : sxfer_sanity = 0x%x, scntl3_sanity = 0x%x\n"
 	       "                   script : ",
-	    host->host_no, cmd->target,
-	    hostdata->sync[cmd->target].sxfer_sanity,
-	    hostdata->sync[cmd->target].scntl3_sanity);
-	for (i = 0; i < (sizeof(hostdata->sync[cmd->target].script) / 4); ++i)
-	    printk ("0x%x ", hostdata->sync[cmd->target].script[i]);
+	    host->host_no, cmd->device->id,
+	    hostdata->sync[cmd->device->id].sxfer_sanity,
+	    hostdata->sync[cmd->device->id].scntl3_sanity);
+	for (i = 0; i < (sizeof(hostdata->sync[cmd->device->id].script) / 4); ++i)
+	    printk ("0x%x ", hostdata->sync[cmd->device->id].script[i]);
 	printk ("\n");
     	print_progress (cmd);
     }
@@ -5604,7 +5604,7 @@
 		    -> dsa, "");
 	} else 
 	    printk ("scsi%d : scsi pid %ld for target %d lun %d has no NCR53c7x0_cmd\n",
-		host->host_no, cmd->pid, cmd->target, cmd->lun);
+		host->host_no, cmd->pid, cmd->device->id, cmd->device->lun);
 	local_irq_restore(flags);
     }
 
--- linux-2.5.x/drivers/scsi/a2091.c	Wed Nov 20 11:36:29 2002
+++ linux-m68k-2.5.x/drivers/scsi/a2091.c	Thu Feb 13 16:14:20 2003
@@ -52,7 +52,7 @@
 {
     unsigned short cntr = CNTR_PDMD | CNTR_INTEN;
     unsigned long addr = virt_to_bus(cmd->SCp.ptr);
-    struct Scsi_Host *instance = cmd->host;
+    struct Scsi_Host *instance = cmd->device->host;
 
     /* don't allow DMA if the physical address is bad */
     if (addr & A2091_XFER_MASK ||
@@ -102,12 +102,12 @@
 	cntr |= CNTR_DDIR;
 
     /* remember direction */
-    HDATA(cmd->host)->dma_dir = dir_in;
+    HDATA(cmd->device->host)->dma_dir = dir_in;
 
-    DMA(cmd->host)->CNTR = cntr;
+    DMA(cmd->device->host)->CNTR = cntr;
 
     /* setup DMA *physical* address */
-    DMA(cmd->host)->ACR = addr;
+    DMA(cmd->device->host)->ACR = addr;
 
     if (dir_in){
 	/* invalidate any cache */
@@ -117,7 +117,7 @@
 	cache_push (addr, cmd->SCp.this_residual);
       }
     /* start DMA */
-    DMA(cmd->host)->ST_DMA = 1;
+    DMA(cmd->device->host)->ST_DMA = 1;
 
     /* return success */
     return 0;
--- linux-2.5.x/drivers/scsi/atari_NCR5380.c	Wed Feb 12 12:31:26 2003
+++ linux-m68k-2.5.x/drivers/scsi/atari_NCR5380.c	Thu Feb 13 15:42:37 2003
@@ -266,7 +266,7 @@
 #define	NEXTADDR(cmd)	((Scsi_Cmnd **)&((cmd)->host_scribble))
 
 #define	HOSTNO		instance->host_no
-#define	H_NO(cmd)	(cmd)->host->host_no
+#define	H_NO(cmd)	(cmd)->device->host->host_no
 
 #ifdef SUPPORT_TAGS
 
@@ -350,17 +350,17 @@
 
 static int is_lun_busy( Scsi_Cmnd *cmd, int should_be_tagged )
 {
-    SETUP_HOSTDATA(cmd->host);
+    SETUP_HOSTDATA(cmd->device->host);
 
-    if (hostdata->busy[cmd->target] & (1 << cmd->lun))
+    if (hostdata->busy[cmd->device->id] & (1 << cmd->device->lun))
 	return( 1 );
     if (!should_be_tagged ||
 	!setup_use_tagged_queuing || !cmd->device->tagged_supported)
 	return( 0 );
-    if (TagAlloc[cmd->target][cmd->lun].nr_allocated >=
-	TagAlloc[cmd->target][cmd->lun].queue_size ) {
+    if (TagAlloc[cmd->device->id][cmd->device->lun].nr_allocated >=
+	TagAlloc[cmd->device->id][cmd->device->lun].queue_size ) {
 	TAG_PRINTK( "scsi%d: target %d lun %d: no free tags\n",
-		    H_NO(cmd), cmd->target, cmd->lun );
+		    H_NO(cmd), cmd->device->id, cmd->device->lun );
 	return( 1 );
     }
     return( 0 );
@@ -374,7 +374,7 @@
 
 static void cmd_get_tag( Scsi_Cmnd *cmd, int should_be_tagged )
 {
-    SETUP_HOSTDATA(cmd->host);
+    SETUP_HOSTDATA(cmd->device->host);
 
     /* If we or the target don't support tagged queuing, allocate the LUN for
      * an untagged command.
@@ -382,19 +382,19 @@
     if (!should_be_tagged ||
 	!setup_use_tagged_queuing || !cmd->device->tagged_supported) {
 	cmd->tag = TAG_NONE;
-	hostdata->busy[cmd->target] |= (1 << cmd->lun);
+	hostdata->busy[cmd->device->id] |= (1 << cmd->device->lun);
 	TAG_PRINTK( "scsi%d: target %d lun %d now allocated by untagged "
-		    "command\n", H_NO(cmd), cmd->target, cmd->lun );
+		    "command\n", H_NO(cmd), cmd->device->id, cmd->device->lun );
     }
     else {
-	TAG_ALLOC *ta = &TagAlloc[cmd->target][cmd->lun];
+	TAG_ALLOC *ta = &TagAlloc[cmd->device->id][cmd->device->lun];
 
 	cmd->tag = find_first_zero_bit( ta->allocated, MAX_TAGS );
 	set_bit( cmd->tag, ta->allocated );
 	ta->nr_allocated++;
 	TAG_PRINTK( "scsi%d: using tag %d for target %d lun %d "
 		    "(now %d tags in use)\n",
-		    H_NO(cmd), cmd->tag, cmd->target, cmd->lun,
+		    H_NO(cmd), cmd->tag, cmd->device->id, cmd->device->lun,
 		    ta->nr_allocated );
     }
 }
@@ -406,23 +406,23 @@
 
 static void cmd_free_tag( Scsi_Cmnd *cmd )
 {
-    SETUP_HOSTDATA(cmd->host);
+    SETUP_HOSTDATA(cmd->device->host);
 
     if (cmd->tag == TAG_NONE) {
-	hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
+	hostdata->busy[cmd->device->id] &= ~(1 << cmd->device->lun);
 	TAG_PRINTK( "scsi%d: target %d lun %d untagged cmd finished\n",
-		    H_NO(cmd), cmd->target, cmd->lun );
+		    H_NO(cmd), cmd->device->id, cmd->device->lun );
     }
     else if (cmd->tag >= MAX_TAGS) {
 	printk(KERN_NOTICE "scsi%d: trying to free bad tag %d!\n",
 		H_NO(cmd), cmd->tag );
     }
     else {
-	TAG_ALLOC *ta = &TagAlloc[cmd->target][cmd->lun];
+	TAG_ALLOC *ta = &TagAlloc[cmd->device->id][cmd->device->lun];
 	clear_bit( cmd->tag, ta->allocated );
 	ta->nr_allocated--;
 	TAG_PRINTK( "scsi%d: freed tag %d for target %d lun %d\n",
-		    H_NO(cmd), cmd->tag, cmd->target, cmd->lun );
+		    H_NO(cmd), cmd->tag, cmd->device->id, cmd->device->lun );
     }
 }
 
@@ -811,7 +811,7 @@
     int i, s;
     unsigned char *command;
     SPRINTF("scsi%d: destination target %d, lun %d\n",
-	    H_NO(cmd), cmd->target, cmd->lun);
+	    H_NO(cmd), cmd->device->id, cmd->device->lun);
     SPRINTF("        command = ");
     command = cmd->cmnd;
     SPRINTF("%2d (0x%02x)", command[0], command[0]);
@@ -903,7 +903,7 @@
 static
 int NCR5380_queue_command (Scsi_Cmnd *cmd, void (*done)(Scsi_Cmnd *))
 {
-    SETUP_HOSTDATA(cmd->host);
+    SETUP_HOSTDATA(cmd->device->host);
     Scsi_Cmnd *tmp;
     int oldto;
     unsigned long flags;
@@ -937,15 +937,15 @@
 	    case WRITE:
 	    case WRITE_6:
 	    case WRITE_10:
-		hostdata->time_write[cmd->target] -= (jiffies - hostdata->timebase);
-		hostdata->bytes_write[cmd->target] += cmd->request_bufflen;
+		hostdata->time_write[cmd->device->id] -= (jiffies - hostdata->timebase);
+		hostdata->bytes_write[cmd->device->id] += cmd->request_bufflen;
 		hostdata->pendingw++;
 		break;
 	    case READ:
 	    case READ_6:
 	    case READ_10:
-		hostdata->time_read[cmd->target] -= (jiffies - hostdata->timebase);
-		hostdata->bytes_read[cmd->target] += cmd->request_bufflen;
+		hostdata->time_read[cmd->device->id] -= (jiffies - hostdata->timebase);
+		hostdata->bytes_read[cmd->device->id] += cmd->request_bufflen;
 		hostdata->pendingr++;
 		break;
 	}
@@ -1086,8 +1086,8 @@
 #if (NDEBUG & NDEBUG_LISTS)
 		if (prev != tmp)
 		    printk("MAIN tmp=%p   target=%d   busy=%d lun=%d\n",
-			   tmp, tmp->target, hostdata->busy[tmp->target],
-			   tmp->lun);
+			   tmp, tmp->device->id, hostdata->busy[tmp->device->id],
+			   tmp->device->lun);
 #endif
 		/*  When we find one, remove it from the issue queue. */
 		/* ++guenther: possible race with Falcon locking */
@@ -1095,7 +1095,7 @@
 #ifdef SUPPORT_TAGS
 		    !is_lun_busy( tmp, tmp->cmnd[0] != REQUEST_SENSE)
 #else
-		    !(hostdata->busy[tmp->target] & (1 << tmp->lun))
+		    !(hostdata->busy[tmp->device->id] & (1 << tmp->device->lun))
 #endif
 		    ) {
 		    /* ++guenther: just to be sure, this must be atomic */
@@ -1121,7 +1121,7 @@
 		     */
 		    MAIN_PRINTK("scsi%d: main(): command for target %d "
 				"lun %d removed from issue_queue\n",
-				HOSTNO, tmp->target, tmp->lun);
+				HOSTNO, tmp->device->id, tmp->device->lun);
 		    /* 
 		     * REQUEST SENSE commands are issued without tagged
 		     * queueing, even on SCSI-II devices because the 
@@ -1355,15 +1355,15 @@
 	    case WRITE:
 	    case WRITE_6:
 	    case WRITE_10:
-		hostdata->time_write[cmd->target] += (jiffies - hostdata->timebase);
-		/*hostdata->bytes_write[cmd->target] += cmd->request_bufflen;*/
+		hostdata->time_write[cmd->device->id] += (jiffies - hostdata->timebase);
+		/*hostdata->bytes_write[cmd->device->id] += cmd->request_bufflen;*/
 		hostdata->pendingw--;
 		break;
 	    case READ:
 	    case READ_6:
 	    case READ_10:
-		hostdata->time_read[cmd->target] += (jiffies - hostdata->timebase);
-		/*hostdata->bytes_read[cmd->target] += cmd->request_bufflen;*/
+		hostdata->time_read[cmd->device->id] += (jiffies - hostdata->timebase);
+		/*hostdata->bytes_read[cmd->device->id] += cmd->request_bufflen;*/
 		hostdata->pendingr--;
 		break;
 	}
@@ -1524,7 +1524,7 @@
      * the host and target ID's on the SCSI bus.
      */
 
-    NCR5380_write(OUTPUT_DATA_REG, (hostdata->id_mask | (1 << cmd->target)));
+    NCR5380_write(OUTPUT_DATA_REG, (hostdata->id_mask | (1 << cmd->device->id)));
 
     /* 
      * Raise ATN while SEL is true before BSY goes false from arbitration,
@@ -1577,7 +1577,7 @@
 
     udelay(1);
 
-    SEL_PRINTK("scsi%d: selecting target %d\n", HOSTNO, cmd->target);
+    SEL_PRINTK("scsi%d: selecting target %d\n", HOSTNO, cmd->device->id);
 
     /* 
      * The SCSI specification calls for a 250 ms timeout for the actual 
@@ -1628,7 +1628,7 @@
 
     if (!(NCR5380_read(STATUS_REG) & SR_BSY)) {
 	NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE);
-	if (hostdata->targets_present & (1 << cmd->target)) {
+	if (hostdata->targets_present & (1 << cmd->device->id)) {
 	    printk(KERN_ERR "scsi%d: weirdness\n", HOSTNO);
 	    if (hostdata->restart_select)
 		printk(KERN_NOTICE "\trestart select\n");
@@ -1650,7 +1650,7 @@
 	return 0;
     } 
 
-    hostdata->targets_present |= (1 << cmd->target);
+    hostdata->targets_present |= (1 << cmd->device->id);
 
     /*
      * Since we followed the SCSI spec, and raised ATN while SEL 
@@ -1671,8 +1671,8 @@
     while (!(NCR5380_read(STATUS_REG) & SR_REQ));
 
     SEL_PRINTK("scsi%d: target %d selected, going into MESSAGE OUT phase.\n",
-	       HOSTNO, cmd->target);
-    tmp[0] = IDENTIFY(1, cmd->lun);
+	       HOSTNO, cmd->device->id);
+    tmp[0] = IDENTIFY(1, cmd->device->lun);
 
 #ifdef SUPPORT_TAGS
     if (cmd->tag != TAG_NONE) {
@@ -1694,7 +1694,7 @@
     /* XXX need to handle errors here */
     hostdata->connected = cmd;
 #ifndef SUPPORT_TAGS
-    hostdata->busy[cmd->target] |= (1 << cmd->lun);
+    hostdata->busy[cmd->device->id] |= (1 << cmd->device->lun);
 #endif    
 
     initialize_SCp(cmd);
@@ -2084,7 +2084,7 @@
 			 * polled-IO. */ 
 			printk(KERN_NOTICE "scsi%d: switching target %d "
 			       "lun %d to slow handshake\n", HOSTNO,
-			       cmd->target, cmd->lun);
+			       cmd->device->id, cmd->device->lun);
 			cmd->device->borken = 1;
 			NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE | 
 			    ICR_ASSERT_ATN);
@@ -2136,7 +2136,7 @@
 		    NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE);
 		    
 		    LNK_PRINTK("scsi%d: target %d lun %d linked command "
-			       "complete.\n", HOSTNO, cmd->target, cmd->lun);
+			       "complete.\n", HOSTNO, cmd->device->id, cmd->device->lun);
 
 		    /* Enable reselect interrupts */
 		    NCR5380_write(SELECT_ENABLE_REG, hostdata->id_mask);
@@ -2149,7 +2149,7 @@
 		    if (!cmd->next_link) {
 			 printk(KERN_NOTICE "scsi%d: target %d lun %d "
 				"linked command complete, no next_link\n",
-				HOSTNO, cmd->target, cmd->lun);
+				HOSTNO, cmd->device->id, cmd->device->lun);
 			    sink = 1;
 			    do_abort (instance);
 			    return;
@@ -2162,7 +2162,7 @@
 		    cmd->result = cmd->SCp.Status | (cmd->SCp.Message << 8); 
 		    LNK_PRINTK("scsi%d: target %d lun %d linked request "
 			       "done, calling scsi_done().\n",
-			       HOSTNO, cmd->target, cmd->lun);
+			       HOSTNO, cmd->device->id, cmd->device->lun);
 #ifdef NCR5380_STATS
 		    collect_stats(hostdata, cmd);
 #endif
@@ -2178,7 +2178,7 @@
 		    falcon_dont_release++;
 		    hostdata->connected = NULL;
 		    QU_PRINTK("scsi%d: command for target %d, lun %d "
-			      "completed\n", HOSTNO, cmd->target, cmd->lun);
+			      "completed\n", HOSTNO, cmd->device->id, cmd->device->lun);
 #ifdef SUPPORT_TAGS
 		    cmd_free_tag( cmd );
 		    if (status_byte(cmd->SCp.Status) == QUEUE_FULL) {
@@ -2190,16 +2190,16 @@
 			 */
 			/* ++Andreas: the mid level code knows about
 			   QUEUE_FULL now. */
-			TAG_ALLOC *ta = &TagAlloc[cmd->target][cmd->lun];
+			TAG_ALLOC *ta = &TagAlloc[cmd->device->id][cmd->device->lun];
 			TAG_PRINTK("scsi%d: target %d lun %d returned "
 				   "QUEUE_FULL after %d commands\n",
-				   HOSTNO, cmd->target, cmd->lun,
+				   HOSTNO, cmd->device->id, cmd->device->lun,
 				   ta->nr_allocated);
 			if (ta->queue_size > ta->nr_allocated)
 			    ta->nr_allocated = ta->queue_size;
 		    }
 #else
-		    hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
+		    hostdata->busy[cmd->device->id] &= ~(1 << cmd->device->lun);
 #endif
 		    /* Enable reselect interrupts */
 		    NCR5380_write(SELECT_ENABLE_REG, hostdata->id_mask);
@@ -2295,12 +2295,12 @@
 			 * the command is treated as untagged further on.
 			 */
 			cmd->device->tagged_supported = 0;
-			hostdata->busy[cmd->target] |= (1 << cmd->lun);
+			hostdata->busy[cmd->device->id] |= (1 << cmd->device->lun);
 			cmd->tag = TAG_NONE;
 			TAG_PRINTK("scsi%d: target %d lun %d rejected "
 				   "QUEUE_TAG message; tagged queuing "
 				   "disabled\n",
-				   HOSTNO, cmd->target, cmd->lun);
+				   HOSTNO, cmd->device->id, cmd->device->lun);
 			break;
 		    }
 		    break;
@@ -2317,7 +2317,7 @@
 		    QU_PRINTK("scsi%d: command for target %d lun %d was "
 			      "moved from connected to the "
 			      "disconnected_queue\n", HOSTNO, 
-			      cmd->target, cmd->lun);
+			      cmd->device->id, cmd->device->lun);
 		    /* 
 		     * Restore phase bits to 0 so an interrupted selection, 
 		     * arbitration can resume.
@@ -2416,13 +2416,13 @@
 		    } else if (tmp != EXTENDED_MESSAGE)
 			printk(KERN_DEBUG "scsi%d: rejecting unknown "
 			       "message %02x from target %d, lun %d\n",
-			       HOSTNO, tmp, cmd->target, cmd->lun);
+			       HOSTNO, tmp, cmd->device->id, cmd->device->lun);
 		    else
 			printk(KERN_DEBUG "scsi%d: rejecting unknown "
 			       "extended message "
 			       "code %02x, length %d from target %d, lun %d\n",
 			       HOSTNO, extended_msg[1], extended_msg[0],
-			       cmd->target, cmd->lun);
+			       cmd->device->id, cmd->device->lun);
    
 
 		    msgout = MESSAGE_REJECT;
@@ -2440,7 +2440,7 @@
 #ifdef SUPPORT_TAGS
 		    cmd_free_tag( cmd );
 #else
-		    hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
+		    hostdata->busy[cmd->device->id] &= ~(1 << cmd->device->lun);
 #endif
 		    hostdata->connected = NULL;
 		    cmd->result = DID_ERROR << 16;
@@ -2576,7 +2576,7 @@
 
     for (tmp = (Scsi_Cmnd *) hostdata->disconnected_queue, prev = NULL; 
 	 tmp; prev = tmp, tmp = NEXT(tmp) ) {
-	if ((target_mask == (1 << tmp->target)) && (lun == tmp->lun)
+	if ((target_mask == (1 << tmp->device->id)) && (lun == tmp->device->lun)
 #ifdef SUPPORT_TAGS
 	    && (tag == tmp->tag) 
 #endif
@@ -2619,7 +2619,7 @@
 
     hostdata->connected = tmp;
     RSL_PRINTK("scsi%d: nexus established, target = %d, lun = %d, tag = %d\n",
-	       HOSTNO, tmp->target, tmp->lun, tmp->tag);
+	       HOSTNO, tmp->device->id, tmp->device->lun, tmp->tag);
     falcon_dont_release--;
 }
 
@@ -2644,7 +2644,7 @@
 static
 int NCR5380_abort (Scsi_Cmnd *cmd)
 {
-    struct Scsi_Host *instance = cmd->host;
+    struct Scsi_Host *instance = cmd->device->host;
     SETUP_HOSTDATA(instance);
     Scsi_Cmnd *tmp, **prev;
     unsigned long flags;
@@ -2698,7 +2698,7 @@
 #ifdef SUPPORT_TAGS
 	  cmd_free_tag( cmd );
 #else
-	  hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
+	  hostdata->busy[cmd->device->id] &= ~(1 << cmd->device->lun);
 #endif
 	  local_irq_restore(flags);
 	  cmd->scsi_done(cmd);
@@ -2805,7 +2805,7 @@
 #ifdef SUPPORT_TAGS
 		    cmd_free_tag( tmp );
 #else
-		    hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
+		    hostdata->busy[cmd->device->id] &= ~(1 << cmd->device->lun);
 #endif
 		    local_irq_restore(flags);
 		    tmp->scsi_done(tmp);
@@ -2849,7 +2849,7 @@
 
 static int NCR5380_bus_reset( Scsi_Cmnd *cmd)
 {
-    SETUP_HOSTDATA(cmd->host);
+    SETUP_HOSTDATA(cmd->device->host);
     int           i;
     unsigned long flags;
 #if 1
@@ -2860,7 +2860,7 @@
 	printk(KERN_ERR "scsi%d: !!BINGO!! Falcon has no lock in NCR5380_reset\n",
 	       H_NO(cmd) );
 
-    NCR5380_print_status (cmd->host);
+    NCR5380_print_status (cmd->device->host);
 
     /* get in phase */
     NCR5380_write( TARGET_COMMAND_REG,
--- linux-2.5.x/drivers/scsi/atari_scsi.c	Wed Feb 12 12:31:26 2003
+++ linux-m68k-2.5.x/drivers/scsi/atari_scsi.c	Thu Feb 13 15:37:43 2003
@@ -823,7 +823,7 @@
 {
 	int		rv;
 	struct NCR5380_hostdata *hostdata =
-		(struct NCR5380_hostdata *)cmd->host->hostdata;
+		(struct NCR5380_hostdata *)cmd->device->host->hostdata;
 
 	/* For doing the reset, SCSI interrupts must be disabled first,
 	 * since the 5380 raises its IRQ line while _RST is active and we
--- linux-2.5.x/drivers/scsi/gvp11.c	Wed Nov 20 11:36:29 2002
+++ linux-m68k-2.5.x/drivers/scsi/gvp11.c	Thu Feb 13 16:15:30 2003
@@ -62,61 +62,62 @@
     static int scsi_alloc_out_of_range = 0;
 
     /* use bounce buffer if the physical address is bad */
-    if (addr & HDATA(cmd->host)->dma_xfer_mask ||
+    if (addr & HDATA(cmd->device->host)->dma_xfer_mask ||
 	(!dir_in && mm_end_of_chunk (addr, cmd->SCp.this_residual)))
     {
-	HDATA(cmd->host)->dma_bounce_len = (cmd->SCp.this_residual + 511)
+	HDATA(cmd->device->host)->dma_bounce_len = (cmd->SCp.this_residual + 511)
 	    & ~0x1ff;
 
  	if( !scsi_alloc_out_of_range ) {
-	    HDATA(cmd->host)->dma_bounce_buffer =
-		kmalloc (HDATA(cmd->host)->dma_bounce_len, GFP_KERNEL);
-	    HDATA(cmd->host)->dma_buffer_pool = BUF_SCSI_ALLOCED;
+	    HDATA(cmd->device->host)->dma_bounce_buffer =
+		kmalloc (HDATA(cmd->device->host)->dma_bounce_len, GFP_KERNEL);
+	    HDATA(cmd->device->host)->dma_buffer_pool = BUF_SCSI_ALLOCED;
 	}
 
-	if ( scsi_alloc_out_of_range || !HDATA(cmd->host)->dma_bounce_buffer) {
-	    HDATA(cmd->host)->dma_bounce_buffer =
-		amiga_chip_alloc(HDATA(cmd->host)->dma_bounce_len,
+	if (scsi_alloc_out_of_range ||
+	    !HDATA(cmd->device->host)->dma_bounce_buffer) {
+	    HDATA(cmd->device->host)->dma_bounce_buffer =
+		amiga_chip_alloc(HDATA(cmd->device->host)->dma_bounce_len,
 				       "GVP II SCSI Bounce Buffer");
 
-	    if(!HDATA(cmd->host)->dma_bounce_buffer)
+	    if(!HDATA(cmd->device->host)->dma_bounce_buffer)
 	    {
-		HDATA(cmd->host)->dma_bounce_len = 0;
+		HDATA(cmd->device->host)->dma_bounce_len = 0;
 		return 1;
 	    }
 
-	    HDATA(cmd->host)->dma_buffer_pool = BUF_CHIP_ALLOCED;
+	    HDATA(cmd->device->host)->dma_buffer_pool = BUF_CHIP_ALLOCED;
 	}
 
 	/* check if the address of the bounce buffer is OK */
-	addr = virt_to_bus(HDATA(cmd->host)->dma_bounce_buffer);
+	addr = virt_to_bus(HDATA(cmd->device->host)->dma_bounce_buffer);
 
-	if (addr & HDATA(cmd->host)->dma_xfer_mask) {
+	if (addr & HDATA(cmd->device->host)->dma_xfer_mask) {
 	    /* fall back to Chip RAM if address out of range */
-	    if( HDATA(cmd->host)->dma_buffer_pool == BUF_SCSI_ALLOCED) {
-		kfree (HDATA(cmd->host)->dma_bounce_buffer);
+	    if( HDATA(cmd->device->host)->dma_buffer_pool == BUF_SCSI_ALLOCED) {
+		kfree (HDATA(cmd->device->host)->dma_bounce_buffer);
 		scsi_alloc_out_of_range = 1;
 	    } else {
-		amiga_chip_free (HDATA(cmd->host)->dma_bounce_buffer);
+		amiga_chip_free (HDATA(cmd->device->host)->dma_bounce_buffer);
             }
 		
-	    HDATA(cmd->host)->dma_bounce_buffer =
-		amiga_chip_alloc(HDATA(cmd->host)->dma_bounce_len,
+	    HDATA(cmd->device->host)->dma_bounce_buffer =
+		amiga_chip_alloc(HDATA(cmd->device->host)->dma_bounce_len,
 				       "GVP II SCSI Bounce Buffer");
 
-	    if(!HDATA(cmd->host)->dma_bounce_buffer)
+	    if(!HDATA(cmd->device->host)->dma_bounce_buffer)
 	    {
-		HDATA(cmd->host)->dma_bounce_len = 0;
+		HDATA(cmd->device->host)->dma_bounce_len = 0;
 		return 1;
 	    }
 
-	    addr = virt_to_bus(HDATA(cmd->host)->dma_bounce_buffer);
-	    HDATA(cmd->host)->dma_buffer_pool = BUF_CHIP_ALLOCED;
+	    addr = virt_to_bus(HDATA(cmd->device->host)->dma_bounce_buffer);
+	    HDATA(cmd->device->host)->dma_buffer_pool = BUF_CHIP_ALLOCED;
 	}
 	    
 	if (!dir_in) {
 	    /* copy to bounce buffer for a write */
-	    memcpy (HDATA(cmd->host)->dma_bounce_buffer,
+	    memcpy (HDATA(cmd->device->host)->dma_bounce_buffer,
 		    cmd->SCp.ptr, cmd->SCp.this_residual);
 	}
     }
@@ -125,11 +126,11 @@
     if (!dir_in)
 	cntr |= GVP11_DMAC_DIR_WRITE;
 
-    HDATA(cmd->host)->dma_dir = dir_in;
-    DMA(cmd->host)->CNTR = cntr;
+    HDATA(cmd->device->host)->dma_dir = dir_in;
+    DMA(cmd->device->host)->CNTR = cntr;
 
     /* setup DMA *physical* address */
-    DMA(cmd->host)->ACR = addr;
+    DMA(cmd->device->host)->ACR = addr;
 
     if (dir_in)
 	/* invalidate any cache */
@@ -138,11 +139,11 @@
 	/* push any dirty cache */
 	cache_push (addr, cmd->SCp.this_residual);
 
-    if ((bank_mask = (~HDATA(cmd->host)->dma_xfer_mask >> 18) & 0x01c0))
-	    DMA(cmd->host)->BANK = bank_mask & (addr >> 18);
+    if ((bank_mask = (~HDATA(cmd->device->host)->dma_xfer_mask >> 18) & 0x01c0))
+	    DMA(cmd->device->host)->BANK = bank_mask & (addr >> 18);
 
     /* start DMA */
-    DMA(cmd->host)->ST_DMA = 1;
+    DMA(cmd->device->host)->ST_DMA = 1;
 
     /* return success */
     return 0;
--- linux-2.5.x/drivers/scsi/sun3_NCR5380.c	Wed Feb 12 17:56:43 2003
+++ linux-m68k-2.5.x/drivers/scsi/sun3_NCR5380.c	Thu Feb 13 13:26:45 2003
@@ -268,7 +268,7 @@
 #define	NEXTADDR(cmd)	((Scsi_Cmnd **)&((cmd)->host_scribble))
 
 #define	HOSTNO		instance->host_no
-#define	H_NO(cmd)	(cmd)->host->host_no
+#define	H_NO(cmd)	(cmd)->device->host->host_no
 
 #define SGADDR(buffer) (void *)(((unsigned long)page_address((buffer)->page)) + \
 			(buffer)->offset)
@@ -360,17 +360,17 @@
 
 static int is_lun_busy( Scsi_Cmnd *cmd, int should_be_tagged )
 {
-    SETUP_HOSTDATA(cmd->host);
+    SETUP_HOSTDATA(cmd->device->host);
 
-    if (hostdata->busy[cmd->target] & (1 << cmd->lun))
+    if (hostdata->busy[cmd->device->id] & (1 << cmd->device->lun))
 	return( 1 );
     if (!should_be_tagged ||
 	!setup_use_tagged_queuing || !cmd->device->tagged_supported)
 	return( 0 );
-    if (TagAlloc[cmd->target][cmd->lun].nr_allocated >=
-	TagAlloc[cmd->target][cmd->lun].queue_size ) {
+    if (TagAlloc[cmd->device->id][cmd->device->lun].nr_allocated >=
+	TagAlloc[cmd->device->id][cmd->device->lun].queue_size ) {
 	TAG_PRINTK( "scsi%d: target %d lun %d: no free tags\n",
-		    H_NO(cmd), cmd->target, cmd->lun );
+		    H_NO(cmd), cmd->device->id, cmd->device->lun );
 	return( 1 );
     }
     return( 0 );
@@ -384,7 +384,7 @@
 
 static void cmd_get_tag( Scsi_Cmnd *cmd, int should_be_tagged )
 {
-    SETUP_HOSTDATA(cmd->host);
+    SETUP_HOSTDATA(cmd->device->host);
 
     /* If we or the target don't support tagged queuing, allocate the LUN for
      * an untagged command.
@@ -392,19 +392,19 @@
     if (!should_be_tagged ||
 	!setup_use_tagged_queuing || !cmd->device->tagged_supported) {
 	cmd->tag = TAG_NONE;
-	hostdata->busy[cmd->target] |= (1 << cmd->lun);
+	hostdata->busy[cmd->device->id] |= (1 << cmd->device->lun);
 	TAG_PRINTK( "scsi%d: target %d lun %d now allocated by untagged "
-		    "command\n", H_NO(cmd), cmd->target, cmd->lun );
+		    "command\n", H_NO(cmd), cmd->device->id, cmd->device->lun );
     }
     else {
-	TAG_ALLOC *ta = &TagAlloc[cmd->target][cmd->lun];
+	TAG_ALLOC *ta = &TagAlloc[cmd->device->id][cmd->device->lun];
 
 	cmd->tag = find_first_zero_bit( &ta->allocated, MAX_TAGS );
 	set_bit( cmd->tag, &ta->allocated );
 	ta->nr_allocated++;
 	TAG_PRINTK( "scsi%d: using tag %d for target %d lun %d "
 		    "(now %d tags in use)\n",
-		    H_NO(cmd), cmd->tag, cmd->target, cmd->lun,
+		    H_NO(cmd), cmd->tag, cmd->device->id, cmd->device->lun,
 		    ta->nr_allocated );
     }
 }
@@ -416,23 +416,23 @@
 
 static void cmd_free_tag( Scsi_Cmnd *cmd )
 {
-    SETUP_HOSTDATA(cmd->host);
+    SETUP_HOSTDATA(cmd->device->host);
 
     if (cmd->tag == TAG_NONE) {
-	hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
+	hostdata->busy[cmd->device->id] &= ~(1 << cmd->device->lun);
 	TAG_PRINTK( "scsi%d: target %d lun %d untagged cmd finished\n",
-		    H_NO(cmd), cmd->target, cmd->lun );
+		    H_NO(cmd), cmd->device->id, cmd->device->lun );
     }
     else if (cmd->tag >= MAX_TAGS) {
 	printk(KERN_NOTICE "scsi%d: trying to free bad tag %d!\n",
 		H_NO(cmd), cmd->tag );
     }
     else {
-	TAG_ALLOC *ta = &TagAlloc[cmd->target][cmd->lun];
+	TAG_ALLOC *ta = &TagAlloc[cmd->device->id][cmd->device->lun];
 	clear_bit( cmd->tag, &ta->allocated );
 	ta->nr_allocated--;
 	TAG_PRINTK( "scsi%d: freed tag %d for target %d lun %d\n",
-		    H_NO(cmd), cmd->tag, cmd->target, cmd->lun );
+		    H_NO(cmd), cmd->tag, cmd->device->id, cmd->device->lun );
     }
 }
 
@@ -819,7 +819,7 @@
     int i, s;
     unsigned char *command;
     SPRINTF("scsi%d: destination target %d, lun %d\n",
-	    H_NO(cmd), cmd->target, cmd->lun);
+	    H_NO(cmd), cmd->device->id, cmd->device->lun);
     SPRINTF("        command = ");
     command = cmd->cmnd;
     SPRINTF("%2d (0x%02x)", command[0], command[0]);
@@ -911,7 +911,7 @@
 /* Only make static if a wrapper function is used */
 static int NCR5380_queue_command (Scsi_Cmnd *cmd, void (*done)(Scsi_Cmnd *))
 {
-    SETUP_HOSTDATA(cmd->host);
+    SETUP_HOSTDATA(cmd->device->host);
     Scsi_Cmnd *tmp;
     unsigned long flags;
 
@@ -943,15 +943,15 @@
 	    case WRITE:
 	    case WRITE_6:
 	    case WRITE_10:
-		hostdata->time_write[cmd->target] -= (jiffies - hostdata->timebase);
-		hostdata->bytes_write[cmd->target] += cmd->request_bufflen;
+		hostdata->time_write[cmd->device->id] -= (jiffies - hostdata->timebase);
+		hostdata->bytes_write[cmd->device->id] += cmd->request_bufflen;
 		hostdata->pendingw++;
 		break;
 	    case READ:
 	    case READ_6:
 	    case READ_10:
-		hostdata->time_read[cmd->target] -= (jiffies - hostdata->timebase);
-		hostdata->bytes_read[cmd->target] += cmd->request_bufflen;
+		hostdata->time_read[cmd->device->id] -= (jiffies - hostdata->timebase);
+		hostdata->bytes_read[cmd->device->id] += cmd->request_bufflen;
 		hostdata->pendingr++;
 		break;
 	}
@@ -1096,7 +1096,7 @@
 #ifdef SUPPORT_TAGS
 		    !is_lun_busy( tmp, tmp->cmnd[0] != REQUEST_SENSE)
 #else
-		    !(hostdata->busy[tmp->target] & (1 << tmp->lun))
+		    !(hostdata->busy[tmp->device->id] & (1 << tmp->device->lun))
 #endif
 		    ) {
 		    /* ++guenther: just to be sure, this must be atomic */
@@ -1350,15 +1350,15 @@
 	    case WRITE:
 	    case WRITE_6:
 	    case WRITE_10:
-		hostdata->time_write[cmd->target] += (jiffies - hostdata->timebase);
-		/*hostdata->bytes_write[cmd->target] += cmd->request_bufflen;*/
+		hostdata->time_write[cmd->device->id] += (jiffies - hostdata->timebase);
+		/*hostdata->bytes_write[cmd->device->id] += cmd->request_bufflen;*/
 		hostdata->pendingw--;
 		break;
 	    case READ:
 	    case READ_6:
 	    case READ_10:
-		hostdata->time_read[cmd->target] += (jiffies - hostdata->timebase);
-		/*hostdata->bytes_read[cmd->target] += cmd->request_bufflen;*/
+		hostdata->time_read[cmd->device->id] += (jiffies - hostdata->timebase);
+		/*hostdata->bytes_read[cmd->device->id] += cmd->request_bufflen;*/
 		hostdata->pendingr--;
 		break;
 	}
@@ -1519,7 +1519,7 @@
      * the host and target ID's on the SCSI bus.
      */
 
-    NCR5380_write(OUTPUT_DATA_REG, (hostdata->id_mask | (1 << cmd->target)));
+    NCR5380_write(OUTPUT_DATA_REG, (hostdata->id_mask | (1 << cmd->device->id)));
 
     /* 
      * Raise ATN while SEL is true before BSY goes false from arbitration,
@@ -1572,7 +1572,7 @@
 
     udelay(1);
 
-    SEL_PRINTK("scsi%d: selecting target %d\n", HOSTNO, cmd->target);
+    SEL_PRINTK("scsi%d: selecting target %d\n", HOSTNO, cmd->device->id);
 
     /* 
      * The SCSI specification calls for a 250 ms timeout for the actual 
@@ -1623,7 +1623,7 @@
 
     if (!(NCR5380_read(STATUS_REG) & SR_BSY)) {
 	NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE);
-	if (hostdata->targets_present & (1 << cmd->target)) {
+	if (hostdata->targets_present & (1 << cmd->device->id)) {
 	    printk(KERN_ERR "scsi%d: weirdness\n", HOSTNO);
 	    if (hostdata->restart_select)
 		printk(KERN_NOTICE "\trestart select\n");
@@ -1645,7 +1645,7 @@
 	return 0;
     } 
 
-    hostdata->targets_present |= (1 << cmd->target);
+    hostdata->targets_present |= (1 << cmd->device->id);
 
     /*
      * Since we followed the SCSI spec, and raised ATN while SEL 
@@ -1666,8 +1666,8 @@
     while (!(NCR5380_read(STATUS_REG) & SR_REQ));
 
     SEL_PRINTK("scsi%d: target %d selected, going into MESSAGE OUT phase.\n",
-	       HOSTNO, cmd->target);
-    tmp[0] = IDENTIFY(1, cmd->lun);
+	       HOSTNO, cmd->device->id);
+    tmp[0] = IDENTIFY(1, cmd->device->lun);
 
 #ifdef SUPPORT_TAGS
     if (cmd->tag != TAG_NONE) {
@@ -1689,7 +1689,7 @@
     /* XXX need to handle errors here */
     hostdata->connected = cmd;
 #ifndef SUPPORT_TAGS
-    hostdata->busy[cmd->target] |= (1 << cmd->lun);
+    hostdata->busy[cmd->device->id] |= (1 << cmd->device->lun);
 #endif    
 #ifdef SUN3_SCSI_VME
     dregs->csr |= CSR_INTR;
@@ -2104,7 +2104,7 @@
 			 * polled-IO. */ 
 			printk(KERN_NOTICE "scsi%d: switching target %d "
 			       "lun %d to slow handshake\n", HOSTNO,
-			       cmd->target, cmd->lun);
+			       cmd->device->id, cmd->device->lun);
 			cmd->device->borken = 1;
 			NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE | 
 			    ICR_ASSERT_ATN);
@@ -2162,7 +2162,7 @@
 		    NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE);
 		    
 		    LNK_PRINTK("scsi%d: target %d lun %d linked command "
-			       "complete.\n", HOSTNO, cmd->target, cmd->lun);
+			       "complete.\n", HOSTNO, cmd->device->id, cmd->device->lun);
 
 		    /* Enable reselect interrupts */
 		    NCR5380_write(SELECT_ENABLE_REG, hostdata->id_mask);
@@ -2175,7 +2175,7 @@
 		    if (!cmd->next_link) {
 			 printk(KERN_NOTICE "scsi%d: target %d lun %d "
 				"linked command complete, no next_link\n",
-				HOSTNO, cmd->target, cmd->lun);
+				HOSTNO, cmd->device->id, cmd->device->lun);
 			    sink = 1;
 			    do_abort (instance);
 			    return;
@@ -2188,7 +2188,7 @@
 		    cmd->result = cmd->SCp.Status | (cmd->SCp.Message << 8); 
 		    LNK_PRINTK("scsi%d: target %d lun %d linked request "
 			       "done, calling scsi_done().\n",
-			       HOSTNO, cmd->target, cmd->lun);
+			       HOSTNO, cmd->device->id, cmd->device->lun);
 #ifdef NCR5380_STATS
 		    collect_stats(hostdata, cmd);
 #endif
@@ -2202,7 +2202,7 @@
 		    NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE);
 		    hostdata->connected = NULL;
 		    QU_PRINTK("scsi%d: command for target %d, lun %d "
-			      "completed\n", HOSTNO, cmd->target, cmd->lun);
+			      "completed\n", HOSTNO, cmd->device->id, cmd->device->lun);
 #ifdef SUPPORT_TAGS
 		    cmd_free_tag( cmd );
 		    if (status_byte(cmd->SCp.Status) == QUEUE_FULL) {
@@ -2214,16 +2214,16 @@
 			 */
 			/* ++Andreas: the mid level code knows about
 			   QUEUE_FULL now. */
-			TAG_ALLOC *ta = &TagAlloc[cmd->target][cmd->lun];
+			TAG_ALLOC *ta = &TagAlloc[cmd->device->id][cmd->device->lun];
 			TAG_PRINTK("scsi%d: target %d lun %d returned "
 				   "QUEUE_FULL after %d commands\n",
-				   HOSTNO, cmd->target, cmd->lun,
+				   HOSTNO, cmd->device->id, cmd->device->lun,
 				   ta->nr_allocated);
 			if (ta->queue_size > ta->nr_allocated)
 			    ta->nr_allocated = ta->queue_size;
 		    }
 #else
-		    hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
+		    hostdata->busy[cmd->device->id] &= ~(1 << cmd->device->lun);
 #endif
 		    /* Enable reselect interrupts */
 		    NCR5380_write(SELECT_ENABLE_REG, hostdata->id_mask);
@@ -2313,12 +2313,12 @@
 			 * the command is treated as untagged further on.
 			 */
 			cmd->device->tagged_supported = 0;
-			hostdata->busy[cmd->target] |= (1 << cmd->lun);
+			hostdata->busy[cmd->device->id] |= (1 << cmd->device->lun);
 			cmd->tag = TAG_NONE;
 			TAG_PRINTK("scsi%d: target %d lun %d rejected "
 				   "QUEUE_TAG message; tagged queuing "
 				   "disabled\n",
-				   HOSTNO, cmd->target, cmd->lun);
+				   HOSTNO, cmd->device->id, cmd->device->lun);
 			break;
 		    }
 		    break;
@@ -2335,7 +2335,7 @@
 		    QU_PRINTK("scsi%d: command for target %d lun %d was "
 			      "moved from connected to the "
 			      "disconnected_queue\n", HOSTNO, 
-			      cmd->target, cmd->lun);
+			      cmd->device->id, cmd->device->lun);
 		    /* 
 		     * Restore phase bits to 0 so an interrupted selection, 
 		     * arbitration can resume.
@@ -2437,13 +2437,13 @@
 		    } else if (tmp != EXTENDED_MESSAGE)
 			printk(KERN_DEBUG "scsi%d: rejecting unknown "
 			       "message %02x from target %d, lun %d\n",
-			       HOSTNO, tmp, cmd->target, cmd->lun);
+			       HOSTNO, tmp, cmd->device->id, cmd->device->lun);
 		    else
 			printk(KERN_DEBUG "scsi%d: rejecting unknown "
 			       "extended message "
 			       "code %02x, length %d from target %d, lun %d\n",
 			       HOSTNO, extended_msg[1], extended_msg[0],
-			       cmd->target, cmd->lun);
+			       cmd->device->id, cmd->device->lun);
    
 
 		    msgout = MESSAGE_REJECT;
@@ -2461,7 +2461,7 @@
 #ifdef SUPPORT_TAGS
 		    cmd_free_tag( cmd );
 #else
-		    hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
+		    hostdata->busy[cmd->device->id] &= ~(1 << cmd->device->lun);
 #endif
 		    hostdata->connected = NULL;
 		    cmd->result = DID_ERROR << 16;
@@ -2580,7 +2580,7 @@
 
     for (tmp = (Scsi_Cmnd *) hostdata->disconnected_queue, prev = NULL; 
 	 tmp; prev = tmp, tmp = NEXT(tmp) ) {
-	if ((target_mask == (1 << tmp->target)) && (lun == tmp->lun)
+	if ((target_mask == (1 << tmp->device->id)) && (lun == tmp->device->lun)
 #ifdef SUPPORT_TAGS
 	    && (tag == tmp->tag) 
 #endif
@@ -2687,7 +2687,7 @@
 
 static int NCR5380_abort (Scsi_Cmnd *cmd)
 {
-    struct Scsi_Host *instance = cmd->host;
+    struct Scsi_Host *instance = cmd->device->host;
     SETUP_HOSTDATA(instance);
     Scsi_Cmnd *tmp, **prev;
     unsigned long flags;
@@ -2737,7 +2737,7 @@
 #ifdef SUPPORT_TAGS
 	  cmd_free_tag( cmd );
 #else
-	  hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
+	  hostdata->busy[cmd->device->id] &= ~(1 << cmd->device->lun);
 #endif
 	  local_irq_restore(flags);
 	  cmd->scsi_done(cmd);
@@ -2842,7 +2842,7 @@
 #ifdef SUPPORT_TAGS
 		    cmd_free_tag( tmp );
 #else
-		    hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
+		    hostdata->busy[cmd->device->id] &= ~(1 << cmd->device->lun);
 #endif
 		    local_irq_restore(flags);
 		    tmp->scsi_done(tmp);
@@ -2879,7 +2879,7 @@
 
 static int NCR5380_bus_reset( Scsi_Cmnd *cmd)
 {
-    SETUP_HOSTDATA(cmd->host);
+    SETUP_HOSTDATA(cmd->device->host);
     int           i;
     unsigned long flags;
 #if 1
@@ -2887,7 +2887,7 @@
 #endif
 
 
-    NCR5380_print_status (cmd->host);
+    NCR5380_print_status (cmd->device->host);
 
     /* get in phase */
     NCR5380_write( TARGET_COMMAND_REG,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
