Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262407AbREZVl3>; Sat, 26 May 2001 17:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262358AbREZVlT>; Sat, 26 May 2001 17:41:19 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:4149
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S262407AbREZVlD>; Sat, 26 May 2001 17:41:03 -0400
Date: Sat, 26 May 2001 23:40:52 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] comx-hw-mixcom.c interrupt flag cleanup (244-ac18)
Message-ID: <20010526234052.B6906@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Forgot l-k when sending this off to gorgo@itc.hu :/)

Hi.

The following patch tries to eliminate the interrupt flag bugs
identified by the stanford team a while back in drivers/net/wan/
comx-hw-mixcom.c. It moves request_region and request_irq outside
the cli()/restore_flags() pair as they can sleep and cleans up
some error paths wrt. resource deallocation. It applies against
244-ac18.

Comments would be nice as this is not my day job :)



--- linux-244-ac18-clean/drivers/net/wan/comx-hw-mixcom.c	Mon Dec 11 22:38:29 2000
+++ linux-244-ac18/drivers/net/wan/comx-hw-mixcom.c	Sat May 26 22:45:44 2001
@@ -487,15 +487,18 @@
 	struct mixcom_privdata *hw = ch->HW_privdata;
 	struct proc_dir_entry *procfile = ch->procdir->subdir;
 	unsigned long flags; 
+	int ret = -ENODEV;
 
-	if (!dev->base_addr || !dev->irq) return -ENODEV;
+	if (!dev->base_addr || !dev->irq)
+		goto err_ret;
 
 
 	if(hw->channel==1) {
 		if(!TWIN(dev) || !(COMX_CHANNEL(TWIN(dev))->init_status & 
 		    IRQ_ALLOCATED)) {
 			printk(KERN_ERR "%s: channel 0 not yet initialized\n",dev->name);
-			return -EAGAIN;
+			ret = -EAGAIN;
+			goto err_ret;
 		}
 	}
 
@@ -503,28 +506,29 @@
 	/* Is our hw present at all ? Not checking for channel 0 if it is already 
 	   open */
 	if(hw->channel!=0 || !(ch->init_status & IRQ_ALLOCATED)) {
-		if (check_region(dev->base_addr, MIXCOM_IO_EXTENT)) {
-			return -EAGAIN;
+		if (!request_region(dev->base_addr, MIXCOM_IO_EXTENT, dev->name)) {
+			ret = -EAGAIN;
+			goto err_ret;
 		}
 		if (mixcom_probe(dev)) {
-			return -ENODEV;
+			ret = -ENODEV;
+			goto err_release_region;
 		}
 	}
 
-	save_flags(flags); cli();
-
-	if(hw->channel==1) {
-		request_region(dev->base_addr, MIXCOM_IO_EXTENT, dev->name);
-	} 
-
 	if(hw->channel==0 && !(ch->init_status & IRQ_ALLOCATED)) {
 		if (request_irq(dev->irq, MIXCOM_interrupt, 0, 
 		    dev->name, (void *)dev)) {
 			printk(KERN_ERR "MIXCOM: unable to obtain irq %d\n", dev->irq);
-			return -EAGAIN;
+			ret = -EAGAIN;
+			goto err_restore_flags;
 		}
+	}
+
+	save_flags(flags); cli();
+
+	if(hw->channel==0 && !(ch->init_status & IRQ_ALLOCATED)) {
 		ch->init_status|=IRQ_ALLOCATED;
-		request_region(dev->base_addr, MIXCOM_IO_EXTENT, dev->name);
 		mixcom_board_on(dev);
 	}
 
@@ -560,6 +564,13 @@
 	}
 
 	return 0;
+	
+err_restore_flags:
+	restore_flags(flags);
+err_release_region:
+	release_region(dev->base_addr, MIXCOM_IO_EXTENT);
+err_ret:
+	return ret;
 }
 
 static int MIXCOM_close(struct net_device *dev)

-- 
        Rasmus(rasmus@jaquet.dk)

"I'm not going to have some reporters pawing through our papers. We are
the president."  -Hillary Clinton commenting on the release of subpoenaed
documents.
