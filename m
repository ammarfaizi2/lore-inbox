Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbUDARI0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 12:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbUDARI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 12:08:26 -0500
Received: from gprs212-217.eurotel.cz ([160.218.212.217]:8832 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262977AbUDARIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 12:08:21 -0500
Date: Thu, 1 Apr 2004 19:08:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: andrea@suse.de, kernel list <linux-kernel@vger.kernel.org>
Subject: Properly stop kernel threads on aic7xxx
Message-ID: <20040401170808.GA696@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is totally untested patch that should make aic7xxx one step
closer to working with software suspend... Plus it kills ugly #if in
the process.
								Pavel 

--- tmp/linux/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-03-11 18:11:12.000000000 +0100
+++ linux/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-04-01 19:01:29.000000000 +0200
@@ -2581,17 +2581,8 @@
 	 * Complete thread creation.
 	 */
 	lock_kernel();
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,60)
-	/*
-	 * Don't care about any signals.
-	 */
-	siginitsetinv(&current->blocked, 0);
-
-	daemonize();
-	sprintf(current->comm, "ahd_dv_%d", ahd->unit);
-#else
 	daemonize("ahd_dv_%d", ahd->unit);
-#endif
+	current->flags |= PF_IOTHREAD;
 	unlock_kernel();
 
 	while (1) {
--- tmp/linux/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-03-11 18:11:12.000000000 +0100
+++ linux/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-04-01 19:01:08.000000000 +0200
@@ -2286,17 +2286,8 @@
 	 * Complete thread creation.
 	 */
 	lock_kernel();
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	/*
-	 * Don't care about any signals.
-	 */
-	siginitsetinv(&current->blocked, 0);
-
-	daemonize();
-	sprintf(current->comm, "ahc_dv_%d", ahc->unit);
-#else
 	daemonize("ahc_dv_%d", ahc->unit);
-#endif
+	current->flags |= PF_IOTHREAD;
 	unlock_kernel();
 
 	while (1) {


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
