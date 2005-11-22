Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbVKVVcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbVKVVcn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbVKVVcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:32:43 -0500
Received: from silver.veritas.com ([143.127.12.111]:20544 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S965051AbVKVVcm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:32:42 -0500
Date: Tue, 22 Nov 2005 21:32:42 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Michael Frank <mhf@berlios.de>
cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Benoit Boissinot <benoit.boissinot@ens-lyon.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Michael Krufky <mkrufky@m1k.net>,
       Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm2 0x414 Bad page states
In-Reply-To: <20051122211625.165F114CB@hornet.berlios.de>
Message-ID: <Pine.LNX.4.61.0511222124040.29784@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511181906240.2853@goblin.wat.veritas.com>
 <20051122211625.165F114CB@hornet.berlios.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Nov 2005 21:32:40.0843 (UTC) FILETIME=[4440ADB0:01C5EFAC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Michael Frank wrote:
> 
> I am getting this also with i810 drm in Vanilla 2.6.15-rc2 
> upon exiting apps such as supertux.

Aha, perhaps you're the one we've been waiting for.  I've suspected
a DRM issue, but nobody has actually seen one until now, and I didn't
want to put in a patch without live justification.

Would you please try the patch below, and let us know if it fixes your
problem.  If so, I'll send it off to Andrew and Linus: the rest of the
PageReserved fixes, including the sound driver Bad page state fixes,
have gone into Linus' git tree today: perhaps this is the missing piece.

If this does not work for you, then presumably you'd be another sound
driver sufferer?  and I should send you that patch (or you pick it up
from yesterday's LKML).  But right now I'd selfishly like you to test
just this DRM patch below.

Thanks,
Hugh

--- 2.6.15-rc2/drivers/char/drm/drm_memory.c	2005-11-20 19:43:39.000000000 +0000
+++ linux/drivers/char/drm/drm_memory.c	2005-11-21 10:10:45.000000000 +0000
@@ -95,7 +95,7 @@ unsigned long drm_alloc_pages(int order,
 	unsigned long addr;
 	unsigned int sz;
 
-	address = __get_free_pages(GFP_KERNEL, order);
+	address = __get_free_pages(GFP_KERNEL|__GFP_COMP, order);
 	if (!address)
 		return 0;
 
--- 2.6.15-rc2/drivers/char/drm/drm_memory_debug.h	2005-11-20 19:43:39.000000000 +0000
+++ linux/drivers/char/drm/drm_memory_debug.h	2005-11-21 10:11:04.000000000 +0000
@@ -221,7 +221,7 @@ unsigned long DRM(alloc_pages) (int orde
 	}
 	spin_unlock(&DRM(mem_lock));
 
-	address = __get_free_pages(GFP_KERNEL, order);
+	address = __get_free_pages(GFP_KERNEL|__GFP_COMP, order);
 	if (!address) {
 		spin_lock(&DRM(mem_lock));
 		++DRM(mem_stats)[area].fail_count;
