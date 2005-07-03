Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVGCXwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVGCXwk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 19:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVGCXwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 19:52:40 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:1260 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261580AbVGCXwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 19:52:34 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ALPS: fix enabling hardware tapping
References: <200506150138.49880.dtor_core@ameritech.net>
	<m3slyw6reu.fsf@telia.com> <20050703203401.GA3733@ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 04 Jul 2005 01:28:06 +0200
In-Reply-To: <20050703203401.GA3733@ucw.cz>
Message-ID: <m3vf3rlbax.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Sun, Jul 03, 2005 at 01:49:13PM +0200, Peter Osterlund wrote:
> > Dmitry Torokhov <dtor_core@ameritech.net> writes:
> > 
> > > It looks like logic for enabling hardware tapping in ALPS driver was
> > > inverted and we enable it only if it was already enabled by BIOS or
> > > firmware.
> > 
> > It looks like alps_init() has the same bug.  This patch fixes that
> > function too by moving the check if the tapping mode needs to change
> > into the alps_tap_mode() function, so that the test doesn't have to be
> > duplicated.
> 
> This looks good. However - what's the point in checking whether tapping
> is enabled before enabling it?

I don't think there is a point. IFAIK this code was added by Dmitry as
part of the hardware auto-detection changes. In that version the check
prevented a printk line when the touchpad was already in the correct
state. That printk is deleted anyway by this patch, so the check can
be removed. (Modulo weird hardware behavior, which can't be completely
ruled out because the driver is based largely on reverse engineering,
since no public docs are available.)

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/input/mouse/alps.c |   22 ++++------------------
 1 files changed, 4 insertions(+), 18 deletions(-)

diff -puN drivers/input/mouse/alps.c~alps-hwtaps-fix drivers/input/mouse/alps.c
--- linux/drivers/input/mouse/alps.c~alps-hwtaps-fix	2005-07-03 13:42:47.000000000 +0200
+++ linux-petero/drivers/input/mouse/alps.c	2005-07-03 23:50:06.000000000 +0200
@@ -2,7 +2,7 @@
  * ALPS touchpad PS/2 mouse driver
  *
  * Copyright (c) 2003 Neil Brown <neilb@cse.unsw.edu.au>
- * Copyright (c) 2003 Peter Osterlund <petero2@telia.com>
+ * Copyright (c) 2003-2005 Peter Osterlund <petero2@telia.com>
  * Copyright (c) 2004 Dmitry Torokhov <dtor@mail.ru>
  * Copyright (c) 2005 Vojtech Pavlik <vojtech@suse.cz>
  *
@@ -350,7 +350,6 @@ static int alps_tap_mode(struct psmouse 
 static int alps_reconnect(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
-	unsigned char param[4];
 	int version;
 
 	psmouse_reset(psmouse);
@@ -361,11 +360,7 @@ static int alps_reconnect(struct psmouse
 	if (priv->i->flags & ALPS_PASS && alps_passthrough_mode(psmouse, 1))
 		return -1;
 
-	if (alps_get_status(psmouse, param))
-		return -1;
-
-	if (!(param[0] & 0x04))
-		alps_tap_mode(psmouse, 1);
+	alps_tap_mode(psmouse, 1);
 
 	if (alps_absolute_mode(psmouse)) {
 		printk(KERN_ERR "alps.c: Failed to enable absolute mode\n");
@@ -389,7 +384,6 @@ static void alps_disconnect(struct psmou
 int alps_init(struct psmouse *psmouse)
 {
 	struct alps_data *priv;
-	unsigned char param[4];
 	int version;
 
 	psmouse->private = priv = kmalloc(sizeof(struct alps_data), GFP_KERNEL);
@@ -403,16 +397,8 @@ int alps_init(struct psmouse *psmouse)
 	if ((priv->i->flags & ALPS_PASS) && alps_passthrough_mode(psmouse, 1))
 		goto init_fail;
 
-	if (alps_get_status(psmouse, param)) {
-		printk(KERN_ERR "alps.c: touchpad status report request failed\n");
-		goto init_fail;
-	}
-
-	if (param[0] & 0x04) {
-		printk(KERN_INFO "alps.c: Enabling hardware tapping\n");
-		if (alps_tap_mode(psmouse, 1))
-			printk(KERN_WARNING "alps.c: Failed to enable hardware tapping\n");
-	}
+	if (alps_tap_mode(psmouse, 1))
+		printk(KERN_WARNING "alps.c: Failed to enable hardware tapping\n");
 
 	if (alps_absolute_mode(psmouse)) {
 		printk(KERN_ERR "alps.c: Failed to enable absolute mode\n");
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
