Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVCFWpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVCFWpa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVCFWoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:44:04 -0500
Received: from coderock.org ([193.77.147.115]:8880 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261585AbVCFWiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:38:12 -0500
Subject: [patch 3/8] isdn/isdn_common: replace interruptible_sleep_on() with wait_event()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
       domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:38:06 +0100
Message-Id: <20050306223806.C0E071EDA4@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Incorrect subject line, sorry.


Use wait_event() instead of the deprecated
interruptible_sleep_on(). Current code does not check for signals, so
interruptible seems unnecessary. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/isdn/i4l/isdn_common.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN drivers/isdn/i4l/isdn_common.c~int_sleep_on-drivers_isdn_i4l_isdn_common drivers/isdn/i4l/isdn_common.c
--- kj/drivers/isdn/i4l/isdn_common.c~int_sleep_on-drivers_isdn_i4l_isdn_common	2005-03-05 16:11:37.000000000 +0100
+++ kj-domen/drivers/isdn/i4l/isdn_common.c	2005-03-05 16:11:37.000000000 +0100
@@ -19,6 +19,7 @@
 #include <linux/vmalloc.h>
 #include <linux/isdn.h>
 #include <linux/smp_lock.h>
+#include <linux/wait.h>
 #include "isdn_common.h"
 #include "isdn_tty.h"
 #include "isdn_net.h"
@@ -1066,8 +1067,8 @@ isdn_write(struct file *file, const char
 			goto out;
 		}
 		chidx = isdn_minor2chan(minor);
-		while (isdn_writebuf_stub(drvidx, chidx, buf, count) != count)
-			interruptible_sleep_on(&dev->drv[drvidx]->snd_waitq[chidx]);
+		wait_event(dev->drv[drvidx]->snd_waitq[chidx],
+				(isdn_writebuf_stub(drvidx, chidx, buf, count) == count));
 		retval = count;
 		goto out;
 	}
_
