Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbTJ0OCo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 09:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTJ0OCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 09:02:41 -0500
Received: from zero.aec.at ([193.170.194.10]:18441 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263085AbTJ0OCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 09:02:34 -0500
Date: Mon, 27 Oct 2003 15:02:17 +0100
From: Andi Kleen <ak@muc.de>
To: torvalds@osdl.org, vojtech@suse.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PS/2 mouse rate setting 
Message-ID: <20031027140217.GA1065@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My KVM doesn't like the new default of psmouse_rate=200. The mouse
felt very "jumpy" and was unconvenient to use. 

Unfortunately the setting could be only changed when the mouse driver
was a module. But I tend to have the mouse driver compiled in.
This patch fixes this by adding an __setup for it too.

Also it fixes an off by one bug to make sure that psmouse_rate=60
really gives 60 samples per second and not 40.

Overall as KVM user I must say I'm not very happy with the 2.6 mouse
driver. 2.4 pretty much worked out of the box, but 2.6 needs
lots of strange options (psmouse_noext, psmouse_rate=80) 
because it does things very differently out of the box.

-Andi

diff -u linux-2.6.0test9-averell/drivers/input/mouse/psmouse-base.c-o linux-2.6.0test9-averell/drivers/input/mouse/psmouse-base.c
--- linux-2.6.0test9-averell/drivers/input/mouse/psmouse-base.c-o	2003-09-28 10:53:17.000000000 +0200
+++ linux-2.6.0test9-averell/drivers/input/mouse/psmouse-base.c	2003-10-27 14:54:02.000000000 +0100
@@ -454,7 +454,7 @@
 	unsigned char rates[] = { 200, 100, 80, 60, 40, 20, 10, 0 };
 	int i = 0;
 
-	while (rates[i] > psmouse_rate) i++;
+	while (rates[i] >= psmouse_rate) i++;
 	psmouse_command(psmouse, rates + i, PSMOUSE_CMD_SETRATE);
 }
 
@@ -651,10 +651,17 @@
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
 




