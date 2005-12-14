Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbVLNNdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbVLNNdD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbVLNNdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:33:02 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:25258 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932521AbVLNNdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:33:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=cs3hbAeQyad0EDx6NWSeqAAQy3Oa5r2vzWF+jKon0koietUXJ/2cPIZqbTaGudP7EC/Ls43kB9pHLXRlChe+zqR29cNUPw5a91yWXmdJn/KiX9RF98G7U6P9gfAJeS/XnS8q1weqLHGJKoit4IjaSvdZwZZQvu8EP+MqoFRctt4=
Message-ID: <e55525570512140532n2d6bde42n15e8f6ce1355965e@mail.gmail.com>
Date: Wed, 14 Dec 2005 09:32:59 -0400
From: Anderson Briglia <briglia.anderson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [patch 4/5] [RFC] Add MMC password protection (lock/unlock) support
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7247_20669358.1134567179072"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_7247_20669358.1134567179072
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



------=_Part_7247_20669358.1134567179072
Content-Type: text/x-patch; name=mmc_sysfs.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mmc_sysfs.diff"

Implement MMC password reset and forced erase support. It uses the sysfs
mechanism to send commands to the MMC subsystem. Usage:

Forced erase:

echo erase > /sys/bus/mmc/devices/mmc0\:0001/lockable

Remove password:

echo remove > /sys/bus/mmc/devices/mmc0\:0001/lockable

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-2.6.14-omap2/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-2.6.14-omap2.orig/drivers/mmc/mmc_sysfs.c	2005-12-13 17:22:13.000000000 -0400
+++ linux-2.6.14-omap2/drivers/mmc/mmc_sysfs.c	2005-12-13 17:22:14.000000000 -0400
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/key.h>
+#include <linux/err.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -64,6 +65,58 @@ static struct device_attribute mmc_dev_a
 
 static struct device_attribute mmc_dev_attr_scr = MMC_ATTR_RO(scr);
 
+#ifdef	CONFIG_MMC_PASSWORDS
+
+static ssize_t
+mmc_lockable_show(struct device *dev, struct device_attribute *att, char *buf)
+{
+	struct mmc_card *card = dev_to_mmc_card(dev);
+
+	if (!mmc_card_lockable(card))
+		return sprintf(buf, "unlockable\n");
+	else
+		return sprintf(buf, "lockable, %slocked\n", mmc_card_locked(card) ?
+			"" : "un");
+}
+
+/*
+ * implement MMC password reset ("remove password") and forced erase ("forgot
+ * password").
+ */
+static ssize_t
+mmc_lockable_store(struct device *dev, struct device_attribute *att,
+	const char *data, size_t len)
+{
+	struct mmc_card *card = dev_to_mmc_card(dev);
+
+	if (!mmc_card_lockable(card))
+		return -EINVAL;
+
+	if (mmc_card_locked(card) && !strncmp(data, "erase", 5)) {
+		/* forced erase only works while card is locked */
+		mmc_lock_unlock(card, NULL, MMC_LOCK_MODE_ERASE);
+		return len;
+	} else if (!mmc_card_locked(card) && !strncmp(data, "remove", 6)) {
+		/* remove password only works while card is unlocked */
+		struct key *mmc_key = request_key(&mmc_key_type, "mmc:key", NULL);
+
+		if (!IS_ERR(mmc_key)) {
+			int err = mmc_lock_unlock(card, mmc_key, MMC_LOCK_MODE_CLR_PWD);
+			if (!err)
+				return len;
+		} else
+			dev_dbg(&card->dev, "request_key returned error %ld\n", PTR_ERR(mmc_key));
+	}
+
+	return -EINVAL;
+}
+
+static struct device_attribute mmc_dev_attr_lockable =
+	__ATTR(lockable, S_IWUSR | S_IRUGO,
+		 mmc_lockable_show, mmc_lockable_store);
+
+#endif
+
 
 static void mmc_release_card(struct device *dev)
 {
@@ -235,6 +288,13 @@ int mmc_register_card(struct mmc_card *c
 			if (ret)
 				device_del(&card->dev);
 		}
+#ifdef CONFIG_MMC_PASSWORDS
+		if (mmc_card_lockable(card)) {
+			ret = device_create_file(&card->dev, &mmc_dev_attr_lockable);
+			if (ret)
+				device_del(&card->dev);
+		}
+#endif
 	}
 	return ret;
 }
@@ -248,7 +308,10 @@ void mmc_remove_card(struct mmc_card *ca
 	if (mmc_card_present(card)) {
 		if (mmc_card_sd(card))
 			device_remove_file(&card->dev, &mmc_dev_attr_scr);
-
+#ifdef CONFIG_MMC_PASSWORDS
+		if (mmc_card_lockable(card))
+			device_remove_file(&card->dev, &mmc_dev_attr_lockable);
+#endif
 		device_del(&card->dev);
 	}
 

--
Anderson Briglia,
Anderson Lizardo,
Carlos Eduardo Aguiar

Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil



------=_Part_7247_20669358.1134567179072--
