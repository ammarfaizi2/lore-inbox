Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbUKSIlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbUKSIlN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 03:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbUKSIlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 03:41:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7608 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261304AbUKSIki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 03:40:38 -0500
Date: Fri, 19 Nov 2004 09:40:04 +0100
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Vladimir B. Savkin" <master@sectorb.msk.ru>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc2 OOPS on boot with 3ware + reiserfs
Message-ID: <20041119084003.GV26240@suse.de>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <20041117165851.GA18044@tentacle.sectorb.msk.ru> <Pine.LNX.4.58.0411170935040.2222@ppc970.osdl.org> <20041118103526.GC26240@suse.de> <20041118160248.GA5922@tentacle.sectorb.msk.ru> <20041118183920.GL26240@suse.de> <20041118191002.GO26240@suse.de> <1100805744.1574.3.camel@mulgrave> <20041118213246.GH2009@suse.de> <1100813973.1574.29.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100813973.1574.29.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18 2004, James Bottomley wrote:
> On Thu, 2004-11-18 at 15:32, Jens Axboe wrote:
> > It's clearly not the only one, the first 3 I looked at all did it.
> > That's the big mess. I'll do an audit.
> 
> Thanks ... I'll owe you a beverage of your choice...

I'm sure that can be arranged :-)

Here's an audit of drivers/scsi, there are quite a few of them in there.
I've opted to keep the ->scsi_done() calls in there and rather return 0,
instead of killing them and returning something more appropriate. I'll
send this to linux-scsi with maintainers CC'ed as well.

===== drivers/scsi/3w-9xxx.c 1.4 vs edited =====
--- 1.4/drivers/scsi/3w-9xxx.c	2004-07-16 17:20:43 +02:00
+++ edited/drivers/scsi/3w-9xxx.c	2004-11-18 22:55:58 +01:00
@@ -1746,6 +1746,7 @@ static int twa_scsi_queue(struct scsi_cm
 		twa_free_request_id(tw_dev, request_id);
 		SCpnt->result = (DID_ERROR << 16);
 		done(SCpnt);
+		reval = 0;
 	}
 
 	return retval;
===== drivers/scsi/3w-xxxx.c 1.47 vs edited =====
--- 1.47/drivers/scsi/3w-xxxx.c	2004-10-07 05:20:16 +02:00
+++ edited/drivers/scsi/3w-xxxx.c	2004-11-18 22:55:31 +01:00
@@ -2067,6 +2067,7 @@ static int tw_scsi_queue(struct scsi_cmn
 		tw_state_request_finish(tw_dev, request_id);
 		SCpnt->result = (DID_ERROR << 16);
 		done(SCpnt);
+		retval = 0;
 	}
 out:
 	return retval;
===== drivers/scsi/ide-scsi.c 1.47 vs edited =====
--- 1.47/drivers/scsi/ide-scsi.c	2004-10-22 01:46:25 +02:00
+++ edited/drivers/scsi/ide-scsi.c	2004-11-18 22:54:09 +01:00
@@ -891,7 +891,7 @@ abort:
 	if (rq) kfree (rq);
 	cmd->result = DID_ERROR << 16;
 	done(cmd);
-	return 1;
+	return 0;
 }
 
 static int idescsi_eh_abort (struct scsi_cmnd *cmd)
===== drivers/scsi/megaraid.c 1.73 vs edited =====
--- 1.73/drivers/scsi/megaraid.c	2004-11-11 09:43:34 +01:00
+++ edited/drivers/scsi/megaraid.c	2004-11-19 09:03:43 +01:00
@@ -634,11 +634,7 @@ mega_build_cmd(adapter_t *adapter, Scsi_
 			}
 
 			if(!(scb = mega_allocate_scb(adapter, cmd))) {
-
-				cmd->result = (DID_ERROR << 16);
-				cmd->scsi_done(cmd);
 				*busy = 1;
-
 				return NULL;
 			}
 
