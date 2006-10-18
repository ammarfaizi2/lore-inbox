Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422835AbWJRUMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422835AbWJRUMl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422868AbWJRUMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:12:17 -0400
Received: from ns1.suse.de ([195.135.220.2]:27058 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422832AbWJRUJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:55 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 15/15] aoe: fix sysfs_create_file warnings
Date: Wed, 18 Oct 2006 13:09:06 -0700
Message-Id: <11612021961246-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021913873-git-send-email-greg@kroah.com>
References: <20061018200433.GA10079@kroah.com> <11612021463993-git-send-email-greg@kroah.com> <11612021491255-git-send-email-greg@kroah.com> <1161202152750-git-send-email-greg@kroah.com> <11612021563910-git-send-email-greg@kroah.com> <11612021601016-git-send-email-greg@kroah.com> <11612021641240-git-send-email-greg@kroah.com> <11612021682148-git-send-email-greg@kroah.com> <1161202171977-git-send-email-greg@kroah.com> <11612021753859-git-send-email-greg@kroah.com> <1161202179462-git-send-email-greg@kroah.com> <11612021821994-git-send-email-greg@kroah.com> <1161202185862-git-send-email-greg@kroah.com> <11612021882386-git-send-email-greg@kroah.com> <11612021913873-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Moved the attributes into a group, making the compiler be quiet about
ignoring the return value of the file create calls.  This also also
fixed a bug when removing the files, which were not symlinks.

Cc: "Ed L. Cashin" <ecashin@coraid.com>
Cc: Alan Cox <alan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/aoe/aoeblk.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 4259b52..d433f27 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -63,21 +63,26 @@ static struct disk_attribute disk_attr_f
 	.show = aoedisk_show_fwver
 };
 
-static void
+static struct attribute *aoe_attrs[] = {
+	&disk_attr_state.attr,
+	&disk_attr_mac.attr,
+	&disk_attr_netif.attr,
+	&disk_attr_fwver.attr,
+};
+
+static const struct attribute_group attr_group = {
+	.attrs = aoe_attrs,
+};
+
+static int
 aoedisk_add_sysfs(struct aoedev *d)
 {
-	sysfs_create_file(&d->gd->kobj, &disk_attr_state.attr);
-	sysfs_create_file(&d->gd->kobj, &disk_attr_mac.attr);
-	sysfs_create_file(&d->gd->kobj, &disk_attr_netif.attr);
-	sysfs_create_file(&d->gd->kobj, &disk_attr_fwver.attr);
+	return sysfs_create_group(&d->gd->kobj, &attr_group);
 }
 void
 aoedisk_rm_sysfs(struct aoedev *d)
 {
-	sysfs_remove_link(&d->gd->kobj, "state");
-	sysfs_remove_link(&d->gd->kobj, "mac");
-	sysfs_remove_link(&d->gd->kobj, "netif");
-	sysfs_remove_link(&d->gd->kobj, "firmware-version");
+	sysfs_remove_group(&d->gd->kobj, &attr_group);
 }
 
 static int
-- 
1.4.2.4

