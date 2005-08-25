Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbVHYRqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVHYRqB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 13:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbVHYRqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 13:46:01 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:23184 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751399AbVHYRqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 13:46:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=IIeZknbTPBpxza9F77dW5y6urf/TRAz0kluUGmX9u+ioZlgSpLLIqvqLsyc3WNdsnvByn8dNlFhgpSCd83LvdsEZ6Wu1s1ylVouHcpqV353HsstIcNia5u3VR34HfblQ9oOICXzCFqv4eGmW5n5WCw89/moFcB8NPjYJnQDdIDQ=
Message-ID: <430E03A5.3030602@gmail.com>
Date: Fri, 26 Aug 2005 01:45:09 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sebastian Kaergel <mailing@wodkahexe.de>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       sylvain.meyer@worldonline.fr
Subject: Re: Linux-2.6.13-rc7
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org>	<20050825194954.6db42e90.mailing@wodkahexe.de>	<430DF08C.8010604@gmail.com> <20050825210148.4f60e531.mailing@wodkahexe.de>
In-Reply-To: <20050825210148.4f60e531.mailing@wodkahexe.de>
Content-Type: multipart/mixed;
 boundary="------------040205070702090006050308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040205070702090006050308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sebastian Kaergel wrote:
> On Fri, 26 Aug 2005 00:23:40 +0800
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> 
>> Sebastian Kaergel wrote:
>>> On Tue, 23 Aug 2005 22:08:13 -0700 (PDT)
>>> Linus Torvalds <torvalds@osdl.org> wrote:
>>>
>>>> Sylvain Meyer:
>>>>   intelfb: Do not ioremap entire graphics aperture
>> Probably this one. If vram is less than stolen size, intelfb
>> will only ioremap the framebuffer memory, excluding the
>> ringbuffer and the cursor memory.
>>
>> Try booting with video=intelfb:accel:0,nohwcursor:0.  If you get
>> a display, try this patch.
>>
>> CC'ed Sylvain.
>>
>> Signed-off-by: Antonino Daplas <adaplas@pol.net>
>> ---
> <patch snipped>
> 
> Hi,
> thanks for your quick reply, but it did not work. the screen remains
> black when booting with video=intelfb:accel:0,{,no}hwcursor:0

Can you try the patch anyway?

If the patch does not fix your problem, can you revert the patches and
see which is the culprit.  I'm attaching those 2 patches.

Tony




> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


--------------040205070702090006050308
Content-Type: text/plain;
 name="intelfb-ioremap.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="intelfb-ioremap.diff"

drivers/video/intelfb/intelfbdrv.c: needs update
Index: drivers/video/intelfb/intelfbdrv.c
===================================================================
--- 0582536f492dc10e4849053d19fec93ca72e9bfe/drivers/video/intelfb/intelfbdrv.c  (mode:100644)
+++ uncommitted/drivers/video/intelfb/intelfbdrv.c  (mode:100644)
@@ -579,23 +579,6 @@
 		return -ENODEV;
 	}
 
-	/* Map the fb and MMIO regions */
-	dinfo->aperture.virtual = (u8 __iomem *)ioremap_nocache
-		(dinfo->aperture.physical, dinfo->aperture.size);
-	if (!dinfo->aperture.virtual) {
-		ERR_MSG("Cannot remap FB region.\n");
-		cleanup(dinfo);
-		return -ENODEV;
-	}
-	dinfo->mmio_base =
-		(u8 __iomem *)ioremap_nocache(dinfo->mmio_base_phys,
-					       INTEL_REG_SIZE);
-	if (!dinfo->mmio_base) {
-		ERR_MSG("Cannot remap MMIO region.\n");
-		cleanup(dinfo);
-		return -ENODEV;
-	}
-
 	/* Get the chipset info. */
 	dinfo->pci_chipset = pdev->device;
 
@@ -679,6 +662,26 @@
 	}
 
 	/* Allocate memories (which aren't stolen) */
+	/* Map the fb and MMIO regions */
+	/* ioremap only up to the end of used aperture */
+	dinfo->aperture.virtual = (u8 __iomem *)ioremap_nocache
+		(dinfo->aperture.physical, ((offset + dinfo->fb.offset) << 12)
+		 + dinfo->fb.size);
+	if (!dinfo->aperture.virtual) {
+		ERR_MSG("Cannot remap FB region.\n");
+		cleanup(dinfo);
+		return -ENODEV;
+	}
+
+	dinfo->mmio_base =
+		(u8 __iomem *)ioremap_nocache(dinfo->mmio_base_phys,
+					       INTEL_REG_SIZE);
+	if (!dinfo->mmio_base) {
+		ERR_MSG("Cannot remap MMIO region.\n");
+		cleanup(dinfo);
+		return -ENODEV;
+	}
+
 	if (dinfo->accel) {
 		if (!(dinfo->gtt_ring_mem =
 		      agp_allocate_memory(bridge, dinfo->ring.size >> 12,

--------------040205070702090006050308
Content-Type: text/plain;
 name="save_info_flags.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="save_info_flags.diff"

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -643,8 +643,8 @@ fb_pan_display(struct fb_info *info, str
 int
 fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 {
-	int err;
-
+	int err, flags = info->flags;
+	
 	if (var->activate & FB_ACTIVATE_INV_MODE) {
 		struct fb_videomode mode1, mode2;
 		int ret = 0;
@@ -697,7 +697,7 @@ fb_set_var(struct fb_info *info, struct 
 			    !list_empty(&info->modelist))
 				err = fb_add_videomode(&mode, &info->modelist);
 
-			if (!err && info->flags & FBINFO_MISC_USEREVENT) {
+			if (!err && flags & FBINFO_MISC_USEREVENT) {
 				struct fb_event event;
 				int evnt = (var->activate & FB_ACTIVATE_ALL) ?
 					FB_EVENT_MODE_CHANGE_ALL :

--------------040205070702090006050308--

