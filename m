Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVIESeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVIESeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 14:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVIESdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 14:33:13 -0400
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:356 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932394AbVIESdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 14:33:01 -0400
Message-Id: <20050905183245.608410000@kohtala.home.org>
References: <20050905183109.284672000@kohtala.home.org>
Date: Mon, 05 Sep 2005 21:31:12 +0300
From: marko.kohtala@gmail.com
To: akpm@osdl.org
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [patch 03/10] parport: ieee1284 fixes and cleanups
Content-Disposition: inline; filename=parport-fix-ieee1284.3-daisy-chain-end-detection.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daisy chain end detection failed at least with older daisy chain
devices that do not implement the last device signal.

Signed-off-by: Marko Kohtala <marko.kohtala@gmail.com>

---

 drivers/parport/daisy.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

Index: linux-dvb/drivers/parport/daisy.c
===================================================================
--- linux-dvb.orig/drivers/parport/daisy.c	2005-08-29 20:11:52.000000000 +0300
+++ linux-dvb/drivers/parport/daisy.c	2005-08-29 20:12:35.000000000 +0300
@@ -436,7 +436,7 @@ static int select_port (struct parport *
 
 static int assign_addrs (struct parport *port)
 {
-	unsigned char s, last_dev;
+	unsigned char s;
 	unsigned char daisy;
 	int thisdev = numdevs;
 	int detected;
@@ -472,10 +472,13 @@ static int assign_addrs (struct parport 
 	}
 
 	parport_write_data (port, 0x78); udelay (2);
-	last_dev = 0; /* We've just been speaking to a device, so we
-			 know there must be at least _one_ out there. */
+	s = parport_read_status (port);
 
-	for (daisy = 0; daisy < 4; daisy++) {
+	for (daisy = 0;
+	     (s & (PARPORT_STATUS_PAPEROUT|PARPORT_STATUS_SELECT))
+		     == (PARPORT_STATUS_PAPEROUT|PARPORT_STATUS_SELECT)
+		     && daisy < 4;
+	     ++daisy) {
 		parport_write_data (port, daisy);
 		udelay (2);
 		parport_frob_control (port,
@@ -485,14 +488,18 @@ static int assign_addrs (struct parport 
 		parport_frob_control (port, PARPORT_CONTROL_STROBE, 0);
 		udelay (1);
 
-		if (last_dev)
-			/* No more devices. */
-			break;
+		add_dev (numdevs++, port, daisy);
 
-		last_dev = !(parport_read_status (port)
-			     & PARPORT_STATUS_BUSY);
+		/* See if this device thought it was the last in the
+		 * chain. */
+		if (!(s & PARPORT_STATUS_BUSY))
+			break;
 
-		add_dev (numdevs++, port, daisy);
+		/* We are seeing pass through status now. We see
+		   last_dev from next device or if last_dev does not
+		   work status lines from some non-daisy chain
+		   device. */
+		s = parport_read_status (port);
 	}
 
 	parport_write_data (port, 0xff); udelay (2);

--
