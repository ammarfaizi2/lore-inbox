Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSKZVpn>; Tue, 26 Nov 2002 16:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSKZVpn>; Tue, 26 Nov 2002 16:45:43 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:25985 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP
	id <S261302AbSKZVpl>; Tue, 26 Nov 2002 16:45:41 -0500
Date: Tue, 26 Nov 2002 21:39:18 +0100
From: Romain Lievin <rlievin@free.fr>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Greg Kroah <greg@kroah.com>, Randy Dunlap <randy.dunlap@verizon.net>
Subject: Fwd: [PATCH] tiglusb timeouts
Message-ID: <20021126203918.GA4186@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch fixes some troubles in the tiglusb driver.

Patch is against 2.5.49. Please apply.

Thanks, Romain.

> From: "Randy.Dunlap" <randy.dunlap@verizon.net>
> To: linux-usb-devel@lists.sf.net, roms@lpg.ticalc.org,
> 	jb@technologeek.org
> Subject: [PATCH] tiglusb timeouts
> 
> Hi,
> 
> Here's a patch for you to consider and apply...
> It addresses the timeout parameter in the tiglusb driver.
> 
> 1.  timeout could be 0, causing a divide-by-zero.
> The patch prevents this.
> 
> 2.  The timeout value to usb_bulk_msg() could be rounded
> down to cause a divide-by-zero if timeout was < 10, e.g. 9,
> in:
> 	result = usb_bulk_msg (s->dev, pipe, buffer, bytes_to_read,
> 			       &bytes_read, HZ / (timeout / 10));
> 9 / 10 == 0 => divide-by-zero !!
> 
> 3.  The timeout value above doesn't do very well on converting
> timeout to tenths of seconds.  Even for the default timeout
> value of 15 (1.5 seconds), it becomes:
> 	HZ / (15 / 10) == HZ / 1 == HZ, or 1 second.
> The patch corrects this formula to use:
> 	(HZ * 10) / timeout
> 
> Patch is against 2.5.49.  Please apply.
> 
> Thanks,
> ~Randy
============================[ cut here ]========================
--- ./drivers/usb/misc/tiglusb.c%times	Fri Nov 22 13:40:13 2002
+++ ./drivers/usb/misc/tiglusb.c	Mon Nov 25 20:03:52 2002
@@ -185,7 +185,7 @@
 
 	pipe = usb_rcvbulkpipe (s->dev, 1);
 	result = usb_bulk_msg (s->dev, pipe, buffer, bytes_to_read,
-			       &bytes_read, HZ / (timeout / 10));
+			       &bytes_read, HZ * 10 / timeout);
 	if (result == -ETIMEDOUT) {	/* NAK */
 		ret = result;
 		if (!bytes_read) {
@@ -242,7 +242,7 @@
 
 	pipe = usb_sndbulkpipe (s->dev, 2);
 	result = usb_bulk_msg (s->dev, pipe, buffer, bytes_to_write,
-			       &bytes_written, HZ / (timeout / 10));
+			       &bytes_written, HZ * 10 / timeout);
 
 	if (result == -ETIMEDOUT) {	/* NAK */
 		warn ("tiglusb_write, NAK received.");
@@ -453,6 +453,8 @@
 	if (ints[0] > 0) {
 		timeout = ints[1];
 	}
+	if (!timeout)
+		timeout = TIMAXTIME;
 
 	return 1;
 }
@@ -494,6 +496,9 @@
 
 	info (DRIVER_DESC ", " DRIVER_VERSION);
 
+	if (!timeout)
+		timeout = TIMAXTIME;
+
 	return 0;
 }
 
@@ -516,6 +521,6 @@
 MODULE_LICENSE (DRIVER_LICENSE);
 
 MODULE_PARM (timeout, "i");
-MODULE_PARM_DESC (timeout, "Timeout (default=1.5 seconds)");
+MODULE_PARM_DESC (timeout, "Timeout in tenths of seconds (default=1.5 seconds)");
 
 /* --------------------------------------------------------------------- */
============================[ cut here ]========================
-- 
Romain Lievin, aka 'roms'  	<roms@lpg.ticalc.org>
Web site 			<http://lpg.ticalc.org/prj_tilp>
"Linux, y'a moins bien mais c'est plus cher !"














