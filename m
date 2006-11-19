Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756692AbWKSOYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692AbWKSOYQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 09:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756695AbWKSOYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 09:24:16 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:52639 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1756692AbWKSOYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 09:24:15 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 19 Nov 2006 15:23:03 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: deadlock in "modprobe -r ohci1394" shortly after "modprobe
 ohci1394"
To: linux1394-devel@lists.sourceforge.net
cc: Alan Stern <stern@rowland.harvard.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <455FA159.2080303@s5r6.in-berlin.de>
Message-ID: <tkrat.8ead93641e26cf48@s5r6.in-berlin.de>
References: <455FA159.2080303@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=6706 :
...
> Right now I don't see a sane fix but I will have a few nights sleep over
> it...

A couple of reboots and a slightly charred pizza later I found out the
following:

1. If Alan's 2.6.16 patch is reverted, the deadlock is gone as expected.
   See bugzilla for the reverting patch.

2. The following patch works too, without the need to revert Alan's
   driver core changes.

3. Now that I have an at least unsane (sic) fix for the deadlock, a new
   bug in eth1394's remove code was revealed. This is a separate issue
   and logged as http://bugzilla.kernel.org/show_bug.cgi?id=7550 .

Please comment on the patch below.


From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: ieee1394: nodemgr: fix deadlock in shutdown

If "modprobe ohci1394" was quickly followed by "modprobe -r ohci1394",
say with 1 second pause in between, the modprobe -r got stuck in
uninterruptible sleep in kthread_stop.  At the same time the knodemgrd
slept uninterruptibly in bus_rescan_devices_helper.

This was a regression since Linux 2.6.16,
	commit bf74ad5bc41727d5f2f1c6bedb2c1fac394de731
	"Hold the device's parent's lock during probe and remove"

The fix lets ieee1394's nodemgr temporarily counteract the driver core's
downed parent->sem.  Thus bus_rescan_devices_helper can proceed and
knodemgrd terminates properly.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/nodemgr.c |   11 +++++++++++
 1 files changed, 11 insertions(+)

Index: linux-2.6.19-rc4/drivers/ieee1394/nodemgr.c
===================================================================
--- linux-2.6.19-rc4.orig/drivers/ieee1394/nodemgr.c	2006-11-18 23:31:35.000000000 +0100
+++ linux-2.6.19-rc4/drivers/ieee1394/nodemgr.c	2006-11-19 15:14:50.000000000 +0100
@@ -1873,8 +1873,19 @@ static void nodemgr_remove_host(struct h
 {
 	struct host_info *hi = hpsb_get_hostinfo(&nodemgr_highlevel, host);
 
+	/* Here comes a potential deadlock. A "modprobe -r ohci1394" calls
+	 * nodemgr_remove_host from driver_detach which takes the parent->sem.
+	 * Meanwhile, knodemgrd may be running into bus_rescan_devices_helper
+	 * which would block on the same semaphore. Therefore lift the
+	 * semaphore until knodemgrd exited. */
 	if (hi) {
+		/* up(&host->device.sem);	--- apparently not required */
+		if (host->device.parent)
+			up(&host->device.parent->sem);
 		kthread_stop(hi->thread);
+		if (host->device.parent)
+			down(&host->device.parent->sem);
+		/* down(&host->device.sem);	--- apparently not required */
 		nodemgr_remove_host_dev(&host->device);
 	}
 }

-- 
Stefan Richter
-=====-=-==- =-== =--==
http://arcgraph.de/sr/

