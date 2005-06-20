Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVFUDSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVFUDSb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 23:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVFUDRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 23:17:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:4580 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261645AbVFTW7d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:33 -0400
Cc: benh@kernel.crashing.org
Subject: [PATCH] Driver core: Don't "lose" devices on suspend on failure
In-Reply-To: <1119308369583@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:29 -0700
Message-Id: <1119308369529@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver core: Don't "lose" devices on suspend on failure

I think we need this patch or we might "lose" devices to the dpm_irq_off
list if a failure occurs during the suspend process.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 42b16c051c3f462095fb8c9bad1bc05b34518cb9
tree 3178bf5b2e3b516b6aea270c757adf728db83836
parent 8215534ce7d073423bfa9c17405c43ab7636ca03
author Benjamin Herrenschmidt <benh@kernel.crashing.org> Tue, 31 May 2005 17:08:49 +1000
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:37 -0700

 drivers/base/power/suspend.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -114,8 +114,19 @@ int device_suspend(pm_message_t state)
 		put_device(dev);
 	}
 	up(&dpm_list_sem);
-	if (error)
+	if (error) {
+		/* we failed... before resuming, bring back devices from
+		 * dpm_off_irq list back to main dpm_off list, we do want
+		 * to call resume() on them, in case they partially suspended
+		 * despite returning -EAGAIN
+		 */
+		while (!list_empty(&dpm_off_irq)) {
+			struct list_head * entry = dpm_off_irq.next;
+			list_del(entry);
+			list_add(entry, &dpm_off);
+		}
 		dpm_resume();
+	}
 	up(&dpm_sem);
 	return error;
 }

