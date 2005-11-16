Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbVKPIpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbVKPIpw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbVKPIpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:45:52 -0500
Received: from verein.lst.de ([213.95.11.210]:61614 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1030214AbVKPIpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:45:51 -0500
Date: Wed, 16 Nov 2005 09:45:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] add compat_ioctl methods to dasd
Message-ID: <20051116084544.GA25181@lst.de>
References: <20051104221652.GB9384@lst.de> <20051112093340.GA15702@lst.de> <1132066277.6014.35.camel@localhost.localdomain> <20051115172438.GA10445@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115172438.GA10445@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 06:24:38PM +0100, Christoph Hellwig wrote:
> > and doesn't work after fixing the compile problem. It's a
> > problem with the bdev->bd_disk->private_data which is NULL at the time
> > the partition detection code calls the BIODASDINFO and HDIO_GETGEO ioctl
> > with ioctl_by_bdev. I don't see an easy way to fix this right now.
> 
> my patch doesn't change anything related to dereferencing those fields.
> 
> I see the problem that you're probably having: ioctl_by_bdev calls
> ->ioctl without ensuring ->open has been called previously.  But I don't
> see why this couldn't have happened previously.

So looking at it again I found a bug:  we return EINVAL on an invalid
ioctl, but the compat layer expects ENOIOCTLCMD so it returns using the
generic compat bits.  Returning ENOIOCTLCMD from unlocked_ioctl is fine
aswell as the ioctl layer turns it back.  The patch below fix this issue
and the missing semicolon after lock_kernel()


Index: linux-2.6/drivers/s390/block/dasd_ioctl.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd_ioctl.c	2005-11-16 00:59:04.000000000 +0100
+++ linux-2.6/drivers/s390/block/dasd_ioctl.c	2005-11-16 01:02:36.000000000 +0100
@@ -86,11 +86,11 @@
 	struct dasd_device *device = bdev->bd_disk->private_data;
 	struct dasd_ioctl *ioctl;
 	const char *dir;
-	int rc = -EINVAL;
+	int rc = -ENOIOCTLCMD;
 
 	if ((_IOC_DIR(no) != _IOC_NONE) && (data == 0)) {
 		PRINT_DEBUG("empty data ptr");
-		return -EINVAL;
+		goto out;
 	}
 	dir = _IOC_DIR (no) == _IOC_NONE ? "0" :
 		_IOC_DIR (no) == _IOC_READ ? "r" :
@@ -100,7 +100,7 @@
 		      "ioctl 0x%08x %s'0x%x'%d(%d) with data %8lx", no,
 		      dir, _IOC_TYPE(no), _IOC_NR(no), _IOC_SIZE(no), data);
 
-	lock_kernel()
+	lock_kernel();
 	/* Search for ioctl no in the ioctl list. */
 	list_for_each_entry(ioctl, &dasd_ioctl_list, list) {
 		if (ioctl->no == no) {
@@ -109,15 +109,16 @@
 				continue;
 			rc = ioctl->handler(bdev, no, data);
 			module_put(ioctl->owner);
-			goto out;
+			break;
 		}
 	}
 	/* No ioctl with number no. */
 	DBF_DEV_EVENT(DBF_INFO, device,
 		      "unknown ioctl 0x%08x=%s'0x%x'%d(%d) data %8lx", no,
 		      dir, _IOC_TYPE(no), _IOC_NR(no), _IOC_SIZE(no), data);
- out:
+ out_unlock:
 	unlock_kernel();
+ out:
 	return rc;
 }
 
