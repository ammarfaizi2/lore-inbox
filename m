Return-Path: <linux-kernel-owner+w=401wt.eu-S932670AbWLSIfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbWLSIfl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbWLSIfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:35:41 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:53539 "EHLO
	noname.neutralserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663AbWLSIfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:35:39 -0500
X-Greylist: delayed 30760 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 03:35:39 EST
Date: Tue, 19 Dec 2006 10:35:07 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: linux-scsi@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>
Subject: [PATCH] scsi_execute_async() should add to the tail of the queue
Message-ID: <20061219083507.GA20847@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

scsi_execute_async() has replaced scsi_do_req() a few versions ago, 
but it also incurred a change of behavior. I noticed that over-queuing 
a SCSI device using that function causes I/Os to be starved from 
low-level queuing for no justified reason.
 
I think it makes much more sense to perserve the original behaviour 
of scsi_do_req() and add the request to the tail of the queue.

Signed-off-by: Dan Aloni <da-x@monatomic.org>

diff -p -urN a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c	2006-12-19 01:48:50.000000000 +0200
+++ b/drivers/scsi/scsi_lib.c	2006-12-19 01:49:35.000000000 +0200
@@ -421,7 +421,7 @@ int scsi_execute_async(struct scsi_devic
 	sioc->data = privdata;
 	sioc->done = done;
 
-	blk_execute_rq_nowait(req->q, NULL, req, 1, scsi_end_async);
+	blk_execute_rq_nowait(req->q, NULL, req, 0, scsi_end_async);
 	return 0;
 
 free_req:


 - Dan
