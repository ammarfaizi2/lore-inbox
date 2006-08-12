Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422697AbWHLVCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422697AbWHLVCi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 17:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422703AbWHLVCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 17:02:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:17043 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422698AbWHLVCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 17:02:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RwxS887C4pGnG06A53LuftPOxElhUrqlLo/IVcSkpqLXk+VNW9w3h0UOeT0K67VMyxQmmgMPSQ1o1Xt/57go4CI7l6geNXoc8qbzybqFwWvZHQwvEGpTN9xtexMHOxHIjOymLwiVyT4brzq1XCgzaBZ5YpLuQjNP9GczJrS18/s=
Message-ID: <44DE420A.4050008@gmail.com>
Date: Sat, 12 Aug 2006 23:03:06 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
       GOTO Masanori <gotom@debian.or.jp>
Subject: Re: [RFC] [PATCH 7/9] drivers/scsi/nsp32.c Removal of old scsi code
References: <44DE3E5E.3020605@gmail.com>
In-Reply-To: <44DE3E5E.3020605@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/scsi/nsp32.c linux-work/drivers/scsi/nsp32.c
--- linux-work-clean/drivers/scsi/nsp32.c	2006-08-12 02:15:32.000000000 +0200
+++ linux-work/drivers/scsi/nsp32.c	2006-08-12 20:43:46.000000000 +0200
@@ -50,10 +50,6 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_ioctl.h>

-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0))
-# include <linux/blk.h>
-#endif
-
 #include "nsp32.h"


@@ -200,17 +196,9 @@ static int  __init    init_nsp32  (void)
 static void __exit    exit_nsp32  (void);

 /* struct struct scsi_host_template */
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
 static int         nsp32_proc_info   (struct Scsi_Host *, char *, char **, off_t, int, int);
-#else
-static int         nsp32_proc_info   (char *, char **, off_t, int, int, int);
-#endif

-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
 static int         nsp32_detect      (struct pci_dev *pdev);
-#else
-static int         nsp32_detect      (struct scsi_host_template *);
-#endif
 static int         nsp32_queuecommand(struct scsi_cmnd *,
 		void (*done)(struct scsi_cmnd *));
 static const char *nsp32_info        (struct Scsi_Host *);
@@ -297,15 +285,7 @@ static struct scsi_host_template nsp32_t
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
 /*	.highmem_io			= 1, */
-#endif
 };

 #include "nsp32_io.h"
@@ -1212,12 +1192,8 @@ static irqreturn_t do_nsp32_isr(int irq,
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
@@ -1481,11 +1457,7 @@ static irqreturn_t do_nsp32_isr(int irq,
 	nsp32_write2(base, IRQ_CONTROL, 0);

  out2:
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,0))
 	spin_unlock_irqrestore(host->host_lock, flags);
-#else
-	spin_unlock_irqrestore(&io_request_lock, flags);
-#endif

 	nsp32_dbg(NSP32_DEBUG_INTR, "exit");

@@ -1501,27 +1473,18 @@ static irqreturn_t do_nsp32_isr(int irq,
 		} \
 	} while(0)
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
@@ -1532,15 +1495,7 @@ static int nsp32_proc_info(
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

@@ -2675,17 +2630,11 @@ static void nsp32_sack_negate(nsp32_hw_d
  *	0x900-0xbff: (map same 0x800-0x8ff I/O port image repeatedly)
  *	0xc00-0xfff: CardBus status registers
  */
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
+
 #define DETECT_OK 0
 #define DETECT_NG 1
 #define PCIDEV    pdev
 static int nsp32_detect(struct pci_dev *pdev)
-#else
-#define DETECT_OK 1
-#define DETECT_NG 0
-#define PCIDEV    (data->Pci)
-static int nsp32_detect(struct scsi_host_template *sht)
-#endif
 {
 	struct Scsi_Host *host;	/* registered host structure */
 	struct resource  *res;
@@ -2698,11 +2647,8 @@ static int nsp32_detect(struct scsi_host
 	/*
 	 * register this HBA as SCSI device
 	 */
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
 	host = scsi_host_alloc(&nsp32_template, sizeof(nsp32_hw_data));
-#else
-	host = scsi_register(sht, sizeof(nsp32_hw_data));
-#endif
+
 	if (host == NULL) {
 		nsp32_msg (KERN_ERR, "failed to scsi register");
 		goto err;
@@ -2720,9 +2666,6 @@ static int nsp32_detect(struct scsi_host
 	host->unique_id = data->BaseAddress;
 	host->n_io_port	= data->NumAddress;
 	host->base      = (unsigned long)data->MmioAddress;
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,63))
-	scsi_set_pci_device(host, PCIDEV);
-#endif

 	data->Host      = host;
 	spin_lock_init(&(data->Lock));
@@ -2884,14 +2827,13 @@ static int nsp32_detect(struct scsi_host
 		goto free_irq;
         }

-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
 	ret = scsi_add_host(host, &PCIDEV->dev);
 	if (ret) {
 		nsp32_msg(KERN_ERR, "failed to add scsi host");
 		goto free_region;
 	}
 	scsi_scan_host(host);
-#endif
+
 	pci_set_drvdata(PCIDEV, host);
 	return DETECT_OK;

@@ -3525,12 +3467,7 @@ static int __devinit nsp32_probe(struct
 	data->MmioLength  = pci_resource_len  (pdev, 1);

 	pci_set_master(pdev);
-
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
 	ret = nsp32_detect(pdev);
-#else
-	ret = scsi_register_host(&nsp32_template);
-#endif

 	nsp32_msg(KERN_INFO, "irq: %i mmio: %p+0x%lx slot: %s model: %s",
 		  pdev->irq,
@@ -3545,21 +3482,15 @@ static int __devinit nsp32_probe(struct

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



