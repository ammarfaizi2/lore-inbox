Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWCAM4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWCAM4j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 07:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWCAM4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 07:56:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35544 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750954AbWCAM4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 07:56:38 -0500
Date: Wed, 1 Mar 2006 13:54:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       seife@suse.de
Subject: [patch] add s2ram pointer to suspend documentation
Message-ID: <20060301125427.GB2054@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Put a pointer to s2ram tool into documentation instead of shell
scripts -- s2ram knows how to switch consoles and should work on more
systems. Whitelist updates.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit e2b385438d8e9711729b4bf075f58db3e1279fde
tree c1d264aaf9b476d6683a52061149540c2e46cfbe
parent 3f517362fe48428b9a9cb4e251238c1abd2d61c2
author <pavel@amd.ucw.cz> Wed, 01 Mar 2006 13:53:30 +0100
committer <pavel@amd.ucw.cz> Wed, 01 Mar 2006 13:53:30 +0100

 Documentation/power/video.txt |   62 +++++++++++++++--------------------------
 1 files changed, 22 insertions(+), 40 deletions(-)

diff --git a/Documentation/power/video.txt b/Documentation/power/video.txt
index dca46e5..9c64350 100644
--- a/Documentation/power/video.txt
+++ b/Documentation/power/video.txt
@@ -1,7 +1,7 @@
 
 		Video issues with S3 resume
 		~~~~~~~~~~~~~~~~~~~~~~~~~~~
-		  2003-2005, Pavel Machek
+		  2003-2006, Pavel Machek
 
 During S3 resume, hardware needs to be reinitialized. For most
 devices, this is easy, and kernel driver knows how to do
@@ -15,6 +15,27 @@ run normally so video card is normally i
 problem for S1 standby, because hardware should retain its state over
 that.
 
+We either have to run video BIOS during early resume, or interpret it
+using vbetool later, or maybe nothing is neccessary on particular
+system because video state is preserved. Unfortunately different
+methods work on different systems, and no known method suits all of
+them.
+
+Userland application called s2ram has been developed; it contains long
+whitelist of systems, and automatically selects working method for a
+given system. It can be downloaded from CVS at
+www.sf.net/projects/suspend . If you get a system that is not in the
+whitelist, please try to find a working solution, and submit whitelist
+entry so that work does not need to be repeated.
+
+Currently, VBE_SAVE method (6 below) works on most
+systems. Unfortunately, vbetool only runs after userland is resumed,
+so it makes debugging of early resume problems
+hard/impossible. Methods that do not rely on userland are preferable.
+
+Details
+~~~~~~~
+
 There are a few types of systems where video works after S3 resume:
 
 (1) systems where video state is preserved over S3.
@@ -161,42 +182,3 @@ Asus A7V8X	    nVidia RIVA TNT2 model 64
 (***) To be tested with a newer kernel.
 
 (****) Not with SMP kernel, UP only.
-
-VBEtool details
-~~~~~~~~~~~~~~~
-(with thanks to Carl-Daniel Hailfinger)
-
-This is not a generic solution. For some machines, you'll have better
-luck with setting parameters on kernel command line.
-
-First, boot into X and run the following script ONCE:
-#!/bin/bash
-statedir=/root/s3/state
-mkdir -p $statedir
-chvt 2
-sleep 1
-vbetool vbestate save >$statedir/vbe
-
-
-To suspend and resume properly, call the following script as root:
-#!/bin/bash
-statedir=/root/s3/state
-curcons=`fgconsole`
-fuser /dev/tty$curcons 2>/dev/null|xargs ps -o comm= -p|grep -q X && chvt 2
-cat /dev/vcsa >$statedir/vcsa
-sync
-echo 3 >/proc/acpi/sleep
-sync
-vbetool post
-vbetool vbestate restore <$statedir/vbe
-cat $statedir/vcsa >/dev/vcsa
-rckbd restart
-chvt $[curcons%6+1]
-chvt $curcons
-
-
-Unless you change your graphics card or other hardware configuration,
-the state once saved will be OK for every resume afterwards.
-NOTE: The "rckbd restart" command may be different for your
-distribution. Simply replace it with the command you would use to
-set the fonts on screen.

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
