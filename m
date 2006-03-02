Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWCBPDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWCBPDM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 10:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWCBPDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 10:03:12 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:51164 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751379AbWCBPDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 10:03:12 -0500
Date: Fri, 03 Mar 2006 00:03:06 +0900 (JST)
Message-Id: <20060303.000306.08077845.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] fix potential jiffies overflow
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found i386 timer_resume is updating jiffies, not jiffies_64.  It
looks there is a potential overflow problem.  Is this a correct fix?

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
index a14d594..e4ed172 100644
--- a/arch/i386/kernel/time.c
+++ b/arch/i386/kernel/time.c
@@ -413,7 +413,7 @@ static int timer_resume(struct sys_devic
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
 	write_sequnlock_irqrestore(&xtime_lock, flags);
-	jiffies += sleep_length;
+	jiffies_64 += sleep_length;
 	wall_jiffies += sleep_length;
 	if (last_timer->resume)
 		last_timer->resume();
