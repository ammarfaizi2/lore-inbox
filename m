Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbUCPANF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbUCPAKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:10:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:16047 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262860AbUCPACN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:13 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913913858@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:31 -0800
Message-Id: <10793913912632@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.61.11, 2004/02/23 16:28:43-08:00, khali@linux-fr.org

[PATCH] I2C: fix Hangs with w83781d

Here is a patch for the w83781d driver that prevents register bits from
being arbitrary changed when we force temp2/3 to comparator mode. Keith
Duthie had been reporting various problems with that driver and finally
found that this arbitrary change was the cause of them. He also tested
this patch, which he confirmed to work.


 drivers/i2c/chips/w83781d.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:37:03 2004
+++ b/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:37:03 2004
@@ -1632,7 +1632,11 @@
 		if (type != w83781d) {
 			/* enable comparator mode for temp2 and temp3 so
 			   alarm indication will work correctly */
-			w83781d_write_value(client, W83781D_REG_IRQ, 0x41);
+			i = w83781d_read_value(client, W83781D_REG_IRQ);
+			if (!(i & 0x40))
+				w83781d_write_value(client, W83781D_REG_IRQ,
+						    i | 0x40);
+
 			for (i = 0; i < 3; i++)
 				data->pwmenable[i] = 1;
 		}

