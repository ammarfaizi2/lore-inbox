Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266004AbUGTQq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUGTQq6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 12:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266005AbUGTQq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 12:46:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26008 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266004AbUGTQql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 12:46:41 -0400
Date: Tue, 20 Jul 2004 18:46:40 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: [0/25] Merge pmdisk and swsusp
Message-ID: <20040720164640.GH10921@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.50.0407171449200.28258-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0407171449200.28258-100000@monsoon.he.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In the end, these patches remove pmdisk from the kernel and clean up the
> swsusp code base. The result is a single code base with greatly improved
> code, that will hopefully help others underestand it better.

Followup patch:

* if machine halt fails, it is very dangerous to continue.

diff -ur linux.middle/kernel/power/disk.c linux/kernel/power/disk.c
--- linux.middle/kernel/power/disk.c	2004-07-19 08:58:08.000000000 -0700
+++ linux/kernel/power/disk.c	2004-07-19 15:00:16.000000000 -0700
@@ -63,6 +63,9 @@
 		break;
 	}
 	machine_halt();
+	/* Valid image is on the disk, if we continue we risk serious data corruption
+	   after resume. */
+	while(1);
 	device_power_up();
 	local_irq_restore(flags);
 	return 0;

* software_suspend() did not check for smp, this fixes it.

diff -ur linux.middle/kernel/power/main.c linux/kernel/power/main.c
--- linux.middle/kernel/power/main.c	2004-07-19 08:58:08.000000000 -0700
+++ linux/kernel/power/main.c	2004-07-20 08:32:43.000000000 -0700
@@ -175,13 +175,7 @@
  */
 int software_suspend(void)
 {
-	int error;
-
-	if (down_trylock(&pm_sem))
-		return -EBUSY;
-	error = pm_suspend_disk();
-	up(&pm_sem);
-	return error;
+	return enter_state(PM_SUSPEND_DISK);
 }
 
 

* copy_page() is dangerous. This is actually my fault.

diff -ur linux.middle/kernel/power/swsusp.c linux/kernel/power/swsusp.c
--- linux.middle/kernel/power/swsusp.c	2004-07-19 09:07:09.000000000 -0700
+++ linux/kernel/power/swsusp.c	2004-07-19 14:30:07.000000000 -0700
@@ -614,12 +614,8 @@
 					struct page * page;
 					page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
 					pbe->orig_address = (long) page_address(page);
-					/* Copy page is dangerous: it likes to mess with
-					   preempt count on specific cpus. Wrong preempt
-					   count is then copied, oops.
-					*/
-					copy_page((void *)pbe->address,
-						  (void *)pbe->orig_address);
+					/* copy_page is no usable for copying task structs. */
+					memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
 					pbe++;
 				}
 			}


-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
