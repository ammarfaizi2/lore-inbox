Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbUKWDKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbUKWDKb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 22:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbUKWDID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 22:08:03 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:39338 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262559AbUKWDEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 22:04:44 -0500
Date: Mon, 22 Nov 2004 22:04:39 -0500
From: Decklin Foster <decklin@red-bean.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] gamecon.c and PSX DDR controllers
Message-ID: <20041123030439.GA31019@terminus.dhs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
X-GPG-Key: finger://debian.org/decklin@debian.org
X-LR8R: Money can't buy you respect so go ahead and do your worst.
Organization: Society for the Unification of Hindiusm and Islam
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

PSX DDR controllers don't work with gamecon.c. I sent a quick fix for
the crash-on-load to Vojtech a while ago, but didn't have time to
really fix it until now, and it didn't actually make DDR controllers
*work* (just load without an oops) so I can't blame him for ignoring
it. :-)

It turns out that getting DDR controllers to function with gamecon is
very simple -- we just forgot to check for them when looking in
status_bit. Here's the three-line patch. Could someone get this into
2.6.10? Thanks a lot.

-- 
things change.
decklin@red-bean.com

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gamecon-ddr.diff"

--- gamecon.c~	2004-10-18 17:55:35.000000000 -0400
+++ gamecon.c	2004-11-22 21:53:15.000000000 -0500
@@ -89,7 +89,7 @@
 static int gc_status_bit[] = { 0x40, 0x80, 0x20, 0x10, 0x08 };
 
 static char *gc_names[] = { NULL, "SNES pad", "NES pad", "NES FourPort", "Multisystem joystick",
-				"Multisystem 2-button joystick", "N64 controller", "PSX controller"
+				"Multisystem 2-button joystick", "N64 controller", "PSX controller",
 				"PSX DDR controller" };
 /*
  * N64 support.
@@ -271,7 +271,7 @@
 		udelay(gc_psx_delay);
 		read = parport_read_status(gc->pd->port) ^ 0x80;
 		for (j = 0; j < 5; j++)
-			data[j] |= (read & gc_status_bit[j] & gc->pads[GC_PSX]) ? (1 << i) : 0;
+			data[j] |= (read & gc_status_bit[j] & (gc->pads[GC_PSX]|gc->pads[GC_DDR])) ? (1 << i) : 0;
 		parport_write_data(gc->pd->port, cmd | GC_PSX_CLOCK | GC_PSX_POWER);
 		udelay(gc_psx_delay);
 	}
@@ -300,7 +300,7 @@
 	gc_psx_command(gc, 0, data2);							/* Dump status */
 
 	for (i =0; i < 5; i++)								/* Find the longest pad */
-		if((gc_status_bit[i] & gc->pads[GC_PSX]) && (GC_PSX_LEN(id[i]) > max_len))
+		if((gc_status_bit[i] & (gc->pads[GC_PSX]|gc->pads[GC_DDR])) && (GC_PSX_LEN(id[i]) > max_len))
 			max_len = GC_PSX_LEN(id[i]);
 
 	for (i = 0; i < max_len * 2; i++) {						/* Read in all the data */

--82I3+IH0IqGh5yIs--
