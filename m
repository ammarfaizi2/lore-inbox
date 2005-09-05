Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVIESdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVIESdI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 14:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVIESc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 14:32:57 -0400
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:47459 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932385AbVIEScw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 14:32:52 -0400
Message-Id: <20050905183245.134152000@kohtala.home.org>
References: <20050905183109.284672000@kohtala.home.org>
Date: Mon, 05 Sep 2005 21:31:11 +0300
From: marko.kohtala@gmail.com
To: akpm@osdl.org
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [patch 02/10] parport: ieee1284 fixes and cleanups
Content-Disposition: inline; filename=parport-fix-read-nibble.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did not move the parport interface properly into IEEE1284_PH_REV_IDLE
phase at end of data due to comparing bytes with nibbles. Internal
phase IEEE1284_PH_HBUSY_DNA became unused, so remove it.

Signed-off-by: Marko Kohtala <marko.kohtala@gmail.com>

---

 drivers/media/video/cpia_pp.c  |   30 ++++++++-----------
 drivers/parport/ieee1284_ops.c |   62 +++++++++++++++++++----------------------
 include/linux/parport.h        |    1 
 3 files changed, 42 insertions(+), 51 deletions(-)

Index: linux-dvb/drivers/media/video/cpia_pp.c
===================================================================
--- linux-dvb.orig/drivers/media/video/cpia_pp.c	2005-05-30 19:44:27.000000000 +0300
+++ linux-dvb/drivers/media/video/cpia_pp.c	2005-05-30 19:48:30.000000000 +0300
@@ -170,16 +170,9 @@ static size_t cpia_read_nibble (struct p
 		/* Does the error line indicate end of data? */
 		if (((i /*& 1*/) == 0) &&
 		    (parport_read_status(port) & PARPORT_STATUS_ERROR)) {
-			port->physport->ieee1284.phase = IEEE1284_PH_HBUSY_DNA;
-				DBG("%s: No more nibble data (%d bytes)\n",
-				port->name, i/2);
-
-			/* Go to reverse idle phase. */
-			parport_frob_control (port,
-					      PARPORT_CONTROL_AUTOFD,
-					      PARPORT_CONTROL_AUTOFD);
-			port->physport->ieee1284.phase = IEEE1284_PH_REV_IDLE;
-			break;
+			DBG("%s: No more nibble data (%d bytes)\n",
+			    port->name, i/2);
+			goto end_of_data;
 		}
 
 		/* Event 7: Set nAutoFd low. */
@@ -227,18 +220,21 @@ static size_t cpia_read_nibble (struct p
 			byte = nibble;
 	}
 
-	i /= 2; /* i is now in bytes */
-
 	if (i == len) {
 		/* Read the last nibble without checking data avail. */
-		port = port->physport;
-		if (parport_read_status (port) & PARPORT_STATUS_ERROR)
-			port->ieee1284.phase = IEEE1284_PH_HBUSY_DNA;
+		if (parport_read_status (port) & PARPORT_STATUS_ERROR) {
+		end_of_data:
+			/* Go to reverse idle phase. */
+			parport_frob_control (port,
+					      PARPORT_CONTROL_AUTOFD,
+					      PARPORT_CONTROL_AUTOFD);
+			port->physport->ieee1284.phase = IEEE1284_PH_REV_IDLE;
+		}
 		else
-			port->ieee1284.phase = IEEE1284_PH_HBUSY_DAVAIL;
+			port->physport->ieee1284.phase = IEEE1284_PH_HBUSY_DAVAIL;
 	}
 
-	return i;
+	return i/2;
 }
 
 /* CPiA nonstandard "Nibble Stream" mode (2 nibbles per cycle, instead of 1)
Index: linux-dvb/drivers/parport/ieee1284_ops.c
===================================================================
--- linux-dvb.orig/drivers/parport/ieee1284_ops.c	2005-05-30 19:45:54.000000000 +0300
+++ linux-dvb/drivers/parport/ieee1284_ops.c	2005-05-30 19:48:30.000000000 +0300
@@ -166,17 +166,7 @@ size_t parport_ieee1284_read_nibble (str
 		/* Does the error line indicate end of data? */
 		if (((i & 1) == 0) &&
 		    (parport_read_status(port) & PARPORT_STATUS_ERROR)) {
-			port->physport->ieee1284.phase = IEEE1284_PH_HBUSY_DNA;
-			DPRINTK (KERN_DEBUG
-				"%s: No more nibble data (%d bytes)\n",
-				port->name, i/2);
-
-			/* Go to reverse idle phase. */
-			parport_frob_control (port,
-					      PARPORT_CONTROL_AUTOFD,
-					      PARPORT_CONTROL_AUTOFD);
-			port->physport->ieee1284.phase = IEEE1284_PH_REV_IDLE;
-			break;
+			goto end_of_data;
 		}
 
 		/* Event 7: Set nAutoFd low. */
