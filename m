Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbUDPSyN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 14:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263604AbUDPSyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 14:54:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:12691 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263590AbUDPSyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 14:54:10 -0400
Date: Fri, 16 Apr 2004 11:54:06 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ken Ashcraft <ken@coverity.com>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu,
       dri-devel@lists.sourceforge.net
Subject: Re: [CHECKER] Probable security holes in 2.6.5
Message-ID: <20040416115406.X22989@build.pdx.osdl.net>
References: <1082134916.19301.7.camel@dns.coverity.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1082134916.19301.7.camel@dns.coverity.int>; from ken@coverity.com on Fri, Apr 16, 2004 at 10:01:57AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ken Ashcraft (ken@coverity.com) wrote:
> [BUG]
> /home/kash/linux/linux-2.6.5/drivers/char/drm/i810_dma.c:1276:i810_dma_mc: ERROR:TAINT: 1267:1276:Using user value "((mc).idx * 4)" without first performing bounds checks [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [PATH= "(*((*dev).lock).hw_lock).lock & -2147483648 == 0" on line 1271 is false => "copy_from_user != 0" on line 1267 is false]    
> 	u32 *hw_status = dev_priv->hw_status_page;
> 	drm_i810_sarea_t *sarea_priv = (drm_i810_sarea_t *)
> 		dev_priv->sarea_priv;
> 	drm_i810_mc_t mc;
> 
> Start --->
> 	if (copy_from_user(&mc, (drm_i810_mc_t *)arg, sizeof(mc)))
> 		return -EFAULT;
> 
> 
> 	if (!_DRM_LOCK_IS_HELD(dev->lock.hw_lock->lock)) {
> 		DRM_ERROR("i810_dma_mc called without lock held\n");
> 		return -EINVAL;
> 	}
> 
> Error --->
> 	i810_dma_dispatch_mc(dev, dma->buflist[mc.idx], mc.used,
> 		mc.last_render );
> 
> 	atomic_add(mc.used, &dev->counts[_DRM_STAT_SECONDARY]);

Looks like a possible bug.  Index shouldn't go off end of buflist.
Perhaps verifying it's below buf_count would do it.  Patch below.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== drivers/char/drm/i810_dma.c 1.31 vs edited =====
--- 1.31/drivers/char/drm/i810_dma.c	Mon Apr 12 10:54:26 2004
+++ edited/drivers/char/drm/i810_dma.c	Fri Apr 16 11:46:32 2004
@@ -1275,6 +1275,9 @@
 		return -EINVAL;
 	}
 
+	if (mc.idx >= dma->buf_count)
+		return -EINVAL;
+
 	i810_dma_dispatch_mc(dev, dma->buflist[mc.idx], mc.used,
 		mc.last_render );
 
