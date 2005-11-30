Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVK3KMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVK3KMK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 05:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVK3KMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 05:12:10 -0500
Received: from [85.8.13.51] ([85.8.13.51]:52389 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750751AbVK3KMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 05:12:09 -0500
Message-ID: <438D7AF2.7030409@drzeus.cx>
Date: Wed, 30 Nov 2005 11:12:02 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051105)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-13561-1133345527-0001-2"
To: Andrew Morton <akpm@osdl.org>
CC: tiwai@suse.de, linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: Re: [Fwd: [PATCH] [PNP][RFC] Suspend support for PNP bus.]
References: <436B2819.4090909@drzeus.cx>	<20051129113210.3d95d71f.akpm@osdl.org>	<438CA2D9.8030304@drzeus.cx>	<20051129120212.3e679296.akpm@osdl.org>	<438CB0D8.90607@drzeus.cx> <20051129130104.0b0fd77b.akpm@osdl.org>
In-Reply-To: <20051129130104.0b0fd77b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-13561-1133345527-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Send an update agaisnt next -mm if you like.  We can feed that in through
> the alsa tree too.  It's not really appropriate to be updating the pnp
> system via the alsa tree, but as long as it's all in one place, it works.
>
>   

Assuming the version you pointed out to me is the final one, then this 
patch will merge my changes into theirs.

Rgds
Pierre


--=_hermes.drzeus.cx-13561-1133345527-0001-2
Content-Type: text/x-patch; name="pnp-suspend.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnp-suspend.patch"

[PNP] Improved PnP suspend support.

