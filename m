Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUFRVHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUFRVHf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264223AbUFRVHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:07:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3457 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263769AbUFRVBE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:01:04 -0400
Message-ID: <40D35802.8010104@pobox.com>
Date: Fri, 18 Jun 2004 17:00:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [Fwd: [patch] fix via-velocity oopses]
Content-Type: multipart/mixed;
 boundary="------------050208050204070105000408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050208050204070105000408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

FYI (since there are other via-velocity changes floating about)

--------------050208050204070105000408
Content-Type: message/rfc822;
 name="[patch] fix via-velocity oopses"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[patch] fix via-velocity oopses"

Return-Path: <akpm@osdl.org>
X-Original-To: garzik@havoc.gtf.org
Delivered-To: garzik@havoc.gtf.org
Received: from icicle.pobox.com (icicle.pobox.com [207.8.226.3])
	by havoc.gtf.org (Postfix) with ESMTP id 4C6B57622
	for <garzik@havoc.gtf.org>; Thu, 17 Jun 2004 23:48:47 -0400 (EDT)
Received: from icicle.pobox.com (localhost [127.0.0.1])
	by icicle.pobox.com (Postfix) with ESMTP id 7802E10C10B
	for <garzik@havoc.gtf.org>; Thu, 17 Jun 2004 23:48:48 -0400 (EDT)
Delivered-To: jgarzik@pobox.com
Received: from colander (localhost [127.0.0.1])
	by icicle.pobox.com (Postfix) with ESMTP id B9E3210C0C7
	for <jgarzik@pobox.com>; Thu, 17 Jun 2004 23:48:47 -0400 (EDT)
Received: from mail.osdl.org (fw.osdl.org [65.172.181.6])
	by icicle.pobox.com (Postfix) with ESMTP
	for <jgarzik@pobox.com>; Thu, 17 Jun 2004 23:48:33 -0400 (EDT)
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i5I3mUr13716
	for <jgarzik@pobox.com>; Thu, 17 Jun 2004 20:48:31 -0700
Date: Thu, 17 Jun 2004 20:47:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [patch] fix via-velocity oopses
Message-Id: <20040617204739.7780ddc3.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=-2.8 required=7.0 tests=AWL,BAYES_00,DOMAIN_BODY,
	REMOVE_REMOVAL_1WORD autolearn=no version=2.63
X-Spam-Level: 
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on havoc.gtf.org



- Don't register the inet_addr notifier if the hardware is absent.  It
  oopses when other interfaces are being upped.

- Mark velocity_remove1() as __devexit_p in the pci_driver table.

- c99ification.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/net/via-velocity.c |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff -puN drivers/net/via-velocity.c~via-velocity-oops-fix drivers/net/via-velocity.c
--- 25/drivers/net/via-velocity.c~via-velocity-oops-fix	2004-06-02 23:14:37.933999272 -0700
+++ 25-akpm/drivers/net/via-velocity.c	2004-06-02 23:14:37.939998360 -0700
@@ -269,8 +269,9 @@ static int velocity_resume(struct pci_de
 static int velocity_netdev_event(struct notifier_block *nb, unsigned long notification, void *ptr);
 
 static struct notifier_block velocity_inetaddr_notifier = {
-      notifier_call:velocity_netdev_event,
+      .notifier_call	= velocity_netdev_event,
 };
+static int velocity_notifier_registered;
 
 #endif				/* CONFIG_PM */
 
@@ -776,6 +777,12 @@ static int __devinit velocity_found1(str
 
 	pci_set_power_state(pdev, 3);
 out:
+#ifdef CONFIG_PM
+	if (ret == 0 && !velocity_notifier_registered) {
+		velocity_notifier_registered = 1;
+		register_inetaddr_notifier(&velocity_inetaddr_notifier);
+	}
+#endif
 	return ret;
 
 err_iounmap:
@@ -2123,13 +2130,13 @@ static int velocity_ioctl(struct net_dev
  */
 
 static struct pci_driver velocity_driver = {
-      name:VELOCITY_NAME,
-      id_table:velocity_id_table,
-      probe:velocity_found1,
-      remove:velocity_remove1,
+      .name	= VELOCITY_NAME,
+      .id_table	= velocity_id_table,
+      .probe	= velocity_found1,
+      .remove	= __devexit_p(velocity_remove1),
 #ifdef CONFIG_PM
-      suspend:velocity_suspend,
-      resume:velocity_resume,
+      .suspend	= velocity_suspend,
+      .resume	= velocity_resume,
 #endif
 };
 
@@ -2147,9 +2154,6 @@ static int __init velocity_init_module(v
 	int ret;
 	ret = pci_module_init(&velocity_driver);
 
-#ifdef CONFIG_PM
-	register_inetaddr_notifier(&velocity_inetaddr_notifier);
-#endif
 	return ret;
 }
 
@@ -2165,7 +2169,10 @@ static int __init velocity_init_module(v
 static void __exit velocity_cleanup_module(void)
 {
 #ifdef CONFIG_PM
-	unregister_inetaddr_notifier(&velocity_inetaddr_notifier);
+	if (velocity_notifier_registered) {
+		unregister_inetaddr_notifier(&velocity_inetaddr_notifier);
+		velocity_notifier_registered = 0;
+	}
 #endif
 	pci_unregister_driver(&velocity_driver);
 }
_




--------------050208050204070105000408--
