Return-Path: <linux-kernel-owner+w=401wt.eu-S964972AbWLTJ6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWLTJ6K (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 04:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWLTJ6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 04:58:10 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:56103 "EHLO
	calculon.skynet.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964972AbWLTJ6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 04:58:09 -0500
Date: Wed, 20 Dec 2006 09:58:07 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git pull] more drm patches got 2.6.20 - proper request now..
Message-ID: <Pine.LNX.4.64.0612200957210.1143@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, ( apologies the last one I sent was missing the pull... )

Can you pull the 'drm-patches' branch from:
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git drm-patches

This is just a bunch of minor patches and fixes for the drm tree.
The biggest change is to the intel driver to fix up some tearing issues,
and a small update to the radeon bounds check to fix r300 issue.

The rest are just cleanups and comment fixes..

Dave.

  drivers/char/drm/drmP.h         |    7 -
  drivers/char/drm/drm_lock.c     |    2
  drivers/char/drm/drm_stub.c     |   12 ++
  drivers/char/drm/drm_sysfs.c    |    8 +-
  drivers/char/drm/i915_irq.c     |  199 +++++++++++++++++++++++++++------------
  drivers/char/drm/r128_drm.h     |    3 -
  drivers/char/drm/r128_drv.h     |    3 -
  drivers/char/drm/r128_state.c   |    3 -
  drivers/char/drm/r300_cmdbuf.c  |   32 +-----
  drivers/char/drm/radeon_drv.h   |   15 +++
  drivers/char/drm/radeon_irq.c   |    4 -
  drivers/char/drm/radeon_mem.c   |    4 -
  drivers/char/drm/radeon_state.c |   13 +--
  drivers/char/drm/savage_bci.c   |    4 -
  14 files changed, 190 insertions(+), 119 deletions(-)

commit f9841a8d6018f8bcba77e75c9e368d94f1f22933
Author: Jean Delvare <khali@linux-fr.org>
Date:   Tue Dec 19 18:04:33 2006 +1100

     drm: Stop defining pci_pretty_name

     drm drivers no longer use pci_pretty_name so we can stop defining it.

     Signed-off-by: Jean Delvare <khali@linux-fr.org>
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 83a9e29b0fd753c28e3979d638a8ebfd3f6ebc96
Author: Dave Airlie <airlied@optimus.localdomain>
Date:   Tue Dec 19 17:56:14 2006 +1100

     drm: r128: comment aligment with drm git

     Align some r128 license comments

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 0c4dd906a220fac7997048178ee4f5d8c378b38b
Author: Dave Airlie <airlied@optimus.localdomain>
Date:   Tue Dec 19 17:49:44 2006 +1100

     drm: make kernel context switch same as for drm git tree.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 94bb598e6b7d68690426f4c7c4385823951861eb
Author: Dave Airlie <airlied@optimus.localdomain>
Date:   Tue Dec 19 17:49:08 2006 +1100

     drm: fixup comment header style

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 183b4aeefa1ff8e0a792b95d5d56f0994d022449
Author: Eric Anholt <eric@anholt.net>
Date:   Tue Dec 19 17:20:02 2006 +1100

     drm: savage: compat fix from drm git.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 1d6bb8e51dba3db1c15575901022fe72d363e5a4
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Fri Dec 15 18:54:35 2006 +1100

     drm: Unify radeon offset checking.

     Replace r300_check_offset() with generic radeon_check_offset(), which doesn't
     reject valid offsets when the framebuffer area is at the very end of the card's
     32 bit address space. Make radeon_check_and_fixup_offset() use
     radeon_check_offset() as well.

     This fixes https://bugs.freedesktop.org/show_bug.cgi?id=7697 .

commit 3188a24c256bae0ed93d81d82db1f1bb6060d727
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Mon Dec 11 18:32:27 2006 +1100

     i915_vblank_tasklet: Try harder to avoid tearing.

     Previously, if there were several buffer swaps scheduled for the same vertical
     blank, all but the first blit emitted stood a chance of exhibiting tearing. In
     order to avoid this, split the blits along slices of each output top to bottom.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 2c3f0eddfbd7f5c7a5450de287bad805722888c3
Author: Jeff Garzik <jeff@garzik.org>
Date:   Sat Dec 9 10:50:22 2006 +1100

     DRM: handle pci_enable_device failure

     Signed-off-by: Jeff Garzik <jeff@garzik.org>
     Signed-off-by: Andrew Morton <akpm@osdl.org>
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 94f060bd0f78814f4daf8c7942bd710af52c7d6f
Author: Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sat Dec 9 10:49:47 2006 +1100

     drm: fix return value check

     class_create() and class_device_create() return error code as a pointer on
     failure.  These return values need to be checked by IS_ERR().

     Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
     Signed-off-by: Andrew Morton <akpm@osdl.org>
     Signed-off-by: Dave Airlie <airlied@linux.ie>
