Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVGJVgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVGJVgo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVGJTjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:39:03 -0400
Received: from ns1.suse.de ([195.135.220.2]:9619 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261847AbVGJTf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:56 -0400
Date: Sun, 10 Jul 2005 19:35:55 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH 47/82] remove linux/version.h from drivers/scsi/pcmcia/nsp*
Message-ID: <20050710193555.47.XnJRow3522.2247.olh@nectarine.suse.de>
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
remove code for obsolete kernel versions

Signed-off-by: Olaf Hering <olh@suse.de>

drivers/scsi/pcmcia/nsp_cs.c |  158 -------------------------------------------
drivers/scsi/pcmcia/nsp_cs.h |   68 ------------------
2 files changed, 226 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/pcmcia/nsp_cs.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/pcmcia/nsp_cs.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/pcmcia/nsp_cs.c
@@ -27,7 +27,6 @@

/* $Id: nsp_cs.c,v 1.23 2003/08/18 11:09:19 elca Exp $ */

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
@@ -85,10 +84,6 @@ static Scsi_Host_Template nsp_driver_tem
.proc_name	         = "nsp_cs",
.proc_info		 = nsp_proc_info,
.name			 = "WorkBit NinjaSCSI-3/32Bi(16bit)",
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
-	.detect			 = nsp_detect_old,
-	.release		 = nsp_release_old,
-#endif
.info			 = nsp_info,
.queuecommand		 = nsp_queuecommand,
/*	.eh_abort_handler	 = nsp_eh_abort,*/
@@ -99,9 +94,6 @@ static Scsi_Host_Template nsp_driver_tem
.sg_tablesize		 = SG_ALL,
.cmd_per_lun		 = 1,
.use_clustering		 = DISABLE_CLUSTERING,
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,2))
-	.use_new_eh_code	 = 1,
-#endif
};

