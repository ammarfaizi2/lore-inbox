Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161230AbWJKUVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161230AbWJKUVB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 16:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161229AbWJKUVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 16:21:00 -0400
Received: from havoc.gtf.org ([69.61.125.42]:39380 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161193AbWJKUU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 16:20:58 -0400
Date: Wed, 11 Oct 2006 16:20:53 -0400
From: Jeff Garzik <jeff@garzik.org>
To: kkeil@suse.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ISDN: fix drivers, by handling errors thrown by ->readstat()
Message-ID: <20061011202053.GA9671@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a particularly ugly on-failure bug, possibly security, since the
lack of error handling here is covering up another class of bug:
failure to handle copy_to_user() return values.

The I4L API function ->readstat() returns an integer, and by looking at
several existing driver implementations, it is clear that a negative
return value was meant to indicate an error.

Given that several drivers already return a negative value indicating an
errno-style error, the current code would blindly accept that [negative]
value as a valid amount of bytes read.  Obvious damage ensues.

Correcting ->readstat() handling to properly notice errors fixes the
existing code to work correctly on error, and enables future patches to
more easily indicate errors during operation.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/isdn/i4l/isdn_common.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/isdn/i4l/isdn_common.c b/drivers/isdn/i4l/isdn_common.c
index c3d79ee..69aee26 100644
--- a/drivers/isdn/i4l/isdn_common.c
+++ b/drivers/isdn/i4l/isdn_common.c
@@ -1134,9 +1134,12 @@ isdn_read(struct file *file, char __user
 		if (dev->drv[drvidx]->interface->readstat) {
 			if (count > dev->drv[drvidx]->stavail)
 				count = dev->drv[drvidx]->stavail;
-			len = dev->drv[drvidx]->interface->
-				readstat(buf, count, drvidx,
-					 isdn_minor2chan(minor));
+			len = dev->drv[drvidx]->interface->readstat(buf, count,
+						drvidx, isdn_minor2chan(minor));
+			if (len < 0) {
+				retval = len;
+				goto out;
+			}
 		} else {
 			len = 0;
 		}
