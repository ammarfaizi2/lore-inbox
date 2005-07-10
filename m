Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVGJVgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVGJVgn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVGJTjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:39:06 -0400
Received: from ns2.suse.de ([195.135.220.15]:45020 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261836AbVGJTfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:54 -0400
Date: Sun, 10 Jul 2005 19:35:53 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH 45/82] remove linux/version.h from drivers/scsi/nsp32
Message-ID: <20050710193553.45.VmXXrX3470.2247.olh@nectarine.suse.de>
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

drivers/scsi/nsp32.c |   73 ---------------------------------------------------
drivers/scsi/nsp32.h |   42 -----------------------------
2 files changed, 115 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/nsp32.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/nsp32.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/nsp32.c
@@ -23,7 +23,6 @@
*   1.2: PowerPC (big endian) support.
*/

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/kernel.h>
@@ -49,10 +48,6 @@
#include <scsi/scsi_host.h>
#include <scsi/scsi_ioctl.h>

-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0))
-# include <linux/blk.h>
-#endif
-
#include "nsp32.h"


@@ -199,17 +194,9 @@ static int  __init    init_nsp32  (void)
static void __exit    exit_nsp32  (void);

/* struct Scsi_Host_Template */
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
static int         nsp32_proc_info   (struct Scsi_Host *, char *, char **, off_t, int, int);
-#else
-static int         nsp32_proc_info   (char *, char **, off_t, int, int, int);
-#endif

-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
static int         nsp32_detect      (struct pci_dev *pdev);
-#else
-static int         nsp32_detect      (Scsi_Host_Template *);
-#endif
static int         nsp32_queuecommand(struct scsi_cmnd *,
void (*done)(struct scsi_cmnd *));
static const char *nsp32_info        (struct Scsi_Host *);
@@ -296,15 +283,6 @@ static struct scsi_host_template nsp32_t
.eh_abort_handler       	= nsp32_eh_abort,
.eh_bus_reset_handler		= nsp32_eh_bus_reset,
.eh_host_reset_handler		= nsp32_eh_host_reset,
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,74))
-	.detect				= nsp32_detect,
-	.release			= nsp32_release,
-#endif
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,2))
-	.use_new_eh_code        	= 1,
-#else
-/*	.highmem_io			= 1, */
-#endif
};

#include "nsp32_io.h"
@@ -1211,12 +1189,8 @@ static irqreturn_t do_nsp32_isr(int irq,
int ret;
int handled = 0;

-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,0))
struct Scsi_Host *host = data->Host;
spin_lock_irqsave(host->host_lock, flags);
-#else
-	spin_lock_irqsave(&io_request_lock, flags);
-#endif

/*
* IRQ check, then enable IRQ mask
@@ -1480,11 +1454,7 @@ static irqreturn_t do_nsp32_isr(int irq,
nsp32_write2(base, IRQ_CONTROL, 0);

out2:
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,0))
spin_unlock_irqrestore(host->host_lock, flags);
-#else
-	spin_unlock_irqrestore(&io_request_lock, flags);
-#endif

nsp32_dbg(NSP32_DEBUG_INTR, "exit");

@@ -1500,27 +1470,18 @@ static irqreturn_t do_nsp32_isr(int irq,
}  	} while(0)
static int nsp32_proc_info(
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
struct Scsi_Host *host,
-#endif
char             *buffer,
char            **start,
off_t             offset,
int               length,
-#if !(LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
-	int               hostno,
-#endif
int               inout)
{
char             *pos = buffer;
int               thislength;
unsigned long     flags;
nsp32_hw_data    *data;
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
int               hostno;
-#else
-	struct Scsi_Host *host;
-#endif
unsigned int      base;
unsigned char     mode_reg;
int               id, speed;
@@ -1531,15 +1492,7 @@ static int nsp32_proc_info(
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
data = (nsp32_hw_data *)host->hostdata;
base = host->io_port;

@@ -2674,17 +2627,10 @@ static void nsp32_sack_negate(nsp32_hw_d
*	0x900-0xbff: (map same 0x800-0x8ff I/O port image repeatedly)
*	0xc00-0xfff: CardBus status registers
*/
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
#define DETECT_OK 0
#define DETECT_NG 1
#define PCIDEV    pdev
static int nsp32_detect(struct pci_dev *pdev)
-#else
-#define DETECT_OK 1
-#define DETECT_NG 0
-#define PCIDEV    (data->Pci)
-static int nsp32_detect(Scsi_Host_Template *sht)
-#endif
{
struct Scsi_Host *host;	/* registered host structure */
struct resource  *res;
@@ -2697,11 +2643,7 @@ static int nsp32_detect(Scsi_Host_Templa
/*
* register this HBA as SCSI device
*/
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
host = scsi_host_alloc(&nsp32_template, sizeof(nsp32_hw_data));
-#else
-	host = scsi_register(sht, sizeof(nsp32_hw_data));
-#endif
if (host == NULL) {
nsp32_msg (KERN_ERR, "failed to scsi register");
goto err;
@@ -2719,9 +2661,6 @@ static int nsp32_detect(Scsi_Host_Templa
host->unique_id = data->BaseAddress;
host->n_io_port	= data->NumAddress;
host->base      = (unsigned long)data->MmioAddress;
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,63))
-	scsi_set_pci_device(host, PCIDEV);
-#endif

data->Host      = host;
spin_lock_init(&(data->Lock));
@@ -2884,10 +2823,8 @@ static int nsp32_detect(Scsi_Host_Templa
goto free_irq;
}

-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
scsi_add_host (host, &PCIDEV->dev);
scsi_scan_host(host);
-#endif
pci_set_drvdata(PCIDEV, host);
return DETECT_OK;

@@ -3519,11 +3456,7 @@ static int __devinit nsp32_probe(struct

pci_set_master(pdev);

-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
ret = nsp32_detect(pdev);
-#else
-	ret = scsi_register_host(&nsp32_template);
-#endif

nsp32_msg(KERN_INFO, "irq: %i mmio: %p+0x%lx slot: %s model: %s",
pdev->irq,
@@ -3538,21 +3471,15 @@ static int __devinit nsp32_probe(struct

static void __devexit nsp32_remove(struct pci_dev *pdev)
{
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
struct Scsi_Host *host = pci_get_drvdata(pdev);
-#endif

nsp32_dbg(NSP32_DEBUG_REGISTER, "enter");

-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
scsi_remove_host(host);

nsp32_release(host);

scsi_host_put(host);
-#else
-	scsi_unregister_host(&nsp32_template);
-#endif
}


Index: linux-2.6.13-rc2-mm1/drivers/scsi/nsp32.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/nsp32.h
+++ linux-2.6.13-rc2-mm1/drivers/scsi/nsp32.h
@@ -618,47 +618,5 @@ typedef struct _nsp32_hw_data {
#define REQSACK_TIMEOUT_TIME	10000	/* max wait time for REQ/SACK assertion
or negation, 10000us == 10ms */

-/**************************************************************************
- * Compatibility functions
- */
-
-/* for Kernel 2.4 */
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0))
-# define scsi_register_host(template) 	scsi_register_module(MODULE_SCSI_HA, template)
-# define scsi_unregister_host(template) scsi_unregister_module(MODULE_SCSI_HA, template)
-# define scsi_host_put(host)            scsi_unregister(host)
-# define pci_name(pci_dev)              ((pci_dev)->slot_name)
-
-typedef void irqreturn_t;
-# define IRQ_NONE      /* */
-# define IRQ_HANDLED   /* */
-# define IRQ_RETVAL(x) /* */
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
-#endif
-
#endif /* _NSP32_H */
/* end */
