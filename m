Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbWD1QiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbWD1QiY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbWD1QiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:38:24 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:30447 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1030456AbWD1QiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:38:24 -0400
Date: Sat, 29 Apr 2006 01:38:57 +0900 (JST)
Message-Id: <20060429.013857.37531336.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] genrtc: fix read on 64-bit platforms
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix genrtc's read() routine for 64-bit platforms.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/drivers/char/genrtc.c b/drivers/char/genrtc.c
index d3a2bc3..588fca5 100644
--- a/drivers/char/genrtc.c
+++ b/drivers/char/genrtc.c
@@ -200,13 +200,13 @@ static ssize_t gen_rtc_read(struct file 
 	/* first test allows optimizer to nuke this case for 32-bit machines */
 	if (sizeof (int) != sizeof (long) && count == sizeof (unsigned int)) {
 		unsigned int uidata = data;
-		retval = put_user(uidata, (unsigned long __user *)buf);
+		retval = put_user(uidata, (unsigned int __user *)buf) ?:
+			sizeof(unsigned int);
 	}
 	else {
-		retval = put_user(data, (unsigned long __user *)buf);
+		retval = put_user(data, (unsigned long __user *)buf) ?:
+			sizeof(unsigned long);
 	}
-	if (!retval)
-		retval = sizeof(unsigned long);
  out:
 	current->state = TASK_RUNNING;
 	remove_wait_queue(&gen_rtc_wait, &wait);
