Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWJBMzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWJBMzp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 08:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWJBMzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 08:55:45 -0400
Received: from server6.greatnet.de ([83.133.96.26]:29828 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S932266AbWJBMzn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 08:55:43 -0400
Message-ID: <45210C77.2050701@nachtwindheim.de>
Date: Mon, 02 Oct 2006 14:56:23 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: [PATCH] scsi: Convertion to struct scsi_cmnd in ips-driver
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Converts the obsolete Scsi_Cmnd to struct scsi_cmnd in the ips-driver.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---
Tested by compilation on x86_64, so it will work on all other archs, too.
 ips.c |   83 ++++++++++++++++++++++++++++++------------------------------------
 ips.h |   16 ++++++------
 2 files changed, 46 insertions(+), 53 deletions(-)


diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index 3c63928..e488f49 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -250,9 +250,9 @@ #endif
  */
 static int ips_detect(struct scsi_host_template *);
 static int ips_release(struct Scsi_Host *);
-static int ips_eh_abort(Scsi_Cmnd *);
-static int ips_eh_reset(Scsi_Cmnd *);
-static int ips_queue(Scsi_Cmnd *, void (*)(Scsi_Cmnd *));
+static int ips_eh_abort(struct scsi_cmnd *);
+static int ips_eh_reset(struct scsi_cmnd *);
+static int ips_queue(struct scsi_cmnd *, void (*)(struct scsi_cmnd *));
 static const char *ips_info(struct Scsi_Host *);
 static irqreturn_t do_ipsintr(int, void *, struct pt_regs *);
 static int ips_hainit(ips_ha_t *);
@@ -325,24 +325,26 @@ static uint32_t ips_statupd_copperhead_m
 static uint32_t ips_statupd_morpheus(ips_ha_t *);
 static ips_scb_t *ips_getscb(ips_ha_t *);
 static void ips_putq_scb_head(ips_scb_queue_t *, ips_scb_t *);
-static void ips_putq_wait_tail(ips_wait_queue_t *, Scsi_Cmnd *);
+static void ips_putq_wait_tail(ips_wait_queue_t *, struct scsi_cmnd *);
 static void ips_putq_copp_tail(ips_copp_queue_t *,
 				      ips_copp_wait_item_t *);
 static ips_scb_t *ips_removeq_scb_head(ips_scb_queue_t *);
 static ips_scb_t *ips_removeq_scb(ips_scb_queue_t *, ips_scb_t *);
-static Scsi_Cmnd *ips_removeq_wait_head(ips_wait_queue_t *);
-static Scsi_Cmnd *ips_removeq_wait(ips_wait_queue_t *, Scsi_Cmnd *);
+static struct scsi_cmnd *ips_removeq_wait_head(ips_wait_queue_t *);
+static struct scsi_cmnd *ips_removeq_wait(ips_wait_queue_t *,
+					  struct scsi_cmnd *);
 static ips_copp_wait_item_t *ips_removeq_copp(ips_copp_queue_t *,
 						     ips_copp_wait_item_t *);
 static ips_copp_wait_item_t *ips_removeq_copp_head(ips_copp_queue_t *);
 
-static int ips_is_passthru(Scsi_Cmnd *);
-static int ips_make_passthru(ips_ha_t *, Scsi_Cmnd *, ips_scb_t *, int);
+static int ips_is_passthru(struct scsi_cmnd *);
+static int ips_make_passthru(ips_ha_t *, struct scsi_cmnd *, ips_scb_t *, int);
 static int ips_usrcmd(ips_ha_t *, ips_passthru_t *, ips_scb_t *);
 static void ips_cleanup_passthru(ips_ha_t *, ips_scb_t *);
-static void ips_scmd_buf_write(Scsi_Cmnd * scmd, void *data,
+static void ips_scmd_buf_write(struct scsi_cmnd * scmd, void *data,
 			       unsigned int count);
-static void ips_scmd_buf_read(Scsi_Cmnd * scmd, void *data, unsigned int count);
+static void ips_scmd_buf_read(struct scsi_cmnd * scmd, void *data,
+			      unsigned int count);
 
 static int ips_proc_info(struct Scsi_Host *, char *, char **, off_t, int, int);
 static int ips_host_info(ips_ha_t *, char *, off_t, int);
@@ -812,8 +814,7 @@ ips_halt(struct notifier_block *nb, ulon
 /*   Abort a command (using the new error code stuff)                       */
 /* Note: this routine is called under the io_request_lock                   */
 /****************************************************************************/
-int
-ips_eh_abort(Scsi_Cmnd * SC)
+int ips_eh_abort(struct scsi_cmnd *SC)
 {
 	ips_ha_t *ha;
 	ips_copp_wait_item_t *item;
@@ -871,8 +872,7 @@ ips_eh_abort(Scsi_Cmnd * SC)
 /* NOTE: this routine is called under the io_request_lock spinlock          */
 /*                                                                          */
 /****************************************************************************/
-static int
-__ips_eh_reset(Scsi_Cmnd * SC)
+static int __ips_eh_reset(struct scsi_cmnd *SC)
 {
 	int ret;
 	int i;
@@ -968,7 +968,7 @@ #else
 	ret = (*ha->func.reset) (ha);
 
 	if (!ret) {
-		Scsi_Cmnd *scsi_cmd;
+		struct scsi_cmnd *scsi_cmd;
 
 		IPS_PRINTK(KERN_NOTICE, ha->pcidev,
 			   "Controller reset failed - controller now offline.\n");
@@ -997,7 +997,7 @@ #else
 	}
 
 	if (!ips_clear_adapter(ha, IPS_INTR_IORL)) {
-		Scsi_Cmnd *scsi_cmd;
+		struct scsi_cmnd *scsi_cmd;
 
 		IPS_PRINTK(KERN_NOTICE, ha->pcidev,
 			   "Controller reset failed - controller now offline.\n");
@@ -1059,8 +1059,7 @@ #endif				/* NO_IPS_RESET */
 
 }
 
-static int
-ips_eh_reset(Scsi_Cmnd * SC)
+static int ips_eh_reset(struct scsi_cmnd *SC)
 {
 	int rc;
 
@@ -1083,8 +1082,7 @@ ips_eh_reset(Scsi_Cmnd * SC)
 /*    Linux obtains io_request_lock before calling this function            */
 /*                                                                          */
 /****************************************************************************/
-static int
-ips_queue(Scsi_Cmnd * SC, void (*done) (Scsi_Cmnd *))
+static int ips_queue(struct scsi_cmnd *SC, void (*done) (struct scsi_cmnd *))
 {
 	ips_ha_t *ha;
 	ips_passthru_t *pt;
@@ -1602,8 +1600,7 @@ ips_proc_info(struct Scsi_Host *host, ch
 /*   Determine if the specified SCSI command is really a passthru command   */
 /*                                                                          */
 /****************************************************************************/
-static int
-ips_is_passthru(Scsi_Cmnd * SC)
+static int ips_is_passthru(struct scsi_cmnd *SC)
 {
 	unsigned long flags;
 
@@ -1685,7 +1682,7 @@ ips_alloc_passthru_buffer(ips_ha_t * ha,
 /*                                                                          */
 /****************************************************************************/
 static int
-ips_make_passthru(ips_ha_t * ha, Scsi_Cmnd * SC, ips_scb_t * scb, int intr)
+ips_make_passthru(ips_ha_t *ha, struct scsi_cmnd *SC, ips_scb_t *scb, int intr)
 {
 	ips_passthru_t *pt;
 	int length = 0;
@@ -2734,9 +2731,9 @@ static void
 ips_next(ips_ha_t * ha, int intr)
 {
 	ips_scb_t *scb;
-	Scsi_Cmnd *SC;
-	Scsi_Cmnd *p;
-	Scsi_Cmnd *q;
+	struct scsi_cmnd *SC;
+	struct scsi_cmnd *p;
+	struct scsi_cmnd *q;
 	ips_copp_wait_item_t *item;
 	int ret;
 	unsigned long cpu_flags = 0;
@@ -2847,7 +2844,7 @@ ips_next(ips_ha_t * ha, int intr)
 			dcdb_active[scmd_channel(p) -
 				    1] & (1 << scmd_id(p)))) {
 			ips_freescb(ha, scb);
-			p = (Scsi_Cmnd *) p->host_scribble;
+			p = (struct scsi_cmnd *) p->host_scribble;
 			continue;
 		}
 
@@ -2962,7 +2959,7 @@ ips_next(ips_ha_t * ha, int intr)
 			break;
 		}		/* end case */
 
-		p = (Scsi_Cmnd *) p->host_scribble;
+		p = (struct scsi_cmnd *) p->host_scribble;
 
 	}			/* end while */
 
@@ -3090,8 +3087,7 @@ ips_removeq_scb(ips_scb_queue_t * queue,
 /* ASSUMED to be called from within the HA lock                             */
 /*                                                                          */
 /****************************************************************************/
-static void
-ips_putq_wait_tail(ips_wait_queue_t * queue, Scsi_Cmnd * item)
+static void ips_putq_wait_tail(ips_wait_queue_t *queue, struct scsi_cmnd *item)
 {
 	METHOD_TRACE("ips_putq_wait_tail", 1);
 
@@ -3122,10 +3118,9 @@ ips_putq_wait_tail(ips_wait_queue_t * qu
 /* ASSUMED to be called from within the HA lock                             */
 /*                                                                          */
 /****************************************************************************/
-static Scsi_Cmnd *
-ips_removeq_wait_head(ips_wait_queue_t * queue)
+static struct scsi_cmnd *ips_removeq_wait_head(ips_wait_queue_t *queue)
 {
-	Scsi_Cmnd *item;
+	struct scsi_cmnd *item;
 
 	METHOD_TRACE("ips_removeq_wait_head", 1);
 
@@ -3135,7 +3130,7 @@ ips_removeq_wait_head(ips_wait_queue_t *
 		return (NULL);
 	}
 
-	queue->head = (Scsi_Cmnd *) item->host_scribble;
+	queue->head = (struct scsi_cmnd *) item->host_scribble;
 	item->host_scribble = NULL;
 
 	if (queue->tail == item)
@@ -3157,10 +3152,10 @@ ips_removeq_wait_head(ips_wait_queue_t *
 /* ASSUMED to be called from within the HA lock                             */
 /*                                                                          */
 /****************************************************************************/
-static Scsi_Cmnd *
-ips_removeq_wait(ips_wait_queue_t * queue, Scsi_Cmnd * item)
+static struct scsi_cmnd *ips_removeq_wait(ips_wait_queue_t *queue,
+					  struct scsi_cmnd *item)
 {
-	Scsi_Cmnd *p;
+	struct scsi_cmnd *p;
 
 	METHOD_TRACE("ips_removeq_wait", 1);
 
@@ -3173,8 +3168,8 @@ ips_removeq_wait(ips_wait_queue_t * queu
 
 	p = queue->head;
 
-	while ((p) && (item != (Scsi_Cmnd *) p->host_scribble))
-		p = (Scsi_Cmnd *) p->host_scribble;
+	while ((p) && (item != (struct scsi_cmnd *) p->host_scribble))
+		p = (struct scsi_cmnd *) p->host_scribble;
 
 	if (p) {
 		/* found a match */
@@ -3659,11 +3654,10 @@ ips_send_wait(ips_ha_t * ha, ips_scb_t *
 /* Routine Name: ips_scmd_buf_write                                         */
 /*                                                                          */
 /* Routine Description:                                                     */
-/*  Write data to Scsi_Cmnd request_buffer at proper offsets                */
+/*  Write data to struct scsi_cmnd request_buffer at proper offsets	    */
 /****************************************************************************/
 static void
-ips_scmd_buf_write(Scsi_Cmnd * scmd, void *data, unsigned
-		   int count)
+ips_scmd_buf_write(struct scsi_cmnd *scmd, void *data, unsigned int count)
 {
 	if (scmd->use_sg) {
 		int i;
@@ -3698,11 +3692,10 @@ ips_scmd_buf_write(Scsi_Cmnd * scmd, voi
 /* Routine Name: ips_scmd_buf_read                                          */
 /*                                                                          */
 /* Routine Description:                                                     */
-/*  Copy data from a Scsi_Cmnd to a new, linear buffer                      */
+/*  Copy data from a struct scsi_cmnd to a new, linear buffer		    */
 /****************************************************************************/
 static void
-ips_scmd_buf_read(Scsi_Cmnd * scmd, void *data, unsigned
-		  int count)
+ips_scmd_buf_read(struct scsi_cmnd *scmd, void *data, unsigned int count)
 {
 	if (scmd->use_sg) {
 		int i;
diff --git a/drivers/scsi/ips.h b/drivers/scsi/ips.h
index f46c382..34680f3 100644
--- a/drivers/scsi/ips.h
+++ b/drivers/scsi/ips.h
@@ -6,7 +6,7 @@
 /*             David Jeffery, Adaptec, Inc.                                  */
 /*                                                                           */
 /* Copyright (C) 1999 IBM Corporation                                        */
-/* Copyright (C) 2003 Adaptec, Inc.                                          */ 
+/* Copyright (C) 2003 Adaptec, Inc.                                          */
 /*                                                                           */
 /* This program is free software; you can redistribute it and/or modify      */
 /* it under the terms of the GNU General Public License as published by      */
@@ -1033,14 +1033,14 @@ typedef struct ips_scb_queue {
  * Wait queue_format
  */
 typedef struct ips_wait_queue {
-   Scsi_Cmnd      *head;
-   Scsi_Cmnd      *tail;
-   int             count;
+	struct scsi_cmnd *head;
+	struct scsi_cmnd *tail;
+	int count;
 } ips_wait_queue_t;
 
 typedef struct ips_copp_wait_item {
-   Scsi_Cmnd                 *scsi_cmd;
-   struct ips_copp_wait_item *next;
+	struct scsi_cmnd *scsi_cmd;
+	struct ips_copp_wait_item *next;
 } ips_copp_wait_item_t;
 
 typedef struct ips_copp_queue {
@@ -1149,7 +1149,7 @@ typedef struct ips_scb {
    uint32_t          flags;
    uint32_t          op_code;
    IPS_SG_LIST       sg_list;
-   Scsi_Cmnd        *scsi_cmd;
+   struct scsi_cmnd *scsi_cmd;
    struct ips_scb   *q_next;
    ips_scb_callback  callback;
    uint32_t          sg_busaddr;
@@ -1175,7 +1175,7 @@ typedef struct ips_scb_pt {
    uint32_t          flags;
    uint32_t          op_code;
    IPS_SG_LIST      *sg_list;
-   Scsi_Cmnd        *scsi_cmd;
+   struct scsi_cmnd *scsi_cmd;
    struct ips_scb   *q_next;
    ips_scb_callback  callback;
 } ips_scb_pt_t;



