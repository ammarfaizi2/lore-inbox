Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263802AbUD0GWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUD0GWi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 02:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263809AbUD0GWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 02:22:37 -0400
Received: from smtp1.cwidc.net ([154.33.63.111]:35555 "EHLO smtp1.cwidc.net")
	by vger.kernel.org with ESMTP id S263802AbUD0GVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 02:21:49 -0400
Message-ID: <408DFBEE.3080803@tequila.co.jp>
Date: Tue, 27 Apr 2004 15:21:34 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: Tequila \ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040308
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org
CC: dlang@digitalinsight.com, linux-kernel@vger.kernel.org,
       go@turbolinux.co.jp
Subject: Re: 2.6.6-rc2-mm2 + Adaptec I2O
References: <408DE95F.5010201@tequila.co.jp>	<20040426221814.490a0cfd.akpm@osdl.org>	<Pine.LNX.4.58.0404262223260.17702@dlang.diginsite.com>	<408DF117.4060309@tequila.co.jp> <20040426230455.53406d74.akpm@osdl.org>
In-Reply-To: <20040426230455.53406d74.akpm@osdl.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070301060207010605010802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070301060207010605010802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
| Clemens Schwaighofer <cs@tequila.co.jp> wrote:
|
|> on this URL [http://www.smartcgi.com/?action=docs,kernel26-adaptec] you
|> can find a patch that I could successfully path again 2.6.5 (vanilla)
|> and compile successfully.
|
|
| hm.  Against 2.6.0.  Go, would you have time to send that patch in to the
| scsi team at linux-scsi@vger.kernel.org?

yes,

remark:

~ Originally this patch has been released by Go Taniguchi at
http://pkgcvs.turbolinux.co.jp/~go/patch-2.6/dpt_i2o.patch

patch attached

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAjfvsjBz/yQjBxz8RAklUAJ4htR1TnQkc6+2ElfOPOMhY7rkhLwCgzdyo
JCuDLEXngGMCHHFjBFtYCMU=
=WBd+
-----END PGP SIGNATURE-----

--------------070301060207010605010802
Content-Type: text/x-patch;
 name="dpt_i2o.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dpt_i2o.patch"

diff -urN linux-2.6.0/drivers/scsi.orig/Kconfig linux-2.6.0/drivers/scsi/Kconfig
--- linux-2.6.0/drivers/scsi.orig/Kconfig	2003-12-18 11:59:36.000000000 +0900
+++ linux-2.6.0/drivers/scsi/Kconfig	2003-12-20 13:53:46.000000000 +0900
@@ -344,7 +344,7 @@
 # All the I2O code and drivers do not seem to be 64bit safe.
 config SCSI_DPT_I2O
 	tristate "Adaptec I2O RAID support "
-	depends on !64BIT && SCSI && BROKEN
+	depends on !64BIT && SCSI
 	help
 	  This driver supports all of Adaptec's I2O based RAID controllers as 
 	  well as the DPT SmartRaid V cards.  This is an Adaptec maintained
diff -urN linux-2.6.0/drivers/scsi.orig/dpt_i2o.c linux-2.6.0/drivers/scsi/dpt_i2o.c
--- linux-2.6.0/drivers/scsi.orig/dpt_i2o.c	2003-12-18 11:59:20.000000000 +0900
+++ linux-2.6.0/drivers/scsi/dpt_i2o.c	2003-12-20 14:51:40.000000000 +0900
@@ -20,17 +20,21 @@
  *   (at your option) any later version.                                   *
  *                                                                         *
  ***************************************************************************/
+/***************************************************************************
+ * Sat Dec 20 2003 Go Taniguchi <go@turbolinux.co.jp>
+ - Support 2.6 kernel and DMA-mapping
+ - ioctl fix for raid tools
+ - use schedule_timeout in long long loop
+ **************************************************************************/
 
-//#define DEBUG 1
-//#define UARTDELAY 1
+/*#define DEBUG 1 */
+/*#define UARTDELAY 1 */
 
-// On the real kernel ADDR32 should always be zero for 2.4. GFP_HIGH allocates
-// high pages. Keep the macro around because of the broken unmerged ia64 tree
+/* On the real kernel ADDR32 should always be zero for 2.4. GFP_HIGH allocates
+   high pages. Keep the macro around because of the broken unmerged ia64 tree */
 
 #define ADDR32 (0)
 
-#error Please convert me to Documentation/DMA-mapping.txt
-
 #include <linux/version.h>
 #include <linux/module.h>
 
@@ -53,6 +57,7 @@
 #include <linux/kernel.h>	/* for printk */
 #include <linux/sched.h>
 #include <linux/reboot.h>
+#include <linux/spinlock.h>
 #include <linux/smp_lock.h>
 
 #include <linux/timer.h>
@@ -86,7 +91,7 @@
 #elif defined(__alpha__)
 	PROC_ALPHA ,
 #else
-	(-1),(-1)
+	(-1),(-1),
 #endif
 	 FT_HBADRVR, 0, OEM_DPT, OS_LINUX, CAP_OVERLAP, DEV_ALL,
 	ADF_ALL_SC5, 0, 0, DPT_VERSION, DPT_REVISION, DPT_SUBREVISION,
@@ -227,7 +232,7 @@
 	/* Active IOPs now in OPERATIONAL state */
 	PDEBUG("HBA's in OPERATIONAL state\n");
 
-	printk(KERN_INFO"dpti: If you have a lot of devices this could take a few minutes.\n");
+	printk("dpti: If you have a lot of devices this could take a few minutes.\n");
 	for (pHba = hba_chain; pHba; pHba = pHba->next) {
 		printk(KERN_INFO"%s: Reading the hardware resource table.\n", pHba->name);
 		if (adpt_i2o_lct_get(pHba) < 0){
@@ -270,6 +275,7 @@
 	adpt_hba* pHba = (adpt_hba*) host->hostdata[0];
 //	adpt_i2o_quiesce_hba(pHba);
 	adpt_i2o_delete_hba(pHba);
+	scsi_unregister(host);
 	return 0;
 }
 
@@ -340,6 +346,8 @@
 	if (rcode != 0) {
 		sprintf(pHba->detail, "Adaptec I2O RAID");
 		printk(KERN_INFO "%s: Inquiry Error (%d)\n",pHba->name,rcode);
+		if (rcode != -ETIME && rcode != -EINTR)
+			kfree(buf);
 	} else {
 		memset(pHba->detail, 0, sizeof(pHba->detail));
 		memcpy(&(pHba->detail), "Vendor: Adaptec ", 16);
@@ -348,8 +356,8 @@
 		memcpy(&(pHba->detail[40]), " FW: ", 4);
 		memcpy(&(pHba->detail[44]), (u8*) &buf[32], 4);
 		pHba->detail[48] = '\0';	/* precautionary */
+		kfree(buf);
 	}
-	kfree(buf);
 	adpt_i2o_status_get(pHba);
 	return ;
 }
@@ -479,7 +487,7 @@
 		heads = 255;
 		sectors = 63;
 	}
