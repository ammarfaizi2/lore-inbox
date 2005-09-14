Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932687AbVINIgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbVINIgj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 04:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbVINIgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 04:36:39 -0400
Received: from ozlabs.org ([203.10.76.45]:39637 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932480AbVINIgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 04:36:38 -0400
Date: Wed, 14 Sep 2005 18:06:29 +1000
From: Anton Blanchard <anton@samba.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, stern@rowland.harvard.edu
Subject: Re: [2.6.14-rc1] sym scsi boot hang
Message-ID: <20050914080629.GB19051@krispykreme>
References: <20050913124804.GA5008@in.ibm.com> <20050913131739.GD26162@krispykreme> <20050913142939.GE26162@krispykreme> <1126629345.4809.36.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126629345.4809.36.camel@mulgrave>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> If that's the cause, it's probably a double down of the host scan
> semaphore somewhere in the code.  alt-sysrq-t should work in this case,
> can you get a stack trace of the blocked process?

It appears to be this patch:

  [SCSI] SCSI core: fix leakage of scsi_cmnd's

  From:         Alan Stern <stern@rowland.harvard.edu>

  This patch (as559b) adds a new routine, scsi_unprep_request, which
  gets called every place a request is requeued.  (That includes
  scsi_queue_insert as well as scsi_requeue_command.)  It also changes
  scsi_kill_requests to make it call __scsi_done with result equal to
  DID_NO_CONNECT << 16.  (I'm not sure if it's necessary to call
  scsi_init_cmd_errh here; maybe you can check on that.)  Finally, the
  patch changes the return value from scsi_end_request, to avoid
  returning a stale pointer in the case where the request was requeued.
  Fortunately the return value is used in only place, and the change
  actually simplified it.


And in particular it looks like the scsi_unprep_request in
scsi_queue_insert is causing it. The following patch fixes the boot
problems on the vscsi machine:


Index: build/drivers/scsi/scsi_lib.c
===================================================================
--- build.orig/drivers/scsi/scsi_lib.c	2005-09-14 18:23:34.000000000 +1000
+++ build/drivers/scsi/scsi_lib.c	2005-09-14 18:27:33.000000000 +1000
@@ -188,7 +188,7 @@
 	 * function.  The SCSI request function detects the blocked condition
 	 * and plugs the queue appropriately.
          */
-	scsi_unprep_request(req);
+	//scsi_unprep_request(req);
 	spin_lock_irqsave(q->queue_lock, flags);
 	blk_requeue_request(q, req);
 	spin_unlock_irqrestore(q->queue_lock, flags);
