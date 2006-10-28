Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752149AbWJ1Lb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbWJ1Lb4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 07:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbWJ1Lbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 07:31:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4519 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752136AbWJ1Lby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 07:31:54 -0400
Date: Sat, 28 Oct 2006 12:31:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [patch 5/5] scsi: fix uaccess handling
Message-ID: <20061028113143.GB14785@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	James Bottomley <James.Bottomley@steeleye.com>
References: <20061026130010.GA7127@osiris.boeblingen.de.ibm.com> <20061026130452.GF7127@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026130452.GF7127@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2006 at 03:04:52PM +0200, Heiko Carstens wrote:
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>  drivers/scsi/scsi_ioctl.c |   17 +++++++++-------
>  drivers/scsi/sg.c         |   47 ++++++++++++++++++++++++----------------------
>  2 files changed, 35 insertions(+), 29 deletions(-)
> 
> Index: linux-2.6/drivers/scsi/scsi_ioctl.c
> ===================================================================
> --- linux-2.6.orig/drivers/scsi/scsi_ioctl.c	2006-10-26 14:40:55.000000000 +0200
> +++ linux-2.6/drivers/scsi/scsi_ioctl.c	2006-10-26 14:42:14.000000000 +0200
> @@ -217,13 +217,16 @@
>  		if (!access_ok(VERIFY_WRITE, arg, sizeof(struct scsi_idlun)))
>  			return -EFAULT;
>  
> -		__put_user((sdev->id & 0xff)
> -			 + ((sdev->lun & 0xff) << 8)
> -			 + ((sdev->channel & 0xff) << 16)
> -			 + ((sdev->host->host_no & 0xff) << 24),
> -			 &((struct scsi_idlun __user *)arg)->dev_id);
> -		__put_user(sdev->host->unique_id,
> -			 &((struct scsi_idlun __user *)arg)->host_unique_id);
> +		if (__put_user((sdev->id & 0xff)
> +			       + ((sdev->lun & 0xff) << 8)
> +			       + ((sdev->channel & 0xff) << 16)
> +			       + ((sdev->host->host_no & 0xff) << 24),
> +			       &((struct scsi_idlun __user *)arg)->dev_id))
> +			return -EFAULT;
> +

While not your fault I'd suggest to fix the __put_user abuse at the same
time, as in the untested patch below for scsi_ioctl.c:

Index: linux-2.6/drivers/scsi/scsi_ioctl.c
===================================================================
--- linux-2.6.orig/drivers/scsi/scsi_ioctl.c	2006-10-28 13:24:18.000000000 +0200
+++ linux-2.6/drivers/scsi/scsi_ioctl.c	2006-10-28 13:30:17.000000000 +0200
@@ -173,6 +173,21 @@
         return copy_to_user(arg, dev->bus_id, sizeof(dev->bus_id))? -EFAULT: 0;
 }
 
+static int scsi_get_idlun(struct scsi_device *sdev,
+		struct scsi_idlun __user *arg)
+{
+	struct scsi_idlun karg = {
+		.dev_id		= (sdev->id & 0xff) +
+			          ((sdev->lun & 0xff) << 8) +
+				  ((sdev->channel & 0xff) << 16) +
+				  ((sdev->host->host_no & 0xff) << 24),
+		.host_unique_id	= sdev->host->unique_id
+	};
+
+	if (copy_to_user(arg, &karg, sizeof(struct scsi_idlun)))
+		return -EFAULT;
+	return 0;
+}
 
 /*
  * the scsi_ioctl() function differs from most ioctls in that it does
@@ -214,17 +229,7 @@
 
 	switch (cmd) {
 	case SCSI_IOCTL_GET_IDLUN:
-		if (!access_ok(VERIFY_WRITE, arg, sizeof(struct scsi_idlun)))
-			return -EFAULT;
-
-		__put_user((sdev->id & 0xff)
-			 + ((sdev->lun & 0xff) << 8)
-			 + ((sdev->channel & 0xff) << 16)
-			 + ((sdev->host->host_no & 0xff) << 24),
-			 &((struct scsi_idlun __user *)arg)->dev_id);
-		__put_user(sdev->host->unique_id,
-			 &((struct scsi_idlun __user *)arg)->host_unique_id);
-		return 0;
+		return scsi_get_idlun(sdev, arg);
 	case SCSI_IOCTL_GET_BUS_NUMBER:
 		return put_user(sdev->host->host_no, (int __user *)arg);
 	case SCSI_IOCTL_PROBE_HOST:
