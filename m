Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265024AbUFHLRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265024AbUFHLRJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 07:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265032AbUFHLRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 07:17:09 -0400
Received: from a62-216-22-210.adsl.cistron.nl ([62.216.22.210]:49679 "EHLO
	mail.kwaak.net") by vger.kernel.org with ESMTP id S265024AbUFHLRE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 07:17:04 -0400
Date: Tue, 8 Jun 2004 13:16:22 +0200
To: linux-kernel@vger.kernel.org
Cc: ard@kwaak.net
Subject: [PATCH] atiixp ac97 timeout gives error (2.6.7-rc2)
Message-ID: <20040608111621.GW18505@kwaak.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="phCU5ROyZO6kBE05"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Ard van Breemen <ard@kwaak.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
I found that with 2.6.7-rc2 alsa refuses to recognize my atiixp
as a working sound card.
My atiixp is of a compaq nx9110 notebook.

pci stuff:

0000:00:14.5 Class 0401: 1002:4341
        Subsystem: 103c:006b
        Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 5
        Memory at d0003000 (32-bit, non-prefetchable)

or:
0000:00:14.5 Multimedia audio controller: ATI Technologies Inc SoundMAX Integrated Digital Audio

I've patched the atiixp driver by ignoring the error when the
driver loads. If I recall correctly, this was the normal
behaviour in 2.6.5: a timeout warning was issued, but the "card"
functioned is it should.

If an alsa developer could point me to the "right" way, I can
make the patch a real patch.

--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-atiixp-soundmax

--- atiixp.c.org	2004-06-08 10:01:41.000000000 +0200
+++ atiixp.c	2004-06-08 10:04:30.000000000 +0200
@@ -1387,12 +1387,18 @@
 		ac97.num = i;
 		ac97.scaps = AC97_SCAP_SKIP_MODEM;
 		if ((err = snd_ac97_mixer(pbus, &ac97, &chip->ac97[i])) < 0) {
-			if (chip->codec_not_ready_bits)
+
+	 		if (chip->codec_not_ready_bits) {
 				/* codec(s) was detected but not available.
 				 * return the error
 				 */
-				return err;
-			else {
+				/*
+				 * The codec probably still is busy, which is
+				 * according to specs I thought.
+				 */
+				/* return err; */
+				printk("snd-atiixp: ignored codec not ready\n",__LINE__);
+			} else {
 				/* codec(s) was NOT detected, so just ignore here */
 				chip->ac97[i] = NULL; /* to be sure */
 				snd_printd("atiixp: codec %d not found\n", i);

--phCU5ROyZO6kBE05--
