Return-Path: <linux-kernel-owner+w=401wt.eu-S1751385AbXAFNSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbXAFNSa (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 08:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbXAFNSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 08:18:30 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:21582 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbXAFNS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 08:18:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:from;
        b=Jor41FjIFfeiqaghpvXOqYqZPWdunD3p9mVogfIrrynSIUw5NUQgRUvxmnCQs6fy0sHxflOWEYvKmzN/TZHcALniJpAOdp35lcHFE3oKsqDeZJXOLQRpVWZ8Uv7APtmFd7pwzWXYkk26QMHPWUlNrlxtjhxrfXJwIxdAon8VBFM=
Date: Sat, 6 Jan 2007 15:18:06 +0200
To: fpavlic@de.ibm.com, linux390@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.20-rc3] S390: kmalloc->kzalloc/casting cleanups
Message-ID: <20070106131806.GD19020@Ahmed>
Mail-Followup-To: fpavlic@de.ibm.com, linux390@de.ibm.com,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please inform me if you are not the maintaner]

A patch for the CTC / ESCON network driver. Switch from kmalloc to kzalloc
when appropriate, remove some unnecessary kmalloc casts too.
Since I have no s390 machine, I didn't compile it but I examined it carefully.

Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>

diff --git a/drivers/s390/net/ctcmain.c b/drivers/s390/net/ctcmain.c
index 03cc263..ee914ab 100644
--- a/drivers/s390/net/ctcmain.c
+++ b/drivers/s390/net/ctcmain.c
@@ -1639,21 +1639,19 @@ add_channel(struct ccw_device *cdev, enum channel_types type)
 	struct channel *ch;
 
 	DBF_TEXT(trace, 2, __FUNCTION__);
-	if ((ch =
-	     (struct channel *) kmalloc(sizeof (struct channel),
-					GFP_KERNEL)) == NULL) {
+	ch = kzalloc(sizeof (struct channel), GFP_KERNEL);
+	if (!ch) {
 		ctc_pr_warn("ctc: Out of memory in add_channel\n");
 		return -1;
 	}
-	memset(ch, 0, sizeof (struct channel));
-	if ((ch->ccw = kmalloc(8*sizeof(struct ccw1),
-					       GFP_KERNEL | GFP_DMA)) == NULL) {
+	/* assure all flags and counters are reset */
+	ch->ccw = kzalloc(8 * sizeof(struct ccw1), GFP_KERNEL | GFP_DMA);
+	if (!ch->ccw) {
 		kfree(ch);
 		ctc_pr_warn("ctc: Out of memory in add_channel\n");
 		return -1;
 	}
 
-	memset(ch->ccw, 0, 8*sizeof(struct ccw1));	// assure all flags and counters are reset
 
 	/**
 	 * "static" ccws are used in the following way:
@@ -1693,15 +1691,14 @@ add_channel(struct ccw_device *cdev, enum channel_types type)
 		return -1;
 	}
 	fsm_newstate(ch->fsm, CH_STATE_IDLE);
-	if ((ch->irb = kmalloc(sizeof (struct irb),
-					      GFP_KERNEL)) == NULL) {
+	ch->irb = kzalloc(sizeof (struct irb), GFP_KERNEL);
+	if (!ch->irb) {
 		ctc_pr_warn("ctc: Out of memory in add_channel\n");
 		kfree_fsm(ch->fsm);
 		kfree(ch->ccw);
 		kfree(ch);
 		return -1;
 	}
-	memset(ch->irb, 0, sizeof (struct irb));
 	while (*c && less_than((*c)->id, ch->id))
 		c = &(*c)->next;
 	if (*c && (!strncmp((*c)->id, ch->id, CTC_ID_SIZE))) {
@@ -2746,14 +2743,13 @@ ctc_probe_device(struct ccwgroup_device *cgdev)
 	if (!get_device(&cgdev->dev))
 		return -ENODEV;
 
-	priv = kmalloc(sizeof (struct ctc_priv), GFP_KERNEL);
+	priv = kzalloc(sizeof (struct ctc_priv), GFP_KERNEL);
 	if (!priv) {
 		ctc_pr_err("%s: Out of memory\n", __func__);
 		put_device(&cgdev->dev);
 		return -ENOMEM;
 	}
 
-	memset(priv, 0, sizeof (struct ctc_priv));
 	rc = ctc_add_files(&cgdev->dev);
 	if (rc) {
 		kfree(priv);
@@ -2794,10 +2790,9 @@ ctc_init_netdevice(struct net_device * dev, int alloc_device,
 	DBF_TEXT(setup, 3, __FUNCTION__);
 
 	if (alloc_device) {
-		dev = kmalloc(sizeof (struct net_device), GFP_KERNEL);
+		dev = kzalloc(sizeof (struct net_device), GFP_KERNEL);
 		if (!dev)
 			return NULL;
-		memset(dev, 0, sizeof (struct net_device));
 	}
 
 	dev->priv = privptr;

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
