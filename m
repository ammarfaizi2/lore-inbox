Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbVLaFV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbVLaFV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 00:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVLaFV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 00:21:27 -0500
Received: from xenotime.net ([66.160.160.81]:3229 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751021AbVLaFVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 00:21:24 -0500
Date: Fri, 30 Dec 2005 21:21:58 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: dax@gurulabs.com, erich@areca.com.tw
Cc: akpm@osdl.org, arjan@infradead.org, oliver@neukum.org,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: [PATCH 2/2] Areca RAID driver (arcmsr) cleanups
Message-Id: <20051230212158.4b97edfe.rdunlap@xenotime.net>
In-Reply-To: <20051230113227.2b787d43.rdunlap@xenotime.net>
References: <1135228831.4122.15.camel@mentorng.gurulabs.com>
	<1135229681.439.23.camel@mindpipe>
	<200512220917.41494.oliver@neukum.org>
	<1135239601.2940.5.camel@laptopd505.fenrus.org>
	<20051222052443.57ffe6f9.akpm@osdl.org>
	<1135279895.19320.24.camel@mentorng.gurulabs.com>
	<20051230113227.2b787d43.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Here's a start on some cleanups and a list of general issues.
> I'm not addressing SCSI or MM/DMA API issues, if there are any.

[PATCH 1/2]
> 0.  some Kconfig and Makefile cleanups
> 1.  fix arcmsr_device_id_table[] inits;
> 2.  fix return (value); -- don't use parenethese
> 3.  fix one-line-ifs-with-braces -- remove braces
> 4.  struct _XYZ & typedef XYZ, PXYZ -- convert to struct XYZ only
> 5.  check NULL usage
> 6.  no "return;" at end of func; -- removed
> 7.  return -ENXIO instead of ENXIO;
> 
> Patch for above items is below.
> 
> More issues, not yet patched:
> 
> 8.  check sparse warnings, stack usage, init/exit sections;
> 9.  don't use // comments;
> 10. use printk levels
> 11. pPCI_DEV: bad naming (throughout driver; don't use mixed case)
> 12. some comments are unreadable (non-ASCII ?)
> 13. uintNN_t int types:  use kernel types except for userspace interfaces
> 14. use kernel-doc
> 15. try to fit source files into 80 columns
> ---

Erich, here are some more notes for you:

16. Tab size in Linux kernel is 8 (not less).
17. Don't put changelog comments in source files.  That's what
    SCMs are for (source code manager tools).
18. Put arcmsr.txt in Documentation/scsi/, not in scsi/arcmsr/.
19. Maybe use sysfs (/sys) instead of /proc.
---




From: Randy Dunlap <rdunlap@xenotime.net>

More Areca (arcmsr) cleanups:

Fix about 1/2 of sparse warnings
    (There are no stack size problems.)
Lots of long lines now fit into 80 columns (but not all of them).
Too much indentation in arcmsr_iop_ioctlcmd() and in arcmsr_info()

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/scsi/arcmsr/arcmsr.c | 1103 +++++++++++++++++++++----------------------
 1 files changed, 561 insertions(+), 542 deletions(-)

--- linux-2615-rc7.orig/drivers/scsi/arcmsr/arcmsr.c
+++ linux-2615-rc7/drivers/scsi/arcmsr/arcmsr.c
@@ -1,5 +1,5 @@
 /*
-******************************************************************************************
+***************************************************************************
 **        O.S   : Linux
 **   FILE NAME  : arcmsr.c
 **        BY    : Erich Chen
@@ -43,49 +43,74 @@
 **************************************************************************
 ** History
 **
-**        REV#         DATE	            NAME	         DESCRIPTION
-**     1.00.00.00    3/31/2004	       Erich Chen	     First release
-**     1.10.00.04    7/28/2004         Erich Chen        modify for ioctl
-**     1.10.00.06    8/28/2004         Erich Chen        modify for 2.6.x
-**     1.10.00.08    9/28/2004         Erich Chen        modify for x86_64
-**     1.10.00.10   10/10/2004         Erich Chen        bug fix for SMP & ioctl
-**     1.20.00.00   11/29/2004         Erich Chen        bug fix with arcmsr_bus_reset when PHY error
-**     1.20.00.02   12/09/2004         Erich Chen        bug fix with over 2T bytes RAID Volume
-**     1.20.00.04    1/09/2005         Erich Chen        fits for Debian linux kernel version 2.2.xx
-**     1.20.00.05    2/20/2005         Erich Chen        cleanly as look like a Linux driver at 2.6.x
-**     													 thanks for peoples kindness comment
-**     															Kornel Wieliczek
-**     															Christoph Hellwig
-**     															Adrian Bunk
-**     															Andrew Morton
-**     															Christoph Hellwig
-**     															James Bottomley
-**     															Arjan van de Ven
-**     1.20.00.06    3/12/2005         Erich Chen        fix with arcmsr_pci_unmap_dma "unsigned long" cast,
-**                                                       modify PCCB POOL allocated by "dma_alloc_coherent"
-**                                                       (Kornel Wieliczek's comment)
-**     1.20.00.07    3/23/2005         Erich Chen        bug fix with arcmsr_scsi_host_template_init ocur segmentation fault,
-**                                                       if RAID adapter does not on PCI slot and modprobe/rmmod this driver twice.
-**                                                       bug fix enormous stack usage (Adrian Bunk's comment)
-**     1.20.00.08    6/23/2005         Erich Chen        bug fix with abort command, in case of heavy loading when sata cable
-**                                                       working on low quality connection
-**     1.20.00.09    9/12/2005         Erich Chen        bug fix with abort command handling, firmware version check
-**                                                       and firmware update notify for hardware bug fix
-**     1.20.00.10    9/23/2005         Erich Chen        enhance sysfs function for change driver's max tag Q number.
-**                                                       add DMA_64BIT_MASK for backward compatible with all 2.6.x
-**                                                       add some useful message for abort command
-**                                                       add ioctl code 'ARCMSR_IOCTL_FLUSH_ADAPTER_CACHE'
-**                                                       customer can send this command for sync raid volume data
-**     1.20.00.11    9/29/2005         Erich Chen        by comment of Arjan van de Ven fix incorrect msleep redefine
-**                                                       cast off sizeof(dma_addr_t) condition for 64bit pci_set_dma_mask
-**     1.20.00.12    9/30/2005         Erich Chen        bug fix with 64bit platform's ccbs using if over 4G system memory
-**                                                       change 64bit pci_set_consistent_dma_mask into 32bit
-**                                                       increcct adapter count if adapter initialize fail.
-**                                                       miss edit at arcmsr_build_ccb....
-**                                                       psge += sizeof(struct SG64ENTRY *) =>  psge += sizeof(struct SG64ENTRY)
-**                                                       64 bits sg entry would be incorrectly calculated
-**                                                       thanks Kornel Wieliczek give me kindly notify and detail description
-******************************************************************************************
+**    REV#       DATE	    NAME	DESCRIPTION
+** 1.00.00.00  03/31/2004   Erich Chen	First release
+** 1.10.00.04  07/28/2004   Erich Chen  modify for ioctl
+** 1.10.00.06  08/28/2004   Erich Chen  modify for 2.6.x
+** 1.10.00.08  09/28/2004   Erich Chen  modify for x86_64
+** 1.10.00.10  10/10/2004   Erich Chen  bug fix for SMP & ioctl
+** 1.20.00.00  11/29/2004   Erich Chen  bug fix with arcmsr_bus_reset
+**					when PHY error
+** 1.20.00.02  12/09/2004   Erich Chen  bug fix with over 2TB RAID Volume
+** 1.20.00.04   1/09/2005   Erich Chen  fix for Debian linux kernel
+**					version 2.2.xx
+** 1.20.00.05   2/20/2005   Erich Chen  clean to look like a Linux
+**					driver at 2.6.x
+**     		 thanks for peoples kindness comment
+**				Kornel Wieliczek
+**				Christoph Hellwig
+**				Adrian Bunk
+**				Andrew Morton
+**				Christoph Hellwig
+**				James Bottomley
+**				Arjan van de Ven
+** 1.20.00.06   3/12/2005   Erich Chen  fix with arcmsr_pci_unmap_dma
+**					"unsigned long" cast,
+**                                      modify PCCB POOL allocated by
+**					"dma_alloc_coherent"
+**                                      (Kornel Wieliczek's comment)
+** 1.20.00.07   3/23/2005   Erich Chen  bug fix with
+**					arcmsr_scsi_host_template_init
+**					occur segmentation fault,
+**                                      if RAID adapter does not own PCI slot
+**					and modprobe/rmmod this driver twice.
+**                                      bug fix enormous stack usage
+**					(Adrian Bunk's comment)
+** 1.20.00.08   6/23/2005   Erich Chen  bug fix with abort command, in case
+**					of heavy loading when sata cable
+**                                      working on low quality connection
+** 1.20.00.09   9/12/2005   Erich Chen  bug fix with abort command handling,
+**					firmware version check
+**                                      and firmware update notify for
+**					hardware bug fix
+** 1.20.00.10   9/23/2005   Erich Chen  enhance sysfs function for change
+**					driver's max tag Q number.
+**                                      add DMA_64BIT_MASK for backward
+**					compatible with all 2.6.x
+**                                      add some useful message for abort
+**					command;
+**                                      add ioctl code
+**					'ARCMSR_IOCTL_FLUSH_ADAPTER_CACHE';
+**                                      customer can send this command to
+**					sync raid volume data
+** 1.20.00.11   9/29/2005   Erich Chen  by comment of Arjan van de Ven fix
+**					incorrect msleep redefine
+**                                      cast off sizeof(dma_addr_t) condition
+**					for 64bit pci_set_dma_mask
+** 1.20.00.12   9/30/2005   Erich Chen  bug fix with 64-bit platform's ccbs
+**					using if over 4G system memory
+**                                      change 64-bit
+**					pci_set_consistent_dma_mask into 32-bit
+**                                      incorrect adapter count if adapter
+**					initialize fail.
+**                                      miss edit at arcmsr_build_ccb....
+**                                      psge += sizeof(struct SG64ENTRY *) =>
+**					psge += sizeof(struct SG64ENTRY)
+**                                      64 bits sg entry would be incorrectly
+**					calculated
+**                                      thanks Kornel Wieliczek give me kindly
+**					notify and detail description
+***************************************************************************
 */
 #include <linux/module.h>
 #include <linux/reboot.h>
@@ -113,14 +138,14 @@ MODULE_DESCRIPTION("ARECA (ARC11xx/12xx)
 MODULE_LICENSE("Dual BSD/GPL");
 
 /*
-**********************************************************************************
-**********************************************************************************
+***************************************************************************
+***************************************************************************
 */
 static u_int8_t arcmsr_adapterCnt = 0;
 static struct HCBARC arcmsr_host_control_block;
 /*
-**********************************************************************************
-**********************************************************************************
+***************************************************************************
+***************************************************************************
 */
 static int arcmsr_fops_ioctl(struct inode *inode, struct file *filep,
 			     unsigned int ioctl_cmd, unsigned long arg);
@@ -129,7 +154,7 @@ static int arcmsr_fops_open(struct inode
 static int arcmsr_halt_notify(struct notifier_block *nb, unsigned long event,
 			      void *buf);
 static int arcmsr_initialize(struct ACB *pACB, struct pci_dev *pPCI_DEV);
-static int arcmsr_iop_ioctlcmd(struct ACB *pACB, int ioctl_cmd, void *arg);
+static int arcmsr_iop_ioctlcmd(struct ACB *pACB, int ioctl_cmd, void __user *arg);
 static int arcmsr_proc_info(struct Scsi_Host *host, char *buffer, char **start,
 			    off_t offset, int length, int inout);
 static int arcmsr_bios_param(struct scsi_device *sdev,
@@ -140,7 +165,7 @@ static int arcmsr_queue_command(struct s
 				void (*done) (struct scsi_cmnd *));
 static int arcmsr_cmd_abort(struct scsi_cmnd *);
 static int arcmsr_bus_reset(struct scsi_cmnd *);
-static int arcmsr_ioctl(struct scsi_device *dev, int ioctl_cmd, void *arg);
+static int arcmsr_ioctl(struct scsi_device *dev, int ioctl_cmd, void __user *arg);
 static int __devinit arcmsr_device_probe(struct pci_dev *pPCI_DEV,
 					 const struct pci_device_id *id);
 static void arcmsr_device_remove(struct pci_dev *pPCI_DEV);
@@ -151,9 +176,8 @@ static irqreturn_t arcmsr_interrupt(stru
 static u_int8_t arcmsr_wait_msgint_ready(struct ACB *pACB);
 static const char *arcmsr_info(struct Scsi_Host *);
 /*
-**********************************************************************************
-**
-**********************************************************************************
+***************************************************************************
+***************************************************************************
 */
 static ssize_t arcmsr_show_firmware_info(struct class_device *dev, char *buf)
 {
@@ -265,9 +289,9 @@ static struct scsi_host_template arcmsr_
 };
 
 /*
-**********************************************************************************
+***************************************************************************
 ** notifier block to get a notify on system shutdown/halt/reboot
-**********************************************************************************
+***************************************************************************
 */
 static struct notifier_block arcmsr_event_notifier =
     { .notifier_call = arcmsr_halt_notify };
@@ -371,7 +395,8 @@ static int __devinit arcmsr_device_probe
 		       arcmsr_adapterCnt);
 		return -ENODEV;
 	}
-	/* allocate scsi host information (includes out adapter) scsi_host_alloc==scsi_register */
+	/* allocate scsi host information (includes our adapter)
+	 * scsi_host_alloc==scsi_register */
 	if ((host =
 	     scsi_host_alloc(&arcmsr_scsi_host_template,
 			     sizeof(struct ACB))) == 0) {
@@ -412,9 +437,9 @@ static int __devinit arcmsr_device_probe
 	host->max_sectors = ARCMSR_MAX_XFER_SECTORS;
 	host->max_lun = ARCMSR_MAX_TARGETLUN;
 	host->max_id = ARCMSR_MAX_TARGETID;	/*16:8 */
-	host->max_cmd_len = 16;	/*this is issue of 64bit LBA, over 2T byte */
+	host->max_cmd_len = 16;	/* this is issue of 64bit LBA, over 2T byte */
 	host->sg_tablesize = ARCMSR_MAX_SG_ENTRIES;
-	host->can_queue = ARCMSR_MAX_OUTSTANDING_CMD;	/* max simultaneous cmds */
+	host->can_queue = ARCMSR_MAX_OUTSTANDING_CMD; /* max simultaneous cmds */
 	host->cmd_per_lun = ARCMSR_MAX_CMD_PERLUN;
 	host->this_id = ARCMSR_SCSI_INITIATOR_ID;
 	host->unique_id = (bus << 8) | dev_fun;
@@ -480,7 +505,7 @@ static void arcmsr_device_remove(struct 
 	scsi_remove_host(host);
 	scsi_host_put(host);
 	pci_set_drvdata(pPCI_DEV, NULL);
-	/*if this is last pACB */
+	/* if this is last pACB */
 	for (i = 0; i < ARCMSR_MAX_ADAPTER; i++) {
 		if (pHCBARC->pACB[i])
 			return;	/* this is not last adapter's release */
@@ -550,17 +575,16 @@ static void arcmsr_pci_unmap_dma(struct 
 		sl = (struct scatterlist *)pcmd->request_buffer;
 		pci_unmap_sg(pACB->pPCI_DEV, sl, pcmd->use_sg,
 			     pcmd->sc_data_direction);
-	} else if (pcmd->request_bufflen != 0) {
+	} else if (pcmd->request_bufflen != 0)
 		pci_unmap_single(pACB->pPCI_DEV,
 				 (dma_addr_t) (unsigned long)pcmd->SCp.ptr,
 				 pcmd->request_bufflen,
 				 pcmd->sc_data_direction);
-	}
 }
 
 /*
-**********************************************************************************
-**********************************************************************************
+***************************************************************************
+***************************************************************************
 */
 static int arcmsr_fops_open(struct inode *inode, struct file *filep)
 {
@@ -582,8 +606,8 @@ static int arcmsr_fops_open(struct inode
 }
 
 /*
-**********************************************************************************
-**********************************************************************************
+***************************************************************************
+***************************************************************************
 */
 static int arcmsr_fops_close(struct inode *inode, struct file *filep)
 {
@@ -605,8 +629,8 @@ static int arcmsr_fops_close(struct inod
 }
 
 /*
-**********************************************************************************
-**********************************************************************************
+***************************************************************************
+***************************************************************************
 */
 static int arcmsr_fops_ioctl(struct inode *inode, struct file *filep,
 			     unsigned int ioctl_cmd, unsigned long arg)
@@ -627,10 +651,10 @@ static int arcmsr_fops_ioctl(struct inod
 		return -ENXIO;
 	/*
 	 ************************************************************
-	 ** We do not allow muti ioctls to the driver at the same duration.
+	 ** We do not allow multi ioctls to the driver at the same duration.
 	 ************************************************************
 	 */
-	return arcmsr_iop_ioctlcmd(pACB, ioctl_cmd, (void *)arg);
+	return arcmsr_iop_ioctlcmd(pACB, ioctl_cmd, (void __user *)arg);
 }
 
 /*
@@ -737,12 +761,14 @@ static u_int8_t arcmsr_wait_msgint_ready
 		for (Index = 0; Index < 100; Index++) {
 			if (readl(&pACB->pmu->outbound_intstatus) &
 			    ARCMSR_MU_OUTBOUND_MESSAGE0_INT) {
-				writel(ARCMSR_MU_OUTBOUND_MESSAGE0_INT, &pACB->pmu->outbound_intstatus);	/*clear interrupt */
+				writel(ARCMSR_MU_OUTBOUND_MESSAGE0_INT,
+					&pACB->pmu->outbound_intstatus);
+					/* clear interrupt */
 				return 0x00;
 			}
 			msleep_interruptible(10);
-		}		/*max 1 seconds */
-	} while (Retries++ < 20);	/*max 20 sec */
+		}	/* max 1 seconds */
+	} while (Retries++ < 20);	/* max 20 sec */
 	return 0xff;
 }
 
@@ -770,7 +796,7 @@ static void arcmsr_iop_reset(struct ACB 
 			printk
 			    ("arcmsr_iop_reset: wait 'abort all outstanding command' timeout................. \n");
 		}
-		/*clear all outbound posted Q */
+		/* clear all outbound posted Q */
 		for (i = 0; i < ARCMSR_MAX_OUTSTANDING_CMD; i++) {
 			readl(&pACB->pmu->outbound_queueport);
 		}
@@ -900,7 +926,7 @@ static void arcmsr_build_ccb(struct ACB 
 
 /*
 **************************************************************************
-**	arcmsr_post_ccb - Send a protocol specific ARC send postcard to a AIOC .
+**	arcmsr_post_ccb - Send a protocol specific ARC send postcard to a AIOC.
 **	handle: Handle of registered ARC protocol driver
 **	adapter_id: AIOC unique identifier(integer)
 **	pPOSTCARD_SEND: Pointer to ARC send postcard
@@ -968,13 +994,15 @@ static void arcmsr_post_Qbuffer(struct A
 		pQbuffer = &pACB->wqbuffer[pACB->wqbuf_firstindex];
 		memcpy(iop_data, pQbuffer, 1);
 		pACB->wqbuf_firstindex++;
-		pACB->wqbuf_firstindex %= ARCMSR_MAX_QBUFFER;	/*if last index number set it to 0 */
+		/* if last index number set it to 0 */
+		pACB->wqbuf_firstindex %= ARCMSR_MAX_QBUFFER;
 		iop_data++;
 		allxfer_len++;
 	}
 	pwbuffer->data_len = allxfer_len;
 	/*
-	 ** push inbound doorbell and wait reply at hwinterrupt routine for next Qbuffer post
+	 ** push inbound doorbell and wait reply at hwinterrupt routine
+	 ** for next Qbuffer post
 	 */
 	writel(ARCMSR_INBOUND_DRIVER_DATA_WRITE_OK,
 	       &pACB->pmu->inbound_doorbell);
@@ -1033,7 +1061,8 @@ static irqreturn_t arcmsr_interrupt(stru
 	 */
 	outbound_intstatus =
 	    readl(&pACB->pmu->outbound_intstatus) & pACB->outbound_int_enable;
-	writel(outbound_intstatus, &pACB->pmu->outbound_intstatus);	/*clear interrupt */
+	/* clear interrupt */
+	writel(outbound_intstatus, &pACB->pmu->outbound_intstatus);
 	if (outbound_intstatus & ARCMSR_MU_OUTBOUND_DOORBELL_INT) {
 		/*
 		 *********************************************
@@ -1041,7 +1070,8 @@ static irqreturn_t arcmsr_interrupt(stru
 		 *********************************************
 		 */
 		outbound_doorbell = readl(&pACB->pmu->outbound_doorbell);
-		writel(outbound_doorbell, &pACB->pmu->outbound_doorbell);	/*clear interrupt */
+		/* clear interrupt */
+		writel(outbound_doorbell, &pACB->pmu->outbound_doorbell);
 		if (outbound_doorbell & ARCMSR_OUTBOUND_IOP331_DATA_WRITE_OK) {
 			struct QBUFFER *prbuffer =
 			    (struct QBUFFER *)&pACB->pmu->ioctl_rbuffer;
@@ -1050,7 +1080,7 @@ static irqreturn_t arcmsr_interrupt(stru
 			int32_t my_empty_len, iop_len, rqbuf_firstindex,
 			    rqbuf_lastindex;
 
-			/*check this iop data if overflow my rqbuffer */
+			/* check this iop data if overflow my rqbuffer */
 			rqbuf_lastindex = pACB->rqbuf_lastindex;
 			rqbuf_firstindex = pACB->rqbuf_firstindex;
 			iop_len = prbuffer->data_len;
@@ -1064,14 +1094,18 @@ static irqreturn_t arcmsr_interrupt(stru
 							    rqbuf_lastindex];
 					memcpy(pQbuffer, iop_data, 1);
 					pACB->rqbuf_lastindex++;
-					pACB->rqbuf_lastindex %= ARCMSR_MAX_QBUFFER;	/*if last index number set it to 0 */
+					/* if last index number set it to 0 */
+					pACB->rqbuf_lastindex %=
+						ARCMSR_MAX_QBUFFER;
 					iop_data++;
 					iop_len--;
 				}
-				writel(ARCMSR_INBOUND_DRIVER_DATA_READ_OK, &pACB->pmu->inbound_doorbell);	/*signature, let IOP331 know data has been readed */
-			} else {
+				/* signature, let IOP331 know data has been
+				 * read */
+				writel(ARCMSR_INBOUND_DRIVER_DATA_READ_OK,
+					&pACB->pmu->inbound_doorbell);
+			} else
 				pACB->acb_flags |= ACB_F_IOPDATA_OVERFLOW;
-			}
 		}
 		if (outbound_doorbell & ARCMSR_OUTBOUND_IOP331_DATA_READ_OK) {
 			/*
@@ -1089,41 +1123,45 @@ static irqreturn_t arcmsr_interrupt(stru
 				while ((pACB->wqbuf_firstindex !=
 					pACB->wqbuf_lastindex)
 				       && (allxfer_len < 124)) {
-					pQbuffer =
-					    &pACB->wqbuffer[pACB->
-							    wqbuf_firstindex];
+					pQbuffer = &pACB->wqbuffer[
+							pACB->wqbuf_firstindex];
 					memcpy(iop_data, pQbuffer, 1);
 					pACB->wqbuf_firstindex++;
-					pACB->wqbuf_firstindex %= ARCMSR_MAX_QBUFFER;	/*if last index number set it to 0 */
+					/* if last index number set it to 0 */
+					pACB->wqbuf_firstindex %=
+						ARCMSR_MAX_QBUFFER;
 					iop_data++;
 					allxfer_len++;
 				}
 				pwbuffer->data_len = allxfer_len;
 				/*
-				 ** push inbound doorbell tell iop driver data write ok and wait reply on next hwinterrupt for next Qbuffer post
+				 ** push inbound doorbell tell iop driver
+				 ** data write ok and wait reply on next
+				 ** hwinterrupt for next Qbuffer post
 				 */
 				writel(ARCMSR_INBOUND_DRIVER_DATA_WRITE_OK,
 				       &pACB->pmu->inbound_doorbell);
-			} else {
+			} else
 				pACB->acb_flags |= ACB_F_IOCTL_WQBUFFER_CLEARED;
