Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVBBBT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVBBBT1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 20:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVBBBT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 20:19:27 -0500
Received: from vivaldi.madbase.net ([81.173.6.10]:34519 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S261981AbVBBBTT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 20:19:19 -0500
Date: Tue, 1 Feb 2005 20:19:17 -0500 (EST)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: kraxel@bytesex.org
cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix SAA7134 transport stream errors
Message-ID: <Pine.LNX.4.58.0502011901020.21364@vivaldi.madbase.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I had a lot of problems with the transport stream input on the
SAA7134. Even the slighest bit of other system activity caused data
corruption. This patch corrects the switching of the two DMA
buffers.

Without the patch, the driver updates the buffer that is just about to
be used by the chip. It still works, but only if no new TS packet
comes in before the registers are updated (in my case there's
typically ~500us between TS packets).

FYI, the problems only occur on Transmeta TM5800/TM5400 Crusoe boards
(1GHz/533MHz). When I move the SAA7134 board to a 400MHz Celeron, no
problems at all. I measured the interrupt latency of the SAA7134
interrupt on the Crusoe, and that peaks to >1000us when power
management is enabled and other activity (IDE DMA) is taking place!!
That may explain why other people haven't seen this problem.

Question for lkml: are interrupt latencies supposed to be like that on
Crusoe systems, or is there something wrong with my boards? Booting
with no-hlt acpi=off apm=off, setting the cpufreq governor to
performance, or running a reniced "while :; do :; done" in the
background all seem to help quite a bit, but it doesn't eliminate the
problem completely.

Eric

--- video4linux/saa7134-ts.c.orig	2004-12-10 08:07:00.000000000 -0500
+++ video4linux/saa7134-ts.c	2005-02-01 18:58:50.000000000 -0500
@@ -221,10 +221,10 @@
 	if (dev->ts_q.curr) {
 		field = dev->ts_q.curr->vb.field;
 		if (field == V4L2_FIELD_TOP) {
-			if ((status & 0x100000) != 0x100000)
+			if ((status & 0x100000) == 0x100000)
 				goto done;
 		} else {
-			if ((status & 0x100000) != 0x000000)
+			if ((status & 0x100000) == 0x000000)
 				goto done;
 		}
 		saa7134_buffer_finish(dev,&dev->ts_q,STATE_DONE);
