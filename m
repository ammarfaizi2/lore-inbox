Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbVHYQZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVHYQZH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 12:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVHYQZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 12:25:07 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:23265 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932283AbVHYQZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 12:25:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=LtoPr2Es3EvSE2qSw05J8G8W2Ww3RoBLZglbQKgTvK9JUUlno4ziMhw6XIgGoYmGZISK/IxY8OvZSn4Vzx0QEpmzusOHW5K9WiInrFOpCywyg5bZ+7uHTGsO04PxCBXJqYMchp7m1MhIZYljzsDa4NVBMfsKZkLaQ8Mk62JhI0E=
Message-ID: <430DF08C.8010604@gmail.com>
Date: Fri, 26 Aug 2005 00:23:40 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sebastian Kaergel <mailing@wodkahexe.de>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Sylvain Meyer <sylvain.meyer@worldonline.fr>
Subject: Re: Linux-2.6.13-rc7
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org> <20050825194954.6db42e90.mailing@wodkahexe.de>
In-Reply-To: <20050825194954.6db42e90.mailing@wodkahexe.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Kaergel wrote:
> On Tue, 23 Aug 2005 22:08:13 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
>> Antonino A. Daplas:
>>   intelfb/fbdev: Save info->flags in a local variable
>> Sylvain Meyer:
>>   intelfb: Do not ioremap entire graphics aperture

Probably this one. If vram is less than stolen size, intelfb
will only ioremap the framebuffer memory, excluding the
ringbuffer and the cursor memory.

Try booting with video=intelfb:accel:0,nohwcursor:0.  If you get
a display, try this patch.

CC'ed Sylvain.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -502,7 +502,7 @@ intelfb_pci_register(struct pci_dev *pde
 	struct agp_bridge_data *bridge;
  	int aperture_bar = 0;
  	int mmio_bar = 1;
-	int offset;
+	int offset, remap;
 
 	DBG_MSG("intelfb_pci_register\n");
 
@@ -662,11 +662,15 @@ intelfb_pci_register(struct pci_dev *pde
 			+ (dinfo->cursor.size >> 12);
 	}
 
+	if (dinfo->fbmem_gart)
+		remap = (dinfo->fb.offset << 12) + dinfo->fb.size;
+	else
+		remap = (dinfo->cursor.offset << 12) + dinfo->cursor.size;
+
 	/* Map the fb and MMIO regions */
 	/* ioremap only up to the end of used aperture */
 	dinfo->aperture.virtual = (u8 __iomem *)ioremap_nocache
-		(dinfo->aperture.physical, (dinfo->fb.offset << 12)
-		 + dinfo->fb.size);
+		(dinfo->aperture.physical, remap);
 	if (!dinfo->aperture.virtual) {
 		ERR_MSG("Cannot remap FB region.\n");
 		cleanup(dinfo);


