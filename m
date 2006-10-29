Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWJ2VtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWJ2VtK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 16:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbWJ2VtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 16:49:10 -0500
Received: from outmx015.isp.belgacom.be ([195.238.4.87]:44497 "EHLO
	outmx015.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1030352AbWJ2VtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 16:49:08 -0500
Date: Sun, 29 Oct 2006 22:48:49 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       stable@kernel.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Akinobu Mita <akinobu.mita@gmail.com>
Subject: [WATCHDOG] sc1200wdt - fix missing pnp_unregister_driver()
Message-ID: <20061029214849.GB4532@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Greg, Stable-team,

There is a bug in the sc1200wdt code where the pnp driver
is not being unregistered in certain error situations.
I think it's worth having the fix in 2.6.19 and the
next stable version of 2.6.18.

So please pull from 'master' branch of
	git://git.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

This will update the following files:

 drivers/char/watchdog/sc1200wdt.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

with these Changes:

Author: Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sun Oct 29 03:43:19 2006 +0900

    [WATCHDOG] sc1200wdt.c pnp unregister fix.
    
    If no devices found or invalid parameter is specified,
    scl200wdt_pnp_driver is left unregistered.
    It breaks global list of pnp drivers.
    
    Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/drivers/char/watchdog/sc1200wdt.c b/drivers/char/watchdog/sc1200wdt.c
index d8d0f28..e323983 100644
--- a/drivers/char/watchdog/sc1200wdt.c
+++ b/drivers/char/watchdog/sc1200wdt.c
@@ -392,7 +392,7 @@ #endif
 	if (io == -1) {
 		printk(KERN_ERR PFX "io parameter must be specified\n");
 		ret = -EINVAL;
-		goto out_clean;
+		goto out_pnp;
 	}
 
 #if defined CONFIG_PNP
@@ -405,7 +405,7 @@ #endif
 	if (!request_region(io, io_len, SC1200_MODULE_NAME)) {
 		printk(KERN_ERR PFX "Unable to register IO port %#x\n", io);
 		ret = -EBUSY;
-		goto out_clean;
+		goto out_pnp;
 	}
 
 	ret = sc1200wdt_probe();
@@ -435,6 +435,11 @@ out_rbt:
 out_io:
 	release_region(io, io_len);
 
+out_pnp:
+#if defined CONFIG_PNP
+	if (isapnp)
+		pnp_unregister_driver(&scl200wdt_pnp_driver);
+#endif
 	goto out_clean;
 }
 
