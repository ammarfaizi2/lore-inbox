Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263995AbUDUBeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263995AbUDUBeH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 21:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264268AbUDUBeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 21:34:07 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:27616
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263995AbUDUBd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 21:33:58 -0400
Date: Wed, 21 Apr 2004 03:34:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Ken Ashcraft <ken@coverity.com>, linux-kernel@vger.kernel.org,
       mc@cs.stanford.edu, dri-devel@lists.sourceforge.net
Subject: Re: [CHECKER] Probable security holes in 2.6.5
Message-ID: <20040421013402.GI29954@dualathlon.random>
References: <1082134916.19301.7.camel@dns.coverity.int> <20040416115406.X22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416115406.X22989@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 11:54:06AM -0700, Chris Wright wrote:
> * Ken Ashcraft (ken@coverity.com) wrote:
> > [BUG]
> > /home/kash/linux/linux-2.6.5/drivers/char/drm/i810_dma.c:1276:i810_dma_mc: ERROR:TAINT: 1267:1276:Using user value "((mc).idx * 4)" without first performing bounds checks [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [PATH= "(*((*dev).lock).hw_lock).lock & -2147483648 == 0" on line 1271 is false => "copy_from_user != 0" on line 1267 is false]    
> > 	u32 *hw_status = dev_priv->hw_status_page;
> > 	drm_i810_sarea_t *sarea_priv = (drm_i810_sarea_t *)
> > 		dev_priv->sarea_priv;
> > 	drm_i810_mc_t mc;
> > 
> > Start --->
> > 	if (copy_from_user(&mc, (drm_i810_mc_t *)arg, sizeof(mc)))
> > 		return -EFAULT;
> > 
> > 
> > 	if (!_DRM_LOCK_IS_HELD(dev->lock.hw_lock->lock)) {
> > 		DRM_ERROR("i810_dma_mc called without lock held\n");
> > 		return -EINVAL;
> > 	}
> > 
> > Error --->
> > 	i810_dma_dispatch_mc(dev, dma->buflist[mc.idx], mc.used,
> > 		mc.last_render );
> > 
> > 	atomic_add(mc.used, &dev->counts[_DRM_STAT_SECONDARY]);
> 
> Looks like a possible bug.  Index shouldn't go off end of buflist.
> Perhaps verifying it's below buf_count would do it.  Patch below.
> 
> thanks,
> -chris
> -- 
> Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
> 
> ===== drivers/char/drm/i810_dma.c 1.31 vs edited =====
> --- 1.31/drivers/char/drm/i810_dma.c	Mon Apr 12 10:54:26 2004
> +++ edited/drivers/char/drm/i810_dma.c	Fri Apr 16 11:46:32 2004
> @@ -1275,6 +1275,9 @@
>  		return -EINVAL;
>  	}
>  
> +	if (mc.idx >= dma->buf_count)
> +		return -EINVAL;
> +
>  	i810_dma_dispatch_mc(dev, dma->buflist[mc.idx], mc.used,
>  		mc.last_render );

this is wrong, idx is signed, so you've to check for negative values
too. Credit for noticing this doesn't belong to me though.

Could you just in case review the other fixes too for other potential
errors like this? thanks.

this is the correct fix for 2.6 (and it seems 2.4 too):

--- linux/drivers/char/drm/i810_dma.c	Mon Apr 12 10:54:26 2004
+++ linux/drivers/char/drm/i810_dma.c	Fri Apr 16 11:46:32 2004
@@ -1275,6 +1275,9 @@
 		return -EINVAL;
 	}
 
+	if (mc.idx >= dma->buf_count || mc.idx < 0)
+		return -EINVAL;
+
 	i810_dma_dispatch_mc(dev, dma->buflist[mc.idx], mc.used,
 		mc.last_render );
 
