Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWIVF34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWIVF34 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 01:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWIVF34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 01:29:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:57640 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932281AbWIVF3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 01:29:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fMqGaFWnhDqcSEJO1h+xUZCQgIAhqzi473OvF39Zn8zl+06T0Bik2kWVSrJh4i5yDtAcLeS+ro7qvvzzwhuJ3zU4+HE/T1awD8NWn2v6TeGwCJxD3DJsrJK8AEkaltClx3/dMZLFUcgfB44IvhjSTaxAIfOzjXFN3i3OkoES34A=
Message-ID: <6b4e42d10609212229v265630cfxcf970a7375c8c37b@mail.gmail.com>
Date: Thu, 21 Sep 2006 22:29:53 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: kmalloc to kzalloc patches for drivers/atm [sane version]
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       linux-atm-general@lists.sourceforge.net
In-Reply-To: <d120d5000609210636n49a35953w44aefe7068f286fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6b4e42d10609210012j6c82379cs53fc374b675a5883@mail.gmail.com>
	 <d120d5000609210636n49a35953w44aefe7068f286fd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleaned up patch, compile tested, comments incorporated.

Replaces kmalloc()s succeeded by memset (,0,) with kzalloc()/kcalloc()
in the drivers/atm directory.

Signed off by : Om Narasimhan <om.turyx@gmail.com>
diff --git a/drivers/atm/adummy.c b/drivers/atm/adummy.c
index 6cc93de..ac2c108 100644
--- a/drivers/atm/adummy.c
+++ b/drivers/atm/adummy.c
@@ -113,15 +113,13 @@ static int __init adummy_init(void)

 	printk(KERN_ERR "adummy: version %s\n", DRV_VERSION);

