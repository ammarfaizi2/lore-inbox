Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUHDTM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUHDTM7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 15:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbUHDTM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 15:12:58 -0400
Received: from mail.gmx.de ([213.165.64.20]:52879 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267374AbUHDTMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 15:12:54 -0400
X-Authenticated: #420190
Message-ID: <411135B0.5040702@gmx.net>
Date: Wed, 04 Aug 2004 21:14:56 +0200
From: Marko Macek <Marko.Macek@gmx.net>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Vojtech Pavlik <vojtech@suse.cz>, Jesper Juhl <juhl-lkml@dif.dk>,
       Eric Wong <eric@yhbt.net>, LKML <linux-kernel@vger.kernel.org>,
       david+challenge-response@blue-labs.org
Subject: Re: KVM & mouse wheel [PATCH]
References: <20040804174140.81473.qmail@web81307.mail.yahoo.com>
In-Reply-To: <20040804174140.81473.qmail@web81307.mail.yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------070102090302060103000100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070102090302060103000100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dmitry Torokhov wrote:

>Anyway, I think that explicitely calling reset-disable after each
>failed probe is a good idea... or maybe not after each probe but just
>once, before probing for generic protocols (imps/exps), like in the
>attached patch.
>  
>
Besides above, the attached patch moves setting the streaming mode
above setting of resolution/rate/scaling.  With that, the mouse works
fine for me in 'imex' mode without any overrides.

Mark



--------------070102090302060103000100
Content-Type: text/x-patch;
 name="psmouse-kvm-reset-streaming.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="psmouse-kvm-reset-streaming.patch"

--- drivers/input/mouse/psmouse-base.c.orig	2004-08-04 21:02:38.045307096 +0200
+++ drivers/input/mouse/psmouse-base.c	2004-08-04 21:01:38.739322976 +0200
@@ -461,6 +461,12 @@
 			return type;
 	}
 
+/*
+ * Reset to defaults in case the device got confused by extended
+ * protocol probes.
+ */
+	psmouse_command(psmouse, NULL, PSMOUSE_CMD_RESET_DIS);
+
 	if (max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse)) {
 
 		if (set_properties) {
@@ -581,6 +587,12 @@
 	unsigned char param[2];
 
 /*
+ * We set the mouse into streaming mode.
+ */
+
+	psmouse_command(psmouse, param, PSMOUSE_CMD_SETSTREAM);
+
+/*
  * We set the mouse report rate, resolution and scaling.
  */
 
@@ -589,12 +601,6 @@
 		psmouse_set_resolution(psmouse);
 		psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
 	}
-
-/*
- * We set the mouse into streaming mode.
- */
-
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETSTREAM);
 }
 
 /*

--------------070102090302060103000100--
