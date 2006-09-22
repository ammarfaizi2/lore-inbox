Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWIVGQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWIVGQy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 02:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWIVGQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 02:16:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:63111 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750718AbWIVGQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 02:16:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QBoGPwM0pKmJsJMh0fz7KgdpJ85F6v1pZNS5+hkjzTV/FsZFE0u27G2kKpjZ46oQX7kW3G/mcDDAZjzl6C2zpQtnfYQmwkxW13cAKuvPHjiYVLM9Jt2OQmfK3o7hbfYpqV93HuWcTCJKgaPEygJ7z0jj2n2tk5gYf5vZikjmoKo=
Message-ID: <6b4e42d10609212316td429f66q51e35d80c823c571@mail.gmail.com>
Date: Thu, 21 Sep 2006 23:16:51 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: removing multiple kfree() and return's
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes repeated calls to kfree() and return; by introducing a label
and goto label.

Signed off by : Om Narasimhan <om.turyx@gmail.com>


 drivers/block/cpqarray.c |   62 +++++++++++++++-------------------------------
 1 files changed, 20 insertions(+), 42 deletions(-)

diff --git a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
index 78082ed..e167cec 100644
--- a/drivers/block/cpqarray.c
+++ b/drivers/block/cpqarray.c
@@ -1642,58 +1642,47 @@ static void start_fwbk(int ctlr)
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

 	info_p->log_drv_map = 0;	
 	
-	id_ldrive = (id_log_drv_t *)kmalloc(sizeof(id_log_drv_t), GFP_KERNEL);
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
@@ -1709,11 +1698,7 @@ static void getgeometry(int ctlr)
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
@@ -1760,11 +1745,7 @@ static void getgeometry(int ctlr)
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
@@ -1795,11 +1776,7 @@ static void getgeometry(int ctlr)
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

@@ -1815,9 +1792,10 @@ static void getgeometry(int ctlr)
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
