Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263613AbVBEBGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263613AbVBEBGR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 20:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263490AbVBEBGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 20:06:16 -0500
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:61202 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id S266468AbVBDWEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:04:24 -0500
Message-ID: <4203F22D.5070200@gentoo.org>
Date: Fri, 04 Feb 2005 22:07:41 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, linux-pm@osdl.org
Subject: [-mm PATCH] driver model: PM type conversions in drivers/macintosh
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020000020903040405070106"
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CxBYs-000Ksu-92*6k56ICxM3xc*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020000020903040405070106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This fixes PM driver model type checking for drivers/macintosh.
Acked by Pavel Machek.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--------------020000020903040405070106
Content-Type: text/x-patch;
 name="macintosh-pm-type-safety.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="macintosh-pm-type-safety.patch"

diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/macintosh/macio_asic.c linux-dsd/drivers/macintosh/macio_asic.c
--- linux-2.6.11-rc2-mm2/drivers/macintosh/macio_asic.c	2004-12-24 21:34:31.000000000 +0000
+++ linux-dsd/drivers/macintosh/macio_asic.c	2005-02-02 21:30:44.000000000 +0000
@@ -106,7 +106,7 @@ static void macio_device_shutdown(struct
 		drv->shutdown(macio_dev);
 }
 
-static int macio_device_suspend(struct device *dev, u32 state)
+static int macio_device_suspend(struct device *dev, pm_message_t state)
 {
 	struct macio_dev * macio_dev = to_macio_device(dev);
 	struct macio_driver * drv = to_macio_driver(dev->driver);
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/macintosh/mediabay.c linux-dsd/drivers/macintosh/mediabay.c
--- linux-2.6.11-rc2-mm2/drivers/macintosh/mediabay.c	2004-12-24 21:34:26.000000000 +0000
+++ linux-dsd/drivers/macintosh/mediabay.c	2005-02-02 21:56:29.000000000 +0000
@@ -710,7 +710,7 @@ static int __devinit media_bay_attach(st
 
 }
 
-static int __pmac media_bay_suspend(struct macio_dev *mdev, u32 state)
+static int __pmac media_bay_suspend(struct macio_dev *mdev, pm_message_t state)
 {
 	struct media_bay_info	*bay = macio_get_drvdata(mdev);
 
@@ -729,8 +729,8 @@ static int __pmac media_bay_resume(struc
 {
 	struct media_bay_info	*bay = macio_get_drvdata(mdev);
 
-	if (mdev->ofdev.dev.power.power_state != 0) {
-		mdev->ofdev.dev.power.power_state = 0;
+	if (mdev->ofdev.dev.power.power_state != PMSG_ON) {
+		mdev->ofdev.dev.power.power_state = PMSG_ON;
 
 	       	/* We re-enable the bay using it's previous content
 	       	   only if it did not change. Note those bozo timings,
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/include/asm-ppc/macio.h linux-dsd/include/asm-ppc/macio.h
--- linux-2.6.11-rc2-mm2/include/asm-ppc/macio.h	2004-12-24 21:34:01.000000000 +0000
+++ linux-dsd/include/asm-ppc/macio.h	2005-02-02 21:34:30.000000000 +0000
@@ -126,7 +126,7 @@ struct macio_driver
 	int	(*probe)(struct macio_dev* dev, const struct of_match *match);
 	int	(*remove)(struct macio_dev* dev);
 
-	int	(*suspend)(struct macio_dev* dev, u32 state);
+	int	(*suspend)(struct macio_dev* dev, pm_message_t state);
 	int	(*resume)(struct macio_dev* dev);
 	int	(*shutdown)(struct macio_dev* dev);
 

--------------020000020903040405070106--
