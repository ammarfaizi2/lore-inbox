Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVDZHgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVDZHgq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 03:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVDZHfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 03:35:10 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:42657 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261395AbVDZHeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 03:34:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Make kobject's name be const char *
Date: Tue, 26 Apr 2005 02:32:00 -0500
User-Agent: KMail/1.8
Cc: Greg KH <gregkh@suse.de>
References: <200504260229.03866.dtor_core@ameritech.net>
In-Reply-To: <200504260229.03866.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504260232.01017.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kobject: make kobject's name const char * since users should not
	 attempt to change it (except by calling kobject_rename).

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 include/linux/kobject.h |    6 +++---
 lib/kobject.c           |    2 +-
 lib/kobject_uevent.c    |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

Index: dtor/include/linux/kobject.h
===================================================================
--- dtor.orig/include/linux/kobject.h
+++ dtor/include/linux/kobject.h
@@ -33,7 +33,7 @@
 extern u64 hotplug_seqnum;
 
 struct kobject {
-	char			* k_name;
+	const char		* k_name;
 	char			name[KOBJ_NAME_LEN];
 	struct kref		kref;
 	struct list_head	entry;
@@ -46,7 +46,7 @@ struct kobject {
 extern int kobject_set_name(struct kobject *, const char *, ...)
 	__attribute__((format(printf,2,3)));
 
-static inline char * kobject_name(struct kobject * kobj)
+static inline const char * kobject_name(const struct kobject * kobj)
 {
 	return kobj->k_name;
 }
@@ -57,7 +57,7 @@ extern void kobject_cleanup(struct kobje
 extern int kobject_add(struct kobject *);
 extern void kobject_del(struct kobject *);
 
-extern int kobject_rename(struct kobject *, char *new_name);
+extern int kobject_rename(struct kobject *, const char *new_name);
 
 extern int kobject_register(struct kobject *);
 extern void kobject_unregister(struct kobject *);
Index: dtor/lib/kobject.c
===================================================================
--- dtor.orig/lib/kobject.c
+++ dtor/lib/kobject.c
@@ -280,7 +280,7 @@ EXPORT_SYMBOL(kobject_set_name);
  *	@new_name: object's new name
  */
 
-int kobject_rename(struct kobject * kobj, char *new_name)
+int kobject_rename(struct kobject * kobj, const char *new_name)
 {
 	int error = 0;
 
Index: dtor/lib/kobject_uevent.c
===================================================================
--- dtor.orig/lib/kobject_uevent.c
+++ dtor/lib/kobject_uevent.c
@@ -197,7 +197,7 @@ void kobject_hotplug(struct kobject *kob
 	int i = 0;
 	int retval;
 	char *kobj_path = NULL;
-	char *name = NULL;
+	const char *name = NULL;
 	char *action_string;
 	u64 seq;
 	struct kobject *top_kobj = kobj;
@@ -249,7 +249,7 @@ void kobject_hotplug(struct kobject *kob
 		name = kobject_name(&kset->kobj);
 
 	argv [0] = hotplug_path;
-	argv [1] = name;
+	argv [1] = (char *)name; /* won't be changed but 'const' has to go */
 	argv [2] = NULL;
 
 	/* minimal command environment */
