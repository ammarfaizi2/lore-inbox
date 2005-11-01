Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbVKAIWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbVKAIWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbVKAIWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:22:17 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:27241 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965018AbVKAIOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:14:55 -0500
Message-ID: <436723D4.9020206@m1k.net>
Date: Tue, 01 Nov 2005 03:14:12 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 17/37] dvb: Fix integer overflow bug
Content-Type: multipart/mixed;
 boundary="------------080500030907020706020609"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080500030907020706020609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------080500030907020706020609
Content-Type: text/x-patch;
 name="2381.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2381.patch"

From: Johannes Stezenbach <js@linuxtv.org>

Fix integer overflow bug in read_signal_strength()
reported by Anthony Leclerc.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/frontends/or51132.c |    7 ++++++-
 drivers/media/dvb/frontends/or51211.c |    8 ++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/frontends/or51132.c
+++ linux-2.6.14-git3/drivers/media/dvb/frontends/or51132.c
@@ -468,6 +468,7 @@
 	unsigned char snd_buf[2];
 	u8 rcvr_stat;
 	u16 snr_equ;
+	u32 signal_strength;
 	int usK;
 
 	snd_buf[0]=0x04;
@@ -503,7 +504,11 @@
 	usK = (rcvr_stat & 0x10) ? 3 : 0;
 
         /* The value reported back from the frontend will be FFFF=100% 0000=0% */
-	*strength = (((8952 - i20Log10(snr_equ) - usK*100)/3+5)*65535)/1000;
+	signal_strength = (((8952 - i20Log10(snr_equ) - usK*100)/3+5)*65535)/1000;
+	if (signal_strength > 0xffff)
+		*strength = 0xffff;
+	else
+		*strength = signal_strength;
 	dprintk("read_signal_strength %i\n",*strength);
 
 	return 0;
--- linux-2.6.14-git3.orig/drivers/media/dvb/frontends/or51211.c
+++ linux-2.6.14-git3/drivers/media/dvb/frontends/or51211.c
@@ -339,6 +339,7 @@
 	u8 rec_buf[2];
 	u8 snd_buf[4];
 	u8 snr_equ;
+	u32 signal_strength;
 
 	/* SNR after Equalizer */
 	snd_buf[0] = 0x04;
@@ -358,8 +359,11 @@
 	snr_equ = rec_buf[0] & 0xff;
 
 	/* The value reported back from the frontend will be FFFF=100% 0000=0% */
-	*strength = (((5334 - i20Log10(snr_equ))/3+5)*65535)/1000;
-
+	signal_strength = (((5334 - i20Log10(snr_equ))/3+5)*65535)/1000;
+	if (signal_strength > 0xffff)
+		*strength = 0xffff;
+	else
+		*strength = signal_strength;
 	dprintk("read_signal_strength %i\n",*strength);
 
 	return 0;


--------------080500030907020706020609--
