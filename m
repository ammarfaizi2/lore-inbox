Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316355AbSFZDW0>; Tue, 25 Jun 2002 23:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316364AbSFZDWZ>; Tue, 25 Jun 2002 23:22:25 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:8952 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S316355AbSFZDWZ>; Tue, 25 Jun 2002 23:22:25 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15641.13160.604786.644958@wombat.chubb.wattle.id.au>
Date: Wed, 26 Jun 2002 13:22:16 +1000
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/partitions broken in 2.5.23
In-Reply-To: <641481775@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a fix that works for me (the /proc/partitions output is still broken in
2.5.24 -- it appears to be following sgp->part[n] pointers that aren't
initialised)

--- /tmp/geta29820	Wed Jun 26 13:16:14 2002
+++ linux-2.5.24/drivers/block/genhd.c	Wed Jun 26 11:50:36 2002
@@ -179,8 +179,7 @@
 
 	/* show the full disk and all non-0 size partitions of it */
 	for (n = 0; n < (sgp->nr_real << sgp->minor_shift); n++) {
-		int minormask = (1<<sgp->minor_shift) - 1;
-		if ((n & minormask) && sgp->part[n].nr_sects == 0)
+		if (sgp->sizes[n] == 0)
 			continue;
 		seq_printf(part, "%4d  %4d %10llu %s\n",
 			sgp->major, n, (unsigned long long)sgp->sizes[n],
--- /tmp/geta29832	Wed Jun 26 13:17:36 2002
+++ linux-2.5.24/drivers/ide/probe.c	Wed Jun 26 11:10:00 2002
@@ -1146,6 +1146,7 @@
 	gd->sizes = kmalloc(ATA_MINORS * sizeof(gd->sizes[0]), GFP_KERNEL);
 	if (!gd->sizes)
 		goto err_kmalloc_gd_sizes;
+	memset(gd->sizes, 0, ATA_MINORS*sizeof(gd->sizes[0]));
 
 	gd->part = kmalloc(ATA_MINORS * sizeof(struct hd_struct), GFP_KERNEL);
 	if (!gd->part)