static dev_link_t *dev_list = NULL;
@@ -1316,11 +1308,7 @@ static struct Scsi_Host *nsp_detect(Scsi
nsp_hw_data *data_b = &nsp_data_base, *data;

nsp_dbg(NSP_DEBUG_INIT, "this_id=%d", sht->this_id);
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
host = scsi_host_alloc(&nsp_driver_template, sizeof(nsp_hw_data));
-#else
-	host = scsi_register(sht, sizeof(nsp_hw_data));
-#endif
if (host == NULL) {
nsp_dbg(NSP_DEBUG_INIT, "host failed");
return NULL;
@@ -1357,37 +1345,6 @@ static struct Scsi_Host *nsp_detect(Scsi
return host; /* detect done. */
}

-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
-static int nsp_detect_old(Scsi_Host_Template *sht)
-{
-	if (nsp_detect(sht) == NULL) {
-		return 0;
-	} else {
-		//MOD_INC_USE_COUNT;
-		return 1;
-	}
-}
-
-
-static int nsp_release_old(struct Scsi_Host *shpnt)
-{
-	//nsp_hw_data *data = (nsp_hw_data *)shpnt->hostdata;
-
-	/* PCMCIA Card Service dose same things below. */
-	/* So we do nothing.                           */
-	//if (shpnt->irq) {
-	//	free_irq(shpnt->irq, data->ScsiInfo);
-	//}
-	//if (shpnt->io_port) {
-	//	release_region(shpnt->io_port, shpnt->n_io_port);
-	//}
-
-	//MOD_DEC_USE_COUNT;
-
-	return 0;
-}
-#endif
-
/*----------------------------------------------------------------*/
/* return info string						  */
/*----------------------------------------------------------------*/
@@ -1408,16 +1365,11 @@ static const char *nsp_info(struct Scsi_
} while(0)
static int
nsp_proc_info(
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
struct Scsi_Host *host,
-#endif
char  *buffer,
char **start,
off_t  offset,
int    length,
-#if !(LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
-	int    hostno,
-#endif
int    inout)
{
int id;
@@ -1426,24 +1378,12 @@ nsp_proc_info(
int speed;
unsigned long flags;
nsp_hw_data *data;
-#if !(LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
-	struct Scsi_Host *host;
-#else
int hostno;
-#endif
if (inout) {
return -EINVAL;
}

-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
hostno = host->host_no;
-#else
-	/* search this HBA host */
-	host = scsi_host_hn_get(hostno);
-	if (host == NULL) {
-		return -ESRCH;
-	}
-#endif
data = (nsp_hw_data *)host->hostdata;


@@ -1716,10 +1656,6 @@ static void nsp_cs_config(dev_link_t *li
cistpl_cftable_entry_t dflt = { 0 };
struct Scsi_Host *host;
nsp_hw_data      *data = &nsp_data_base;
-#if !(LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,74))
-	Scsi_Device	 *dev;
-	dev_node_t	**tail, *node;
-#endif

nsp_dbg(NSP_DEBUG_INIT, "in");

@@ -1865,17 +1801,7 @@ static void nsp_cs_config(dev_link_t *li
goto cs_failed;
}

-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,2))
host = nsp_detect(&nsp_driver_template);
-#else
-	scsi_register_host(&nsp_driver_template);
-	for (host = scsi_host_get_next(NULL); host != NULL;
-	     host = scsi_host_get_next(host)) {
-		if (host->hostt == &nsp_driver_template) {
-			break;
-		}
-	}
-#endif

if (host == NULL) {
nsp_dbg(NSP_DEBUG_INIT, "detect failed");
@@ -1883,7 +1809,6 @@ static void nsp_cs_config(dev_link_t *li
}


-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,74))
scsi_add_host (host, NULL);
scsi_scan_host(host);

@@ -1891,52 +1816,6 @@ static void nsp_cs_config(dev_link_t *li
link->dev  = &info->node;
info->host = host;

-#else
-	nsp_dbg(NSP_DEBUG_INIT, "GET_SCSI_INFO");
-	tail = &link->dev;
-	info->ndev = 0;
-
-	nsp_dbg(NSP_DEBUG_INIT, "host=0x%p", host);
-
-	for (dev = host->host_queue; dev != NULL; dev = dev->next) {
-		unsigned long id;
-		id = (dev->id & 0x0f) + ((dev->lun & 0x0f) << 4) +
-			((dev->channel & 0x0f) << 8) +
-			((dev->host->host_no & 0x0f) << 12);
-		node = &info->node[info->ndev];
-		node->minor = 0;
-		switch (dev->type) {
-		case TYPE_TAPE:
-			node->major = SCSI_TAPE_MAJOR;
-			snprintf(node->dev_name, sizeof(node->dev_name), "st#%04lx", id);
-			break;
-		case TYPE_DISK:
-		case TYPE_MOD:
-			node->major = SCSI_DISK0_MAJOR;
-			snprintf(node->dev_name, sizeof(node->dev_name), "sd#%04lx", id);
-			break;
-		case TYPE_ROM:
-		case TYPE_WORM:
-			node->major = SCSI_CDROM_MAJOR;
-			snprintf(node->dev_name, sizeof(node->dev_name), "sr#%04lx", id);
-			break;
-		default:
-			node->major = SCSI_GENERIC_MAJOR;
-			snprintf(node->dev_name, sizeof(node->dev_name), "sg#%04lx", id);
-			break;
-		}
-		*tail = node; tail = &node->next;
-		info->ndev++;
-		info->host = dev->host;
-	}
-
-	*tail = NULL;
-	if (info->ndev == 0) {
-		nsp_msg(KERN_INFO, "no SCSI devices found");
-	}
-	nsp_dbg(NSP_DEBUG_INIT, "host=0x%p", host);
-#endif
-
/* Finally, report what we've done */
printk(KERN_INFO "nsp_cs: index 0x%02x: Vcc %d.%d",
link->conf.ConfigIndex,
@@ -1991,13 +1870,9 @@ static void nsp_cs_release(dev_link_t *l
nsp_dbg(NSP_DEBUG_INIT, "link=0x%p", link);

/* Unlink the device chain */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,2))
if (info->host != NULL) {
scsi_remove_host(info->host);
}
-#else
-	scsi_unregister_host(&nsp_driver_template);
-#endif
link->dev = NULL;

if (link->win) {
@@ -2014,11 +1889,9 @@ static void nsp_cs_release(dev_link_t *l
pcmcia_release_irq(link->handle, &link->irq);
}
link->state &= ~DEV_CONFIG;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,2))
if (info->host != NULL) {
scsi_host_put(info->host);
}
-#endif
} /* nsp_cs_release */

/*======================================================================
@@ -2057,9 +1930,6 @@ static int nsp_cs_event(event_t
case CS_EVENT_CARD_INSERTION:
nsp_dbg(NSP_DEBUG_INIT, "event: insert");
link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,68))
-		info->bus    =  args->bus;
-#endif
nsp_cs_config(link);
break;

@@ -2118,7 +1988,6 @@ static int nsp_cs_event(event_t
/*======================================================================*
*	module entry point
*====================================================================*/
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,68))
static struct pcmcia_device_id nsp_cs_ids[] = {
PCMCIA_DEVICE_PROD_ID123("IO DATA", "CBSC16       ", "1", 0x547e66dc, 0x0d63a3fd, 0x51de003a),
PCMCIA_DEVICE_PROD_ID123("KME    ", "SCSI-CARD-001", "1", 0x534c02bc, 0x52008408, 0x51de003a),
@@ -2141,47 +2010,20 @@ static struct pcmcia_driver nsp_driver =
.detach		= nsp_cs_detach,
.id_table	= nsp_cs_ids,
};
-#endif

