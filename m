Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWIUGL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWIUGL2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 02:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWIUGL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 02:11:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:47593 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751250AbWIUGL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 02:11:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rPNPzLqB5sFu5IeiK8Ks/0A6AItDs8qialslbW+7IbG2BPNWC1SOGxzEQHDuvyzVTH2u32uWvs6MJ2GCnt9bdzSeTir3WkbtPfksk0JVJswQav1P/Xf/DoWjRQjKZ8+otcax6/JriDv0BtFfJ3+YNxUMmWjWPfljdHGPoJH62RU=
Message-ID: <6b4e42d10609202311t47038692x5627f51d69f28209@mail.gmail.com>
Date: Wed, 20 Sep 2006 23:11:25 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: kmalloc to kzalloc patches for drivers/block [sane version]
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the kmalloc() calls followed by memset(,0,) to kzalloc.

    cciss.c : Changed the kmalloc/memset pair to kzalloc
    cpqarray.c : km2zalloc conversion and code size reduction by
changing multiple cleanup calls and returns of the function
getgeometry() by adding a label.
    loop.c : km2zalloc converion


Signed off by Om Narasimhan <om.turyx@gmail.com>
 drivers/block/cciss.c    |    4 +--
 drivers/block/cpqarray.c |   72 +++++++++++++++-------------------------------
 drivers/block/loop.c     |    4 +--
 3 files changed, 25 insertions(+), 55 deletions(-)

diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index 2cd3391..a800a69 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -900,7 +900,7 @@ #if 0				/* 'buf_size' member is 16-bits
 				return -EINVAL;
 #endif
 			if (iocommand.buf_size > 0) {
-				buff = kmalloc(iocommand.buf_size, GFP_KERNEL);
+				buff = kzalloc(iocommand.buf_size, GFP_KERNEL);
 				if (buff == NULL)
 					return -EFAULT;
 			}
@@ -911,8 +911,6 @@ #endif
 					kfree(buff);
 					return -EFAULT;
 				}
