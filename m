Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVDLNra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVDLNra (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVDLMzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:55:48 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:61786 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262430AbVDLMwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:52:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=tZadH773WjsR5vbL36DN6Em1ku8iAYOC/HtXdxfiXqU6/gvaUTtLDdX/jM7sUQkrWJFsGayh22I/CqD3c7lwNXNXgi4jPDSDP3DYEssOTWypDBgAZ6IPsMWnrZ2i5rT8qsguMkz4jywYBm09/PyJ7V2FfSw/NsX8gFXg9170cNY=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050412125219.88E5C1F6@htj.dyndns.org>
In-Reply-To: <20050412125219.88E5C1F6@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 03/07] scsi: replace scsi_queue_insert() usages with scsi_retry_command()
Message-ID: <20050412125219.D4AAB938@htj.dyndns.org>
Date: Tue, 12 Apr 2005 21:52:36 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

03_scsi_requeue_use_scsi_retry_command_instead_of_scsi_queue_insert.patch

	There are two users of scsi_queue_insert() left now.  One in
	scsi_softirq() and the other in scsi_eh_flush_done_q().  The
	only additional functionality of scsi_queue_insert() used is
	setting device_blocked on ADD_TO_MLQUEUE case in
	scsi_softirq().

	Open code device_blocked setting and replace
	scsi_queue_insert() with scsi_retry_command() in both cases.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi.c       |    7 ++++---
 scsi_error.c |    2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi.c	2005-04-12 21:50:11.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi.c	2005-04-12 21:50:11.000000000 +0900
@@ -638,6 +638,7 @@ static void scsi_softirq(struct softirq_
 	while (!list_empty(&local_q)) {
 		struct scsi_cmnd *cmd = list_entry(local_q.next,
 						   struct scsi_cmnd, eh_entry);
+		struct scsi_device *sdev = cmd->device;
 		list_del_init(&cmd->eh_entry);
 
 		disposition = scsi_decide_disposition(cmd);
@@ -646,12 +647,12 @@ static void scsi_softirq(struct softirq_
 		case SUCCESS:
 			scsi_finish_command(cmd);
 			break;
+		case ADD_TO_MLQUEUE:
+			sdev->device_blocked = sdev->max_device_blocked;
+			/* fall through */
 		case NEEDS_RETRY:
 			scsi_retry_command(cmd);
 			break;
-		case ADD_TO_MLQUEUE:
-			scsi_queue_insert(cmd, SCSI_MLQUEUE_DEVICE_BUSY);
-			break;
 		default:
 			if (!scsi_eh_scmd_add(cmd, 0))
 				scsi_finish_command(cmd);
Index: scsi-reqfn-export/drivers/scsi/scsi_error.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_error.c	2005-04-12 21:50:10.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_error.c	2005-04-12 21:50:11.000000000 +0900
@@ -1522,7 +1522,7 @@ static void scsi_eh_flush_done_q(struct 
 							  " retry cmd: %p\n",
 							  current->comm,
 							  scmd));
-				scsi_queue_insert(scmd, SCSI_MLQUEUE_EH_RETRY);
+			scsi_retry_command(scmd);
 		} else {
 			if (!scmd->result)
 				scmd->result |= (DRIVER_TIMEOUT << 24);

