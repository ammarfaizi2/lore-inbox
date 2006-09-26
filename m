Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWIZFjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWIZFjx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWIZFjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:39:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:48085 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751428AbWIZFjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:39:48 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@xenotime.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 33/47] kobject: must_check fixes
Date: Mon, 25 Sep 2006 22:37:53 -0700
Message-Id: <11592491901464-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491862904-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com> <11592491833450-git-send-email-greg@kroah.com> <11592491862904-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Check all __must_check warnings in lib/kobject.c

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 lib/kobject.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 8e7c719..1699eb9 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -407,6 +407,7 @@ static struct kobj_type dir_ktype = {
 struct kobject *kobject_add_dir(struct kobject *parent, const char *name)
 {
 	struct kobject *k;
+	int ret;
 
 	if (!parent)
 		return NULL;
@@ -418,7 +419,13 @@ struct kobject *kobject_add_dir(struct k
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
-- 
1.4.2.1

