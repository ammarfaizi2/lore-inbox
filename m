Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVCFXtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVCFXtd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVCFXrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 18:47:24 -0500
Received: from coderock.org ([193.77.147.115]:7088 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261583AbVCFWiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:38:08 -0500
Subject: [patch 2/8] isdn/capi: replace interruptible_sleep_on() with wait_event_interruptible()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
       domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:38:02 +0100
Message-Id: <20050306223803.77C4F1EC90@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use wait_event_interruptible() instead of the deprecated
interruptible_sleep_on(). Patch is straight-forward as current sleep is
conditionally looped. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/isdn/capi/capi.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff -puN drivers/isdn/capi/capi.c~int_sleep_on-drivers_isdn_capi_capi drivers/isdn/capi/capi.c
--- kj/drivers/isdn/capi/capi.c~int_sleep_on-drivers_isdn_capi_capi	2005-03-05 16:11:36.000000000 +0100
+++ kj-domen/drivers/isdn/capi/capi.c	2005-03-05 16:11:36.000000000 +0100
@@ -675,13 +675,8 @@ capi_read(struct file *file, char __user
 		if (file->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 
-		for (;;) {
-			interruptible_sleep_on(&cdev->recvwait);
-			if ((skb = skb_dequeue(&cdev->recvqueue)) != 0)
-				break;
-			if (signal_pending(current))
-				break;
-		}
+		wait_event_interruptible(cdev->recvwait,
+				((skb = skb_dequeue(&cdev->recvqueue)) == 0));
 		if (skb == 0)
 			return -ERESTARTNOHAND;
 	}
_
