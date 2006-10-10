Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbWJJHkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbWJJHkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 03:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbWJJHkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 03:40:46 -0400
Received: from havoc.gtf.org ([69.61.125.42]:58254 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965079AbWJJHkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 03:40:45 -0400
Date: Tue, 10 Oct 2006 03:40:44 -0400
From: Jeff Garzik <jeff@garzik.org>
To: wim@iguana.be, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] watchdog/iTCO_wdt: fix bug related to gcc uninit warning
Message-ID: <20061010074044.GA23501@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc emits the following warning:

drivers/char/watchdog/iTCO_wdt.c: In function ‘iTCO_wdt_ioctl’:
drivers/char/watchdog/iTCO_wdt.c:429: warning: ‘time_left’ may be used uninitialized in this function

This indicates a condition near enough to a bug, to want to fix.
iTCO_wdt_get_timeleft() stores a value in 'time_left' iff
iTCO_version==(1 or 2).  This driver only supports versions
1 or 2, so this is ok.  However, since (a) the return value of
iTCO_wdt_get_timeleft() is handled anyway, (b) it fixes the warning,
and (c) it future-proofs the driver, we go ahead and add the obvious
return value.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/char/watchdog/iTCO_wdt.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/watchdog/iTCO_wdt.c b/drivers/char/watchdog/iTCO_wdt.c
index aaac94d..bf5cd55 100644
--- a/drivers/char/watchdog/iTCO_wdt.c
+++ b/drivers/char/watchdog/iTCO_wdt.c
@@ -355,7 +355,8 @@ static int iTCO_wdt_get_timeleft (int *t
 		spin_unlock(&iTCO_wdt_private.io_lock);
 
 		*time_left = (val8 * 6) / 10;
-	}
+	} else
+		return -EINVAL;
 	return 0;
 }
 
@@ -426,7 +427,6 @@ static int iTCO_wdt_ioctl (struct inode 
 {
 	int new_options, retval = -EINVAL;
 	int new_heartbeat;
-	int time_left;
 	void __user *argp = (void __user *)arg;
 	int __user *p = argp;
 	static struct watchdog_info ident = {
@@ -486,6 +486,8 @@ static int iTCO_wdt_ioctl (struct inode 
 
 		case WDIOC_GETTIMELEFT:
 		{
+			int time_left;
+
 			if (iTCO_wdt_get_timeleft(&time_left))
 				return -EINVAL;
 