@@ -677,11 +673,7 @@ mega_build_cmd(adapter_t *adapter, Scsi_
 
 			/* Allocate a SCB and initialize passthru */
 			if(!(scb = mega_allocate_scb(adapter, cmd))) {
-
-				cmd->result = (DID_ERROR << 16);
-				cmd->scsi_done(cmd);
 				*busy = 1;
-
 				return NULL;
 			}
 			pthru = scb->pthru;
@@ -723,11 +715,7 @@ mega_build_cmd(adapter_t *adapter, Scsi_
 
 			/* Allocate a SCB and initialize mailbox */
 			if(!(scb = mega_allocate_scb(adapter, cmd))) {
-
-				cmd->result = (DID_ERROR << 16);
-				cmd->scsi_done(cmd);
 				*busy = 1;
-
 				return NULL;
 			}
 			mbox = (mbox_t *)scb->raw_mbox;
@@ -867,11 +855,7 @@ mega_build_cmd(adapter_t *adapter, Scsi_
 
 			/* Allocate a SCB and initialize mailbox */
 			if(!(scb = mega_allocate_scb(adapter, cmd))) {
-
-				cmd->result = (DID_ERROR << 16);
-				cmd->scsi_done(cmd);
 				*busy = 1;
-
 				return NULL;
 			}
 
@@ -899,11 +883,7 @@ mega_build_cmd(adapter_t *adapter, Scsi_
 	else {
 		/* Allocate a SCB and initialize passthru */
 		if(!(scb = mega_allocate_scb(adapter, cmd))) {
-
-			cmd->result = (DID_ERROR << 16);
-			cmd->scsi_done(cmd);
 			*busy = 1;
-
 			return NULL;
 		}
 
===== drivers/scsi/ncr53c8xx.c 1.50 vs edited =====
--- 1.50/drivers/scsi/ncr53c8xx.c	2004-11-11 09:43:34 +01:00
+++ edited/drivers/scsi/ncr53c8xx.c	2004-11-19 09:06:28 +01:00
@@ -7517,6 +7517,7 @@ printk("ncr53c8xx : command successfully
      if (sts != DID_OK) {
           unmap_scsi_data(np, cmd);
           done(cmd);
+	  sts = 0;
      }
 
      return sts;
===== drivers/scsi/nsp32.c 1.32 vs edited =====
--- 1.32/drivers/scsi/nsp32.c	2004-10-20 21:24:36 +02:00
+++ edited/drivers/scsi/nsp32.c	2004-11-19 09:10:05 +01:00
@@ -970,8 +970,7 @@ static int nsp32_queuecommand(struct scs
 		data->CurrentSC = NULL;
 		SCpnt->result   = DID_NO_CONNECT << 16;
 		done(SCpnt);
-
-		return SCSI_MLQUEUE_HOST_BUSY;
+		return 0;
 	}
 
 	/* check target ID is not same as this initiator ID */
@@ -979,7 +978,7 @@ static int nsp32_queuecommand(struct scs
 		nsp32_dbg(NSP32_DEBUG_QUEUECOMMAND, "terget==host???");
 		SCpnt->result = DID_BAD_TARGET << 16;
 		done(SCpnt);
-		return SCSI_MLQUEUE_DEVICE_BUSY;
+		return 0;
 	}
 
 	/* check target LUN is allowable value */
@@ -987,7 +986,7 @@ static int nsp32_queuecommand(struct scs
 		nsp32_dbg(NSP32_DEBUG_QUEUECOMMAND, "no more lun");
 		SCpnt->result = DID_BAD_TARGET << 16;
 		done(SCpnt);
-		return SCSI_MLQUEUE_DEVICE_BUSY;
+		return 0;
 	}
 
 	show_command(SCpnt);
@@ -1019,7 +1018,7 @@ static int nsp32_queuecommand(struct scs
 		nsp32_msg(KERN_ERR, "SGT fail");
 		SCpnt->result = DID_ERROR << 16;
 		nsp32_scsi_done(SCpnt);
-		return SCSI_MLQUEUE_HOST_BUSY;
+		return 0;
 	}
 
 	/* Build IDENTIFY */
@@ -1089,7 +1088,6 @@ static int nsp32_queuecommand(struct scs
 	if (ret != TRUE) {
 		nsp32_dbg(NSP32_DEBUG_QUEUECOMMAND, "selection fail");
 		nsp32_scsi_done(SCpnt);
-		return SCSI_MLQUEUE_DEVICE_BUSY;
 	}
 
 	return 0;
===== drivers/scsi/aacraid/aachba.c 1.29 vs edited =====
--- 1.29/drivers/scsi/aacraid/aachba.c	2004-10-01 17:10:08 +02:00
+++ edited/drivers/scsi/aacraid/aachba.c	2004-11-18 23:10:40 +01:00
@@ -894,7 +894,7 @@ int aac_read(struct scsi_cmnd * scsicmd,
 	aac_io_done(scsicmd);
 	fib_complete(cmd_fibcontext);
 	fib_free(cmd_fibcontext);
-	return -1;
+	return 0;
 }
 
 static int aac_write(struct scsi_cmnd * scsicmd, int cid)
@@ -928,7 +928,7 @@ static int aac_write(struct scsi_cmnd * 
 	if (!(cmd_fibcontext = fib_alloc(dev))) {
 		scsicmd->result = DID_ERROR << 16;
 		aac_io_done(scsicmd);
-		return -1;
+		return 0;
 	}
 	fib_init(cmd_fibcontext);
 
@@ -1004,7 +1004,7 @@ static int aac_write(struct scsi_cmnd * 
 
 	fib_complete(cmd_fibcontext);
 	fib_free(cmd_fibcontext);
-	return -1;
+	return 0;
 }
 
 
===== drivers/scsi/megaraid/megaraid_mbox.c 1.9 vs edited =====
--- 1.9/drivers/scsi/megaraid/megaraid_mbox.c	2004-10-08 17:12:09 +02:00
+++ edited/drivers/scsi/megaraid/megaraid_mbox.c	2004-11-18 23:12:10 +01:00
@@ -1623,6 +1623,7 @@ megaraid_queue_command(struct scsi_cmnd 
 
 	if (!scb) {	// command already completed
 		done(scp);
+		return 0;
 	}
 
 	return if_busy;
===== drivers/scsi/pcmcia/nsp_cs.c 1.35 vs edited =====
--- 1.35/drivers/scsi/pcmcia/nsp_cs.c	2004-10-05 22:11:16 +02:00
+++ edited/drivers/scsi/pcmcia/nsp_cs.c	2004-11-19 09:36:39 +01:00
@@ -226,7 +226,7 @@ static int nsp_queuecommand(Scsi_Cmnd *S
 		nsp_msg(KERN_DEBUG, "CurrentSC!=NULL this can't be happen");
 		SCpnt->result   = DID_BAD_TARGET << 16;
 		nsp_scsi_done(SCpnt);
-		return SCSI_MLQUEUE_HOST_BUSY;
+		return 0;
 	}
 
 #if 0
@@ -273,7 +273,7 @@ static int nsp_queuecommand(Scsi_Cmnd *S
 		nsp_dbg(NSP_DEBUG_QUEUECOMMAND, "selection fail");
 		SCpnt->result   = DID_BUS_BUSY << 16;
 		nsp_scsi_done(SCpnt);
-		return SCSI_MLQUEUE_DEVICE_BUSY;
+		return 0;
 	}
 
 

-- 
Jens Axboe

