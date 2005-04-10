Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVDJEOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVDJEOS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 00:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVDJEOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 00:14:18 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:33273 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261425AbVDJEOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 00:14:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=HHF039dhNNn0/T6qKGWpUKY8WmNwveTMauvXAn6/wVDFjlSZ8BVrK+zye4fGRXVakVxrfEDqsPk+MtkCMHB5WMJNlee4fKbPLe4VDjLvCoF84YyriREKpolEM3zZqa1ni42sBaS+ZxDoK4iDq7L1gtF7h+NZXuAdtZ9B8jg7YL4=
Date: Sun, 10 Apr 2005 13:14:04 +0900
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH linux-misc-2.6] scsi: remove volatile from scsi data structures
Message-ID: <20050410041404.GA24158@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, James.
 Hello, Christoph.

 This patch removes volatile qualifier from scsi_device->device_busy,
Scsi_Host->host_busy and ->host_failed as the volatile qualifiers
don't serve any purpose now.  While at it, convert those fields from
unsigned short to unsigned int as suggested by Christoph.


Signed-off-by: Tejun Heo <htejun@gmail.com>


Index: scsi-reqfn-export/include/scsi/scsi_device.h
===================================================================
--- scsi-reqfn-export.orig/include/scsi/scsi_device.h	2005-04-10 13:03:14.000000000 +0900
+++ scsi-reqfn-export/include/scsi/scsi_device.h	2005-04-10 13:04:42.000000000 +0900
@@ -43,7 +43,8 @@ struct scsi_device {
 	struct list_head    siblings;   /* list of all devices on this host */
 	struct list_head    same_target_siblings; /* just the devices sharing same target id */
 
-	volatile unsigned short device_busy;	/* commands actually active on low-level */
+	unsigned int device_busy;	/* commands actually active on
+					 * low-level. protected by queue_lock. */
 	spinlock_t sdev_lock;           /* also the request queue_lock */
 	spinlock_t list_lock;
 	struct list_head cmd_list;	/* queue of in use SCSI Command structures */
Index: scsi-reqfn-export/include/scsi/scsi_host.h
===================================================================
--- scsi-reqfn-export.orig/include/scsi/scsi_host.h	2005-04-10 13:03:14.000000000 +0900
+++ scsi-reqfn-export/include/scsi/scsi_host.h	2005-04-10 13:04:42.000000000 +0900
@@ -448,8 +448,14 @@ struct Scsi_Host {
 	wait_queue_head_t       host_wait;
 	struct scsi_host_template *hostt;
 	struct scsi_transport_template *transportt;
-	volatile unsigned short host_busy;   /* commands actually active on low-level */
-	volatile unsigned short host_failed; /* commands that failed. */
+
+	/*
+	 * The following two fields are protected with host_lock;
+	 * however, eh routines can safely access during eh processing
+	 * without acquiring the lock.
+	 */
+	unsigned int host_busy;		   /* commands actually active on low-level */
+	unsigned int host_failed;	   /* commands that failed. */
     
 	unsigned short host_no;  /* Used for IOCTL_GET_IDLUN, /proc/scsi et al. */
 	int resetting; /* if set, it means that last_reset is a valid value */
