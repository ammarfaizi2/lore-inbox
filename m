Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVGCTm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVGCTm2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 15:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVGCTm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 15:42:27 -0400
Received: from blackbird.sr71.net ([64.146.134.44]:37568 "EHLO
	blackbird.sr71.net") by vger.kernel.org with ESMTP id S261507AbVGCTl3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 15:41:29 -0400
Subject: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested?
	(Accelerometer)
From: Dave Hansen <dave@sr71.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       Paul Sladen <thinkpad@paul.sladen.org>,
       linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       Yani Ioannou <yani.ioannou@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <42C82BBB.9090008@gmail.com>
References: <1119559367.20628.5.camel@mindpipe>
	 <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net>
	 <20050625144736.GB7496@atrey.karlin.mff.cuni.cz>
	 <42BD9EBD.8040203@linuxwireless.org> <20050625200953.GA1591@ucw.cz>
	 <42C7A3B2.4090502@linuxwireless.org> <20050703101613.GA2372@ucw.cz>
	 <9a8748490507030407547fa29b@mail.gmail.com>  <42C82BBB.9090008@gmail.com>
Content-Type: multipart/mixed; boundary="=-0m0uIMGytBDTaTkLahWG"
Date: Sun, 03 Jul 2005 12:41:02 -0700
Message-Id: <1120419662.4351.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0m0uIMGytBDTaTkLahWG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2005-07-03 at 20:17 +0200, Jesper Juhl wrote:
>         while (1) {
....
>                 } else if (time_before(jiffies, wait_until)) {
>                         set_current_state(TASK_INTERRUPTIBLE);
>                         schedule_timeout(HZ);
>                 } else {

Please don't do the manual task state setting.  It's preferable to just
use msleep_interruptable().  jiffies and HZ can change with each kernel
configuration, and are not dependable.  

I've attached an untested patch that cleans up the init function a bit
(I think).

-- Dave

--=-0m0uIMGytBDTaTkLahWG
Content-Disposition: attachment; filename=init-function-cleanup.patch
Content-Type: text/x-patch; name=init-function-cleanup.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- accelerometer.c-0.1.orig	2005-07-03 12:28:28.000000000 -0700
+++ accelerometer.c	2005-07-03 12:33:39.000000000 -0700
@@ -158,45 +158,49 @@
 }
 
 /* initialize the accelerometer, wait up to `timeout' seconds for success */
-int accelerometer_init(unsigned int timeout)
+int accelerometer_init(unsigned int timeout_secs)
 {
-	unsigned long wait_until = jiffies + timeout * HZ;
+	unsigned long total_wait_msecs = timeout_secs * 1000;
+	unsinged msec_per_wait = 10;
+	unsigned long msecs_waited = 0;
+	int ret = -EIO;
 	
 	outb(0x13, 0x1610);
 	outb(0x01, 0x161f);
  	if (!wait_latch(0x00, 0x161f))
-		return -EIO;
+		return ret;
 	if (!wait_latch(0x03, 0x1611))
-		return -EIO;
+		return ret;
 	outb(0x17, 0x1610);
 	outb(0x81, 0x1611);
 	outb(0x01, 0x161f);
 	if (!wait_latch(0x00, 0x161f))
-		return -EIO;
+		return ret;
 	if (!wait_latch(0x00, 0x1611))
-		return -EIO;
+		return ret;
 	if (!wait_latch(0x60, 0x1612))
-		return -EIO;
+		return ret;
 	if (!wait_latch(0x00, 0x1613))
-		return -EIO;
+		return ret;
 	outb(0x14, 0x1610);
 	outb(0x01, 0x1611);
 	outb(0x01, 0x161f);
 	if (!wait_latch(0x00, 0x161f))
-		return -EIO;
+		return ret;
 	outb(0x10, 0x1610);
 	outb(0xc8, 0x1611);
 	outb(0x00, 0x1612);
 	outb(0x02, 0x1613);
 	outb(0x01, 0x161f);
 	if (!wait_latch(0x00, 0x161f))
-		return -EIO;
+		return ret;
 	if (!request_refresh(REFRESH_SYNC))
-		return -EIO;
+		return ret;
 	if (!wait_latch(0x00, 0x1611))
-		return -EIO;
+		return ret;
 
-	while (1) {
+	ret = -ENXIO;
+	while (msecs_waited <= total_wait_msecs) {
 		if (wait_latch(0x02, 0x1611)) {
 			struct hdaps_accel_data data;
 			/* 
@@ -204,15 +208,13 @@
 			 * return success.
 			 */
 			 accelerometer_read(&data);
-			return 0;
-		} else if (time_before(jiffies, wait_until)) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(HZ);
-		} else {
-			/* we timed out, return failure */
-			return -ENXIO;
+			ret = 0;
+			break;
 		}
+		msleep(msecs_per_wait);
+		msecs_waited += msecs_per_wait;
 	}
+	return ret;
 }
 
 static int ibm_hdaps_init(void)

--=-0m0uIMGytBDTaTkLahWG--

