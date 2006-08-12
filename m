Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422689AbWHLVBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422689AbWHLVBl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 17:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422692AbWHLVBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 17:01:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:28050 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422689AbWHLVBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 17:01:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=m2rnjgeZZHbrUl622o8BFmzyqlhP9p2LefkEtFxGvGO+kq3rkjKrr4qHl9LBiSDlz87qqrEkPgagxjQWm1Ap0U7izHCx5UHEMkctsQzvGEinWH5Nvglrl0obPu1hoAq5XW0DPqRb/sF17taY5qJni6Jv91rzixaDez2+BDIyxOQ=
Message-ID: <44DE41D1.9020804@gmail.com>
Date: Sat, 12 Aug 2006 23:02:09 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
       Achim Leubner <achim_leubner@adaptec.com>
Subject: Re: [RFC] [PATCH 2/9] drivers/scsi/gdth.c Removal of old scsi code
References: <44DE3E5E.3020605@gmail.com>
In-Reply-To: <44DE3E5E.3020605@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/scsi/gdth.c linux-work/drivers/scsi/gdth.c
--- linux-work-clean/drivers/scsi/gdth.c	2006-08-12 01:51:16.000000000 +0200
+++ linux-work/drivers/scsi/gdth.c	2006-08-12 20:54:01.000000000 +0200
@@ -393,12 +393,7 @@
 #include <linux/proc_fs.h>
 #include <linux/time.h>
 #include <linux/timer.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,6)
 #include <linux/dma-mapping.h>
-#else
-#define DMA_32BIT_MASK	0x00000000ffffffffULL
-#define DMA_64BIT_MASK	0xffffffffffffffffULL
-#endif

 #ifdef GDTH_RTC
 #include <linux/mc146818rtc.h>
@@ -410,12 +405,7 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <linux/spinlock.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
 #include <linux/blkdev.h>
-#else
-#include <linux/blk.h>
-#include "sd.h"
-#endif

 #include "scsi.h"
 #include <scsi/scsi_host.h>
@@ -711,7 +701,6 @@ static void gdth_delay(int milliseconds)
     }
 }

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
 static void gdth_scsi_done(struct scsi_cmnd *scp)
 {
     TRACE2(("gdth_scsi_done()\n"));
@@ -749,42 +738,6 @@ int __gdth_execute(struct scsi_device *s
     kfree(scp);
     return rval;
 }
-#else
-static void gdth_scsi_done(Scsi_Cmnd *scp)
-{
-    TRACE2(("gdth_scsi_done()\n"));
-
-    scp->request.rq_status = RQ_SCSI_DONE;
-    if (scp->request.waiting)
-        complete(scp->request.waiting);
-}
-
-int __gdth_execute(struct scsi_device *sdev, gdth_cmd_str *gdtcmd, char *cmnd,
-                   int timeout, u32 *info)
-{
-    Scsi_Cmnd *scp = scsi_allocate_device(sdev, 1, FALSE);
-    unsigned bufflen = gdtcmd ? sizeof(gdth_cmd_str) : 0;
-    DECLARE_COMPLETION(wait);
-    int rval;
-
-    if (!scp)
-        return -ENOMEM;
-    scp->cmd_len = 12;
-    scp->use_sg = 0;
-    scp->SCp.this_residual = IOCTL_PRI;   /* priority */
-    scp->request.rq_status = RQ_SCSI_BUSY;
-    scp->request.waiting = &wait;
-    scsi_do_cmd(scp, cmnd, gdtcmd, bufflen, gdth_scsi_done, timeout*HZ, 1);
-    wait_for_completion(&wait);
-
-    rval = scp->SCp.Status;
-    if (info)
-        *info = scp->SCp.Message;
-
-    scsi_release_command(scp);
-    return rval;
-}
-#endif

 int gdth_execute(struct Scsi_Host *shost, gdth_cmd_str *gdtcmd, char *cmnd,
                  int timeout, u32 *info)
@@ -2249,29 +2202,17 @@ static int __init gdth_search_drives(int
         printk("GDT-HA %d: Vendor: %s Name: %s\n",
                hanum,oemstr->text.oem_company_name,ha->binfo.type_string);
         /* Save the Host Drive inquiry data */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
         strlcpy(ha->oem_name,oemstr->text.scsi_host_drive_inquiry_vendor_id,
                 sizeof(ha->oem_name));
-#else
-        strncpy(ha->oem_name,oemstr->text.scsi_host_drive_inquiry_vendor_id,7);
-        ha->oem_name[7] = '\0';
-#endif
     } else {
         /* Old method, based on PCI ID */
         TRACE2(("gdth_search_drives(): CACHE_READ_OEM_STRING_RECORD failed\n"));
         printk("GDT-HA %d: Name: %s\n",
                hanum,ha->binfo.type_string);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
         if (ha->oem_id == OEM_ID_INTEL)
             strlcpy(ha->oem_name,"Intel  ", sizeof(ha->oem_name));
         else
             strlcpy(ha->oem_name,"ICP    ", sizeof(ha->oem_name));
-#else
-        if (ha->oem_id == OEM_ID_INTEL)
-            strcpy(ha->oem_name,"Intel  ");
-        else
-            strcpy(ha->oem_name,"ICP    ");
-#endif
     }

     /* scanning for host drives */
@@ -2680,17 +2621,10 @@ static void gdth_copy_internal_data(int
                 return;
             }
             local_irq_save(flags);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
             address = kmap_atomic(sl->page, KM_BIO_SRC_IRQ) + sl->offset;
             memcpy(address,buffer,cpnow);
             flush_dcache_page(sl->page);
             kunmap_atomic(address, KM_BIO_SRC_IRQ);
-#else
-            address = kmap_atomic(sl->page, KM_BH_IRQ) + sl->offset;
-            memcpy(address,buffer,cpnow);
-            flush_dcache_page(sl->page);
-            kunmap_atomic(address, KM_BH_IRQ);
-#endif
             local_irq_restore(flags);
             if (cpsum == cpcount)
                 break;
@@ -4281,11 +4215,7 @@ int __init option_setup(char *str)
     return 1;
 }

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
 static int __init gdth_detect(struct scsi_host_template *shtp)
