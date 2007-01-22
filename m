Return-Path: <linux-kernel-owner+w=401wt.eu-S1751935AbXAVPWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbXAVPWN (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbXAVPWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:22:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44908 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbXAVPWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:22:12 -0500
Date: Mon, 22 Jan 2007 10:22:09 -0500
From: Prarit Bhargava <prarit@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: matt_domsch@dell.com, matthew.e.tolentino@intel.com,
       anil.s.keshavamurthy@intel.com, Prarit Bhargava <prarit@redhat.com>
Message-Id: <20070122152209.29717.52473.sendpatchset@prarit.boston.redhat.com>
Subject: [PATCH] Fix race in efi variable delete code.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix race when deleting an EFI variable and issuing another EFI command on the
same variable.  The removal of the variable from the efivars_list should be
done in efivar_delete and not delayed until the kprobes release.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>

diff --git a/drivers/firmware/efivars.c b/drivers/firmware/efivars.c
index 5ab5e39..bf2ca97 100644
--- a/drivers/firmware/efivars.c
+++ b/drivers/firmware/efivars.c
@@ -385,10 +385,8 @@ static struct sysfs_ops efivar_attr_ops = {
 
 static void efivar_release(struct kobject *kobj)
 {
-	struct efivar_entry *var = container_of(kobj, struct efivar_entry, kobj);
-	spin_lock(&efivars_lock);
-	list_del(&var->list);
-	spin_unlock(&efivars_lock);
+	struct efivar_entry *var = container_of(kobj, struct efivar_entry,
+						kobj);
 	kfree(var);
 }
 
@@ -537,6 +535,9 @@ efivar_delete(struct subsystem *sub, const char *buf, size_t count)
 		spin_unlock(&efivars_lock);
 		return -EIO;
 	}
+
+	list_del(&search_efivar->list);
+
 	/* We need to release this lock before unregistering. */
 	spin_unlock(&efivars_lock);
 