-	cylinders = capacity / (heads * sectors);
+	cylinders = sector_div(capacity, heads * sectors);
 
 	// Special case if CDROM
 	if(sdev->type == 5) {  // CDROM
@@ -872,6 +880,9 @@
 		return -EINVAL;
 	}
 	pci_set_master(pDev);
+	if (pci_set_dma_mask(pDev, 0xffffffffffffffffULL) &&
+	    pci_set_dma_mask(pDev, 0xffffffffULL))
+		return -EINVAL;
 
 	base_addr0_phys = pci_resource_start(pDev,0);
 	hba_map0_area_size = pci_resource_len(pDev,0);
@@ -964,6 +975,7 @@
 
 	// Initializing the spinlocks
 	spin_lock_init(&pHba->state_lock);
+	spin_lock_init(&adpt_post_wait_lock);
 
 	if(raptorFlag == 0){
 		printk(KERN_INFO"Adaptec I2O RAID controller %d at %lx size=%x irq=%d\n", 
@@ -1065,7 +1077,7 @@
 {
 	int i;
 
-	printk(KERN_INFO"Loading Adaptec I2O RAID: Version " DPT_I2O_VERSION "\n");
+	printk("Loading Adaptec I2O RAID: Version " DPT_I2O_VERSION "\n");
 	for (i = 0; i < DPTI_MAX_HBA; i++) {
 		hbas[i] = NULL;
 	}
@@ -1153,12 +1165,22 @@
 	timeout *= HZ;
 	if((status = adpt_i2o_post_this(pHba, msg, len)) == 0){
 		set_current_state(TASK_INTERRUPTIBLE);
-		spin_unlock_irq(pHba->host->host_lock);
+		if(pHba->host)
+			spin_unlock_irq(pHba->host->host_lock);
 		if (!timeout)
 			schedule();
-		else
+		else{
+			timeout = schedule_timeout(timeout);
+			if (timeout == 0) {
+				// I/O issued, but cannot get result in
+				// specified time. Freeing resorces is
+				// dangerous.
+				status = -ETIME;
+			}
 			schedule_timeout(timeout*HZ);
-		spin_lock_irq(pHba->host->host_lock);
+		}
+		if(pHba->host)
+			spin_lock_irq(pHba->host->host_lock);
 	}
 	spin_lock_irq(&adpt_wq_i2o_post.lock);
 	__remove_wait_queue(&adpt_wq_i2o_post, &wait);
@@ -1210,6 +1232,8 @@
 			printk(KERN_WARNING"dpti%d: Timeout waiting for message frame!\n", pHba->unit);
 			return -ETIMEDOUT;
 		}
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(1);
 	} while(m == EMPTY_QUEUE);
 		
 	msg = (u32*) (pHba->msg_addr_virt + m);
@@ -1284,6 +1308,8 @@
 			printk(KERN_WARNING"Timeout waiting for message!\n");
 			return -ETIMEDOUT;
 		}
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(1);
 	} while (m == EMPTY_QUEUE);
 
 	status = (u8*)kmalloc(4, GFP_KERNEL|ADDR32);
