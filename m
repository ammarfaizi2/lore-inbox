Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVJAHHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVJAHHR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 03:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVJAHHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 03:07:16 -0400
Received: from sccrmhc13.comcast.net ([63.240.76.28]:4320 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1750758AbVJAHHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 03:07:15 -0400
Date: Sat, 1 Oct 2005 00:07:17 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [drivers/fc4] kmalloc + memset -> kzalloc conversion
Message-ID: <20051001070717.GH25424@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/drivers/fc4/fc.c b/drivers/fc4/fc.c
--- a/drivers/fc4/fc.c
+++ b/drivers/fc4/fc.c
@@ -266,13 +266,12 @@ static void fcp_report_map_done(fc_chann
 			printk ("FC: Bad magic from REPORT_AL_MAP on %s - %08x\n", fc->name, p->magic);
 			fc->state = FC_STATE_OFFLINE;
 		} else {
-			fc->posmap = (fcp_posmap *)kmalloc(sizeof(fcp_posmap)+p->len, GFP_KERNEL);
+			fc->posmap = (fcp_posmap *)kzalloc(sizeof(fcp_posmap)+p->len, GFP_KERNEL);
 			if (!fc->posmap) {
 				printk("FC: Not enough memory, offlining channel\n");
 				fc->state = FC_STATE_OFFLINE;
 			} else {
 				int k;
-				memset(fc->posmap, 0, sizeof(fcp_posmap)+p->len);
 				/* FIXME: This is where SOCAL transfers our AL-PA.
 				   Keep it here till we found out what other cards do... */
 				fc->sid = (p->magic & 0xff);
@@ -351,14 +350,12 @@ void fcp_register(fc_channel *fc, u8 typ
 			fc->dma_scsi_rsp = fc->dma_scsi_cmd + slots * sizeof (fcp_cmd);
 			fc->scsi_bitmap_end = (slots + 63) & ~63;
 			size = fc->scsi_bitmap_end / 8;
-			fc->scsi_bitmap = kmalloc (size, GFP_KERNEL);
-			memset (fc->scsi_bitmap, 0, size);
+			fc->scsi_bitmap = kzalloc (size, GFP_KERNEL);
 			set_bit (0, fc->scsi_bitmap);
 			for (i = fc->can_queue; i < fc->scsi_bitmap_end; i++)
 				set_bit (i, fc->scsi_bitmap);
 			fc->scsi_free = fc->can_queue;
-			fc->cmd_slots = (fcp_cmnd **)kmalloc(slots * sizeof(fcp_cmnd*), GFP_KERNEL);
-			memset(fc->cmd_slots, 0, slots * sizeof(fcp_cmnd*));
+			fc->cmd_slots = (fcp_cmnd **)kzalloc(slots * sizeof(fcp_cmnd*), GFP_KERNEL);
 			fc->abort_count = 0;
 		} else {
 			fc->scsi_name[0] = 0;
@@ -541,12 +538,11 @@ int fcp_initialize(fc_channel *fcchain, 
 	FCND(("fcp_inititialize %08lx\n", (long)fcp_init))
 	FCND(("fc_channels %08lx\n", (long)fc_channels))
 	FCND((" SID %d DID %d\n", fcchain->sid, fcchain->did))
-	l = kmalloc(sizeof (ls) + count, GFP_KERNEL);
+	l = kzalloc(sizeof (ls) + count, GFP_KERNEL);
 	if (!l) {
 		printk ("FC: Cannot allocate memory for initialization\n");
 		return -ENOMEM;
 	}
-	memset (l, 0, sizeof(ls) + count);
 	l->magic = LSMAGIC;
 	l->count = count;
 	FCND(("FCP Init for %d channels\n", count))
@@ -555,8 +551,8 @@ int fcp_initialize(fc_channel *fcchain, 
 	l->timer.function = fcp_login_timeout;
 	l->timer.data = (unsigned long)l;
 	atomic_set (&l->todo, count);
-	l->logi = kmalloc (count * 3 * sizeof(logi), GFP_KERNEL);
-	l->fcmds = kmalloc (count * sizeof(fcp_cmnd), GFP_KERNEL);
+	l->logi = kzalloc (count * 3 * sizeof(logi), GFP_KERNEL);
+	l->fcmds = kzalloc (count * sizeof(fcp_cmnd), GFP_KERNEL);
 	if (!l->logi || !l->fcmds) {
 		if (l->logi) kfree (l->logi);
 		if (l->fcmds) kfree (l->fcmds);
@@ -564,8 +560,6 @@ int fcp_initialize(fc_channel *fcchain, 
 		printk ("FC: Cannot allocate DMA memory for initialization\n");
 		return -ENOMEM;
 	}
-	memset (l->logi, 0, count * 3 * sizeof(logi));
-	memset (l->fcmds, 0, count * sizeof(fcp_cmnd));
 	for (fc = fcchain, i = 0; fc && i < count; fc = fc->next, i++) {
 		fc->state = FC_STATE_UNINITED;
 		fc->rst_pkt = NULL;	/* kmalloc when first used */
@@ -678,13 +672,12 @@ int fcp_forceoffline(fc_channel *fcchain
 	l.timer.function = fcp_login_timeout;
 	l.timer.data = (unsigned long)&l;
 	atomic_set (&l.todo, count);
-	l.fcmds = kmalloc (count * sizeof(fcp_cmnd), GFP_KERNEL);
+	l.fcmds = kzalloc (count * sizeof(fcp_cmnd), GFP_KERNEL);
 	if (!l.fcmds) {
 		kfree (l.fcmds);
 		printk ("FC: Cannot allocate memory for forcing offline\n");
 		return -ENOMEM;
 	}
-	memset (l.fcmds, 0, count * sizeof(fcp_cmnd));
 	FCND(("Initializing OFFLINE packets\n"))
 	for (fc = fcchain, i = 0; fc && i < count; fc = fc->next, i++) {
 		fc->state = FC_STATE_UNINITED;
@@ -1114,9 +1107,8 @@ int fc_do_plogi(fc_channel *fc, unsigned
 	logi *l;
 	int status;
 
-	l = (logi *)kmalloc(2 * sizeof(logi), GFP_KERNEL);
+	l = (logi *)kzalloc(2 * sizeof(logi), GFP_KERNEL);
 	if (!l) return -ENOMEM;
-	memset(l, 0, 2 * sizeof(logi));
 	l->code = LS_PLOGI;
 	memcpy (&l->nport_wwn, &fc->wwn_nport, sizeof(fc_wwn));
 	memcpy (&l->node_wwn, &fc->wwn_node, sizeof(fc_wwn));
@@ -1149,9 +1141,8 @@ int fc_do_prli(fc_channel *fc, unsigned 
 	prli *p;
 	int status;
 
-	p = (prli *)kmalloc(2 * sizeof(prli), GFP_KERNEL);
+	p = (prli *)kzalloc(2 * sizeof(prli), GFP_KERNEL);
 	if (!p) return -ENOMEM;
-	memset(p, 0, 2 * sizeof(prli));
 	p->code = LS_PRLI;
 	p->params[0] = 0x08002000;
 	p->params[3] = 0x00000022;
diff --git a/drivers/fc4/soc.c b/drivers/fc4/soc.c
--- a/drivers/fc4/soc.c
+++ b/drivers/fc4/soc.c
@@ -556,10 +556,9 @@ static inline void soc_init(struct sbus_
 	int size, i;
 	int irq;
 	
-	s = kmalloc (sizeof (struct soc), GFP_KERNEL);
+	s = kzalloc (sizeof (struct soc), GFP_KERNEL);
 	if (s == NULL)
 		return;
-	memset (s, 0, sizeof(struct soc));
 	spin_lock_init(&s->lock);
 	s->soc_no = no;
 
diff --git a/drivers/fc4/socal.c b/drivers/fc4/socal.c
--- a/drivers/fc4/socal.c
+++ b/drivers/fc4/socal.c
@@ -665,9 +665,8 @@ static inline void socal_init(struct sbu
 	int size, i;
 	int irq, node;
 	
-	s = kmalloc (sizeof (struct socal), GFP_KERNEL);
+	s = kzalloc (sizeof (struct socal), GFP_KERNEL);
 	if (!s) return;
-	memset (s, 0, sizeof(struct socal));
 	spin_lock_init(&s->lock);
 	s->socal_no = no;
 
-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
