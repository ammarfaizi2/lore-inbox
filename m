Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264191AbTICW1d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 18:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264214AbTICW1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 18:27:33 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:2569 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264191AbTICW1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 18:27:22 -0400
Date: Wed, 3 Sep 2003 17:33:47 -0500
From: mike.miller@hp.com
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss error handling patch for 2.6.0-test4
Message-ID: <20030903223347.GA11071@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was built & tested using 2.6.0-test4. It _hopefully_ cleans up the error handling in cciss_init_one().
Please consider this for inclusion in the 2.6.0 kernel.

Thanks,
mikem
------------------------------------------------------------------------------
diff -burN lx260test4-p1/drivers/block/cciss.c lx260test4/drivers/block/cciss.c
--- lx260test4-p1/drivers/block/cciss.c	2003-08-26 13:09:45.000000000 -0500
+++ lx260test4/drivers/block/cciss.c	2003-08-26 14:01:12.000000000 -0500
@@ -2447,11 +2447,8 @@
 	if( i < 0 ) 
 		return (-1);
 	if (cciss_pci_init(hba[i], pdev) != 0)
-	{
-		release_io_mem(hba[i]);
-		free_hba(i);
-		return (-1);
-	}
+		goto clean1;
+	
 	sprintf(hba[i]->devname, "cciss%d", i);
 	hba[i]->ctlr = i;
 	hba[i]->pdev = pdev;
@@ -2463,28 +2460,23 @@
 		printk("cciss: not using DAC cycles\n");
 	else {
 		printk("cciss: no suitable DMA available\n");
-		free_hba(i);
-		return -ENODEV;
+		goto clean0;
 	}
 
 	if (register_blkdev(COMPAQ_CISS_MAJOR+i, hba[i]->devname)) {
-		release_io_mem(hba[i]);
-		free_hba(i);
-		return -1;
+		printk(KERN_ERR "cciss: Unable to register device %s\n",
+				hba[i]->devname);
+		goto clean1;
 	}
 
 	/* make sure the board interrupts are off */
 	hba[i]->access.set_intr_mask(hba[i], CCISS_INTR_OFF);
 	if( request_irq(hba[i]->intr, do_cciss_intr, 
 		SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM, 
-			hba[i]->devname, hba[i]))
-	{
-		printk(KERN_ERR "ciss: Unable to get irq %d for %s\n",
+			hba[i]->devname, hba[i])) {
+		printk(KERN_ERR "cciss: Unable to get irq %d for %s\n",
 			hba[i]->intr, hba[i]->devname);
-		unregister_blkdev( COMPAQ_CISS_MAJOR+i, hba[i]->devname);
-		release_io_mem(hba[i]);
-		free_hba(i);
-		return(-1);
+		goto clean2;
 	}
 	hba[i]->cmd_pool_bits = kmalloc(((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long), GFP_KERNEL);
 	hba[i]->cmd_pool = (CommandList_struct *)pci_alloc_consistent(
@@ -2495,35 +2487,15 @@
 		&(hba[i]->errinfo_pool_dhandle));
 	if((hba[i]->cmd_pool_bits == NULL) 
 		|| (hba[i]->cmd_pool == NULL)
-		|| (hba[i]->errinfo_pool == NULL))
-        {
-err_all:
-		if(hba[i]->cmd_pool_bits)
-                	kfree(hba[i]->cmd_pool_bits);
-                if(hba[i]->cmd_pool)
-                	pci_free_consistent(hba[i]->pdev,  
-				NR_CMDS * sizeof(CommandList_struct), 
-				hba[i]->cmd_pool, hba[i]->cmd_pool_dhandle);	
-		if(hba[i]->errinfo_pool)
-			pci_free_consistent(hba[i]->pdev,
-				NR_CMDS * sizeof( ErrorInfo_struct),
-				hba[i]->errinfo_pool, 
-				hba[i]->errinfo_pool_dhandle);
-                free_irq(hba[i]->intr, hba[i]);
-                unregister_blkdev(COMPAQ_CISS_MAJOR+i, hba[i]->devname);
-		release_io_mem(hba[i]);
-		free_hba(i);
+		|| (hba[i]->errinfo_pool == NULL)) {
                 printk( KERN_ERR "cciss: out of memory");
-		return(-1);
+		goto clean4;
 	}
 
-	/*
-	 * someone needs to clean up this failure handling mess
-	 */
 	spin_lock_init(&hba[i]->lock);
 	q = blk_init_queue(do_cciss_request, &hba[i]->lock);
 	if (!q)
-		goto err_all;
+		goto clean4;
 
 	hba[i]->queue = q;
 
@@ -2576,6 +2548,28 @@
 		add_disk(disk);
 	}
 	return(1);
+
+clean4:
+	if(hba[i]->cmd_pool_bits)
+               	kfree(hba[i]->cmd_pool_bits);
+	if(hba[i]->cmd_pool)
+		pci_free_consistent(hba[i]->pdev,
+			NR_CMDS * sizeof(CommandList_struct),
+			hba[i]->cmd_pool, hba[i]->cmd_pool_dhandle);
+	if(hba[i]->errinfo_pool)
+		pci_free_consistent(hba[i]->pdev,
+			NR_CMDS * sizeof( ErrorInfo_struct),
+			hba[i]->errinfo_pool, 
+			hba[i]->errinfo_pool_dhandle);
+clean3:
+	free_irq(hba[i]->intr, hba[i]);
+clean2:
+	unregister_blkdev(COMPAQ_CISS_MAJOR+i, hba[i]->devname);
+clean1:
+	release_io_mem(hba[i]);
+clean0:
+	free_hba(i);
+	return(-1);
 }
 
 static void __devexit cciss_remove_one (struct pci_dev *pdev)
