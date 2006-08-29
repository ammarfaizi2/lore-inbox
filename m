Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965343AbWH2Uyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965343AbWH2Uyh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 16:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965348AbWH2Uyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 16:54:37 -0400
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:49948 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S965343AbWH2Uyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 16:54:35 -0400
Date: Tue, 29 Aug 2006 22:54:32 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@pol.net>
Subject: Re: [patch 5/6] Convert to use mutexes instead of semaphores
Message-ID: <20060829205432.GA13522@hansmi.ch>
References: <20060811050310.958962036.dtor@insightbb.com> <20060811050611.530817371.dtor@insightbb.com> <d120d5000608110558l3d3a5720i1781f4e90f40579b@mail.gmail.com> <1155302169.19959.16.camel@localhost.localdomain> <d120d5000608110634n501d33b0yb7702a24cbf064e3@mail.gmail.com> <20060811134215.GA26017@hansmi.ch> <d120d5000608110707o2b758739x20033b000449113f@mail.gmail.com> <1155314751.25767.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155314751.25767.6.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 05:45:51PM +0100, Richard Purdie wrote:
> On Fri, 2006-08-11 at 10:07 -0400, Dmitry Torokhov wrote: 
> > On 8/11/06, Michael Hanselmann <linux-kernel@hansmi.ch> wrote:
> > > Because I am responsible/wrote for the broken code, how should I
> > > proceed?

Somehow this got lost, sorry. The patch below fixes at least the
wrongly ordered up()/down() calls. I know there are outstanding with the
backlight code in general, but those issues aren't that easy to fix.

Is it okay? If yes, I'm going to send it to akpm.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>

---
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc5.orig/drivers/macintosh/via-pmu-backlight.c linux-2.6.18-rc5/drivers/macintosh/via-pmu-backlight.c
--- linux-2.6.18-rc5.orig/drivers/macintosh/via-pmu-backlight.c	2006-08-29 22:27:01.000000000 +0200
+++ linux-2.6.18-rc5/drivers/macintosh/via-pmu-backlight.c	2006-08-29 22:40:58.000000000 +0200
@@ -168,11 +168,11 @@ void __init pmu_backlight_init()
 		mutex_unlock(&info->bl_mutex);
 	}
 
-	up(&bd->sem);
+	down(&bd->sem);
 	bd->props->brightness = level;
 	bd->props->power = FB_BLANK_UNBLANK;
 	bd->props->update_status(bd);
-	down(&bd->sem);
+	up(&bd->sem);
 
 	mutex_lock(&pmac_backlight_mutex);
 	if (!pmac_backlight)
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc5.orig/drivers/video/aty/aty128fb.c linux-2.6.18-rc5/drivers/video/aty/aty128fb.c
--- linux-2.6.18-rc5.orig/drivers/video/aty/aty128fb.c	2006-08-29 22:27:01.000000000 +0200
+++ linux-2.6.18-rc5/drivers/video/aty/aty128fb.c	2006-08-29 22:41:24.000000000 +0200
@@ -1801,10 +1801,10 @@ static struct backlight_properties aty12
 static void aty128_bl_set_power(struct fb_info *info, int power)
 {
 	mutex_lock(&info->bl_mutex);
-	up(&info->bl_dev->sem);
+	down(&info->bl_dev->sem);
 	info->bl_dev->props->power = power;
 	__aty128_bl_update_status(info->bl_dev);
-	down(&info->bl_dev->sem);
+	up(&info->bl_dev->sem);
 	mutex_unlock(&info->bl_mutex);
 }
 
@@ -1839,11 +1839,11 @@ static void aty128_bl_init(struct aty128
 		219 * FB_BACKLIGHT_MAX / MAX_LEVEL);
 	mutex_unlock(&info->bl_mutex);
 
-	up(&bd->sem);
+	down(&bd->sem);
 	bd->props->brightness = aty128_bl_data.max_brightness;
 	bd->props->power = FB_BLANK_UNBLANK;
 	bd->props->update_status(bd);
-	down(&bd->sem);
+	up(&bd->sem);
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	mutex_lock(&pmac_backlight_mutex);
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc5.orig/drivers/video/aty/atyfb_base.c linux-2.6.18-rc5/drivers/video/aty/atyfb_base.c
--- linux-2.6.18-rc5.orig/drivers/video/aty/atyfb_base.c	2006-08-29 22:27:01.000000000 +0200
+++ linux-2.6.18-rc5/drivers/video/aty/atyfb_base.c	2006-08-29 22:41:47.000000000 +0200
@@ -2200,10 +2200,10 @@ static struct backlight_properties aty_b
 static void aty_bl_set_power(struct fb_info *info, int power)
 {
 	mutex_lock(&info->bl_mutex);
-	up(&info->bl_dev->sem);
+	down(&info->bl_dev->sem);
 	info->bl_dev->props->power = power;
 	__aty_bl_update_status(info->bl_dev);
-	down(&info->bl_dev->sem);
+	up(&info->bl_dev->sem);
 	mutex_unlock(&info->bl_mutex);
 }
 
