Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266490AbUGKDNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266490AbUGKDNq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 23:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266492AbUGKDNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 23:13:46 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:24948 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266490AbUGKDNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 23:13:43 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Fix OOPS in device_platform_unregister
Date: Sat, 10 Jul 2004 22:13:39 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407102213.39422.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch should fix the oops reported by Denis. We can safely
move call to device_unregister as the release fucntion is not guaranteed
to be called immediately and therefore should not access resources anyway.
 
-- 
Dmitry


===================================================================


ChangeSet@1.1819, 2004-07-10 22:08:01-05:00, dtor_core@ameritech.net
  Driver core: platform_device_unregister should release resources first
               and only then call device_unregister, otherwise if there
               are no more references to the device it will be freed and
               the fucntion will try to access freed memory.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
              


 platform.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


===================================================================



diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	2004-07-10 22:09:10 -05:00
+++ b/drivers/base/platform.c	2004-07-10 22:09:10 -05:00
@@ -146,13 +146,13 @@
 	int i;
 
 	if (pdev) {
-		device_unregister(&pdev->dev);
-
 		for (i = 0; i < pdev->num_resources; i++) {
 			struct resource *r = &pdev->resource[i];
 			if (r->flags & (IORESOURCE_MEM|IORESOURCE_IO))
 				release_resource(r);
 		}
+
+		device_unregister(&pdev->dev);
 	}
 }
 
