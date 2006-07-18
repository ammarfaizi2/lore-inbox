Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWGRJOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWGRJOT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWGRJOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:14:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:62837 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932095AbWGRJOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:14:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OtiSLRst67Pl1gik7b/6166X/WNQiv1ythsA1H/6O4Jof3SJ5kw0+wnvMrjoLhFWgqqXi2kjqNkWcz4ZOxMA5CmicInhTkDlgP8cje1f4CCklQ7z5RbmSF6m0DcRVnhTbhFeu0/U3JuGgsf5+RpEbZoTnKTdN0RPxeK7m3+cbmo=
Message-ID: <8dd980de0607180214y8262ba6t7d8ad8933bca6c4d@mail.gmail.com>
Date: Tue, 18 Jul 2006 17:14:16 +0800
From: "Kevin Hao" <haokexin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]net: Add netconsole support to dm9000 driver
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

    Add netconsole support to dm9000 driver ,against 2.6.18-rc2

diff --git a/drivers/net/dm9000.c b/drivers/net/dm9000.c
index 1b758b7..3d76fa1 100644
--- a/drivers/net/dm9000.c
+++ b/drivers/net/dm9000.c
@@ -339,6 +339,17 @@ static void dm9000_timeout(struct net_de
 	spin_unlock_irqrestore(&db->lock,flags);
 }

+#ifdef CONFIG_NET_POLL_CONTROLLER
+/*
+ *Used by netconsole
+ */
+static void dm9000_poll_controller(struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	dm9000_interrupt(dev->irq,dev,NULL);
+	enable_irq(dev->irq);
+}
+#endif

 /* dm9000_release_board
  *
@@ -538,6 +549,9 @@ dm9000_probe(struct platform_device *pde
 	ndev->stop		 = &dm9000_stop;
 	ndev->get_stats		 = &dm9000_get_stats;
 	ndev->set_multicast_list = &dm9000_hash_table;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	ndev->poll_controller	 = &dm9000_poll_controller;
+#endif

 #ifdef DM9000_PROGRAM_EEPROM
 	program_eeprom(db);
