Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVGJVgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVGJVgl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVGJTjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:39:19 -0400
Received: from mail.suse.de ([195.135.220.2]:6291 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261809AbVGJTft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:49 -0400
Date: Sun, 10 Jul 2005 19:35:48 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH 40/82] remove linux/version.h from drivers/scsi/ips
Message-ID: <20050710193548.40.oQkFzx3336.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.
remove code for obsolete kernels

Signed-off-by: Olaf Hering <olh@suse.de>

drivers/scsi/ips.c |  104 -----------------------------------------------------
drivers/scsi/ips.h |   33 ----------------
2 files changed, 137 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/ips.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/ips.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/ips.c
@@ -162,7 +162,6 @@
#include <asm/byteorder.h>
#include <asm/page.h>
#include <linux/stddef.h>
-#include <linux/version.h>
#include <linux/string.h>
#include <linux/errno.h>
#include <linux/kernel.h>
@@ -180,12 +179,7 @@
#include <scsi/sg.h>

#include "scsi.h"
-
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,0)
-#include "hosts.h"
-#else
#include <scsi/scsi_host.h>
-#endif

#include "ips.h"

@@ -214,21 +208,10 @@ module_param(ips, charp, 0);
#warning "This driver has only been tested on the x86/ia64/x86_64 platforms"
#endif

-#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,0)
-#include <linux/blk.h>
-#include "sd.h"
-#define IPS_SG_ADDRESS(sg)       ((sg)->address)
-#define IPS_LOCK_SAVE(lock,flags) spin_lock_irqsave(&io_request_lock,flags)
-#define IPS_UNLOCK_RESTORE(lock,flags) spin_unlock_irqrestore(&io_request_lock,flags)
-#ifndef __devexit_p
-#define __devexit_p(x) x
-#endif
-#else
#define IPS_SG_ADDRESS(sg)      (page_address((sg)->page) ?                                     page_address((sg)->page)+(sg)->offset : NULL)
#define IPS_LOCK_SAVE(lock,flags) do{spin_lock(lock);(void)flags;}while(0)
#define IPS_UNLOCK_RESTORE(lock,flags) do{spin_unlock(lock);(void)flags;}while(0)
-#endif

#define IPS_DMA_DIR(scb) ((!scb->scsi_cmd || ips_is_passthru(scb->scsi_cmd) ||                           DMA_NONE == scb->scsi_cmd->sc_data_direction) ? @@ -384,24 +367,13 @@ static Scsi_Host_Template ips_driver_tem
.eh_abort_handler	= ips_eh_abort,
.eh_host_reset_handler	= ips_eh_reset,
.proc_name		= "ips",
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,0)
.proc_info		= ips_proc_info,
.slave_configure	= ips_slave_configure,
-#else
-	.proc_info		= ips_proc24_info,
-	.select_queue_depths	= ips_select_queue_depth,
-#endif
.bios_param		= ips_biosparam,
.this_id		= -1,
.sg_tablesize		= IPS_MAX_SG,
.cmd_per_lun		= 3,
.use_clustering		= ENABLE_CLUSTERING,
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	.use_new_eh_code	= 1,
-#endif
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,20)  &&  LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-    .highmem_io          = 1,
-#endif
};

static IPS_DEFINE_COMPAT_TABLE( Compatable );	/* Version Compatability Table      */
@@ -1186,17 +1158,10 @@ ips_queue(Scsi_Cmnd * SC, void (*done) (
/*                                                                          */
/****************************************************************************/
static int
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-ips_biosparam(Disk * disk, kdev_t dev, int geom[])
-{
-	ips_ha_t *ha = (ips_ha_t *) disk->device->host->hostdata;
-	unsigned long capacity = disk->capacity;
-#else
ips_biosparam(struct scsi_device *sdev, struct block_device *bdev,
sector_t capacity, int geom[])
{
ips_ha_t *ha = (ips_ha_t *) sdev->host->hostdata;
-#endif
int heads;
int sectors;
int cylinders;
@@ -1234,70 +1199,6 @@ ips_biosparam(struct scsi_device *sdev,
return (0);
}

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-
-/* ips_proc24_info is a wrapper around ips_proc_info *
- * for compatibility with the 2.4 scsi parameters    */
-static int
-ips_proc24_info(char *buffer, char **start, off_t offset, int length,
-		              int hostno, int func)
-{
-	int i;
-
-	for (i = 0; i < ips_next_controller; i++) {
-		if (ips_sh[i] && ips_sh[i]->host_no == hostno) {
-			return ips_proc_info(ips_sh[i], buffer, start,
-					     offset, length, func);
-		}
-	}
-	return -EINVAL;
-}
-
-/****************************************************************************/
-/*                                                                          */
-/* Routine Name: ips_select_queue_depth                                     */
-/*                                                                          */
-/* Routine Description:                                                     */
-/*                                                                          */
-/*   Select queue depths for the devices on the contoller                   */
-/*                                                                          */
-/****************************************************************************/
-static void
-ips_select_queue_depth(struct Scsi_Host *host, Scsi_Device * scsi_devs)
-{
-	Scsi_Device *device;
-	ips_ha_t *ha;
-	int count = 0;
-	int min;
-
-	ha = IPS_HA(host);
-	min = ha->max_cmds / 4;
-
-	for (device = scsi_devs; device; device = device->next) {
-		if (device->host == host) {
-			if ((device->channel == 0) && (device->type == 0))
-				count++;
-		}
-	}
-
-	for (device = scsi_devs; device; device = device->next) {
-		if (device->host == host) {
-			if ((device->channel == 0) && (device->type == 0)) {
-				device->queue_depth =
-				    (ha->max_cmds - 1) / count;
-				if (device->queue_depth < min)
-					device->queue_depth = min;
-			} else {
-				device->queue_depth = 2;
-			}
-
-			if (device->queue_depth < 2)
-				device->queue_depth = 2;
-		}
-	}
-}
-
-#else
/****************************************************************************/
/*                                                                          */
/* Routine Name: ips_slave_configure                                        */
@@ -1322,7 +1223,6 @@ ips_slave_configure(Scsi_Device * SDptr)
}
return 0;
}
-#endif

/****************************************************************************/
/*                                                                          */
@@ -7044,9 +6944,7 @@ ips_register_scsi(int index)
sh->unchecked_isa_dma = sh->hostt->unchecked_isa_dma;
sh->use_clustering = sh->hostt->use_clustering;

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,7)
sh->max_sectors = 128;
-#endif

sh->max_id = ha->ntargets;
sh->max_lun = ha->nlun;
@@ -7470,9 +7368,7 @@ ips_init_phase2(int index)
return SUCCESS;
}

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,9)
MODULE_LICENSE("GPL");
-#endif

