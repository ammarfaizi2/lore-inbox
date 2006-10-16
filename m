Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422911AbWJPUiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422911AbWJPUiZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 16:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422910AbWJPUiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 16:38:25 -0400
Received: from mail0.lsil.com ([147.145.40.20]:62680 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1422907AbWJPUiY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 16:38:24 -0400
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 2.6.19-rc2] scsi: megaraid_{mm,mbox}: 64-bit DMAcapability fix
Date: Mon, 16 Oct 2006 14:37:20 -0600
Message-ID: <890BF3111FB9484E9526987D912B261932E3E8@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.19-rc2] scsi: megaraid_{mm,mbox}: 64-bit DMAcapability fix
Thread-Index: AcbxWir7Jv87VzhST8yRckoc0Xyo+gABpT7A
From: "Ju, Seokmann" <Seokmann.Ju@lsi.com>
To: "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Vasily Averin" <vvs@sw.ru>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>, <devel@openvz.org>,
       "Andrey Mirkin" <amirkin@sw.ru>
X-OriginalArrivalTime: 16 Oct 2006 20:37:21.0451 (UTC) FILETIME=[E13BA7B0:01C6F162]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> Er ... this patch would apply in reverse, but what's in the tree
> currently looks to be correct.
No, the patch submitted by Andrey and Vasily should fix the issue.
Without this, driver still claims 64-bit DMA capability for those MegaRAID SATA controllers.
---
Example)
For SATA 150-6 with OLD filter,
	if (((1) && ((0) || (1))) || (0) || (0) || (0) || (0) || (0) {
		...;
	}
driver gets into inside of if clause and set DMA mask with 64-bit which is NOT correct.

However, with the patch,
	if (((1) && ((0) && (1))) || (0) || (0) || (0) || (0) || (0) {
		...;
	}
driver bypasses this filter and stay with 32-bit DMA mask.
---

Seokmann

> -----Original Message-----
> From: James Bottomley [mailto:James.Bottomley@SteelEye.com] 
> Sent: Monday, October 16, 2006 3:35 PM
> To: Vasily Averin
> Cc: Linux Kernel Mailing List; linux-scsi@vger.kernel.org; 
> Ju, Seokmann; Andrew Morton; Linus Torvalds; 
> devel@openvz.org; Andrey Mirkin
> Subject: Re: [PATCH 2.6.19-rc2] scsi: megaraid_{mm,mbox}: 
> 64-bit DMAcapability fix
> 
> On Mon, 2006-10-16 at 12:08 +0400, Vasily Averin wrote:
> > It is known that 2 LSI Logic MegaRAID SATA RAID Controllers 
> (150-4 and 150-6)
> > don't support 64-bit DMA. Unfortunately currently this 
> check is wrong and driver
> >  sets 64-bit DMA mode for these devices.
> > 
> > Signed-off-by:	Andrey Mirkin <amirkin@sw.ru>
> > Ack-by:		Vasily Averin <vvs@sw.ru>
> > 
> > --- 
> linux-2.6.19-rc2/drivers/scsi/megaraid/megaraid_mbox.c.mgst6	
> 2006-10-16
> > 10:26:50.000000000 +0400
> > +++ linux-2.6.19-rc2/drivers/scsi/megaraid/megaraid_mbox.c	
> 2006-10-16
> > 11:30:55.000000000 +0400
> > @@ -884,7 +884,7 @@ megaraid_init_mbox(adapter_t *adapter)
> > 
> >  	if (((magic64 == HBA_SIGNATURE_64_BIT) &&
> >  		((adapter->pdev->subsystem_device !=
> > -		PCI_SUBSYS_ID_MEGARAID_SATA_150_6) ||
> > +		PCI_SUBSYS_ID_MEGARAID_SATA_150_6) &&
> >  		(adapter->pdev->subsystem_device !=
> >  		PCI_SUBSYS_ID_MEGARAID_SATA_150_4))) ||
> >  		(adapter->pdev->vendor == PCI_VENDOR_ID_LSI_LOGIC &&
> 
> Er ... this patch would apply in reverse, but what's in the tree
> currently looks to be correct.
> 
> James
> 
> 
> 
