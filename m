Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWEWSeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWEWSeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWEWSdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:33:41 -0400
Received: from mx.pathscale.com ([64.160.42.68]:8119 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751215AbWEWSdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:33:35 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 5 of 10] ipath - fix NULL dereference during cleanup
X-Mercurial-Node: 6bf52c0f0f0d0df39a784921b05616176fa37251
Message-Id: <6bf52c0f0f0d0df39a78.1148409153@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1148409148@eng-12.pathscale.com>
Date: Tue, 23 May 2006 11:32:33 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix NULL deref due to pcidev being clobbered before dd->ipath_f_cleanup()
was called.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r c7cf56636dd1 -r 6bf52c0f0f0d drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Tue May 23 11:29:15 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Tue May 23 11:29:15 2006 -0700
@@ -1905,19 +1905,19 @@ static void __exit infinipath_cleanup(vo
 			} else
 				ipath_dbg("irq is 0, not doing free_irq "
 					  "for unit %u\n", dd->ipath_unit);
+
+			/*
+			 * we check for NULL here, because it's outside
+			 * the kregbase check, and we need to call it
+			 * after the free_irq.  Thus it's possible that
+			 * the function pointers were never initialized.
+			 */
+			if (dd->ipath_f_cleanup)
+				/* clean up chip-specific stuff */
+				dd->ipath_f_cleanup(dd);
+
 			dd->pcidev = NULL;
 		}
-
-		/*
-		 * we check for NULL here, because it's outside the kregbase
-		 * check, and we need to call it after the free_irq.  Thus
-		 * it's possible that the function pointers were never
-		 * initialized.
-		 */
-		if (dd->ipath_f_cleanup)
-			/* clean up chip-specific stuff */
-			dd->ipath_f_cleanup(dd);
-
 		spin_lock_irqsave(&ipath_devs_lock, flags);
 	}
 