MODULE_DESCRIPTION("IBM ServeRAID Adapter Driver " IPS_VER_STRING);

Index: linux-2.6.13-rc2-mm1/drivers/scsi/ips.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/ips.h
+++ linux-2.6.13-rc2-mm1/drivers/scsi/ips.h
@@ -56,9 +56,7 @@
/*
* Some handy macros
*/
-   #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,20) || defined CONFIG_HIGHIO
#define IPS_HIGHIO
-   #endif

#define IPS_HA(x)                   ((ips_ha_t *) x->hostdata)
#define IPS_COMMAND_ID(ha, scb)     (int) (scb - ha->scbs)
@@ -82,31 +80,7 @@
#define IPS_SGLIST_SIZE(ha)       (IPS_USE_ENH_SGLIST(ha) ?                                           sizeof(IPS_ENH_SG_LIST) : sizeof(IPS_STD_SG_LIST))

-   #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,4)
-      #define pci_set_dma_mask(dev,mask) ( mask > 0xffffffff ? 1:0 )
-      #define scsi_set_pci_device(sh,dev) (0)
-   #endif

-   #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-
-      #ifndef irqreturn_t
-         typedef void irqreturn_t;
-      #endif
-
-      #define IRQ_NONE
-      #define IRQ_HANDLED
-      #define IRQ_RETVAL(x)
-      #define IPS_REGISTER_HOSTS(SHT)      scsi_register_module(MODULE_SCSI_HA,SHT)
-      #define IPS_UNREGISTER_HOSTS(SHT)    scsi_unregister_module(MODULE_SCSI_HA,SHT)
-      #define IPS_ADD_HOST(shost,device)
-      #define IPS_REMOVE_HOST(shost)
-      #define IPS_SCSI_SET_DEVICE(sh,ha)   scsi_set_pci_device(sh, (ha)->pcidev)
-      #define IPS_PRINTK(level, pcidev, format, arg...)                 -            printk(level "%s %s:" format , "ips" ,     -            (pcidev)->slot_name , ## arg)
-      #define scsi_host_alloc(sh,size)         scsi_register(sh,size)
-      #define scsi_host_put(sh)             scsi_unregister(sh)
-   #else
#define IPS_REGISTER_HOSTS(SHT)      (!ips_detect(SHT))
#define IPS_UNREGISTER_HOSTS(SHT)
#define IPS_ADD_HOST(shost,device)   do { scsi_add_host(shost,device); scsi_scan_host(shost); } while (0)
@@ -114,7 +88,6 @@
#define IPS_SCSI_SET_DEVICE(sh,ha)   do { } while (0)
#define IPS_PRINTK(level, pcidev, format, arg...)                              dev_printk(level , &((pcidev)->dev) , format , ## arg)
-   #endif

#ifndef MDELAY
#define MDELAY mdelay
@@ -444,16 +417,10 @@
/*
* Scsi_Host Template
*/
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-   static int ips_proc24_info(char *, char **, off_t, int, int, int);
-   static void ips_select_queue_depth(struct Scsi_Host *, Scsi_Device *);
-   static int ips_biosparam(Disk *disk, kdev_t dev, int geom[]);
-#else
static int ips_proc_info(struct Scsi_Host *, char *, char **, off_t, int, int);
static int ips_biosparam(struct scsi_device *sdev, struct block_device *bdev,
sector_t capacity, int geom[]);
static int ips_slave_configure(Scsi_Device *SDptr);
-#endif

/*
* Raid Command Formats
