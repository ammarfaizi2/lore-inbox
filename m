Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266157AbUHHTZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266157AbUHHTZi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 15:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUHHTZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 15:25:38 -0400
Received: from gprs214-77.eurotel.cz ([160.218.214.77]:640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266157AbUHHTZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 15:25:36 -0400
Date: Sun, 8 Aug 2004 21:23:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: highmem handling again
Message-ID: <20040808192300.GA659@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I agree that swsusp_free is not the right place to restore_highmem(),
but I can't find "right" place to do it... Best I could come up is
with is:

It did not work at the end of swsusp_resume, or at the end of
swsusp_restore, IIRC.

								Pavel

--- clean-mm/kernel/power/disk.c	2004-07-28 23:39:49.000000000 +0200
+++ linux-mm/kernel/power/disk.c	2004-08-08 21:11:38.000000000 +0200
@@ -184,8 +187,11 @@
 			error = power_down(pm_disk_mode);
 			pr_debug("PM: Power down failed.\n");
 		}
-	} else
+	} else {
+		extern int restore_highmem(void);
+		restore_highmem();
 		pr_debug("PM: Image restored successfully.\n");
+	}
 	swsusp_free();
  Done:
 	finish();
--- clean-mm/kernel/power/swsusp.c	2004-07-28 23:39:49.000000000 +0200
+++ linux-mm/kernel/power/swsusp.c	2004-08-08 20:55:59.000000000 +0200
@@ -523,7 +523,7 @@
 	return 0;
 }
 
-static int restore_highmem(void)
+int restore_highmem(void)
 {
 	while (highmem_copy) {
 		struct highmem_page *save = highmem_copy;




-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
