Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263979AbTCUW0u>; Fri, 21 Mar 2003 17:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263684AbTCUSLN>; Fri, 21 Mar 2003 13:11:13 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35971
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263672AbTCUSI2>; Fri, 21 Mar 2003 13:08:28 -0500
Date: Fri, 21 Mar 2003 19:23:41 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211923.h2LJNfV4025729@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove ifs from ancient backcompat in mwave driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also add warning about a broken spinlock/sleep someone still has to fix

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/mwave/mwavedd.c linux-2.5.65-ac2/drivers/char/mwave/mwavedd.c
--- linux-2.5.65/drivers/char/mwave/mwavedd.c	2003-02-10 18:38:11.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/mwave/mwavedd.c	2003-03-07 14:30:52.000000000 +0000
@@ -53,46 +53,20 @@
 #include <linux/init.h>
 #include <linux/major.h>
 #include <linux/miscdevice.h>
-#include <linux/proc_fs.h>
+#include <linux/device.h>
 #include <linux/serial.h>
 #include <linux/sched.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 #include <linux/spinlock.h>
-#else
-#include <asm/spinlock.h>
-#endif
 #include <linux/delay.h>
 #include "smapi.h"
 #include "mwavedd.h"
 #include "3780i.h"
 #include "tp3780i.h"
 