-			}
 		}
 	}
 	if (outbound_intstatus & ARCMSR_MU_OUTBOUND_POSTQUEUE_INT) {
 		int id, lun;
 		/*
-		 *****************************************************************************
+		 **********************************************************
 		 **               areca cdb command done
-		 *****************************************************************************
+		 **********************************************************
 		 */
 		while (1) {
 			if ((flag_ccb =
 			     readl(&pACB->pmu->outbound_queueport)) ==
 			    0xFFFFFFFF) {
-				break;	/*chip FIFO no ccb for completion already */
+				break;	/* chip FIFO no ccb for completion already */
 			}
 			/* check if command done with no error */
-			pCCB = (struct CCB *)(pACB->vir2phy_offset + (flag_ccb << 5));	/*frame must be 32 bytes aligned */
+			/* frame must be 32 bytes aligned */
+			pCCB = (struct CCB *)(pACB->vir2phy_offset +
+				(flag_ccb << 5));
 			if ((pCCB->pACB != pACB)
 			    || (pCCB->startdone != ARCMSR_CCB_START)) {
 				if (pCCB->startdone == ARCMSR_CCB_ABORTED) {
@@ -1181,31 +1219,35 @@ static irqreturn_t arcmsr_interrupt(stru
 					}
 					break;
 				default:
-					/* error occur Q all error ccb to errorccbpending Q */
+					/* error occur Q all error ccb to
+					 * errorccbpending Q */
 					printk
 					    ("arcmsr%d scsi id=%d lun=%d isr get command error done, but got unknow DeviceStatus=0x%x \n",
 					     pACB->adapter_index, id, lun,
 					     pCCB->arcmsr_cdb.DeviceStatus);
 					pACB->devstate[id][lun] =
 					    ARECA_RAID_GONE;
-					pCCB->pcmd->result = DID_NO_CONNECT << 16;	/*unknow error or crc error just for retry */
+					/* unknown error or crc error just for
+					 * retry */
+					pCCB->pcmd->result =
+						DID_NO_CONNECT << 16;
 					arcmsr_ccb_complete(pCCB);
 					break;
 				}
 			}
-		}		/*drain reply FIFO */
+		}		/* drain reply FIFO */
 	}
 	if (!(outbound_intstatus & ARCMSR_MU_OUTBOUND_HANDLE_INT))
