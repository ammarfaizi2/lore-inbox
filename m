Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbTJEPMe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 11:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbTJEPMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 11:12:34 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:15232 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S263128AbTJEPMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 11:12:32 -0400
Subject: Re: [PATCH 5/8] Rely less on sanity of AT keyboards.
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <10645086121089@twilight.ucw.cz>
References: <10645086121089@twilight.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1065366749.755.18.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 05 Oct 2003 17:12:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-25 at 18:50, Vojtech Pavlik wrote:

> diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> --- a/drivers/input/mouse/psmouse-base.c	Thu Sep 25 18:37:20 2003
> +++ b/drivers/input/mouse/psmouse-base.c	Thu Sep 25 18:37:20 2003
> @@ -28,6 +28,8 @@
>  MODULE_PARM_DESC(psmouse_noext, "Disable any protocol extensions. Useful for KVM switches.");
>  MODULE_PARM(psmouse_resolution, "i");
>  MODULE_PARM_DESC(psmouse_resolution, "Resolution, in dpi.");
> +MODULE_PARM(psmouse_rate, "i");
> +MODULE_PARM_DESC(psmouse_rate, "Report rate, in reports per second.");
>  MODULE_PARM(psmouse_smartscroll, "i");
>  MODULE_PARM_DESC(psmouse_smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
>  MODULE_PARM(psmouse_resetafter, "i");
> @@ -38,6 +40,7 @@
>  
>  static int psmouse_noext;
>  int psmouse_resolution;
> +unsigned int psmouse_rate = 60;

Please change this back to 200. Mousebehaviour is _really_ horrible with
60. There's currently no way to change it for kernels with this driver
compiled in.

Here's a patch to change it back to 200 and readd the fallback to a
lower rate if the requested failed to be set.

--- linux-2.6.0-test6-mm4/drivers/input/mouse/psmouse-base.c.orig	2003-10-05 17:02:23.000000000 +0200
+++ linux-2.6.0-test6-mm4/drivers/input/mouse/psmouse-base.c	2003-10-05 17:06:55.000000000 +0200
@@ -40,7 +40,7 @@
 
 static int psmouse_noext;
 int psmouse_resolution;
-unsigned int psmouse_rate = 60;
+unsigned int psmouse_rate = 200;
 int psmouse_smartscroll = PSMOUSE_LOGITECH_SMARTSCROLL;
 unsigned int psmouse_resetafter;
 
@@ -450,6 +450,11 @@
 	int i = 0;
 
 	while (rates[i] > psmouse_rate) i++;
+
+	/* set lower rate in case requested rate fails */
+	if (rates[i])
+		psmouse_command(psmouse, rates + i + 1, PSMOUSE_CMD_SETRATE);
+
 	psmouse_command(psmouse, rates + i, PSMOUSE_CMD_SETRATE);
 }
 

-- 
/Martin
