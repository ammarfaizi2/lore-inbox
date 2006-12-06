Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937018AbWLFSO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937018AbWLFSO2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937025AbWLFSO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:14:28 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:28637 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937021AbWLFSO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:14:26 -0500
Date: Wed, 6 Dec 2006 10:14:34 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Miguel Ojeda <maxextreme@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Luming Yu <Luming.yu@intel.com>, Andrew Zabolotny <zap@homelink.ru>,
       linux-acpi@vger.kernel.org, kernel-discuss@handhelds.org
Subject: Re: Display class
Message-Id: <20061206101434.8acb229a.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0612061443180.28745@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
	<653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
	<Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
	<Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org>
	<20061205171401.fd11160d.randy.dunlap@oracle.com>
	<Pine.LNX.4.64.0612061443180.28745@pentafluge.infradead.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 15:10:44 +0000 (GMT) James Simmons wrote:

> 
> > > of Mr. Yu for acpi. Also this class could in time replace the lcd class 
> > > located in the backlight directory since a lcd is a type of display.
> > > The final hope is that the purpose auxdisplay could fall under this 
> > > catergory.
> > > 
> > > P.S
> > >    I know the edid parsing would have to be pulled out of the fbdev layer.
> 
> That patch was rought draft for feedback. I applied your comments. This 
> patch actually works. It includes my backlight fix as well.

Glad to hear it.  I had to make the following changes
in order for it to build.
However, I still have build errors for aty.

---
From: Randy Dunlap <randy.dunlap@oracle.com>

Replace CONFIG_FB_BACKLIGHT with CONFIG_BACKLIGHT_CLASS_DEVICE
in include/linux/fb.h and drivers/video/fbsysfs.c
to match Kconfig changes.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/video/fbsysfs.c |    8 ++++----
 include/linux/fb.h      |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.19-git7.orig/include/linux/fb.h
+++ linux-2.6.19-git7/include/linux/fb.h
@@ -367,7 +367,7 @@ struct fb_cursor {
 	struct fb_image	image;	/* Cursor image */
 };
 
-#ifdef CONFIG_FB_BACKLIGHT
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 /* Settings for the generic backlight code */
 #define FB_BACKLIGHT_LEVELS	128
 #define FB_BACKLIGHT_MAX	0xFF
@@ -759,7 +759,7 @@ struct fb_info {
 	struct list_head modelist;      /* mode list */
 	struct fb_videomode *mode;	/* current mode */
 
-#ifdef CONFIG_FB_BACKLIGHT
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 	/* Lock ordering:
 	 * bl_mutex (protects bl_dev and bl_curve)
 	 *   bl_dev->sem (backlight class)
--- linux-2.6.19-git7.orig/drivers/video/fbsysfs.c
+++ linux-2.6.19-git7/drivers/video/fbsysfs.c
@@ -58,7 +58,7 @@ struct fb_info *framebuffer_alloc(size_t
 
 	info->device = dev;
 
-#ifdef CONFIG_FB_BACKLIGHT
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 	mutex_init(&info->bl_mutex);
 #endif
 
@@ -411,7 +411,7 @@ static ssize_t show_fbstate(struct devic
 	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->state);
 }
 
-#ifdef CONFIG_FB_BACKLIGHT
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 static ssize_t store_bl_curve(struct device *device,
 			      struct device_attribute *attr,
 			      const char *buf, size_t count)
@@ -500,7 +500,7 @@ static struct device_attribute device_at
 	__ATTR(stride, S_IRUGO, show_stride, NULL),
 	__ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
 	__ATTR(state, S_IRUGO|S_IWUSR, show_fbstate, store_fbstate),
-#ifdef CONFIG_FB_BACKLIGHT
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 	__ATTR(bl_curve, S_IRUGO|S_IWUSR, show_bl_curve, store_bl_curve),
 #endif
 };
@@ -541,7 +541,7 @@ void fb_cleanup_device(struct fb_info *f
 	}
 }
 
-#ifdef CONFIG_FB_BACKLIGHT
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 /* This function generates a linear backlight curve
  *
  *     0: off
