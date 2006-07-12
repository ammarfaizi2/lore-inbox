Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWGLVt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWGLVt3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWGLVt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:49:29 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:8611 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751440AbWGLVt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:49:28 -0400
Date: Wed, 12 Jul 2006 23:49:03 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: linux-kernel@vger.kernel.org
cc: Rik van Riel <riel@nl.linux.org>
Message-ID: <Pine.LNX.4.58.0607122302400.3618@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Subject: [RFC][PATCH][RESEND] allow users to increase the oom-killer-score of their applications
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow users to increase the oom score of their applications.

Signed-off-by: Bodo Eggert <7eggert@gmx.de>

---

This patch is tested by "in the editor, it looks good".

There is a small race possibly preventing root from changing the 
score, but I don't think it's an issue, since kill -9 exisis and
the race is tiny.

--- 2.6.17/fs/proc/base.c~	2006-07-07 12:20:54.000000000 +0200
+++ 2.6.17/fs/proc/base.c	2006-07-07 12:20:54.000000000 +0200
@@ -962,8 +962,6 @@ static ssize_t oom_adjust_write(struct f
 	char buffer[8], *end;
 	int oom_adjust;
 
-	if (!capable(CAP_SYS_RESOURCE))
-		return -EPERM;
 	memset(buffer, 0, 8);
 	if (count > 6)
 		count = 6;
@@ -974,6 +972,9 @@ static ssize_t oom_adjust_write(struct f
 		return -EINVAL;
 	if (*end == '\n')
 		end++;
+	if (!capable(CAP_SYS_RESOURCE)
+	&&  task->oomkilladj > oom_adjust)
+		return -EPERM;
 	task->oomkilladj = oom_adjust;
 	if (end - buffer == 0)
 		return -EIO;
-- 
Funny quotes:
20. The only substitute for good manners is fast reflexes.
