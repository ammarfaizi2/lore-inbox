Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161050AbVLOFp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbVLOFp4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161133AbVLOFp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:45:56 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:9860 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161050AbVLOFp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:45:56 -0500
Message-Id: <20051215054444.590158000.dtor_core@ameritech.net>
References: <20051215053933.125918000.dtor_core@ameritech.net>
Date: Thu, 15 Dec 2005 00:39:34 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: wbsd-devel@list.drzeus.cx, linux-kernel@vger.kernel.org
Subject: [patch 1/3] wbsd: convert to the new platfrom device interface
Content-Disposition: inline; filename=wbsd-new-platform-intf.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wbsd: convert to the new platfrom device interface

platform_device_register_simple() is going away, switch to
using platfrom_device_alloc() + platform_device_add(). Also
make sure that wbsd_driver gets unregistered when wbsd_init
fails.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/mmc/wbsd.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

Index: work/drivers/mmc/wbsd.c
===================================================================
--- work.orig/drivers/mmc/wbsd.c
+++ work/drivers/mmc/wbsd.c
@@ -2090,10 +2090,20 @@ static int __init wbsd_drv_init(void)
 		if (result < 0)
 			return result;
 
-		wbsd_device = platform_device_register_simple(DRIVER_NAME, -1,
-			NULL, 0);
-		if (IS_ERR(wbsd_device))
-			return PTR_ERR(wbsd_device);
+		wbsd_device = platform_device_alloc(DRIVER_NAME, -1);
+		if (!wbsd_device)
+		{
+			platform_driver_unregister(&wbsd_driver);
+			return -ENOMEM;
+		}
+
+		result = platform_device_add(wbsd_device);
+		if (result)
+		{
+			platform_device_put(wbsd_device);
+			platform_driver_unregister(&wbsd_driver);
+			return result;
+		}
 	}
 
 	return 0;

