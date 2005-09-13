Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbVIMVSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbVIMVSk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 17:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbVIMVSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 17:18:40 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:33435 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932518AbVIMVSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 17:18:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=j0DV1QllPZ23dFKACkNcN9x2fbxJyZLycMGLa/KIv3x6KLmb9a8D9bOgmu81VHWWV2eU+MRHwMqXtG27y7YcCNmwcMS3+YlEdui4btbeU5cwDOfvrFu2AwjHhUfj+CvTcqI8yNtobW4bfxSmImLJE/D47CylDGHZ6+fBfyQG80k=
Message-ID: <432741E9.2090401@gmail.com>
Date: Wed, 14 Sep 2005 05:17:29 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Wilson <gww@btinternet.com>
CC: linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@pol.net>
Subject: Re: 2.6.14-rc1: oops during boot
References: <1126643143.5170.11.camel@tlg.swandive.local>
In-Reply-To: <1126643143.5170.11.camel@tlg.swandive.local>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Wilson wrote:
> 2.6.14-rc1 oops on boot as a result of the patch "nvidiafb: Fallback to
> firmware EDID".
> 
> This is because the call to fb_firmware_edid added by the patch may
> return NULL but this is not checked before trying to memcpy using this
> pointer resulting in the following oops:
> 

Thanks.  Try this patch.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
--- a/drivers/video/nvidia/nv_i2c.c
+++ b/drivers/video/nvidia/nv_i2c.c
@@ -209,10 +209,13 @@ int nvidia_probe_i2c_connector(struct fb
 
 	if (!edid && conn == 1) {
 		/* try to get from firmware */
-		edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
-		if (edid)
-			memcpy(edid, fb_firmware_edid(info->device),
-			       EDID_LENGTH);
+		const u8 *e = fb_firmware_edid(info->device);
+		
+		if (e != NULL) {
+			edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
+			if (edid)
+				memcpy(edid, e, EDID_LENGTH);
+		}
 	}
 
 	if (out_edid)
