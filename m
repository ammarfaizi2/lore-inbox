Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWGLDw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWGLDw0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 23:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWGLDwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 23:52:07 -0400
Received: from xenotime.net ([66.160.160.81]:12774 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932397AbWGLDwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 23:52:01 -0400
Date: Tue, 11 Jul 2006 20:51:49 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>, linux-pcmcia@lists.infradead.org
Cc: linux@brodo.de, akpm <akpm@osdl.org>
Subject: [PATCH -mm] pcmcia/ds: must_check fixes
Message-Id: <20060711205149.04666cb7.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Check all __must_check warnings in pcmcia/ds.c

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/pcmcia/ds.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

--- linux-2618-rc1mm1.orig/drivers/pcmcia/ds.c
+++ linux-2618-rc1mm1/drivers/pcmcia/ds.c
@@ -1367,10 +1367,22 @@ struct bus_type pcmcia_bus_type = {
 
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
 


---
