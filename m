Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbTLPEFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 23:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264454AbTLPEFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 23:05:39 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:50088 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S264452AbTLPEFg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 23:05:36 -0500
Date: Mon, 15 Dec 2003 23:02:04 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@Stimpy.netroedge.com>
Subject: Re: [PATCH 2.6] sensors chip updates (1 of 4)
Message-ID: <20031216040204.GB1658@earth.solarsys.private>
References: <20031216035219.GA1658@earth.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031216035219.GA1658@earth.solarsys.private>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch improves chip detection.  It was forward ported from the 
lm_sensors project CVS, from these revisions:

	1.104 (Khali) Enhance chip detection (stricter).
	1.108 (Khali) Fix W83627HF detection.

--- linux-2.6.0-test11-gkh/drivers/i2c/chips/w83781d.c	2003-12-14 13:53:50.000000000 -0500
+++ linux-2.6.0-test11-mmh/drivers/i2c/chips/w83781d.c	2003-12-14 15:50:46.000000000 -0500
@@ -24,10 +24,11 @@
     Supports following chips:
 
     Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    as99127f	7	3	1?	3	0x30	0x12c3	yes	no
-    asb100 "bach" (type_name = as99127f)	0x30	0x0694	yes	no
-    w83781d	7	3	0	3	0x10	0x5ca3	yes	yes
-    w83627hf	9	3	2	3	0x20	0x5ca3	yes	yes(LPC)
+    as99127f	7	3	1?	3	0x31	0x12c3	yes	no
+    as99127f rev.2 (type_name = 1299127f)	0x31	0x5ca3	yes	no
+    asb100 "bach" (type_name = as99127f)	0x31	0x0694	yes	no
+    w83781d	7	3	0	3	0x10-1	0x5ca3	yes	yes
+    w83627hf	9	3	2	3	0x21	0x5ca3	yes	yes(LPC)
     w83627thf	9	3	2	3	0x90	0x5ca3	no	yes(LPC)
     w83782d	9	3	2-4	3	0x30	0x5ca3	yes	yes
     w83783s	5-6	3	2	1-2	0x40	0x5ca3	yes	no
@@ -1264,7 +1265,7 @@
 			goto ERROR2;
 		}
 		/* If Winbond SMBus, check address at 0x48.
-		   Asus doesn't support */
+		   Asus doesn't support, except for as99127f rev.2 */
 		if ((!is_isa) && (((!(val1 & 0x80)) && (val2 == 0xa3)) ||
 				  ((val1 & 0x80) && (val2 == 0x5c)))) {
 			if (w83781d_read_value
@@ -1295,18 +1296,17 @@
 			goto ERROR2;
 		}
 
-		/* mask off lower bit, not reliable */
-		val1 =
-		    w83781d_read_value(new_client, W83781D_REG_WCHIPID) & 0xfe;
-		if (val1 == 0x10 && vendid == winbond)
+		val1 = w83781d_read_value(new_client, W83781D_REG_WCHIPID);
+		if ((val1 == 0x10 || val1 == 0x11) && vendid == winbond)
 			kind = w83781d;
 		else if (val1 == 0x30 && vendid == winbond)
 			kind = w83782d;
-		else if (val1 == 0x40 && vendid == winbond && !is_isa)
+		else if (val1 == 0x40 && vendid == winbond && !is_isa
+				&& address == 0x2d)
 			kind = w83783s;
-		else if ((val1 == 0x20 || val1 == 0x90) && vendid == winbond)
+		else if ((val1 == 0x21 || val1 == 0x90) && vendid == winbond)
 			kind = w83627hf;
-		else if (val1 == 0x30 && vendid == asus && !is_isa)
+		else if (val1 == 0x31 && !is_isa && address >= 0x28)
 			kind = as99127f;
 		else if (val1 == 0x60 && vendid == winbond && is_isa)
 			kind = w83697hf;
-- 
Mark M. Hoffman
mhoffman@lightlink.com

