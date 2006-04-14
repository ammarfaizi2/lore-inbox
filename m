Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbWDNULG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbWDNULG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 16:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbWDNULG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 16:11:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:2445 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965106AbWDNULF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 16:11:05 -0400
Cc: Ryan Wilson <hap9@epoch.ncsc.mil>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 5/7] driver core: driver_bind attribute returns incorrect value
In-Reply-To: <11450453961756-git-send-email-greg@kroah.com>
X-Mailer: git-send-email
Date: Fri, 14 Apr 2006 13:09:56 -0700
Message-Id: <11450453961276-git-send-email-greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The manual driver <-> device binding attribute in sysfs doesn't return
the correct value on failure or success of driver_probe_device.
driver_probe_device returns 1 on success (the driver accepted the
device) or 0 on probe failure (when the driver didn't accept the
device but no real error occured). However, the attribute can't just
return 0 or 1, it must return the number of bytes consumed from buf
or an error value. Returning 0 indicates to userspace that nothing
was written (even though the kernel has tried to do the bind/probe and
failed). Returning 1 indicates that only one character was accepted in
which case userspace will re-try the write with a partial string.

A more correct version of driver_bind would return count (to indicate
the entire string was consumed) when driver_probe_device returns 1
and -ENODEV when driver_probe_device returns 0. This patch makes that
change.

Signed-off-by: Ryan Wilson <hap9@epoch.ncsc.mil>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/base/bus.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

372254018eb1b65ee69210d11686bfc65c8d84db
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 48718b7..76656ac 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -188,6 +188,11 @@ static ssize_t driver_bind(struct device
 		up(&dev->sem);
 		if (dev->parent)
 			up(&dev->parent->sem);
+
+		if (err > 0) 		/* success */
+			err = count;
+		else if (err == 0)	/* driver didn't accept device */
+			err = -ENODEV;
 	}
 	put_device(dev);
 	put_bus(bus);
-- 
1.2.6


