Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbULAA4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbULAA4c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbULAAz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:55:56 -0500
Received: from newton.linux4geeks.de ([193.30.1.1]:40835 "EHLO
	newton.linux4geeks.de") by vger.kernel.org with ESMTP
	id S261154AbULAAqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:46:14 -0500
From: Sven Ladegast <sven@linux4geeks.de>
Organization: Linux4Geeks
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] via-rhine: WOL band-aid (patch against 2.6.9)
Date: Wed, 1 Dec 2004 01:46:13 +0100
User-Agent: KMail/1.6.2
References: <20041130224014.GD29947@k3.hellgate.ch>
In-Reply-To: <20041130224014.GD29947@k3.hellgate.ch>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VRRrBTg+AcnJBVe"
Message-Id: <200412010146.13552.sven@linux4geeks.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_VRRrBTg+AcnJBVe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 30 November 2004 23:40, Roger Luethi wrote:

> This version applies against -mm. I suggest to put it there for testing
> and into 2.6.11 if feedback is good.

And here is the "backport" to 2.6.9 for current users waiting for this patc=
h.=20
It is working for me on an ECS Elitegroup KT-600A mainboard with VT8237 and=
 a=20
Rhine-II network controller.

Sven
=2D-=20
Sven Ladegast, Friedrich-Fr=F6bel-Stra=DFe 11, 93310 Arnstadt / Germany
Phone: +49-175-5334308, PGP-key: 0x5856A5ED


--Boundary-00=_VRRrBTg+AcnJBVe
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="via-rhine-corrected-2.6.9.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="via-rhine-corrected-2.6.9.diff"

--- via-rhine.c	2004-10-18 23:55:28.000000000 +0200
+++ via-rhine-patched.c	2004-12-01 01:02:18.000000000 +0100
@@ -664,7 +664,7 @@ static void __devinit rhine_reload_eepro
 
 	/* Turn off EEPROM-controlled wake-up (magic packet) */
 	if (rp->quirks & rqWOL)
-		writeb(readb(ioaddr + ConfigA) & 0xFE, ioaddr + ConfigA);
+		writeb(readb(ioaddr + ConfigA) & 0xFC, ioaddr + ConfigA);
 
 }
 
@@ -1917,8 +1917,14 @@ static void rhine_shutdown (struct devic
 	if (rp->quirks & rq6patterns)
 		writeb(0x04, ioaddr + 0xA7);
 
-	if (rp->wolopts & WAKE_MAGIC)
+	if (rp->wolopts & WAKE_MAGIC) {
 		writeb(WOLmagic, ioaddr + WOLcrSet);
+		/*
+		 * Turn EEPROM-controlled wake-up back on -- some hardware may
+		 * not cooperate otherwise.
+		 */
+		writeb(readb(ioaddr + ConfigA) | 0x03, ioaddr + ConfigA);
+	}
 
 	if (rp->wolopts & (WAKE_BCAST|WAKE_MCAST))
 		writeb(WOLbmcast, ioaddr + WOLcgSet);
@@ -1929,9 +1935,11 @@ static void rhine_shutdown (struct devic
 	if (rp->wolopts & WAKE_UCAST)
 		writeb(WOLucast, ioaddr + WOLcrSet);
 
-	/* Enable legacy WOL (for old motherboards) */
-	writeb(0x01, ioaddr + PwcfgSet);
-	writeb(readb(ioaddr + StickyHW) | 0x04, ioaddr + StickyHW);
+	if (rp->wolopts) {
+		/* Enable legacy WOL (for old motherboards) */
+		writeb(0x01, ioaddr + PwcfgSet);
+		writeb(readb(ioaddr + StickyHW) | 0x04, ioaddr + StickyHW);
+	}
 
 	/* Hit power state D3 (sleep) */
 	writeb(readb(ioaddr + StickyHW) | 0x03, ioaddr + StickyHW);

--Boundary-00=_VRRrBTg+AcnJBVe--
