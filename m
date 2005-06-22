Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262826AbVFVFW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbVFVFW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbVFVFSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:18:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:33175 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262746AbVFVFMO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:12:14 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1_smem: support for new simple rom family [0x81 id].
In-Reply-To: <11194171264139@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:12:06 -0700
Message-Id: <11194171262246@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1_smem: support for new simple rom family [0x81 id].

Support for new simple rom family [0x81 id].
It is the same as existing 0x01 family,
which is used in ds9490* w1 adapters.
Patch is on top of new-thermal-sensor-families patch.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 85e941cc9f10316080a16b121d24d329e5c2a65d
tree 85e034582cfb6f9efb40e49efdef3490f5e56eb6
parent 718a538f945a84244a460df434c3f6f04701957b
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Mon, 02 May 2005 14:26:42 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:43:09 -0700

 drivers/w1/w1_family.h |    3 ++-
 drivers/w1/w1_smem.c   |   26 ++++++++++++++++++++++----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/w1/w1_family.h b/drivers/w1/w1_family.h
--- a/drivers/w1/w1_family.h
+++ b/drivers/w1/w1_family.h
@@ -27,7 +27,8 @@
 #include <asm/atomic.h>
 
 #define W1_FAMILY_DEFAULT	0
-#define W1_FAMILY_SMEM		0x01
+#define W1_FAMILY_SMEM_01	0x01
+#define W1_FAMILY_SMEM_81	0x81
 #define W1_THERM_DS18S20 	0x10
 #define W1_THERM_DS1822  	0x22
 #define W1_THERM_DS18B20 	0x28
diff --git a/drivers/w1/w1_smem.c b/drivers/w1/w1_smem.c
--- a/drivers/w1/w1_smem.c
+++ b/drivers/w1/w1_smem.c
@@ -99,19 +99,37 @@ out_dec:
 	return count;
 }
 
-static struct w1_family w1_smem_family = {
-	.fid = W1_FAMILY_SMEM,
+static struct w1_family w1_smem_family_01 = {
+	.fid = W1_FAMILY_SMEM_01,
+	.fops = &w1_smem_fops,
+};
+
+static struct w1_family w1_smem_family_81 = {
+	.fid = W1_FAMILY_SMEM_81,
 	.fops = &w1_smem_fops,
 };
 
 static int __init w1_smem_init(void)
 {
-	return w1_register_family(&w1_smem_family);
+	int err;
+
+	err = w1_register_family(&w1_smem_family_01);
+	if (err)
+		return err;
+	
+	err = w1_register_family(&w1_smem_family_81);
+	if (err) {
+		w1_unregister_family(&w1_smem_family_01);
+		return err;
+	}
+
+	return 0;
 }
 
 static void __exit w1_smem_fini(void)
 {
-	w1_unregister_family(&w1_smem_family);
+	w1_unregister_family(&w1_smem_family_01);
+	w1_unregister_family(&w1_smem_family_81);
 }
 
 module_init(w1_smem_init);

