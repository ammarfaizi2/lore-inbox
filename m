Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261362AbSKGSX2>; Thu, 7 Nov 2002 13:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbSKGSX2>; Thu, 7 Nov 2002 13:23:28 -0500
Received: from pop.gmx.net ([213.165.64.20]:57062 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261362AbSKGSXZ>;
	Thu, 7 Nov 2002 13:23:25 -0500
Message-ID: <3DCAAF2D.2040202@gmx.net>
Date: Thu, 07 Nov 2002 19:21:33 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2002-Q4@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: de, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: linux-kernel <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: Linux 2.4.20-rc1
References: <Pine.LNX.4.44L.0211061033410.27268-100000@freak.distro.conectiva>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080202080302090109010209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080202080302090109010209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

[CC: linux-fbdev-devel to find out what was wrong with the patch]
Marcelo Tosatti wrote:
> On Sat, 2 Nov 2002, Carl-Daniel Hailfinger wrote:
>>Marcelo Tosatti wrote:
>>
>>>Hi,
>>>
>>>Finally, rc1.
>>>[snipped]
>>>
>>>Please stress test it.
>>>
>>
>>My system comes up with a blank console after hardware suspend and resume.
>>The cursor is still visible, but no text is there. Switching to another
>>console and back fixes it. Vesafb is enabled with vga=791.
>>Hardware is a Toshiba Satellite 4100XCDT notebook with Trident Cyber9525DVD
>>graphics chipset, but this also can be reproduced with Dell notebooks.
>>
>>I just verified the problem exists still with 2.4.20-rc1.
>>A binary search turned up 2.4.18-pre7 as the kernel which broke,
>>specifically the changes made to apm.c back then.
> 
> 
> Have you tried to revert 2.4.18-pre7's changes to apm.c to make sure it is
> the cause?>

I tried it and found out that my results were incorrect. The problem was 
introduced in 2.4.18-pre1 by the changes to drivers/video/fbcon.c

Reverting the attached patch fixes my problem. However, I am not exactly 
sure why a patch intended to fix a PM problem introduced another one.

Regards
Carl-Daniel

--------------080202080302090109010209
Content-Type: text/plain;
 name="patch-fbdev.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-fbdev.txt"

diff -Naur -X /home/marcelo/lib/dontdiff linux.orig/drivers/video/fbcon.c linux/drivers/video/fbcon.c
--- linux.orig/drivers/video/fbcon.c	Thu Jan 10 20:17:41 2002
+++ linux/drivers/video/fbcon.c	Wed Dec 26 16:50:52 2001
@@ -75,6 +75,7 @@
 #include <linux/selection.h>
 #include <linux/smp.h>
 #include <linux/init.h>
+#include <linux/pm.h>
 
 #include <asm/irq.h>
 #include <asm/system.h>
@@ -137,6 +138,12 @@
 static void fbcon_free_font(struct display *);
 static int fbcon_set_origin(struct vc_data *);
 
+#ifdef CONFIG_PM
+static int pm_fbcon_request(struct pm_dev *dev, pm_request_t rqst, void *data);
+static struct pm_dev *pm_fbcon;
+static int fbcon_sleeping;
+#endif
+
 /*
  * Emmanuel: fbcon will now use a hardware cursor if the
  * low-level driver provides a non-NULL dispsw->cursor pointer,
@@ -233,6 +240,7 @@
 static struct timer_list cursor_timer = {
     function: cursor_timer_handler
 };
+static int use_timer_cursor;
 
 static void cursor_timer_handler(unsigned long dev_addr)
 {
@@ -457,11 +465,16 @@
 #endif
 
     if (irqres) {
+	use_timer_cursor = 1;
 	cursor_blink_rate = DEFAULT_CURSOR_BLINK_RATE;
 	cursor_timer.expires = jiffies+HZ/50;
 	add_timer(&cursor_timer);
     }
 
+#ifdef CONFIG_PM
+    pm_fbcon = pm_register(PM_SYS_DEV, PM_SYS_VGA, pm_fbcon_request);
+#endif
+
     return display_desc;
 }
 
@@ -1558,6 +1571,10 @@
 
     if (blank < 0)	/* Entering graphics mode */
 	return 0;
+#ifdef CONFIG_PM
+    if (fbcon_sleeping)
+    	return 0;
+#endif /* CONFIG_PM */
 
     fbcon_cursor(p->conp, blank ? CM_ERASE : CM_DRAW);
 
@@ -2446,6 +2463,39 @@
 
     return done ? (LOGO_H + fontheight(p) - 1) / fontheight(p) : 0 ;
 }
+
+#ifdef CONFIG_PM
+/* console.c doesn't do enough here */
+static int
+pm_fbcon_request(struct pm_dev *dev, pm_request_t rqst, void *data)
+{
+	unsigned long flags;
+	
+	switch (rqst)
+	{
+	case PM_RESUME:
+		acquire_console_sem();
+		fbcon_sleeping = 0;
+		if (use_timer_cursor) {
+			cursor_timer.expires = jiffies+HZ/50;
+			add_timer(&cursor_timer);
+		}
+		release_console_sem();
+		break;
+	case PM_SUSPEND:
+		acquire_console_sem();
+		save_flags(flags);
+		cli();
+		if (use_timer_cursor)
+			del_timer(&cursor_timer);
+		fbcon_sleeping = 1;
+		restore_flags(flags);
+		release_console_sem();
+		break;
+	}
+	return 0;
+}
+#endif /* CONFIG_PM */
 
 /*
  *  The console `switch' structure for the frame buffer based console

--------------080202080302090109010209--