static int __init nsp_cs_init(void)
{
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,68))
nsp_msg(KERN_INFO, "loading...");

return pcmcia_register_driver(&nsp_driver);
-#else
-	servinfo_t serv;
-
-	nsp_msg(KERN_INFO, "loading...");
-	pcmcia_get_card_services_info(&serv);
-	if (serv.Revision != CS_RELEASE_CODE) {
-		nsp_msg(KERN_DEBUG, "Card Services release does not match!");
-		return -EINVAL;
-	}
-	register_pcmcia_driver(&dev_info, &nsp_cs_attach, &nsp_cs_detach);
-
-	nsp_dbg(NSP_DEBUG_INIT, "out");
-	return 0;
-#endif
}

static void __exit nsp_cs_exit(void)
{
nsp_msg(KERN_INFO, "unloading...");

-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,68))
pcmcia_unregister_driver(&nsp_driver);
BUG_ON(dev_list != NULL);
-#else
-	unregister_pcmcia_driver(&dev_info);
-	/* XXX: this really needs to move into generic code.. */
-	while (dev_list != NULL) {
-		if (dev_list->state & DEV_CONFIG) {
-			nsp_cs_release(dev_list);
-		}
-		nsp_cs_detach(dev_list);
-	}
-#endif
}


Index: linux-2.6.13-rc2-mm1/drivers/scsi/pcmcia/nsp_cs.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/pcmcia/nsp_cs.h
+++ linux-2.6.13-rc2-mm1/drivers/scsi/pcmcia/nsp_cs.h
@@ -227,13 +227,7 @@
typedef struct scsi_info_t {
dev_link_t             link;
struct Scsi_Host      *host;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,74))
dev_node_t             node;
-#else
-	int	               ndev;
-	dev_node_t             node[8];
-	struct bus_operations *bus;
-#endif
int                    stop;
} scsi_info_t;

@@ -304,22 +298,13 @@ static int         nsp_cs_event  (event_

/* Linux SCSI subsystem specific functions */
static struct Scsi_Host *nsp_detect     (Scsi_Host_Template *sht);
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
-static        int        nsp_detect_old (Scsi_Host_Template *sht);
-static        int        nsp_release_old(struct Scsi_Host *shpnt);
-#endif
static const  char      *nsp_info       (struct Scsi_Host *shpnt);
static        int        nsp_proc_info  (
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
struct Scsi_Host *host,
-#endif
char   *buffer,
char  **start,
off_t   offset,
int     length,
-#if !(LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
-					 int     hostno,
-#endif
int     inout);
static        int        nsp_queuecommand(Scsi_Cmnd *SCpnt, void (* done)(Scsi_Cmnd *SCpnt));

@@ -412,61 +397,8 @@ enum _burst_mode {
#define MSG_EXT_SDTR         0x01


-/**************************************************************************
- * Compatibility functions
- */
-
-/* for Kernel 2.4 */
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0))
-#  define scsi_register_host(template)   scsi_register_module(MODULE_SCSI_HA, template)
-#  define scsi_unregister_host(template) scsi_unregister_module(MODULE_SCSI_HA, template)
-#  define scsi_host_put(host)            scsi_unregister(host)
-
-typedef void irqreturn_t;
-#  define IRQ_NONE      /* */
-#  define IRQ_HANDLED   /* */
-#  define IRQ_RETVAL(x) /* */
-
-/* This is ad-hoc version of scsi_host_get_next() */
-static inline struct Scsi_Host *scsi_host_get_next(struct Scsi_Host *host)
-{
-	if (host == NULL) {
-		return scsi_hostlist;
-	} else {
-		return host->next;
-	}
-}
-
-/* This is ad-hoc version of scsi_host_hn_get() */
-static inline struct Scsi_Host *scsi_host_hn_get(unsigned short hostno)
-{
-	struct Scsi_Host *host;
-
-	for (host = scsi_host_get_next(NULL); host != NULL;
-	     host = scsi_host_get_next(host)) {
-		if (host->host_no == hostno) {
-			break;
-		}
-	}
-
-	return host;
-}
-
-static void cs_error(client_handle_t handle, int func, int ret)
-{
-	error_info_t err = { func, ret };
-	pcmcia_report_error(handle, &err);
-}
-
-/* scatter-gather table */
-#  define BUFFER_ADDR (SCpnt->SCp.buffer->address)
-#endif
-
-/* for Kernel 2.6 */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0))
/* scatter-gather table */
#  define BUFFER_ADDR ((char *)((unsigned int)(SCpnt->SCp.buffer->page) + SCpnt->SCp.buffer->offset))
-#endif

#endif  /*__nsp_cs__*/
/* end */