-#ifndef __exit
-#define __exit
-#endif
-
 MODULE_DESCRIPTION("3780i Advanced Communications Processor (Mwave) driver");
 MODULE_AUTHOR("Mike Sullivan and Paul Schroeder");
 MODULE_LICENSE("GPL");
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
-static int mwave_get_info(char *buf, char **start, off_t offset, int len);
-#else
-static int mwave_read_proc(char *buf, char **start, off_t offset, int xlen, int unused);
-static struct proc_dir_entry mwave_proc = {
-	0,                      /* unsigned short low_ino */
-	5,                      /* unsigned short namelen */
-	"mwave",                /* const char *name */
-	S_IFREG | S_IRUGO,      /* mode_t mode */
-	1,                      /* nlink_t nlink */
-	0,                      /* uid_t uid */
-	0,                      /* gid_t gid */
-	0,                      /* unsigned long size */
-	NULL,                   /* struct inode_operations *ops */
-	&mwave_read_proc        /* int (*get_info) (...) */
-};
-#endif
-
 /*
 * These parameters support the setting of MWave resources. Note that no
 * checks are made against other devices (ie. superio) for conflicts.
@@ -157,19 +131,23 @@
 
 		case IOCTL_MW_RESET:
 			PRINTK_1(TRACE_MWAVE,
-				"mwavedd::mwave_ioctl, IOCTL_MW_RESET calling tp3780I_ResetDSP\n");
+				"mwavedd::mwave_ioctl, IOCTL_MW_RESET"
+				" calling tp3780I_ResetDSP\n");
 			retval = tp3780I_ResetDSP(&pDrvData->rBDData);
 			PRINTK_2(TRACE_MWAVE,
-				"mwavedd::mwave_ioctl, IOCTL_MW_RESET retval %x from tp3780I_ResetDSP\n",
+				"mwavedd::mwave_ioctl, IOCTL_MW_RESET"
+				" retval %x from tp3780I_ResetDSP\n",
 				retval);
 			break;
 	
 		case IOCTL_MW_RUN:
 			PRINTK_1(TRACE_MWAVE,
-				"mwavedd::mwave_ioctl, IOCTL_MW_RUN calling tp3780I_StartDSP\n");
+				"mwavedd::mwave_ioctl, IOCTL_MW_RUN"
+				" calling tp3780I_StartDSP\n");
 			retval = tp3780I_StartDSP(&pDrvData->rBDData);
 			PRINTK_2(TRACE_MWAVE,
-				"mwavedd::mwave_ioctl, IOCTL_MW_RUN retval %x from tp3780I_StartDSP\n",
+				"mwavedd::mwave_ioctl, IOCTL_MW_RUN"
+				" retval %x from tp3780I_StartDSP\n",
 				retval);
 			break;
 	
@@ -177,17 +155,24 @@
 			MW_ABILITIES rAbilities;
 	
 			PRINTK_1(TRACE_MWAVE,
-				"mwavedd::mwave_ioctl, IOCTL_MW_DSP_ABILITIES calling tp3780I_QueryAbilities\n");
-			retval = tp3780I_QueryAbilities(&pDrvData->rBDData, &rAbilities);
+				"mwavedd::mwave_ioctl,"
+				" IOCTL_MW_DSP_ABILITIES calling"
+				" tp3780I_QueryAbilities\n");
+			retval = tp3780I_QueryAbilities(&pDrvData->rBDData,
+					&rAbilities);
 			PRINTK_2(TRACE_MWAVE,
-				"mwavedd::mwave_ioctl, IOCTL_MW_DSP_ABILITIES retval %x from tp3780I_QueryAbilities\n",
+				"mwavedd::mwave_ioctl, IOCTL_MW_DSP_ABILITIES"
+				" retval %x from tp3780I_QueryAbilities\n",
 				retval);
 			if (retval == 0) {
-				if( copy_to_user((char *) ioarg, (char *) &rAbilities, sizeof(MW_ABILITIES)) )
+				if( copy_to_user((char *) ioarg,
+							(char *) &rAbilities,
+							sizeof(MW_ABILITIES)) )
 					return -EFAULT;
 			}
 			PRINTK_2(TRACE_MWAVE,
-				"mwavedd::mwave_ioctl, IOCTL_MW_DSP_ABILITIES exit retval %x\n",
+				"mwavedd::mwave_ioctl, IOCTL_MW_DSP_ABILITIES"
+				" exit retval %x\n",
 				retval);
 		}
 			break;
@@ -197,15 +182,21 @@
 			MW_READWRITE rReadData;
 			unsigned short *pusBuffer = 0;
 	
-			if( copy_from_user((char *) &rReadData, (char *) ioarg, sizeof(MW_READWRITE)) )
+			if( copy_from_user((char *) &rReadData,
+						(char *) ioarg,
+						sizeof(MW_READWRITE)) )
 				return -EFAULT;
 			pusBuffer = (unsigned short *) (rReadData.pBuf);
 	
 			PRINTK_4(TRACE_MWAVE,
-				"mwavedd::mwave_ioctl IOCTL_MW_READ_DATA, size %lx, ioarg %lx pusBuffer %p\n",
+				"mwavedd::mwave_ioctl IOCTL_MW_READ_DATA,"
+				" size %lx, ioarg %lx pusBuffer %p\n",
 				rReadData.ulDataLength, ioarg, pusBuffer);
-			retval = tp3780I_ReadWriteDspDStore(&pDrvData->rBDData, iocmd,
-				(void *) pusBuffer, rReadData.ulDataLength, rReadData.usDspAddress);
+			retval = tp3780I_ReadWriteDspDStore(&pDrvData->rBDData,
+					iocmd,
+					(void *) pusBuffer,
+					rReadData.ulDataLength,
+					rReadData.usDspAddress);
 		}
 			break;
 	
@@ -213,12 +204,14 @@
 			MW_READWRITE rReadData;
 			unsigned short *pusBuffer = 0;
 	
-			if( copy_from_user((char *) &rReadData, (char *) ioarg, sizeof(MW_READWRITE)) )
+			if( copy_from_user((char *) &rReadData, (char *) ioarg,
+						sizeof(MW_READWRITE)) )
 				return -EFAULT;
 			pusBuffer = (unsigned short *) (rReadData.pBuf);
 	
 			PRINTK_4(TRACE_MWAVE,
-				"mwavedd::mwave_ioctl IOCTL_MW_READ_INST, size %lx, ioarg %lx pusBuffer %p\n",
+				"mwavedd::mwave_ioctl IOCTL_MW_READ_INST,"
+				" size %lx, ioarg %lx pusBuffer %p\n",
 				rReadData.ulDataLength / 2, ioarg,
 				pusBuffer);
 			retval = tp3780I_ReadWriteDspDStore(&pDrvData->rBDData,
@@ -232,16 +225,21 @@
 			MW_READWRITE rWriteData;
 			unsigned short *pusBuffer = 0;
 	
-			if( copy_from_user((char *) &rWriteData, (char *) ioarg, sizeof(MW_READWRITE)) )
+			if( copy_from_user((char *) &rWriteData,
+						(char *) ioarg,
+						sizeof(MW_READWRITE)) )
 				return -EFAULT;
 			pusBuffer = (unsigned short *) (rWriteData.pBuf);
 	
 			PRINTK_4(TRACE_MWAVE,
-				"mwavedd::mwave_ioctl IOCTL_MW_WRITE_DATA, size %lx, ioarg %lx pusBuffer %p\n",
+				"mwavedd::mwave_ioctl IOCTL_MW_WRITE_DATA,"
+				" size %lx, ioarg %lx pusBuffer %p\n",
 				rWriteData.ulDataLength, ioarg,
 				pusBuffer);
-			retval = tp3780I_ReadWriteDspDStore(&pDrvData->rBDData, iocmd,
-				pusBuffer, rWriteData.ulDataLength, rWriteData.usDspAddress);
+			retval = tp3780I_ReadWriteDspDStore(&pDrvData->rBDData,
+					iocmd, pusBuffer,
+					rWriteData.ulDataLength,
+					rWriteData.usDspAddress);
 		}
 			break;
 	
@@ -249,16 +247,21 @@
 			MW_READWRITE rWriteData;
 			unsigned short *pusBuffer = 0;
 	
-			if( copy_from_user((char *) &rWriteData, (char *) ioarg, sizeof(MW_READWRITE)) )
+			if( copy_from_user((char *) &rWriteData,
+						(char *) ioarg,
+						sizeof(MW_READWRITE)) )
 				return -EFAULT;
 			pusBuffer = (unsigned short *) (rWriteData.pBuf);
 	
 			PRINTK_4(TRACE_MWAVE,
-				"mwavedd::mwave_ioctl IOCTL_MW_WRITE_INST, size %lx, ioarg %lx pusBuffer %p\n",
+				"mwavedd::mwave_ioctl IOCTL_MW_WRITE_INST,"
+				" size %lx, ioarg %lx pusBuffer %p\n",
 				rWriteData.ulDataLength, ioarg,
 				pusBuffer);
-			retval = tp3780I_ReadWriteDspIStore(&pDrvData->rBDData, iocmd,
-					pusBuffer, rWriteData.ulDataLength, rWriteData.usDspAddress);
+			retval = tp3780I_ReadWriteDspIStore(&pDrvData->rBDData,
+					iocmd, pusBuffer,
+					rWriteData.ulDataLength,
+					rWriteData.usDspAddress);
 		}
 			break;
 	
@@ -266,23 +269,25 @@
 			unsigned int ipcnum = (unsigned int) ioarg;
 	
 			PRINTK_3(TRACE_MWAVE,
-				"mwavedd::mwave_ioctl IOCTL_MW_REGISTER_IPC ipcnum %x entry usIntCount %x\n",
+				"mwavedd::mwave_ioctl IOCTL_MW_REGISTER_IPC"
+				" ipcnum %x entry usIntCount %x\n",
 				ipcnum,
 				pDrvData->IPCs[ipcnum].usIntCount);
 	
-			if (ipcnum > 16) {
-				PRINTK_ERROR(KERN_ERR_MWAVE "mwavedd::mwave_ioctl: IOCTL_MW_REGISTER_IPC: Error: Invalid ipcnum %x\n", ipcnum);
+			if (ipcnum > ARRAY_SIZE(pDrvData->IPCs)) {
+				PRINTK_ERROR(KERN_ERR_MWAVE
+						"mwavedd::mwave_ioctl:"
+						" IOCTL_MW_REGISTER_IPC:"
+						" Error: Invalid ipcnum %x\n",
+						ipcnum);
 				return -EINVAL;
 			}
 			pDrvData->IPCs[ipcnum].bIsHere = FALSE;
 			pDrvData->IPCs[ipcnum].bIsEnabled = TRUE;
-	#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
-	#else
-			current->priority = 0x28;	/* boost to provide priority timing */
-	#endif
 	
 			PRINTK_2(TRACE_MWAVE,
-				"mwavedd::mwave_ioctl IOCTL_MW_REGISTER_IPC ipcnum %x exit\n",
+				"mwavedd::mwave_ioctl IOCTL_MW_REGISTER_IPC"
+				" ipcnum %x exit\n",
 				ipcnum);
 		}
 			break;
