Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263766AbUE1RwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbUE1RwT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 13:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUE1RwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 13:52:19 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46574 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263766AbUE1RwN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 13:52:13 -0400
Date: Fri, 28 May 2004 10:52:06 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: Greg KH <greg@kroah.com>
Cc: Todd Poynor <tpoynor@mvista.com>, mochel@digitalimplant.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Leave runtime suspended devices off at system resume
Message-ID: <20040528175206.GF7176@slurryseal.ddns.mvista.com>
References: <20040526214319.GB7176@slurryseal.ddns.mvista.com> <20040528170315.GB8192@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528170315.GB8192@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 10:03:15AM -0700, Greg KH wrote:
> Nice, that looks good.
> 
> Applied, thanks.

Sorry, Felipe Solana found that USB drivers tweak the power.power_state
field during suspend, so we can't rely on that field to tell what to
resume.  A new patch against 2.6.6 creates a separate field for the
original value, so driver mods to the field won't break resume.  I'll
also send a patch against the original patch to fix trees already
updated in a moment.  Thanks -- Todd

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


