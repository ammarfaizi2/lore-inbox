Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbUCRLBK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 06:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbUCRLBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 06:01:10 -0500
Received: from ozlabs.org ([203.10.76.45]:25064 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262517AbUCRK7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 05:59:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16473.32070.733168.354075@cargo.ozlabs.ibm.com>
Date: Thu, 18 Mar 2004 21:43:18 +1100
From: Paul Mackerras <paulus@samba.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: HID_MAX_USAGES undefined
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech,

Recently you added code to include/linux/hiddev.h that looks like
this:

/* hiddev_usage_ref_multi is used for sending multiple bytes to a control.
 * It really manifests itself as setting the value of consecutive usages */
struct hiddev_usage_ref_multi {
	struct hiddev_usage_ref uref;
	__u32 num_values;
	__s32 values[HID_MAX_USAGES];
};

However, the only place that I could see where HID_MAX_USAGES is
defined is in drivers/usb/input/hid.h.

Worse, the size of hiddev_usage_ref_multi (which depends on
HID_MAX_USAGES) determines values that userland needs to know:

#define HIDIOCGUSAGES		_IOWR('H', 0x13, struct hiddev_usage_ref_multi)
#define HIDIOCSUSAGES		_IOW('H', 0x14, struct hiddev_usage_ref_multi)

Could you move the HID_MAX_USAGES definition to include/linux/hiddev.h
please?

I found this because I have a local hack to let me use various HID
ioctls from a 32-bit process running under a ppc64 kernel.  I have
included the patch I am using below.  It isn't complete, though,
because there are some HID ioctl command values which are a whole
range of commands:

#define HIDIOCGNAME(len)	_IOC(_IOC_READ, 'H', 0x06, len)
#define HIDIOCGPHYS(len)	_IOC(_IOC_READ, 'H', 0x12, len)

This might be a clever trick but it makes life hard for those of us
trying to support 32-bit processes on 64-bit kernels.  For now I have
just left them out, since I don't need to use them.  (The HID
application that I have is a little program that sets the backlight
brightness on my Apple LCD monitor.)

Regards,
Paul.

diff -urN linux-2.5/arch/ppc64/kernel/ioctl32.c g5-ppc64/arch/ppc64/kernel/ioctl32.c
--- linux-2.5/arch/ppc64/kernel/ioctl32.c	2004-02-26 16:34:13.000000000 +1100
+++ g5-ppc64/arch/ppc64/kernel/ioctl32.c	2004-03-18 21:28:08.426019720 +1100
@@ -24,6 +24,8 @@
 #include "compat_ioctl.c"
 #include <linux/ncp_fs.h>
 #include <linux/syscalls.h>
+#define HID_MAX_USAGES	1024		/* XXX completely bogus... */
+#include <linux/hiddev.h>
 #include <asm/ppc32.h>
 
 #define CODE
diff -urN linux-2.5/include/linux/compat_ioctl.h g5-ppc64/include/linux/compat_ioctl.h
--- linux-2.5/include/linux/compat_ioctl.h	2004-03-16 08:12:19.000000000 +1100
+++ g5-ppc64/include/linux/compat_ioctl.h	2004-03-18 21:07:11.945995312 +1100
@@ -691,3 +691,20 @@
 COMPATIBLE_IOCTL(SIOCGIWRETRY)
 COMPATIBLE_IOCTL(SIOCSIWPOWER)
 COMPATIBLE_IOCTL(SIOCGIWPOWER)
+/* Big H for USB HID devices */
+COMPATIBLE_IOCTL(HIDIOCGVERSION)
+COMPATIBLE_IOCTL(HIDIOCAPPLICATION)
+COMPATIBLE_IOCTL(HIDIOCGDEVINFO)
+COMPATIBLE_IOCTL(HIDIOCGSTRING)
+COMPATIBLE_IOCTL(HIDIOCINITREPORT)
+COMPATIBLE_IOCTL(HIDIOCGREPORT)
+COMPATIBLE_IOCTL(HIDIOCSREPORT)
+COMPATIBLE_IOCTL(HIDIOCGREPORTINFO)
+COMPATIBLE_IOCTL(HIDIOCGFIELDINFO)
+COMPATIBLE_IOCTL(HIDIOCGUSAGE)
+COMPATIBLE_IOCTL(HIDIOCSUSAGE)
+COMPATIBLE_IOCTL(HIDIOCGUCODE)
+COMPATIBLE_IOCTL(HIDIOCGFLAG)
+COMPATIBLE_IOCTL(HIDIOCSFLAG)
+COMPATIBLE_IOCTL(HIDIOCGCOLLECTIONINDEX)
+COMPATIBLE_IOCTL(HIDIOCGCOLLECTIONINFO)
diff -urN linux-2.5/include/linux/hiddev.h g5-ppc64/include/linux/hiddev.h
--- linux-2.5/include/linux/hiddev.h	2004-03-17 22:09:24.000000000 +1100
+++ g5-ppc64/include/linux/hiddev.h	2004-03-18 21:18:57.279934968 +1100
@@ -213,6 +213,10 @@
  */
 
 #ifdef CONFIG_USB_HIDDEV
+struct hid_device;
+struct hid_usage;
+struct hid_field;
+struct hid_report;
 int hiddev_connect(struct hid_device *);
 void hiddev_disconnect(struct hid_device *);
 void hiddev_hid_event(struct hid_device *hid, struct hid_field *field,
