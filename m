Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbVI3C0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVI3C0j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVI3C0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:26:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45482 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932541AbVI3C0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:26:02 -0400
Message-Id: <20050930022140.536323000@localhost.localdomain>
References: <20050930022016.640197000@localhost.localdomain>
Date: Thu, 29 Sep 2005 19:20:17 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, Olaf Hering <olh@suse.de>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Marcus Wegner <wegner3000@hotmail.com>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 01/10] [PATCH] yenta oops fix
Content-Disposition: inline; filename=yenta-oops-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

In some cases, especially on modern laptops with a lot of PCI and
cardbus bridges, we're unable to assign correct secondary/subordinate
bus numbers to all cardbus bridges due to BIOS limitations unless
we are using "pci=assign-busses" boot option.
So some cardbus controllers may not have attached subordinate pci_bus
structure, and yenta driver must cope with it - just ignore such cardbus
bridges.

For example, see https://bugzilla.novell.com/show_bug.cgi?id=113778

Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 drivers/pcmcia/yenta_socket.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletion(-)

Index: linux-2.6.13.y/drivers/pcmcia/yenta_socket.c
===================================================================
--- linux-2.6.13.y.orig/drivers/pcmcia/yenta_socket.c
+++ linux-2.6.13.y/drivers/pcmcia/yenta_socket.c
@@ -976,7 +976,18 @@ static int __devinit yenta_probe (struct
 {
 	struct yenta_socket *socket;
 	int ret;
-	
+
+	/*
+	 * If we failed to assign proper bus numbers for this cardbus
+	 * controller during PCI probe, its subordinate pci_bus is NULL.
+	 * Bail out if so.
+	 */
+	if (!dev->subordinate) {
+		printk(KERN_ERR "Yenta: no bus associated with %s! "
+			"(try 'pci=assign-busses')\n", pci_name(dev));
+		return -ENODEV;
+	}
+
 	socket = kmalloc(sizeof(struct yenta_socket), GFP_KERNEL);
 	if (!socket)
 		return -ENOMEM;

--
