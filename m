Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266201AbUHYWuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266201AbUHYWuD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUHYWsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:48:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:36763 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266292AbUHYWhC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:37:02 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9-rc1
In-Reply-To: <1093473387351@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 25 Aug 2004 15:36:27 -0700
Message-Id: <10934733871075@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1803.64.5, 2004/08/23 13:17:08-07:00, greg@kroah.com

KREF: make kref_get() return void as it makes sense to do so.

Thanks to Kiran for bugging me to do this.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/scsi/sd.c    |    4 +---
 drivers/scsi/sr.c    |    4 +---
 include/linux/kref.h |    2 +-
 lib/kref.c           |    3 +--
 4 files changed, 4 insertions(+), 9 deletions(-)


diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	2004-08-25 14:56:03 -07:00
+++ b/drivers/scsi/sd.c	2004-08-25 14:56:03 -07:00
@@ -180,8 +180,7 @@
 	if (disk->private_data == NULL)
 		goto out;
 	sdkp = scsi_disk(disk);
-	if (!kref_get(&sdkp->kref))
-		goto out_sdkp;
+	kref_get(&sdkp->kref);
 	if (scsi_device_get(sdkp->device))
 		goto out_put;
 	up(&sd_ref_sem);
@@ -189,7 +188,6 @@
 
  out_put:
 	kref_put(&sdkp->kref, scsi_disk_release);
- out_sdkp:
 	sdkp = NULL;
  out:
 	up(&sd_ref_sem);
diff -Nru a/drivers/scsi/sr.c b/drivers/scsi/sr.c
--- a/drivers/scsi/sr.c	2004-08-25 14:56:03 -07:00
+++ b/drivers/scsi/sr.c	2004-08-25 14:56:03 -07:00
@@ -140,15 +140,13 @@
 	if (disk->private_data == NULL)
 		goto out;
 	cd = scsi_cd(disk);
-	if (!kref_get(&cd->kref))
-		goto out_null;
+	kref_get(&cd->kref);
 	if (scsi_device_get(cd->device))
 		goto out_put;
 	goto out;
 
  out_put:
 	kref_put(&cd->kref, sr_kref_release);
- out_null:
 	cd = NULL;
  out:
 	up(&sr_ref_sem);
diff -Nru a/include/linux/kref.h b/include/linux/kref.h
--- a/include/linux/kref.h	2004-08-25 14:56:03 -07:00
+++ b/include/linux/kref.h	2004-08-25 14:56:03 -07:00
@@ -23,7 +23,7 @@
 };
 
 void kref_init(struct kref *kref);
-struct kref *kref_get(struct kref *kref);
+void kref_get(struct kref *kref);
 void kref_put(struct kref *kref, void (*release) (struct kref *kref));
 
 #endif /* _KREF_H_ */
diff -Nru a/lib/kref.c b/lib/kref.c
--- a/lib/kref.c	2004-08-25 14:56:03 -07:00
+++ b/lib/kref.c	2004-08-25 14:56:03 -07:00
@@ -27,11 +27,10 @@
  * kref_get - increment refcount for object.
  * @kref: object.
  */
-struct kref *kref_get(struct kref *kref)
+void kref_get(struct kref *kref)
 {
 	WARN_ON(!atomic_read(&kref->refcount));
 	atomic_inc(&kref->refcount);
-	return kref;
 }
 
 /**

