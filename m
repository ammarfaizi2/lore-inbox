Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755135AbWKXDVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135AbWKXDVx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 22:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757588AbWKXDVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 22:21:52 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:58784 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1755135AbWKXDVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 22:21:52 -0500
Date: Thu, 23 Nov 2006 22:20:07 -0500
From: linux-kernel@ttuttle.net
Subject: [PATCH] Fixed acpi_video_get_next_level.
To: linux-kernel@vger.kernel.org
Mail-followup-to: linux-kernel@vger.kernel.org
Message-id: <20061124032007.GA17400@lion>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=EeQfGwPcQSOJBaQU
Content-disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I just upgraded the BIOS on my Dell Inspiron e1405 to the latest version
(A05), and the LCD brightness hotkeys stopped working.  It turns out
that the Dell ACPI code was actually sending video notify events to the
kernel, but that the function acpi_video_get_next_level, which was
supposed to choose the new video level, contained simply the phrase "Fix
me" and "return level_current;".

So I did.

Here's a patch that implements acpi_video_get_next_level properly, as
far as I know.  I tried it on this laptop and it works.  It's against
the current linus/linux-2.6.git tree.

I'm a relatively new kernel hacker, so a few gentle whacks with a
clue-by-four are probably necessary, and appreciated.

Signed-off-by: Thomas Tuttle <linux-kernel@ttuttle.net>

Thanks, and hope this helps.

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="acpi_video_get_next_level-fix.patch"

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 56666a9..2fc78ca 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -3,6 +3,7 @@
  *
  *  Copyright (C) 2004 Luming Yu <luming.yu@intel.com>
  *  Copyright (C) 2004 Bruno Ducrot <ducrot@poupinou.org>
+ *  Copyright (C) 2006 Thomas Tuttle <linux-kernel@ttuttle.net>
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
@@ -47,11 +48,11 @@ #define ACPI_VIDEO_NOTIFY_CYCLE		0x82
 #define ACPI_VIDEO_NOTIFY_NEXT_OUTPUT	0x83
 #define ACPI_VIDEO_NOTIFY_PREV_OUTPUT	0x84
 
-#define ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS	0x82
-#define	ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS	0x83
-#define ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS	0x84
-#define ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS	0x85
-#define ACPI_VIDEO_NOTIFY_DISPLAY_OFF		0x86
+#define ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS	0x85
+#define	ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS	0x86
+#define ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS	0x87
+#define ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS	0x88
+#define ACPI_VIDEO_NOTIFY_DISPLAY_OFF		0x89
 
 #define ACPI_VIDEO_HEAD_INVALID		(~0u - 1)
 #define ACPI_VIDEO_HEAD_END		(~0u)
@@ -1509,8 +1510,30 @@ static int
 acpi_video_get_next_level(struct acpi_video_device *device,
 			  u32 level_current, u32 event)
 {
-	/*Fix me */
-	return level_current;
+	int min, max, min_above, max_below, i, l;
+	max = max_below = 0;
+	min = min_above = 255;
+	for (i = 0; i < device->brightness->count; i++) {
+		l = device->brightness->levels[i];
+		if (l < min) min = l;
+		if (l > max) max = l;
+		if (l < min_above && l > level_current) min_above = l;
+		if (l > max_below && l < level_current) max_below = l;
+	}
+
+	switch (event) {
+	case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS:
+		return (level_current < max) ? min_above : min;
+	case ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS:
+		return (level_current < max) ? min_above : max;
+	case ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS:
+		return (level_current > min) ? max_below : min;
+	case ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS:
+	case ACPI_VIDEO_NOTIFY_DISPLAY_OFF:
+		return 0;
+	default:
+		return level_current;
+	}
 }
 
 static void

--EeQfGwPcQSOJBaQU--
