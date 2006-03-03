Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWCCQKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWCCQKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 11:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWCCQKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 11:10:05 -0500
Received: from webapps.arcom.com ([194.200.159.168]:27653 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S932083AbWCCQKC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 11:10:02 -0500
Message-ID: <44086A4F.1040403@arcom.com>
Date: Fri, 03 Mar 2006 16:09:51 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jayakumar.alsa@gmail.com
CC: Linux Kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: CS5535: shorter delays when accessing AC'97 codec registers
Content-Type: multipart/mixed;
 boundary="------------060803090207050707030804"
X-OriginalArrivalTime: 03 Mar 2006 16:09:56.0171 (UTC) FILETIME=[E9BAF9B0:01C63EDC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060803090207050707030804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The 10 ms sleeps while waiting for AC'97 codec register reads/writes to
complete are excessive given the maxmium time is one AC'97 frame (~21 us).

With AC'97 codecs with integrated touchscreens (like the UCB1400) this
improves the interactive performance of the touchscreen.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

--------------060803090207050707030804
Content-Type: text/plain;
 name="alsa-cs5535-quicker-ac97-register-accesses"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-cs5535-quicker-ac97-register-accesses"

ALSA: CS5535: shorter delays when accessing AC'97 codec registers

The 10 ms sleeps while waiting for AC'97 codec register reads/writes to
complete are excessive given the maxmium time is one AC'97 frame (~21 us).

With AC'97 codecs with integrated touchscreens (like the UCB1400) this
improves the interactive performance of the touchscreen.

Signed-off-by: David Vrabel <dvrabel@arcom.com>

Index: linux-2.6-working/sound/pci/cs5535audio/cs5535audio.c
===================================================================
--- linux-2.6-working.orig/sound/pci/cs5535audio/cs5535audio.c	2006-03-02 16:12:52.000000000 +0000
+++ linux-2.6-working/sound/pci/cs5535audio/cs5535audio.c	2006-03-03 15:47:30.000000000 +0000
@@ -62,7 +62,7 @@
 		tmp = cs_readl(cs5535au, ACC_CODEC_CNTL);
 		if (!(tmp & CMD_NEW))
 			break;
-		msleep(10);
+		udelay(1);
 	} while (--timeout);
 	if (!timeout)
 		snd_printk(KERN_ERR "Failure writing to cs5535 codec\n");
@@ -80,14 +80,14 @@
 	regdata |= CMD_NEW;
 
 	cs_writel(cs5535au, ACC_CODEC_CNTL, regdata);
-	wait_till_cmd_acked(cs5535au, 500);
+	wait_till_cmd_acked(cs5535au, 50);
 
 	timeout = 50;
 	do {
 		val = cs_readl(cs5535au, ACC_CODEC_STATUS);
 		if ((val & STS_NEW) && reg == (val >> 24))
 			break;
-		msleep(10);
+		udelay(1);
 	} while (--timeout);
 	if (!timeout)
 		snd_printk(KERN_ERR "Failure reading cs5535 codec\n");

--------------060803090207050707030804--
