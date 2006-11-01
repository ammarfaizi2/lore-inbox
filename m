Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946575AbWKAFuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946575AbWKAFuF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946546AbWKAFnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:43:46 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:16348 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946542AbWKAFnf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:43:35 -0500
Message-Id: <20061101054331.907620000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:25 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Akinobu Mita <akinobu.mita@gmail.com>,
       Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 45/61] Watchdog: sc1200wdt - fix missing pnp_unregister_driver()
Content-Disposition: inline; filename=watchdog-sc1200wdt-fix-missing-pnp_unregister_driver.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Akinobu Mita <akinobu.mita@gmail.com>

[WATCHDOG] sc1200wdt.c pnp unregister fix.

If no devices found or invalid parameter is specified,
scl200wdt_pnp_driver is left unregistered.
It breaks global list of pnp drivers.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/char/watchdog/sc1200wdt.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- linux-2.6.18.1.orig/drivers/char/watchdog/sc1200wdt.c
+++ linux-2.6.18.1/drivers/char/watchdog/sc1200wdt.c
@@ -392,7 +392,7 @@ static int __init sc1200wdt_init(void)
 	if (io == -1) {
 		printk(KERN_ERR PFX "io parameter must be specified\n");
 		ret = -EINVAL;
-		goto out_clean;
+		goto out_pnp;
 	}
 
 #if defined CONFIG_PNP
@@ -405,7 +405,7 @@ static int __init sc1200wdt_init(void)
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
 

--
