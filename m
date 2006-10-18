Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422895AbWJRUTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422895AbWJRUTE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422890AbWJRUQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:16:21 -0400
Received: from mx1.suse.de ([195.135.220.2]:22450 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422810AbWJRUJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:46 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 13/16] Driver core: Don't leak 'old_class_name' in drivers/base/core.c::device_rename()
Date: Wed, 18 Oct 2006 13:09:04 -0700
Message-Id: <11612021872574-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021841579-git-send-email-greg@kroah.com>
References: <20061018195833.GA21808@kroah.com> <1161202147758-git-send-email-greg@kroah.com> <11612021503109-git-send-email-greg@kroah.com> <1161202153578-git-send-email-greg@kroah.com> <11612021563449-git-send-email-greg@kroah.com> <11612021603361-git-send-email-greg@kroah.com> <1161202163247-git-send-email-greg@kroah.com> <1161202166551-git-send-email-greg@kroah.com> <11612021701905-git-send-email-greg@kroah.com> <11612021733101-git-send-email-greg@kroah.com> <11612021771048-git-send-email-greg@kroah.com> <11612021801495-git-send-email-greg@kroah.com> <11612021841579-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>

If kmalloc() fails to allocate space for 'old_symlink_name' in
drivers/base/core.c::device_rename(), then we'll leak 'old_class_name'.

Spotted by the Coverity checker.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 365f709..41f3dca 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -809,8 +809,10 @@ int device_rename(struct device *dev, ch
 
 	if (dev->class) {
 		old_symlink_name = kmalloc(BUS_ID_SIZE, GFP_KERNEL);
-		if (!old_symlink_name)
-			return -ENOMEM;
+		if (!old_symlink_name) {
+			error = -ENOMEM;
+			goto out_free_old_class;
+		}
 		strlcpy(old_symlink_name, dev->bus_id, BUS_ID_SIZE);
 	}
 
@@ -834,9 +836,10 @@ int device_rename(struct device *dev, ch
 	}
 	put_device(dev);
 
-	kfree(old_class_name);
 	kfree(new_class_name);
 	kfree(old_symlink_name);
+ out_free_old_class:
+	kfree(old_class_name);
 
 	return error;
 }
-- 
1.4.2.4