-		/*it must be share irq */
+		/* it must be share irq */
 		return IRQ_NONE;
 	if (atomic_read(&pACB->ccbwait2gocount) != 0)
-		arcmsr_post_wait2go_ccb(pACB);	/*try to post all pending ccb */
+		arcmsr_post_wait2go_ccb(pACB);	/* try to post all pending ccb */
 	return IRQ_HANDLED;
 }
 
 /*
-*******************************************************************************
-*******************************************************************************
+***************************************************************************
+***************************************************************************
 */
 static void arcmsr_iop_parking(struct ACB *pACB)
 {
@@ -1233,282 +1275,257 @@ static void arcmsr_iop_parking(struct AC
 ***********************************************************************
 ************************************************************************
 */
-static int arcmsr_iop_ioctlcmd(struct ACB *pACB, int ioctl_cmd, void *arg)
+static int arcmsr_iop_ioctlcmd(struct ACB *pACB, int ioctl_cmd, void __user *arg)
 {
 	struct CMD_IOCTL_FIELD *pcmdioctlfld;
 	dma_addr_t cmd_handle;
 	int retvalue = 0;
 	/* Only let one of these through at a time */
 
-	pcmdioctlfld =
-	    pci_alloc_consistent(pACB->pPCI_DEV,
-				 sizeof(struct CMD_IOCTL_FIELD), &cmd_handle);
-	if (pcmdioctlfld == NULL)
+	pcmdioctlfld = pci_alloc_consistent(pACB->pPCI_DEV,
+			sizeof(struct CMD_IOCTL_FIELD), &cmd_handle);
+	if (!pcmdioctlfld)
 		return -ENOMEM;
-	if (copy_from_user(pcmdioctlfld, arg, sizeof(struct CMD_IOCTL_FIELD))
-	    != 0) {
+	if (copy_from_user(pcmdioctlfld, arg, sizeof(struct CMD_IOCTL_FIELD))) {
 		retvalue = -EFAULT;
 		goto ioctl_out;
 	}
-	if (memcmp(pcmdioctlfld->cmdioctl.Signature, "ARCMSR", 6) != 0) {
+	if (memcmp(pcmdioctlfld->cmdioctl.Signature, "ARCMSR", 6)) {
 		retvalue = -EINVAL;
 		goto ioctl_out;
 	}
 	switch (ioctl_cmd) {
 	case ARCMSR_IOCTL_READ_RQBUFFER:
-		{
-			unsigned long flag;
-			unsigned long *ver_addr;
-			dma_addr_t buf_handle;
-			uint8_t *pQbuffer, *ptmpQbuffer;
-			int32_t allxfer_len = 0;
-
-			ver_addr =
-			    pci_alloc_consistent(pACB->pPCI_DEV, 1032,
-						 &buf_handle);
-			if (ver_addr == NULL) {
-				retvalue = -ENOMEM;
-				goto ioctl_out;
-			}
-			ptmpQbuffer = (uint8_t *) ver_addr;
-			spin_lock_irqsave(&pACB->qbuffer_lockunlock, flag);
-			while ((pACB->rqbuf_firstindex != pACB->rqbuf_lastindex)
-			       && (allxfer_len < 1031)) {
-				/*copy READ QBUFFER to srb */
-				pQbuffer =
-				    &pACB->rqbuffer[pACB->rqbuf_firstindex];
-				memcpy(ptmpQbuffer, pQbuffer, 1);
-				pACB->rqbuf_firstindex++;
-				pACB->rqbuf_firstindex %= ARCMSR_MAX_QBUFFER;	/*if last index number set it to 0 */
-				ptmpQbuffer++;
-				allxfer_len++;
-			}
-			if (pACB->acb_flags & ACB_F_IOPDATA_OVERFLOW) {
-				struct QBUFFER *prbuffer =
-				    (struct QBUFFER *)&pACB->pmu->ioctl_rbuffer;
-				uint8_t *pQbuffer;
-				uint8_t *iop_data = (uint8_t *) prbuffer->data;
-				int32_t iop_len;
-
-				pACB->acb_flags &= ~ACB_F_IOPDATA_OVERFLOW;
-				iop_len = (int32_t) prbuffer->data_len;
-				/*this iop data does no chance to make me overflow again here, so just do it */
-				while (iop_len > 0) {
-					pQbuffer =
-					    &pACB->rqbuffer[pACB->
-							    rqbuf_lastindex];
-					memcpy(pQbuffer, iop_data, 1);
-					pACB->rqbuf_lastindex++;
-					pACB->rqbuf_lastindex %= ARCMSR_MAX_QBUFFER;	/*if last index number set it to 0 */
-					iop_data++;
-					iop_len--;
-				}
-				writel(ARCMSR_INBOUND_DRIVER_DATA_READ_OK, &pACB->pmu->inbound_doorbell);	/*signature, let IOP331 know data has been readed */
-			}
-			spin_unlock_irqrestore(&pACB->qbuffer_lockunlock, flag);
-			memcpy(pcmdioctlfld->ioctldatabuffer,
-			       (uint8_t *) ver_addr, allxfer_len);
-			pcmdioctlfld->cmdioctl.Length = allxfer_len;
-			pcmdioctlfld->cmdioctl.ReturnCode =
-			    ARCMSR_IOCTL_RETURNCODE_OK;
-			if (copy_to_user
-			    (arg, pcmdioctlfld,
-			     sizeof(struct CMD_IOCTL_FIELD)) != 0) {
-				retvalue = -EFAULT;
-			}
-			pci_free_consistent(pACB->pPCI_DEV, 1032, ver_addr,
-					    buf_handle);
+	{
+		unsigned long flag;
+		unsigned long *ver_addr;
+		dma_addr_t buf_handle;
+		uint8_t *pQbuffer, *ptmpQbuffer;
+		int32_t allxfer_len = 0;
+
+		ver_addr = pci_alloc_consistent(pACB->pPCI_DEV, 1032,
+				 &buf_handle);
+		if (!ver_addr) {
+			retvalue = -ENOMEM;
+			goto ioctl_out;
+		}
+		ptmpQbuffer = (uint8_t *) ver_addr;
+		spin_lock_irqsave(&pACB->qbuffer_lockunlock, flag);
+		while ((pACB->rqbuf_firstindex != pACB->rqbuf_lastindex)
+		       && (allxfer_len < 1031)) {
+			/* copy READ QBUFFER to srb */
+			pQbuffer = &pACB->rqbuffer[pACB->rqbuf_firstindex];
+			memcpy(ptmpQbuffer, pQbuffer, 1);
+			pACB->rqbuf_firstindex++;
+			/* if last index number set it to 0 */
+			pACB->rqbuf_firstindex %= ARCMSR_MAX_QBUFFER;
+			ptmpQbuffer++;
+			allxfer_len++;
 		}
+		if (pACB->acb_flags & ACB_F_IOPDATA_OVERFLOW) {
+			struct QBUFFER *prbuffer =
+			    (struct QBUFFER *)&pACB->pmu->ioctl_rbuffer;
+			uint8_t *pQbuffer;
+			uint8_t *iop_data = (uint8_t *) prbuffer->data;
+			int32_t iop_len;
+
+			pACB->acb_flags &= ~ACB_F_IOPDATA_OVERFLOW;
+			iop_len = (int32_t) prbuffer->data_len;
+			/* this iop data has no chance to make me
+			 * overflow again here, so just do it */
+			while (iop_len > 0) {
+				pQbuffer = &pACB->rqbuffer[pACB->
+						    rqbuf_lastindex];
+				memcpy(pQbuffer, iop_data, 1);
+				pACB->rqbuf_lastindex++;
+				/* if last index number set it to 0 */
+				pACB->rqbuf_lastindex %= ARCMSR_MAX_QBUFFER;
+				iop_data++;
+				iop_len--;
+			}
+			/* signature, let IOP331 know data has been read */
+			writel(ARCMSR_INBOUND_DRIVER_DATA_READ_OK,
+				&pACB->pmu->inbound_doorbell);
+		}
+		spin_unlock_irqrestore(&pACB->qbuffer_lockunlock, flag);
+		memcpy(pcmdioctlfld->ioctldatabuffer,
+		       (uint8_t *) ver_addr, allxfer_len);
+		pcmdioctlfld->cmdioctl.Length = allxfer_len;
+		pcmdioctlfld->cmdioctl.ReturnCode = ARCMSR_IOCTL_RETURNCODE_OK;
+		if (copy_to_user(arg, pcmdioctlfld,
+		     sizeof(struct CMD_IOCTL_FIELD)))
+			retvalue = -EFAULT;
+		pci_free_consistent(pACB->pPCI_DEV, 1032, ver_addr, buf_handle);
 		break;
+	}
 	case ARCMSR_IOCTL_WRITE_WQBUFFER:
-		{
-			unsigned long flag;
-			unsigned long *ver_addr;
-			dma_addr_t buf_handle;
-			int32_t my_empty_len, user_len, wqbuf_firstindex,
-			    wqbuf_lastindex;
-			uint8_t *pQbuffer, *ptmpuserbuffer;
-
-			ver_addr =
-			    pci_alloc_consistent(pACB->pPCI_DEV, 1032,
-						 &buf_handle);
-			if (ver_addr == NULL) {
-				retvalue = -ENOMEM;
-				goto ioctl_out;
-			}
-			ptmpuserbuffer = (uint8_t *) ver_addr;
-			user_len = pcmdioctlfld->cmdioctl.Length;
-			memcpy(ptmpuserbuffer, pcmdioctlfld->ioctldatabuffer,
-			       user_len);
-			/*check if data xfer length of this request will overflow my array qbuffer */
-			spin_lock_irqsave(&pACB->qbuffer_lockunlock, flag);
-			wqbuf_lastindex = pACB->wqbuf_lastindex;
-			wqbuf_firstindex = pACB->wqbuf_firstindex;
-			my_empty_len =
-			    (wqbuf_firstindex - wqbuf_lastindex -
-			     1) & (ARCMSR_MAX_QBUFFER - 1);
-			if (my_empty_len >= user_len) {
-				while (user_len > 0) {
-					/*copy srb data to wqbuffer */
-					pQbuffer =
-					    &pACB->wqbuffer[pACB->
-							    wqbuf_lastindex];
-					memcpy(pQbuffer, ptmpuserbuffer, 1);
-					pACB->wqbuf_lastindex++;
-					pACB->wqbuf_lastindex %= ARCMSR_MAX_QBUFFER;	/*if last index number set it to 0 */
-					ptmpuserbuffer++;
-					user_len--;
-				}
-				/*post fist Qbuffer */
-				if (pACB->
-				    acb_flags & ACB_F_IOCTL_WQBUFFER_CLEARED) {
-					pACB->acb_flags &=
-					    ~ACB_F_IOCTL_WQBUFFER_CLEARED;
-					arcmsr_post_Qbuffer(pACB);
-				}
-				pcmdioctlfld->cmdioctl.ReturnCode =
-				    ARCMSR_IOCTL_RETURNCODE_OK;
-			} else {
-				pcmdioctlfld->cmdioctl.ReturnCode =
-				    ARCMSR_IOCTL_RETURNCODE_ERROR;
+	{
+		unsigned long flag;
+		unsigned long *ver_addr;
+		dma_addr_t buf_handle;
+		int32_t my_empty_len, user_len, wqbuf_firstindex,
+		    wqbuf_lastindex;
+		uint8_t *pQbuffer, *ptmpuserbuffer;
+
+		ver_addr = pci_alloc_consistent(pACB->pPCI_DEV, 1032,
+					 &buf_handle);
+		if (ver_addr == NULL) {
+			retvalue = -ENOMEM;
+			goto ioctl_out;
+		}
+		ptmpuserbuffer = (uint8_t *) ver_addr;
+		user_len = pcmdioctlfld->cmdioctl.Length;
+		memcpy(ptmpuserbuffer, pcmdioctlfld->ioctldatabuffer,
+		       user_len);
+		/* check if data xfer length of this request will
+		 * overflow my array qbuffer */
+		spin_lock_irqsave(&pACB->qbuffer_lockunlock, flag);
+		wqbuf_lastindex = pACB->wqbuf_lastindex;
+		wqbuf_firstindex = pACB->wqbuf_firstindex;
+		my_empty_len = (wqbuf_firstindex - wqbuf_lastindex - 1) &
+				(ARCMSR_MAX_QBUFFER - 1);
+		if (my_empty_len >= user_len) {
+			while (user_len > 0) {
+				/* copy srb data to wqbuffer */
+				pQbuffer = &pACB->wqbuffer[pACB->
+						    wqbuf_lastindex];
+				memcpy(pQbuffer, ptmpuserbuffer, 1);
+				pACB->wqbuf_lastindex++;
+				/* if last index number set it to 0 */
+				pACB->wqbuf_lastindex %= ARCMSR_MAX_QBUFFER;
+				ptmpuserbuffer++;
+				user_len--;
+			}
+			/* post first Qbuffer */
+			if (pACB->acb_flags & ACB_F_IOCTL_WQBUFFER_CLEARED) {
+				pACB->acb_flags &=
+				    ~ACB_F_IOCTL_WQBUFFER_CLEARED;
+				arcmsr_post_Qbuffer(pACB);
 			}
-			spin_unlock_irqrestore(&pACB->qbuffer_lockunlock, flag);
-			if (copy_to_user
-			    (arg, pcmdioctlfld,
-			     sizeof(struct CMD_IOCTL_FIELD)) != 0) {
-				retvalue = -EFAULT;
-			}
-			pci_free_consistent(pACB->pPCI_DEV, 1032, ver_addr,
-					    buf_handle);
-		}
-		break;
-	case ARCMSR_IOCTL_CLEAR_RQBUFFER:
-		{
-			unsigned long flag;
-			uint8_t *pQbuffer = pACB->rqbuffer;
-
-			if (pACB->acb_flags & ACB_F_IOPDATA_OVERFLOW) {
-				pACB->acb_flags &= ~ACB_F_IOPDATA_OVERFLOW;
-				writel(ARCMSR_INBOUND_DRIVER_DATA_READ_OK, &pACB->pmu->inbound_doorbell);	/*signature, let IOP331 know data has been readed */
-			}
-			pACB->acb_flags |= ACB_F_IOCTL_RQBUFFER_CLEARED;
-			spin_lock_irqsave(&pACB->qbuffer_lockunlock, flag);
-			pACB->rqbuf_firstindex = 0;
-			pACB->rqbuf_lastindex = 0;
-			memset(pQbuffer, 0, ARCMSR_MAX_QBUFFER);
-			spin_unlock_irqrestore(&pACB->qbuffer_lockunlock, flag);
-			/*report success */
 			pcmdioctlfld->cmdioctl.ReturnCode =
 			    ARCMSR_IOCTL_RETURNCODE_OK;
-			if (copy_to_user
-			    (arg, pcmdioctlfld,
-			     sizeof(struct CMD_IOCTL_FIELD)) != 0) {
-				retvalue = -EFAULT;
-			}
-		}
+		} else
+			pcmdioctlfld->cmdioctl.ReturnCode =
+					ARCMSR_IOCTL_RETURNCODE_ERROR;
+		spin_unlock_irqrestore(&pACB->qbuffer_lockunlock, flag);
+		if (copy_to_user(arg, pcmdioctlfld,
+		     sizeof(struct CMD_IOCTL_FIELD)))
+			retvalue = -EFAULT;
+		pci_free_consistent(pACB->pPCI_DEV, 1032, ver_addr,
+				    buf_handle);
 		break;
+	}
+	case ARCMSR_IOCTL_CLEAR_RQBUFFER:
+	{
+		unsigned long flag;
+		uint8_t *pQbuffer = pACB->rqbuffer;
+
+		if (pACB->acb_flags & ACB_F_IOPDATA_OVERFLOW) {
+			pACB->acb_flags &= ~ACB_F_IOPDATA_OVERFLOW;
+			/* signature, let IOP331 know data has been read */
+			writel(ARCMSR_INBOUND_DRIVER_DATA_READ_OK,
+				&pACB->pmu->inbound_doorbell);
+		}
+		pACB->acb_flags |= ACB_F_IOCTL_RQBUFFER_CLEARED;
+		spin_lock_irqsave(&pACB->qbuffer_lockunlock, flag);
+		pACB->rqbuf_firstindex = 0;
+		pACB->rqbuf_lastindex = 0;
+		memset(pQbuffer, 0, ARCMSR_MAX_QBUFFER);
+		spin_unlock_irqrestore(&pACB->qbuffer_lockunlock, flag);
+		/* report success */
+		pcmdioctlfld->cmdioctl.ReturnCode = ARCMSR_IOCTL_RETURNCODE_OK;
+		if (copy_to_user(arg, pcmdioctlfld,
+		     sizeof(struct CMD_IOCTL_FIELD)))
+			retvalue = -EFAULT;
+		break;
+	}
 	case ARCMSR_IOCTL_CLEAR_WQBUFFER:
-		{
-			unsigned long flag;
-			uint8_t *pQbuffer = pACB->wqbuffer;
-
-			if (pACB->acb_flags & ACB_F_IOPDATA_OVERFLOW) {
-				pACB->acb_flags &= ~ACB_F_IOPDATA_OVERFLOW;
-				writel(ARCMSR_INBOUND_DRIVER_DATA_READ_OK, &pACB->pmu->inbound_doorbell);	/*signature, let IOP331 know data has been readed */
-			}
-			pACB->acb_flags |= ACB_F_IOCTL_WQBUFFER_CLEARED;
-			spin_lock_irqsave(&pACB->qbuffer_lockunlock, flag);
-			pACB->wqbuf_firstindex = 0;
-			pACB->wqbuf_lastindex = 0;
-			memset(pQbuffer, 0, ARCMSR_MAX_QBUFFER);
-			spin_unlock_irqrestore(&pACB->qbuffer_lockunlock, flag);
-			/*report success */
-			pcmdioctlfld->cmdioctl.ReturnCode =
-			    ARCMSR_IOCTL_RETURNCODE_OK;
-			if (copy_to_user
-			    (arg, pcmdioctlfld,
-			     sizeof(struct CMD_IOCTL_FIELD)) != 0) {
-				retvalue = -EFAULT;
-			}
-		}
+	{
+		unsigned long flag;
+		uint8_t *pQbuffer = pACB->wqbuffer;
+
+		if (pACB->acb_flags & ACB_F_IOPDATA_OVERFLOW) {
+			pACB->acb_flags &= ~ACB_F_IOPDATA_OVERFLOW;
+			/* signature, let IOP331 know data has been read */
+			writel(ARCMSR_INBOUND_DRIVER_DATA_READ_OK,
+				&pACB->pmu->inbound_doorbell);
+		}
+		pACB->acb_flags |= ACB_F_IOCTL_WQBUFFER_CLEARED;
+		spin_lock_irqsave(&pACB->qbuffer_lockunlock, flag);
+		pACB->wqbuf_firstindex = 0;
+		pACB->wqbuf_lastindex = 0;
+		memset(pQbuffer, 0, ARCMSR_MAX_QBUFFER);
+		spin_unlock_irqrestore(&pACB->qbuffer_lockunlock, flag);
+		/* report success */
+		pcmdioctlfld->cmdioctl.ReturnCode = ARCMSR_IOCTL_RETURNCODE_OK;
+		if (copy_to_user(arg, pcmdioctlfld,
+		     sizeof(struct CMD_IOCTL_FIELD)))
+			retvalue = -EFAULT;
 		break;
+	}
 	case ARCMSR_IOCTL_CLEAR_ALLQBUFFER:
-		{
-			unsigned long flag;
-			uint8_t *pQbuffer;
-
-			if (pACB->acb_flags & ACB_F_IOPDATA_OVERFLOW) {
-				pACB->acb_flags &= ~ACB_F_IOPDATA_OVERFLOW;
-				writel(ARCMSR_INBOUND_DRIVER_DATA_READ_OK, &pACB->pmu->inbound_doorbell);	/*signature, let IOP331 know data has been readed */
-			}
-			pACB->acb_flags |=
-			    (ACB_F_IOCTL_WQBUFFER_CLEARED |
-			     ACB_F_IOCTL_RQBUFFER_CLEARED);
-			spin_lock_irqsave(&pACB->qbuffer_lockunlock, flag);
-			pACB->rqbuf_firstindex = 0;
-			pACB->rqbuf_lastindex = 0;
-			pACB->wqbuf_firstindex = 0;
-			pACB->wqbuf_lastindex = 0;
-			pQbuffer = pACB->rqbuffer;
-			memset(pQbuffer, 0, sizeof(struct QBUFFER));
-			pQbuffer = pACB->wqbuffer;
-			memset(pQbuffer, 0, sizeof(struct QBUFFER));
-			spin_unlock_irqrestore(&pACB->qbuffer_lockunlock, flag);
-			/*report success */
-			pcmdioctlfld->cmdioctl.ReturnCode =
-			    ARCMSR_IOCTL_RETURNCODE_OK;
-			if (copy_to_user
-			    (arg, pcmdioctlfld,
-			     sizeof(struct CMD_IOCTL_FIELD)) != 0) {
-				retvalue = -EFAULT;
-			}
-		}
+	{
+		unsigned long flag;
+		uint8_t *pQbuffer;
+
+		if (pACB->acb_flags & ACB_F_IOPDATA_OVERFLOW) {
+			pACB->acb_flags &= ~ACB_F_IOPDATA_OVERFLOW;
+			/* signature, let IOP331 know data has been read */
+			writel(ARCMSR_INBOUND_DRIVER_DATA_READ_OK,
+				&pACB->pmu->inbound_doorbell);
+		}
+		pACB->acb_flags |= (ACB_F_IOCTL_WQBUFFER_CLEARED |
+				ACB_F_IOCTL_RQBUFFER_CLEARED);
+		spin_lock_irqsave(&pACB->qbuffer_lockunlock, flag);
+		pACB->rqbuf_firstindex = 0;
+		pACB->rqbuf_lastindex = 0;
+		pACB->wqbuf_firstindex = 0;
+		pACB->wqbuf_lastindex = 0;
+		pQbuffer = pACB->rqbuffer;
+		memset(pQbuffer, 0, sizeof(struct QBUFFER));
+		pQbuffer = pACB->wqbuffer;
+		memset(pQbuffer, 0, sizeof(struct QBUFFER));
+		spin_unlock_irqrestore(&pACB->qbuffer_lockunlock, flag);
+		/* report success */
+		pcmdioctlfld->cmdioctl.ReturnCode = ARCMSR_IOCTL_RETURNCODE_OK;
+		if (copy_to_user(arg, pcmdioctlfld,
+		     sizeof(struct CMD_IOCTL_FIELD)))
+			retvalue = -EFAULT;
 		break;
+	}
 	case ARCMSR_IOCTL_RETURN_CODE_3F:
-		{
-			pcmdioctlfld->cmdioctl.ReturnCode =
-			    ARCMSR_IOCTL_RETURNCODE_3F;
-			if (copy_to_user
-			    (arg, pcmdioctlfld,
-			     sizeof(struct CMD_IOCTL_FIELD)) != 0) {
-				retvalue = -EFAULT;
-			}
-		}
+		pcmdioctlfld->cmdioctl.ReturnCode = ARCMSR_IOCTL_RETURNCODE_3F;
+		if (copy_to_user(arg, pcmdioctlfld,
+		     sizeof(struct CMD_IOCTL_FIELD)))
+			retvalue = -EFAULT;
 		break;
 	case ARCMSR_IOCTL_SAY_HELLO:
-		{
-			int8_t *hello_string = "Hello! I am ARCMSR";
+	{
+		int8_t *hello_string = "Hello! I am ARCMSR";
 
-			memcpy(pcmdioctlfld->ioctldatabuffer, hello_string,
-			       (int16_t) strlen(hello_string));
-			pcmdioctlfld->cmdioctl.ReturnCode =
-			    ARCMSR_IOCTL_RETURNCODE_OK;
-			if (copy_to_user
-			    (arg, pcmdioctlfld,
-			     sizeof(struct CMD_IOCTL_FIELD)) != 0) {
-				retvalue = -EFAULT;
-			}
-		}
+		memcpy(pcmdioctlfld->ioctldatabuffer, hello_string,
+		       (int16_t) strlen(hello_string));
+		pcmdioctlfld->cmdioctl.ReturnCode = ARCMSR_IOCTL_RETURNCODE_OK;
+		if (copy_to_user(arg, pcmdioctlfld,
+		     sizeof(struct CMD_IOCTL_FIELD)))
+			retvalue = -EFAULT;
 		break;
+	}
 	case ARCMSR_IOCTL_SAY_GOODBYE:
-		{
-			arcmsr_iop_parking(pACB);
-		}
+		arcmsr_iop_parking(pACB);
 		break;
 	case ARCMSR_IOCTL_FLUSH_ADAPTER_CACHE:
-		{
-			arcmsr_flush_adapter_cache(pACB);
-			if (arcmsr_wait_msgint_ready(pACB)) {
-				printk
-				    ("arcmsr%d ioctl flush cache wait 'flush adapter cache' timeout \n",
-				     pACB->adapter_index);
-			}
+		arcmsr_flush_adapter_cache(pACB);
+		if (arcmsr_wait_msgint_ready(pACB)) {
+			printk
+			    ("arcmsr%d ioctl flush cache wait 'flush adapter cache' timeout \n",
+			     pACB->adapter_index);
 		}
 		break;
 	default:
 		retvalue = -EFAULT;
 	}
-      ioctl_out:
+ioctl_out:
 	pci_free_consistent(pACB->pPCI_DEV, sizeof(struct CMD_IOCTL_FIELD),
 			    pcmdioctlfld, cmd_handle);
 	return retvalue;
@@ -1516,20 +1533,21 @@ static int arcmsr_iop_ioctlcmd(struct AC
 
 /*
 ************************************************************************
-**  arcmsr_ioctl
+** arcmsr_ioctl
 ** Performs ioctl requests not satified by the upper levels.
 ** copy_from_user(to, from, n)
 ** copy_to_user(to, from, n)
 **
-**  The scsi_device struct contains what we know about each given scsi
-**  device.
+** The scsi_device struct contains what we know about each given scsi device.
 **
 ** FIXME(eric) - one of the great regrets that I have is that I failed to define
-** these structure elements as something like sdev_foo instead of foo.  This would
+** these structure elements as something like sdev_foo instead of foo.
+** This would
 ** make it so much easier to grep through sources and so forth.  I propose that
 ** all new elements that get added to these structures follow this convention.
-** As time goes on and as people have the stomach for it, it should be possible to
-** go back and retrofit at least some of the elements here with with the prefix.
+** As time goes on and as people have the stomach for it, it should be possible
+** to go back and retrofit at least some of the elements here with with the
+** prefix.
 **
 **
 **struct scsi_device {
@@ -1539,60 +1557,60 @@ static int arcmsr_iop_ioctlcmd(struct AC
 **	                                        %% struct private is a way of marking it in a sort of C++ type of way.
 **	                                        %%
 **
-**	struct scsi_device      *next;	                    %% Used for linked list %%
-**	struct scsi_device      *prev;	                    %% Used for linked list %%
-**	wait_queue_head_t       scpnt_wait;	                %% Used to wait if device is busy %%
+**	struct scsi_device      *next;	        %% Used for linked list %%
+**	struct scsi_device      *prev;	        %% Used for linked list %%
+**	wait_queue_head_t       scpnt_wait;	%% Used to wait if device is busy %%
 **	struct Scsi_Host        *host;
 **	request_queue_t         request_queue;
-**  atomic_t                device_active;              %% commands checked out for device %%
-**	volatile unsigned short device_busy;	            %% commands actually active on low-level %%
-**	int (*scsi_init_io_fn)  (struct scsi_cmnd *);	            %% Used to initialize  new request %%
-**	struct scsi_cmnd               *device_queue;	            %% queue of SCSI Command structures %%
+**  atomic_t                device_active;      %% commands checked out for device %%
+**	volatile unsigned short device_busy;	%% commands actually active on low-level %%
+**	int (*scsi_init_io_fn)  (struct scsi_cmnd *); %% Used to initialize  new request %%
+**	struct scsi_cmnd               *device_queue; %% queue of SCSI Command structures %%
 **
 **  %% public: %%
 **
 **	unsigned int            id, lun, channel;
-**	unsigned int            manufacturer;	            %% Manufacturer of device, for using vendor-specific cmd's %%
-**	unsigned                sector_size;	            %% size in bytes %%
-**	int                     attached;		            %% # of high level drivers attached to this %%
-**	int                     access_count;	            %% Count of open channels/mounts %%
-**	void                    *hostdata;		            %% available to low-level driver %%
-**	devfs_handle_t          de;                         %% directory for the device %%
+**	unsigned int            manufacturer;	%% Manufacturer of device, for using vendor-specific cmd's %%
+**	unsigned                sector_size;	%% size in bytes %%
+**	int                     attached;	%% # of high level drivers attached to this %%
+**	int                     access_count;	%% Count of open channels/mounts %%
+**	void                    *hostdata;	%% available to low-level driver %%
+**	devfs_handle_t          de;             %% directory for the device %%
 **	char                    type;
 **	char                    scsi_level;
 **	char                    vendor[8], model[16], rev[4];
-**	unsigned char           current_tag;             	%% current tag %%
-**	unsigned char           sync_min_period;	        %% Not less than this period %%
-**	unsigned char           sync_max_offset;	        %% Not greater than this offset %%
-**	unsigned char           queue_depth;	            %% How deep a queue to use %%
+**	unsigned char           current_tag;    %% current tag %%
+**	unsigned char           sync_min_period; %% Not less than this period %%
+**	unsigned char           sync_max_offset; %% Not greater than this offset %%
+**	unsigned char           queue_depth;	%% How deep a queue to use %%
 **	unsigned                online:1;
 **	unsigned                writeable:1;
 **	unsigned                removable:1;
 **	unsigned                random:1;
 **	unsigned                has_cmdblocks:1;
-**	unsigned                changed:1;	                %% Data invalid due to media change %%
-**	unsigned                busy:1;	                    %% Used to prevent races %%
-**	unsigned                lockable:1;	                %% Able to prevent media removal %%
-**	unsigned                borken:1;	                %% Tell the Seagate driver to be painfully slow on this device %%
-**	unsigned                tagged_supported:1;	        %% Supports SCSI-II tagged queuing %%
-**	unsigned                tagged_queue:1;	            %% SCSI-II tagged queuing enabled %%
-**	unsigned                disconnect:1;	            %% can disconnect %%
-**	unsigned                soft_reset:1;	            %% Uses soft reset option %%
-**	unsigned                sync:1;	                    %% Negotiate for sync transfers %%
-**	unsigned                wide:1;	                    %% Negotiate for WIDE transfers %%
-**	unsigned                single_lun:1;	            %% Indicates we should only allow I/O to one of the luns for the device at a time. %%
-**	unsigned                was_reset:1;	            %% There was a bus reset on the bus for this device %%
-**	unsigned                expecting_cc_ua:1;	        %% Expecting a CHECK_CONDITION/UNIT_ATTN because we did a bus reset. %%
-**	unsigned                device_blocked:1;	        %% Device returned QUEUE_FULL. %%
-**	unsigned                ten:1;		                %% support ten byte read / write %%
-**	unsigned                remap:1;	                %% support remapping  %%
-**	unsigned                starved:1;	                %% unable to process commands because  host busy %%
-**	int                     allow_revalidate;           %% Flag to allow revalidate to succeed in sd_open
+**	unsigned                changed:1;	%% Data invalid due to media change %%
+**	unsigned                busy:1;	        %% Used to prevent races %%
+**	unsigned                lockable:1;	%% Able to prevent media removal %%
+**	unsigned                borken:1;	%% Tell the Seagate driver to be painfully slow on this device %%
+**	unsigned                tagged_supported:1; %% Supports SCSI-II tagged queuing %%
+**	unsigned                tagged_queue:1;	%% SCSI-II tagged queuing enabled %%
+**	unsigned                disconnect:1;	%% can disconnect %%
+**	unsigned                soft_reset:1;	%% Uses soft reset option %%
+**	unsigned                sync:1;	        %% Negotiate for sync transfers %%
+**	unsigned                wide:1;	        %% Negotiate for WIDE transfers %%
+**	unsigned                single_lun:1;	%% Indicates we should only allow I/O to one of the luns for the device at a time. %%
+**	unsigned                was_reset:1;	%% There was a bus reset on the bus for this device %%
+**	unsigned                expecting_cc_ua:1; %% Expecting a CHECK_CONDITION/UNIT_ATTN because we did a bus reset. %%
+**	unsigned                device_blocked:1; %% Device returned QUEUE_FULL. %%
+**	unsigned                ten:1;		%% support ten byte read / write %%
+**	unsigned                remap:1;	%% support remapping  %%
+**	unsigned                starved:1;	%% unable to process commands because  host busy %%
+**	int                     allow_revalidate; %% Flag to allow revalidate to succeed in sd_open
 **};
 **
 ************************************************************************
 */
-static int arcmsr_ioctl(struct scsi_device *dev, int ioctl_cmd, void *arg)
+static int arcmsr_ioctl(struct scsi_device *dev, int ioctl_cmd, void __user *arg)
 {
 	struct ACB *pACB;
 	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
@@ -1610,6 +1628,7 @@ static int arcmsr_ioctl(struct scsi_devi
 		return -ENXIO;
 	if (!arg)
 		return -EINVAL;
+
 	return arcmsr_iop_ioctlcmd(pACB, ioctl_cmd, arg);
 }
 
@@ -1643,10 +1662,10 @@ static struct CCB *arcmsr_get_freeccb(st
 ** struct scsi_cmnd {
 **	int          sc_magic;
 **  // private: //
-**	           //
-**	           // This information is private to the scsi mid-layer. Wrapping it in a
-**	           // struct private is a way of marking it in a sort of C++ type of way.
-**	           //
+**	        //
+**	        // This information is private to the scsi mid-layer. Wrapping it in a
+**	        // struct private is a way of marking it in a sort of C++ type of way.
+**	        //
 **	struct Scsi_Host   *host;
 **	unsigned short    state;
 **	unsigned short    owner;
@@ -1658,19 +1677,19 @@ static struct CCB *arcmsr_get_freeccb(st
 **	int eh_state;		 // Used for state tracking in error handlr
 **	void (*done) (struct scsi_cmnd *);
 **            // Mid-level done function
-**	           //
-**	           // A SCSI Command is assigned a nonzero serial_number when internal_cmnd
-**	           // passes it to the driver's queue command function. The serial_number
-**	           // is cleared when scsi_done is entered indicating that the command has
-**	           // been completed. If a timeout occurs, the serial number at the moment
-**	           // of timeout is copied into serial_number_at_timeout. By subsequently
-**	           // comparing the serial_number and serial_number_at_timeout fields
-**	           // during abort or reset processing, we can detect whether the command
-**	           // has already completed. This also detects cases where the command has
-**	           // completed and the SCSI Command structure has already being reused
-**	           // for another command, so that we can avoid incorrectly aborting or
-**	           // resetting the new command.
-**	           //
+**	      //
+**	      // A SCSI Command is assigned a nonzero serial_number when internal_cmnd
+**	      // passes it to the driver's queue command function. The serial_number
+**	      // is cleared when scsi_done is entered indicating that the command has
+**	      // been completed. If a timeout occurs, the serial number at the moment
+**	      // of timeout is copied into serial_number_at_timeout. By subsequently
+**	      // comparing the serial_number and serial_number_at_timeout fields
+**	      // during abort or reset processing, we can detect whether the command
+**	      // has already completed. This also detects cases where the command has
+**	      // completed and the SCSI Command structure has already being reused
+**	      // for another command, so that we can avoid incorrectly aborting or
+**	      // resetting the new command.
+**	      //
 **
 **	unsigned long     serial_number;
 **	unsigned long     serial_number_at_timeout;
@@ -1681,10 +1700,10 @@ static struct CCB *arcmsr_get_freeccb(st
 **	int          timeout_total;
 **	int          timeout;
 **
-**	           //
-**	           // We handle the timeout differently if it happens when a reset,
-**	           // abort, etc are in process.
-**	           //
+**	      //
+**	      // We handle the timeout differently if it happens when a reset,
+**	      // abort, etc are in process.
+**	      //
 **	unsigned volatile char internal_timeout;
 **	struct scsi_cmnd   *bh_next;
 **            // To enumerate the commands waiting to be processed.
@@ -1698,7 +1717,7 @@ static struct CCB *arcmsr_get_freeccb(st
 **	unsigned char     old_cmd_len;
 **	unsigned char     sc_data_direction;
 **	unsigned char     sc_old_data_direction;
-**	           // These elements define the operation we are about to perform
+**	      // These elements define the operation we are about to perform
 **	unsigned char     cmnd[MAX_COMMAND_SIZE];
 **	unsigned       request_bufflen;
 **            // Actual request size
@@ -1707,7 +1726,7 @@ static struct CCB *arcmsr_get_freeccb(st
 **            // Used to time out the command.
 **	void         *request_buffer;
 **            // Actual requested buffer
-**	           // These elements define the operation we ultimately want to perform
+**	      // These elements define the operation we ultimately want to perform
 **	unsigned char data_cmnd[MAX_COMMAND_SIZE];
 **	unsigned short old_use_sg;
 **            // We save use_sg here when requesting sense info
@@ -1727,7 +1746,7 @@ static struct CCB *arcmsr_get_freeccb(st
 **            // save underflow here when reusing the command for error handling
 **
 **	unsigned transfersize;
-**           	 // How much we are guaranteed to transfer with each SCSI transfer
+**            // How much we are guaranteed to transfer with each SCSI transfer
 **            // (ie, between disconnect/reconnects.  Probably==sector size
 **	int resid;
 **            // Number of bytes requested to be transferred
@@ -1737,26 +1756,26 @@ static struct CCB *arcmsr_get_freeccb(st
 **	unsigned char sense_buffer[SCSI_SENSE_BUFFERSIZE];
 **            // obtained by REQUEST SENSE when CHECK CONDITION is received on original command (auto-sense)
 **	unsigned flags;
-**	           // Used to indicate that a command which has timed out also
-**	           // completed normally. Typically the completion function will
-**	           // do nothing but set this flag in this instance because the
-**	           // timeout handler is already running.
+**	      // Used to indicate that a command which has timed out also
+**	      // completed normally. Typically the completion function will
+**	      // do nothing but set this flag in this instance because the
+**	      // timeout handler is already running.
 **	unsigned done_late:1;
-**	           // Low-level done function - can be used by low-level driver to point
-**	           // to completion function. Not used by mid/upper level code.
+**	      // Low-level done function - can be used by low-level driver to point
+**	      // to completion function. Not used by mid/upper level code.
 **	void (*scsi_done) (struct scsi_cmnd *);
-**	           // The following fields can be written to by the host specific code.
-**	           // Everything else should be left alone.
+**	      // The following fields can be written to by the host specific code.
+**	      // Everything else should be left alone.
 **	Scsi_Pointer SCp;
 **            // Scratchpad used by some host adapters
 **	unsigned char *host_scribble;
 **            // The host adapter is allowed to
-**					   // call scsi_malloc and get some memory
-**					   // and hang it here.   The host adapter
-**					   // is also expected to call scsi_free
-**					   // to release this memory. (The memory
-**					   // obtained by scsi_malloc is guaranteed
-**					   // to be at an address < 16Mb).
+**	      // call scsi_malloc and get some memory
+**	      // and hang it here.   The host adapter
+**	      // is also expected to call scsi_free
+**	      // to release this memory. (The memory
+**	      // obtained by scsi_malloc is guaranteed
+**	      // to be at an address < 16Mb).
 **	int result;
 **            // Status code from lower level driver
 **	unsigned char tag;
@@ -1796,7 +1815,9 @@ static int arcmsr_queue_command(struct s
 	cmd->scsi_done = done;
 	cmd->host_scribble = NULL;
 	cmd->result = 0;
-	if (cmd->cmnd[0] == SYNCHRONIZE_CACHE) {	/* 0x35 avoid synchronizing disk cache cmd after .remove : arcmsr_device_remove (linux bug) */
+	if (cmd->cmnd[0] == SYNCHRONIZE_CACHE) {
+		/* 0x35 avoid synchronizing disk cache cmd after .remove :
+			arcmsr_device_remove (linux bug) */
 		if (pACB->devstate[target][lun] == ARECA_RAID_GONE)
 			cmd->result = (DID_NO_CONNECT << 16);
 		cmd->scsi_done(cmd);
@@ -1827,16 +1848,18 @@ static int arcmsr_queue_command(struct s
 		if (atomic_read(&pACB->ccboutstandingcount) <
 		    ARCMSR_MAX_OUTSTANDING_CMD) {
 			/*
-			 ******************************************************************
-			 ** and we can make sure there were no pending ccb in this duration
-			 ******************************************************************
+			 **************************************************
+			 ** and we can make sure there were no pending ccb
+			 ** in this duration
+			 **************************************************
 			 */
 			arcmsr_post_ccb(pACB, pCCB);
 		} else {
 			/*
-			 ******************************************************************
-			 ** Q of ccbwaitexec will be post out when any outstanding command complete
-			 ******************************************************************
+			 **************************************************
+			 ** Q of ccbwaitexec will be post out when any
+			 ** outstanding command complete
+			 **************************************************
 			 */
 			arcmsr_queue_wait2go_ccb(pACB, pCCB);
 		}
@@ -1895,10 +1918,14 @@ static void arcmsr_get_firmware_spec(str
 		printk
 		    ("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
 	}
-	pACB->firm_request_len = readl(&pACB->pmu->message_rbuffer[1]);	/*firm_request_len,1,04-07 */
-	pACB->firm_numbers_queue = readl(&pACB->pmu->message_rbuffer[2]);	/*firm_numbers_queue,2,08-11 */
-	pACB->firm_sdram_size = readl(&pACB->pmu->message_rbuffer[3]);	/*firm_sdram_size,3,12-15 */
-	pACB->firm_ide_channels = readl(&pACB->pmu->message_rbuffer[4]);	/*firm_ide_channels,4,16-19 */
+	/* firm_request_len,1,04-07 */
+	pACB->firm_request_len = readl(&pACB->pmu->message_rbuffer[1]);
+	/* firm_numbers_queue,2,08-11 */
+	pACB->firm_numbers_queue = readl(&pACB->pmu->message_rbuffer[2]);
+	/* firm_sdram_size,3,12-15 */
+	pACB->firm_sdram_size = readl(&pACB->pmu->message_rbuffer[3]);
+	/* firm_ide_channels,4,16-19 */
+	pACB->firm_ide_channels = readl(&pACB->pmu->message_rbuffer[4]);
 }
 
 /*
@@ -1920,20 +1947,21 @@ static void arcmsr_start_adapter_bgrb(st
 static void arcmsr_polling_ccbdone(struct ACB *pACB, struct CCB *poll_ccb)
 {
 	struct CCB *pCCB;
-	uint32_t flag_ccb, outbound_intstatus, poll_ccb_done = 0, poll_count =
-	    0;
+	uint32_t flag_ccb, outbound_intstatus, poll_ccb_done = 0,
+		poll_count = 0;
 	int id, lun;
 
-      polling_ccb_retry:
+polling_ccb_retry:
 	poll_count++;
 	outbound_intstatus =
 	    readl(&pACB->pmu->outbound_intstatus) & pACB->outbound_int_enable;
-	writel(outbound_intstatus, &pACB->pmu->outbound_intstatus);	/*clear interrupt */
+	/* clear interrupt */
+	writel(outbound_intstatus, &pACB->pmu->outbound_intstatus);
 	while (1) {
 		if ((flag_ccb =
 		     readl(&pACB->pmu->outbound_queueport)) == 0xFFFFFFFF) {
 			if (poll_ccb_done)
-				break;	/*chip FIFO no ccb for completion already */
+				break; /* chip FIFO no ccb for completion already */
 			else {
 				msleep(25);
 				if (poll_count > 100)
@@ -1942,7 +1970,8 @@ static void arcmsr_polling_ccbdone(struc
 			}
 		}
 		/* check if command done with no error */
-		pCCB = (struct CCB *)(pACB->vir2phy_offset + (flag_ccb << 5));	/*frame must be 32 bytes aligned */
+		/* frame must be 32 bytes aligned */
+		pCCB = (struct CCB *)(pACB->vir2phy_offset + (flag_ccb << 5));
 		if ((pCCB->pACB != pACB)
 		    || (pCCB->startdone != ARCMSR_CCB_START)) {
 			if ((pCCB->startdone == ARCMSR_CCB_ABORTED)
@@ -1999,18 +2028,20 @@ static void arcmsr_polling_ccbdone(struc
 				}
 				break;
 			default:
-				/* error occur Q all error ccb to errorccbpending Q */
+				/* error occur Q all error ccb to
+				 * errorccbpending Q */
 				printk
 				    ("arcmsr%d scsi id=%d lun=%d polling and getting command error done, but got unknow DeviceStatus=0x%x \n",
 				     pACB->adapter_index, id, lun,
 				     pCCB->arcmsr_cdb.DeviceStatus);
 				pACB->devstate[id][lun] = ARECA_RAID_GONE;
-				pCCB->pcmd->result = DID_BAD_TARGET << 16;	/*unknow error or crc error just for retry */
+				/* unknown error or crc error just for retry */
+				pCCB->pcmd->result = DID_BAD_TARGET << 16;
 				arcmsr_ccb_complete(pCCB);
 				break;
 			}
 		}
-	}			/*drain reply FIFO */
+	}			/* drain reply FIFO */
 }
 
 /*
@@ -2025,9 +2056,10 @@ static void arcmsr_iop_init(struct ACB *
 	do {
 		firmware_state = readl(&pACB->pmu->outbound_msgaddr1);
 	} while ((firmware_state & ARCMSR_OUTBOUND_MESG1_FIRMWARE_OK) == 0);
-	intmask_org = readl(&pACB->pmu->outbound_intmask);	/*change "disable iop interrupt" to arcmsr_initialize */
+	/* change "disable iop interrupt" to arcmsr_initialize */
+	intmask_org = readl(&pACB->pmu->outbound_intmask);
 	arcmsr_get_firmware_spec(pACB);
-	/*start background rebuild */
+	/* start background rebuild */
 	arcmsr_start_adapter_bgrb(pACB);
 	if (arcmsr_wait_msgint_ready(pACB)) {
 		printk
@@ -2037,11 +2069,13 @@ static void arcmsr_iop_init(struct ACB *
 	/* clear Qbuffer if door bell ringed */
 	outbound_doorbell = readl(&pACB->pmu->outbound_doorbell);
 	if (outbound_doorbell & ARCMSR_OUTBOUND_IOP331_DATA_WRITE_OK) {
-		writel(outbound_doorbell, &pACB->pmu->outbound_doorbell);	/*clear interrupt */
+		/* clear interrupt */
+		writel(outbound_doorbell, &pACB->pmu->outbound_doorbell);
 		writel(ARCMSR_INBOUND_DRIVER_DATA_READ_OK,
 		       &pACB->pmu->inbound_doorbell);
 	}
-	/* enable outbound Post Queue, outbound message0, outbound doorbell Interrupt */
+	/* enable outbound Post Queue, outbound message0, outbound
+	 * doorbell Interrupt */
 	mask =
 	    ~(ARCMSR_MU_OUTBOUND_POSTQUEUE_INTMASKENABLE |
 	      ARCMSR_MU_OUTBOUND_DOORBELL_INTMASKENABLE |
@@ -2077,8 +2111,8 @@ static int arcmsr_bus_reset(struct scsi_
 }
 
 /*
-*****************************************************************************************
-*****************************************************************************************
+***************************************************************************
+***************************************************************************
 */
 static int arcmsr_seek_cmd2abort(struct scsi_cmnd *pabortcmd)
 {
@@ -2089,13 +2123,14 @@ static int arcmsr_seek_cmd2abort(struct 
 
 	pACB->num_aborts++;
 	/*
-	 *****************************************************************************
-	 ** It is the upper layer do abort command this lock just prior to calling us.
+	 ******************************************************************
+	 ** It is the upper layer do abort command this lock just prior to
+	 ** calling us.
 	 ** First determine if we currently own this command.
 	 ** Start by searching the device queue. If not found
 	 ** at all, and the system wanted us to just abort the
 	 ** command return success.
-	 *****************************************************************************
+	 ******************************************************************
 	 */
 	if (atomic_read(&pACB->ccboutstandingcount) != 0) {
 		for (i = 0; i < ARCMSR_MAX_FREECCB_NUM; i++) {
@@ -2140,7 +2175,8 @@ static int arcmsr_seek_cmd2abort(struct 
 		}
 	}
 	return SUCCESS;
-      abort_outstanding_cmd:
+
+abort_outstanding_cmd:
 	/* disable all outbound interrupt */
 	intmask_org = readl(&pACB->pmu->outbound_intmask);
 	writel(intmask_org | ARCMSR_MU_OUTBOUND_ALL_INTMASKENABLE,
@@ -2158,8 +2194,8 @@ static int arcmsr_seek_cmd2abort(struct 
 }
 
 /*
-*****************************************************************************************
-*****************************************************************************************
+***************************************************************************
+***************************************************************************
 */
 static int arcmsr_cmd_abort(struct scsi_cmnd *cmd)
 {
@@ -2185,46 +2221,46 @@ static int arcmsr_cmd_abort(struct scsi_
 *********************************************************************
 ** arcmsr_info()
 **struct pci_dev {
-**	struct list_head      global_list;		## node in list of all PCI devices ##
+**	struct list_head      global_list;	## node in list of all PCI devices ##
 **	struct list_head      bus_list;	    	## node in per-bus list ##
-**	struct pci_bus	      *bus;		    	## bus this device is on ##
-**	struct pci_bus	      *subordinate;		## bus this device bridges to ##
-**	void		          *sysdata;	    	## hook for sys-specific extension ##
+**	struct pci_bus	      *bus;	    	## bus this device is on ##
+**	struct pci_bus	      *subordinate;	## bus this device bridges to ##
+**	void		          *sysdata;    	## hook for sys-specific extension ##
 **	struct proc_dir_entry *procent;	        ## device entry in /proc/bus/pci ##
-**	unsigned int	      devfn;		    ## encoded device & function index ##
+**	unsigned int	      devfn;	        ## encoded device & function index ##
 **	unsigned short	      vendor;
 **	unsigned short	      device;
 **	unsigned short	      subsystem_vendor;
 **	unsigned short	      subsystem_device;
-**	unsigned int	      class;		    ## 3 bytes: (base,sub,prog-if) ##
-**	u8		              hdr_type;	        ## PCI header type (`multi' flag masked out) ##
-**	u8		              rom_base_reg;	    ## which config register controls the ROM ##
+**	unsigned int	      class;		## 3 bytes: (base,sub,prog-if) ##
+**	u8		              hdr_type;	## PCI header type (`multi' flag masked out) ##
+**	u8		              rom_base_reg; ## which config register controls the ROM ##
 **
 **	struct pci_driver    *driver;	        ## which driver has allocated this device ##
-**	void		         *driver_data;	    ## data private to the driver ##
-**	u64		              dma_mask;	        ## Mask of the bits of bus address this device implements.  Normally this is
-**					                        ## 0xffffffff.  You only need to change this if your device has broken DMA
-**					                        ## or supports 64-bit transfers.
+**	void		         *driver_data;	## data private to the driver ##
+**	u64		              dma_mask;	## Mask of the bits of bus address this device implements.  Normally this is
+**					        ## 0xffffffff.  You only need to change this if your device has broken DMA
+**					        ## or supports 64-bit transfers.
 **	u32                   current_state;    ## Current operating state. In ACPI-speak, this is D0-D3, D0 being fully functional, and D3 being off. ##
 **	unsigned short vendor_compatible[DEVICE_COUNT_COMPATIBLE]; ## device is compatible with these IDs ##
 **	unsigned short device_compatible[DEVICE_COUNT_COMPATIBLE];
-**	 										##
-**	 										##Instead of touching interrupt line and base address registers
-**	 										##directly, use the values stored here. They might be different!
-**	 										##
+**	 		##
+**	##Instead of touching interrupt line and base address registers
+**	##directly, use the values stored here. They might be different!
+**			##
 **	unsigned int	      irq;
 **	struct resource       resource[DEVICE_COUNT_RESOURCE]; ## I/O and memory regions + expansion ROMs ##
 **	struct resource       dma_resource[DEVICE_COUNT_DMA];
 **	struct resource       irq_resource[DEVICE_COUNT_IRQ];
-**	char		          name[90];	                       ## device name ##
-**	char		          slot_name[8];	                   ## slot name ##
-**	u32		              saved_state[16];                 ## for saving the config space before suspend ##
-**	int		              active;		                   ## ISAPnP: device is active ##
-**	int		              ro;		                       ## ISAPnP: read only ##
-**	unsigned short	      regs;		                       ## ISAPnP: supported registers ##
-**	                                                       ## These fields are used by common fixups ##
-**	unsigned short	      transparent:1;	               ## Transparent PCI bridge ##
-**	int (*prepare)(struct pci_dev *dev);	               ## ISAPnP hooks ##
+**	char		          name[90];     ## device name ##
+**	char		          slot_name[8];	## slot name ##
+**	u32		              saved_state[16]; ## for saving the config space before suspend ##
+**	int		              active;	## ISAPnP: device is active ##
+**	int		              ro;	## ISAPnP: read only ##
+**	unsigned short	      regs;		## ISAPnP: supported registers ##
+**	                                        ## These fields are used by common fixups ##
+**	unsigned short	      transparent:1;	## Transparent PCI bridge ##
+**	int (*prepare)(struct pci_dev *dev);	## ISAPnP hooks ##
 **	int (*activate)(struct pci_dev *dev);
 **	int (*deactivate)(struct pci_dev *dev);
 **};
@@ -2239,77 +2275,58 @@ static const char *arcmsr_info(struct Sc
 
 	pACB = (struct ACB *)host->hostdata;
 	device_id = pACB->pPCI_DEV->device;
+
 	switch (device_id) {
 	case PCIDeviceIDARC1110:
-		{
-			sprintf(buf,
-				"ARECA ARC1110 PCI-X 4 PORTS SATA RAID CONTROLLER\n        %s",
-				ARCMSR_DRIVER_VERSION);
-			break;
-		}
+		sprintf(buf,
+			"ARECA ARC1110 PCI-X 4 PORTS SATA RAID CONTROLLER\n        %s",
+			ARCMSR_DRIVER_VERSION);
+		break;
 	case PCIDeviceIDARC1120:
-		{
-			sprintf(buf,
-				"ARECA ARC1120 PCI-X 8 PORTS SATA RAID CONTROLLER (RAID6-ENGINE Inside)\n        %s",
-				ARCMSR_DRIVER_VERSION);
-			break;
-		}
+		sprintf(buf,
+			"ARECA ARC1120 PCI-X 8 PORTS SATA RAID CONTROLLER (RAID6-ENGINE Inside)\n        %s",
+			ARCMSR_DRIVER_VERSION);
+		break;
 	case PCIDeviceIDARC1130:
-		{
-			sprintf(buf,
-				"ARECA ARC1130 PCI-X 12 PORTS SATA RAID CONTROLLER (RAID6-ENGINE Inside)\n        %s",
-				ARCMSR_DRIVER_VERSION);
-			break;
-		}
+		sprintf(buf,
+			"ARECA ARC1130 PCI-X 12 PORTS SATA RAID CONTROLLER (RAID6-ENGINE Inside)\n        %s",
+			ARCMSR_DRIVER_VERSION);
+		break;
 	case PCIDeviceIDARC1160:
-		{
-			sprintf(buf,
-				"ARECA ARC1160 PCI-X 16 PORTS SATA RAID CONTROLLER (RAID6-ENGINE Inside)\n        %s",
-				ARCMSR_DRIVER_VERSION);
-			break;
-		}
+		sprintf(buf,
+			"ARECA ARC1160 PCI-X 16 PORTS SATA RAID CONTROLLER (RAID6-ENGINE Inside)\n        %s",
+			ARCMSR_DRIVER_VERSION);
+		break;
 	case PCIDeviceIDARC1170:
-		{
-			sprintf(buf,
-				"ARECA ARC1170 PCI-X 24 PORTS SATA RAID CONTROLLER (RAID6-ENGINE Inside)\n        %s",
-				ARCMSR_DRIVER_VERSION);
-			break;
-		}
+		sprintf(buf,
+			"ARECA ARC1170 PCI-X 24 PORTS SATA RAID CONTROLLER (RAID6-ENGINE Inside)\n        %s",
+			ARCMSR_DRIVER_VERSION);
+		break;
 	case PCIDeviceIDARC1210:
-		{
-			sprintf(buf,
-				"ARECA ARC1210 PCI-EXPRESS 4 PORTS SATA RAID CONTROLLER\n        %s",
-				ARCMSR_DRIVER_VERSION);
-			break;
-		}
+		sprintf(buf,
+			"ARECA ARC1210 PCI-EXPRESS 4 PORTS SATA RAID CONTROLLER\n        %s",
+			ARCMSR_DRIVER_VERSION);
+		break;
 	case PCIDeviceIDARC1220:
-		{
-			sprintf(buf,
-				"ARECA ARC1220 PCI-EXPRESS 8 PORTS SATA RAID CONTROLLER (RAID6-ENGINE Inside)\n        %s",
-				ARCMSR_DRIVER_VERSION);
-			break;
-		}
+		sprintf(buf,
+			"ARECA ARC1220 PCI-EXPRESS 8 PORTS SATA RAID CONTROLLER (RAID6-ENGINE Inside)\n        %s",
+			ARCMSR_DRIVER_VERSION);
+		break;
 	case PCIDeviceIDARC1230:
-		{
-			sprintf(buf,
-				"ARECA ARC1230 PCI-EXPRESS 12 PORTS SATA RAID CONTROLLER (RAID6-ENGINE Inside)\n        %s",
-				ARCMSR_DRIVER_VERSION);
-			break;
-		}
+		sprintf(buf,
+			"ARECA ARC1230 PCI-EXPRESS 12 PORTS SATA RAID CONTROLLER (RAID6-ENGINE Inside)\n        %s",
+			ARCMSR_DRIVER_VERSION);
+		break;
 	case PCIDeviceIDARC1260:
-		{
-			sprintf(buf,
-				"ARECA ARC1260 PCI-EXPRESS 16 PORTS SATA RAID CONTROLLER (RAID6-ENGINE Inside)\n        %s",
-				ARCMSR_DRIVER_VERSION);
-			break;
-		}
+		sprintf(buf,
+			"ARECA ARC1260 PCI-EXPRESS 16 PORTS SATA RAID CONTROLLER (RAID6-ENGINE Inside)\n        %s",
+			ARCMSR_DRIVER_VERSION);
+		break;
 	case PCIDeviceIDARC1270:
-		{
-			sprintf(buf,
-				"ARECA ARC1270 PCI-EXPRESS 24 PORTS SATA RAID CONTROLLER (RAID6-ENGINE Inside)\n        %s",
-				ARCMSR_DRIVER_VERSION);
-			break;
-		}
+		sprintf(buf,
+			"ARECA ARC1270 PCI-EXPRESS 24 PORTS SATA RAID CONTROLLER (RAID6-ENGINE Inside)\n        %s",
+			ARCMSR_DRIVER_VERSION);
+		break;
 	}
 	return buf;
 }
@@ -2349,7 +2366,7 @@ static int arcmsr_initialize(struct ACB 
 	pACB->acb_flags &= ~ACB_F_SCSISTOPADAPTER;
 	pACB->irq = pPCI_DEV->irq;
 	/*
-	 *******************************************************************************
+	 ******************************************************************
 	 **                 Allocate the PCCB memory
 	 ******************************************************
 	 **   Using large dma-coherent buffers
@@ -2396,7 +2413,8 @@ static int arcmsr_initialize(struct ACB 
 	pACB->dma_coherent_handle = dma_coherent_handle;
 	memset(dma_coherent, 0,
 	       ARCMSR_MAX_FREECCB_NUM * sizeof(struct CCB) + 0x20);
-	if (((unsigned long)dma_coherent & 0x1F) != 0) {	/*ccb address must 32 (0x20) boundary */
+	if (((unsigned long)dma_coherent & 0x1F) != 0) {
+		/* ccb address must 32 (0x20) boundary */
 		dma_coherent =
 		    dma_coherent + (0x20 -
 				    ((unsigned long)dma_coherent & 0x1F));
@@ -2494,7 +2512,7 @@ static void arcmsr_pcidev_disattach(stru
 			    ("arcmsr%d pcidev disattach wait 'abort all outstanding command' timeout \n",
 			     pACB->adapter_index);
 		}
-		/*clear all outbound posted Q */
+		/* clear all outbound posted Q */
 		for (i = 0; i < ARCMSR_MAX_OUTSTANDING_CMD; i++) {
 			readl(&pACB->pmu->outbound_queueport);
 		}
@@ -2511,7 +2529,8 @@ static void arcmsr_pcidev_disattach(stru
 		writel(intmask_org & mask, &pACB->pmu->outbound_intmask);
 		atomic_set(&pACB->ccboutstandingcount, 0);
 	}
-	if (atomic_read(&pACB->ccbwait2gocount) != 0) {	/*remove first wait2go ccb and abort it */
+	if (atomic_read(&pACB->ccbwait2gocount) != 0) {
+		/* remove first wait2go ccb and abort it */
 		for (i = 0; i < ARCMSR_MAX_OUTSTANDING_CMD; i++) {
 			pCCB = pACB->pccbwait2go[i];
 			if (pCCB) {
@@ -2544,9 +2563,9 @@ static int arcmsr_halt_notify(struct not
 	int i;
 
 	if ((event != SYS_RESTART) && (event != SYS_HALT)
-	    && (event != SYS_POWER_OFF)) {
+	    && (event != SYS_POWER_OFF))
 		return NOTIFY_DONE;
-	}
+
 	for (i = 0; i < ARCMSR_MAX_ADAPTER; i++) {
 		pACB = pHCBARC->pACB[i];
 		if (!pACB)
@@ -2631,7 +2650,7 @@ static int arcmsr_release(struct Scsi_Ho
 	/* Issue a blocking(interrupts disabled) command to the card */
 	arcmsr_pcidev_disattach(pACB);
 	scsi_unregister(host);
-	/*if this is last pACB */
+	/* if this is last pACB */
 	for (i = 0; i < ARCMSR_MAX_ADAPTER; i++) {
 		if (pHCBARC->pACB[i])
 			return 0;	/* this is not last adapter's release */
