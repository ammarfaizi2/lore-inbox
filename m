Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265663AbUE0Xeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265663AbUE0Xeh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 19:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265679AbUE0Xeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 19:34:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46074 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265663AbUE0Xee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 19:34:34 -0400
Date: Thu, 27 May 2004 16:34:32 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-rc1-mm1: revert leave-runtime-suspended-devices-off-at-system-resume.patch
Message-ID: <20040527233432.GE7176@slurryseal.ddns.mvista.com>
References: <1085658551.1998.7.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085658551.1998.7.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 01:49:12PM +0200, Felipe Alfaro Solana wrote:
> 
> 2.6.7-rc-mm1 includes
> "leave-runtime-suspended-devices-off-at-system-resume" which causes
> mayor problems when used on my ACPI laptop. After resuming from S3
> (STR), both the CardBus and UHCI-HCD bridges won't come up from
> suspension, rendering them completely unusable: neither my CardBus NIC,
> nor my USB mouse are recognized or functional.

Aargh, USB drivers appear to be the only drivers to modify that field, I
didn't catch that, sorry.  The following patch against 2.6.6 adds a new
field for "previous state", so that drivers that modify their own
dev->power.power_state during the suspend callback will be resumed.  Can
send a patch to fix 2.6.7-rc1-mm1 if desired.

--- linux-2.6.6-orig/drivers/base/power/suspend.c	2004-05-10 11:22:58.000000000 -0700
+++ linux-2.6.6-prevstate/drivers/base/power/suspend.c	2004-05-27 13:58:01.931014888 -0700
@@ -39,7 +39,9 @@
 {
 	int error = 0;
 
-	if (dev->bus && dev->bus->suspend)
+	dev->power.prev_state = dev->power.power_state;
+
+	if (dev->bus && dev->bus->suspend && ! dev->power.power_state)
 		error = dev->bus->suspend(dev,state);
 
 	if (!error) {
--- linux-2.6.6-orig/drivers/base/power/resume.c	2004-05-10 11:22:58.000000000 -0700
+++ linux-2.6.6-prevstate/drivers/base/power/resume.c	2004-05-27 14:35:03.373304328 -0700
@@ -35,7 +35,10 @@
 		struct list_head * entry = dpm_off.next;
 		struct device * dev = to_device(entry);
 		list_del_init(entry);
-		resume_device(dev);
+
+		if (! dev->power.prev_state)
+			resume_device(dev);
+
 		list_add_tail(entry,&dpm_active);
 	}
 }
--- linux-2.6.6-orig/include/linux/pm.h	2004-05-10 11:23:56.000000000 -0700
+++ linux-2.6.6-prevstate/include/linux/pm.h	2004-05-27 14:35:37.143170528 -0700
@@ -231,6 +231,7 @@
 struct dev_pm_info {
 #ifdef	CONFIG_PM
 	u32			power_state;
+	u32			prev_state;
 	u8			* saved_state;
 	atomic_t		pm_users;
 	struct device		* pm_parent;


-- 
Todd
