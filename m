Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUE1Szo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUE1Szo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 14:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263799AbUE1Szo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 14:55:44 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24307 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263770AbUE1Szm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 14:55:42 -0400
Date: Fri, 28 May 2004 11:54:59 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc1-mm1: revert leave-runtime-suspended-devices-off-at-system-resume.patch
Message-ID: <20040528185459.GG7176@slurryseal.ddns.mvista.com>
References: <1085658551.1998.7.camel@teapot.felipe-alfaro.com> <20040527233432.GE7176@slurryseal.ddns.mvista.com> <1085742197.1684.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085742197.1684.0.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch to fix my previous
leave-runtime-suspended-devices-off-at-system-resume patch; the new
changes save a copy of power.power_state in order to know whether to
resume a device, independently of mods to that field by a driver suspend
routine.  This fixes 2.6.7-rc1-mm1 in the same fashion as the updated
2.6.6 patch sent previously.  Thanks -- Todd

--- linux-2.6.7-rc1-mm1.orig/drivers/base/power/suspend.c	2004-05-27 12:18:53.000000000 -0700
+++ linux-2.6.7-rc1-mm1.pm/drivers/base/power/suspend.c	2004-05-28 11:08:10.486982568 -0700
@@ -39,6 +39,8 @@
 {
 	int error = 0;
 
+	dev->power.prev_state = dev->power.power_state;
+
 	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
 		error = dev->bus->suspend(dev,state);
 
--- linux-2.6.7-rc1-mm1.orig/drivers/base/power/resume.c	2004-05-27 12:18:53.000000000 -0700
+++ linux-2.6.7-rc1-mm1.pm/drivers/base/power/resume.c	2004-05-28 11:10:43.792676560 -0700
@@ -36,7 +36,7 @@
 		struct device * dev = to_device(entry);
 		list_del_init(entry);
 
-		if (!dev->power.power_state)
+		if (!dev->power.prev_state)
 			resume_device(dev);
 
 		list_add_tail(entry,&dpm_active);
--- linux-2.6.7-rc1-mm1.orig/include/linux/pm.h	2004-05-27 12:16:59.000000000 -0700
+++ linux-2.6.7-rc1-mm1.pm/include/linux/pm.h	2004-05-28 11:11:50.792491040 -0700
@@ -231,6 +231,7 @@
 struct dev_pm_info {
 	u32			power_state;
 #ifdef	CONFIG_PM
+	u32			prev_state;
 	u8			* saved_state;
 	atomic_t		pm_users;
 	struct device		* pm_parent;
