Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTJMQaJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 12:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTJMQaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 12:30:09 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:216 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261837AbTJMQaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 12:30:00 -0400
Message-ID: <3F8AD4A7.1040804@pacbell.net>
Date: Mon, 13 Oct 2003 09:36:55 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: [patch 2.6.0-test7] PM resume must allow device removal
Content-Type: multipart/mixed;
 boundary="------------030707010405000500090006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030707010405000500090006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick,

Here's a patch that resolves the PM problem I reported last week:
the self-deadlock during PM resume, in the case where devices
vanished during suspend.  That's typical in certain OHCI-HCD
resume scenarios (where the HC loses power) and may eventually
happen in other cases, as drivers for hotpluggable buses become
more intelligent about things getting unplugged.

You may want to have a more elaborate fix.  It looked to me like
that lock was overloaded ... it's serving not just to protect
the list of PM devices against concurrent changes, but also to
make sure only one task was managing PM suspend/resume.  It
seems to me that the "one task" rule would better be handled
by some sort of state flag.

- Dave


--------------030707010405000500090006
Content-Type: text/plain;
 name="pm-1013.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pm-1013.patch"

--- 1.11/drivers/base/power/resume.c	Mon Aug 25 11:08:21 2003
+++ edited/drivers/base/power/resume.c	Fri Oct 10 21:06:07 2003
@@ -22,8 +22,17 @@
 
 int resume_device(struct device * dev)
 {
-	if (dev->bus && dev->bus->resume)
-		return dev->bus->resume(dev);
+	if (dev->bus && dev->bus->resume) {
+		int retval;
+
+		/* drop lock so the call can use device_del() to clean up
+		 * after unplugged (or otherwise vanished) child devices
+		 */
+		up(&dpm_sem);
+		retval = dev->bus->resume(dev);
+		down(&dpm_sem);
+		return retval;
+	}
 	return 0;
 }
 

--------------030707010405000500090006--