@@ -226,18 +216,25 @@ size_t parport_ieee1284_read_nibble (str
 			byte = nibble;
 	}
 
-	i /= 2; /* i is now in bytes */
-
 	if (i == len) {
 		/* Read the last nibble without checking data avail. */
-		port = port->physport;
-		if (parport_read_status (port) & PARPORT_STATUS_ERROR)
-			port->ieee1284.phase = IEEE1284_PH_HBUSY_DNA;
+		if (parport_read_status (port) & PARPORT_STATUS_ERROR) {
+		end_of_data:
+			DPRINTK (KERN_DEBUG
+				"%s: No more nibble data (%d bytes)\n",
+				port->name, i/2);
+
+			/* Go to reverse idle phase. */
+			parport_frob_control (port,
+					      PARPORT_CONTROL_AUTOFD,
+					      PARPORT_CONTROL_AUTOFD);
+			port->physport->ieee1284.phase = IEEE1284_PH_REV_IDLE;
+		}
 		else
-			port->ieee1284.phase = IEEE1284_PH_HBUSY_DAVAIL;
+			port->physport->ieee1284.phase = IEEE1284_PH_HBUSY_DAVAIL;
 	}
 
-	return i;
+	return i/2;
 #endif /* IEEE1284 support */
 }
 
@@ -257,17 +254,7 @@ size_t parport_ieee1284_read_byte (struc
 
 		/* Data available? */
 		if (parport_read_status (port) & PARPORT_STATUS_ERROR) {
-			port->physport->ieee1284.phase = IEEE1284_PH_HBUSY_DNA;
-			DPRINTK (KERN_DEBUG
-				 "%s: No more byte data (%Zd bytes)\n",
-				 port->name, count);
-
-			/* Go to reverse idle phase. */
-			parport_frob_control (port,
-					      PARPORT_CONTROL_AUTOFD,
-					      PARPORT_CONTROL_AUTOFD);
-			port->physport->ieee1284.phase = IEEE1284_PH_REV_IDLE;
-			break;
+			goto end_of_data;
 		}
 
 		/* Event 14: Place data bus in high impedance state. */
@@ -319,11 +306,20 @@ size_t parport_ieee1284_read_byte (struc
 
 	if (count == len) {
 		/* Read the last byte without checking data avail. */
-		port = port->physport;
-		if (parport_read_status (port) & PARPORT_STATUS_ERROR)
-			port->ieee1284.phase = IEEE1284_PH_HBUSY_DNA;
+		if (parport_read_status (port) & PARPORT_STATUS_ERROR) {
+		end_of_data:
+			DPRINTK (KERN_DEBUG
+				 "%s: No more byte data (%Zd bytes)\n",
+				 port->name, count);
+
+			/* Go to reverse idle phase. */
+			parport_frob_control (port,
+					      PARPORT_CONTROL_AUTOFD,
+					      PARPORT_CONTROL_AUTOFD);
+			port->physport->ieee1284.phase = IEEE1284_PH_REV_IDLE;
+		}
 		else
-			port->ieee1284.phase = IEEE1284_PH_HBUSY_DAVAIL;
+			port->physport->ieee1284.phase = IEEE1284_PH_HBUSY_DAVAIL;
 	}
 
 	return count;
Index: linux-dvb/include/linux/parport.h
===================================================================
--- linux-dvb.orig/include/linux/parport.h	2005-05-30 19:44:27.000000000 +0300
+++ linux-dvb/include/linux/parport.h	2005-05-30 19:48:30.000000000 +0300
@@ -242,7 +242,6 @@ enum ieee1284_phase {
 	IEEE1284_PH_FWD_IDLE,
 	IEEE1284_PH_TERMINATE,
 	IEEE1284_PH_NEGOTIATION,
-	IEEE1284_PH_HBUSY_DNA,
 	IEEE1284_PH_REV_IDLE,
 	IEEE1284_PH_HBUSY_DAVAIL,
 	IEEE1284_PH_REV_DATA,

--
