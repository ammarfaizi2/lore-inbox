Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbTKIKEs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 05:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTKIKEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 05:04:47 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:27532 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262240AbTKIKEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 05:04:43 -0500
Date: Sun, 9 Nov 2003 11:04:12 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Matt <dirtbird@ntlworld.com>,
       herbert@gondor.apana.org.au,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [MOUSE] Alias for /dev/psaux
Message-ID: <20031109100412.GA12868@ucw.cz>
References: <20031105173907.GA27922@ucw.cz> <Pine.LNX.4.44.0311050942461.11208-100000@home.osdl.org> <20031105180321.GC27922@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20031105180321.GC27922@ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 05, 2003 at 07:03:21PM +0100, Vojtech Pavlik wrote:
> > How about something like this:
> > 
> >  - if "mouse_noext" is set (which implies that we won't be doing any 
> >    probing), we also don't set rate/precision unless the user asked us.
> > 
> >    Thus "psmouse_noext" becomes the "ultra-safe" setting. We still want to 
> >    have some way to set things like wheel etc info by hand later on (ie as
> >    a response to the user _telling_ us what mouse it is), but that's a
> >    more long-range plan.
> > 
> >  - if we do probing, we first ask the mouse for its current details, and 
> >    we restore the thing by default afterwards. That at least should give 
> >    us 2.4.x behaviour unless the mouse is broken (and for broken mice 
> >    you'd just have to have "mouse_noext").
> > 
> >    Again, long-term we'd want to have the possibility of tweaking the 
> >    results later even with the autodetection.
> > 
> > Does that sound like a reasonable plan?
> 
> Yes, it does.

It didn't work out.

The problem is that the psmouse driver always issues the 0xf6 RESET
command as the second command in the command sequence. This is correct,
because we need to disable the mouse input, so that it doesn't collide
with further probing and setup.

The 0xf6 RESET command will initalize the mouse to the default (100
samples/second, 100 dpi, 1:1 mapping) settings.

So there is no point in saving those settings and restoring them later,
when we know what they are already.

Also, in 2.4, the 0xf6 RESET is one of the first commands XFree86 sends
to the mouse, so again, there is no state left from BIOS or powerup
defaults.

XFree86 also sets the mouse to 200dpi, because that's what some mice
need to operate properly (Windows does the same). Most mice ignore that
setting, anyway.

So the attached patch sets the mouse to 100 samples/second, 200 dpi, 1:1
mapping, which is a standard setting, as close to 2.4 XFree86 behavior as
possible, and a good performance setting, too.

It also in the case of 'psmouse_noext' doesn't probe and set anything
all, though it still issues the RESET command. This is as safe as one
can get.

The only real problem remaining is that the report rate and resolution
cannot be set from XFree86 config and only is available as a
kernel/module parameter. The fix is, howewer not 2.6.0 material.

The attached patch, although rather obvious, was tested on most of my
computers and laptops, and works fine.

Please apply it before 2.6.0 ...

Thanks.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mousefix

ChangeSet@1.1396.2.2, 2003-11-09 08:45:56+01:00, vojtech@suse.cz
  input: Always reset PS/2 mouse resolution and update speed to default
         values after probing, if probing for extensions is enabled.


 psmouse-base.c |   23 +++++++----------------
 1 files changed, 7 insertions(+), 16 deletions(-)


diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Sun Nov  9 11:03:54 2003
+++ b/drivers/input/mouse/psmouse-base.c	Sun Nov  9 11:03:54 2003
@@ -36,12 +36,10 @@
 MODULE_PARM_DESC(psmouse_resetafter, "Reset Synaptics Touchpad after so many bad packets (0 = never).");
 MODULE_LICENSE("GPL");
 
-#define PSMOUSE_LOGITECH_SMARTSCROLL	1
-
 static int psmouse_noext;
-int psmouse_resolution;
-unsigned int psmouse_rate;
-int psmouse_smartscroll = PSMOUSE_LOGITECH_SMARTSCROLL;
+int psmouse_resolution = 200;
+unsigned int psmouse_rate = 100;
+int psmouse_smartscroll = 1;
 unsigned int psmouse_resetafter;
 
 static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};
@@ -466,22 +464,15 @@
 {
 	unsigned char param[2];
 	
-
 /*
- * We set the mouse report rate.
+ * We set the mouse report rate, resolution and scaling.
  */
 
-	if (psmouse_rate)
+	if (!psmouse_noext) {
 		psmouse_set_rate(psmouse);
-
-/*
- * We also set the resolution and scaling.
- */
-
-	if (psmouse_resolution)
 		psmouse_set_resolution(psmouse);
-
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
+		psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
+	}
 
 /*
  * We set the mouse into streaming mode.

--TB36FDmn/VVEgNH/--
