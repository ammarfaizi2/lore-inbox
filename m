Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVGIMqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVGIMqF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 08:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVGIMqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 08:46:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:2764 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261358AbVGIMqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 08:46:04 -0400
Date: Sat, 9 Jul 2005 14:46:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@infradead.org>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050709124606.GA5540@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507081938.27815.s0348365@sms.ed.ac.uk> <20050708194827.GA22536@elte.hu> <200507082145.08877.s0348365@sms.ed.ac.uk> <20050709124105.GB4665@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709124105.GB4665@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (gdb) ####################################
> (gdb) # c0228ec3, stack size:  764 bytes #
> (gdb) ####################################
> (gdb) 0xc0228ec3 is in calc_mode_timings (drivers/video/fbmon.c:317).

fix below.

	Ingo

--

quick hack to remove a 764 bytes stack footprint from fbmon.c. Codepath 
is most likely serialized but with the semaphore it's for sure.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/drivers/video/fbmon.c
===================================================================
--- linux.orig/drivers/video/fbmon.c
+++ linux/drivers/video/fbmon.c
@@ -315,9 +315,11 @@ static int edid_is_monitor_block(unsigne
 
 static void calc_mode_timings(int xres, int yres, int refresh, struct fb_videomode *mode)
 {
-	struct fb_var_screeninfo var;
-	struct fb_info info;
-	
+	static struct fb_var_screeninfo var;
+	static struct fb_info info;
+	static DECLARE_MUTEX(fb_lock);
+
+	down(&fb_lock);
 	var.xres = xres;
 	var.yres = yres;
 	fb_get_mode(FB_VSYNCTIMINGS | FB_IGNOREMON, 
@@ -334,6 +336,7 @@ static void calc_mode_timings(int xres, 
 	mode->vsync_len = var.vsync_len;
 	mode->vmode = 0;
 	mode->sync = 0;
+	up(&fb_lock);
 }
 
 static int get_est_timing(unsigned char *block, struct fb_videomode *mode)

