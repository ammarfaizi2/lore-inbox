Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268014AbUH3NUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268014AbUH3NUo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 09:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268020AbUH3NUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 09:20:44 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:961 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S268014AbUH3NUj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 09:20:39 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 30 Aug 2004 14:52:34 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l/bttv: add sanity check (bug #3309)
Message-ID: <20040830125233.GA1727@bytesex>
References: <20040830025443.3aad9fa4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830025443.3aad9fa4.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Software Environment: gnomemeeting
> Problem Description: I have a miropctv (bttv card=1), kernel serie 2.4 have v4l
> only implementation. Kernel serie 2.6 have v4l2 only implementation (v4l
> broken). I had to go back to 2.4 to use gnomemeeting (v4l only). Everything is
> fine in 2.4.x. With 2.6, programs using v4l2 works ok (xawtv, ...); and programs
> using v4l crash:

> Aug 25 19:20:19 zain kernel: kernel BUG at drivers/media/video/bttv-driver.c:1900!

Missing sanity check, overlay is supported for packed pixel formats
only.  Patch below.  It's not API related btw, the bug can be triggered
using the v4l2 API as well.

  Gerd

diff -u linux-2.6.9-rc1/drivers/media/video/bttv-driver.c linux/drivers/media/video/bttv-driver.c
--- linux-2.6.9-rc1/drivers/media/video/bttv-driver.c	2004-08-25 18:23:10.000000000 +0200
+++ linux/drivers/media/video/bttv-driver.c	2004-08-30 14:42:43.321218189 +0200
@@ -1861,6 +1861,8 @@
 
 	if (NULL == fh->ovfmt)
 		return -EINVAL;
+	if (!(fh->ovfmt->flags & FORMAT_FLAGS_PACKED))
+		return -EINVAL;
 	retval = verify_window(&bttv_tvnorms[btv->tvnorm],win,fixup);
 	if (0 != retval)
 		return retval;
