Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVCEW7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVCEW7N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVCEWyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:54:49 -0500
Received: from coderock.org ([193.77.147.115]:58789 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261318AbVCEWnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:43:37 -0500
Subject: [patch 11/15] 8/34: block/swim3: replace interruptible_sleep_on() with wait_event_interruptible()
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:43:16 +0100
Message-Id: <20050305224316.E5D081F1F0@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use wait_event_interruptible() instead of the deprecated
interruptible_sleep_on(). The change is pretty straight-forward, as the current
sleep is conditional.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/swim3.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff -puN drivers/block/swim3.c~wait_event_int-drivers_block_swim3 drivers/block/swim3.c
--- kj/drivers/block/swim3.c~wait_event_int-drivers_block_swim3	2005-03-05 16:11:55.000000000 +0100
+++ kj-domen/drivers/block/swim3.c	2005-03-05 16:11:55.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/wait.h>
 #include <asm/io.h>
 #include <asm/dbdma.h>
 #include <asm/prom.h>
@@ -792,13 +793,11 @@ static int grab_drive(struct floppy_stat
 	cli();
 	if (fs->state != idle) {
 		++fs->wanted;
-		while (fs->state != available) {
-			if (interruptible && signal_pending(current)) {
-				--fs->wanted;
-				restore_flags(flags);
-				return -EINTR;
-			}
-			interruptible_sleep_on(&fs->wait);
+		wait_event_interruptible(fs->wait, (fs->state == available));
+		if (interruptible && signal_pending(current)) {
+			--fs->wanted;
+			restore_flags(flags);
+			return -EINTR;
 		}
 		--fs->wanted;
 	}
_
