Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWI1QBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWI1QBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWI1QB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:01:26 -0400
Received: from mx.pathscale.com ([64.160.42.68]:59829 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751611AbWI1QBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:22 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 5 of 28] IB/ipath - unregister from IB core early
X-Mercurial-Node: e2916bbf09ed8c3adc056b75622cd15bd8373439
Message-Id: <e2916bbf09ed8c3adc05.1159459201@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:01 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This gives upper-level protocols a chance to unregister while the device
is still usable.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r a69f8b7a8a04 -r e2916bbf09ed drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Sep 28 08:57:12 2006 -0700
@@ -536,7 +536,12 @@ static void __devexit ipath_remove_one(s
 		return;
 
 	dd = pci_get_drvdata(pdev);
-	ipath_unregister_ib_device(dd->verbs_dev);
+
+	if (dd->verbs_dev) {
+		ipath_unregister_ib_device(dd->verbs_dev);
+		dd->verbs_dev = NULL;
+	}
+
 	ipath_diag_remove(dd);
 	ipath_user_remove(dd);
 	ipathfs_remove_device(dd);
@@ -2027,6 +2032,11 @@ static void __exit infinipath_cleanup(vo
 	list_for_each_entry_safe(dd, tmp, &ipath_dev_list, ipath_list) {
 		spin_unlock_irqrestore(&ipath_devs_lock, flags);
 
+		if (dd->verbs_dev) {
+			ipath_unregister_ib_device(dd->verbs_dev);
+			dd->verbs_dev = NULL;
+		}
+
 		if (dd->ipath_kregbase)
 			cleanup_device(dd);
 
