Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264765AbUEPSRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264765AbUEPSRM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 14:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264760AbUEPSRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 14:17:12 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:21947 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264765AbUEPSRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 14:17:05 -0400
Message-ID: <40A7AF6D.6060304@pacbell.net>
Date: Sun, 16 May 2004 11:14:05 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Greg KH <greg@kroah.com>, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [BK PATCH] USB changes for 2.6.6
References: <20040514224516.GA16814@kroah.com> <20040515113251.GA27011@suse.de> <Pine.LNX.4.58.0405151034500.10718@ppc970.osdl.org> <40A7AA0B.5000200@pacbell.net> <Pine.LNX.4.58.0405161101160.25502@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405161101160.25502@ppc970.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------000702020808070905000707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000702020808070905000707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> So I'd much rather just have two different functions, one in the CONFIG_PM 
> section, and one in the !CONFIG_PM one. That's how we already do 
> everything else in that header file (and how we handle PCI etc).

More like this then?  I'm not sure whether you'd prefer
to apply that logic to the "struct pm_info" innards too.
That file has multiple CONFIG_PM sections, too.

- Dave

--------------000702020808070905000707
Content-Type: text/plain;
 name="Diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Diff"

--- 1.13/include/linux/pm.h	Thu Aug 21 11:47:27 2003
+++ edited/include/linux/pm.h	Sun May 16 11:11:06 2004
@@ -238,6 +238,24 @@
 #endif
 };
 
+#ifdef	CONFIG_PM
+
+static inline u32
+device_pm_state(struct dev_pm_info *info)
+{
+	return info->power_state;
+}
+
+#else
+
+static inline u32
+device_pm_state(struct dev_pm_info *info)
+{
+	return 0;
+}
+
+#endif
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

--------------000702020808070905000707--

