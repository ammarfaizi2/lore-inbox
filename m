Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbVITK20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbVITK20 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 06:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbVITK20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 06:28:26 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:48777 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964968AbVITK2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 06:28:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=lzKtMBPwjmoCJdplK5R1MqKM24OdrZymnWKo+m+CnRRVpWlJSYz9TLcgTH49CzLP7mxGkbisjI6ffBOPsC6EfGKWf9Dju9Lu6x4BVHPrPpINsE27gJi4vqHMJajvVzBNn6+Uy4FOU9ttKQE6RAsnxubWDOM4Sy6A/sEZqmSGhgg=
Message-ID: <432FE3E0.3020405@gmail.com>
Date: Tue, 20 Sep 2005 18:26:40 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Dittmer <jdittmer@ppp0.net>
CC: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: no cursor on nvidiafb console in 2.6.14-rc1-mm1
References: <20050919175116.GA8172@amd64.of.nowhere> <432F08C1.8010705@ppp0.net> <432F36B4.8030209@gmail.com> <432FBC93.4040007@ppp0.net>
In-Reply-To: <432FBC93.4040007@ppp0.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer wrote:
> Antonino A. Daplas wrote:
>> Jan Dittmer wrote:
>>
>>> jurriaan wrote:
>>>
>>>> After updating from 2.6.13-rc4-mm1 to 2.6.14-rc1-mm1 I see no cursor on
>>>> my console.
>>> Me too, 2.6.14-rc1-git4. Didn't try any kernel before with framebuffer,
>>> sorry. No fb options on the kernel command line.
>>>
>>
>> Can you try reversing this particular diff?
>>
>> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff_plain;h=af99ea96012ec72ef57fd36655a6d8aaa22e809e;hp=30f80c23f934bb0a76719232f492153fc7cca00a
>>
>> Tony
>>
> 
> --- 30f80c23f934bb0a76719232f492153fc7cca00a
> +++ af99ea96012ec72ef57fd36655a6d8aaa22e809e
> 
> ^^^ Which file??
> 

Heh, didn't realize that. drivers/video/nvidia/nvidia.c, actually.
But just apply this patch instead, as a Kconfig change is also
needed.

Signed-off-by: Antonino Daplas <adaplas@pol.net>

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -650,6 +650,7 @@ config FB_NVIDIA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This driver supports graphics boards with the nVidia chips, TNT
 	  and newer. For very old chipsets, such as the RIVA128, then use
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -893,7 +893,7 @@ static int nvidiafb_cursor(struct fb_inf
 	int i, set = cursor->set;
 	u16 fg, bg;
 
-	if (!hwcur || cursor->image.width > MAX_CURS || cursor->image.height > MAX_CURS)
+	if (cursor->image.width > MAX_CURS || cursor->image.height > MAX_CURS)
 		return -ENXIO;
 
 	NVShowHideCursor(par, 0);
@@ -1356,6 +1356,9 @@ static int __devinit nvidia_set_fbinfo(s
 	info->pixmap.size = 8 * 1024;
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 
+	if (!hwcur)
+	    info->fbops->fb_cursor = soft_cursor;
+
 	info->var.accel_flags = (!noaccel);
 
 	switch (par->Architecture) {
