Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbTJ0Sja (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 13:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbTJ0Sj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 13:39:29 -0500
Received: from zero.aec.at ([193.170.194.10]:26890 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263480AbTJ0Sj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 13:39:27 -0500
Date: Mon, 27 Oct 2003 19:38:56 +0100
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, vojtech@suse.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PS/2 mouse rate setting
Message-ID: <20031027183856.GA1461@averell>
References: <20031027140217.GA1065@averell> <Pine.LNX.4.44.0310270830060.1699-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310270830060.1699-100000@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 08:32:15AM -0800, Linus Torvalds wrote:
> 
> On Mon, 27 Oct 2003, Andi Kleen wrote:
> > 
> > Overall as KVM user I must say I'm not very happy with the 2.6 mouse
> > driver. 2.4 pretty much worked out of the box, but 2.6 needs
> > lots of strange options (psmouse_noext, psmouse_rate=80) 
> > because it does things very differently out of the box.
> 
> I agree. The keyboard driver has also deteriorated, I think. 
> 
> I'd suggest we _not_ set the rate by default at all (and let the default
> thing just happen). And only set the rate if the user _asks_ for it with
> your setup thing. Mind sending me that kind of patch?

Here's the new patch with this change.
-Andi

-------------------------------------------------------------

Add an psmouse_rate option for the kernel command line.

Don't set the psmouse sample rate unless the user specified a value.

Make rates[] array static

diff -u linux-2.6.0test9-averell/drivers/input/mouse/psmouse-base.c-o linux-2.6.0test9-averell/drivers/input/mouse/psmouse-base.c
--- linux-2.6.0test9-averell/drivers/input/mouse/psmouse-base.c-o	2003-09-28 10:53:17.000000000 +0200
+++ linux-2.6.0test9-averell/drivers/input/mouse/psmouse-base.c	2003-10-27 19:27:44.000000000 +0100
@@ -40,7 +40,7 @@
 
 static int psmouse_noext;
 int psmouse_resolution;
-unsigned int psmouse_rate = 60;
+unsigned int psmouse_rate = 0;
 int psmouse_smartscroll = PSMOUSE_LOGITECH_SMARTSCROLL;
 unsigned int psmouse_resetafter;
 
@@ -451,10 +451,13 @@
 
 static void psmouse_set_rate(struct psmouse *psmouse)
 {
-	unsigned char rates[] = { 200, 100, 80, 60, 40, 20, 10, 0 };
+	static unsigned char rates[] = { 200, 100, 80, 60, 40, 20, 10, 0 };
 	int i = 0;
 
-	while (rates[i] > psmouse_rate) i++;
+	if (!psmouse_rate)
+		return; 
+
+	while (rates[i] >= psmouse_rate) i++;
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
 
