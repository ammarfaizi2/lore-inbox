Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270168AbUJSXWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270168AbUJSXWz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269553AbUJSXV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:21:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:19850 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270167AbUJSWql convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:41 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225738989@kroah.com>
Date: Tue, 19 Oct 2004 15:42:18 -0700
Message-Id: <10982257383944@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.49, 2004/10/06 13:44:51-07:00, nacc@us.ibm.com

[PATCH] pci hotplug/pciehp: replace schedule_timeout() with msleep_interruptible()

Use msleep_interruptible() instead of schedule_timeout() to guarantee
the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/pciehp.h |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)


diff -Nru a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
--- a/drivers/pci/hotplug/pciehp.h	2004-10-19 15:23:11 -07:00
+++ b/drivers/pci/hotplug/pciehp.h	2004-10-19 15:23:11 -07:00
@@ -31,6 +31,7 @@
 
 #include <linux/types.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
 #include <asm/semaphore.h>
 #include <asm/io.h>		
 #include "pci_hotplug.h"
@@ -261,14 +262,12 @@
 
 	dbg("%s : start\n", __FUNCTION__);
 	add_wait_queue(&ctrl->queue, &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
-	if (!pciehp_poll_mode) {
+	if (!pciehp_poll_mode)
 		/* Sleep for up to 1 second */
-		schedule_timeout(1*HZ);
-	} else
-		schedule_timeout(2.5*HZ);
+		msleep_interruptible(1000);
+	else
+		msleep_interruptible(2500);
 	
-	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&ctrl->queue, &wait);
 	if (signal_pending(current))
 		retval =  -EINTR;

