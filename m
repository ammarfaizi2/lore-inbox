Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937646AbWLFVPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937646AbWLFVPZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 16:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937652AbWLFVPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 16:15:25 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50195 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937646AbWLFVPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 16:15:24 -0500
Date: Wed, 6 Dec 2006 21:15:22 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: ... and then some...
Message-ID: <20061206211522.GJ4587@ftp.linux.org.uk>
References: <20061206184145.GC4587@ftp.linux.org.uk> <20061206185140.GD4587@ftp.linux.org.uk> <20061206191820.GF4587@ftp.linux.org.uk> <20061206194641.GG4587@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206194641.GG4587@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

diff --git a/drivers/scsi/ibmvscsi/ibmvstgt.c b/drivers/scsi/ibmvscsi/ibmvstgt.c
index 0e74174..e28260f 100644
--- a/drivers/scsi/ibmvscsi/ibmvstgt.c
+++ b/drivers/scsi/ibmvscsi/ibmvstgt.c
@@ -67,6 +67,7 @@ struct vio_port {
 
 	unsigned long liobn;
 	unsigned long riobn;
+	struct srp_target *target;
 };
 
 static struct workqueue_struct *vtgtd;
@@ -685,10 +686,10 @@ static inline struct viosrp_crq *next_cr
 	return crq;
 }
 
-static void handle_crq(void *data)
+static void handle_crq(struct work_struct *work)
 {
-	struct srp_target *target = (struct srp_target *) data;
-	struct vio_port *vport = target_to_port(target);
+	struct vio_port *vport = container_of(work, struct vio_port, crq_work);
+	struct srp_target *target = vport->target;
 	struct viosrp_crq *crq;
 	int done = 0;
 
@@ -822,6 +823,7 @@ static int ibmvstgt_probe(struct vio_dev
 	target->shost = shost;
 	vport->dma_dev = dev;
 	target->ldata = vport;
+	vport->target = target;
 	err = srp_target_alloc(target, &dev->dev, INITIAL_SRP_LIMIT,
 			       SRP_MAX_IU_LEN);
 	if (err)
@@ -837,7 +839,7 @@ static int ibmvstgt_probe(struct vio_dev
 	vport->liobn = dma[0];
 	vport->riobn = dma[5];
 
-	INIT_WORK(&vport->crq_work, handle_crq, target);
+	INIT_WORK(&vport->crq_work, handle_crq);
 
 	err = crq_queue_create(&vport->crq_queue, target);
 	if (err)