@@ -293,17 +298,22 @@
 			unsigned long flags;
 	
 			PRINTK_3(TRACE_MWAVE,
-				"mwavedd::mwave_ioctl IOCTL_MW_GET_IPC ipcnum %x, usIntCount %x\n",
+				"mwavedd::mwave_ioctl IOCTL_MW_GET_IPC"
+				" ipcnum %x, usIntCount %x\n",
 				ipcnum,
 				pDrvData->IPCs[ipcnum].usIntCount);
-			if (ipcnum > 16) {
-				PRINTK_ERROR(KERN_ERR_MWAVE "mwavedd::mwave_ioctl: IOCTL_MW_GET_IPC: Error: Invalid ipcnum %x\n", ipcnum);
+			if (ipcnum > ARRAY_SIZE(pDrvData->IPCs)) {
+				PRINTK_ERROR(KERN_ERR_MWAVE
+						"mwavedd::mwave_ioctl:"
+						" IOCTL_MW_GET_IPC: Error:"
+						" Invalid ipcnum %x\n", ipcnum);
 				return -EINVAL;
 			}
 	
 			if (pDrvData->IPCs[ipcnum].bIsEnabled == TRUE) {
 				PRINTK_2(TRACE_MWAVE,
-					"mwavedd::mwave_ioctl, thread for ipc %x going to sleep\n",
+					"mwavedd::mwave_ioctl, thread for"
+					" ipc %x going to sleep\n",
 					ipcnum);
 	
 				spin_lock_irqsave(&ipc_lock, flags);
@@ -313,10 +323,13 @@
 					pDrvData->IPCs[ipcnum].usIntCount = 2;	/* first int has been handled */
 					spin_unlock_irqrestore(&ipc_lock, flags);
 					PRINTK_2(TRACE_MWAVE,
-						"mwavedd::mwave_ioctl IOCTL_MW_GET_IPC ipcnum %x handling first int\n",
+						"mwavedd::mwave_ioctl"
+						" IOCTL_MW_GET_IPC ipcnum %x"
+						" handling first int\n",
 						ipcnum);
 				} else {	/* either 1st int has not yet occurred, or we have already handled the first int */
 					pDrvData->IPCs[ipcnum].bIsHere = TRUE;
+#warning "Sleeping on spinlock"
 					interruptible_sleep_on(&pDrvData->IPCs[ipcnum].ipc_wait_queue);
 					pDrvData->IPCs[ipcnum].bIsHere = FALSE;
 					if (pDrvData->IPCs[ipcnum].usIntCount == 1) {
@@ -325,11 +338,16 @@
 					}
 					spin_unlock_irqrestore(&ipc_lock, flags);
 					PRINTK_2(TRACE_MWAVE,
-						"mwavedd::mwave_ioctl IOCTL_MW_GET_IPC ipcnum %x woke up and returning to application\n",
+						"mwavedd::mwave_ioctl"
+						" IOCTL_MW_GET_IPC ipcnum %x"
+						" woke up and returning to"
+						" application\n",
 						ipcnum);
 				}
 				PRINTK_2(TRACE_MWAVE,
-					"mwavedd::mwave_ioctl IOCTL_MW_GET_IPC, returning thread for ipc %x processing\n",
+					"mwavedd::mwave_ioctl IOCTL_MW_GET_IPC,"
+					" returning thread for ipc %x"
+					" processing\n",
 					ipcnum);
 			}
 		}
@@ -339,10 +357,15 @@
 			unsigned int ipcnum = (unsigned int) ioarg;
 	
 			PRINTK_2(TRACE_MWAVE,
-				"mwavedd::mwave_ioctl IOCTL_MW_UNREGISTER_IPC ipcnum %x\n",
+				"mwavedd::mwave_ioctl IOCTL_MW_UNREGISTER_IPC"
+				" ipcnum %x\n",
 				ipcnum);
