Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266334AbUAOHp7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 02:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266338AbUAOHp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 02:45:59 -0500
Received: from [81.193.98.140] ([81.193.98.140]:24201 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S266334AbUAOHp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 02:45:56 -0500
Message-ID: <400645D9.1040400@vgertech.com>
Date: Thu, 15 Jan 2004 07:48:41 +0000
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: linux-hotplug-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 013 release
References: <20040113235213.GA7659@kroah.com> <4004D084.1050106@vgertech.com> <20040114171527.GB5472@kroah.com> <40058086.5000106@nortelnetworks.com> <4005971F.4020608@vgertech.com> <20040114211417.GC6650@kroah.com>
In-Reply-To: <20040114211417.GC6650@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------010803080408000807060208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010803080408000807060208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

Greg KH wrote:
> On Wed, Jan 14, 2004 at 07:23:11PM +0000, Nuno Silva wrote:
> 
>>This would be nice but I think that full info for every new hotplugged 
>>device is even better. It's only 1 line :-)
> 
> 
> Heh, care to make that one line patch?  :)
> 

Ehehehe I was talking about the extra line ending up in syslog. :-)

Anyway, attached is a simple patch that outputs 50% of what I'd like to 
see - still missing the SYSFS_model, serial, etc because 
sysfs_get_classdev_attributes didn't work at my first try, but that's my 
faulty C showing :)

Thanks,
Nuno Silva

--------------010803080408000807060208
Content-Type: text/plain;
 name="udev-report-details.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="udev-report-details.diff"

diff -Naur udev-013.orig/logging.c udev-013/logging.c
--- udev-013.orig/logging.c	2003-12-15 21:57:35.000000000 +0000
+++ udev-013/logging.c	2004-01-15 02:52:36.000000000 +0000
@@ -27,8 +27,6 @@
 #include <syslog.h>
 #include "udev.h"
 
-#ifdef DEBUG
-
 static int logging_init = 0;
 static unsigned char udev_logname[42];
 
@@ -55,4 +53,3 @@
 	return 1;
 }
 
-#endif
diff -Naur udev-013.orig/namedev.c udev-013/namedev.c
--- udev-013.orig/namedev.c	2004-01-13 22:52:57.000000000 +0000
+++ udev-013/namedev.c	2004-01-15 07:40:40.000000000 +0000
@@ -748,6 +748,13 @@
 		udev->owner[0] = 0x00;
 		udev->group[0] = 0x00;
 	}
+	/* notify syslog and report some of the configuration: */
+	/* FIXME: add SYSFS_* nodes, too */
+	dbg_syslog("New device! Metrics: BUS='%s', ID='%s', KERNEL='%s'",
+	    sysfs_device->bus, sysfs_device->bus_id, class_dev->name);
+	dbg_syslog("name, '%s' is going to have owner='%s', group='%s', mode = %#o",
+	    udev->name, udev->owner, udev->group, udev->mode);
+
 	dbg("name, '%s' is going to have owner='%s', group='%s', mode = %#o",
 	    udev->name, udev->owner, udev->group, udev->mode);
 
diff -Naur udev-013.orig/udev.h udev-013/udev.h
--- udev-013.orig/udev.h	2004-01-13 01:50:34.000000000 +0000
+++ udev-013/udev.h	2004-01-14 23:22:08.000000000 +0000
@@ -25,9 +25,14 @@
 
 #include "libsysfs/libsysfs.h"
 #include <sys/param.h>
+#include <syslog.h>
+
+#define dbg_syslog(format, arg...)							\
+	do {										\
+		log_message (LOG_DEBUG , "%s: " format , __FUNCTION__ , ## arg);	\
+	} while (0)
 
 #ifdef DEBUG
-#include <syslog.h>
 #define dbg(format, arg...)								\
 	do {										\
 		log_message (LOG_DEBUG , "%s: " format , __FUNCTION__ , ## arg);	\

--------------010803080408000807060208--

