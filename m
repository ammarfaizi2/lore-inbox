Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVLTG1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVLTG1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 01:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVLTG1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 01:27:08 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:29061 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750806AbVLTG1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 01:27:07 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFT] Fix psmouse turning off light on optical mice
Date: Tue, 20 Dec 2005 01:27:03 -0500
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512200127.03840.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch attempts to fix issue with some PS/2 mice turning off
their light and powering down when used with kernel 2.6. If you own such
a mouse please give patch below a spin.

Thanks!

-- 
Dmitry

Input: psmouse - don't leave mouse asleep

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
