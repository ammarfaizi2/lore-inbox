Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268304AbUIWH1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268304AbUIWH1U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 03:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUIWH1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 03:27:20 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:64251 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S268304AbUIWH1P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 03:27:15 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2 vs glxgears
Date: Thu, 23 Sep 2004 03:27:11 -0400
User-Agent: KMail/1.7
Cc: "Frank Phillips" <fphillips@linuxmail.org>
References: <20040923052338.C1D0C21B32F@ws5-6.us4.outblaze.com>
In-Reply-To: <20040923052338.C1D0C21B32F@ws5-6.us4.outblaze.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409230327.11531.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.51.220] at Thu, 23 Sep 2004 02:27:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 September 2004 01:23, Frank Phillips wrote:
>Hello,
>
>I don't know why your FPS would be decreasing like that, but as for
>the 9FPS - radeon, right? Look for this line in Xorg.0.log:
>
>(EE) RADEON(0): [pci] Out of memory (-1007)

On 2.6.9-rc1-mm5 ATM, and the above line doesn't exist in the 
Xorg.0.log

>this is an easy fix:
>
>===== linux/drm_scatter.h 1.6 vs edited =====
>--- 1.6/linux/drm_scatter.h     Sun Sep  5 21:22:06 2004
>+++ edited/linux/drm_scatter.h  Thu Sep 16 01:11:13 2004
>@@ -73,7 +73,7 @@
>
>        DRM_DEBUG( "%s\n", __FUNCTION__ );
>
>-       if (drm_core_check_feature(dev, DRIVER_SG))
>+       if (!drm_core_check_feature(dev, DRIVER_SG))
>                return -EINVAL;
>
>        if ( dev->sg )

And this '!' is already in 2.6.9-rc2-mm2.

I'm building a 2.6.9-rc1-mm5 with the exclamation mark now & we'll see 
what effect that has on glxgears once amanda is done.

This patch seems to be a no-op here.  Booted to it now, with no really 
significant difference in the slowdown:
1463 frames in 5.0 seconds = 292.600 FPS
985 frames in 5.0 seconds = 197.000 FPS
831 frames in 5.0 seconds = 166.200 FPS
727 frames in 5.0 seconds = 145.400 FPS
636 frames in 5.0 seconds = 127.200 FPS
682 frames in 5.0 seconds = 136.400 FPS
622 frames in 5.0 seconds = 124.400 FPS
622 frames in 5.0 seconds = 124.400 FPS
554 frames in 5.0 seconds = 110.800 FPS
552 frames in 5.0 seconds = 110.400 FPS
552 frames in 5.0 seconds = 110.400 FPS
464 frames in 5.0 seconds = 92.800 FPS
310 frames in 5.0 seconds = 62.000 FPS
424 frames in 5.0 seconds = 84.800 FPS
404 frames in 5.0 seconds = 80.800 FPS
422 frames in 5.0 seconds = 84.400 FPS
461 frames in 5.0 seconds = 92.200 FPS
437 frames in 5.0 seconds = 87.400 FPS
287 frames in 5.0 seconds = 57.400 FPS

So while the patch may be correct, I'm apparently not hitting that 
exact piece of code here.

Then, rebooted to 2.6.9-rc2-mm2, I'm back to this, also without any 
errors in the Xorg.0.log:
[root@coyote root]# glxgears
60 frames in 5.0 seconds = 12.000 FPS
49 frames in 5.0 seconds =  9.800 FPS
49 frames in 5.0 seconds =  9.800 FPS
50 frames in 5.0 seconds = 10.000 FPS
49 frames in 5.0 seconds =  9.800 FPS
50 frames in 5.0 seconds = 10.000 FPS
49 frames in 5.0 seconds =  9.800 FPS
49 frames in 5.0 seconds =  9.800 FPS
48 frames in 5.0 seconds =  9.600 FPS
48 frames in 5.0 seconds =  9.600 FPS
50 frames in 5.0 seconds = 10.000 FPS
49 frames in 5.0 seconds =  9.800 FPS
43 frames in 5.0 seconds =  8.600 FPS
47 frames in 5.0 seconds =  9.400 FPS
49 frames in 5.0 seconds =  9.800 FPS
44 frames in 5.0 seconds =  8.800 FPS
31 frames in 5.0 seconds =  6.200 FPS
45 frames in 5.0 seconds =  9.000 FPS

Which even I have to agree is pretty pathetic.

>courtesy Jon Smirl. See this thread:
> http://marc.theaimsgroup.com/?t=109530394200002&r=1&w=2
>
>With this I get consistent 350s on 2.6.9-rc2-mm1-VP-S1.
>
>Frank

Other than the glxgears being slow, it seems to be working, so I'm 
gonna go sleep in it.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
