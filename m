Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268268AbUJJMWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268268AbUJJMWS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 08:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268271AbUJJMWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 08:22:18 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:55991 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S268268AbUJJMWI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 08:22:08 -0400
Message-ID: <4169297A.8040602@drzeus.cx>
Date: Sun, 10 Oct 2004 14:22:18 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-17159-1097410959-0001-2"
To: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH] MMC power cycle
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-17159-1097410959-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I think I've found the special magic required to initialise my problem 
card without causing issues with other cards/controllers.

After the initial scan to determine a correct voltage, the host cycles 
power to reboot any cards (like mine) that have gone into shutdown. This 
patch works with the two cards I have (one good, one bad).

Russell, do you think this will work in all discussed scenarios?

Rgds
Pierre

--=_hades.drzeus.cx-17159-1097410959-0001-2
Content-Type: text/x-patch; name="mmc-powercycle.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-powercycle.patch"

Index: linux-wbsd/drivers/mmc/mmc.c
===================================================================
--- linux-wbsd/drivers/mmc/mmc.c	(revision 71)
+++ linux-wbsd/drivers/mmc/mmc.c	(working copy)
@@ -666,13 +666,24 @@
 		host->ocr = mmc_select_voltage(host, ocr);
 
 		/*
-		 * Since we're changing the OCR value, we seem to
-		 * need to tell some cards to go back to the idle
-		 * state.  We wait 1ms to give cards time to
-		 * respond.
+		 * Some cards shut down when receiving an OCR of
+		 * zero. But since they send their mask before
+		 * shutting down we can still calculate a correct
+		 * voltage. To get them back to life we need to
+		 * cycle power.
+		 *
+		 * When changing OCR values we also need to put
+		 * the cards in idle state. But since we restart
+		 * them here that point is moot.
 		 */
 		if (host->ocr)
+		{
+			mmc_power_off(host);
+			mmc_delay(100);
+			mmc_power_up(host);
+
 			mmc_idle_cards(host);
+		}
 	} else {
 		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
 		host->ios.clock = host->f_min;

--=_hades.drzeus.cx-17159-1097410959-0001-2--
