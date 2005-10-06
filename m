Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVJFLKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVJFLKo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 07:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbVJFLKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 07:10:44 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:24976 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750827AbVJFLKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 07:10:44 -0400
Date: Thu, 6 Oct 2005 13:10:47 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch] s390: ccw device reconnect oops.
Message-ID: <20051006111047.GA7710@skybase.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
this patch is a bug fix that should be included in 2.6.14.
The klist bus_find_device/driver_find_device rework has introduced
the bug. The machine will oops if an online ccw device that has
been detached gets reconnected.

blue skies,
  Martin.

---

[patch] s390: ccw device reconnect oops.

From: Cornelia Huck <cohuck@de.ibm.com>

Search for a disconnect ccw_device on the ccw bus rather than on the css bus
(was a typo in patch I did for the klist conversion). A cast to an embedding
ccw_device from an embedded device in a struct subchannel will lead us to
oopses.

Signed-off-by: Cornelia Huck <cohuck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device.c	2005-10-06 11:00:26.000000000 +0200
@@ -544,7 +544,7 @@ get_disc_ccwdev_by_devno(unsigned int de
 		.sibling = sibling,
 	};
 
-	dev = bus_find_device(&css_bus_type, NULL, &data, match_devno);
+	dev = bus_find_device(&ccw_bus_type, NULL, &data, match_devno);
 
 	return dev ? to_ccwdev(dev) : NULL;
 }
