Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161054AbWJDBJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbWJDBJx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 21:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbWJDBJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 21:09:53 -0400
Received: from mail0.lsil.com ([147.145.40.20]:25333 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1030537AbWJDBJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 21:09:51 -0400
Subject: [Patch 4/6] megaraid_sas: prints pending cmds before setting
	hw_crit_error
From: Sumant Patro <sumantp@lsil.com>
To: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Cc: akpm@osdl.org, hch@lst.de, linux-kernel@vger.kernel.org,
       Neela.Kolli@lsil.com, Bo.Yang@lsil.com
Content-Type: multipart/mixed; boundary="=-Pv6IRmyckNRmFxMo2uf0"
Date: Tue, 03 Oct 2006 13:09:14 -0700
Message-Id: <1159906154.5618.29.camel@dumbo>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Pv6IRmyckNRmFxMo2uf0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Resubmitting.

This patch adds function to print the pending frame details before returning
failure from the reset routine. It also exposes a new variable megasas_dbg_lvl 
that allows the user to set the debug level for logging. 

Signed-off-by: Sumant Patro <Sumant.Patro@lsil.com>

diff -uprN linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c linux2.6/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c 2006-10-02 11:11:10.000000000 -0700
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.c 2006-10-02 11:13:30.000000000 -0700
@@ -71,6 +71,8 @@ static struct megasas_mgmt_info megasas_
 static struct fasync_struct *megasas_async_queue;
 static DEFINE_MUTEX(megasas_async_queue_mutex);
 
+static u32 megasas_dbg_lvl;
+
 /**
  * megasas_get_cmd - Get a command from the free pool
  * @instance:  Adapter soft state
@@ -758,6 +760,69 @@ static inline int megasas_is_ldio(struct
  }
 }
 
+ /**
+ * megasas_dump_pending_frames - Dumps the frame address of all pending cmds 
+ *                               in FW
+ * @instance:    Adapter soft state
+ */
+static inline void
+megasas_dump_pending_frames(struct megasas_instance *instance)
+{
+	struct megasas_cmd *cmd;
+	int i,n;
+	union megasas_sgl *mfi_sgl;
+	struct megasas_io_frame *ldio;
+	struct megasas_pthru_frame *pthru;
+	u32 sgcount;
+	u32 max_cmd = instance->max_fw_cmds;
+
+	printk(KERN_ERR "\nmegasas[%d]: Dumping Frame Phys Address of all pending cmds in FW\n",instance->host->host_no);
+	printk(KERN_ERR "megasas[%d]: Total OS Pending cmds : %d\n",instance->host->host_no,atomic_read(&instance->fw_outstanding));
+	if (IS_DMA64) 
+		printk(KERN_ERR "\nmegasas[%d]: 64 bit SGLs were sent to FW\n",instance->host->host_no);
+	else
+		printk(KERN_ERR "\nmegasas[%d]: 32 bit SGLs were sent to FW\n",instance->host->host_no);
+		
+	printk(KERN_ERR "megasas[%d]: Pending OS cmds in FW : \n",instance->host->host_no);
+	for (i = 0; i < max_cmd; i++) {
+		cmd = instance->cmd_list[i];
+		if(!cmd->scmd)
+			continue;
+		printk(KERN_ERR "megasas[%d]: Frame addr :0x%08lx : ",instance->host->host_no,(unsigned long)cmd->frame_phys_addr);
+		if (megasas_is_ldio(cmd->scmd)){
+			ldio = (struct megasas_io_frame *)cmd->frame;
+			mfi_sgl = &ldio->sgl;
+			sgcount = ldio->sge_count;
+			printk(KERN_ERR "megasas[%d]: frame count : 0x%x, Cmd : 0x%x, Tgt id : 0x%x, lba lo : 0x%x, lba_hi : 0x%x, sense_buf addr : 0x%x,sge count : 0x%x\n",instance->host->host_no, cmd->frame_count,ldio->cmd,ldio->target_id, ldio->start_lba_lo,ldio->start_lba_hi,ldio->sense_buf_phys_addr_lo,sgcount);
+		}
+		else {
+			pthru = (struct megasas_pthru_frame *) cmd->frame;
+			mfi_sgl = &pthru->sgl;
+			sgcount = pthru->sge_count;
+			printk(KERN_ERR "megasas[%d]: frame count : 0x%x, Cmd : 0x%x, Tgt id : 0x%x, lun : 0x%x, cdb_len : 0x%x, data xfer len : 0x%x, sense_buf addr : 0x%x,sge count : 0x%x\n",instance->host->host_no,cmd->frame_count,pthru->cmd,pthru->target_id,pthru->lun,pthru->cdb_len , pthru->data_xfer_len,pthru->sense_buf_phys_addr_lo,sgcount);
+		}
+	if(megasas_dbg_lvl & MEGASAS_DBG_LVL){
+		for (n = 0; n < sgcount; n++){
+			if (IS_DMA64) 
+				printk(KERN_ERR "megasas: sgl len : 0x%x, sgl addr : 0x%08lx ",mfi_sgl->sge64[n].length , (unsigned long)mfi_sgl->sge64[n].phys_addr) ;
+			else
+				printk(KERN_ERR "megasas: sgl len : 0x%x, sgl addr : 0x%x ",mfi_sgl->sge32[n].length , mfi_sgl->sge32[n].phys_addr) ;
+			}
+		}
+		printk(KERN_ERR "\n");
+	} /*for max_cmd*/
+	printk(KERN_ERR "\nmegasas[%d]: Pending Internal cmds in FW : \n",instance->host->host_no);
+	for (i = 0; i < max_cmd; i++) {
+
+		cmd = instance->cmd_list[i];
+
+		if(cmd->sync_cmd == 1){
+			printk(KERN_ERR "0x%08lx : ", (unsigned long)cmd->frame_phys_addr);
+		}
+	}
+	printk(KERN_ERR "megasas[%d]: Dumping Done.\n\n",instance->host->host_no);
+}
+
 /**
  * megasas_queue_command -	Queue entry point
  * @scmd:			SCSI command to be queued
@@ -869,6 +934,7 @@ static int megasas_wait_for_outstanding(
 		*/
 		writel(MFI_STOP_ADP,
 				&instance->reg_set->inbound_doorbell);
+		megasas_dump_pending_frames(instance);
 		instance->hw_crit_error = 1;
 		return FAILED;
 	}