-			if (ipcnum > 16) {
-				PRINTK_ERROR(KERN_ERR_MWAVE "mwavedd::mwave_ioctl: IOCTL_MW_UNREGISTER_IPC: Error: Invalid ipcnum %x\n", ipcnum);
+			if (ipcnum > ARRAY_SIZE(pDrvData->IPCs)) {
+				PRINTK_ERROR(KERN_ERR_MWAVE
+						"mwavedd::mwave_ioctl:"
+						" IOCTL_MW_UNREGISTER_IPC:"
+						" Error: Invalid ipcnum %x\n",
+						ipcnum);
 				return -EINVAL;
 			}
 			if (pDrvData->IPCs[ipcnum].bIsEnabled == TRUE) {
@@ -355,7 +378,9 @@
 			break;
 	
 		default:
-			PRINTK_ERROR(KERN_ERR_MWAVE "mwavedd::mwave_ioctl: Error: Unrecognized iocmd %x\n", iocmd);
+			PRINTK_ERROR(KERN_ERR_MWAVE "mwavedd::mwave_ioctl:"
+					" Error: Unrecognized iocmd %x\n",
+					iocmd);
 			return -ENOTTY;
 			break;
 	} /* switch */
@@ -381,7 +406,8 @@
                            size_t count, loff_t * ppos)
 {
 	PRINTK_5(TRACE_MWAVE,
-		"mwavedd::mwave_write entry file %p, buf %p, count %x ppos %p\n",
+		"mwavedd::mwave_write entry file %p, buf %p,"
+		" count %x ppos %p\n",
 		file, buf, count, ppos);
 
 	return -EINVAL;
@@ -400,7 +426,9 @@
 			/* OK */
 			break;
 		default:
-			PRINTK_ERROR(KERN_ERR_MWAVE "mwavedd::register_serial_portandirq: Error: Illegal port %x\n", port );
+			PRINTK_ERROR(KERN_ERR_MWAVE
+					"mwavedd::register_serial_portandirq:"
+					" Error: Illegal port %x\n", port );
 			return -1;
 	} /* switch */
 	/* port is okay */
@@ -413,7 +441,9 @@
 			/* OK */
 			break;
 		default:
-			PRINTK_ERROR(KERN_ERR_MWAVE "mwavedd::register_serial_portandirq: Error: Illegal irq %x\n", irq );
+			PRINTK_ERROR(KERN_ERR_MWAVE
+					"mwavedd::register_serial_portandirq:"
+					" Error: Illegal irq %x\n", irq );
 			return -1;
 	} /* switch */
 	/* irq is okay */
@@ -427,7 +457,6 @@
 }
 
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 static struct file_operations mwave_fops = {
 	.owner		= THIS_MODULE,
 	.read		= mwave_read,
@@ -436,24 +465,46 @@
 	.open		= mwave_open,
 	.release	= mwave_close
 };
