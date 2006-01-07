Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030550AbWAGTIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030550AbWAGTIw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030553AbWAGTIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:08:32 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:33401 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030551AbWAGTIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:08:22 -0500
Message-Id: <20060107172100.444488000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:07 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 08/24] psmouse: dont leave mouse asleep
Content-Disposition: inline; filename=psmouse-dont-snooze.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
It looks like quite a few mice out there treat PSMOUSE_RESET_DIS
as a powerdown request and turn off the light rendering the mouse
unusable.

Vojtech recommended to switch from PSMOUSE_RESET_DIS to full reset,
however we don't want to do that everywhere as full reset is pretty
slow. Instead we only use it before probing for "generic" protocols,
such as IntelliMouse and Explorer, to make sure that the mouse will
be woken up if it went to sleep as a result of PSMOUSE_RESET_DIS
issued earlier.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/psmouse-base.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

Index: work/drivers/input/mouse/psmouse-base.c
===================================================================
--- work.orig/drivers/input/mouse/psmouse-base.c
+++ work/drivers/input/mouse/psmouse-base.c
@@ -527,11 +527,15 @@ static int psmouse_extensions(struct psm
 	if (max_proto > PSMOUSE_IMEX && ps2pp_init(psmouse, set_properties) == 0)
 		return PSMOUSE_PS2PP;
 
+	if (max_proto > PSMOUSE_IMEX && trackpoint_detect(psmouse, set_properties) == 0)
+		return PSMOUSE_TRACKPOINT;
+
 /*
  * Reset to defaults in case the device got confused by extended
- * protocol probes.
+ * protocol probes. Note that we do full reset becuase some mice
+ * put themselves to sleep when see PSMOUSE_RESET_DIS.
  */
-	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
+	psmouse_reset(psmouse);
 
 	if (max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse, set_properties) == 0)
 		return PSMOUSE_IMEX;
@@ -540,12 +544,6 @@ static int psmouse_extensions(struct psm
 		return PSMOUSE_IMPS;
 
 /*
- * Try to initialize the IBM TrackPoint
- */
-	if (max_proto > PSMOUSE_IMEX && trackpoint_detect(psmouse, set_properties) == 0)
-		return PSMOUSE_TRACKPOINT;
-
-/*
  * Okay, all failed, we have a standard mouse here. The number of the buttons
  * is still a question, though. We assume 3.
  */
@@ -559,7 +557,6 @@ static int psmouse_extensions(struct psm
  * extensions.
  */
 		psmouse_reset(psmouse);
-		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
 	}
 
 	return PSMOUSE_PS2;

