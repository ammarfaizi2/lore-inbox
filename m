Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWJXIz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWJXIz0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWJXIz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:55:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:30295 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030234AbWJXIzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:55:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=tPw+5jJJxtZD+kIgGvnxQuAA0eW89QYdgWWz7671vdqPDPfPdIv5q8Duf/TKuC/X2qAf8qGr/CKyoAopg1cmGfok//eme6j9JYicIpkV/iPHDB55qiaubcqmvntQrNVX3NgdlZ74U9NoN+gQqJ+Kl3SMUnY443d1GqL9oXHpvIA=
Date: Tue, 24 Oct 2006 17:55:20 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Doug Thompson <norsk5@xmission.com>
Subject: [PATCH] edac_mc: fix error handling
Message-ID: <20061024085520.GC7703@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	Doug Thompson <norsk5@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Call sysdev_class_unregister() on failure in edac_sysfs_memctrl_setup()
and decrease identation level for clear logic.

Cc: Doug Thompson <norsk5@xmission.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/edac/edac_mc.c |   49 +++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

Index: work-fault-inject/drivers/edac/edac_mc.c
===================================================================
--- work-fault-inject.orig/drivers/edac/edac_mc.c
+++ work-fault-inject/drivers/edac/edac_mc.c
@@ -230,34 +230,43 @@ static struct kobj_type ktype_memctrl = 
  */
 static int edac_sysfs_memctrl_setup(void)
 {
-	int err=0;
+	int err = 0;
 
 	debugf1("%s()\n", __func__);
 
 	/* create the /sys/devices/system/edac directory */
 	err = sysdev_class_register(&edac_class);
 
-	if (!err) {
-		/* Init the MC's kobject */
-		memset(&edac_memctrl_kobj, 0, sizeof (edac_memctrl_kobj));
-		edac_memctrl_kobj.parent = &edac_class.kset.kobj;
-		edac_memctrl_kobj.ktype = &ktype_memctrl;
-
-		/* generate sysfs "..../edac/mc"   */
-		err = kobject_set_name(&edac_memctrl_kobj,"mc");
-
-		if (!err) {
-			/* FIXME: maybe new sysdev_create_subdir() */
-			err = kobject_register(&edac_memctrl_kobj);
-
-			if (err)
-				debugf1("Failed to register '.../edac/mc'\n");
-			else
-				debugf1("Registered '.../edac/mc' kobject\n");
-		}
-	} else
+	if (err) {
 		debugf1("%s() error=%d\n", __func__, err);
+		return err;
+	}
+
+	/* Init the MC's kobject */
+	memset(&edac_memctrl_kobj, 0, sizeof (edac_memctrl_kobj));
+	edac_memctrl_kobj.parent = &edac_class.kset.kobj;
+	edac_memctrl_kobj.ktype = &ktype_memctrl;
+
+	/* generate sysfs "..../edac/mc"   */
+	err = kobject_set_name(&edac_memctrl_kobj,"mc");
 
+	if (err)
+		goto fail;
+
+	/* FIXME: maybe new sysdev_create_subdir() */
+	err = kobject_register(&edac_memctrl_kobj);
+
+	if (err) {
+		debugf1("Failed to register '.../edac/mc'\n");
+		goto fail;
+	}
+
+	debugf1("Registered '.../edac/mc' kobject\n");
+
+	return 0;
+
+fail:
+	sysdev_class_unregister(&edac_class);
 	return err;
 }
 
