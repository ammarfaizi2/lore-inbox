Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbVCVGcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbVCVGcQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 01:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVCVG2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 01:28:54 -0500
Received: from fire.osdl.org ([65.172.181.4]:42982 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262337AbVCVGZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 01:25:38 -0500
Date: Mon, 21 Mar 2005 22:25:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.11-rc4: Alps touchpad too slow
Message-Id: <20050321222514.7f98e255.akpm@osdl.org>
In-Reply-To: <20050322061336.GA2809@hexapodia.org>
References: <20050304221523.GA32685@hexapodia.org>
	<20050321144412.5e6d9398.akpm@osdl.org>
	<20050322061336.GA2809@hexapodia.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson <adi@hexapodia.org> wrote:
>
> On Mon, Mar 21, 2005 at 02:44:12PM -0800, Andrew Morton wrote:
> > Andy Isaacson <adi@hexapodia.org> wrote:
> > > My Vaio r505te comes up with an unusably slow touchpad if I allow the
> > > ALPS driver to drive it.  It says
> > > 
> > > > ALPS Touchpad (Glidepoint) detected
> > > >   Disabling hardware tapping
> > > > input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
> > > 
> > > and then the trackpad operates at about 1/8 the speed I've gotten used
> > > to. ...  2.6.11-rc4 ...
> > 
> > Andy, could you please test 2.6.12-rc1 and let us know which problems
> > remain?
> 
> With cvsbk rev 423b66b6oJOGN68OhmSrBFxxLOtIEA (rsynced Monday, it claims
> to be "2.6.12-rc1"), the situation is much improved.  The AlpsPS/2
> driver recognizes the trackpad, tracking speed is back to normal, and
> tapping is turned on by default.  (Drat, now I need to figure out how to
> turn that off again.)

Wonderful, thanks.

> The kernel output is a bit odd, though:
> 
> [ 1200.254707] Adding 987988k swap on /dev/hda3.  Priority:-1 extents:1
> [ 1200.330453] EXT3 FS on hda2, internal journal
> [ 1203.504154] SCSI subsystem initialized
> [ 1204.039053]   Enabling hardware tapping
> [ 1204.099034] ieee1394: Initialized config rom entry `ip1394'
> [ 1204.266077] input: PS/2 Mouse on isa0060/serio1
> [ 1204.400583] input: AlpsPS/2 ALPS GlidePoint on isa0060/serio1
> [ 1204.779799] sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
> [ 1206.183165] kjournald starting.  Commit interval 5 seconds
> 
> Note how the "Enabling hardware tapping" message is several lines
> earlier than it seems it should be... I don't think I'm supposed to be
> tapping on my SCSI hardware.
> 
> ... ah, I think I'm missing the "ALPS GlidePoint detected" message which
> I used to get.  Without it, the "Enabling hardware tapping" message is a
> bit opaque.

Yes, alps_init() had a printk removed and now the output looks funny.



diff -puN drivers/input/mouse/alps.c~alps-printk-tidy drivers/input/mouse/alps.c
--- 25/drivers/input/mouse/alps.c~alps-printk-tidy	2005-03-21 22:23:46.000000000 -0800
+++ 25-akpm/drivers/input/mouse/alps.c	2005-03-21 22:23:53.000000000 -0800
@@ -395,7 +395,7 @@ int alps_init(struct psmouse *psmouse)
 	}
 
 	if (param[0] & 0x04) {
-		printk(KERN_INFO "  Enabling hardware tapping\n");
+		printk(KERN_INFO "alps.c: Enabling hardware tapping\n");
 		if (alps_tap_mode(psmouse, 1))
 			printk(KERN_WARNING "alps.c: Failed to enable hardware tapping\n");
 	}
_

