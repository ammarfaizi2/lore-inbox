Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267369AbUBRUlq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUBRUlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:41:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:18049 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267369AbUBRUln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:41:43 -0500
Date: Wed, 18 Feb 2004 12:40:34 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: jt@hpl.hp.com
Cc: jt@bougret.hpl.hp.com, Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.3 + hp100 -> Oops
Message-Id: <20040218124034.05c9f6aa@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040218201559.GA31872@bougret.hpl.hp.com>
References: <20040218201559.GA31872@bougret.hpl.hp.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should fix the problem... The multi-bus probe logic error handling was
botched.

diff -Nru a/drivers/net/hp100.c b/drivers/net/hp100.c
--- a/drivers/net/hp100.c	Wed Feb 18 12:39:41 2004
+++ b/drivers/net/hp100.c	Wed Feb 18 12:39:41 2004
@@ -3043,14 +3043,27 @@
 	int err;
 
 	err = hp100_isa_init();
-
+	if (err && err != -ENODEV)
+		goto out;
 #ifdef CONFIG_EISA
-	err |= eisa_driver_register(&hp100_eisa_driver);
+	err = eisa_driver_register(&hp100_eisa_driver);
+	if (err && err != -ENODEV) 
+		goto out2;
 #endif
 #ifdef CONFIG_PCI
-	err |= pci_module_init(&hp100_pci_driver);
+	err = pci_module_init(&hp100_pci_driver);
+	if (err && err != -ENODEV) 
+		goto out3;
 #endif
+ out:
 	return err;
+ out3:
+#ifdef CONFIG_EISA
+	eisa_driver_unregister (&hp100_eisa_driver);
+ out2:
+#endif
+	hp100_isa_cleanup();
+	goto out;
 }
 
 
