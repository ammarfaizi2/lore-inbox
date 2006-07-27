Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161013AbWG0M51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbWG0M51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 08:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWG0M51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 08:57:27 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:37572 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S932072AbWG0M50
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 08:57:26 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <E1G65Ok-0002fh-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Thu, 27 Jul 2006 14:55:30 +0200)
Subject: [PATCH 1/5] fuse: fix zero timeout
References: <E1G65Ok-0002fh-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1G65QR-0002gm-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 27 Jul 2006 14:57:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An attribute and entry timeout of zero should mean, that the entity is
invalidated immediately after the operation.  Previously invalidation
only happened at the next clock tick.

Reported and tested by Craig Davies.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-07-27 14:35:15.000000000 +0200
+++ linux/fs/fuse/dir.c	2006-07-27 14:37:59.000000000 +0200
@@ -25,8 +25,11 @@
  */
 static unsigned long time_to_jiffies(unsigned long sec, unsigned long nsec)
 {
-	struct timespec ts = {sec, nsec};
-	return jiffies + timespec_to_jiffies(&ts);
+	if (sec || nsec) {
+		struct timespec ts = {sec, nsec};
+		return jiffies + timespec_to_jiffies(&ts);
+	} else
+		return jiffies - 1;
 }
 
 /*
