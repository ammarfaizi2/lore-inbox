Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWFUTy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWFUTy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWFUTuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:50:04 -0400
Received: from mail.suse.de ([195.135.220.2]:33713 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030247AbWFUTt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:49:56 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 15/22] [PATCH] Driver core: PM_DEBUG device suspend() messages become informative
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:45:58 -0700
Message-Id: <11509192111668-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11509192081167-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com> <11509191721672-git-send-email-greg@kroah.com> <1150919175882-git-send-email-greg@kroah.com> <11509191781796-git-send-email-greg@kroah.com> <11509191812079-git-send-email-greg@kroah.com> <115091918546-git-send-email-greg@kroah.com> <11509191893358-git-send-email-greg@kroah.com> <1150919192294-git-send-email-greg@kroah.com> <11509191951525-git-send-email-greg@kroah.com> <11509191982588-git-send-email-greg@kroah.com> <11509192022315-git-send-email-greg@kroah.com> <11509192043044-git-send-email-greg@kroah.com> <11509192081167-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

This makes the driver model PM suspend debug messages more useful, by

  (a) explaining what event is being sent, since not all suspend()
      requests mean the same thing;

  (b) reporting when a PM_EVENT_SUSPEND call is allowing the device
      to issue wakeup events.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/power/suspend.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
index 2a769cc..1a1fe43 100644
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -29,6 +29,15 @@ #include "power.h"
  * lists. This way, the ancestors will be accessed before their descendents.
  */
 
+static inline char *suspend_verb(u32 event)
+{
+	switch (event) {
+	case PM_EVENT_SUSPEND:	return "suspend";
+	case PM_EVENT_FREEZE:	return "freeze";
+	default:		return "(unknown suspend event)";
+	}
+}
+
 
 /**
  *	suspend_device - Save state of one device.
@@ -57,7 +66,13 @@ int suspend_device(struct device * dev, 
 	dev->power.prev_state = dev->power.power_state;
 
 	if (dev->bus && dev->bus->suspend && !dev->power.power_state.event) {
-		dev_dbg(dev, "suspending\n");
+		dev_dbg(dev, "%s%s\n",
+			suspend_verb(state.event),
+			((state.event == PM_EVENT_SUSPEND)
+					&& device_may_wakeup(dev))
+				? ", may wakeup"
+				: ""
+			);
 		error = dev->bus->suspend(dev, state);
 		suspend_report_result(dev->bus->suspend, error);
 	}
-- 
1.4.0