-#else
-static struct file_operations mwave_fops = {
-	NULL,			/* lseek */
-	mwave_read,		/* read */
-	mwave_write,		/* write */
-	NULL,			/* readdir */
-	NULL,			/* poll */
-	mwave_ioctl,		/* ioctl */
-	NULL,			/* mmap */
-	mwave_open,		/* open */
-	NULL,			/* flush */
-	mwave_close		/* release */
-};
-#endif
+
 
 static struct miscdevice mwave_misc_dev = { MWAVE_MINOR, "mwave", &mwave_fops };
 
 /*
+ * sysfs support <paulsch@us.ibm.com>
+ */
+
+struct device mwave_device;
+
+/* Prevent code redundancy, create a macro for mwave_show_* functions. */
+#define mwave_show_function(attr_name, format_string, field)		\
+static ssize_t mwave_show_##attr_name(struct device *dev, char *buf)	\
+{									\
+	DSP_3780I_CONFIG_SETTINGS *pSettings =				\
+		&mwave_s_mdd.rBDData.rDspSettings;			\
+        return sprintf(buf, format_string, pSettings->field);		\
+}
+
+/* All of our attributes are read attributes. */
+#define mwave_dev_rd_attr(attr_name, format_string, field)		\
+	mwave_show_function(attr_name, format_string, field)		\
+static DEVICE_ATTR(attr_name, S_IRUGO, mwave_show_##attr_name, NULL)
+
+mwave_dev_rd_attr (3780i_dma, "%i\n", usDspDma);
+mwave_dev_rd_attr (3780i_irq, "%i\n", usDspIrq);
+mwave_dev_rd_attr (3780i_io, "%#.4x\n", usDspBaseIO);
+mwave_dev_rd_attr (uart_irq, "%i\n", usUartIrq);
+mwave_dev_rd_attr (uart_io, "%#.4x\n", usUartBaseIO);
+
+static struct device_attribute * const mwave_dev_attrs[] = {
+	&dev_attr_3780i_dma,
+	&dev_attr_3780i_irq,
+	&dev_attr_3780i_io,
+	&dev_attr_uart_irq,
+	&dev_attr_uart_io,
+};
+
+
+/*
 * mwave_init is called on module load
 *
 * mwave_exit is called on module unload
@@ -461,17 +512,16 @@
 */
 static void mwave_exit(void)
 {
+	int i;
 	pMWAVE_DEVICE_DATA pDrvData = &mwave_s_mdd;
 
 	PRINTK_1(TRACE_MWAVE, "mwavedd::mwave_exit entry\n");
 
-	if (pDrvData->bProcEntryCreated) {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
-		remove_proc_entry("mwave", NULL);
-#else
-		proc_unregister(&proc_root, mwave_proc.low_ino);
-#endif
+	for (i = 0; i < ARRAY_SIZE(mwave_dev_attrs); i++) {
+		device_remove_file(&mwave_device, mwave_dev_attrs[i]);
 	}
+	device_unregister(&mwave_device);
+
 	if ( pDrvData->sLine >= 0 ) {
 		unregister_serial(pDrvData->sLine);
 	}
@@ -497,72 +547,81 @@
 {
 	int i;
 	int retval = 0;
-	unsigned int resultMiscRegister;
 	pMWAVE_DEVICE_DATA pDrvData = &mwave_s_mdd;
 
-	memset(&mwave_s_mdd, 0, sizeof(MWAVE_DEVICE_DATA));
-
 	PRINTK_1(TRACE_MWAVE, "mwavedd::mwave_init entry\n");
 
+	memset(&mwave_s_mdd, 0, sizeof(MWAVE_DEVICE_DATA));
+
 	pDrvData->bBDInitialized = FALSE;
 	pDrvData->bResourcesClaimed = FALSE;
 	pDrvData->bDSPEnabled = FALSE;
 	pDrvData->bDSPReset = FALSE;
 	pDrvData->bMwaveDevRegistered = FALSE;
 	pDrvData->sLine = -1;
-	pDrvData->bProcEntryCreated = FALSE;
 
-	for (i = 0; i < 16; i++) {
+	for (i = 0; i < ARRAY_SIZE(pDrvData->IPCs); i++) {
 		pDrvData->IPCs[i].bIsEnabled = FALSE;
 		pDrvData->IPCs[i].bIsHere = FALSE;
 		pDrvData->IPCs[i].usIntCount = 0;	/* no ints received yet */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 		init_waitqueue_head(&pDrvData->IPCs[i].ipc_wait_queue);
-#endif
 	}
 
 	retval = tp3780I_InitializeBoardData(&pDrvData->rBDData);
 	PRINTK_2(TRACE_MWAVE,
-		"mwavedd::mwave_init, return from tp3780I_InitializeBoardData retval %x\n",
+		"mwavedd::mwave_init, return from tp3780I_InitializeBoardData"
+		" retval %x\n",
 		retval);
 	if (retval) {
-		PRINTK_ERROR(KERN_ERR_MWAVE "mwavedd::mwave_init: Error: Failed to initialize board data\n");
+		PRINTK_ERROR(KERN_ERR_MWAVE
+				"mwavedd::mwave_init: Error:"
+				" Failed to initialize board data\n");
 		goto cleanup_error;
 	}
 	pDrvData->bBDInitialized = TRUE;
 
 	retval = tp3780I_CalcResources(&pDrvData->rBDData);
 	PRINTK_2(TRACE_MWAVE,
-		"mwavedd::mwave_init, return from tp3780I_CalcResources retval %x\n",
+		"mwavedd::mwave_init, return from tp3780I_CalcResources"
+		" retval %x\n",
 		retval);
 	if (retval) {
-		PRINTK_ERROR(KERN_ERR_MWAVE "mwavedd:mwave_init: Error: Failed to calculate resources\n");
+		PRINTK_ERROR(KERN_ERR_MWAVE
+				"mwavedd:mwave_init: Error:"
+				" Failed to calculate resources\n");
 		goto cleanup_error;
 	}
 
 	retval = tp3780I_ClaimResources(&pDrvData->rBDData);
 	PRINTK_2(TRACE_MWAVE,
-		"mwavedd::mwave_init, return from tp3780I_ClaimResources retval %x\n",
+		"mwavedd::mwave_init, return from tp3780I_ClaimResources"
+		" retval %x\n",
 		retval);
 	if (retval) {
-		PRINTK_ERROR(KERN_ERR_MWAVE "mwavedd:mwave_init: Error: Failed to claim resources\n");
+		PRINTK_ERROR(KERN_ERR_MWAVE
+				"mwavedd:mwave_init: Error:"
+				" Failed to claim resources\n");
 		goto cleanup_error;
 	}
 	pDrvData->bResourcesClaimed = TRUE;
 
 	retval = tp3780I_EnableDSP(&pDrvData->rBDData);
 	PRINTK_2(TRACE_MWAVE,
-		"mwavedd::mwave_init, return from tp3780I_EnableDSP retval %x\n",
+		"mwavedd::mwave_init, return from tp3780I_EnableDSP"
+		" retval %x\n",
 		retval);
 	if (retval) {
-		PRINTK_ERROR(KERN_ERR_MWAVE "mwavedd:mwave_init: Error: Failed to enable DSP\n");
+		PRINTK_ERROR(KERN_ERR_MWAVE
+				"mwavedd:mwave_init: Error:"
+				" Failed to enable DSP\n");
 		goto cleanup_error;
 	}
 	pDrvData->bDSPEnabled = TRUE;
 
-	resultMiscRegister = misc_register(&mwave_misc_dev);
-	if (resultMiscRegister < 0) {
-		PRINTK_ERROR(KERN_ERR_MWAVE "mwavedd:mwave_init: Error: Failed to register misc device\n");
+	if (misc_register(&mwave_misc_dev) < 0) {
+		PRINTK_ERROR(KERN_ERR_MWAVE
+				"mwavedd:mwave_init: Error:"
+				" Failed to register misc device\n");
 		goto cleanup_error;
 	}
 	pDrvData->bMwaveDevRegistered = TRUE;
@@ -572,28 +631,36 @@
 		pDrvData->rBDData.rDspSettings.usUartIrq
 	);
 	if (pDrvData->sLine < 0) {
-		PRINTK_ERROR(KERN_ERR_MWAVE "mwavedd:mwave_init: Error: Failed to register serial driver\n");
+		PRINTK_ERROR(KERN_ERR_MWAVE
+				"mwavedd:mwave_init: Error:"
+				" Failed to register serial driver\n");
 		goto cleanup_error;
 	}
 	/* uart is registered */
 
-	if (
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
-		!create_proc_info_entry("mwave", 0, NULL, mwave_get_info)
-#else
-		proc_register(&proc_root, &mwave_proc)
-#endif
-	) {
-		PRINTK_ERROR(KERN_ERR_MWAVE "mwavedd::mwave_init: Error: Failed to register /proc/mwave\n");
-		goto cleanup_error;
+	/* sysfs */
+	memset(&mwave_device, 0, sizeof (struct device));
+	snprintf(mwave_device.name, DEVICE_NAME_SIZE, "mwave");
+	snprintf(mwave_device.bus_id, BUS_ID_SIZE, "mwave");
+
+	device_register(&mwave_device);
+	for (i = 0; i < ARRAY_SIZE(mwave_dev_attrs); i++) {
+		if(device_create_file(&mwave_device, mwave_dev_attrs[i])) {
+			PRINTK_ERROR(KERN_ERR_MWAVE
+					"mwavedd:mwave_init: Error:"
+					" Failed to create sysfs file %s\n",
+					mwave_dev_attrs[i]->attr.name);
+			goto cleanup_error;
+		}
 	}
-	pDrvData->bProcEntryCreated = TRUE;
 
 	/* SUCCESS! */
 	return 0;
 
 	cleanup_error:
-	PRINTK_ERROR(KERN_ERR_MWAVE "mwavedd::mwave_init: Error: Failed to initialize\n");
+	PRINTK_ERROR(KERN_ERR_MWAVE
+			"mwavedd::mwave_init: Error:"
+			" Failed to initialize\n");
 	mwave_exit(); /* clean up */
 
 	return -EIO;
@@ -601,39 +668,3 @@
 
 module_init(mwave_init);
 
-
-/*
-* proc entry stuff added by Ian Pilcher <pilcher@us.ibm.com>
-*/
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
-static int mwave_get_info(char *buf, char **start, off_t offset, int len)
-{
-	DSP_3780I_CONFIG_SETTINGS *pSettings = &mwave_s_mdd.rBDData.rDspSettings;
-
-	char *out = buf;
-
-	out += sprintf(out, "3780i_IRQ %i\n", pSettings->usDspIrq);
-	out += sprintf(out, "3780i_DMA %i\n", pSettings->usDspDma);
-	out += sprintf(out, "3780i_IO  %#.4x\n", pSettings->usDspBaseIO);
-	out += sprintf(out, "UART_IRQ  %i\n", pSettings->usUartIrq);
-	out += sprintf(out, "UART_IO   %#.4x\n", pSettings->usUartBaseIO);
-
-	return out - buf;
-}
-#else /* kernel version < 2.4.0 */
-static int mwave_read_proc(char *buf, char **start, off_t offset,
-                           int xlen, int unused)
-{
-	DSP_3780I_CONFIG_SETTINGS *pSettings = &mwave_s_mdd.rBDData.rDspSettings;
-	int len;
-
-	len = sprintf(buf,        "3780i_IRQ %i\n", pSettings->usDspIrq);
-	len += sprintf(&buf[len], "3780i_DMA %i\n", pSettings->usDspDma);
-	len += sprintf(&buf[len], "3780i_IO  %#.4x\n", pSettings->usDspBaseIO);
-	len += sprintf(&buf[len], "UART_IRQ  %i\n", pSettings->usUartIrq);
-	len += sprintf(&buf[len], "UART_IO   %#.4x\n", pSettings->usUartBaseIO);
-
-	return len;
-}
-#endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/mwave/mwavedd.h linux-2.5.65-ac2/drivers/char/mwave/mwavedd.h
--- linux-2.5.65/drivers/char/mwave/mwavedd.h	2003-02-10 18:38:43.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/mwave/mwavedd.h	2003-03-06 23:15:49.000000000 +0000
@@ -126,11 +126,7 @@
 	BOOLEAN bIsEnabled;
 	BOOLEAN bIsHere;
 	/* entry spin lock */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	wait_queue_head_t ipc_wait_queue;
-#else
-	struct wait_queue *ipc_wait_queue;
-#endif
 } MWAVE_IPC;
 
 typedef struct _MWAVE_DEVICE_DATA {
@@ -143,7 +139,6 @@
 	BOOLEAN bDSPReset;
 	MWAVE_IPC IPCs[16];
 	BOOLEAN bMwaveDevRegistered;
-	BOOLEAN bProcEntryCreated;
 	short sLine;
 
 } MWAVE_DEVICE_DATA, *pMWAVE_DEVICE_DATA;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/mwave/mwavepub.h linux-2.5.65-ac2/drivers/char/mwave/mwavepub.h
--- linux-2.5.65/drivers/char/mwave/mwavepub.h	2003-02-10 18:39:17.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/mwave/mwavepub.h	2003-03-06 23:15:49.000000000 +0000
@@ -50,13 +50,8 @@
 #ifndef _LINUX_MWAVEPUB_H
 #define _LINUX_MWAVEPUB_H
 
-#ifndef MWAVEM_APP_DIST
 #include <linux/miscdevice.h>
-#endif
 
-#ifdef MWAVEM_APP_DIST
-#define MWAVE_MINOR      219
-#endif
 
 typedef struct _MW_ABILITIES {
 	unsigned long instr_per_sec;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/mwave/smapi.c linux-2.5.65-ac2/drivers/char/mwave/smapi.c
--- linux-2.5.65/drivers/char/mwave/smapi.c	2003-02-10 18:38:53.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/mwave/smapi.c	2003-03-06 23:15:49.000000000 +0000
@@ -280,10 +280,11 @@
 				if ((usSI & 0xFF) == mwave_uart_irq) {
 #ifndef MWAVE_FUTZ_WITH_OTHER_DEVICES
 					PRINTK_ERROR(KERN_ERR_MWAVE
+						"smapi::smapi_set_DSP_cfg: Serial port A irq %x conflicts with mwave_uart_irq %x\n", usSI & 0xFF, mwave_uart_irq);
 #else
 					PRINTK_3(TRACE_SMAPI,
+						"smapi::smapi_set_DSP_cfg: Serial port A irq %x conflicts with mwave_uart_irq %x\n", usSI & 0xFF, mwave_uart_irq);
 #endif
-						"smapi::smapi_set_DSP_cfg: Serial port A irq %x conflicts with mwave_uart_irq %x\n", usSI, mwave_uart_irq);
 #ifdef MWAVE_FUTZ_WITH_OTHER_DEVICES
 					PRINTK_1(TRACE_SMAPI,
 						"smapi::smapi_set_DSP_cfg Disabling conflicting serial port\n");
@@ -300,13 +301,14 @@
 					if ((usSI >> 8) == uartio_index) {
 #ifndef MWAVE_FUTZ_WITH_OTHER_DEVICES
 						PRINTK_ERROR(KERN_ERR_MWAVE
+							"smapi::smapi_set_DSP_cfg: Serial port A base I/O address %x conflicts with mwave uart I/O %x\n", ausUartBases[usSI >> 8], ausUartBases[uartio_index]);
 #else
 						PRINTK_3(TRACE_SMAPI,
+							"smapi::smapi_set_DSP_cfg: Serial port A base I/O address %x conflicts with mwave uart I/O %x\n", ausUartBases[usSI >> 8], ausUartBases[uartio_index]);
 #endif
-							"smapi::smapi_set_DSP_cfg: Serial port A base I/O address index %x conflicts with uartio_index %x\n", usSI >> 8, uartio_index);
 #ifdef MWAVE_FUTZ_WITH_OTHER_DEVICES
 						PRINTK_1(TRACE_SMAPI,
-							"smapi::smapi_set_DSP_cfg Disabling conflicting serial port\n");
+							"smapi::smapi_set_DSP_cfg Disabling conflicting serial port A\n");
 						bRC = smapi_request (0x1403, 0x0100, 0, usSI,
 							&usAX, &usBX, &usCX, &usDX, &usDI, &usSI);
 						if (bRC) goto exit_smapi_request_error;
@@ -331,13 +333,14 @@
 				if ((usSI & 0xFF) == mwave_uart_irq) {
 #ifndef MWAVE_FUTZ_WITH_OTHER_DEVICES
 					PRINTK_ERROR(KERN_ERR_MWAVE
+						"smapi::smapi_set_DSP_cfg: Serial port B irq %x conflicts with mwave_uart_irq %x\n", usSI & 0xFF, mwave_uart_irq);
 #else
 					PRINTK_3(TRACE_SMAPI,
+						"smapi::smapi_set_DSP_cfg: Serial port B irq %x conflicts with mwave_uart_irq %x\n", usSI & 0xFF, mwave_uart_irq);
 #endif
-						"smapi::smapi_set_DSP_cfg: Serial port B irq %x conflicts with mwave_uart_irq %x\n", usSI, mwave_uart_irq);
 #ifdef MWAVE_FUTZ_WITH_OTHER_DEVICES
 					PRINTK_1(TRACE_SMAPI,
-						"smapi::smapi_set_DSP_cfg Disabling conflicting serial port\n");
+						"smapi::smapi_set_DSP_cfg Disabling conflicting serial port B\n");
 					bRC = smapi_request(0x1405, 0x0100, 0, usSI,
 						&usAX, &usBX, &usCX, &usDX, &usDI, &usSI);
 					if (bRC) goto exit_smapi_request_error;
@@ -351,13 +354,14 @@
 					if ((usSI >> 8) == uartio_index) {
 #ifndef MWAVE_FUTZ_WITH_OTHER_DEVICES
 						PRINTK_ERROR(KERN_ERR_MWAVE
+							"smapi::smapi_set_DSP_cfg: Serial port B base I/O address %x conflicts with mwave uart I/O %x\n", ausUartBases[usSI >> 8], ausUartBases[uartio_index]);
 #else
 						PRINTK_3(TRACE_SMAPI,
+							"smapi::smapi_set_DSP_cfg: Serial port B base I/O address %x conflicts with mwave uart I/O %x\n", ausUartBases[usSI >> 8], ausUartBases[uartio_index]);
 #endif
-							"smapi::smapi_set_DSP_cfg: Serial port B base I/O address index %x conflicts with uartio_index %x\n", usSI >> 8, uartio_index);
 #ifdef MWAVE_FUTZ_WITH_OTHER_DEVICES
 						PRINTK_1 (TRACE_SMAPI,
-						    "smapi::smapi_set_DSP_cfg Disabling conflicting serial port\n");
+						    "smapi::smapi_set_DSP_cfg Disabling conflicting serial port B\n");
 						bRC = smapi_request (0x1405, 0x0100, 0, usSI,
 							&usAX, &usBX, &usCX, &usDX, &usDI, &usSI);
 						if (bRC) goto exit_smapi_request_error;
@@ -380,39 +384,15 @@
 			&usAX, &usBX, &usCX, &usDX, &usDI, &usSI);
 		if (bRC) goto exit_smapi_request_error;
 		/* bRC == 0 */
-		if ((usCX & 0xff) == mwave_uart_irq) {	/* serial port is enabled */
-#ifndef MWAVE_FUTZ_WITH_OTHER_DEVICES
-			PRINTK_ERROR(KERN_ERR_MWAVE
-#else
-			PRINTK_3(TRACE_SMAPI,
-#endif
-				"smapi::smapi_set_DSP_cfg: IR port irq %x conflicts with mwave_uart_irq %x\n", usSI, mwave_uart_irq);
-#ifdef MWAVE_FUTZ_WITH_OTHER_DEVICES
-			PRINTK_1(TRACE_SMAPI,
-				"smapi::smapi_set_DSP_cfg Disabling conflicting IR port\n");
-			bRC = smapi_request(0x1701, 0x0100, 0, 0,
-				&usAX, &usBX, &usCX, &usDX, &usDI, &usSI);
-			if (bRC) goto exit_smapi_request_error;
-			bRC = smapi_request(0x1700, 0, 0, 0,
-				&usAX, &usBX, &usCX, &usDX, &usDI, &usSI);
-			if (bRC) goto exit_smapi_request_error;
-			bRC = smapi_request(0x1705, 0x01ff, 0, usSI,
-				&usAX, &usBX, &usCX, &usDX, &usDI, &usSI);
-			if (bRC) goto exit_smapi_request_error;
-			bRC = smapi_request(0x1704, 0x0000, 0, 0,
-				&usAX, &usBX, &usCX, &usDX, &usDI, &usSI);
-			if (bRC) goto exit_smapi_request_error;
-#else
-			goto exit_conflict;
-#endif
-		} else {
-			if ((usSI & 0xff) == uartio_index) {
+		if ((usCX & 0xff) != 0xff) { /* IR port not disabled */
+			if ((usCX & 0xff) == mwave_uart_irq) {
 #ifndef MWAVE_FUTZ_WITH_OTHER_DEVICES
 				PRINTK_ERROR(KERN_ERR_MWAVE
+					"smapi::smapi_set_DSP_cfg: IR port irq %x conflicts with mwave_uart_irq %x\n", usCX & 0xff, mwave_uart_irq);
 #else
 				PRINTK_3(TRACE_SMAPI,
+					"smapi::smapi_set_DSP_cfg: IR port irq %x conflicts with mwave_uart_irq %x\n", usCX & 0xff, mwave_uart_irq);
 #endif
-					"smapi::smapi_set_DSP_cfg: IR port base I/O address index %x conflicts with uartio_index %x\n", usSI & 0xff, uartio_index);
 #ifdef MWAVE_FUTZ_WITH_OTHER_DEVICES
 				PRINTK_1(TRACE_SMAPI,
 					"smapi::smapi_set_DSP_cfg Disabling conflicting IR port\n");
@@ -431,6 +411,34 @@
 #else
 				goto exit_conflict;
 #endif
+			} else {
+				if ((usSI & 0xff) == uartio_index) {
+#ifndef MWAVE_FUTZ_WITH_OTHER_DEVICES
+					PRINTK_ERROR(KERN_ERR_MWAVE
+						"smapi::smapi_set_DSP_cfg: IR port base I/O address %x conflicts with mwave uart I/O %x\n", ausUartBases[usSI & 0xff], ausUartBases[uartio_index]);
+#else
+					PRINTK_3(TRACE_SMAPI,
+						"smapi::smapi_set_DSP_cfg: IR port base I/O address %x conflicts with mwave uart I/O %x\n", ausUartBases[usSI & 0xff], ausUartBases[uartio_index]);
+#endif
+#ifdef MWAVE_FUTZ_WITH_OTHER_DEVICES
+					PRINTK_1(TRACE_SMAPI,
+						"smapi::smapi_set_DSP_cfg Disabling conflicting IR port\n");
+					bRC = smapi_request(0x1701, 0x0100, 0, 0,
+						&usAX, &usBX, &usCX, &usDX, &usDI, &usSI);
+					if (bRC) goto exit_smapi_request_error;
+					bRC = smapi_request(0x1700, 0, 0, 0,
+						&usAX, &usBX, &usCX, &usDX, &usDI, &usSI);
+					if (bRC) goto exit_smapi_request_error;
+					bRC = smapi_request(0x1705, 0x01ff, 0, usSI,
+						&usAX, &usBX, &usCX, &usDX, &usDI, &usSI);
+					if (bRC) goto exit_smapi_request_error;
+					bRC = smapi_request(0x1704, 0x0000, 0, 0,
+						&usAX, &usBX, &usCX, &usDX, &usDI, &usSI);
+					if (bRC) goto exit_smapi_request_error;
+#else
+					goto exit_conflict;
+#endif
+				}
 			}
 		}
 	}
