Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbTJTHTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 03:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbTJTHTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 03:19:55 -0400
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:28855 "EHLO
	water-ox.its.caltech.edu") by vger.kernel.org with ESMTP
	id S262286AbTJTHTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 03:19:52 -0400
Date: Mon, 20 Oct 2003 00:19:47 -0700 (PDT)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@clyde
To: kkeil@suse.de, kai.germaschewski@gmx.de
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [PATCH] Make ISDN CAPI compile with MODULES=n - interesting behavior
Message-ID: <Pine.GSO.4.58.0310171454430.13905@blinky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings All,

This patch fixes two problems in drivers/isdn/capi/kcapi.c.  The first portion
fixes an obscure compilation problem: when CONFIG_MODULES=n, struct module is an
incomplete type, and this makes the card->owner->name expressions raise
compilation errors.  At first I thought of fixing this at the module.h level,
but kcapi.c appears to be the only file in the kernel that uses a struct module
in a fashion that makes this a problem, so I made those usages compile
conditionally instead.  Is that appropriate?

The second change introduces a simple test for a NULL pointer where one looks
appropriate but was absent.

This applies to linux-2.5 BK as of 0700 UTC 10/20/2003 and passes (allyesconfig
- broken stuff) on i386, sparc, sparc64, ia64, and alpha.  I don't have hardware
I could test this on, but I think it's straightforward.

Thanks,
Noah

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1371  -> 1.1372
#	drivers/isdn/capi/kcapi.c	1.46    -> 1.48
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/16	noah@caltech.edu	1.1372
# Make drivers/isdn/capi/kcapi.c compile without CONFIG_MODULES by defining
# appropriate static inline stubs.  Add a simple NULL pointer test where
# one is clearly missing.
# --------------------------------------------
#
diff -Nru a/drivers/isdn/capi/kcapi.c b/drivers/isdn/capi/kcapi.c
--- a/drivers/isdn/capi/kcapi.c	Fri Oct 17 13:41:45 2003
+++ b/drivers/isdn/capi/kcapi.c	Fri Oct 17 13:41:45 2003
@@ -73,6 +73,7 @@
 static struct work_struct tq_recv_notify;

 /* -------- controller ref counting -------------------------------------- */
+#ifdef CONFIG_MODULES

 static inline struct capi_ctr *
 capi_ctr_get(struct capi_ctr *card)
@@ -90,6 +91,14 @@
 	DBG("Release module: %s", card->owner->name);
 }

+#else /* CONFIG_MODULES */
+
+static inline struct capi_ctr * capi_ctr_get(struct capi_ctr *card)
+{ return card; }
+static inline void capi_ctr_put(struct capi_ctr *card)
+{              }
+
+#endif /* CONFIG_MODULES */
 /* ------------------------------------------------------------- */

 static inline struct capi_ctr *get_capi_ctr_by_nr(u16 contr)
@@ -150,8 +159,8 @@
 static void register_appl(struct capi_ctr *card, u16 applid, capi_register_params *rparam)
 {
 	card = capi_ctr_get(card);
-
-	card->register_appl(card, applid, rparam);
+	if( likely(card != NULL) )
+		card->register_appl(card, applid, rparam);
 }



