Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263519AbTJ0TaM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 14:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263521AbTJ0TaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 14:30:12 -0500
Received: from zero.aec.at ([193.170.194.10]:41482 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263519AbTJ0TaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 14:30:06 -0500
Date: Mon, 27 Oct 2003 20:29:50 +0100
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, vojtech@suse.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PS/2 mouse rate setting
Message-ID: <20031027192950.GA2192@averell>
References: <20031027183856.GA1461@averell> <Pine.LNX.4.44.0310271054120.1636-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310271054120.1636-100000@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jOn Mon, Oct 27, 2003 at 10:56:16AM -0800, Linus Torvalds wrote:
> 
> Which makes no sense.

Ok new patch with this fixed.

---------------------------

Only set PS/2 mouse rate when the user specified a value.

Allow specifying it from the command line when the driver is compiled in.

Make rates[] static.

diff -u linux-2.6.0test9-averell/drivers/input/mouse/psmouse-base.c-o linux-2.6.0test9-averell/drivers/input/mouse/psmouse-base.c
--- linux-2.6.0test9-averell/drivers/input/mouse/psmouse-base.c-o	2003-09-28 10:53:17.000000000 +0200
+++ linux-2.6.0test9-averell/drivers/input/mouse/psmouse-base.c	2003-10-27 20:16:25.000000000 +0100
@@ -40,7 +40,7 @@
 
 static int psmouse_noext;
 int psmouse_resolution;
-unsigned int psmouse_rate = 60;
+unsigned int psmouse_rate = 0;
 int psmouse_smartscroll = PSMOUSE_LOGITECH_SMARTSCROLL;
 unsigned int psmouse_resetafter;
 
@@ -451,9 +451,12 @@
 
 static void psmouse_set_rate(struct psmouse *psmouse)
 {
-	unsigned char rates[] = { 200, 100, 80, 60, 40, 20, 10, 0 };
+	static unsigned char rates[] = { 200, 100, 80, 60, 40, 20, 10, 0 };
 	int i = 0;
 
+	if (!psmouse_rate)
+		return; 
+
 	while (rates[i] > psmouse_rate) i++;
 	psmouse_command(psmouse, rates + i, PSMOUSE_CMD_SETRATE);
 }
@@ -651,10 +654,17 @@
 	return 1;
 }
 
+static int __init psmouse_rate_setup(char *str)
+{
+	get_option(&str, &psmouse_rate);
+	return 1;
+}
+
 __setup("psmouse_noext", psmouse_noext_setup);
 __setup("psmouse_resolution=", psmouse_resolution_setup);
 __setup("psmouse_smartscroll=", psmouse_smartscroll_setup);
 __setup("psmouse_resetafter=", psmouse_resetafter_setup);
+__setup("psmouse_rate=", psmouse_rate_setup);
 
 #endif
 
