Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWELXpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWELXpG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWELXos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:48 -0400
Received: from mx.pathscale.com ([64.160.42.68]:59817 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932276AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 32 of 53] ipath - fix NULL dereference during cleanup
X-Mercurial-Node: b9fd1a46c910bf69177f685b88d67f59d434c952
Message-Id: <b9fd1a46c910bf69177f.1147477397@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:17 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix NULL deref due to pcidev being clobbered before dd->ipath_f_cleanup()
was called.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 4868daa7f215 -r b9fd1a46c910 drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Fri May 12 15:55:28 2006 -0700
@@ -1897,19 +1897,19 @@ static void __exit infinipath_cleanup(vo
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
 
