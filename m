Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWDRLPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWDRLPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 07:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWDRLPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 07:15:48 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:49346 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932193AbWDRLPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 07:15:47 -0400
Date: Tue, 18 Apr 2006 12:15:29 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git pull] drm patches for 2.6.17
Message-ID: <Pine.LNX.4.64.0604181212260.21843@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
 	This contains various cleanups and coverity fixes, deinlining 
patch, and a minor ioctl flags change.

Please pull 'drm-patches' from:
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

Dave.

  drmP.h             |    4 -
  drm_drv.c          |    4 -
  drm_memory.c       |  134 +++++++++++++++++++++++++++++++++++++++++++++++++++++
  drm_memory.h       |  128 +-------------------------------------------------
  drm_memory_debug.h |    2
  drm_pci.c          |    1
  via_irq.c          |   12 ++--
  7 files changed, 152 insertions(+), 133 deletions(-)

commit d253258c80117c2afaa644554e613201992e4ee9
Author: Jayachandran C <c.jayachandran@gmail.com>
Date:   Mon Apr 10 23:18:28 2006 -0700

     drm: Fix further issues in drivers/char/drm/via_irq.c

     Fix de-reference of 'dev_priv' before NULL check.

     Signed-off-by: Jayachandran C. <c.jayachandran@gmail.com>
     Cc: Dave Airlie <airlied@linux.ie>
     Signed-off-by: Andrew Morton <akpm@osdl.org>

commit 031de96af0e7ed6ad4a7ec2b74a77bf9782f966e
Author: Adrian Bunk <bunk@stusta.de>
Date:   Mon Apr 10 23:18:27 2006 -0700

     drivers/char/drm/drm_memory.c: possible cleanups

     - #if 0 the following unused global function:
       - drm_ioremap_nocache()

     - make the following needlessly global functions static:
       - agp_remap()
       - drm_lookup_map()

     Signed-off-by: Adrian Bunk <bunk@stusta.de>
     Cc: Dave Airlie <airlied@linux.ie>
     Signed-off-by: Andrew Morton <akpm@osdl.org>

commit 31f64bd101ea256f9fc4a7f1f1706d6417d5550a
Author: Dave Airlie <airlied@linux.ie>
Date:   Fri Apr 7 16:55:43 2006 +1000

     drm: deline a few large inlines in DRM code

     This patch moves a few large functions from drm_memory.h
     to drm_memory.c, with the following effect:

       text    data     bss     dec     hex filename
      46305    1304      20   47629    ba0d new/drm.ko
      46367    1304      20   47691    ba4b org/drm.ko
      12969    1372       0   14341    3805 new/i810.ko
      14712    1372       0   16084    3ed4 org/i810.ko
      16447    1364       0   17811    4593 new/i830.ko
      18198    1364       0   19562    4c6a org/i830.ko
      11875    1324       0   13199    338f new/i915.ko
      13025    1324       0   14349    380d org/i915.ko
      23936   29288       0   53224    cfe8 new/mga.ko
      27280   29288       0   56568    dcf8 org/mga.ko

     Please apply.

     Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 11bab7d2c86fe486e3581ac3dcdb349478ffb899
Author: Dave Airlie <airlied@linux.ie>
Date:   Wed Apr 5 18:13:13 2006 +1000

     drm: remove master setting from add/remove context

     Clients can do this in the miniglx setups.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 195b3a2d57b81d30e3129575ef6c8a95b2c936b7
Author: Dave Airlie <airlied@linux.ie>
Date:   Wed Apr 5 18:12:18 2006 +1000

     drm: drm_pci needs dma-mapping.h

     On alpha:

     WARNING: "dma_free_coherent" [drivers/char/drm/drm.ko] undefined!
     WARNING: "dma_alloc_coherent" [drivers/char/drm/drm.ko] undefined!

     Signed-off-by: Andrew Morton <akpm@osdl.org>
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 86678dfddba55a7b9e2ea084d59be6500fec2256
Author: Dave Airlie <airlied@linux.ie>
Date:   Wed Apr 5 18:10:11 2006 +1000

     [PATCH] drm: Fix issue reported by Coverity in drivers/char/drm/via_irq.c

     This patch tries to fix an issue reported in drivers/char/drm/via_irq.c by
     Coverity, please review and apply if correct.

     Error reported:
     CID: 3444 Checker: REVERSE_INULL (help)
     File: /export2/p4-coverity/mc2/linux26/drivers/char/drm/via_irq.c
     Function: via_driver_irq_wait
     Description: Pointer "dev_priv" dereferenced before NULL check

     Patch Description:
      Move de-referencing dev_priv to after the NULL check.

     Signed-off-by: Jayachandran C. <c.jayachandran at gmail.com>
     Signed-off-by: Dave Airlie <airlied@linux.ie>