-#else
-static int __init gdth_detect(Scsi_Host_Template *shtp)
-#endif
 {
     struct Scsi_Host *shp;
     gdth_pci_str pcistr[MAXHA];
@@ -4425,10 +4355,6 @@ static int __init gdth_detect(Scsi_Host_
                     hdr_channel = ha->bus_cnt;
                 ha->virt_bus = hdr_channel;

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,20) && \
-    LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
-                shp->highmem_io  = 0;
-#endif
                 if (ha->cache_feat & ha->raw_feat & ha->screen_feat & GDT_64BIT)
                     shp->max_cmd_len = 16;

@@ -4549,10 +4475,6 @@ static int __init gdth_detect(Scsi_Host_
                     hdr_channel = ha->bus_cnt;
                 ha->virt_bus = hdr_channel;

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,20) && \
-    LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
-                shp->highmem_io  = 0;
-#endif
                 if (ha->cache_feat & ha->raw_feat & ha->screen_feat & GDT_64BIT)
                     shp->max_cmd_len = 16;

@@ -4652,10 +4574,6 @@ static int __init gdth_detect(Scsi_Host_
                 hdr_channel = ha->bus_cnt;
             ha->virt_bus = hdr_channel;

-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
-            scsi_set_pci_device(shp, pcistr[ctr].pdev);
-#endif
             if (!(ha->cache_feat & ha->raw_feat & ha->screen_feat &GDT_64BIT)||
                 /* 64-bit DMA only supported from FW >= x.43 */
                 (!ha->dma64_support)) {
@@ -4887,11 +4805,7 @@ static int gdth_eh_bus_reset(Scsi_Cmnd *
     return SUCCESS;
 }

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
 static int gdth_bios_param(struct scsi_device *sdev,struct block_device *bdev,sector_t cap,int *ip)
-#else
-static int gdth_bios_param(Disk *disk,kdev_t dev,int *ip)
-#endif
 {
     unchar b, t;
     int hanum;
@@ -4899,13 +4813,8 @@ static int gdth_bios_param(Disk *disk,kd
     struct scsi_device *sd;
     unsigned capacity;

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
     sd = sdev;
     capacity = cap;
-#else
-    sd = disk->device;
-    capacity = disk->capacity;
-#endif
     hanum = NUMDATA(sd->host)->hanum;
     b = virt_ctr ? NUMDATA(sd->host)->busnum : sd->channel;
     t = sd->id;
@@ -5520,7 +5429,6 @@ static int gdth_ioctl(struct inode *inod
         hanum = res.ionode;
         ha = HADATA(gdth_ctr_tab[hanum]);

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
         scp  = kmalloc(sizeof(*scp), GFP_KERNEL);
         if (!scp)
             return -ENOMEM;
@@ -5532,17 +5440,7 @@ static int gdth_ioctl(struct inode *inod
         rval = gdth_eh_bus_reset(scp);
         res.status = (rval == SUCCESS ? S_OK : S_GENERR);
         kfree(scp);
-#else
-        scp  = scsi_allocate_device(ha->sdev, 1, FALSE);
-        if (!scp)
-            return -ENOMEM;
-        scp->cmd_len = 12;
-        scp->use_sg = 0;
-        scp->channel = virt_ctr ? 0 : res.number;
-        rval = gdth_eh_bus_reset(scp);
-        res.status = (rval == SUCCESS ? S_OK : S_GENERR);
-        scsi_release_command(scp);
-#endif
+
         if (copy_to_user(argp, &res, sizeof(gdth_ioctl_reset)))
             return -EFAULT;
         break;
@@ -5630,7 +5528,6 @@ static int gdth_halt(struct notifier_blo
     return NOTIFY_OK;
 }

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
 /* configure lun */
 static int gdth_slave_configure(struct scsi_device *sdev)
 {
@@ -5639,13 +5536,8 @@ static int gdth_slave_configure(struct s
     sdev->skip_ms_page_8 = 1;
     return 0;
 }
-#endif

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
 static struct scsi_host_template driver_template = {
-#else
-static Scsi_Host_Template driver_template = {
-#endif
         .proc_name              = "gdth",
         .proc_info              = gdth_proc_info,
         .name                   = "GDT SCSI Disk Array Controller",
@@ -5656,20 +5548,12 @@ static Scsi_Host_Template driver_templat
         .eh_bus_reset_handler   = gdth_eh_bus_reset,
         .bios_param             = gdth_bios_param,
         .can_queue              = GDTH_MAXCMDS,
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
         .slave_configure        = gdth_slave_configure,
-#endif
         .this_id                = -1,
         .sg_tablesize           = GDTH_MAXSG,
         .cmd_per_lun            = GDTH_MAXC_P_L,
         .unchecked_isa_dma      = 1,
         .use_clustering         = ENABLE_CLUSTERING,
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
-        .use_new_eh_code        = 1,
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,20)
-        .highmem_io             = 1,
-#endif
-#endif
 };

 #include "scsi_module.c"

