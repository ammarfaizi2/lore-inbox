Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVGJVgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVGJVgk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVGJTja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:39:30 -0400
Received: from ns1.suse.de ([195.135.220.2]:4755 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261799AbVGJTfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:46 -0400
Date: Sun, 10 Jul 2005 19:35:45 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       Achim Leubner <achim_leubner@adaptec.com>
Subject: [PATCH 37/82] remove linux/version.h from drivers/scsi/gdth
Message-ID: <20050710193545.37.eRXtWE3260.2247.olh@nectarine.suse.de>
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

drivers/scsi/gdth.c      |  204 -----------------------------------------------
drivers/scsi/gdth.h      |   11 --
drivers/scsi/gdth_proc.c |  143 --------------------------------
drivers/scsi/gdth_proc.h |    6 -
4 files changed, 1 insertion(+), 363 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/gdth.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/gdth.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/gdth.c
@@ -374,7 +374,6 @@

#include <linux/module.h>

-#include <linux/version.h>
#include <linux/kernel.h>
#include <linux/types.h>
#include <linux/pci.h>
@@ -398,12 +397,7 @@
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
@@ -2135,29 +2129,17 @@ static int __init gdth_search_drives(int
printk("GDT-HA %d: Vendor: %s Name: %sn",
hanum,oemstr->text.oem_company_name,ha->binfo.type_string);
/* Save the Host Drive inquiry data */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
strlcpy(ha->oem_name,oemstr->text.scsi_host_drive_inquiry_vendor_id,
sizeof(ha->oem_name));
-#else
-        strncpy(ha->oem_name,oemstr->text.scsi_host_drive_inquiry_vendor_id,7);
-        ha->oem_name[7] = '0';
-#endif
} else {
/* Old method, based on PCI ID */
TRACE2(("gdth_search_drives(): CACHE_READ_OEM_STRING_RECORD failedn"));
printk("GDT-HA %d: Name: %sn",
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
@@ -4293,10 +4275,6 @@ static int __init gdth_detect(Scsi_Host_
hdr_channel = ha->bus_cnt;
ha->virt_bus = hdr_channel;

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,20) && -    LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
-                shp->highmem_io  = 0;
-#endif
if (ha->cache_feat & ha->raw_feat & ha->screen_feat & GDT_64BIT)
shp->max_cmd_len = 16;

@@ -4417,10 +4395,6 @@ static int __init gdth_detect(Scsi_Host_
hdr_channel = ha->bus_cnt;
ha->virt_bus = hdr_channel;

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,20) && -    LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
-                shp->highmem_io  = 0;
-#endif
if (ha->cache_feat & ha->raw_feat & ha->screen_feat & GDT_64BIT)
shp->max_cmd_len = 16;

@@ -4521,9 +4495,6 @@ static int __init gdth_detect(Scsi_Host_
ha->virt_bus = hdr_channel;


-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
-            scsi_set_pci_device(shp, pcistr[ctr].pdev);
-#endif
if (!(ha->cache_feat & ha->raw_feat & ha->screen_feat &GDT_64BIT)||
/* 64-bit DMA only supported from FW >= x.43 */
(!ha->dma64_support)) {
@@ -4755,11 +4726,7 @@ static int gdth_eh_bus_reset(Scsi_Cmnd *
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
@@ -4767,13 +4734,8 @@ static int gdth_bios_param(Disk *disk,kd
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
@@ -4921,11 +4883,7 @@ static int ioc_resetdrv(void __user *arg
gdth_cmd_str cmd;
int hanum;
gdth_ha_str *ha;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
Scsi_Request *srp;
-#else
-    Scsi_Cmnd *scp;
-#endif

if (copy_from_user(&res, arg, sizeof(gdth_ioctl_reset)) ||
res.ionode >= gdth_ctr_count || res.number >= MAX_HDRIVES)
@@ -4942,7 +4900,6 @@ static int ioc_resetdrv(void __user *arg
cmd.u.cache64.DeviceNo = res.number;
else
cmd.u.cache.DeviceNo = res.number;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
srp  = scsi_allocate_request(ha->sdev, GFP_KERNEL);
if (!srp)
return -ENOMEM;
@@ -4951,16 +4908,6 @@ static int ioc_resetdrv(void __user *arg
gdth_do_req(srp, &cmd, cmnd, 30);
res.status = (ushort)srp->sr_command->SCp.Status;
scsi_release_request(srp);
-#else
-    scp  = scsi_allocate_device(ha->sdev, 1, FALSE);
-    if (!scp)
-        return -ENOMEM;
-    scp->cmd_len = 12;
-    scp->use_sg = 0;
-    gdth_do_cmd(scp, &cmd, cmnd, 30);
-    res.status = (ushort)scp->SCp.Status;
-    scsi_release_command(scp);
-#endif

if (copy_to_user(arg, &res, sizeof(gdth_ioctl_reset)))
return -EFAULT;
@@ -4974,11 +4921,7 @@ static int ioc_general(void __user *arg,
ulong64 paddr;
int hanum;
gdth_ha_str *ha;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
Scsi_Request *srp;
-#else
-        Scsi_Cmnd *scp;
-#endif

if (copy_from_user(&gen, arg, sizeof(gdth_ioctl_general)) ||
gen.ionode >= gdth_ctr_count)
@@ -5070,7 +5013,6 @@ static int ioc_general(void __user *arg,
}
}

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
srp  = scsi_allocate_request(ha->sdev, GFP_KERNEL);
if (!srp)
return -ENOMEM;
@@ -5080,17 +5022,6 @@ static int ioc_general(void __user *arg,
gen.status = srp->sr_command->SCp.Status;
gen.info = srp->sr_command->SCp.Message;
scsi_release_request(srp);
-#else
-    scp  = scsi_allocate_device(ha->sdev, 1, FALSE);
-    if (!scp)
-        return -ENOMEM;
-    scp->cmd_len = 12;
-    scp->use_sg = 0;
-    gdth_do_cmd(scp, &gen.command, cmnd, gen.timeout);
-    gen.status = scp->SCp.Status;
-    gen.info = scp->SCp.Message;
-    scsi_release_command(scp);
-#endif

if (copy_to_user(arg + sizeof(gdth_ioctl_general), buf,
gen.data_len + gen.sense_len)) {
@@ -5113,11 +5044,7 @@ static int ioc_hdrlist(void __user *arg,
gdth_ha_str *ha;
unchar i;
int hanum, rc = -ENOMEM;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
Scsi_Request *srp;
-#else
-    Scsi_Cmnd *scp;
-#endif

rsc = kmalloc(sizeof(*rsc), GFP_KERNEL);
cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
@@ -5133,19 +5060,11 @@ static int ioc_hdrlist(void __user *arg,
ha = HADATA(gdth_ctr_tab[hanum]);
memset(cmd, 0, sizeof(gdth_cmd_str));

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
srp  = scsi_allocate_request(ha->sdev, GFP_KERNEL);
if (!srp)
goto free_fail;
srp->sr_cmd_len = 12;
srp->sr_use_sg = 0;
-#else
-    scp  = scsi_allocate_device(ha->sdev, 1, FALSE);
-    if (!scp)
-        goto free_fail;
-    scp->cmd_len = 12;
-    scp->use_sg = 0;
-#endif

for (i = 0; i < MAX_HDRIVES; ++i) {
if (!ha->hdr[i].present) {
@@ -5163,22 +5082,12 @@ static int ioc_hdrlist(void __user *arg,
cmd->u.cache64.DeviceNo = i;
else
cmd->u.cache.DeviceNo = i;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
gdth_do_req(srp, cmd, cmnd, 30);
if (srp->sr_command->SCp.Status == S_OK)
rsc->hdr_list[i].cluster_type = srp->sr_command->SCp.Message;
-#else
-            gdth_do_cmd(scp, cmd, cmnd, 30);
-            if (scp->SCp.Status == S_OK)
-                rsc->hdr_list[i].cluster_type = scp->SCp.Message;
-#endif
}
}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
scsi_release_request(srp);
-#else
-    scsi_release_command(scp);
-#endif

if (copy_to_user(arg, rsc, sizeof(gdth_ioctl_rescan)))
rc = -EFAULT;
@@ -5201,11 +5110,7 @@ static int ioc_rescan(void __user *arg,
int rc = -ENOMEM;
ulong flags;
gdth_ha_str *ha;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
Scsi_Request *srp;
-#else
-    Scsi_Cmnd *scp;
-#endif

rsc = kmalloc(sizeof(*rsc), GFP_KERNEL);
cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
@@ -5221,19 +5126,11 @@ static int ioc_rescan(void __user *arg,
ha = HADATA(gdth_ctr_tab[hanum]);
memset(cmd, 0, sizeof(gdth_cmd_str));

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
srp  = scsi_allocate_request(ha->sdev, GFP_KERNEL);
if (!srp)
goto free_fail;
srp->sr_cmd_len = 12;
srp->sr_use_sg = 0;
-#else
-    scp  = scsi_allocate_device(ha->sdev, 1, FALSE);
-    if (!scp)
-        goto free_fail;
-    scp->cmd_len = 12;
-    scp->use_sg = 0;
-#endif

if (rsc->flag == 0) {
/* old method: re-init. cache service */
@@ -5245,19 +5142,9 @@ static int ioc_rescan(void __user *arg,
cmd->OpCode = GDT_INIT;
cmd->u.cache.DeviceNo = LINUX_OS;
}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
gdth_do_req(srp, cmd, cmnd, 30);
status = (ushort)srp->sr_command->SCp.Status;
info = (ulong32)srp->sr_command->SCp.Message;
-#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
-        gdth_do_cmd(scp, cmd, cmnd, 30);
-        status = (ushort)scp->SCp.Status;
-        info = (ulong32)scp->SCp.Message;
-#else
-        gdth_do_cmd(&scp, cmd, cmnd, 30);
-        status = (ushort)scp.SCp.Status;
-        info = (ulong32)scp.SCp.Message;
-#endif
i = 0;
hdr_cnt = (status == S_OK ? (ushort)info : 0);
} else {
@@ -5272,15 +5159,9 @@ static int ioc_rescan(void __user *arg,
cmd->u.cache64.DeviceNo = i;
else
cmd->u.cache.DeviceNo = i;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
gdth_do_req(srp, cmd, cmnd, 30);
status = (ushort)srp->sr_command->SCp.Status;
info = (ulong32)srp->sr_command->SCp.Message;
-#else
-        gdth_do_cmd(scp, cmd, cmnd, 30);
-        status = (ushort)scp->SCp.Status;
-        info = (ulong32)scp->SCp.Message;
-#endif
spin_lock_irqsave(&ha->smp_lock, flags);
rsc->hdr_list[i].bus = ha->virt_bus;
rsc->hdr_list[i].target = i;
@@ -5312,15 +5193,9 @@ static int ioc_rescan(void __user *arg,
cmd->u.cache64.DeviceNo = i;
else
cmd->u.cache.DeviceNo = i;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
gdth_do_req(srp, cmd, cmnd, 30);
status = (ushort)srp->sr_command->SCp.Status;
info = (ulong32)srp->sr_command->SCp.Message;
-#else
-        gdth_do_cmd(scp, cmd, cmnd, 30);
-        status = (ushort)scp->SCp.Status;
-        info = (ulong32)scp->SCp.Message;
-#endif
spin_lock_irqsave(&ha->smp_lock, flags);
ha->hdr[i].devtype = (status == S_OK ? (ushort)info : 0);
spin_unlock_irqrestore(&ha->smp_lock, flags);
@@ -5331,15 +5206,9 @@ static int ioc_rescan(void __user *arg,
cmd->u.cache64.DeviceNo = i;
else
cmd->u.cache.DeviceNo = i;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
gdth_do_req(srp, cmd, cmnd, 30);
status = (ushort)srp->sr_command->SCp.Status;
info = (ulong32)srp->sr_command->SCp.Message;
-#else
-        gdth_do_cmd(scp, cmd, cmnd, 30);
-        status = (ushort)scp->SCp.Status;
-        info = (ulong32)scp->SCp.Message;
-#endif
spin_lock_irqsave(&ha->smp_lock, flags);
ha->hdr[i].cluster_type =
((status == S_OK && !shared_access) ? (ushort)info : 0);
@@ -5352,24 +5221,14 @@ static int ioc_rescan(void __user *arg,
cmd->u.cache64.DeviceNo = i;
else
cmd->u.cache.DeviceNo = i;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
gdth_do_req(srp, cmd, cmnd, 30);
status = (ushort)srp->sr_command->SCp.Status;
info = (ulong32)srp->sr_command->SCp.Message;
-#else
-        gdth_do_cmd(scp, cmd, cmnd, 30);
-        status = (ushort)scp->SCp.Status;
-        info = (ulong32)scp->SCp.Message;
-#endif
spin_lock_irqsave(&ha->smp_lock, flags);
ha->hdr[i].rw_attribs = (status == S_OK ? (ushort)info : 0);
spin_unlock_irqrestore(&ha->smp_lock, flags);
}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
scsi_release_request(srp);
-#else
-    scsi_release_command(scp);
-#endif

if (copy_to_user(arg, rsc, sizeof(gdth_ioctl_rescan)))
rc = -EFAULT;
@@ -5416,9 +5275,7 @@ static int gdth_ioctl(struct inode *inod
{
gdth_ioctl_osvers osv;

-        osv.version = (unchar)(LINUX_VERSION_CODE >> 16);
-        osv.subversion = (unchar)(LINUX_VERSION_CODE >> 8);
-        osv.revision = (ushort)(LINUX_VERSION_CODE & 0xff);
+	memset(&osv, 0, sizeof(osv));
if (copy_to_user(argp, &osv, sizeof(gdth_ioctl_osvers)))
return -EFAULT;
break;
@@ -5515,7 +5372,6 @@ static int gdth_ioctl(struct inode *inod
ha = HADATA(gdth_ctr_tab[hanum]);

/* Because we need a Scsi_Cmnd struct., we make a scsi_allocate device also for kernels >=2.6.x */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
scp  = scsi_get_command(ha->sdev, GFP_KERNEL);
if (!scp)
return -ENOMEM;
@@ -5525,17 +5381,6 @@ static int gdth_ioctl(struct inode *inod
rval = gdth_eh_bus_reset(scp);
res.status = (rval == SUCCESS ? S_OK : S_GENERR);
scsi_put_command(scp);
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
if (copy_to_user(argp, &res, sizeof(gdth_ioctl_reset)))
return -EFAULT;
break;
@@ -5557,11 +5402,7 @@ static void gdth_flush(int hanum)
int             i;
gdth_ha_str     *ha;
gdth_cmd_str    gdtcmd;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
Scsi_Request    *srp;
-#else
-    Scsi_Cmnd       *scp;
-#endif
Scsi_Device     *sdev;
char            cmnd[MAX_COMMAND_SIZE];
memset(cmnd, 0xff, MAX_COMMAND_SIZE);
@@ -5569,21 +5410,12 @@ static void gdth_flush(int hanum)
TRACE2(("gdth_flush() hanum %dn",hanum));
ha = HADATA(gdth_ctr_tab[hanum]);

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
sdev = scsi_get_host_dev(gdth_ctr_tab[hanum]);
srp  = scsi_allocate_request(sdev, GFP_KERNEL);
if (!srp)
return;
srp->sr_cmd_len = 12;
srp->sr_use_sg = 0;
-#else
-    sdev = scsi_get_host_dev(gdth_ctr_tab[hanum]);
-    scp  = scsi_allocate_device(sdev, 1, FALSE);
-    if (!scp)
-        return;
-    scp->cmd_len = 12;
-    scp->use_sg = 0;
-#endif

for (i = 0; i < MAX_HDRIVES; ++i) {
if (ha->hdr[i].present) {
@@ -5600,20 +5432,11 @@ static void gdth_flush(int hanum)
gdtcmd.u.cache.sg_canz = 0;
}
TRACE2(("gdth_flush(): flush ha %d drive %dn", hanum, i));
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
gdth_do_req(srp, &gdtcmd, cmnd, 30);
-#else
-            gdth_do_cmd(scp, &gdtcmd, cmnd, 30);
-#endif
}
}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
scsi_release_request(srp);
scsi_free_host_dev(sdev);
-#else
-    scsi_release_command(scp);
-    scsi_free_host_dev(sdev);
-#endif
}

/* shutdown routine */
@@ -5622,13 +5445,8 @@ static int gdth_halt(struct notifier_blo
int             hanum;
#ifndef __alpha__
gdth_cmd_str    gdtcmd;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
Scsi_Request    *srp;
Scsi_Device     *sdev;
-#else
-    Scsi_Cmnd       *scp;
-    Scsi_Device     *sdev;
-#endif
char            cmnd[MAX_COMMAND_SIZE];
#endif

@@ -5647,7 +5465,6 @@ static int gdth_halt(struct notifier_blo
gdtcmd.Service = CACHESERVICE;
gdtcmd.OpCode = GDT_RESET;
TRACE2(("gdth_halt(): reset controller %dn", hanum));
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
sdev = scsi_get_host_dev(gdth_ctr_tab[hanum]);
srp  = scsi_allocate_request(sdev, GFP_KERNEL);
if (!srp) {
@@ -5659,19 +5476,6 @@ static int gdth_halt(struct notifier_blo
gdth_do_req(srp, &gdtcmd, cmnd, 10);
scsi_release_request(srp);
scsi_free_host_dev(sdev);
-#else
-        sdev = scsi_get_host_dev(gdth_ctr_tab[hanum]);
-        scp  = scsi_allocate_device(sdev, 1, FALSE);
-        if (!scp) {
-            unregister_reboot_notifier(&gdth_notifier);
-            return NOTIFY_OK;
-        }
-        scp->cmd_len = 12;
-        scp->use_sg = 0;
-        gdth_do_cmd(scp, &gdtcmd, cmnd, 10);
-        scsi_release_command(scp);
-        scsi_free_host_dev(sdev);
-#endif
#endif
}
printk("Done.n");
@@ -5699,12 +5503,6 @@ static Scsi_Host_Template driver_templat
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
Index: linux-2.6.13-rc2-mm1/drivers/scsi/gdth.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/gdth.h
+++ linux-2.6.13-rc2-mm1/drivers/scsi/gdth.h
@@ -13,7 +13,6 @@
* $Id: gdth.h,v 1.57 2004/03/31 11:52:09 achim Exp $
*/

-#include <linux/version.h>
#include <linux/types.h>

#ifndef TRUE
@@ -936,18 +935,12 @@ typedef struct {
gdth_binfo_str      binfo;                  /* controller info */
gdth_evt_data       dvr;                    /* event structure */
spinlock_t          smp_lock;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
struct pci_dev      *pdev;
-#endif
char                oem_name[8];
#ifdef GDTH_DMA_STATISTICS
ulong               dma32_cnt, dma64_cnt;   /* statistics: DMA buffer */
#endif
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
Scsi_Device         *sdev;
-#else
-    Scsi_Device         sdev;
-#endif
} gdth_ha_str;

/* structure for scsi_register(), SCSI bus != 0 */
@@ -1029,10 +1022,6 @@ typedef struct {

/* function prototyping */

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
int gdth_proc_info(struct Scsi_Host *, char *,char **,off_t,int,int);
-#else
-int gdth_proc_info(char *,char **,off_t,int,int,int);
-#endif

#endif
Index: linux-2.6.13-rc2-mm1/drivers/scsi/gdth_proc.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/gdth_proc.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/gdth_proc.c
@@ -4,7 +4,6 @@

#include <linux/completion.h>

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
int gdth_proc_info(struct Scsi_Host *host, char *buffer,char **start,off_t offset,int length,
int inout)
{
@@ -21,61 +20,21 @@ int gdth_proc_info(struct Scsi_Host *hos
else
return(gdth_get_info(buffer,start,offset,length,host,hanum,busnum));
}
-#else
-int gdth_proc_info(char *buffer,char **start,off_t offset,int length,int hostno,
-                   int inout)
-{
-    int hanum,busnum,i;
-
-    TRACE2(("gdth_proc_info() length %d offs %d inout %dn",
-            length,(int)offset,inout));
-
-    for (i = 0; i < gdth_ctr_vcount; ++i) {
-        if (gdth_ctr_vtab[i]->host_no == hostno)
-            break;
-    }
-    if (i == gdth_ctr_vcount)
-        return(-EINVAL);
-
-    hanum = NUMDATA(gdth_ctr_vtab[i])->hanum;
-    busnum= NUMDATA(gdth_ctr_vtab[i])->busnum;
-
-    if (inout)
-        return(gdth_set_info(buffer,length,gdth_ctr_vtab[i],hanum,busnum));
-    else
-        return(gdth_get_info(buffer,start,offset,length,
-                             gdth_ctr_vtab[i],hanum,busnum));
-}
-#endif

static int gdth_set_info(char *buffer,int length,struct Scsi_Host *host,
int hanum,int busnum)
{
int             ret_val = -EINVAL;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
Scsi_Request    *scp;
Scsi_Device     *sdev;
-#else
-    Scsi_Cmnd       *scp;
-    Scsi_Device     *sdev;
-#endif
TRACE2(("gdth_set_info() ha %d bus %dn",hanum,busnum));

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
sdev = scsi_get_host_dev(host);
scp  = scsi_allocate_request(sdev, GFP_KERNEL);
if (!scp)
return -ENOMEM;
scp->sr_cmd_len = 12;
scp->sr_use_sg = 0;
-#else
-    sdev = scsi_get_host_dev(host);
-    scp  = scsi_allocate_device(sdev, 1, FALSE);
-    if (!scp)
-        return -ENOMEM;
-    scp->cmd_len = 12;
-    scp->use_sg = 0;
-#endif

if (length >= 4) {
if (strncmp(buffer,"gdth",4) == 0) {
@@ -84,21 +43,12 @@ static int gdth_set_info(char *buffer,in
ret_val = gdth_set_asc_info( buffer, length, hanum, scp );
}
}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
scsi_release_request(scp);
scsi_free_host_dev(sdev);
-#else
-    scsi_release_command(scp);
-    scsi_free_host_dev(sdev);
-#endif
return ret_val;
}

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
static int gdth_set_asc_info(char *buffer,int length,int hanum,Scsi_Request *scp)
-#else
-static int gdth_set_asc_info(char *buffer,int length,int hanum,Scsi_Cmnd *scp)
-#endif
{
int             orig_length, drive, wb_mode;
int             i, found;
@@ -146,11 +96,7 @@ static int gdth_set_asc_info(char *buffe
gdtcmd.u.cache.DeviceNo = i;
gdtcmd.u.cache.BlockNo = 1;
}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
gdth_do_req(scp, &gdtcmd, cmnd, 30);
-#else
-                gdth_do_cmd(scp, &gdtcmd, cmnd, 30);
-#endif
}
}
if (!found)
@@ -202,11 +148,7 @@ static int gdth_set_asc_info(char *buffe
gdtcmd.u.ioctl.subfunc = CACHE_CONFIG;
gdtcmd.u.ioctl.channel = INVALID_CHANNEL;
pcpar->write_back = wb_mode==1 ? 0:1;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
gdth_do_req(scp, &gdtcmd, cmnd, 30);
-#else
-        gdth_do_cmd(scp, &gdtcmd, cmnd, 30);
-#endif
gdth_ioctl_free(hanum, GDTH_SCRATCH, ha->pscratch, paddr);
printk("Done.n");
return(orig_length);
@@ -230,13 +172,8 @@ static int gdth_get_info(char *buffer,ch

gdth_cmd_str *gdtcmd;
gdth_evt_str *estr;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
Scsi_Request *scp;
Scsi_Device *sdev;
-#else
-    Scsi_Cmnd *scp;
-    Scsi_Device *sdev;
-#endif
char hrec[161];
struct timeval tv;

@@ -260,28 +197,12 @@ static int gdth_get_info(char *buffer,ch
TRACE2(("gdth_get_info() ha %d bus %dn",hanum,busnum));
ha = HADATA(gdth_ctr_tab[hanum]);

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
sdev = scsi_get_host_dev(host);
scp  = scsi_allocate_request(sdev, GFP_KERNEL);
if (!scp)
goto free_fail;
scp->sr_cmd_len = 12;
scp->sr_use_sg = 0;
-#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
-    sdev = scsi_get_host_dev(host);
-    scp  = scsi_allocate_device(sdev, 1, FALSE);
-    if (!scp)
-        goto free_fail;
-    scp->cmd_len = 12;
-    scp->use_sg = 0;
-#else
-    memset(&sdev,0,sizeof(Scsi_Device));
-    memset(&scp, 0,sizeof(Scsi_Cmnd));
-    sdev.host = scp.host = host;
-    sdev.id = scp.target = sdev.host->this_id;
-    scp.device = &sdev;
-#endif
-

/* request is i.e. "cat /proc/scsi/gdth/0" */
/* format: %-15st%-10st%-15st%s */
@@ -386,13 +307,8 @@ static int gdth_get_info(char *buffer,ch
sizeof(pds->list[0]);
if (pds->entries > cnt)
pds->entries = cnt;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
gdth_do_req(scp, gdtcmd, cmnd, 30);
if (scp->sr_command->SCp.Status != S_OK)
-#else
-            gdth_do_cmd(scp, gdtcmd, cmnd, 30);
-            if (scp->SCp.Status != S_OK)
-#endif
{
pds->count = 0;
}
@@ -410,13 +326,8 @@ static int gdth_get_info(char *buffer,ch
gdtcmd->u.ioctl.subfunc = SCSI_DR_INFO | L_CTRL_PATTERN;
gdtcmd->u.ioctl.channel =
ha->raw[i].address | ha->raw[i].id_list[j];
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
gdth_do_req(scp, gdtcmd, cmnd, 30);
if (scp->sr_command->SCp.Status == S_OK)
-#else
-                gdth_do_cmd(scp, gdtcmd, cmnd, 30);
-                if (scp->SCp.Status == S_OK)
-#endif
{
strncpy(hrec,pdi->vendor,8);
strncpy(hrec+8,pdi->product,16);
@@ -466,13 +377,8 @@ static int gdth_get_info(char *buffer,ch
gdtcmd->u.ioctl.channel =
ha->raw[i].address | ha->raw[i].id_list[j];
pdef->sddc_type = 0x08;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
gdth_do_req(scp, gdtcmd, cmnd, 30);
if (scp->sr_command->SCp.Status == S_OK)
-#else
-                    gdth_do_cmd(scp, gdtcmd, cmnd, 30);
-                    if (scp->SCp.Status == S_OK)
-#endif
{
size = sprintf(buffer+len,
" Grown Defects:t%dn",
@@ -519,13 +425,8 @@ static int gdth_get_info(char *buffer,ch
gdtcmd->u.ioctl.param_size = sizeof(gdth_cdrinfo_str);
gdtcmd->u.ioctl.subfunc = CACHE_DRV_INFO;
gdtcmd->u.ioctl.channel = drv_no;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
gdth_do_req(scp, gdtcmd, cmnd, 30);
if (scp->sr_command->SCp.Status != S_OK)
-#else
-                gdth_do_cmd(scp, gdtcmd, cmnd, 30);
-                if (scp->SCp.Status != S_OK)
-#endif
{
break;
}
@@ -629,13 +530,8 @@ static int gdth_get_info(char *buffer,ch
gdtcmd->u.ioctl.param_size = sizeof(gdth_arrayinf_str);
gdtcmd->u.ioctl.subfunc = ARRAY_INFO | LA_CTRL_PATTERN;
gdtcmd->u.ioctl.channel = i;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
gdth_do_req(scp, gdtcmd, cmnd, 30);
if (scp->sr_command->SCp.Status == S_OK)
-#else
-            gdth_do_cmd(scp, gdtcmd, cmnd, 30);
-            if (scp->SCp.Status == S_OK)
-#endif
{
if (pai->ai_state == 0)
strcpy(hrec, "idle");
@@ -710,13 +606,8 @@ static int gdth_get_info(char *buffer,ch
gdtcmd->u.ioctl.channel = i;
phg->entries = MAX_HDRIVES;
phg->offset = GDTOFFSOF(gdth_hget_str, entry[0]);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
gdth_do_req(scp, gdtcmd, cmnd, 30);
if (scp->sr_command->SCp.Status != S_OK)
-#else
-            gdth_do_cmd(scp, gdtcmd, cmnd, 30);
-            if (scp->SCp.Status != S_OK)
-#endif
{
ha->hdr[i].ldr_no = i;
ha->hdr[i].rw_attribs = 0;
@@ -791,13 +682,8 @@ static int gdth_get_info(char *buffer,ch
}

stop_output:
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
scsi_release_request(scp);
scsi_free_host_dev(sdev);
-#else
-    scsi_release_command(scp);
-    scsi_free_host_dev(sdev);
-#endif
*start = buffer +(offset-begin);
len -= (offset-begin);
if (len > length)
@@ -813,7 +699,6 @@ free_fail:
}


-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
static void gdth_do_req(Scsi_Request *scp, gdth_cmd_str *gdtcmd,
char *cmnd, int timeout)
{
@@ -832,42 +717,14 @@ static void gdth_do_req(Scsi_Request *sc
wait_for_completion(&wait);
}

-#else
-static void gdth_do_cmd(Scsi_Cmnd *scp, gdth_cmd_str *gdtcmd,
-                        char *cmnd, int timeout)
-{
-    unsigned bufflen;
-    DECLARE_COMPLETION(wait);
-
-    TRACE2(("gdth_do_cmd()n"));
-    if (gdtcmd != NULL) {
-        scp->SCp.this_residual = IOCTL_PRI;
-        bufflen = sizeof(gdth_cmd_str);
-    } else {
-        scp->SCp.this_residual = DEFAULT_PRI;
-        bufflen = 0;
-    }
-
-    scp->request.rq_status = RQ_SCSI_BUSY;
-    scp->request.waiting = &wait;
-    scsi_do_cmd(scp, cmnd, gdtcmd, bufflen, gdth_scsi_done, timeout*HZ, 1);
-    wait_for_completion(&wait);
-}
-#endif

void gdth_scsi_done(Scsi_Cmnd *scp)
{
TRACE2(("gdth_scsi_done()n"));

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
scp->request->rq_status = RQ_SCSI_DONE;
if (scp->request->waiting != NULL)
complete(scp->request->waiting);
-#else
-    scp->request.rq_status = RQ_SCSI_DONE;
-    if (scp->request.waiting != NULL)
-        complete(scp->request.waiting);
-#endif
}

static char *gdth_ioctl_alloc(int hanum, int size, int scratch,
Index: linux-2.6.13-rc2-mm1/drivers/scsi/gdth_proc.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/gdth_proc.h
+++ linux-2.6.13-rc2-mm1/drivers/scsi/gdth_proc.h
@@ -10,15 +10,9 @@ static int gdth_set_info(char *buffer,in
static int gdth_get_info(char *buffer,char **start,off_t offset,int length,
struct Scsi_Host *host,int hanum,int busnum);

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
static void gdth_do_req(Scsi_Request *srp, gdth_cmd_str *cmd,
char *cmnd, int timeout);
static int gdth_set_asc_info(char *buffer,int length,int hanum,Scsi_Request *scp);
-#else
-static void gdth_do_cmd(Scsi_Cmnd *scp, gdth_cmd_str *cmd,
-                        char *cmnd, int timeout);
-static int gdth_set_asc_info(char *buffer,int length,int hanum,Scsi_Cmnd *scp);
-#endif

static char *gdth_ioctl_alloc(int hanum, int size, int scratch,
ulong64 *paddr);
