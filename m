Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266345AbUAHAAN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 19:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266379AbUAHAAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 19:00:12 -0500
Received: from ee.oulu.fi ([130.231.61.23]:11700 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S266345AbUAGX7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:59:18 -0500
Date: Thu, 8 Jan 2004 01:59:12 +0200
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: linux-kernel@vger.kernel.org
Cc: linux-dvb@linuxtv.org
Subject: Use of floating point in the kernel
Message-ID: <20040107235912.GA23812@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

There are a few instances of use of floating point in 2.6,

--- linux-2.6.0-1.30/drivers/media/dvb/ttpci/av7110.c~	2004-01-07 23:14:14.000000000 +0200
+++ linux-2.6.0-1.30/drivers/media/dvb/ttpci/av7110.c	2004-01-07 23:14:14.000000000 +0200
@@ -2673,9 +2673,9 @@
 	buf[1] = div & 0xff;
 	buf[2] = 0x8e;
 
-	if (freq < (u32) 16*168.25 )
+	if (freq < 2692 ) /* 16*168.25 */
 		config = 0xa0;
-	else if (freq < (u32) 16*447.25)
+	else if (freq < 7156) /* 16*447.25 */
 		config = 0x90;
 	else
 		config = 0x30;

(If I'm not mistaken a similar patch for this has already been sent to
Linus, just making sure the DVB people get this in their trees as well)
(u32) (16*168.25) would work too, I suppose.

The other case is a bit more widespread, patch below is mostly rhetoric :-)
http://www.winischhofer.net/linuxsisvga.shtml#download contains the latest version
of the sisfb that doesn't use floating point at all, so that is certainly the better
option.

--- linux-2.6.0-1.30/drivers/video/sis/sis_main.c~	2004-01-08 01:27:44.909006216 +0200
+++ linux-2.6.0-1.30/drivers/video/sis/sis_main.c	2004-01-08 01:28:19.111806600 +0200
@@ -616,6 +616,7 @@
 		var->left_margin + var->xres + var->right_margin +
 		var->hsync_len;
 	unsigned int vtotal = 0; 
+#error Use of floating point in the kernel is NOT safe!
 	double drate = 0, hrate = 0;
 	int found_mode = 0;
 	int old_mode;
--- linux-2.6.0-1.30/drivers/video/Kconfig~	2004-01-08 01:25:37.570364632 +0200
+++ linux-2.6.0-1.30/drivers/video/Kconfig	2004-01-08 01:25:37.571364480 +0200
@@ -704,7 +704,7 @@
 
 config FB_SIS
 	tristate "SIS acceleration"
-	depends on FB && PCI
+	depends on FB && PCI && BROKEN
 	help
 	  This is the frame buffer device driver for the SiS 630 and 640 Super
 	  Socket 7 UMA cards.  Specs available at <http://www.sis.com.tw/>.


-- 
Pekka Pietikainen