-			} else {
-				memset(buff, 0, iocommand.buf_size);
 			}
 			if ((c = cmd_alloc(host, 0)) == NULL) {
 				kfree(buff);
diff --git a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
index 78082ed..8a697c7 100644
--- a/drivers/block/cpqarray.c
+++ b/drivers/block/cpqarray.c
@@ -424,7 +424,7 @@ static int __init cpqarray_register_ctlr
 	hba[i]->cmd_pool = (cmdlist_t *)pci_alloc_consistent(
 		hba[i]->pci_dev, NR_CMDS * sizeof(cmdlist_t),
 		&(hba[i]->cmd_pool_dhandle));
-	hba[i]->cmd_pool_bits = kmalloc(
+	hba[i]->cmd_pool_bits = kzalloc(
 		((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long),
 		GFP_KERNEL);

@@ -432,7 +432,6 @@ static int __init cpqarray_register_ctlr
 			goto Enomem1;

 	memset(hba[i]->cmd_pool, 0, NR_CMDS * sizeof(cmdlist_t));
-	memset(hba[i]->cmd_pool_bits, 0,
((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long));
 	printk(KERN_INFO "cpqarray: Finding drives on %s",
 		hba[i]->devname);

@@ -523,7 +522,6 @@ static int __init cpqarray_init_one( str
 	i = alloc_cpqarray_hba();
 	if( i < 0 )
 		return (-1);
-	memset(hba[i], 0, sizeof(ctlr_info_t));
 	sprintf(hba[i]->devname, "ida%d", i);
 	hba[i]->ctlr = i;
 	/* Initialize the pdev driver private data */
@@ -580,7 +578,7 @@ static int alloc_cpqarray_hba(void)

 	for(i=0; i< MAX_CTLR; i++) {
 		if (hba[i] == NULL) {
-			hba[i] = kmalloc(sizeof(ctlr_info_t), GFP_KERNEL);
+			hba[i] = kzalloc(sizeof(ctlr_info_t), GFP_KERNEL);
 			if(hba[i]==NULL) {
 				printk(KERN_ERR "cpqarray: out of memory.\n");
 				return (-1);
@@ -765,7 +763,6 @@ static int __init cpqarray_eisa_detect(v
 			continue;
 		}

-		memset(hba[ctlr], 0, sizeof(ctlr_info_t));
 		hba[ctlr]->io_mem_addr = eisa[i];
 		hba[ctlr]->io_mem_length = 0x7FF;
 		if(!request_region(hba[ctlr]->io_mem_addr,
@@ -1642,58 +1639,46 @@ static void start_fwbk(int ctlr)
     It is used only at init time.
 *****************************************************************/
 static void getgeometry(int ctlr)
-{				
-	id_log_drv_t *id_ldrive;
-	id_ctlr_t *id_ctlr_buf;
-	sense_log_drv_stat_t *id_lstatus_buf;
-	config_t *sense_config_buf;
+{
+	id_log_drv_t *id_ldrive = NULL;
+	id_ctlr_t *id_ctlr_buf = NULL;
+	sense_log_drv_stat_t *id_lstatus_buf = NULL;
+	config_t *sense_config_buf = NULL;
 	unsigned int log_unit, log_index;
 	int ret_code, size;
-	drv_info_t *drv;
+	drv_info_t *drv = NULL;
 	ctlr_info_t *info_p = hba[ctlr];
 	int i;

-	info_p->log_drv_map = 0;	
-	
-	id_ldrive = (id_log_drv_t *)kmalloc(sizeof(id_log_drv_t), GFP_KERNEL);
+	info_p->log_drv_map = 0;
+	id_ldrive = (id_log_drv_t *)kzalloc(sizeof(id_log_drv_t), GFP_KERNEL);
 	if(id_ldrive == NULL)
 	{
 		printk( KERN_ERR "cpqarray:  out of memory.\n");
-		return;
+		goto end;
 	}

-	id_ctlr_buf = (id_ctlr_t *)kmalloc(sizeof(id_ctlr_t), GFP_KERNEL);
+	id_ctlr_buf = (id_ctlr_t *)kzalloc(sizeof(id_ctlr_t), GFP_KERNEL);
 	if(id_ctlr_buf == NULL)
 	{
-		kfree(id_ldrive);
 		printk( KERN_ERR "cpqarray:  out of memory.\n");
-		return;
+		goto end;
 	}

-	id_lstatus_buf = (sense_log_drv_stat_t
*)kmalloc(sizeof(sense_log_drv_stat_t), GFP_KERNEL);
+	id_lstatus_buf = (sense_log_drv_stat_t
*)kzalloc(sizeof(sense_log_drv_stat_t), GFP_KERNEL);
 	if(id_lstatus_buf == NULL)
 	{
-		kfree(id_ctlr_buf);
-		kfree(id_ldrive);
 		printk( KERN_ERR "cpqarray:  out of memory.\n");
-		return;
+		goto end;
 	}

-	sense_config_buf = (config_t *)kmalloc(sizeof(config_t), GFP_KERNEL);
+	sense_config_buf = (config_t *)kzalloc(sizeof(config_t), GFP_KERNEL);
 	if(sense_config_buf == NULL)
 	{
-		kfree(id_lstatus_buf);
-		kfree(id_ctlr_buf);
-		kfree(id_ldrive);
 		printk( KERN_ERR "cpqarray:  out of memory.\n");
-		return;
+		goto end;
 	}

-	memset(id_ldrive, 0, sizeof(id_log_drv_t));
-	memset(id_ctlr_buf, 0, sizeof(id_ctlr_t));
-	memset(id_lstatus_buf, 0, sizeof(sense_log_drv_stat_t));
-	memset(sense_config_buf, 0, sizeof(config_t));
-
 	info_p->phys_drives = 0;
 	info_p->log_drv_map = 0;
 	info_p->drv_assign_map = 0;
@@ -1709,11 +1694,7 @@ static void getgeometry(int ctlr)
 		 */
 		 /* Free all the buffers and return */
 		printk(KERN_ERR "cpqarray: error sending ID controller\n");
-		kfree(sense_config_buf);
-                kfree(id_lstatus_buf);
-                kfree(id_ctlr_buf);
-                kfree(id_ldrive);
-                return;
+		goto end;
         }

 	info_p->log_drives = id_ctlr_buf->nr_drvs;
@@ -1760,11 +1741,7 @@ static void getgeometry(int ctlr)
 			 "Access to this controller has been disabled\n",
 				ctlr, log_unit);
 			/* Free all the buffers and return */
-                	kfree(sense_config_buf);
-                	kfree(id_lstatus_buf);
-                	kfree(id_ctlr_buf);
-                	kfree(id_ldrive);
-                	return;
+			goto end;
 		}
 		/*
 		   Make sure the logical drive is configured
@@ -1795,11 +1772,7 @@ static void getgeometry(int ctlr)
 					info_p->log_drv_map = 0;
 					/* Free all the buffers and return */
                 			printk(KERN_ERR "cpqarray: error sending sense config\n");
-                			kfree(sense_config_buf);
-                			kfree(id_lstatus_buf);
-                			kfree(id_ctlr_buf);
-                			kfree(id_ldrive);
-                			return;
+					goto end;

 				}

@@ -1815,9 +1788,10 @@ static void getgeometry(int ctlr)
 			log_index = log_index + 1;
 		}		/* end of if logical drive configured */
 	}			/* end of for log_unit */
+end:
 	kfree(sense_config_buf);
-  	kfree(id_ldrive);
-  	kfree(id_lstatus_buf);
+	kfree(id_ldrive);
+	kfree(id_lstatus_buf);
 	kfree(id_ctlr_buf);
 	return;

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7b3b94d..cc4785f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1260,11 +1260,9 @@ static int __init loop_init(void)
 	if (register_blkdev(LOOP_MAJOR, "loop"))
 		return -EIO;

-	loop_dev = kmalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
+	loop_dev = kzalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
 	if (!loop_dev)
 		goto out_mem1;
-	memset(loop_dev, 0, max_loop * sizeof(struct loop_device));
-
 	disks = kmalloc(max_loop * sizeof(struct gendisk *), GFP_KERNEL);
 	if (!disks)
 		goto out_mem2;
