Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292377AbSBPOkg>; Sat, 16 Feb 2002 09:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292375AbSBPOk0>; Sat, 16 Feb 2002 09:40:26 -0500
Received: from pak218.pakuni.net ([207.91.34.218]:40456 "EHLO linuxtr.net")
	by vger.kernel.org with ESMTP id <S292374AbSBPOkT>;
	Sat, 16 Feb 2002 09:40:19 -0500
Date: Sat, 16 Feb 2002 09:26:56 -0600 (CST)
From: Mike Phillips <mikep@linuxtr.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Olympic - Janitor Remove save_flags/cli/restore_flags
Message-ID: <Pine.LNX.4.10.10202160922140.3114-100000@www.linuxtr.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another janitor patch for olympic to replace the save_flags/cli/restore
flags sequence with spin_locks.

Thanks
Mike Phillips
Linux Token Ring Project
http://www.linuxtr.net

diff -urN -X~/dontdiff linux-2.4.17-vanilla/drivers/net/tokenring/olympic.c linux-2.4.17-production/net/tokenring/olympic.c
--- linux-2.4.17-vanilla/drivers/net/tokengring/olympic.c	Sat Feb  9 11:45:22 2002
+++ linux-2.4.17-production/drivers/net/tokenring/olympic.c	Sat Feb 16 08:26:26 2002
@@ -433,8 +433,6 @@
 	do {
 		int i;
 
-		save_flags(flags);
-		cli();
 		for(i=0;i<SRB_COMMAND_SIZE;i+=4)
 			writel(0,init_srb+i);
 		if(SRB_COMMAND_SIZE & 2)
@@ -465,10 +463,12 @@
 			memcpy(dev->dev_addr,olympic_priv->olympic_laa,dev->addr_len) ;  
 		} 	
 		writeb(1,init_srb+30);
-	
+
+		spin_lock_irqsave(&olympic_priv->olympic_lock,flags);	
 		olympic_priv->srb_queued=1;
 
 		writel(LISR_SRB_CMD,olympic_mmio+LISR_SUM);
+		spin_unlock_irqrestore(&olympic_priv->olympic_lock,flags);
 
 		t = jiffies ; 
 	
@@ -496,7 +496,6 @@
 		remove_wait_queue(&olympic_priv->srb_wait,&wait) ; 
 		set_current_state(TASK_RUNNING) ; 
 
-		restore_flags(flags);
 #if OLYMPIC_DEBUG
 		printk("init_srb(%p): ",init_srb);
 		for(i=0;i<20;i++)
@@ -1058,12 +1057,11 @@
 	writeb(0,srb+1);
 	writeb(OLYMPIC_CLEAR_RET_CODE,srb+2);
 
-	save_flags(flags);
-	cli();	
-
+	spin_lock_irqsave(&olympic_priv->olympic_lock,flags);
 	olympic_priv->srb_queued=1;
 
 	writel(LISR_SRB_CMD,olympic_mmio+LISR_SUM);
+	spin_unlock_irqrestore(&olympic_priv->olympic_lock,flags);
 	
 	t = jiffies ; 
 
@@ -1088,7 +1086,6 @@
 	remove_wait_queue(&olympic_priv->srb_wait,&wait) ; 
 	set_current_state(TASK_RUNNING) ; 
 
-	restore_flags(flags) ; 
 	olympic_priv->rx_status_last_received++;
 	olympic_priv->rx_status_last_received&=OLYMPIC_RX_RING_SIZE-1;
 

