Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVCaJSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVCaJSr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 04:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVCaJPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 04:15:47 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:57171 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261228AbVCaJIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 04:08:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=F17zznw9hTDVlP/gdldLZUCVQrTqVUdLvLx08wKXIjNQjzDdpoxdyVYVPHvqcBgwze4yeQEi0YLvxbTb8A/TtFtwTvNtz4CD0i2erf3QIa2KBmIA2QVAcI3UZoZ9ka+kZZX5N8gKOqhLALeM/4XguH9nJxmGfUPAviHzrDZobwk=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050331090647.FEDC3964@htj.dyndns.org>
In-Reply-To: <20050331090647.FEDC3964@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 04/13] scsi: remove meaningless volatile qualifiers from structure definitions
Message-ID: <20050331090647.57213FBA@htj.dyndns.org>
Date: Thu, 31 Mar 2005 18:08:10 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

04_scsi_remove_volatile.patch

	scsi_device->device_busy, Scsi_Host->host_busy and
	->host_failed have volatile qualifiers, but the qualifiers
	don't serve any purpose.  Kill them.  While at it, protect
	->host_failed update in scsi_error for consistency and clarity.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_device.h |    3 ++-
 scsi_host.h   |   10 ++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

Index: scsi-export/include/scsi/scsi_device.h
===================================================================
--- scsi-export.orig/include/scsi/scsi_device.h	2005-03-31 17:42:05.000000000 +0900
+++ scsi-export/include/scsi/scsi_device.h	2005-03-31 18:06:20.000000000 +0900
@@ -43,7 +43,8 @@ struct scsi_device {
 	struct list_head    siblings;   /* list of all devices on this host */
 	struct list_head    same_target_siblings; /* just the devices sharing same target id */
 
-	volatile unsigned short device_busy;	/* commands actually active on low-level */
+	unsigned short device_busy;	/* commands actually active on
+					 * low-level. protected by sdev_lock. */
 	spinlock_t sdev_lock;           /* also the request queue_lock */
 	spinlock_t list_lock;
 	struct list_head cmd_list;	/* queue of in use SCSI Command structures */
Index: scsi-export/include/scsi/scsi_host.h
===================================================================
--- scsi-export.orig/include/scsi/scsi_host.h	2005-03-31 17:42:05.000000000 +0900
+++ scsi-export/include/scsi/scsi_host.h	2005-03-31 18:06:20.000000000 +0900
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
+	unsigned short host_busy;	   /* commands actually active on low-level */
+	unsigned short host_failed;	   /* commands that failed. */
     
 	unsigned short host_no;  /* Used for IOCTL_GET_IDLUN, /proc/scsi et al. */
 	int resetting; /* if set, it means that last_reset is a valid value */

