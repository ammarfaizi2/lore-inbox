Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265908AbUAIBwf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 20:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266397AbUAIBwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 20:52:35 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22994 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265908AbUAIBwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 20:52:32 -0500
Date: Fri, 9 Jan 2004 02:52:30 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@trained-monkey.org>,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [patch] 2.6.1-rc2-mm1: qla1280.c doesn't compile
Message-ID: <20040109015229.GK13867@fs.tum.de>
References: <20040107232831.13261f76.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107232831.13261f76.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 11:28:31PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.1-rc1-mm2:
>...
> -qla1280-update.patch
> +qla1280-update-2.patch
> 
>  Updated qlogic patch
>...

I got the following compile error when trying to compile this driver 
statically into a kernel with hotplug enabled:


<--  snip  -->

...
drivers/scsi/qla1280.c:4849: error: `qla1280_remove_one' undeclared here 
(not in a function)
drivers/scsi/qla1280.c:4849: error: initializer element is not constant
drivers/scsi/qla1280.c:4849: error: (near initialization for 
`qla1280_pci_driver.remove')
make[2]: *** [drivers/scsi/qla1280.o] Error 1

<--  snip  -->


Since I don't see a good reason why qla1280_remove_one is #ifdef'ed out 
in the non-modular case the patch below fixes this problem by removing 
two #ifdef's.


cu
Adrian


--- linux-2.6.1-rc2-mm1/drivers/scsi/qla1280.c.old	2004-01-08 22:40:54.000000000 +0100
+++ linux-2.6.1-rc2-mm1/drivers/scsi/qla1280.c	2004-01-08 22:42:46.000000000 +0100
@@ -480,9 +480,7 @@
 #endif
 
 static int qla1280_probe_one(struct pci_dev *, const struct pci_device_id *);
-#if defined(CONFIG_SCSI_QLOGIC_1280_MODULE) || (LINUX_VERSION_CODE < 0x020600)
 static void qla1280_remove_one(struct pci_dev *);
-#endif
 
 /*
  *  QLogic Driver Support Function Prototypes.
@@ -4807,7 +4805,6 @@
 }
 
 
-#if defined(CONFIG_SCSI_QLOGIC_1280_MODULE) || (LINUX_VERSION_CODE < 0x020600)
 static void __devexit
 qla1280_remove_one(struct pci_dev *pdev)
 {
@@ -4839,7 +4836,6 @@
 
 	scsi_host_put(host);
 }
-#endif
 
 #if LINUX_VERSION_CODE >= 0x020600
 static struct pci_driver qla1280_pci_driver = {
