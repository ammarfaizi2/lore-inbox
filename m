Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751640AbWIUV4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbWIUV4X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbWIUV4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:56:23 -0400
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:33053 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1751640AbWIUV4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:56:22 -0400
Date: Thu, 21 Sep 2006 23:56:20 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: olaf@aepfle.de
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       "Antonino A. Daplas" <adaplas@pol.net>,
       Daniel R Thompson <daniel.thompson@st.com>,
       Jon Smirl <jonsmirl@gmail.com>, akpm@osdl.org
Subject: Re: backlight: oops in __mutex_lock_slowpath during head /sys/class/graphics/fb0/* in 2.6.18
Message-ID: <20060921215620.GA9518@hansmi.ch>
References: <20060921121952.GA16927@aepfle.de> <20060921123742.ec225cc2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921123742.ec225cc2.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 12:37:42PM -0700, Andrew Morton wrote:
> On Thu, 21 Sep 2006 14:19:52 +0200
> Olaf Hering <olaf@aepfle.de> wrote:
> > The bl_curve code has some room for improvement.

Agreed.

> > inst-sys:~ # dmesg
> > valkyriefb: vmode 13 does not support cmode 1.
> > Unable to handle kernel paging request for data at address 0x00000000
> > Faulting instruction address: 0xc02c7bd8

Seems like not all drivers use the framebuffer_alloc() function and
won't have an initialized mutex. But those don't have a backlight,
anyway.

What about the patch below? Does it work for you?

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>

---
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18.orig/drivers/video/fbsysfs.c linux-2.6.18/drivers/video/fbsysfs.c
--- linux-2.6.18.orig/drivers/video/fbsysfs.c	2006-09-21 23:40:06.000000000 +0200
+++ linux-2.6.18/drivers/video/fbsysfs.c	2006-09-21 23:50:00.000000000 +0200
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