@@ -1315,6 +1341,8 @@
 			return -ETIMEDOUT;
 		}
 		rmb();
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(1);
 	}
 
 	if(*status == 0x01 /*I2O_EXEC_IOP_RESET_IN_PROGRESS*/) {
@@ -1331,6 +1359,8 @@
 				printk(KERN_ERR "%s:Timeout waiting for IOP Reset.\n",pHba->name);
 				return -ETIMEDOUT;
 			}
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(1);
 		} while (m == EMPTY_QUEUE);
 		// Flush the offset
 		adpt_send_nop(pHba, m);
@@ -1696,15 +1726,20 @@
 	}
 
 	do {
-		spin_lock_irqsave(pHba->host->host_lock, flags);
+		if(pHba->host)
+			spin_lock_irqsave(pHba->host->host_lock, flags);
 		// This state stops any new commands from enterring the
 		// controller while processing the ioctl
 //		pHba->state |= DPTI_STATE_IOCTL;
 //		We can't set this now - The scsi subsystem sets host_blocked and
 //		the queue empties and stops.  We need a way to restart the queue
 		rcode = adpt_i2o_post_wait(pHba, msg, size, FOREVER);
+		if (rcode != 0)
+			printk("adpt_i2o_passthru: post wait failed %d %p\n",
+					rcode, reply);
 //		pHba->state &= ~DPTI_STATE_IOCTL;
-		spin_unlock_irqrestore(pHba->host->host_lock, flags);
+		if(pHba->host)
+			spin_unlock_irqrestore(pHba->host->host_lock, flags);
 	} while(rcode == -ETIMEDOUT);  
 
 	if(rcode){
@@ -1765,10 +1800,12 @@
 
 
 cleanup:
-	kfree (reply);
+	if (rcode != -ETIME && rcode != -EINTR)
+		kfree (reply);
 	while(sg_index) {
 		if(sg_list[--sg_index]) {
-			kfree((void*)(sg_list[sg_index]));
+			if (rcode != -ETIME && rcode != -EINTR)
+				kfree((void*)(sg_list[sg_index]));
 		}
 	}
 	return rcode;
@@ -1876,7 +1913,7 @@
 	int minor;
 	int error = 0;
 	adpt_hba* pHba;
-	ulong flags;
+	ulong flags = 0;
 
 	minor = iminor(inode);
 	if (minor >= DPTI_MAX_HBA){
@@ -1942,9 +1979,11 @@
 		break;
 		}
 	case I2ORESETCMD:
-		spin_lock_irqsave(pHba->host->host_lock, flags);
+		if(pHba->host)
+			spin_lock_irqsave(pHba->host->host_lock, flags);
 		adpt_hba_reset(pHba);
-		spin_unlock_irqrestore(pHba->host->host_lock, flags);
+		if(pHba->host)
+			spin_unlock_irqrestore(pHba->host->host_lock, flags);
 		break;
 	case I2ORESCANCMD:
 		adpt_rescan(pHba);
@@ -1957,7 +1996,7 @@
 }
 
 
