Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263966AbTCUUIz>; Fri, 21 Mar 2003 15:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263970AbTCUUHv>; Fri, 21 Mar 2003 15:07:51 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:43268
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263966AbTCUUGq>; Fri, 21 Mar 2003 15:06:46 -0500
Subject: Re: 2.5.65-mm3
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030320235821.1e4ff308.akpm@digeo.com>
References: <20030320235821.1e4ff308.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1048277871.4908.36.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 21 Mar 2003 15:17:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-21 at 02:58, Andrew Morton wrote:

> dev_t-3-major_h-cleanup.patch
>   dev_t [3/3]: major.h cleanups
> 
> dev_t-32-bit.patch
>   [for playing only] change type of dev_t

Now that dev_t is an unsigned long, MKDEV() correspondingly returns an
unsigned long.  This causes a compiler warning and potential bug on
64-bit architectures in drivers/scsi/sg.c :: sg_device_kdev_read().

This patch needs to be applied on top of the dev_t patches.

	Robert Love


 drivers/scsi/sg.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


diff -urN linux-2.5.65-mm3/drivers/scsi/sg.c linux/drivers/scsi/sg.c
--- linux-2.5.65-mm3/drivers/scsi/sg.c	2003-03-17 16:44:05.000000000 -0500
+++ linux/drivers/scsi/sg.c	2003-03-19 11:35:50.706607408 -0500
@@ -1331,9 +1331,11 @@
 sg_device_kdev_read(struct device *driverfs_dev, char *page)
 {
 	Sg_device *sdp = list_entry(driverfs_dev, Sg_device, sg_driverfs_dev);
-	return sprintf(page, "%x\n", MKDEV(sdp->disk->major,
-					   sdp->disk->first_minor));
+
+	return sprintf(page, "%lx\n", MKDEV(sdp->disk->major,
+					sdp->disk->first_minor));
 }
+
 static DEVICE_ATTR(kdev,S_IRUGO,sg_device_kdev_read,NULL);
 
 static ssize_t



