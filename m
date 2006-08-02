Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWHBVhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWHBVhE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWHBVhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:37:04 -0400
Received: from mail1.cenara.com ([193.111.152.3]:28363 "EHLO
	kingpin.cenara.com") by vger.kernel.org with ESMTP id S932231AbWHBVhC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:37:02 -0400
From: Magnus =?iso-8859-1?q?Vigerl=F6f?= <wigge@bigfoot.com>
To: linux-input@atrey.karlin.mff.cuni.cz
Subject: [PATCH] input: Null-termination of strings returned to userspace
Date: Wed, 2 Aug 2006 23:36:30 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200608022336.30648.wigge@bigfoot.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes the risk of returning non-null terminated strings
to userspace in those cases the provided buffer is too small.

Signed-off-by: Magnus Vigerlöf <wigge@bigfoot.com>
---
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 12c7ab8..667333c 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -377,11 +377,13 @@ static int str_to_user(const char *str, 
 	if (!str)
 		return -ENOENT;
 
-	len = strlen(str) + 1;
-	if (len > maxlen)
-		len = maxlen;
+	len = strlen(str);
+	if (len >= maxlen)
+		len = maxlen - 1;
 
-	return copy_to_user(p, str, len) ? -EFAULT : len;
+	if (copy_to_user(p, str, len))
+		return -EFAULT;
+	return put_user('\0', (char __user *)p + len) ? -EFAULT : len + 1;
 }
 
 static long evdev_ioctl_handler(struct file *file, unsigned int cmd,