-static void adpt_isr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t adpt_isr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	Scsi_Cmnd* cmd;
 	adpt_hba* pHba = dev_id;
@@ -1966,12 +2005,15 @@
 	u32 status=0;
 	u32 context;
 	ulong flags = 0;
+	int handled = 0;
 
-	if (pHba == NULL ){
+	if (pHba == NULL){
 		printk(KERN_WARNING"adpt_isr: NULL dev_id\n");
-		return;
+		return IRQ_NONE;
 	}
-	spin_lock_irqsave(pHba->host->host_lock, flags);
+	if(pHba->host)
+		spin_lock_irqsave(pHba->host->host_lock, flags);
+
 	while( readl(pHba->irq_mask) & I2O_INTERRUPT_PENDING_B) {
 		m = readl(pHba->reply_port);
 		if(m == EMPTY_QUEUE){
@@ -2036,7 +2078,10 @@
 		wmb();
 		rmb();
 	}
-out:	spin_unlock_irqrestore(pHba->host->host_lock, flags);
+	handled = 1;
+out:	if(pHba->host)
+		spin_unlock_irqrestore(pHba->host->host_lock, flags);
+	return IRQ_RETVAL(handled);
 }
 
 static s32 adpt_scsi_to_i2o(adpt_hba* pHba, Scsi_Cmnd* cmd, struct adpt_device* d)
@@ -2111,15 +2156,19 @@
 	/* Now fill in the SGList and command */
 	if(cmd->use_sg) {
 		struct scatterlist *sg = (struct scatterlist *)cmd->request_buffer;
+		int sg_count = pci_map_sg(pHba->pDev, sg, cmd->use_sg,
+                        scsi_to_pci_dma_dir(cmd->sc_data_direction));
+		
+
 		len = 0;
-		for(i = 0 ; i < cmd->use_sg; i++) {
-			*mptr++ = direction|0x10000000|sg->length;
-			len+=sg->length;
-			*mptr++ = virt_to_bus(sg->address);
+		for(i = 0 ; i < sg_count; i++) {
+			*mptr++ = direction|0x10000000|sg_dma_len(sg);
+			len+=sg_dma_len(sg);
+			*mptr++ = sg_dma_address(sg);
 			sg++;
 		}
 		/* Make this an end of list */
-		mptr[-2] = direction|0xD0000000|(sg-1)->length;
+		mptr[-2] = direction|0xD0000000|sg_dma_len(sg-1);
 		reqlen = mptr - msg;
 		*lenptr = len;
 		
@@ -2133,7 +2182,10 @@
 			reqlen = 12;
 		} else {
 			*mptr++ = 0xD0000000|direction|cmd->request_bufflen;
-			*mptr++ = virt_to_bus(cmd->request_buffer);
+			*mptr++ = pci_map_single(pHba->pDev,
+				cmd->request_buffer,
+				cmd->request_bufflen,
+				scsi_to_pci_dma_dir(cmd->sc_data_direction));
 		}
 	}
 	
@@ -2306,15 +2358,17 @@
 static s32 adpt_rescan(adpt_hba* pHba)
 {
 	s32 rcode;
-	ulong flags;
+	ulong flags = 0;
 
-	spin_lock_irqsave(pHba->host->host_lock, flags);
+	if(pHba->host)
+		spin_lock_irqsave(pHba->host->host_lock, flags);
 	if ((rcode=adpt_i2o_lct_get(pHba)) < 0)
 		goto out;
 	if ((rcode=adpt_i2o_reparse_lct(pHba)) < 0)
 		goto out;
 	rcode = 0;
-out:	spin_unlock_irqrestore(pHba->host->host_lock, flags);
+out:	if(pHba->host)
+		spin_unlock_irqrestore(pHba->host->host_lock, flags);
 	return rcode;
 }
 
@@ -2596,6 +2650,8 @@
 			printk(KERN_ERR "%s: Timeout waiting for message frame!\n",pHba->name);
 			return 2;
 		}
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(1);
 	}
 	msg = (u32*)(pHba->msg_addr_virt + m);
 	writel( THREE_WORD_MSG_SIZE | SGL_OFFSET_0,&msg[0]);
