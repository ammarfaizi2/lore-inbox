Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbVHRAdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbVHRAdf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 20:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbVHRAdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 20:33:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:18890 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751399AbVHRAde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 20:33:34 -0400
Date: Wed, 17 Aug 2005 17:33:11 -0700
From: Greg KH <gregkh@suse.de>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: Michal Ostrowski <mostrows@watson.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix manual binding infinite loop
Message-ID: <20050818003311.GA26539@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for manual binding of drivers to devices.  Problem is if you pass in
a valid device id, but the driver refuses to bind.  Infinite loop as
write() tries to resubmit the data it just sent.

Thanks to Michal Ostrowski <mostrows@watson.ibm.com> for pointing the
problem out.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/bus.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/base/bus.c	2005-08-02 13:41:26.000000000 -0700
+++ gregkh-2.6/drivers/base/bus.c	2005-08-17 17:11:35.000000000 -0700
@@ -180,7 +180,9 @@ static ssize_t driver_bind(struct device
 		up(&dev->sem);
 		put_device(dev);
 	}
-	return err;
+	if (err)
+		return err;
+	return count;
 }
 static DRIVER_ATTR(bind, S_IWUSR, NULL, driver_bind);
 
-- 