-	adummy_dev = (struct adummy_dev *) kmalloc(sizeof(struct adummy_dev),
+	adummy_dev = kzalloc(sizeof(struct adummy_dev),
 						   GFP_KERNEL);
 	if (!adummy_dev) {
-		printk(KERN_ERR DEV_LABEL ": kmalloc() failed\n");
+		printk(KERN_ERR DEV_LABEL ": kzalloc() failed\n");
 		err = -ENOMEM;
 		goto out;
 	}
-	memset(adummy_dev, 0, sizeof(struct adummy_dev));
-
 	atm_dev = atm_dev_register(DEV_LABEL, &adummy_ops, -1, NULL);
 	if (!atm_dev) {
 		printk(KERN_ERR DEV_LABEL ": atm_dev_register() failed\n");
diff --git a/drivers/atm/atmtcp.c b/drivers/atm/atmtcp.c
diff --git a/drivers/atm/firestream.c b/drivers/atm/firestream.c
index 38fc054..30e2eb2 100644
--- a/drivers/atm/firestream.c
+++ b/drivers/atm/firestream.c
@@ -1784,7 +1784,7 @@ static int __devinit fs_init (struct fs_
 		write_fs (dev, RAM, (1 << (28 - FS155_VPI_BITS - FS155_VCI_BITS)) - 1);
 		dev->nchannels = FS155_NR_CHANNELS;
 	}
-	dev->atm_vccs = kmalloc (dev->nchannels * sizeof (struct atm_vcc *),
+	dev->atm_vccs = kcalloc (dev->nchannels, sizeof (struct atm_vcc *),
 				 GFP_KERNEL);
 	fs_dprintk (FS_DEBUG_ALLOC, "Alloc atmvccs: %p(%Zd)\n",
 		    dev->atm_vccs, dev->nchannels * sizeof (struct atm_vcc *));
@@ -1794,9 +1794,7 @@ static int __devinit fs_init (struct fs_
 		/* XXX Clean up..... */
 		return 1;
 	}
-	memset (dev->atm_vccs, 0, dev->nchannels * sizeof (struct atm_vcc *));
-
-	dev->tx_inuse = kmalloc (dev->nchannels / 8 /* bits/byte */ , GFP_KERNEL);
+	dev->tx_inuse = kzalloc (dev->nchannels / 8 /* bits/byte */ , GFP_KERNEL);
 	fs_dprintk (FS_DEBUG_ALLOC, "Alloc tx_inuse: %p(%d)\n",
 		    dev->atm_vccs, dev->nchannels / 8);

@@ -1805,8 +1803,6 @@ static int __devinit fs_init (struct fs_
 		/* XXX Clean up..... */
 		return 1;
 	}
-	memset (dev->tx_inuse, 0, dev->nchannels / 8);
-
 	/* -- RAS1 : FS155 and 50 differ. Default (0) should be OK for both */
 	/* -- RAS2 : FS50 only: Default is OK. */

@@ -1893,14 +1889,11 @@ static int __devinit firestream_init_one
 	if (pci_enable_device(pci_dev))
 		goto err_out;

-	fs_dev = kmalloc (sizeof (struct fs_dev), GFP_KERNEL);
+	fs_dev = kzalloc (sizeof (struct fs_dev), GFP_KERNEL);
 	fs_dprintk (FS_DEBUG_ALLOC, "Alloc fs-dev: %p(%Zd)\n",
 		    fs_dev, sizeof (struct fs_dev));
 	if (!fs_dev)
 		goto err_out;
-
-	memset (fs_dev, 0, sizeof (struct fs_dev));
-
 	atm_dev = atm_dev_register("fs", &ops, -1, NULL);
 	if (!atm_dev)
 		goto err_out_free_fs_dev;
diff --git a/drivers/atm/he.c b/drivers/atm/he.c
index d369130..611a532 100644
--- a/drivers/atm/he.c
+++ b/drivers/atm/he.c
@@ -383,14 +383,12 @@ he_init_one(struct pci_dev *pci_dev, con
 	}
 	pci_set_drvdata(pci_dev, atm_dev);

-	he_dev = (struct he_dev *) kmalloc(sizeof(struct he_dev),
+	he_dev = kzalloc(sizeof(struct he_dev),
 							GFP_KERNEL);
 	if (!he_dev) {
 		err = -ENOMEM;
 		goto init_one_failure;
 	}
-	memset(he_dev, 0, sizeof(struct he_dev));
-
 	he_dev->pci_dev = pci_dev;
 	he_dev->atm_dev = atm_dev;
 	he_dev->atm_dev->dev_data = he_dev;
diff --git a/drivers/atm/horizon.c b/drivers/atm/horizon.c
index d1113e8..209dba1 100644
--- a/drivers/atm/horizon.c
+++ b/drivers/atm/horizon.c
@@ -2719,7 +2719,7 @@ static int __devinit hrz_probe(struct pc
 		goto out_disable;
 	}

-	dev = kmalloc(sizeof(hrz_dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(hrz_dev), GFP_KERNEL);
 	if (!dev) {
 		// perhaps we should be nice: deregister all adapters and abort?
 		PRINTD(DBG_ERR, "out of memory");
@@ -2727,8 +2727,6 @@ static int __devinit hrz_probe(struct pc
 		goto out_release;
 	}

-	memset(dev, 0, sizeof(hrz_dev));
-
 	pci_set_drvdata(pci_dev, dev);

 	// grab IRQ and install handler - move this someplace more sensible
diff --git a/drivers/atm/idt77105.c b/drivers/atm/idt77105.c
diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index b0369bb..1bc3a31 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -642,11 +642,9 @@ alloc_scq(struct idt77252_dev *card, int
 {
 	struct scq_info *scq;

-	scq = (struct scq_info *) kmalloc(sizeof(struct scq_info), GFP_KERNEL);
+	scq = kzalloc(sizeof(struct scq_info), GFP_KERNEL);
 	if (!scq)
 		return NULL;
-	memset(scq, 0, sizeof(struct scq_info));
-
 	scq->base = pci_alloc_consistent(card->pcidev, SCQ_SIZE,
 					 &scq->paddr);
 	if (scq->base == NULL) {
@@ -2142,11 +2140,9 @@ idt77252_init_est(struct vc_map *vc, int
 {
 	struct rate_estimator *est;

-	est = kmalloc(sizeof(struct rate_estimator), GFP_KERNEL);
+	est = kzalloc(sizeof(struct rate_estimator), GFP_KERNEL);
 	if (!est)
 		return NULL;
-	memset(est, 0, sizeof(*est));
-
 	est->maxcps = pcr < 0 ? -pcr : pcr;
 	est->cps = est->maxcps;
 	est->avcps = est->cps << 5;
@@ -2451,14 +2447,12 @@ idt77252_open(struct atm_vcc *vcc)

 	index = VPCI2VC(card, vpi, vci);
 	if (!card->vcs[index]) {
-		card->vcs[index] = kmalloc(sizeof(struct vc_map), GFP_KERNEL);
+		card->vcs[index] = kzalloc(sizeof(struct vc_map), GFP_KERNEL);
 		if (!card->vcs[index]) {
 			printk("%s: can't alloc vc in open()\n", card->name);
 			up(&card->mutex);
 			return -ENOMEM;
 		}
-		memset(card->vcs[index], 0, sizeof(struct vc_map));
-
 		card->vcs[index]->card = card;
 		card->vcs[index]->index = index;

@@ -2926,13 +2920,11 @@ open_card_oam(struct idt77252_dev *card)
 		for (vci = 3; vci < 5; vci++) {
 			index = VPCI2VC(card, vpi, vci);

-			vc = kmalloc(sizeof(struct vc_map), GFP_KERNEL);
+			vc = kzalloc(sizeof(struct vc_map), GFP_KERNEL);
 			if (!vc) {
 				printk("%s: can't alloc vc\n", card->name);
 				return -ENOMEM;
 			}
-			memset(vc, 0, sizeof(struct vc_map));
-
 			vc->index = index;
 			card->vcs[index] = vc;

@@ -2995,12 +2987,11 @@ open_card_ubr0(struct idt77252_dev *card
 {
 	struct vc_map *vc;

-	vc = kmalloc(sizeof(struct vc_map), GFP_KERNEL);
+	vc = kzalloc(sizeof(struct vc_map), GFP_KERNEL);
 	if (!vc) {
 		printk("%s: can't alloc vc\n", card->name);
 		return -ENOMEM;
 	}
-	memset(vc, 0, sizeof(struct vc_map));
 	card->vcs[0] = vc;
 	vc->class = SCHED_UBR0;

@@ -3695,14 +3686,12 @@ idt77252_init_one(struct pci_dev *pcidev
 		goto err_out_disable_pdev;
 	}

-	card = kmalloc(sizeof(struct idt77252_dev), GFP_KERNEL);
+	card = kzalloc(sizeof(struct idt77252_dev), GFP_KERNEL);
 	if (!card) {
 		printk("idt77252-%d: can't allocate private data\n", index);
 		err = -ENOMEM;
 		goto err_out_disable_pdev;
 	}
-	memset(card, 0, sizeof(struct idt77252_dev));
-
 	card->revision = revision;
 	card->index = index;
 	card->pcidev = pcidev;
diff --git a/drivers/atm/lanai.c b/drivers/atm/lanai.c
index fe60a59..b9568e1 100644
--- a/drivers/atm/lanai.c
+++ b/drivers/atm/lanai.c
@@ -1482,16 +1482,10 @@ #endif
 static inline struct lanai_vcc *new_lanai_vcc(void)
 {
 	struct lanai_vcc *lvcc;
-	lvcc = (struct lanai_vcc *) kmalloc(sizeof(*lvcc), GFP_KERNEL);
+	lvcc =  kzalloc(sizeof(*lvcc), GFP_KERNEL);
 	if (likely(lvcc != NULL)) {
-		lvcc->vbase = NULL;
-		lvcc->rx.atmvcc = lvcc->tx.atmvcc = NULL;
-		lvcc->nref = 0;
-		memset(&lvcc->stats, 0, sizeof lvcc->stats);
-		lvcc->rx.buf.start = lvcc->tx.buf.start = NULL;
 		skb_queue_head_init(&lvcc->tx.backlog);
 #ifdef DEBUG
-		lvcc->tx.unqueue = NULL;
 		lvcc->vci = -1;
 #endif
 	}
diff --git a/drivers/atm/suni.c b/drivers/atm/suni.c
diff --git a/drivers/atm/uPD98402.c b/drivers/atm/uPD98402.c
diff --git a/drivers/atm/zatm.c b/drivers/atm/zatm.c
index 2c65e82..c491ec4 100644
--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -603,9 +603,8 @@ static int start_rx(struct atm_dev *dev)
 DPRINTK("start_rx\n");
 	zatm_dev = ZATM_DEV(dev);
 	size = sizeof(struct atm_vcc *)*zatm_dev->chans;
-	zatm_dev->rx_map = (struct atm_vcc **) kmalloc(size,GFP_KERNEL);
+	zatm_dev->rx_map =  kzalloc(size,GFP_KERNEL);
 	if (!zatm_dev->rx_map) return -ENOMEM;
-	memset(zatm_dev->rx_map,0,size);
 	/* set VPI/VCI split (use all VCIs and give what's left to VPIs) */
 	zpokel(zatm_dev,(1 << dev->ci_range.vci_bits)-1,uPD98401_VRR);
 	/* prepare free buffer pools */
@@ -951,9 +950,8 @@ static int open_tx_first(struct atm_vcc
 	skb_queue_head_init(&zatm_vcc->tx_queue);
 	init_waitqueue_head(&zatm_vcc->tx_wait);
 	/* initialize ring */
-	zatm_vcc->ring = kmalloc(RING_SIZE,GFP_KERNEL);
+	zatm_vcc->ring = kzalloc(RING_SIZE,GFP_KERNEL);
 	if (!zatm_vcc->ring) return -ENOMEM;
-	memset(zatm_vcc->ring,0,RING_SIZE);
 	loop = zatm_vcc->ring+RING_ENTRIES*RING_WORDS;
 	loop[0] = uPD98401_TXPD_V;
 	loop[1] = loop[2] = 0;
