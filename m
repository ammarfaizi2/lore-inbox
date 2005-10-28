Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbVJ1A6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbVJ1A6a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 20:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVJ1A6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 20:58:30 -0400
Received: from havoc.gtf.org ([69.61.125.42]:9937 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965030AbVJ1A6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 20:58:30 -0400
Date: Thu, 27 Oct 2005 20:58:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x sx8 driver update
Message-ID: <20051028005828.GA16764@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'sx8' branch of
master.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

to obtain the following minor sx8 block driver updates.

 drivers/block/sx8.c |   51 +++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 37 insertions(+), 14 deletions(-)

Jeff Garzik:
      drivers/block/sx8: several minor changes
      drivers/block/sx8: kill unused variable

diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index d57007b..1ded3b4 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -1,7 +1,7 @@
 /*
  *  sx8.c: Driver for Promise SATA SX8 looks-like-I2O hardware
  *
- *  Copyright 2004 Red Hat, Inc.
+ *  Copyright 2004-2005 Red Hat, Inc.
  *
  *  Author/maintainer:  Jeff Garzik <jgarzik@pobox.com>
  *
@@ -31,10 +31,6 @@
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
-MODULE_AUTHOR("Jeff Garzik");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Promise SATA SX8 block driver");
-
 #if 0
 #define CARM_DEBUG
 #define CARM_VERBOSE_DEBUG
@@ -45,9 +41,35 @@ MODULE_DESCRIPTION("Promise SATA SX8 blo
 #undef CARM_NDEBUG
 
 #define DRV_NAME "sx8"
-#define DRV_VERSION "0.8"
+#define DRV_VERSION "1.0"
 #define PFX DRV_NAME ": "
 
+MODULE_AUTHOR("Jeff Garzik");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Promise SATA SX8 block driver");
+MODULE_VERSION(DRV_VERSION);
+
+/*
+ * SX8 hardware has a single message queue for all ATA ports.
+ * When this driver was written, the hardware (firmware?) would
+ * corrupt data eventually, if more than one request was outstanding.
+ * As one can imagine, having 8 ports bottlenecking on a single
+ * command hurts performance.
+ *
+ * Based on user reports, later versions of the hardware (firmware?)
+ * seem to be able to survive with more than one command queued.
+ *
+ * Therefore, we default to the safe option -- 1 command -- but
+ * allow the user to increase this.
+ *
+ * SX8 should be able to support up to ~60 queued commands (CARM_MAX_REQ),
+ * but problems seem to occur when you exceed ~30, even on newer hardware.
+ */
+static int max_queue = 1;
+module_param(max_queue, int, 0444);
+MODULE_PARM_DESC(max_queue, "Maximum number of queued commands. (min==1, max==30, safe==1)");
+
+
 #define NEXT_RESP(idx)	((idx + 1) % RMSG_Q_LEN)
 
 /* 0xf is just arbitrary, non-zero noise; this is sorta like poisoning */
@@ -90,12 +112,10 @@ enum {
 
 	/* command message queue limits */
 	CARM_MAX_REQ		= 64,	       /* max command msgs per host */
-	CARM_MAX_Q		= 1,		   /* one command at a time */
 	CARM_MSG_LOW_WATER	= (CARM_MAX_REQ / 4),	     /* refill mark */
 
 	/* S/G limits, host-wide and per-request */
 	CARM_MAX_REQ_SG		= 32,	     /* max s/g entries per request */
-	CARM_SG_BOUNDARY	= 0xffffUL,	    /* s/g segment boundary */
 	CARM_MAX_HOST_SG	= 600,		/* max s/g entries per host */
 	CARM_SG_LOW_WATER	= (CARM_MAX_HOST_SG / 4),   /* re-fill mark */
 
@@ -181,6 +201,10 @@ enum {
 	FL_DYN_MAJOR		= (1 << 17),
 };
 
+enum {
+	CARM_SG_BOUNDARY	= 0xffffUL,	    /* s/g segment boundary */
+};
+
 enum scatter_gather_types {
 	SGT_32BIT		= 0,
 	SGT_64BIT		= 1,
@@ -218,7 +242,6 @@ static const char *state_name[] = {
 
 struct carm_port {
 	unsigned int			port_no;
-	unsigned int			n_queued;
 	struct gendisk			*disk;
 	struct carm_host		*host;
 
@@ -448,7 +471,7 @@ static inline int carm_lookup_bucket(u32
 	for (i = 0; i < ARRAY_SIZE(msg_sizes); i++)
 		if (msg_size <= msg_sizes[i])
 			return i;
-	
+
 	return -ENOENT;
 }
 
@@ -509,7 +532,7 @@ static struct carm_request *carm_get_req
 	if (host->hw_sg_used >= (CARM_MAX_HOST_SG - CARM_MAX_REQ_SG))
 		return NULL;
 
-	for (i = 0; i < CARM_MAX_Q; i++)
+	for (i = 0; i < max_queue; i++)
 		if ((host->msg_alloc & (1ULL << i)) == 0) {
 			struct carm_request *crq = &host->req[i];
 			crq->port = NULL;
@@ -521,14 +544,14 @@ static struct carm_request *carm_get_req
 			assert(host->n_msgs <= CARM_MAX_REQ);
 			return crq;
 		}
-	
+
 	DPRINTK("no request available, returning NULL\n");
 	return NULL;
 }
 
 static int carm_put_request(struct carm_host *host, struct carm_request *crq)
 {
-	assert(crq->tag < CARM_MAX_Q);
+	assert(crq->tag < max_queue);
 
 	if (unlikely((host->msg_alloc & (1ULL << crq->tag)) == 0))
 		return -EINVAL; /* tried to clear a tag that was not active */
@@ -791,7 +814,7 @@ static inline void carm_end_rq(struct ca
 			int is_ok)
 {
 	carm_end_request_queued(host, crq, is_ok);
-	if (CARM_MAX_Q == 1)
+	if (max_queue == 1)
 		carm_round_robin(host);
 	else if ((host->n_msgs <= CARM_MSG_LOW_WATER) &&
 		 (host->hw_sg_used <= CARM_SG_LOW_WATER)) {
