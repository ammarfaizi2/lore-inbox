Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWGLDw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWGLDw1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 23:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWGLDwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 23:52:06 -0400
Received: from xenotime.net ([66.160.160.81]:12518 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932394AbWGLDwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 23:52:01 -0400
Date: Tue, 11 Jul 2006 20:49:41 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, gregkh <greg@kroah.com>
Subject: [PATCH -mm] kobject: must_check fixes
Message-Id: <20060711204941.a46da8bf.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Check all __must_check warnings in lib/kobject.c

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 lib/kobject.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)

--- linux-2618-rc1mm1.orig/lib/kobject.c
+++ linux-2618-rc1mm1/lib/kobject.c
@@ -457,6 +457,7 @@ static struct kobj_type dir_ktype = {
 struct kobject *kobject_add_dir(struct kobject *parent, const char *name)
 {
 	struct kobject *k;
+	int ret;
 
 	if (!parent)
 		return NULL;
@@ -468,7 +469,13 @@ struct kobject *kobject_add_dir(struct k
 	k->parent = parent;
 	k->ktype = &dir_ktype;
 	kobject_set_name(k, name);
-	kobject_register(k);
+	ret = kobject_register(k);
+	if (ret < 0) {
+		printk(KERN_WARNING "kobject_add_dir: "
+			"kobject_register error: %d\n", ret);
+		kobject_del(k);
+		return NULL;
+	}
 
 	return k;
 }


---
