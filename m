Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265300AbUEZDkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265300AbUEZDkr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 23:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265297AbUEZDkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 23:40:47 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:9360 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265300AbUEZDkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 23:40:33 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Sean Neakums <sneakums@zork.net>
Subject: Re: Scroll wheel on PS/2 Logitech MouseMan Wheel no longer works (was Re: 2.6.6-mm3)
Date: Tue, 25 May 2004 22:40:25 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       vojtech@suse.cz
References: <20040516025514.3fe93f0c.akpm@osdl.org> <200405191256.32335.dtor_core@ameritech.net> <6uy8nnczcg.fsf@zork.zork.net>
In-Reply-To: <6uy8nnczcg.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405252240.29353.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 May 2004 02:49 am, Sean Neakums wrote:
> Dmitry Torokhov <dtor_core@ameritech.net> writes:
> > >
> > Hmm... it indeed reports REL_X and REL_Y events instead of REL_WHEEL... So
> > its definitely not a mousedev problem. Could you also try booting with
> > psmouse.proto=exps and see if it still behaves sanely?
> 
> The scrolls wheel appears to do nothing when I boot with psmouse.proto=exps.
> Here's what the mouse is shown as in /proc/bus/input/devices:
> 

Hi,

Sorry for delay with my answer. I got a hold of a mouse that supports
Explorer PS/2 protocol and it works fine here. Still could you try
reverting the patch below and see if it restores the correct behavior.

Thanks!

-- 
Dmitry


===================================================================


ChangeSet@1.1612.1.17, 2004-05-14 11:18:46+02:00, vojtech@suse.cz
  input: Check for IM Explorer mice even if IMPS check failed.


 psmouse-base.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-05-25 22:38:24 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-05-25 22:38:24 -05:00
@@ -461,24 +461,25 @@
 			return type;
 	}
 
-	if (max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse)) {
+	if (max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse)) {
 
 		if (set_properties) {
 			set_bit(REL_WHEEL, psmouse->dev.relbit);
+			set_bit(BTN_SIDE, psmouse->dev.keybit);
+			set_bit(BTN_EXTRA, psmouse->dev.keybit);
 			if (!psmouse->name)
-				psmouse->name = "Wheel Mouse";
+				psmouse->name = "Explorer Mouse";
 		}
 
-		if (max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse)) {
+		return PSMOUSE_IMEX;
+	}
 
-			if (!set_properties) {
-				set_bit(BTN_SIDE, psmouse->dev.keybit);
-				set_bit(BTN_EXTRA, psmouse->dev.keybit);
-				if (!psmouse->name)
-					psmouse->name = "Explorer Mouse";
-			}
+	if (max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse)) {
 
-			return PSMOUSE_IMEX;
+		if (set_properties) {
+			set_bit(REL_WHEEL, psmouse->dev.relbit);
+			if (!psmouse->name)
+				psmouse->name = "Wheel Mouse";
 		}
 
 		return PSMOUSE_IMPS;
