Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVJ2Uzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVJ2Uzg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 16:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbVJ2UzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 16:55:01 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:3247 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932182AbVJ2Uyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 16:54:32 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [RFC][PATCH 4/6] swsusp: move swap check out of swsusp_suspend
Date: Sat, 29 Oct 2005 22:36:47 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
References: <200510292158.11089.rjw@sisk.pl>
In-Reply-To: <200510292158.11089.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510292236.47960.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a non-essential step making the next patch possible.  No functionality
changes.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/swsusp.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

Index: linux-2.6.14-rc5-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/swsusp.c	2005-10-29 13:13:47.000000000 +0200
+++ linux-2.6.14-rc5-mm1/kernel/power/swsusp.c	2005-10-29 13:13:55.000000000 +0200
@@ -644,12 +644,15 @@
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
 
 
@@ -672,11 +675,6 @@
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
@@ -689,7 +687,6 @@
 	restore_processor_state();
 Restore_highmem:
 	restore_highmem();
-Power_up:
 	device_power_up();
 Enable_irqs:
 	local_irq_enable();
@@ -916,7 +913,7 @@
 		 * Reset swap signature now.
 		 */
 		error = bio_write_page(0, &swsusp_header);
-	} else { 
+	} else {
 		return -EINVAL;
 	}
 	if (!error)


