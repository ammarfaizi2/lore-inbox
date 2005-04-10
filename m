Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVDJSwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVDJSwE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVDJSwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:52:00 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:33580 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261578AbVDJSpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:45:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=OqLAAtfmajn1d01KSpdW/kUBSofRm20dz+iSAEgfIMW/YwcpxhLXUdc9WrR0/bWQ2ZeNFV9EWLIEJdtyhnktWZdmQy+5jt55CkaUV8LIomeYmk00KwN+sxJiuISxuA27r8Mlgrf03Hfe26ysCKqWozCHL9zf+dRWrVk+ldy9k7o=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050410184214.4AAD0992@htj.dyndns.org>
In-Reply-To: <20050410184214.4AAD0992@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 07/07] scsi: make reuse of SCSI cmd timer strict
Message-ID: <20050410184215.FFD7AAEA@htj.dyndns.org>
Date: Mon, 11 Apr 2005 03:45:41 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

07_scsi_timer_strict_reuse.patch

	SCSI cmd timer shouldn't be reused while it's active.  Make
	sure that the unused condition is marked with
	eh_timeout->function = NULL and BUG() active reuse path.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_error.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi_error.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_error.c	2005-04-11 03:42:12.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_error.c	2005-04-11 03:42:13.000000000 +0900
@@ -99,6 +99,8 @@ int scsi_eh_scmd_add(struct scsi_cmnd *s
  **/
 static void scsi_times_out(struct scsi_cmnd *scmd)
 {
+	scmd->eh_timeout.function = NULL;
+
 	scsi_log_completion(scmd, TIMEOUT_ERROR);
 
 	if (scmd->device->host->hostt->eh_timed_out)
@@ -136,14 +138,7 @@ static void scsi_times_out(struct scsi_c
  **/
 void scsi_add_timer(struct scsi_cmnd *scmd, int timeout)
 {
-
-	/*
-	 * If the clock was already running for this command, then
-	 * first delete the timer.  The timer handling code gets rather
-	 * confused if we don't do this.
-	 */
-	if (scmd->eh_timeout.function)
-		del_timer(&scmd->eh_timeout);
+	BUG_ON(scmd->eh_timeout.function);
 
 	scmd->eh_timeout.data = (unsigned long)scmd;
 	scmd->eh_timeout.expires = jiffies + timeout;
@@ -177,7 +172,6 @@ int scsi_delete_timer(struct scsi_cmnd *
 					 " rtn: %d\n", __FUNCTION__,
 					 scmd, rtn));
 
-	scmd->eh_timeout.data = (unsigned long)NULL;
 	scmd->eh_timeout.function = NULL;
 
 	return rtn;

