Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWGXS2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWGXS2M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 14:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWGXS2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 14:28:12 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:18193 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1751415AbWGXS2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 14:28:11 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Linux List <linux-kernel@vger.kernel.org>
Subject: [patch] [resend] Fix swsusp with PNP BIOS
Date: Mon, 24 Jul 2006 20:28:01 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1284
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200607242028.01666.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
swsusp is unable to suspend my machine (DTK FortisPro TOP-5A notebook) with 
kernel 2.6.17.5 because it's unable to suspend PNP device 00:16 (mouse).

The problem is in PNP BIOS. pnp_bus_suspend() calls pnp_stop_dev() for the 
device if the device can be disabled according to pnp_can_disable(). The 
problem is that pnpbios_disable_resources() returns -EPERM if the device is 
not dynamic (!pnpbios_is_dynamic()) but insert_device() happily sets 
PNP_DISABLE capability/flag even if the device is not dynamic. So we try to 
disable non-dynamic devices which will fail. 
This patch prevents insert_device() from setting PNP_DISABLE if the device is 
not dynamic and fixes suspend on my system.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-2.6.17.5-orig/drivers/pnp/pnpbios/core.c	2006-07-15 04:38:43.000000000 +0200
+++ linux-2.6.17.5/drivers/pnp/pnpbios/core.c	2006-07-22 18:44:36.000000000 +0200
@@ -346,7 +346,7 @@
 	dev->flags = node->flags;
 	if (!(dev->flags & PNPBIOS_NO_CONFIG))
 		dev->capabilities |= PNP_CONFIGURABLE;
-	if (!(dev->flags & PNPBIOS_NO_DISABLE))
+	if (!(dev->flags & PNPBIOS_NO_DISABLE) && pnpbios_is_dynamic(dev))
 		dev->capabilities |= PNP_DISABLE;
 	dev->capabilities |= PNP_READ;
 	if (pnpbios_is_dynamic(dev))

-- 
Ondrej Zary
