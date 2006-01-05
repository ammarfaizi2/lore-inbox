Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWAEDYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWAEDYO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 22:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWAEDYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 22:24:13 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:61606 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751038AbWAEDYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 22:24:12 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: mouse issues in 2.6.15-rc5-mm series
Date: Wed, 4 Jan 2006 22:24:07 -0500
User-Agent: KMail/1.8.3
Cc: Marc Koschewski <marc@osknowledge.org>, Joe Feise <jfeise@feise.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <43ACEE14.7060507@feise.com> <200512252309.07162.dtor_core@ameritech.net> <43AF742E.5040604@tuxrocks.com>
In-Reply-To: <43AF742E.5040604@tuxrocks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601042224.08509.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 December 2005 23:40, Frank Sorenson wrote:
> Dmitry Torokhov wrote:
> > On Saturday 24 December 2005 05:57, Frank Sorenson wrote:
> >
> >>I continue to see the same issues with the resync patch in -mm.  For me,
> >>tapping stops working, and I'm now seeing both the mouse pointer jumping
> >> as well (a lesser issue for me, so it was probably present earlier as
> >>well).
> >>
> >
> > Frank,
> >
> > Does the tapping not work period or it only does not work first time you
> > try to tap after not touching the pad for more than 5 seconds?
> 
> The tapping works initially, then stops.  I hadn't put 2+2 together with
> the 5-second idle bit, but that seems the likely issue.
> 
> I applied that patch you sent out yesterday, and now tapping works and
> I'm not seeing the mouse stall/jump problem.  I'm at 21+ hours uptime
> now, with no mouse problems, so I think setting the resync_time to 0
> looks like the right fix.
> 

Frank,

Could you please try the patch below and see if it makes tapping work?
Make sure you enable resynching by doing:

	echo -n 5 > /sys/bus/serio/devices/serioX/resync_time

Thanks!

-- 
Dmitry

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/alps.c         |   11 ++++++-----
 drivers/input/mouse/psmouse-base.c |   27 ++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 8 deletions(-)

Index: work/drivers/input/mouse/alps.c
===================================================================
--- work.orig/drivers/input/mouse/alps.c
+++ work/drivers/input/mouse/alps.c
@@ -356,19 +356,20 @@ static int alps_poll(struct psmouse *psm
 {
 	struct alps_data *priv = psmouse->private;
 	unsigned char buf[6];
+	int poll_failed;
 
 	if (priv->i->flags & ALPS_PASS)
 		alps_passthrough_mode(psmouse, 1);
 
-	if (ps2_command(&psmouse->ps2dev, buf, PSMOUSE_CMD_POLL | (psmouse->pktsize << 8)))
-		return -1;
-
-	if ((buf[0] & priv->i->mask0) != priv->i->byte0)
-		return -1;
+	poll_failed = ps2_command(&psmouse->ps2dev, buf,
+				  PSMOUSE_CMD_POLL | (psmouse->pktsize << 8)) < 0;
 
 	if (priv->i->flags & ALPS_PASS)
 		alps_passthrough_mode(psmouse, 0);
 
+	if (poll_failed || (buf[0] & priv->i->mask0) != priv->i->byte0)
+		return -1;
+
 	if ((psmouse->badbyte & 0xc8) == 0x08) {
 /*
  * Poll the track stick ...
Index: work/drivers/input/mouse/psmouse-base.c
===================================================================
--- work.orig/drivers/input/mouse/psmouse-base.c
+++ work/drivers/input/mouse/psmouse-base.c
@@ -54,7 +54,7 @@ static unsigned int psmouse_smartscroll 
 module_param_named(smartscroll, psmouse_smartscroll, bool, 0644);
 MODULE_PARM_DESC(smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
 
-static unsigned int psmouse_resetafter;
+static unsigned int psmouse_resetafter = 5;
 module_param_named(resetafter, psmouse_resetafter, uint, 0644);
 MODULE_PARM_DESC(resetafter, "Reset device after so many bad packets (0 = never).");
 
@@ -850,8 +850,29 @@ static void psmouse_deactivate(struct ps
 
 static int psmouse_poll(struct psmouse *psmouse)
 {
-	return ps2_command(&psmouse->ps2dev, psmouse->packet,
-			   PSMOUSE_CMD_POLL | (psmouse->pktsize << 8));
+	if (ps2_command(&psmouse->ps2dev, psmouse->packet,
+			PSMOUSE_CMD_POLL | (psmouse->pktsize << 8)))
+		return -1;
+
+	switch (psmouse->type) {
+		case PSMOUSE_PS2:
+		case PSMOUSE_PS2PP:
+		case PSMOUSE_IMPS:
+		case PSMOUSE_IMEX:
+		case PSMOUSE_LIFEBOOK:
+		case PSMOUSE_TRACKPOINT:
+/*
+ * If protocol may be used by "tappable" device (touchpad, touchscreen) try to "restore"
+ * tap data from the halfway-discarded packet
+ */
+			if ((psmouse->badbyte & 0x08) == (psmouse->packet[0] & 0x08))
+				psmouse->packet[0] |= psmouse->badbyte & 0x07;
+
+		default:
+			break;
+	}
+
+	return 0;
 }
 
 