@@ -2629,6 +2685,8 @@
 			printk(KERN_WARNING"%s: Timeout waiting for message frame\n",pHba->name);
 			return -ETIMEDOUT;
 		}
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(1);
 	} while(m == EMPTY_QUEUE);
 
 	msg=(u32 *)(pHba->msg_addr_virt+m);
@@ -2664,9 +2722,10 @@
 		rmb();
 		if(time_after(jiffies,timeout)){
 			printk(KERN_WARNING"%s: Timeout Initializing\n",pHba->name);
-			kfree((void*)status);
 			return -ETIMEDOUT;
 		}
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(1);
 	} while (1);
 
 	// If the command was successful, fill the fifo with our reply
@@ -2744,6 +2803,8 @@
 					pHba->name);
 			return -ETIMEDOUT;
 		}
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(1);
 	} while(m==EMPTY_QUEUE);
 
 	
@@ -2770,6 +2831,8 @@
 			return -ETIMEDOUT;
 		}
 		rmb();
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(1);
 	}
 
 	// Set up our number of outbound and inbound messages
@@ -3095,17 +3158,33 @@
 			int group, int field, void *buf, int buflen)
 {
 	u16 opblk[] = { 1, 0, I2O_PARAMS_FIELD_GET, group, 1, field };
-	u8  resblk[8+buflen]; /* 8 bytes for header */
+	u8 *resblk;
+
 	int size;
 
+	/* 8 bytes for header */
+	resblk = kmalloc(sizeof(u8) * (8+buflen), GFP_KERNEL|ADDR32);
+	if (resblk == NULL) {
+		printk(KERN_CRIT "%s: query scalar failed; Out of memory.\n", pHba->name);
+		return -ENOMEM;
+	}
+
 	if (field == -1)  		/* whole group */
 			opblk[4] = -1;
 
 	size = adpt_i2o_issue_params(I2O_CMD_UTIL_PARAMS_GET, pHba, tid, 
-		opblk, sizeof(opblk), resblk, sizeof(resblk));
+		opblk, sizeof(opblk), resblk, sizeof(u8)*(8+buflen));
+	if (size == -ETIME) {
+		printk(KERN_WARNING "%s: issue params failed; Timed out.\n", pHba->name);
+		return -ETIME;
+	} else if (size == -EINTR) {
+		printk(KERN_WARNING "%s: issue params failed; Interrupted.\n", pHba->name);
+		return -EINTR;
+	}
 			
 	memcpy(buf, resblk+8, buflen);  /* cut off header */
 
+	kfree(resblk);
 	if (size < 0)
 		return size;	
 
@@ -3139,6 +3218,7 @@
 	msg[8] = virt_to_bus(resblk);
 
 	if ((wait_status = adpt_i2o_post_wait(pHba, msg, sizeof(msg), 20))) {
+		printk("adpt_i2o_issue_params: post_wait failed (%p)\n", resblk);
    		return wait_status; 	/* -DetailedStatus */
 	}
 
diff -urN linux-2.6.0/drivers/scsi.orig/dpti.h linux-2.6.0/drivers/scsi/dpti.h
--- linux-2.6.0/drivers/scsi.orig/dpti.h	2003-12-18 11:57:58.000000000 +0900
+++ linux-2.6.0/drivers/scsi/dpti.h	2003-12-22 14:49:23.882610752 +0900
@@ -65,7 +65,7 @@
 #include "dpt/dpti_i2o.h"
 #include "dpt/dpti_ioctl.h"
 
-#define DPT_I2O_VERSION "2.4 Build 5"
+#define DPT_I2O_VERSION "2.4 Build 5go"
 #define DPT_VERSION     2
 #define DPT_REVISION    '4'
 #define DPT_SUBREVISION '5'
@@ -272,7 +272,7 @@
 static void adpt_i2o_sys_shutdown(void);
 static int adpt_init(void);
 static int adpt_i2o_build_sys_table(void);
-static void adpt_isr(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t adpt_isr(int irq, void *dev_id, struct pt_regs *regs);
 #ifdef REBOOT_NOTIFIER
 static int adpt_reboot_event(struct notifier_block *n, ulong code, void *p);
 #endif

--------------070301060207010605010802--
