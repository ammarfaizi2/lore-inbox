Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVK1WVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVK1WVD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 17:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVK1WVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 17:21:03 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:56514 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932238AbVK1WVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 17:21:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mdgzf9IyNXba6Lsu3vJHvFdwgsp4p2YPv/GRpYYtJScyzqDTjVhCDvYBDX7qjDiL6t9ltIbK6x8ey+Ij7dNOXhrBT1saVc0RzXgi/tq2PiZjCzP6qKLFBALEAQ5k+BAYmqMo9nOCXhQb/uelMcgfogrtJoyDx79nnxrMChPK/CQ=
Message-ID: <438B82A4.4030107@gmail.com>
Date: Tue, 29 Nov 2005 06:20:20 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Marc Koschewski <marc@osknowledge.org>
CC: "Calin A. Culianu" <calin@ajvar.org>, akpm@osdl.org, adaplas@pol.net,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: nvidia fb flicker
References: <Pine.LNX.4.64.0511252358390.25302@rtlab.med.cornell.edu> <20051128103554.GA7071@stiffy.osknowledge.org> <438AF8A2.6030403@gmail.com> <20051128132035.GA7265@stiffy.osknowledge.org> <438B0D89.1080400@gmail.com> <20051128212418.GA7185@stiffy.osknowledge.org>
In-Reply-To: <20051128212418.GA7185@stiffy.osknowledge.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Koschewski wrote:
> * Antonino A. Daplas <adaplas@gmail.com> [2005-11-28 22:00:41 +0800]:
> 
>> Marc Koschewski wrote:
>>> * Antonino A. Daplas <adaplas@gmail.com> [2005-11-28 20:31:30 +0800]:
>>>
>>>> Marc Koschewski wrote:
>>>>> * Calin A. Culianu <calin@ajvar.org> [2005-11-26 00:02:46 -0500]:
>>>>>
>>>
>> Try again with CONFIG_FB_NVIDIA_I2C = n in your kernel config.
>>
>> Tony
> 
> Tony,
> 	it works. Could you explain me, what the difference is? :/
> 

The problem is nvidiafb trusts the EDID block as gospel truth :-)

You happen to have an EDID block which left the most important fields
blank -- the hsync and vsync range.  So the EDID parser extrapolated
the ranges, but since the block has only a single mode entry, 1600x1200@60,
what you get is this:

Nov 28 14:02:32 stiffy kernel: Extrapolated
Nov 28 14:02:32 stiffy kernel:            H: 75-75KHz V: 60-60Hz DCLK: 162MHz

Since the min and max value of the sync timings are equal, nvidiafb has
no room left to verify the timings, and will _always_ reject any timings even
if they are valid.

So, try this patch, we make nvidiafb less restrictive by ignoring the
hsync and vsync ranges if the min and max values are equal. This should
make your hardware display properly even if CONFIG_FB_NVIDIA_I2c = y.

Tony


diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index 961007d..ff28610 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1239,7 +1239,9 @@ static int nvidiafb_check_var(struct fb_
 		}
 	}
 
-	if (!mode_valid && info->monspecs.modedb_len)
+	if (!mode_valid && info->monspecs.modedb_len &&
+	    !(info->monspecs.hfmin == info->monspecs.hfmax &&
+	      info->monspecs.vfmin == info->monspecs.vfmax))
 		return -EINVAL;
 
 	if (par->fpWidth && par->fpHeight && (par->fpWidth < var->xres ||
 
