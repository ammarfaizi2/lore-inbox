Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbVKRVZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbVKRVZz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbVKRVZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:25:54 -0500
Received: from hera.kernel.org ([140.211.167.34]:7366 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750970AbVKRVZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:25:54 -0500
Date: Fri, 18 Nov 2005 14:05:50 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mpcore_wdt.c bogus fpos check
Message-ID: <20051118160550.GB13943@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

drivers/char/watchdog/mpcore_wdt.c write function contains a check for
(ppos != &file->f_pos). Such check used to make sense when a pointer to
file->f_pos was handed by vfs_write(), not a copy of it as it stands
now.

Has been broken since then... Don't have a device to test - does it work
at all?

mpc8xx_wdt.c is similarly broken (patch will be sent separately).

Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

diff --git a/drivers/char/watchdog/mpcore_wdt.c b/drivers/char/watchdog/mpcore_wdt.c
index da631c1..c9f545e 100644
--- a/drivers/char/watchdog/mpcore_wdt.c
+++ b/drivers/char/watchdog/mpcore_wdt.c
@@ -180,10 +180,6 @@ static ssize_t mpcore_wdt_write(struct f
 {
 	struct mpcore_wdt *wdt = file->private_data;
 
-	/*  Can't seek (pwrite) on this device  */
-	if (ppos != &file->f_pos)
-		return -ESPIPE;
-
 	/*
 	 *	Refresh the timer.
 	 */
