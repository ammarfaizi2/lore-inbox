Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbVAKBDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbVAKBDZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVAKA6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:58:35 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:65464 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262762AbVAKAmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:42:44 -0500
Date: Mon, 10 Jan 2005 16:42:42 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [UPDATE PATCH] net/slip: replace schedule_timeout() with msleep()
Message-ID: <20050111004242.GK9186@us.ibm.com>
References: <20050110164703.GD14307@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110164703.GD14307@nd47.coderock.org>
X-Operating-System: Linux 2.6.10 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 05:47:03PM +0100, Domen Puncer wrote:
> Patchset of 171 patches is at http://coderock.org/kj/2.6.10-bk13-kj/
> 
> Quick patch summary: about 30 new, 30 merged, 30 dropped.
> Seems like most external trees are merged in -linus, so i'll start
> (re)sending old patches.

<snip>

> msleep_interruptible-drivers_net_slip.patch

Please consider replacing with the following:

Description: Use msleep() instead of schedule_timeout() to guarantee
the task delays as expected. While the original code does use
TASK_INTERRUPTIBLE, it does not check for signals, so I believe msleep() is more
appropriate.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-v/drivers/net/slip.c	2004-12-24 13:35:49.000000000 -0800
+++ 2.6.10/drivers/net/slip.c	2005-01-05 14:23:05.000000000 -0800
@@ -75,6 +75,7 @@
 #include <linux/if_arp.h>
 #include <linux/if_slip.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include "slip.h"
 #ifdef CONFIG_INET
 #include <linux/ip.h>
@@ -1395,10 +1396,8 @@ static void __exit slip_exit(void)
 	/* First of all: check for active disciplines and hangup them.
 	 */
 	do {
-		if (busy) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(HZ / 10);
-		}
+		if (busy)
+			msleep(100);
 
 		busy = 0;
 		for (i = 0; i < slip_maxdev; i++) {
