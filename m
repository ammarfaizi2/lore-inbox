Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVFTLkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVFTLkb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 07:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVFTLka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 07:40:30 -0400
Received: from smtp06.auna.com ([62.81.186.16]:42425 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261206AbVFTLit convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 07:38:49 -0400
Date: Mon, 20 Jun 2005 11:38:41 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20050619233029.45dd66b8.akpm@osdl.org> (from akpm@osdl.org on
	Mon Jun 20 08:30:29 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1119267521l.17554l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.212.68] Login:jamagallon@able.es Fecha:Mon, 20 Jun 2005 13:38:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.20, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm1/
> 
> 
> - Someone broke /proc/device-tree on ppc64.  It's being looked into.
> 
> - Nothing particularly special here - various fixes and updates.
> 

I had this in my kernel, compiled from lkml ans supposed to fix some brakage
realted to slab management in libata. Is still needed ?

--- linux-2.6.11.orig/drivers/scsi/libata-core.c
+++ linux-2.6.11/drivers/scsi/libata-core.c
@@ -41,6 +41,7 @@
 #include <scsi/scsi.h>
 #include "scsi.h"
 #include "scsi_priv.h"
+#include "scsi_logging.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 #include <asm/io.h>
@@ -2833,6 +2834,11 @@ static void atapi_request_sense(struct a
 	DPRINTK("EXIT\n");
 }
 
+void ata_qc_timeout_done(struct scsi_cmnd *scmd)
+{
+	return;
+}
+
 /**
  *	ata_qc_timeout - Handle timeout of queued command
  *	@qc: Command that timed out
@@ -2865,17 +2871,16 @@ static void ata_qc_timeout(struct ata_qu
 		struct scsi_cmnd *cmd = qc->scsicmd;
 
 		if (!scsi_eh_eflags_chk(cmd, SCSI_EH_CANCEL_CMD)) {
-
 			/* finish completing original command */
+			qc->scsidone = ata_qc_timeout_done;
+
 			__ata_qc_complete(qc);
 
 			atapi_request_sense(ap, dev, cmd);
 
 			cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
-			scsi_finish_command(cmd);
-
-			goto out;
 		}
+		goto out;
 	}
 
 	/* hack alert!  We cannot use the supplied completion
--- linux-2.6.11.orig/drivers/scsi/libata-scsi.c
+++ linux-2.6.11/drivers/scsi/libata-scsi.c
@@ -380,12 +380,6 @@ int ata_scsi_error(struct Scsi_Host *hos
 	ap = (struct ata_port *) &host->hostdata[0];
 	ap->ops->eng_timeout(ap);
 
-	/* TODO: this is per-command; when queueing is supported
-	 * this code will either change or move to a more
-	 * appropriate place
-	 */
-	host->host_failed--;
-
 	DPRINTK("EXIT\n");
 	return 0;
 }
--- linux-2.6.11.orig/drivers/scsi/scsi_error.c
+++ linux-2.6.11/drivers/scsi/scsi_error.c
@@ -1606,6 +1606,40 @@ static void scsi_unjam_host(struct Scsi_
 	scsi_eh_flush_done_q(&eh_done_q);
 }
 
+static void scsi_invoke_strategy_handler(struct Scsi_Host *shost)
+{
+	int rtn;
+	struct list_head *lh, *lh_sf;
+	struct scsi_cmnd *scmd;
+	unsigned long flags;
+	LIST_HEAD(eh_work_q);
+	LIST_HEAD(eh_done_q);
+
+	rtn = shost->hostt->eh_strategy_handler(shost);
+
+	spin_lock_irqsave(shost->host_lock, flags);
+	list_splice_init(&shost->eh_cmd_q, &eh_work_q);
+	spin_unlock_irqrestore(shost->host_lock, flags);
+
+	SCSI_LOG_ERROR_RECOVERY(1, scsi_eh_prt_fail_stats(shost, &eh_work_q));
+
+	list_for_each_safe(lh, lh_sf, &eh_work_q) {
+		scmd = list_entry(lh, struct scsi_cmnd, eh_entry);
+
+		if (scsi_eh_eflags_chk(scmd, SCSI_EH_CANCEL_CMD) ||
+		    !SCSI_SENSE_VALID(scmd))
+			continue;
+		scmd->retries = scmd->allowed;
+		scsi_eh_finish_cmd(scmd, &eh_done_q);
+	}
+
+	if (!list_empty(&eh_work_q))
+		if (!scsi_eh_abort_cmds(&eh_work_q, &eh_done_q))
+			scsi_eh_ready_devs(shost, &eh_work_q, &eh_done_q);
+
+	scsi_eh_flush_done_q(&eh_done_q);
+}
+
 /**
  * scsi_error_handler - Handle errors/timeouts of SCSI cmds.
  * @data:	Host for which we are running.
@@ -1620,7 +1654,6 @@ static void scsi_unjam_host(struct Scsi_
 int scsi_error_handler(void *data)
 {
 	struct Scsi_Host *shost = (struct Scsi_Host *) data;
-	int rtn;
 	DECLARE_MUTEX_LOCKED(sem);
 
 	/*
@@ -1676,8 +1709,8 @@ int scsi_error_handler(void *data)
 		 * what we need to do to get it up and online again (if we can).
 		 * If we fail, we end up taking the thing offline.
 		 */
-		if (shost->hostt->eh_strategy_handler) 
-			rtn = shost->hostt->eh_strategy_handler(shost);
+		if (shost->hostt->eh_strategy_handler)
+			scsi_invoke_strategy_handler(shost);
 		else
 			scsi_unjam_host(shost);
 
	
--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam1 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


