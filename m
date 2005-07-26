Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVGZGbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVGZGbq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 02:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVGZGbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 02:31:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59319 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261791AbVGZGas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 02:30:48 -0400
Date: Tue, 26 Jul 2005 08:30:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk
Subject: [patch] Fix compilation in locomo.c
Message-ID: <20050726063043.GI8684@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not access children in struct device directly, use
device_for_each_child helper instead. It fixes compilation.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 3d7f15c66bc66c480d468e2c4d623949bba0d41f
tree 9734f5a58c31dade74b1b35c1ce0b0d6d44da589
parent 6cd7322dce560001570713269630390754881e5d
author <pavel@amd.(none)> Tue, 26 Jul 2005 08:29:38 +0200
committer <pavel@amd.(none)> Tue, 26 Jul 2005 08:29:38 +0200

 arch/arm/common/locomo.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -651,15 +651,15 @@ __locomo_probe(struct device *me, struct
 	return ret;
 }
 
-static void __locomo_remove(struct locomo *lchip)
+static int locomo_remove_child(struct device *dev, void *data)
 {
-	struct list_head *l, *n;
-
-	list_for_each_safe(l, n, &lchip->dev->children) {
-		struct device *d = list_to_dev(l);
+	device_unregister(dev);
+	return 0;
+} 
 
-		device_unregister(d);
-	}
+static void __locomo_remove(struct locomo *lchip)
+{
+	device_for_each_child(lchip->dev, NULL, locomo_remove_child);
 
 	if (lchip->irq != NO_IRQ) {
 		set_irq_chained_handler(lchip->irq, NULL);

-- 
teflon -- maybe it is a trademark, but it should not be.
