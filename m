Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758915AbWK2WvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758915AbWK2WvF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758916AbWK2WvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:51:05 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:38743 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1758915AbWK2WvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:51:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=FOE4LivrlxnSOD1c6tJXa3WE0RKNCuA06oz6dYdDMyNw788IbNUmHG+tzHi/+CylPCSmTySPA/jZeRCvFw3qT0SEX6IeUWPLfi5CTlYMze7V7rJf6tcAdGokaKKb3Xdbz9XkFOxbSQLdoCSsMQtE8EBmG21h7LmqNNj/+oiVyYc=  ;
X-YMail-OSG: t.sg9NQVM1kd75U0ddHBNAtJfoKDxRMGMRvHLSwkVLPipg8aJBgy6g7KDXRwWly1TWGIkkljmdfhlzMBmjMmj5dbk3nCaDQ1VmfMsSeVk83KbFMkGsxqyw--
From: David Brownell <david-b@pacbell.net>
To: Greg KH <gregkh@suse.de>
Subject: [patch 2.6.19-rc6] fix hotplug for legacy platform drivers
Date: Wed, 29 Nov 2006 14:50:58 -0800
User-Agent: KMail/1.7.1
Cc: Kay Sievers <kay.sievers@vrfy.org>, "Marco d'Itri" <md@Linux.IT>,
       linux-kernel@vger.kernel.org
References: <20061122135948.GA7888@bongo.bofh.it> <1164623293.3702.4.camel@pim.off.vrfy.org> <20061127190315.GA28107@suse.de>
In-Reply-To: <20061127190315.GA28107@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611291450.59165.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 November 2006 11:03 am, Greg KH wrote:

> David, any chance you can fix this up, as people are seeing this bug
> today.

Here's my fix.  Unlike the fix Kay suggested, it causes at worst only
a minor loss of functionality, so that tradeoff seems fair for a late
merge.  I audited all the drivers using the relevant APIs, and I can't
see many (if any!) folk hitting problems from this.

- Dave


============== CUT HERE
We've had recent reports of some legacy "probe the hardware" style platform
drivers having nasty problems with hotplug support.

The core issue is that those drivers don't fully conform to the driver model.
They assume a role that's the responsibility of infrastructure code:  they
create their own device nodes.  But hotplugging relies on drivers to have split
those roles into different modules, hence the problems.  If the driver creates
nodes for devices that don't exist, the "modprobe $MODALIAS" step of hotplugging
can become an endless loop *when driver load aborts* (it's safe otherwise).

This fix adds a per-device flag saying whether its driver can't be hotplugged,
which is set by APIs used for "probe the hardware" style drivers.  The flag
is used to bypass relevant hotplug logic (setting the $MODALIAS environment
variable) for those problematic drivers.

The minor glitch is that in a few cases those APIs are used by platform code,
instead of by drivers.  Examples include most places where a "pcspkr" device is
created (although a recent un-merged patch fixed that for X86_PC), or the way
platform devices are created for OpenFirmware nodes ... all those cases seem
to kick in before userspace (and hotplug) is active though.

So the net of this patch is removing some nasty failures with legacy drivers,
while retaining hotplug capability for those platform drivers which are well
behaved (the majority).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


Index: g26/include/linux/device.h
===================================================================
--- g26.orig/include/linux/device.h	2006-11-27 21:01:30.000000000 -0800
+++ g26/include/linux/device.h	2006-11-27 21:03:48.000000000 -0800
@@ -330,6 +330,7 @@ struct device {
 	struct kobject kobj;
 	char	bus_id[BUS_ID_SIZE];	/* position on parent bus */
 	unsigned		is_registered:1;
+	unsigned		is_driver_not_hotpluggable:1;
 	struct device_attribute uevent_attr;
 	struct device_attribute *devt_attr;
 
Index: g26/drivers/base/platform.c
===================================================================
--- g26.orig/drivers/base/platform.c	2006-11-27 21:03:46.000000000 -0800
+++ g26/drivers/base/platform.c	2006-11-29 11:02:04.000000000 -0800
@@ -160,6 +160,11 @@ static void platform_device_release(stru
  *
  *	Create a platform device object which can have other objects attached
  *	to it, and which will have attached objects freed when it is released.
+ *
+ *	This device will be marked as not supporting hotpluggable drivers.  In
+ *	the unusual case that the device isn't being dynamically allocated as
+ *	of a legacy "probe the hardware" driver, infrastructure code should
+ *	consider reversing this marking.
  */
 struct platform_device *platform_device_alloc(const char *name, unsigned int id)
 {
@@ -172,6 +177,7 @@ struct platform_device *platform_device_
 		pa->pdev.id = id;
 		device_initialize(&pa->pdev.dev);
 		pa->pdev.dev.release = platform_device_release;
+		pa->pdev.dev.is_driver_not_hotpluggable = 1;
 	}
 
 	return pa ? &pa->pdev : NULL;
@@ -349,6 +355,13 @@ EXPORT_SYMBOL_GPL(platform_device_unregi
  *	memory allocated for the device allows drivers using such devices
  *	to be unloaded iwithout waiting for the last reference to the device
  *	to be dropped.
+ *
+ *	This interface is primarily intended for use with legacy drivers
+ *	which probe hardware directly.  Because such drivers create device
+ *	nodes themselves, rather than letting system infrastructure handle
+ *	such device enumeration tasks, they don't fully conform to the Linux
+ *	driver model.  In particular, when such drivers are built as modules,
+ *	they can't be "hotplugged".
  */
 struct platform_device *platform_device_register_simple(char *name, unsigned int id,
 							struct resource *res, unsigned int num)
@@ -525,6 +538,13 @@ static int platform_uevent(struct device
 {
 	struct platform_device	*pdev = to_platform_device(dev);
 
+	/* prevent hotplug "modprobe $(MODALIAS)" from causing trouble in
+	 * legacy probe-the-hardware drivers, which don't properly split
+	 * out enumeration logic from drivers.
+	 */
+	if (dev->is_driver_not_hotpluggable)
+		return 0;
+
 	envp[0] = buffer;
 	snprintf(buffer, buffer_size, "MODALIAS=%s", pdev->name);
 	return 0;
