Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934519AbWKXI7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934519AbWKXI7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 03:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934521AbWKXI7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 03:59:18 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26032 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S934519AbWKXI7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 03:59:17 -0500
Date: Fri, 24 Nov 2006 09:59:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@osdl.org>
Subject: s2ram debugging documentation
Message-ID: <20061124085900.GA5081@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus posted quite nice TRACE_RESUME how-to, and I think it is too
nice to be hidden in archives of mailing list, so I turned it into
Documentation piece.

Signed-off-by: Pavel Machek <pavel@suse.cz>

Add linus' how-to-get s2ram to work.

---
commit 10ef1d7d246e5d041eeb076f045dd21167311324
tree a5deed96319360e4e1f4982d4a6574f23a4dfe23
parent b6be65f0eb2ba9a7d2c8cef7a7af9ae481fe3ec9
author Pavel <pavel@amd.ucw.cz> Fri, 24 Nov 2006 09:57:12 +0100
committer Pavel <pavel@amd.ucw.cz> Fri, 24 Nov 2006 09:57:12 +0100

 Documentation/power/s2ram.txt |   56 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/Documentation/power/s2ram.txt b/Documentation/power/s2ram.txt
new file mode 100644
index 0000000..50dce18
--- /dev/null
+++ b/Documentation/power/s2ram.txt
@@ -0,0 +1,56 @@
+			How to get s2ram working
+			~~~~~~~~~~~~~~~~~~~~~~~~
+			2006 Linus Torvalds
+			2006 Pavel Machek
+
+1) Check suspend.sf.net, program s2ram there has long whitelist of
+   "known ok" machines, along with tricks to use on each one.
+
+2) If that does not help, try reading tricks.txt and
+   video.txt. Perhaps problem is as simple as broken module, and
+   simple module unload can fix it.
+
+3) You can use Linus' TRACE_RESUME infrastructure, described below.
+
+		      Using TRACE_RESUME
+		      ~~~~~~~~~~~~~~~~~~
+
+I've been working at making the machines I have able to STR, and almost 
+always it's a driver that is buggy. Thank God for the suspend/resume 
+debugging - the thing that Chuck tried to disable. That's often the _only_ 
+way to debug these things, and it's actually pretty powerful (but 
+time-consuming - having to insert TRACE_RESUME() markers into the device 
+driver that doesn't resume and recompile and reboot).
+
+Anyway, the way to debug this for people who are interested (have a 
+machine that doesn't boot) is:
+
+ - enable PM_DEBUG, and PM_TRACE
+
+ - use a script like this:
+
+	#!/bin/sh
+	sync
+	echo 1 > /sys/power/pm_trace
+	echo mem > /sys/power/state
+
+   to suspend
+
+ - if it doesn't come back up (which is usually the problem), reboot by 
+   holding the power button down, and look at the dmesg output for things 
+   like
+
+	Magic number: 4:156:725
+	hash matches drivers/base/power/resume.c:28
+	hash matches device 0000:01:00.0
+
+   which means that the last trace event was just before trying to resume 
+   device 0000:01:00.0. Then figure out what driver is controlling that 
+   device (lspci and /sys/devices/pci* is your friend), and see if you can 
+   fix it, disable it, or trace into its resume function.
+
+For example, the above happens to be the VGA device on my EVO, which I 
+used to run with "radeonfb" (it's an ATI Radeon mobility). It turns out 
+that "radeonfb" simply cannot resume that device - it tries to set the 
+PLL's, and it just _hangs_. Using the regular VGA console and letting X 
+resume it instead works fine.


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
