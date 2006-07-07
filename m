Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWGGKmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWGGKmA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 06:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWGGKmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 06:42:00 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:59292 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750716AbWGGKmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 06:42:00 -0400
Date: Fri, 7 Jul 2006 12:41:40 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] allow users to increase the oom-killer-score of their
 applications
Message-ID: <Pine.LNX.4.58.0607071222050.2795@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow users to increase the oom score of their applications.

Signed-off-by: Bodo Eggert <7eggert@gmx.de>

---

This patch is tested by "in the editor, it looks good".

There is a small race possibly preventing root from changing the 
score, but I don't think it's an issue, since kill -9 exisis and
the race is tiny.

--- ./fs/proc/base.c~	2006-07-07 12:20:54.000000000 +0200
+++ ./fs/proc/base.c	2006-07-07 12:20:54.000000000 +0200
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
