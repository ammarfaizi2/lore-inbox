Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbUCRV64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 16:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbUCRV64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 16:58:56 -0500
Received: from ip-213-226-226-138.ji.cz ([213.226.226.138]:37249 "HELO
	machine.sinus.cz") by vger.kernel.org with SMTP id S262991AbUCRV5Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 16:57:16 -0500
Date: Thu, 18 Mar 2004 22:57:13 +0100
From: Petr Baudis <pasky@ucw.cz>
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH 2.6] fbcon font cloning fix
Message-ID: <20040318215713.GA3779@pasky.ji.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  this patch (against 2.6.4) fixes a bug which I hit when migrating from 2.4.
Basically, when I do setfont during the system boot, the then-spawned ttys do
not retain the new font but fall back to the default one.

  I've tracked that down to a clearly bogus test in fbcon_set_display(),
because vc->vc_font.width is not set at that time yet (no font has been loaded
for the new vc). But even if it would (or this was meant to test against
tmp->vc_font.width), it would mean only *HUGE* fonts would be retained.  And
even if there were *two* bugs there and it was supposed to be less-than there,
I couldn't make a sense of the test.

  Please consider applying.

 drivers/video/console/fbcon.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

  Kind regards,
                                Petr Baudis

diff -rup linux/drivers/video/console/fbcon.c linux+pasky/drivers/video/console/fbcon.c
--- linux/drivers/video/console/fbcon.c	Thu Mar 18 22:14:28 2004
+++ linux+pasky/drivers/video/console/fbcon.c	Thu Mar 18 21:32:01 2004
@@ -746,19 +746,17 @@ static void fbcon_set_display(struct vc_
 		struct display *q = &fb_display[i];
 		struct vc_data *tmp = vc_cons[i].d;
 		
-		if (vc->vc_font.width > 32) {
-			/* If we are not the first console on this
-			   fb, copy the font from that console */
-			vc->vc_font.width = tmp->vc_font.width;
-			vc->vc_font.height = tmp->vc_font.height;
-			vc->vc_font.data = p->fontdata = q->fontdata;
-			p->userfont = q->userfont;
-			if (p->userfont) {
-				REFCOUNT(p->fontdata)++;
-				charcnt = FNTCHARCNT(p->fontdata);
-			}
-			con_copy_unimap(vc->vc_num, i);
+		/* If we are not the first console on this
+		   fb, copy the font from that console */
+		vc->vc_font.width = tmp->vc_font.width;
+		vc->vc_font.height = tmp->vc_font.height;
+		vc->vc_font.data = p->fontdata = q->fontdata;
+		p->userfont = q->userfont;
+		if (p->userfont) {
+			REFCOUNT(p->fontdata)++;
+			charcnt = FNTCHARCNT(p->fontdata);
 		}
+		con_copy_unimap(vc->vc_num, i);
 	}
 
 	if (!p->fontdata) {
