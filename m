Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161429AbWJKVSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161429AbWJKVSV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161432AbWJKVId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:08:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:31650 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161429AbWJKVIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:08:13 -0400
Date: Wed, 11 Oct 2006 14:07:27 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, olaf@aepfle.de, daniel.thompson@st.com,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       "Antonino A. Daplas" <adaplas@pol.net>, Jon Smirl <jonsmirl@gmail.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 43/67] backlight: fix oops in __mutex_lock_slowpath during head /sys/class/graphics/fb0/bits_per_pixel /sys/class/graphics/fb0/blank /sys/class/graphics/fb0/console /sys/class/graphics/fb0/cursor /sys/class/graphics/fb0/dev /sys/class/graphics/fb0/device /sys/class/graphics/fb0/mode /sys/class/graphics/fb0/modes /sys/class/graphics/fb0/name /sys/class/graphics/fb0/pan /sys/class/graphics/fb0/rotate /sys/class/graphics/fb0/state /sys/class/graphics/fb0/stride /sys/class/graphics/fb0/subsystem /sys/class/graphics/fb0/uevent /sys/class/graphics/fb0/virtual_size
Message-ID: <20061011210727.GR16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="backlight-fix-oops-in-__mutex_lock_slowpath-during-head-sys-class-graphics-fb0.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Michael Hanselmann <linux-kernel@hansmi.ch>

Seems like not all drivers use the framebuffer_alloc() function and won't
have an initialized mutex.  But those don't have a backlight, anyway.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: Olaf Hering <olaf@aepfle.de>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Cc: Daniel R Thompson <daniel.thompson@st.com>
Cc: Jon Smirl <jonsmirl@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/video/fbsysfs.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- linux-2.6.18.orig/drivers/video/fbsysfs.c
+++ linux-2.6.18/drivers/video/fbsysfs.c
@@ -397,6 +397,12 @@ static ssize_t store_bl_curve(struct cla
 	u8 tmp_curve[FB_BACKLIGHT_LEVELS];
 	unsigned int i;
 
+	/* Some drivers don't use framebuffer_alloc(), but those also
+	 * don't have backlights.
+	 */
+	if (!fb_info || !fb_info->bl_dev)
+		return -ENODEV;
+
 	if (count != (FB_BACKLIGHT_LEVELS / 8 * 24))
 		return -EINVAL;
 
@@ -430,6 +436,12 @@ static ssize_t show_bl_curve(struct clas
 	ssize_t len = 0;
 	unsigned int i;
 
+	/* Some drivers don't use framebuffer_alloc(), but those also
+	 * don't have backlights.
+	 */
+	if (!fb_info || !fb_info->bl_dev)
+		return -ENODEV;
+
 	mutex_lock(&fb_info->bl_mutex);
 	for (i = 0; i < FB_BACKLIGHT_LEVELS; i += 8)
 		len += snprintf(&buf[len], PAGE_SIZE,

--
