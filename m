Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbTCQTNj>; Mon, 17 Mar 2003 14:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261841AbTCQTNj>; Mon, 17 Mar 2003 14:13:39 -0500
Received: from air-2.osdl.org ([65.172.181.6]:27264 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261842AbTCQTNi>;
	Mon, 17 Mar 2003 14:13:38 -0500
Date: Mon, 17 Mar 2003 11:24:32 -0800
From: Bob Miller <rem@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.64] Add error checking get_disk().
Message-ID: <20030317192432.GC10775@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The get_disk() function should check the return value from kobject_get()
before passing it to to_disk().  This patch fixes this error.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17


diff -Nru a/drivers/block/genhd.c b/drivers/block/genhd.c
--- a/drivers/block/genhd.c	Mon Mar 17 11:12:16 2003
+++ b/drivers/block/genhd.c	Mon Mar 17 11:12:16 2003
@@ -538,12 +538,20 @@
 struct gendisk *get_disk(struct gendisk *disk)
 {
 	struct module *owner;
+	struct kobject *kobj;
+
 	if (!disk->fops)
 		return NULL;
 	owner = disk->fops->owner;
 	if (owner && !try_module_get(owner))
 		return NULL;
-	return to_disk(kobject_get(&disk->kobj));
+	kobj = kobject_get(&disk->kobj);
+	if (kobj == NULL) {
+		module_put(owner);
+		return NULL;
+	}
+	return to_disk(kobj);
+
 }
 
 void put_disk(struct gendisk *disk)
