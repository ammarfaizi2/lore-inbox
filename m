Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbVKRBIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbVKRBIr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 20:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVKRBIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 20:08:47 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:62817 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751316AbVKRBIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 20:08:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pgCG72VoladG1pZrW/z1dAz/UmqrFI5CQ5PA2FAesHK1GQzMk83jr+sh5B2OA52N4Fmx2VX2FVytcf/eTl7MCiFIRbGTARJJsaHucfIxGQlitNFUvqLi//TGux6m7nB0QKYq7nXeNu9kymsp81NkqJpH/oCnSUKfxS1wiuitkUM=
Message-ID: <437D298A.7070203@gmail.com>
Date: Fri, 18 Nov 2005 09:08:26 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sylvain Meyer <sylvain.meyer@worldonline.fr>
Subject: Re: X and intelfb fight over videomode
References: <20051117000144.GA29144@hardeman.nu> <437BD8D9.9030904@gmail.com> <20051117014558.GA30088@hardeman.nu> <437C0BF2.4010400@gmail.com> <20051117234510.GA3854@hardeman.nu>
In-Reply-To: <20051117234510.GA3854@hardeman.nu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Härdeman wrote:
> On Thu, Nov 17, 2005 at 12:49:54PM +0800, Antonino A. Daplas wrote:
>> Ignore the hack I mentioned in the previous thread.  Try this patch
>> instead.
> 
> Didn't help, the messages remain the same (tried with vga=0x318 and
> video=intelfb:1024x768-32@60,mtrr=0 vga=0x318).
> 
> Boot:
> intelfb: 00:02.0: Intel(R) 852GM, aperture size 128MB, stolen memory 8060kB
> intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode
> switching.
> intelfb: Initial video mode is 1024x768-32@60.
> intelfb: Changing the video mode is not supported.
> Console: switching to colour frame buffer device 128x48
> 
> Starting X:
> mtrr: base(0xe0020000) is not aligned on a size(0x300000) boundary
> [drm:drm_unlock] *ERROR* Process 2976 using kernel context 0
> 
> First time I switch from X to VC:
> intelfb: Changing the video mode is not supported.
> intelfb: ring buffer : space: 6024 wanted 65472
> intelfb: lockup - turning off hardware acceleration
> 

Well, intelfb is at the mercy of X if it's in 'fixed mode'.

> Other suggestions?

I'm adding Sylvain, the intelfb maintainer, to the CC list.

How about this one?  It also resets the ringbuffer before re-initializing
it again.

Tony

diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
index 427689e..f1e7778 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -1283,6 +1283,16 @@ intelfb_set_par(struct fb_info *info)
 
 	if (FIXED_MODE(dinfo)) {
 		ERR_MSG("Changing the video mode is not supported.\n");
+
+		/* 
+		 * We need to at least initialize the 2D engine even
+		 * if changing the mode is not allowed
+		 */
+		if (ACCEL(dinfo, info)) {
+			intelfbhw_2d_stop(dinfo);
+			intelfbhw_2d_start(dinfo);
+		}
+
 		return -EINVAL;
 	}
 
