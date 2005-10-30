Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVJ3Pwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVJ3Pwo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVJ3Pwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:52:43 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:31665 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932095AbVJ3PwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:52:21 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/3] swsusp: move swap check out of swsusp_suspend
Date: Sun, 30 Oct 2005 16:48:29 +0100
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <200510301637.48842.rjw@sisk.pl>
In-Reply-To: <200510301637.48842.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510301648.30191.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the check for available swap out of swsusp_suspend(),
which is necessary for separating the swap-handling functions in swsusp
from the core code.  No functionality changes.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/swsusp.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

Index: linux-2.6.14-rc5-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/swsusp.c	2005-10-30 12:36:58.000000000 +0100
+++ linux-2.6.14-rc5-mm1/kernel/power/swsusp.c	2005-10-30 12:37:12.000000000 +0100
@@ -567,12 +567,15 @@
 {
 	int error;
 
+	if ((error = swsusp_swap_check())) {
+		printk(KERN_ERR "swsusp: cannot find swap device, try swapon -a.\n");
+		return error;
+	}
 	lock_swapdevices();
 	error = write_suspend_image();
 	/* This will unlock ignored swap devices since writing is finished */
 	lock_swapdevices();
 	return error;
-
 }
 
 
@@ -595,11 +598,6 @@
 		goto Enable_irqs;
 	}
 
-	if ((error = swsusp_swap_check())) {
-		printk(KERN_ERR "swsusp: cannot find swap device, try swapon -a.\n");
-		goto Power_up;
-	}
-
 	if ((error = save_highmem())) {
 		printk(KERN_ERR "swsusp: Not enough free pages for highmem\n");
 		goto Restore_highmem;
@@ -612,7 +610,6 @@
 	restore_processor_state();
 Restore_highmem:
 	restore_highmem();
-Power_up:
 	device_power_up();
 Enable_irqs:
 	local_irq_enable();
@@ -781,7 +778,7 @@
 		 * Reset swap signature now.
 		 */
 		error = bio_write_page(0, &swsusp_header);
-	} else { 
+	} else {
 		return -EINVAL;
 	}
 	if (!error)
