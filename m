Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTJTIKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 04:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbTJTIKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 04:10:19 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:24963
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S262356AbTJTIKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 04:10:09 -0400
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Subject: Re: swsusp in test8 fails with intel-agp and i830
Message-Id: <E1ABV7L-0001Os-00@penngrove.fdns.net>
Date: Mon, 20 Oct 2003 01:10:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I took a naive look at 'intel-agp.c' to see if i could learn anything.  Not 
much luck.  I think it has a better chance of winning if 'intel-agp' and 
friends aren't compiled as modules, but even then, i'm rather skeptical...

   Pavel - I looked in intel_agp and placed printk+mdelay all over
   agp_intel_resume(struct pci_dev *pdev), but something strange happened: I saw
   those print outs during _suspend_ and not during resume - does that make any
   sense?
							-- Aviram Jenik

I also tried putting in prink's at agp_intel_suspend(), agp_intel_resume(),
and a couple of other places.  ...suspend() was called, and ...resume() did 
appear to be called during the power down sequence [even if the DRM code is
not loaded], and after as well, i think, albeit the timing isn't completely 
clear to me from 'kern.log'.  (Similarly, e100 reported 'Link is Up' during 
the power-down sequence, and also happened after it was powered back up.)

So it looks like it's trying at least, and the problem may be elsewhere.
For example, if 'i810fb' wins with software suspend, then 'intel-agp' may 
not be the issue here, as it is worth noting that the i810 frame buffer
code ('drivers/video/i810/i810_main.c'), which uses it, makes some effort 
to make sure things are suspended and resumed properly.

   drivers/char/drm/i830_drv driver is apparently using DMA _and_ has no
   suspend/resume support. That looks dangerous to me, perhaps you'll
   need to implement those, too.
							-- Pavel Machek

I wasn't able to find anything that looked like suspend/resume support in
'drivers/char/drm/*', and i'm starting to wonder if DRI in general has any
chance of working with software suspend.  After all, i think the X server 
reaches in and hacks the hardware, so i don't understand how the DRM code 
can manage to restore that state after being powered down, 'cause i don't 
think it has any way of remembering what the user level code has been doing.  
No dbout, someone else has a MUCH better understanding of this than i do! 
*-sigh-*

I did go back to 2.4.21 to try out the older i830 frame buffer code (which
was formerly called 'intelfb'). It indeed seemed to work, but alas, for my 
machine, like 'vesafb', it seemed to be stuck with whatever frame buffer 
configuration 'arch/i386/boot/video.S' set up.  So again, the best i could
do seems to be 1024x768x8 (as it seemed to look like maybe the BIOS was 
rejecting anything larger than that in memory size).

				-- JM
