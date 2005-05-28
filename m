Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVE1XJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVE1XJr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 19:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVE1XJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 19:09:47 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:21986 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261191AbVE1XJo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 19:09:44 -0400
X-ORBL: [69.107.40.98]
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.12-rc5] pcmcia/cs.c and SS_CAP_STATIC_MAP
Date: Sat, 28 May 2005 16:09:26 -0700
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_moPmCdBvkmWE4Xm"
Message-Id: <200505281609.26470.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_moPmCdBvkmWE4Xm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I traced a puzzling bug down to the combination of SS_CAP_STATIC_MAP,
finicky hardware, and a bug fixed by the following patch.  The fix
is a one-liner that won't affect any socket driver that's yet merged;
basically, it stops discarding I/O attributes for static mappings.

- Dave


--Boundary-00=_moPmCdBvkmWE4Xm
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pcmcia.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pcmcia.patch"

The PCMCIA card services layer is never setting the i/o map attributes
when SS_CAP_STATIC_MAP is specified.  Net result, sockets' set_io_map()
calls always see requests with most flags clear, meaning 8 bit access.

For hardware that always autosizes, that won't matter; and all current
STATIC_MAP drivers ignore those attributes.  A new driver (for at91rm9200)
suffers badly from this, since this forces everything into 8 bit mode and
that breaks both (a) cards requiring 16 bit access, and (b) ide-cs; but
of course 8-bit cards work OK (as does accessing card attributes).

So this patch arranges to pass the attributes down, matching the behavior
for non-static mappings (using the first/only I/O window).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- at91x.orig/drivers/pcmcia/cs.c	2005-05-28 14:20:39.000000000 -0700
+++ at91x/drivers/pcmcia/cs.c	2005-05-28 15:21:06.000000000 -0700
@@ -767,6 +767,7 @@
     }
     if ((s->features & SS_CAP_STATIC_MAP) && s->io_offset) {
 	*base = s->io_offset | (*base & 0x0fff);
+	s->io[0].Attributes = attr;
 	return 0;
     }
     /* Check for an already-allocated window that must conflict with

--Boundary-00=_moPmCdBvkmWE4Xm--
