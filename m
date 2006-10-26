Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422640AbWJZCU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422640AbWJZCU5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 22:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965289AbWJZCTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 22:19:12 -0400
Received: from isilmar.linta.de ([213.239.214.66]:31455 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S965287AbWJZCTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 22:19:04 -0400
Date: Wed, 25 Oct 2006 22:13:53 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, rdunlap@xenotime.net
Subject: [RFC PATCH 4/11] pcmcia/ds: driver layer error checking
Message-ID: <20061026021353.GE20473@dominikbrodowski.de>
Mail-Followup-To: linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, rdunlap@xenotime.net
References: <20061026021027.GA20473@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026021027.GA20473@dominikbrodowski.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>
Date: Fri, 20 Oct 2006 14:44:12 -0700
Subject: [PATCH] pcmcia/ds: driver layer error checking

Check driver layer return values in pcmcia/ds.c

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/ds.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 74b3124..af392bf 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -1292,10 +1292,22 @@ struct bus_type pcmcia_bus_type = {
 
 static int __init init_pcmcia_bus(void)
 {
+	int ret;
+
 	spin_lock_init(&pcmcia_dev_list_lock);
 
-	bus_register(&pcmcia_bus_type);
-	class_interface_register(&pcmcia_bus_interface);
+	ret = bus_register(&pcmcia_bus_type);
+	if (ret < 0) {
+		printk(KERN_WARNING "pcmcia: bus_register error: %d\n", ret);
+		return ret;
+	}
+	ret = class_interface_register(&pcmcia_bus_interface);
+	if (ret < 0) {
+		printk(KERN_WARNING
+			"pcmcia: class_interface_register error: %d\n", ret);
+		bus_unregister(&pcmcia_bus_type);
+		return ret;
+	}
 
 	pcmcia_setup_ioctl();
 
-- 
1.4.3

