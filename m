Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWIZByZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWIZByZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 21:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWIZByZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 21:54:25 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:42943 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1750740AbWIZByZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 21:54:25 -0400
Date: Tue, 26 Sep 2006 11:54:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Cc: "Alexey Dobriyan" <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [POWERPC] fix spin lock nesting in hvc_iseries
Message-Id: <20060926115416.46b86d82.sfr@canb.auug.org.au>
In-Reply-To: <20060926005838.d0cd5d7e.sfr@canb.auug.org.au>
References: <b6fcc0a0609250547p551f49bcgab46192e7fa55a39@mail.gmail.com>
	<20060926005838.d0cd5d7e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We had nested spinlocks using the same flags variable, but it turns out
that we don't need the nested locks at all (the lock protects a static
buffer that we aren't using here), so just remove the extra locks.

Spotted by Alexey Dobriyan.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/hvc_iseries.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/char/hvc_iseries.c b/drivers/char/hvc_iseries.c
index ea36201..f144a94 100644
--- a/drivers/char/hvc_iseries.c
+++ b/drivers/char/hvc_iseries.c
@@ -154,9 +154,7 @@ static int put_chars(uint32_t vtermno, c
 	spin_lock_irqsave(&consolelock, flags);
 
 	if (viochar_is_console(pi) && !viopath_isactive(pi->lp)) {
-		spin_lock_irqsave(&consoleloglock, flags);
 		HvCall_writeLogBuffer(buf, count);
-		spin_unlock_irqrestore(&consoleloglock, flags);
 		sent = count;
 		goto done;
 	}
@@ -172,11 +170,8 @@ static int put_chars(uint32_t vtermno, c
 
 		len = (count > VIOCHAR_MAX_DATA) ? VIOCHAR_MAX_DATA : count;
 
-		if (viochar_is_console(pi)) {
-			spin_lock_irqsave(&consoleloglock, flags);
+		if (viochar_is_console(pi))
 			HvCall_writeLogBuffer(buf, len);
-			spin_unlock_irqrestore(&consoleloglock, flags);
-		}
 
 		init_data_event(viochar, pi->lp);
 
-- 
1.4.2.1

