Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932687AbWCIA4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbWCIA4U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbWCIA4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:56:20 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:9251 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S932687AbWCIA4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:56:19 -0500
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=yeNaj6vfAgBy9AAwbgNgknUzbDCl8Yr3VpmFGfGpI0kIR5xGFzm784MOwJnJtkOvxwUNf7GtCWwqwj3q+tba7goJHGIsZzFC/SIzBHR1GUa1lhjp3caqR/VeJyL/oA1O;
X-IronPort-AV: i="4.02,177,1139205600"; 
   d="scan'208"; a="56520403:sNHT28557782"
Date: Wed, 8 Mar 2006 19:03:18 -0600
From: Doug Warzecha <Douglas_Warzecha@dell.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dcdbas: dcdbas_pdev referenced after platform_device_unregister on exit
Message-ID: <20060309010317.GA4375@sysman-doug.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

smi_data_buf_free() references dcdbas_pdev when calling dma_free_coherent().  In dcdbas_exit(), smi_data_buf_free() is called after platform_device_unregister(dcdbas_pdev).

This patch moves platform_device_unregister(dcdbas_pdev) after smi_data_buf_free() in dcdbas_exit().

Signed-off-by: Doug Warzecha <Douglas_Warzecha@dell.com>
---

--- linux-2.6.16-rc5/drivers/firmware/dcdbas.c.orig	2006-03-07 16:28:18.000000000 -0600
+++ linux-2.6.16-rc5/drivers/firmware/dcdbas.c	2006-03-07 19:38:46.172641512 -0600
@@ -39,7 +39,7 @@
 #include "dcdbas.h"
 
 #define DRIVER_NAME		"dcdbas"
-#define DRIVER_VERSION		"5.6.0-1"
+#define DRIVER_VERSION		"5.6.0-2"
 #define DRIVER_DESCRIPTION	"Dell Systems Management Base Driver"
 
 static struct platform_device *dcdbas_pdev;
@@ -581,9 +581,13 @@ static int __init dcdbas_init(void)
  */
 static void __exit dcdbas_exit(void)
 {
-	platform_device_unregister(dcdbas_pdev);
+	/*
+	 * make sure functions that use dcdbas_pdev are called
+	 * before platform_device_unregister
+	 */
 	unregister_reboot_notifier(&dcdbas_reboot_nb);
 	smi_data_buf_free();
+	platform_device_unregister(dcdbas_pdev);
 }
 
 module_init(dcdbas_init);