Also use the PnP functions to start/stop the devices during the suspend so
that drivers will not have to duplicate this code.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/pnp/driver.c  |   37 ++++++++++++++++++++---
 drivers/pnp/manager.c |   78 +++++++++++++++++++++++++++++++++++++------------
 include/linux/pnp.h   |    4 +++
 3 files changed, 95 insertions(+), 24 deletions(-)

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index ea2cb9a..15fb758 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -150,19 +150,46 @@ static int pnp_bus_suspend(struct device
 {
 	struct pnp_dev * pnp_dev = to_pnp_dev(dev);
 	struct pnp_driver * pnp_drv = pnp_dev->driver;
+	int error;
+
+	if (!pnp_drv)
+		return 0;
+
+	if (pnp_drv->suspend) {
+		error = pnp_drv->suspend(pnp_dev, state);
+		if (error)
+			return error;
+	}
+
+	if (!(pnp_drv->flags & PNP_DRIVER_RES_DO_NOT_CHANGE) &&
+	    pnp_can_disable(pnp_dev)) {
+	    	error = pnp_stop_dev(pnp_dev);
+	    	if (error)
+	    		return error;
+	}
 
-	if (pnp_drv && pnp_drv->suspend)
-		return pnp_drv->suspend(pnp_dev, state);
 	return 0;
 }
 
-static void pnp_bus_resume(struct device *dev)
+static int pnp_bus_resume(struct device *dev)
 {
 	struct pnp_dev * pnp_dev = to_pnp_dev(dev);
 	struct pnp_driver * pnp_drv = pnp_dev->driver;
+	int error;
 
-	if (pnp_drv && pnp_drv->resume)
-		pnp_drv->resume(pnp_dev);
+	if (!pnp_drv)
+		return 0;
+
+	if (!(pnp_drv->flags & PNP_DRIVER_RES_DO_NOT_CHANGE)) {
+		error = pnp_start_dev(pnp_dev);
+		if (error)
+			return error;
+	}
+
+	if (pnp_drv->resume)
+		return pnp_drv->resume(pnp_dev);
+
+	return 0;
 }
 
 struct bus_type pnp_bus_type = {
diff --git a/drivers/pnp/manager.c b/drivers/pnp/manager.c
index 2616686..c4256aa 100644
--- a/drivers/pnp/manager.c
+++ b/drivers/pnp/manager.c
@@ -470,6 +470,53 @@ int pnp_auto_config_dev(struct pnp_dev *
 }
 
 /**
+ * pnp_start_dev - low-level start of the PnP device
+ * @dev: pointer to the desired device
+ *
+ * assumes that resources have alread been allocated
+ */
+
+int pnp_start_dev(struct pnp_dev *dev)
+{
+	if (!pnp_can_write(dev)) {
+		pnp_info("Device %s does not supported activation.", dev->dev.bus_id);
+		return -EINVAL;
+	}
+
+	if (dev->protocol->set(dev, &dev->res)<0) {
+		pnp_err("Failed to activate device %s.", dev->dev.bus_id);
+		return -EIO;
+	}
+
+	pnp_info("Device %s activated.", dev->dev.bus_id);
+
+	return 0;
+}
+
+/**
+ * pnp_stop_dev - low-level disable of the PnP device
+ * @dev: pointer to the desired device
+ *
+ * does not free resources
+ */
+
+int pnp_stop_dev(struct pnp_dev *dev)
+{
+	if (!pnp_can_disable(dev)) {
+		pnp_info("Device %s does not supported disabling.", dev->dev.bus_id);
+		return -EINVAL;
+	}
+	if (dev->protocol->disable(dev)<0) {
+		pnp_err("Failed to disable device %s.", dev->dev.bus_id);
+		return -EIO;
+	}
+
+	pnp_info("Device %s disabled.", dev->dev.bus_id);
+
+	return 0;
+}
+
+/**
  * pnp_activate_dev - activates a PnP device for use
  * @dev: pointer to the desired device
  *
@@ -477,6 +524,8 @@ int pnp_auto_config_dev(struct pnp_dev *
  */
 int pnp_activate_dev(struct pnp_dev *dev)
 {
+	int error;
+
 	if (!dev)
 		return -EINVAL;
 	if (dev->active) {
@@ -487,18 +536,11 @@ int pnp_activate_dev(struct pnp_dev *dev
 	if (pnp_auto_config_dev(dev))
 		return -EBUSY;
 
-	if (!pnp_can_write(dev)) {
-		pnp_info("Device %s does not supported activation.", dev->dev.bus_id);
-		return -EINVAL;
-	}
-
-	if (dev->protocol->set(dev, &dev->res)<0) {
-		pnp_err("Failed to activate device %s.", dev->dev.bus_id);
-		return -EIO;
-	}
+	error = pnp_start_dev(dev);
+	if (error)
+		return error;
 
 	dev->active = 1;
-	pnp_info("Device %s activated.", dev->dev.bus_id);
 
 	return 1;
 }
@@ -511,23 +553,19 @@ int pnp_activate_dev(struct pnp_dev *dev
  */
 int pnp_disable_dev(struct pnp_dev *dev)
 {
+	int error;
+
         if (!dev)
                 return -EINVAL;
 	if (!dev->active) {
 		return 0; /* the device is already disabled */
 	}
 
-	if (!pnp_can_disable(dev)) {
-		pnp_info("Device %s does not supported disabling.", dev->dev.bus_id);
-		return -EINVAL;
-	}
-	if (dev->protocol->disable(dev)<0) {
-		pnp_err("Failed to disable device %s.", dev->dev.bus_id);
-		return -EIO;
-	}
+	error = pnp_stop_dev(dev);
+	if (error)
+		return error;
 
 	dev->active = 0;
-	pnp_info("Device %s disabled.", dev->dev.bus_id);
 
 	/* release the resources so that other devices can use them */
 	down(&pnp_res_mutex);
@@ -558,6 +596,8 @@ EXPORT_SYMBOL(pnp_manual_config_dev);
 #if 0
 EXPORT_SYMBOL(pnp_auto_config_dev);
 #endif
+EXPORT_SYMBOL(pnp_start_dev);
+EXPORT_SYMBOL(pnp_stop_dev);
 EXPORT_SYMBOL(pnp_activate_dev);
 EXPORT_SYMBOL(pnp_disable_dev);
 EXPORT_SYMBOL(pnp_resource_change);
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index 472319f..93b0959 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -385,6 +385,8 @@ void pnp_init_resource_table(struct pnp_
 int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode);
 int pnp_auto_config_dev(struct pnp_dev *dev);
 int pnp_validate_config(struct pnp_dev *dev);
+int pnp_start_dev(struct pnp_dev *dev);
+int pnp_stop_dev(struct pnp_dev *dev);
 int pnp_activate_dev(struct pnp_dev *dev);
 int pnp_disable_dev(struct pnp_dev *dev);
 void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size);
@@ -428,6 +430,8 @@ static inline void pnp_init_resource_tab
 static inline int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode) { return -ENODEV; }
 static inline int pnp_auto_config_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_validate_config(struct pnp_dev *dev) { return -ENODEV; }
+static inline int pnp_start_dev(struct pnp_dev *dev) { return -ENODEV; }
+static inline int pnp_stop_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size) { }

--=_hermes.drzeus.cx-13561-1133345527-0001-2--