@@ -2236,6 +2302,8 @@ megasas_probe_one(struct pci_dev *pdev, 
 	instance->unique_id = pdev->bus->number << 8 | pdev->devfn;
 	instance->init_id = MEGASAS_DEFAULT_INIT_ID;
 
+	megasas_dbg_lvl = 0;
+
 	/*
 	 * Initialize MFI Firmware
 	 */
@@ -2862,6 +2930,26 @@ megasas_sysfs_show_release_date(struct d
 static DRIVER_ATTR(release_date, S_IRUGO, megasas_sysfs_show_release_date,
 		   NULL);
 
+static ssize_t 
+megasas_sysfs_show_dbg_lvl(struct device_driver *dd, char *buf)
+{
+	return sprintf(buf,"%u",megasas_dbg_lvl);
+}
+
+static ssize_t 
+megasas_sysfs_set_dbg_lvl(struct device_driver *dd, const char *buf, size_t count)
+{
+	int retval = count;
+	if(sscanf(buf,"%u",&megasas_dbg_lvl)<1){
+		printk(KERN_ERR "megasas: could not set dbg_lvl\n");
+		retval = -EINVAL;
+	}
+	return retval;
+}
+
+static DRIVER_ATTR(dbg_lvl, S_IRUGO|S_IWUGO, megasas_sysfs_show_dbg_lvl,
+		   megasas_sysfs_set_dbg_lvl);
+
 /**
  * megasas_init - Driver load entry point
  */
@@ -2902,6 +2990,8 @@ static int __init megasas_init(void)
 	driver_create_file(&megasas_pci_driver.driver, &driver_attr_version);
 	driver_create_file(&megasas_pci_driver.driver,
 			   &driver_attr_release_date);
+	driver_create_file(&megasas_pci_driver.driver,
+			   &driver_attr_dbg_lvl);
 
 	return rval;
 }
@@ -2914,6 +3004,8 @@ static void __exit megasas_exit(void)
 	driver_remove_file(&megasas_pci_driver.driver, &driver_attr_version);
 	driver_remove_file(&megasas_pci_driver.driver,
 			   &driver_attr_release_date);
+	driver_remove_file(&megasas_pci_driver.driver,
+			   &driver_attr_dbg_lvl);
 
 	pci_unregister_driver(&megasas_pci_driver);
 	unregister_chrdev(megasas_mgmt_majorno, "megaraid_sas_ioctl");
diff -uprN linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.h linux2.6/drivers/scsi/megaraid/megaraid_sas.h
--- linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.h	2006-10-02 11:11:10.000000000 -0700
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.h 2006-10-02 11:13:30.000000000 -0700
@@ -537,6 +537,8 @@ struct megasas_ctrl_info {
 #define MEGASAS_MAX_LUN    8
 #define MEGASAS_MAX_LD				64
 
+#define MEGASAS_DBG_LVL				1
+
 /*
  * When SCSI mid-layer calls driver's reset routine, driver waits for
  * MEGASAS_RESET_WAIT_TIME seconds for all outstanding IO to complete. Note


--=-Pv6IRmyckNRmFxMo2uf0
Content-Disposition: attachment; filename=dbg_dump-p4.patch
Content-Type: text/x-patch; name=dbg_dump-p4.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uprN linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c linux2.6/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.c	2006-10-02 11:11:10.000000000 -0700
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.c	2006-10-02 11:13:30.000000000 -0700
@@ -71,6 +71,8 @@ static struct megasas_mgmt_info megasas_
 static struct fasync_struct *megasas_async_queue;
 static DEFINE_MUTEX(megasas_async_queue_mutex);
 
+static u32 megasas_dbg_lvl;
+
 /**
  * megasas_get_cmd -	Get a command from the free pool
  * @instance:		Adapter soft state
@@ -758,6 +760,69 @@ static inline int megasas_is_ldio(struct
 	}
 }
 
+ /**
+ * megasas_dump_pending_frames -	Dumps the frame address of all pending cmds 
+ *                              	in FW
+ * @instance:				Adapter soft state
+ */
+static inline void
+megasas_dump_pending_frames(struct megasas_instance *instance)
+{
+	struct megasas_cmd *cmd;
+	int i,n;
+	union megasas_sgl *mfi_sgl;
+	struct megasas_io_frame *ldio;
+	struct megasas_pthru_frame *pthru;
+	u32 sgcount;
+	u32 max_cmd = instance->max_fw_cmds;
+
+	printk(KERN_ERR "\nmegasas[%d]: Dumping Frame Phys Address of all pending cmds in FW\n",instance->host->host_no);
+	printk(KERN_ERR "megasas[%d]: Total OS Pending cmds : %d\n",instance->host->host_no,atomic_read(&instance->fw_outstanding));
+	if (IS_DMA64) 
+		printk(KERN_ERR "\nmegasas[%d]: 64 bit SGLs were sent to FW\n",instance->host->host_no);
+	else
+		printk(KERN_ERR "\nmegasas[%d]: 32 bit SGLs were sent to FW\n",instance->host->host_no);
+		
+	printk(KERN_ERR "megasas[%d]: Pending OS cmds in FW : \n",instance->host->host_no);
+	for (i = 0; i < max_cmd; i++) {
+		cmd = instance->cmd_list[i];
+		if(!cmd->scmd)
+			continue;
+		printk(KERN_ERR "megasas[%d]: Frame addr :0x%08lx : ",instance->host->host_no,(unsigned long)cmd->frame_phys_addr);
+		if (megasas_is_ldio(cmd->scmd)){
+			ldio = (struct megasas_io_frame *)cmd->frame;
+			mfi_sgl = &ldio->sgl;
+			sgcount = ldio->sge_count;
+			printk(KERN_ERR "megasas[%d]: frame count : 0x%x, Cmd : 0x%x, Tgt id : 0x%x, lba lo : 0x%x, lba_hi : 0x%x, sense_buf addr : 0x%x,sge count : 0x%x\n",instance->host->host_no, cmd->frame_count,ldio->cmd,ldio->target_id, ldio->start_lba_lo,ldio->start_lba_hi,ldio->sense_buf_phys_addr_lo,sgcount);
+		}
+		else {
+			pthru = (struct megasas_pthru_frame *) cmd->frame;
+			mfi_sgl = &pthru->sgl;
+			sgcount = pthru->sge_count;
+			printk(KERN_ERR "megasas[%d]: frame count : 0x%x, Cmd : 0x%x, Tgt id : 0x%x, lun : 0x%x, cdb_len : 0x%x, data xfer len : 0x%x, sense_buf addr : 0x%x,sge count : 0x%x\n",instance->host->host_no,cmd->frame_count,pthru->cmd,pthru->target_id,pthru->lun,pthru->cdb_len , pthru->data_xfer_len,pthru->sense_buf_phys_addr_lo,sgcount);
+		}
+	if(megasas_dbg_lvl & MEGASAS_DBG_LVL){
+		for (n = 0; n < sgcount; n++){
+			if (IS_DMA64) 
+				printk(KERN_ERR "megasas: sgl len : 0x%x, sgl addr : 0x%08lx ",mfi_sgl->sge64[n].length , (unsigned long)mfi_sgl->sge64[n].phys_addr) ;
+			else
+				printk(KERN_ERR "megasas: sgl len : 0x%x, sgl addr : 0x%x ",mfi_sgl->sge32[n].length , mfi_sgl->sge32[n].phys_addr) ;
+			}
+		}
+		printk(KERN_ERR "\n");
+	} /*for max_cmd*/
+	printk(KERN_ERR "\nmegasas[%d]: Pending Internal cmds in FW : \n",instance->host->host_no);
+	for (i = 0; i < max_cmd; i++) {
+
+		cmd = instance->cmd_list[i];
+
+		if(cmd->sync_cmd == 1){
+			printk(KERN_ERR "0x%08lx : ", (unsigned long)cmd->frame_phys_addr);
+		}
+	}
+	printk(KERN_ERR "megasas[%d]: Dumping Done.\n\n",instance->host->host_no);
+}
+
 /**
  * megasas_queue_command -	Queue entry point
  * @scmd:			SCSI command to be queued
@@ -869,6 +934,7 @@ static int megasas_wait_for_outstanding(
 		*/
 		writel(MFI_STOP_ADP,
 				&instance->reg_set->inbound_doorbell);
+		megasas_dump_pending_frames(instance);
 		instance->hw_crit_error = 1;
 		return FAILED;
 	}
@@ -2236,6 +2302,8 @@ megasas_probe_one(struct pci_dev *pdev, 
 	instance->unique_id = pdev->bus->number << 8 | pdev->devfn;
 	instance->init_id = MEGASAS_DEFAULT_INIT_ID;
 
+	megasas_dbg_lvl = 0;
+
 	/*
 	 * Initialize MFI Firmware
 	 */
@@ -2862,6 +2930,26 @@ megasas_sysfs_show_release_date(struct d
 static DRIVER_ATTR(release_date, S_IRUGO, megasas_sysfs_show_release_date,
 		   NULL);
 
+static ssize_t 
+megasas_sysfs_show_dbg_lvl(struct device_driver *dd, char *buf)
+{
+	return sprintf(buf,"%u",megasas_dbg_lvl);
+}
+
+static ssize_t 
+megasas_sysfs_set_dbg_lvl(struct device_driver *dd, const char *buf, size_t count)
+{
+	int retval = count;
+	if(sscanf(buf,"%u",&megasas_dbg_lvl)<1){
+		printk(KERN_ERR "megasas: could not set dbg_lvl\n");
+		retval = -EINVAL;
+	}
+	return retval;
+}
+
+static DRIVER_ATTR(dbg_lvl, S_IRUGO|S_IWUGO, megasas_sysfs_show_dbg_lvl,
+		   megasas_sysfs_set_dbg_lvl);
+
 /**
  * megasas_init - Driver load entry point
  */
@@ -2902,6 +2990,8 @@ static int __init megasas_init(void)
 	driver_create_file(&megasas_pci_driver.driver, &driver_attr_version);
 	driver_create_file(&megasas_pci_driver.driver,
 			   &driver_attr_release_date);
+	driver_create_file(&megasas_pci_driver.driver,
+			   &driver_attr_dbg_lvl);
 
 	return rval;
 }
@@ -2914,6 +3004,8 @@ static void __exit megasas_exit(void)
 	driver_remove_file(&megasas_pci_driver.driver, &driver_attr_version);
 	driver_remove_file(&megasas_pci_driver.driver,
 			   &driver_attr_release_date);
+	driver_remove_file(&megasas_pci_driver.driver,
+			   &driver_attr_dbg_lvl);
 
 	pci_unregister_driver(&megasas_pci_driver);
 	unregister_chrdev(megasas_mgmt_majorno, "megaraid_sas_ioctl");
diff -uprN linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.h linux2.6/drivers/scsi/megaraid/megaraid_sas.h
--- linux2.6-orig/drivers/scsi/megaraid/megaraid_sas.h	2006-10-02 11:11:10.000000000 -0700
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.h	2006-10-02 11:13:30.000000000 -0700
@@ -537,6 +537,8 @@ struct megasas_ctrl_info {
 #define MEGASAS_MAX_LUN				8
 #define MEGASAS_MAX_LD				64
 
+#define MEGASAS_DBG_LVL				1
+
 /*
  * When SCSI mid-layer calls driver's reset routine, driver waits for
  * MEGASAS_RESET_WAIT_TIME seconds for all outstanding IO to complete. Note

--=-Pv6IRmyckNRmFxMo2uf0--