@@ -2234,11 +2234,11 @@ static void aty_bl_init(struct atyfb_par
 		0xFF * FB_BACKLIGHT_MAX / MAX_LEVEL);
 	mutex_unlock(&info->bl_mutex);
 
-	up(&bd->sem);
+	down(&bd->sem);
 	bd->props->brightness = aty_bl_data.max_brightness;
 	bd->props->power = FB_BLANK_UNBLANK;
 	bd->props->update_status(bd);
-	down(&bd->sem);
+	up(&bd->sem);
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	mutex_lock(&pmac_backlight_mutex);
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc5.orig/drivers/video/aty/radeon_backlight.c linux-2.6.18-rc5/drivers/video/aty/radeon_backlight.c
--- linux-2.6.18-rc5.orig/drivers/video/aty/radeon_backlight.c	2006-08-29 22:27:01.000000000 +0200
+++ linux-2.6.18-rc5/drivers/video/aty/radeon_backlight.c	2006-08-29 22:39:23.000000000 +0200
@@ -195,11 +195,11 @@ void radeonfb_bl_init(struct radeonfb_in
 		217 * FB_BACKLIGHT_MAX / MAX_RADEON_LEVEL);
 	mutex_unlock(&rinfo->info->bl_mutex);
 
-	up(&bd->sem);
+	down(&bd->sem);
 	bd->props->brightness = radeon_bl_data.max_brightness;
 	bd->props->power = FB_BLANK_UNBLANK;
 	bd->props->update_status(bd);
-	down(&bd->sem);
+	up(&bd->sem);
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	mutex_lock(&pmac_backlight_mutex);
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc5.orig/drivers/video/nvidia/nv_backlight.c linux-2.6.18-rc5/drivers/video/nvidia/nv_backlight.c
--- linux-2.6.18-rc5.orig/drivers/video/nvidia/nv_backlight.c	2006-08-29 22:27:01.000000000 +0200
+++ linux-2.6.18-rc5/drivers/video/nvidia/nv_backlight.c	2006-08-29 22:43:03.000000000 +0200
@@ -113,10 +113,10 @@ static struct backlight_properties nvidi
 void nvidia_bl_set_power(struct fb_info *info, int power)
 {
 	mutex_lock(&info->bl_mutex);
-	up(&info->bl_dev->sem);
+	down(&info->bl_dev->sem);
 	info->bl_dev->props->power = power;
 	__nvidia_bl_update_status(info->bl_dev);
-	down(&info->bl_dev->sem);
+	up(&info->bl_dev->sem);
 	mutex_unlock(&info->bl_mutex);
 }
 
@@ -151,11 +151,11 @@ void nvidia_bl_init(struct nvidia_par *p
 		0x534 * FB_BACKLIGHT_MAX / MAX_LEVEL);
 	mutex_unlock(&info->bl_mutex);
 
-	up(&bd->sem);
+	down(&bd->sem);
 	bd->props->brightness = nvidia_bl_data.max_brightness;
 	bd->props->power = FB_BLANK_UNBLANK;
 	bd->props->update_status(bd);
-	down(&bd->sem);
+	up(&bd->sem);
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	mutex_lock(&pmac_backlight_mutex);
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc5.orig/drivers/video/riva/fbdev.c linux-2.6.18-rc5/drivers/video/riva/fbdev.c
--- linux-2.6.18-rc5.orig/drivers/video/riva/fbdev.c	2006-08-29 22:27:01.000000000 +0200
+++ linux-2.6.18-rc5/drivers/video/riva/fbdev.c	2006-08-29 22:43:26.000000000 +0200
@@ -355,10 +355,10 @@ static struct backlight_properties riva_
 static void riva_bl_set_power(struct fb_info *info, int power)
 {
 	mutex_lock(&info->bl_mutex);
-	up(&info->bl_dev->sem);
+	down(&info->bl_dev->sem);
 	info->bl_dev->props->power = power;
 	__riva_bl_update_status(info->bl_dev);
-	down(&info->bl_dev->sem);
+	up(&info->bl_dev->sem);
 	mutex_unlock(&info->bl_mutex);
 }
 
@@ -393,11 +393,11 @@ static void riva_bl_init(struct riva_par
 		0x534 * FB_BACKLIGHT_MAX / MAX_LEVEL);
 	mutex_unlock(&info->bl_mutex);
 
-	up(&bd->sem);
+	down(&bd->sem);
 	bd->props->brightness = riva_bl_data.max_brightness;
 	bd->props->power = FB_BLANK_UNBLANK;
 	bd->props->update_status(bd);
-	down(&bd->sem);
+	up(&bd->sem);
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	mutex_lock(&pmac_backlight_mutex);
