Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263144AbVCDXIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbVCDXIL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263404AbVCDXFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:05:04 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:9104 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S263226AbVCDVMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:12:42 -0500
Date: Fri, 4 Mar 2005 22:13:27 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Benoit Boissinot <bboissin@gmail.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: New ALPS code in -mm
Message-ID: <20050304211327.GA5636@ucw.cz>
References: <Pine.LNX.4.62.0502241822310.8449@light.int.webcon.net> <200502242208.16065.dtor_core@ameritech.net> <20050227075041.GA1722@ucw.cz> <Pine.LNX.4.62.0502281721210.21033@light.int.webcon.net> <422454A5.7070206@blue-labs.org> <20050301115432.GA5598@ucw.cz> <40f323d005030413024d71e3f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f323d005030413024d71e3f9@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 10:02:03PM +0100, Benoit Boissinot wrote:
> On Tue, 1 Mar 2005 12:54:32 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > 
> > Can you check with a current -mm kernel whether any of the issues is
> > still there? Everything seems to work smoothly with my ALPS.
> > 
> 
> I have problems with ALPS and 2.6.11-mm1. If I move the pointer with
> the touchpad, it activates button modifiers at the same time. (xev
> reports a MotionNotify event with state = 0x600 or sometimes 0x200
> instead of the expected 0x0).
> 
> Moreover the pointer sometimes jump at the bottom right of the screen.
> 
> It worked fine with 2.6.11-rc5-mm1.
> 
> relevant portion of dmesg:
> 
> - with rc5:
> 
> Linux version 2.6.11-rc5-mm1 (tonfa@casaverde) (gcc version
> 3.4.3-20050110 (Gentoo Linux 3.                4.3.20050110,
> ssp-3.4.3.20050110-0, pie-8.7.7)) #2 Tue Mar 1 13:33:05 CET 2005
> input: AT Translated Set 2 keyboard on isa0060/serio0
> ALPS Touchpad (Dualpoint) detected
> Enabling hardware tapping
> input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
> 
> - with .11
> 
> Linux version 2.6.11-mm1 (tonfa@casaverde) (gcc version 3.4.3-20050110
> (Gentoo Linux 3.4.3.                20050110, ssp-3.4.3.20050110-0,
> pie-8.7.7)) #5 Fri Mar 4 16:49:47 CET 2005
> input: AT Translated Set 2 keyboard on isa0060/serio0
>    Enabling hardware tapping
> input: DualPoint Stick on isa0060/serio1
> input: AlpsPS/2 ALPS DualPoint TouchPad on isa0060/serio1
> 
> I hope it can help.

Can you check if this patch helps?


ChangeSet@1.2068.1.2, 2005-03-04 20:19:05+01:00, vojtech@suse.cz
  input: Fix inverted conditions in ALPS DualPoint stick packet
         decoding.
ChangeSet@1.2072, 2005-03-04 21:55:23+01:00, vojtech@suse.cz
  input: Fix ALPS DualPoint stick buttons. Testing shows that they're
         at the same place as the pad ones, but packet has z==127.
  
 alps.c |   26 +++++++++---------------
 1 files changed, 10 insertions(+), 16 deletions(-)


diff -Nru a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
--- a/drivers/input/mouse/alps.c	2005-03-04 22:00:33 +01:00
+++ b/drivers/input/mouse/alps.c	2005-03-04 22:00:33 +01:00
@@ -124,8 +124,8 @@
 
 		/* Relative movement packet */
  		if (z == 127) {
-			input_report_rel(dev2, REL_X,  (x > 383 ? x : (x - 768)));
-			input_report_rel(dev2, REL_Y, -(y > 255 ? y : (x - 512)));
+			input_report_rel(dev2, REL_X,  (x > 383 ? (x - 768) : x));
+			input_report_rel(dev2, REL_Y, -(y > 255 ? (x - 512) : y));
 			input_sync(dev2);
 			return;
 		}
diff -Nru a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
--- a/drivers/input/mouse/alps.c	2005-03-04 22:00:49 +01:00
+++ b/drivers/input/mouse/alps.c	2005-03-04 22:00:49 +01:00
@@ -115,20 +115,14 @@
 	ges = packet[2] & 1;
 	fin = packet[2] & 2;
 
-	/* Dualpoint has stick buttons in byte 0 */
-	if (priv->i->flags & ALPS_DUALPOINT) {
-	
-		input_report_key(dev2, BTN_LEFT,    packet[0]       & 1);    
-		input_report_key(dev2, BTN_MIDDLE, (packet[0] >> 2) & 1);
-		input_report_key(dev2, BTN_RIGHT,  (packet[0] >> 1) & 1);
-
-		/* Relative movement packet */
- 		if (z == 127) {
-			input_report_rel(dev2, REL_X,  (x > 383 ? (x - 768) : x));
-			input_report_rel(dev2, REL_Y, -(y > 255 ? (x - 512) : y));
-			input_sync(dev2);
-			return;
-		}
+	if ((priv->i->flags & ALPS_DUALPOINT) && z == 127) {
+		input_report_key(dev2, BTN_LEFT,   left);    
+		input_report_key(dev2, BTN_RIGHT,  right);
+		input_report_key(dev2, BTN_MIDDLE, middle);
+		input_report_rel(dev2, REL_X,  (x > 383 ? (x - 768) : x));
+		input_report_rel(dev2, REL_Y, -(y > 255 ? (x - 512) : y));
+		input_sync(dev2);
+		return;
 	}
 
 	/* Convert hardware tap to a reasonable Z value */

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
