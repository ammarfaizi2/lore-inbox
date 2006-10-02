Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbWJBCht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbWJBCht (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 22:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWJBCht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 22:37:49 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:4568 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932604AbWJBChs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 22:37:48 -0400
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Paul Jackson <pj@sgi.com>,
       Greg KH <greg@kroah.com>
Date: Sun, 01 Oct 2006 19:37:20 -0700
Message-Id: <20061002023720.9780.85391.sendpatchset@v0>
Subject: [PATCH] usb hubc build fix.patch prefix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

The patch series 2.6.18-mm2-broken-out does not apply to 2.6.18,
for me anyway.

The 'quilt push' of this series fails with:

    Applying patch usb-hubc-build-fix.patch
    patching file drivers/usb/core/hub.c
    Hunk #1 FAILED at 1831.
    Hunk #2 succeeded at 1904 (offset -2 lines).
    Hunk #3 FAILED at 1946.
    2 out of 3 hunks FAILED -- rejects in file drivers/usb/core/hub.c
    Patch usb-hubc-build-fix.patch does not apply (enforce with -f)

If I apply the following patch *just before* the failing
usb-hubc-build-fix.patch, everything applies cleanly from there on
down the patch set.

I don't know what's right here.  I'm just blindly pushing code.

But it seems obvious to me that the 2.6.18-mm2 broken-out patch set
is borked:

  The first patch in the series: origin.patch, definitely places these
  two hub_* defines just before the usb_resume_root_hub() routine.
  
  But then the patch usb-hubc-build-fix.patch clearly expects to find
  those two hub_* defines just before the hub_suspend() routine.

Signed-off-by: Paul Jackson <pj@sgi.com>

---
 drivers/usb/core/hub.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- 2.6.18-mm2.orig/drivers/usb/core/hub.c	2006-10-01 17:52:53.000000000 -0700
+++ 2.6.18-mm2/drivers/usb/core/hub.c	2006-10-01 18:26:17.000000000 -0700
@@ -1862,6 +1862,8 @@ static inline int remote_wakeup(struct u
 	return 0;
 }
 
+#define hub_suspend NULL
+#define hub_resume NULL
 #endif
 
 static int hub_suspend(struct usb_interface *intf, pm_message_t msg)
@@ -1946,8 +1948,6 @@ static inline int remote_wakeup(struct u
 	return 0;
 }
 
-#define hub_suspend NULL
-#define hub_resume NULL
 #endif
 
 void usb_resume_root_hub(struct usb_device *hdev)

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
