Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbTDIV0P (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 17:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263831AbTDIV0O (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 17:26:14 -0400
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:53000 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id S263827AbTDIV0F (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 17:26:05 -0400
Message-ID: <3E9492A8.1010407@acm.org>
Date: Wed, 09 Apr 2003 16:37:44 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Minor IPMI fixes
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8E1C6E42F80402E567134ACC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E1C6E42F80402E567134ACC
Content-Type: multipart/mixed;
 boundary="------------060102080209040406020200"

This is a multi-part message in MIME format.
--------------060102080209040406020200
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The attached patch fixes a few minor problems with the IPMI driver, a
misplaced lock, a wrong semphore type, and a few errors in certain
configurations.  This is relative to 2.5.67.

Linus, please apply.

Thanks,

-Corey


--------------060102080209040406020200
Content-Type: text/plain;
 name="ipmi-2.5.67-minorfixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-2.5.67-minorfixes.diff"

diff -ur linux.orig/drivers/char/ipmi/ipmi_devintf.c linux-main/drivers/char/ipmi/ipmi_devintf.c
--- linux.orig/drivers/char/ipmi/ipmi_devintf.c	Mon Apr  7 15:55:43 2003
+++ linux-main/drivers/char/ipmi/ipmi_devintf.c	Thu Apr  3 12:32:28 2003
@@ -81,9 +81,9 @@
 	unsigned int             mask = 0;
 	unsigned long            flags;
 
-	spin_lock_irqsave(&priv->recv_msg_lock, flags);
-
 	poll_wait(file, &priv->wait, wait);
+
+	spin_lock_irqsave(&priv->recv_msg_lock, flags);
 
 	if (! list_empty(&(priv->recv_msgs)))
 		mask |= (POLLIN | POLLRDNORM);
diff -ur linux.orig/drivers/char/ipmi/ipmi_watchdog.c linux-main/drivers/char/ipmi/ipmi_watchdog.c
--- linux.orig/drivers/char/ipmi/ipmi_watchdog.c	Tue Jan 14 11:16:10 2003
+++ linux-main/drivers/char/ipmi/ipmi_watchdog.c	Wed Apr  9 14:55:03 2003
@@ -751,7 +751,7 @@
 {
 	int rv = -EBUSY;
 
-	down_read(&register_sem);
+	down_write(&register_sem);
 	if (watchdog_user)
 		goto out;
 
@@ -917,7 +917,7 @@
 	} else if (strcmp(preaction, "pre_int") == 0) {
 		preaction_val = WDOG_PRETIMEOUT_MSG_INT;
 	} else {
-		action_val = WDOG_PRETIMEOUT_NONE;
+		preaction_val = WDOG_PRETIMEOUT_NONE;
 		printk("ipmi_watchdog: Unknown preaction '%s', defaulting to"
 		       " none\n", preaction);
 	}
@@ -929,7 +929,7 @@
 	} else if (strcmp(preop, "preop_give_data") == 0) {
 		preop_val = WDOG_PREOP_GIVE_DATA;
 	} else {
-		action_val = WDOG_PREOP_NONE;
+		preop_val = WDOG_PREOP_NONE;
 		printk("ipmi_watchdog: Unknown preop '%s', defaulting to"
 		       " none\n", preop);
 	}

--------------060102080209040406020200--

--------------enig8E1C6E42F80402E567134ACC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+lJKoIXnXXONXERcRAkMTAJ951dHciNEGwowqAQETQKDFM260pACgs6o/
qL40s1rLpS+jWfRlEuyx1b8=
=qd9B
-----END PGP SIGNATURE-----

--------------enig8E1C6E42F80402E567134ACC--

