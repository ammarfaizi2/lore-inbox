Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265043AbTFCPP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbTFCPP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:15:29 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29398 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265043AbTFCPP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:15:27 -0400
Date: Tue, 3 Jun 2003 17:28:48 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>, Henrique Gobbi <henrique.gobbi@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.21rc6-ac1: fix pc300_drv.c .text.exit
Message-ID: <20030603152848.GE27168@fs.tum.de>
References: <200305311153.h4VBrNi21640@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305311153.h4VBrNi21640@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile pc300_drv.c statically into a kernel without hotplug 
support results in a .text.exit error at final linking.

The problem is that the pointer to the __devexit cpc_remove_one didn't 
use __devexit_p.

The patch below fixes this issue, besides it does a few small cleanups 
to the struct.

Please apply
Adrian


--- linux-2.4.21-rc6-ac1-full-nohotplug/drivers/net/wan/pc300_drv.c.old	2003-06-02 22:37:04.000000000 +0200
+++ linux-2.4.21-rc6-ac1-full-nohotplug/drivers/net/wan/pc300_drv.c	2003-06-02 22:42:46.000000000 +0200
@@ -3461,12 +3461,10 @@
 }
 
 static struct pci_driver cpc_driver = {
-	name:"pc300",
-	id_table:cpc_pci_dev_id,
-	probe:cpc_init_one,
-	remove:cpc_remove_one,
-	suspend:NULL,
-	resume:NULL,
+	.name		= "pc300",
+	.id_table	= cpc_pci_dev_id,
+	.probe		= cpc_init_one,
+	.remove		= __devexit_p(cpc_remove_one),
 };
 
 static int __init cpc_init(void)
