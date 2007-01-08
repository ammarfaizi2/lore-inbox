Return-Path: <linux-kernel-owner+w=401wt.eu-S1161347AbXAHQZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161347AbXAHQZ5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 11:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161349AbXAHQZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 11:25:57 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:21903 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161347AbXAHQZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 11:25:56 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Broadcom 4400 resume small fix
From: Dmitriy Monakhov <dmonakhov@sw.ru>
Date: Mon, 08 Jan 2007 19:26:09 +0300
Message-ID: <87lkkdv61q.fsf@sw.ru>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Return value  of 'pci_enable_device' was ignored in b44_resume().
We can't ingore it because it can fail.

Signed-off-by: Dmitriy Monakhov <dmonakhov@openvz.org>
-------

--=-=-=
Content-Disposition: inline; filename=diff-ms-net-b44

diff --git a/drivers/net/b44.c b/drivers/net/b44.c
index 5eb2ec6..63de31b 100644
--- a/drivers/net/b44.c
+++ b/drivers/net/b44.c
@@ -2315,9 +2315,15 @@ static int b44_resume(struct pci_dev *pd
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct b44 *bp = netdev_priv(dev);
+	int err;
 
 	pci_restore_state(pdev);
-	pci_enable_device(pdev);
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Cannot enable PCI device, "
+		       "aborting.\n");
+		return err;
+	}
 	pci_set_master(pdev);
 
 	if (!netif_running(dev))

--=-=-=--

