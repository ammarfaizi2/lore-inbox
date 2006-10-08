Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWJHSq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWJHSq1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWJHSq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:46:27 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:43438 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751323AbWJHSq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:46:26 -0400
Message-ID: <45294778.8020802@linuxtv.org>
Date: Sun, 08 Oct 2006 14:46:16 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: stable@kernel.org
CC: linux-kernel@vger.kernel.org,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Yeasah Pell <yeasah@schwide.net>, Steven Toth <stoth@hauppauge.com>
Subject: [2.6.17.y PATCH 2/2] cx24123: fix PLL divisor setup
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From df9b6db4d2168cd82f8590d2f9a2d3580cdf7233 Mon Sep 17 00:00:00 2001
From: Yeasah Pell <yeasah@schwide.net>
Date: Tue, 3 Oct 2006 21:57:08 -0400
Subject: [PATCH] cx24123: fix PLL divisor setup

The cx24109 datasheet says: "NOTE: if A=0, then N=N+1"

The current code is the result of a misinterpretation of the datasheet to
mean exactly the opposite of the requirement -- The actual value of N is 1 greater than the value written when A is 0, so 1 needs to be *subtracted*
from it to compensate.

Signed-off-by: Yeasah Pell <yeasah@schwide.net>
Signed-off-by: Steven Toth <stoth@hauppauge.com>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
---
 drivers/media/dvb/frontends/cx24123.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb/frontends/cx24123.c b/drivers/media/dvb/frontends/cx24123.c
index 691dc84..afb08ff 100644
--- a/drivers/media/dvb/frontends/cx24123.c
+++ b/drivers/media/dvb/frontends/cx24123.c
@@ -579,8 +579,8 @@ static int cx24123_pll_calculate(struct 
 	ndiv = ( ((p->frequency * vco_div * 10) / (2 * XTAL / 1000)) / 32) & 0x1ff;
 	adiv = ( ((p->frequency * vco_div * 10) / (2 * XTAL / 1000)) % 32) & 0x1f;
 
-	if (adiv == 0)
-		ndiv++;
+	if (adiv == 0 && ndiv > 0)
+		ndiv--;
 
 	/* control bits 11, refdiv 11, charge pump polarity 1, charge pump current, ndiv, adiv */
 	state->pllarg = (3 << 19) | (3 << 17) | (1 << 16) | (pump << 14) | (ndiv << 5) | adiv;
