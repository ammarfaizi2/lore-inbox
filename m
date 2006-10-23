Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWJWBWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWJWBWT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 21:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWJWBWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 21:22:19 -0400
Received: from viefep15-int.chello.at ([213.46.255.20]:2096 "EHLO
	viefep18-int.chello.at") by vger.kernel.org with ESMTP
	id S1751016AbWJWBWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 21:22:19 -0400
Message-ID: <453C1946.1080803@freemail.hu>
Date: Mon, 23 Oct 2006 03:22:14 +0200
From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.7.12) Gecko/20050920
X-Accept-Language: en, hu, de
MIME-Version: 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] input: init struct serio_bus at compile time
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Márton Németh <nm127@freemail.hu>

Initialize serio_bus structure at compile time instead of at runtime in serio_init().
This will speed up startup a little bit and also reduce code size.

Signed-off-by: Márton Németh <nm127@freemail.hu>

---
Patch against Linux kernel 2.6.19-rc2.


--- linux-2.6.19-rc2.orig/drivers/input/serio/serio.c	2006-10-13 18:25:04.000000000 +0200
+++ linux-2.6.19-rc2/drivers/input/serio/serio.c	2006-10-16 18:05:31.000000000 +0200
@@ -768,12 +768,6 @@ static int serio_driver_remove(struct de
  	return 0;
  }

-static struct bus_type serio_bus = {
-	.name =	"serio",
-	.probe = serio_driver_probe,
-	.remove = serio_driver_remove,
-};
-
  static void serio_add_driver(struct serio_driver *drv)
  {
  	int error;
@@ -930,15 +924,21 @@ irqreturn_t serio_interrupt(struct serio
  	return ret;
  }

+static struct bus_type serio_bus = {
+	.name =	"serio",
+	.dev_attrs = serio_device_attrs,
+	.drv_attrs = serio_driver_attrs,
+	.match = serio_bus_match,
+	.uevent = serio_uevent,
+	.probe = serio_driver_probe,
+	.remove = serio_driver_remove,
+	.resume = serio_resume,
+};
+
  static int __init serio_init(void)
  {
  	int error;

-	serio_bus.dev_attrs = serio_device_attrs;
-	serio_bus.drv_attrs = serio_driver_attrs;
-	serio_bus.match = serio_bus_match;
-	serio_bus.uevent = serio_uevent;
-	serio_bus.resume = serio_resume;
  	error = bus_register(&serio_bus);
  	if (error) {
  		printk(KERN_ERR "serio: failed to register serio bus, error: %d\n", error);
