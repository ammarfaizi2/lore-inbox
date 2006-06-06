Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWFFLKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWFFLKm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 07:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWFFLKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 07:10:42 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:53140 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751217AbWFFLKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 07:10:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=L5CtV6ZxTbJdF515hjVL1GX8jlYPJB/JEspw+AaRZjU8ZD/alt2WdqPDt6au9DaaIYG3LEjUCgvLdtqZgD+A+Y3htCzst8Mk2m7piIkbMM/SV7nEAXmS6oJcA438F0V0DYIXFQkyS1IFh3ZQz1HrWAwxvwuTaYiNzdMmCJzxwNA=
Message-ID: <44856232.8090909@gmail.com>
Date: Tue, 06 Jun 2006 19:08:34 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] Detaching fbcon: Fix give_up_console()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To allow for detaching fbcon, it must be able to give up the console. However,
the function give_up_console() is plain broken. It just sets the entries in
the console driver map to NULL, it leaves the vt layer without a console
driver, and does not decrement the module reference count.  Calling
give_up_console() is guaranteed to hang the machine..

To fix this problem, ensure that the virtual consoles are not left dangling
without a driver.  All systems have a default boot driver (either vgacon or
dummycon) which is never unloaded. For those vt's that lost their
driver, the default boot driver is reassigned back to them.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/char/vt.c |   29 +++++++++++++++++++++--------
 1 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index eb27eed..d7ff7fd 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -100,6 +100,7 @@ #include <asm/uaccess.h>
 
 
 const struct consw *conswitchp;
+static struct consw *defcsw; /* default console */
 
 /* A bitmap for codes <32. A bit of 1 indicates that the code
  * corresponding to that bit number invokes some special action
@@ -2673,17 +2674,23 @@ int take_over_console(const struct consw
 	if (!try_module_get(owner))
 		return -ENODEV;
 
-	acquire_console_sem();
+	/* save default console, for possible recovery later on */
+	if (!defcsw)
+		defcsw = (struct consw *) conswitchp;
 
+	acquire_console_sem();
 	desc = csw->con_startup();
+
 	if (!desc) {
 		release_console_sem();
 		module_put(owner);
 		return -ENODEV;
 	}
+
 	if (deflt) {
 		if (conswitchp)
 			module_put(conswitchp->owner);
+
 		__module_get(owner);
 		conswitchp = csw;
 	}
@@ -2701,6 +2708,7 @@ int take_over_console(const struct consw
 			continue;
 
 		j = i;
+
 		if (CON_IS_VISIBLE(vc)) {
 			k = i;
 			save_screen(vc);
@@ -2709,10 +2717,8 @@ int take_over_console(const struct consw
 		old_was_color = vc->vc_can_do_color;
 		vc->vc_sw->con_deinit(vc);
 		vc->vc_origin = (unsigned long)vc->vc_screenbuf;
-		vc->vc_visible_origin = vc->vc_origin;
-		vc->vc_scr_end = vc->vc_origin + vc->vc_screenbuf_size;
-		vc->vc_pos = vc->vc_origin + vc->vc_size_row * vc->vc_y + 2 * vc->vc_x;
 		visual_init(vc, i, 0);
+		set_origin(vc);
 		update_attr(vc);
 
 		/* If the console changed between mono <-> color, then
@@ -2741,22 +2747,29 @@ int take_over_console(const struct consw
 		printk("to %s\n", desc);
 
 	release_console_sem();
-
 	module_put(owner);
 	return 0;
 }
 
 void give_up_console(const struct consw *csw)
 {
-	int i;
+	int i, first = -1, last = -1, deflt = 0;
 
-	for(i = 0; i < MAX_NR_CONSOLES; i++)
+	for (i = 0; i < MAX_NR_CONSOLES; i++)
 		if (con_driver_map[i] == csw) {
+			if (first == -1)
+				first = i;
+			last = i;
 			module_put(csw->owner);
 			con_driver_map[i] = NULL;
 		}
-}
 
+	if (first != -1 && defcsw) {
+		if (first == 0 && last == MAX_NR_CONSOLES - 1)
+			deflt = 1;
+		take_over_console(defcsw, first, last, deflt);
+	}
+}
 #endif
 
 /*



