Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVAGWWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVAGWWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVAGWTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:19:03 -0500
Received: from av3-1-sn4.m-sp.skanova.net ([81.228.10.114]:52403 "EHLO
	av3-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261653AbVAGWRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:17:14 -0500
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor_core@ameritech.net>,
       Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ALPS touchpad detection fix
References: <m3wtuqxzue.fsf@telia.com>
	<200501071928.32096.vda@port.imtp.ilyichevsk.odessa.ua>
From: Peter Osterlund <petero2@telia.com>
Date: 07 Jan 2005 23:17:03 +0100
In-Reply-To: <200501071928.32096.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <m3zmzk28bk.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:

> On Thursday 06 January 2005 18:54, Peter Osterlund wrote:
> > My ALPS touchpad is not recognized because the device gets confused by
> > the Kensington ThinkingMouse probe.  It responds with "00 00 14"
> > instead of the expected "00 00 64" to the "E6 report".
> > 
> > Resetting the device before attempting the ALPS probe fixes the
> > problem.
> > 
...
> >  /*
> >   * Try ALPS TouchPad
> >   */
> > +	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
> >  	if (max_proto > PSMOUSE_IMEX && alps_detect(psmouse, set_properties) == 0) {
> >  		if (!set_properties || alps_init(psmouse) == 0)
> >  			return PSMOUSE_ALPS;
> 
> You do reset even if max_proto <= PSMOUSE_IMEX and therefore
> alps_detect won't be called. Is it intended?

Not really intended. (It shouldn't harm though because the
mouse/touchpad is reset anyway before the IntelliMouse probe.)

Here is an updated patch that only does the reset when alps_detect()
is going to be called.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/input/mouse/psmouse-base.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff -puN drivers/input/mouse/psmouse-base.c~alps-fix drivers/input/mouse/psmouse-base.c
--- linux/drivers/input/mouse/psmouse-base.c~alps-fix	2005-01-06 22:43:28.000000000 +0100
+++ linux-petero/drivers/input/mouse/psmouse-base.c	2005-01-07 22:51:45.000000000 +0100
@@ -451,14 +451,16 @@ static int psmouse_extensions(struct psm
 /*
  * Try ALPS TouchPad
  */
-	if (max_proto > PSMOUSE_IMEX && alps_detect(psmouse, set_properties) == 0) {
-		if (!set_properties || alps_init(psmouse) == 0)
-			return PSMOUSE_ALPS;
-
+	if (max_proto > PSMOUSE_IMEX) {
+		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
+		if (alps_detect(psmouse, set_properties) == 0) {
+			if (!set_properties || alps_init(psmouse) == 0)
+				return PSMOUSE_ALPS;
 /*
  * Init failed, try basic relative protocols
  */
-		max_proto = PSMOUSE_IMEX;
+			max_proto = PSMOUSE_IMEX;
+		}
 	}
 
 	if (max_proto > PSMOUSE_IMEX && genius_detect(psmouse, set_properties) == 0)
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
