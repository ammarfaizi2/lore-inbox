Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264695AbUEPR5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264695AbUEPR5t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 13:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264701AbUEPR5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 13:57:48 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:39825 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264695AbUEPR5f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 13:57:35 -0400
Message-ID: <40A7AA0B.5000200@pacbell.net>
Date: Sun, 16 May 2004 10:51:07 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Greg KH <greg@kroah.com>, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [BK PATCH] USB changes for 2.6.6
References: <20040514224516.GA16814@kroah.com> <20040515113251.GA27011@suse.de> <Pine.LNX.4.58.0405151034500.10718@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405151034500.10718@ppc970.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------000201050909020900060600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000201050909020900060600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:

> ... would never have
> compiled with debugging on anyway. 

Speaking of which, please consider merging this.  It
missed Greg's push on Friday, but it's needed to build
OHCI and EHCI with CONFIG_USB_DEBUG when !CONFIG_PM.

By request, this adds (and uses) a new API call to hide
the necessary #ifdef once, rather than repeat it in every
driver.  It's an accessor for a field only exists when
#ifdef CONFIG_PM.  These particular references prevent
dumping registers when that part of the chip suspended.

- Dave



--------------000201050909020900060600
Content-Type: text/plain;
 name="Diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Diff"

--- 1.13/include/linux/pm.h	Thu Aug 21 11:47:27 2003
+++ edited/include/linux/pm.h	Sun May 16 10:49:54 2004
@@ -238,6 +238,16 @@
 #endif
 };
 
+static inline u32
+device_pm_state(struct dev_pm_info *info)
+{
+#ifdef	CONFIG_PM
+	return info->power_state;
+#else
+	return 0;
+#endif
+}
+
 extern void device_pm_set_parent(struct device * dev, struct device * parent);
 
 extern int device_suspend(u32 state);
--- 1.33/drivers/usb/host/ehci-dbg.c	Fri May  7 12:48:33 2004
+++ edited/drivers/usb/host/ehci-dbg.c	Sun May 16 10:49:54 2004
@@ -639,7 +639,7 @@
 
 	spin_lock_irqsave (&ehci->lock, flags);
 
-	if (bus->controller->power.power_state) {
+	if (device_pm_state (&bus->controller->power)) {
 		size = scnprintf (next, size,
 			"bus %s, device %s (driver " DRIVER_VERSION ")\n"
 			"SUSPENDED (no register access)\n",
--- 1.26/drivers/usb/host/ohci-dbg.c	Tue May 11 13:17:33 2004
+++ edited/drivers/usb/host/ohci-dbg.c	Sun May 16 10:49:54 2004
@@ -623,7 +623,7 @@
 		hcd->self.controller->bus_id,
 		hcd_name);
 
-	if (bus->controller->power.power_state) {
+	if (device_pm_state (&bus->controller->power)) {
 		size -= scnprintf (next, size,
 			"SUSPENDED (no register access)\n");
 		goto done;

--------------000201050909020900060600--


