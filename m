Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWARA2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWARA2H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWARA2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:28:06 -0500
Received: from [151.97.230.9] ([151.97.230.9]:20451 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S964980AbWARA1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:27:42 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 1/9] uml: avoid sysfs warning on hot-unplug
Date: Wed, 18 Jan 2006 01:19:21 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060118001920.14622.79573.stgit@zion.home.lan>
In-Reply-To: <20060117235659.14622.18544.stgit@zion.home.lan>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Define a release method for the ubd and network driver so that sysfs doesn't
complain when one is removed via:

host $ uml_mconsole <umid> remove <dev>

Done by Jeff around January for ubd only, later lost, then restored in his tree
- however I'm merging it now since there's no reason to leave this here.

We don't need to do any cleanup in the new added method, because when hot-unplug
is done by uml_mconsole we already handle cleanup in mconsole infrastructure,
i.e.  mc_device->remove (net_remove/ubd_remove), which is also the calling
method.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/net_kern.c |    6 ++++++
 arch/um/drivers/ubd_kern.c |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index fb1f9fb..5b8c64e 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -276,6 +276,11 @@ static struct platform_driver uml_net_dr
 };
 static int driver_registered;
 
+/* Sysfs requires a ->release when mconsole hot-unplug is done */
+static void dummy_device_release(struct device *dev)
+{
+}
+
 static int eth_configure(int n, void *init, char *mac,
 			 struct transport *transport)
 {
@@ -324,6 +329,7 @@ static int eth_configure(int n, void *in
 	}
 	device->pdev.id = n;
 	device->pdev.name = DRIVER_NAME;
+	device->pdev.dev.release = dummy_device_release;
 	platform_device_register(&device->pdev);
 	SET_NETDEV_DEV(dev,&device->pdev.dev);
 
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 7696f8d..49dda56 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -617,6 +617,11 @@ static int ubd_open_dev(struct ubd *dev)
 	return(err);
 }
 
+/* Sysfs requires a ->release when mconsole hot-unplug is done */
+static void dummy_device_release(struct device *dev)
+{
+}
+
 static int ubd_new_disk(int major, u64 size, int unit,
 			struct gendisk **disk_out)
 			
@@ -652,6 +657,7 @@ static int ubd_new_disk(int major, u64 s
 	if (major == MAJOR_NR) {
 		ubd_dev[unit].pdev.id   = unit;
 		ubd_dev[unit].pdev.name = DRIVER_NAME;
+		ubd_dev[unit].pdev.dev.release = dummy_device_release;
 		platform_device_register(&ubd_dev[unit].pdev);
 		disk->driverfs_dev = &ubd_dev[unit].pdev.dev;
 	}

