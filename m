Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbVIQKhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVIQKhS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 06:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbVIQKhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 06:37:17 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:8140 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751049AbVIQKhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 06:37:16 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] Fix bd_claim() error code.
Date: Sat, 17 Sep 2005 05:37:04 -0500
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509170537.04473.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rob Landley <rob@landley.net>

Problem: In some circumstances, bd_claim() is returning the wrong error code.

If we try to swapon an unused block device that isn't swap formatted, we get
-EINVAL.  But if that same block device is already mounted, we instead get
-EBUSY, even though it still isn't a valid swap device.

This issue came up on the busybox list trying to get the error message
from "swapon -a" right.  If a swap device is already enabled, we get -EBUSY,
and we shouldn't report this as an error.  But we can't distinguish the two
-EBUSY conditions, which are very different errors.

In the code, bd_claim() returns either 0 or -EBUSY, but in this case busy
means "somebody other than sys_swapon has already claimed this", and
_that_ means this block device can't be a valid swap device.  So return
-EINVAL there.

--- linux-2.6.13.1/mm/swapfile.c 2005-09-09 21:42:58.000000000 -0500
+++ linux-2.6.13.1-new/mm/swapfile.c 2005-09-17 02:42:45.000000000 -0500
@@ -1358,6 +1358,7 @@
   error = bd_claim(bdev, sys_swapon);
   if (error < 0) {
    bdev = NULL;
+   error = -EINVAL;
    goto bad_swap;
   }
   p->old_block_size = block_size(bdev);
