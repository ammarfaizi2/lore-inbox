Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbUBWBBx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 20:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbUBWBBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 20:01:49 -0500
Received: from gate.crashing.org ([63.228.1.57]:25776 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261301AbUBWBAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 20:00:17 -0500
Subject: fbdv/fbcon pending problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077497593.5960.28.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 23 Feb 2004 11:53:14 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Here's a list of pending issues with fbdev (either upstream or in the
fbdev bk treee), I figured posting it here may help getting more people
on those issues as my time is sparse and I suppose James too.

 - First one, I will deal with, just writing it for completeness: When
switching from KD_GRAPHICS to KD_TEXT (either same console changing mode
or switching to a different console), we need a callback so the fbdev
has a chance to restore the accel engine setting (or even the whole
mode, to be safe).

 - Memory corruption problems. There is still at least one identified
when using stty. Just use crazy values, like flipping rows & cols (like
stty rows 132 cols 30) and usually, you'll see the box blow up very soon
with heavy memory corruption.

 - mach64 lockups on LT-G (I'll try on an LT-Pro soon) plus other
mach64 bugs in the new version in the bk fbdev, I'll have a patch for
some of the problems, but I didn't find a good explanation for the
accel lockups yet

 - Logo problems. When booting with a logo, then going to getty, the
logo doesn't get erased until we actually switch to another console (or
reset the console). At this point, using things like vi & scrolling up
doesn't work properly. Actually, last time I tried, I had to switch
back & forth twice before my console that had the logo got fully working
with vi.

 - Back buffer problem: maybe related to the logo ? After boot, doing
shift-pageup to go back to the boot message, usually you get crap
displayed at various places.

 - On x86, various junk displayed when the fbdev takes over. Reported
by radeonfb users, I couldn't test myself, I don't have an x86 with
radeon at hand for the moment. Apparently, the takeover from vgacon
doesn't properly "convert" the previous VGA text buffer content

 - stty & mode picking. Currently, fbcon_resize() (called when stty is
used to resize the console) will hack a "var" strcture by just putting
new width/height in it and pass that to set_var. The way the various
drivers react to that mostly broken "var" structure is rather random.
We need to explicitely differenciate between a mode that is "complete"
(like what fbset or X passes down the fbdev) or a mode that is just
width/height and eventually a hint of frequency, like what fbcon passes
in this case. I added FB_ACTIVATE_FIND for that purpose, but that needs
better driver support to "pick" up a proper mode. The algorithm for
that isn't trivial. Could be moved to common code.

 - fbset doesn't resize the console. I consider that a regression from
2.4. I have some code based on the notification mecanism to address
that, but it tends to trigger the same memory corruption problem as
reported with stty & bogus coordinates. There is something hairy going
on with console resizes. That code is a bit foreign to me though.

Ok, that's all that comes to my mind right now, help is welcome :)

Ben.


