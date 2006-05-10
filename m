Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWEJDAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWEJDAR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 23:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWEJC5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:57:19 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:10558 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932440AbWEJC44
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:56 -0400
Date: Tue, 9 May 2006 19:56:02 -0700
Message-Id: <200605100256.k4A2u2wo031725@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: vandrove@vc.cvut.cz, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] matroxfb_maven gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks possible that the PLL and clock functions might get into a condition
when these stack variables would get used/returned with uninitialized
data . So it needs further review ..

Fixes the following warning,

drivers/video/matrox/matroxfb_maven.c: In function 'maven_out_compute':
drivers/video/matrox/matroxfb_maven.c:287: warning: 'p' may be used uninitialized in this function
drivers/video/matrox/matroxfb_maven.c:718: warning: 'h2' may be used uninitialized in this function
drivers/video/matrox/matroxfb_maven.c:718: warning: 'b' may be used uninitialized in this function
drivers/video/matrox/matroxfb_maven.c:718: warning: 'a' may be used uninitialized in this function

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/video/matrox/matroxfb_maven.c
===================================================================
--- linux-2.6.16.orig/drivers/video/matrox/matroxfb_maven.c
+++ linux-2.6.16/drivers/video/matrox/matroxfb_maven.c
@@ -284,7 +284,7 @@ static unsigned int matroxfb_mavenclock(
 		unsigned int* in, unsigned int* feed, unsigned int* post,
 		unsigned int* htotal2) {
 	unsigned int fvco;
-	unsigned int p;
+	unsigned int p = 0;
 
 	fvco = matroxfb_PLL_mavenclock(&maven1000_pll, ctl, htotal, vtotal, in, feed, &p, htotal2);
 	if (!fvco)
@@ -715,7 +715,10 @@ static int maven_find_exact_clocks(unsig
 	m->regs[0x82] = 0x81;
 
 	for (x = 0; x < 8; x++) {
-		unsigned int a, b, c, h2;
+		unsigned int a = 0; 
+		unsigned int b = 0; 
+		unsigned int h2 = 0;
+		unsigned int c;
 		unsigned int h = ht + 2 + x;
 
 		if (!matroxfb_mavenclock((m->mode == MATROXFB_OUTPUT_MODE_PAL) ? &maven_PAL : &maven_NTSC, h, vt, &a, &b, &c, &h2)) {
