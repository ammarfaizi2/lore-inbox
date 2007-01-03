Return-Path: <linux-kernel-owner+w=401wt.eu-S1754910AbXACHYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910AbXACHYq (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 02:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754905AbXACHYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 02:24:45 -0500
Received: from mail.queued.net ([207.210.101.209]:1733 "EHLO mail.queued.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754808AbXACHYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 02:24:45 -0500
Message-ID: <459B5256.6050004@queued.net>
Date: Wed, 03 Jan 2007 01:51:02 -0500
From: Andres Salomon <dilinger@queued.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: linux-kernel@vger.kernel.org, vojtech@suse.cz, warp@aehallh.com
Subject: Re: [PATCH] psmouse split [02/03]
References: <457F822E.4040404@debian.org>	 <200612130108.19447.dtor@insightbb.com> <457FAA01.9010807@debian.org>	 <d120d5000612130612v5d12adc0uc878b8307770d79@mail.gmail.com>	 <45802D98.7030608@debian.org> <d120d5000612130947w899614y68cf32cb1e3b35ec@mail.gmail.com> <459B51C4.8040906@queued.net>
In-Reply-To: <459B51C4.8040906@queued.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------090507080508080503020001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090507080508080503020001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andres Salomon wrote:
> Dmitry Torokhov wrote:
>> On 12/13/06, Andres Salomon <dilinger@debian.org> wrote:
>>> Alright, I guess we're down to a matter of taste then.  I'll change the
>>> patch to still have a monolithic psmouse that allows protocols to be
>>> enabled/disabled via Kconfig.
>>>
>> That'd be great. Thanks!
>>
> 
> Yikes, almost forgot to send this.  Here you go; 3 patches total.
> Please let me know if there are any other change.  The first is attached.
> 

Here's the second; everything is split except for the synaptic stuff.

--------------090507080508080503020001
Content-Type: text/plain;
 name*0="0002-Wrap-all-protocols-except-for-synaptics-w-ifdefs.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0002-Wrap-all-protocols-except-for-synaptics-w-ifdefs.txt"

>From 712d339038bb348c354f5e7472f1f156e485bda3 Mon Sep 17 00:00:00 2001
From: Andres Salomon <dilinger@debian.org>
Date: Tue, 26 Dec 2006 16:50:47 -0500
Subject: [PATCH] Wrap all protocols except for synaptics w/ ifdefs

This patch allows ALPS, LOGIPS2PP, LIFEBOOK, and TRACKPOINT protocol
extensions to be disabled during compilation.  The synaptics stuff is left
alone for now, since it needs special handling for synaptic pass-through
ports.

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/input/mouse/psmouse-base.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index a0e4a03..6b3ac9d 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -555,6 +555,7 @@ static int psmouse_extensions(struct psm
 {
 	int synaptics_hardware = 0;
 
+#ifdef CONFIG_MOUSE_PS2_LIFEBOOK
 /*
  * We always check for lifebook because it does not disturb mouse
  * (it only checks DMI information).
@@ -565,6 +566,7 @@ static int psmouse_extensions(struct psm
 				return PSMOUSE_LIFEBOOK;
 		}
 	}
+#endif
 
 /*
  * Try Kensington ThinkingMouse (we try first, because synaptics probe
@@ -596,6 +598,7 @@ static int psmouse_extensions(struct psm
 		synaptics_reset(psmouse);
 	}
 
+#ifdef CONFIG_MOUSE_PS2_ALPS
 /*
  * Try ALPS TouchPad
  */
@@ -610,15 +613,20 @@ static int psmouse_extensions(struct psm
 			max_proto = PSMOUSE_IMEX;
 		}
 	}
+#endif
 
 	if (max_proto > PSMOUSE_IMEX && genius_detect(psmouse, set_properties) == 0)
 		return PSMOUSE_GENPS;
 
+#ifdef CONFIG_MOUSE_PS2_LOGIPS2PP
 	if (max_proto > PSMOUSE_IMEX && ps2pp_init(psmouse, set_properties) == 0)
 		return PSMOUSE_PS2PP;
+#endif
 
+#ifdef CONFIG_MOUSE_PS2_TRACKPOINT
 	if (max_proto > PSMOUSE_IMEX && trackpoint_detect(psmouse, set_properties) == 0)
 		return PSMOUSE_TRACKPOINT;
+#endif
 
 /*
  * Reset to defaults in case the device got confused by extended
@@ -660,12 +668,14 @@ static const struct psmouse_protocol psm
 		.maxproto	= 1,
 		.detect		= ps2bare_detect,
 	},
+#ifdef CONFIG_MOUSE_PS2_LOGIPS2PP
 	{
 		.type		= PSMOUSE_PS2PP,
 		.name		= "PS2++",
 		.alias		= "logitech",
 		.detect		= ps2pp_init,
 	},
+#endif
 	{
 		.type		= PSMOUSE_THINKPS,
 		.name		= "ThinkPS/2",
@@ -699,6 +709,7 @@ static const struct psmouse_protocol psm
 		.detect		= synaptics_detect,
 		.init		= synaptics_init,
 	},
+#ifdef CONFIG_MOUSE_PS2_ALPS
 	{
 		.type		= PSMOUSE_ALPS,
 		.name		= "AlpsPS/2",
@@ -706,18 +717,23 @@ static const struct psmouse_protocol psm
 		.detect		= alps_detect,
 		.init		= alps_init,
 	},
+#endif
+#ifdef CONFIG_MOUSE_PS2_LIFEBOOK
 	{
 		.type		= PSMOUSE_LIFEBOOK,
 		.name		= "LBPS/2",
 		.alias		= "lifebook",
 		.init		= lifebook_init,
 	},
+#endif
+#ifdef CONFIG_MOUSE_PS2_TRACKPOINT
 	{
 		.type		= PSMOUSE_TRACKPOINT,
 		.name		= "TPPS/2",
 		.alias		= "trackpoint",
 		.detect		= trackpoint_detect,
 	},
+#endif
 	{
 		.type		= PSMOUSE_AUTO,
 		.name		= "auto",
-- 
1.4.1


--------------090507080508080503020001--
