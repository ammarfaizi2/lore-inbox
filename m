Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTLQSSE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 13:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbTLQSSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 13:18:03 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:44511 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264496AbTLQSRn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 13:17:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: azarah@gentoo.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: scsi_id segfault with udev-009
Date: Wed, 17 Dec 2003 10:17:28 -0800
User-Agent: KMail/1.4.1
Cc: Greg KH <greg@kroah.com>
References: <1071682198.5067.17.camel@nosferatu.lan>
In-Reply-To: <1071682198.5067.17.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200312171017.28358.dsteklof@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 December 2003 09:29 am, Martin Schlemmer wrote:
> Hi
>
> Getting this with scsi_id and udev-009:


Hi,

Scsi_id hasn't been changed to use the latest libsysfs changes. The 
"directory" in the sysfs_class_device is now considered "private" and only 
should be accessed using functions. Treating the structures as handles lets 
us only load information when it's needed, reducing caching or stale 
information and also helping performance. 

Here's the problem.

static inline char *sysfs_get_attr(struct sysfs_class_device *dev,
                                    const char *attr)
{
        return sysfs_get_value_from_attributes(dev->directory->attributes,
                                               attr);
}

Please try this quick fix:

--- udev/extras/scsi_id/scsi_id.h	2003-12-08 01:42:46.000000000 -0800
+++ udev-fix/extras/scsi_id/scsi_id.h	2003-12-17 09:52:31.032184768 -0800
@@ -42,8 +42,14 @@
 static inline char *sysfs_get_attr(struct sysfs_class_device *dev,
 				    const char *attr)
 {
-	return sysfs_get_value_from_attributes(dev->directory->attributes,
-					       attr);
+	struct dlist *attributes = NULL;
+
+	attributes = sysfs_get_classdev_attributes(dev);
+
+	if (attributes == NULL)
+		return NULL;
+
+	return sysfs_get_value_from_attributes(attributes, attr);
 }
 
 extern int scsi_get_serial (struct sysfs_class_device *scsi_dev,
--- udev/extras/scsi_id/scsi_id.c	2003-12-08 01:42:46.000000000 -0800
+++ udev-fix/extras/scsi_id/scsi_id.c	2003-12-17 09:55:54.113311744 -0800
@@ -133,7 +133,7 @@
 		return -1;
 
 	snprintf(bus_dev_name, MAX_NAME_LEN, "%s/%s/%s/%s/%s", sysfs_mnt_path,
-		 SYSFS_BUS_DIR, bus, SYSFS_DEVICES_NAME, bus_id);
+		 SYSFS_BUS_NAME, bus, SYSFS_DEVICES_NAME, bus_id);
 
 	if (stat(sysfs_path, &stat_buf))
 		return -1;

