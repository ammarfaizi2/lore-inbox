Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVCEW7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVCEW7N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVCEWyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:54:05 -0500
Received: from coderock.org ([193.77.147.115]:60069 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261320AbVCEWno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:43:44 -0500
Subject: [patch 12/15] 9/34: block/swim_iop: replace interruptible_sleep_on() with wait_event_interruptible()
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:43:19 +0100
Message-Id: <20050305224320.324321F203@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use wait_event_interruptible() instead of the deprecated
interruptible_sleep_on(). The change is pretty straight-forward, as the current
sleep is conditional.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/swim_iop.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff -puN drivers/block/swim_iop.c~wait_event_int-drivers_block_swim_iop drivers/block/swim_iop.c
--- kj/drivers/block/swim_iop.c~wait_event_int-drivers_block_swim_iop	2005-03-05 16:11:56.000000000 +0100
+++ kj-domen/drivers/block/swim_iop.c	2005-03-05 16:11:56.000000000 +0100
@@ -32,6 +32,7 @@
 #include <linux/fd.h>
 #include <linux/ioctl.h>
 #include <linux/blkdev.h>
+#include <linux/wait.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/mac_iop.h>
@@ -431,13 +432,11 @@ static int grab_drive(struct floppy_stat
 	local_irq_save(flags);
 	if (fs->state != idle) {
 		++fs->wanted;
-		while (fs->state != available) {
-			if (interruptible && signal_pending(current)) {
-				--fs->wanted;
-				local_irq_restore(flags);
-				return -EINTR;
-			}
-			interruptible_sleep_on(&fs->wait);
+		wait_event_interruptible(fs->wait, (fs->state == available));
+		if (interruptible && signal_pending(current)) {
+			--fs->wanted;
+			local_irq_restore(flags);
+			return -EINTR;
 		}
 		--fs->wanted;
 	}
_
