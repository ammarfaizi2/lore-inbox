Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWBPRTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWBPRTi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 12:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWBPRTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 12:19:38 -0500
Received: from pat.qlogic.com ([198.70.193.2]:61512 "EHLO avexch02.qlogic.com")
	by vger.kernel.org with ESMTP id S1750720AbWBPRTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 12:19:38 -0500
Date: Thu, 16 Feb 2006 09:19:34 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc3 qlogic panic ?
Message-ID: <20060216171934.GA5627@andrew-vasquezs-powerbook-g4-15.local>
References: <1140108589.29800.2.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140108589.29800.2.camel@dyn9047017100.beaverton.ibm.com>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 16 Feb 2006 17:19:36.0514 (UTC) FILETIME=[29367220:01C6331D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2006, Badari Pulavarty wrote:

> I am not sure if its already reported. I get following panic
> while using qla2200 on 2.6.16-rc3.
>

The qlogicfc driver attaches to 2100 and 2200 devices:

> Unable to handle kernel NULL pointer dereference at 0000000000000000
> RIP:
> <ffffffff88042690>{:qla2xxx:qla2x00_mem_free+648}
> PGD 1bddac067 PUD 1be314067 PMD 0
> Oops: 0000 [1] SMP
> CPU 0
> Modules linked in: thermal processor fan button battery ac parport_pc lp
> parport ipv6 sg qlogicfc qla2200 qla2300 qla2xxx ohci_hcd hw_random
> usbcore dm_mod

Choose either qlogicfc or qla2xxx to manage the 2200, not both.

> Pid: 4601, comm: modprobe Tainted: GF     2.6.16-rc3 #1
> RIP: 0010:[<ffffffff88042690>]
> <ffffffff88042690>{:qla2xxx:qla2x00_mem_free+648}RSP:

The crash is occuring due to PCI resources being held by qlogicfc and
qla2xxx bailing-out into it's cleanup routines.

The attached patch should handle the cleanup issues during resource
contention -- I'll workup a larger one for 2.6.17 to address the
clean-up-everything-in-one-function mess.

Thanks,
AV

---

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 9f91f1a..df9c434 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1311,8 +1311,11 @@ int qla2x00_probe_one(struct pci_dev *pd
 
 	/* Configure PCI I/O space */
 	ret = qla2x00_iospace_config(ha);
-	if (ret)
-		goto probe_failed;
+	if (ret) {
+		scsi_host_put(host);
+		pci_release_regions(pdev);
+		goto probe_disable_device;
+	}
 
 	qla_printk(KERN_INFO, ha,
 	    "Found an ISP%04X, irq %d, iobase 0x%p\n", pdev->device, pdev->irq,
