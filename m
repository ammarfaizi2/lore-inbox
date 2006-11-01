Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946552AbWKAFpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946552AbWKAFpJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946549AbWKAFpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:45:08 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47324 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946548AbWKAFpA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:45:00 -0500
Message-Id: <20061101054422.145185000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:29 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jeff Garzik <jeff@garzik.org>,
       Karsten Keil <kkeil@suse.de>
Subject: [PATCH 49/61] ISDN: fix drivers, by handling errors thrown by ->readstat()
Content-Disposition: inline; filename=isdn-fix-drivers-by-handling-errors-thrown-by-readstat.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Jeff Garzik <jeff@garzik.org>

This is a particularly ugly on-failure bug, possibly security, since the
lack of error handling here is covering up another class of bug: failure to
handle copy_to_user() return values.

The I4L API function ->readstat() returns an integer, and by looking at
several existing driver implementations, it is clear that a negative return
value was meant to indicate an error.

Given that several drivers already return a negative value indicating an
errno-style error, the current code would blindly accept that [negative]
value as a valid amount of bytes read.  Obvious damage ensues.

Correcting ->readstat() handling to properly notice errors fixes the
existing code to work correctly on error, and enables future patches to
more easily indicate errors during operation.

Signed-off-by: Jeff Garzik <jeff@garzik.org>
Cc: Karsten Keil <kkeil@suse.de>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/isdn/i4l/isdn_common.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- linux-2.6.18.1.orig/drivers/isdn/i4l/isdn_common.c
+++ linux-2.6.18.1/drivers/isdn/i4l/isdn_common.c
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

--
