Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262716AbVCWCU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbVCWCU1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 21:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVCWCTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 21:19:19 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:51587 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262712AbVCWCOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 21:14:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=jM2EO3y3+5DrBtwfnGmKdXHme5WdPJTT475uXrTpsMKoSqA6tfZWMO9Dw2/NlULXswivvKeMiMcUPkv4eLiGYDbAT+egniDsuX6mYFwXn8WPkBAZk3Y8gTY/lx417g5ByeC0jffTDANeiskVQw2s1QVulg7ACdKV2w9u9o4GXM8=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050323021335.960F95F8@htj.dyndns.org>
In-Reply-To: <20050323021335.960F95F8@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 04/08] scsi: remove meaningless volatile qualifiers from structure definitions
Message-ID: <20050323021335.2655518E@htj.dyndns.org>
Date: Wed, 23 Mar 2005 11:14:39 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

04_scsi_remove_volatile.patch

	scsi_device->device_busy, Scsi_Host->host_busy and
	->host_failed have volatile qualifiers, but the qualifiers
	don't serve any purpose.  Kill them.  While at it, protect
	->host_failed update in scsi_error for consistency and clarity.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/scsi_error.c  |    6 +++++-
 include/scsi/scsi_device.h |    2 +-
 include/scsi/scsi_host.h   |    4 ++--
 3 files changed, 8 insertions(+), 4 deletions(-)

Index: scsi-export/drivers/scsi/scsi_error.c
===================================================================
--- scsi-export.orig/drivers/scsi/scsi_error.c	2005-03-23 09:40:09.000000000 +0900
+++ scsi-export/drivers/scsi/scsi_error.c	2005-03-23 09:40:10.000000000 +0900
@@ -652,9 +652,13 @@ static int scsi_request_sense(struct scs
 static void scsi_eh_finish_cmd(struct scsi_cmnd *scmd,
 			       struct list_head *done_q)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(scmd->device->host->host_lock, flags);
 	scmd->device->host->host_failed--;
-	scmd->state = SCSI_STATE_BHQUEUE;
+	spin_unlock_irqrestore(scmd->device->host->host_lock, flags);
 
+	scmd->state = SCSI_STATE_BHQUEUE;
 	scsi_eh_eflags_clr_all(scmd);
 
 	/*
Index: scsi-export/include/scsi/scsi_device.h
===================================================================
--- scsi-export.orig/include/scsi/scsi_device.h	2005-03-23 09:39:36.000000000 +0900
+++ scsi-export/include/scsi/scsi_device.h	2005-03-23 09:40:10.000000000 +0900
@@ -43,7 +43,7 @@ struct scsi_device {
 	struct list_head    siblings;   /* list of all devices on this host */
 	struct list_head    same_target_siblings; /* just the devices sharing same target id */
 
-	volatile unsigned short device_busy;	/* commands actually active on low-level */
+	unsigned short device_busy;	/* commands actually active on low-level */
 	spinlock_t sdev_lock;           /* also the request queue_lock */
 	spinlock_t list_lock;
 	struct list_head cmd_list;	/* queue of in use SCSI Command structures */
Index: scsi-export/include/scsi/scsi_host.h
===================================================================
--- scsi-export.orig/include/scsi/scsi_host.h	2005-03-23 09:39:36.000000000 +0900
+++ scsi-export/include/scsi/scsi_host.h	2005-03-23 09:40:10.000000000 +0900
@@ -448,8 +448,8 @@ struct Scsi_Host {
 	wait_queue_head_t       host_wait;
 	struct scsi_host_template *hostt;
 	struct scsi_transport_template *transportt;
-	volatile unsigned short host_busy;   /* commands actually active on low-level */
-	volatile unsigned short host_failed; /* commands that failed. */
+	unsigned short host_busy;	   /* commands actually active on low-level */
+	unsigned short host_failed;	   /* commands that failed. */
     
 	unsigned short host_no;  /* Used for IOCTL_GET_IDLUN, /proc/scsi et al. */
 	int resetting; /* if set, it means that last_reset is a valid value */

