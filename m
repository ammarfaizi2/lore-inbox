Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTDPR6N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 13:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264497AbTDPR6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 13:58:12 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:46784 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264496AbTDPR6H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 13:58:07 -0400
Date: Wed, 16 Apr 2003 11:05:29 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Gert Vervoort <gert.vervoort@hccnet.nl>
Cc: tconnors@astro.swin.edu.au, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
Message-ID: <20030416110529.A5782@beaverton.ibm.com>
References: <3E982AAC.3060606@hccnet.nl> <1050172083.2291.459.camel@localhost> <3E993C54.40805@hccnet.nl> <1050255133.733.6.camel@localhost> <3E99A1E4.30904@hccnet.nl> <20030415120000.A30422@beaverton.ibm.com> <3E9C6F10.10001@hccnet.nl> <20030415144051.A31514@beaverton.ibm.com> <3E9D984F.20402@hccnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E9D984F.20402@hccnet.nl>; from gert.vervoort@hccnet.nl on Wed, Apr 16, 2003 at 07:52:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 07:52:15PM +0200, Gert Vervoort wrote:

> bh?: old sense key No Sense
> Non-extended sense class 0 code 0x0
> Waking error handler thread
> Error handler scsi_eh_0 waking up
> scsi_eh_prt_fail_stats: 0:0:6:0 cmds failed: 1, cancel: 0
> Total of 1 commands on 1 devices require eh work
> scsi_eh_0: requesting sense for id: 6
> scsi_add_timer: scmd: c7ea4060, time: 10000, (c0239f10)
> scsi_eh_done scmd: c7ea4060 result: 0
> scsi_send_eh_cmnd: scmd: c7ea4060, rtn:2002
> scsi_send_eh_cmnd: scsi_eh_completed_normally 2002
> sense requested for c7ea4060 result 2
> Current bh?: sense key Unit Attention
> Additional sense: Not ready to ready change, medium may have changed

The ppa driver did not do auto-sense, so we run the error handler
to get the sense code.

There was a missing call to scsi_queue_next_request for door locking (the
ioctl in the scsi log output, ALLOW_MEDIUM_REMOVAL value 30, or 0x1e),
Mike A posted this patch to linux-scsi in response to some debugging leg
work of Alan Stern, does this fix your problem?

Not sure if it patches clean against 2.5.67, but it's pretty simple.

DESC
The patch adds a call to scsi_queue_next_request from scsi_release_request. It
also removes a call in scsi_eh_lock_done to scsi_put_command.
scsi_release_request will do a call to scsi_put_command if needed.
EDESC


 drivers/scsi/scsi.c       |    2 ++
 drivers/scsi/scsi_error.c |    4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/scsi/scsi.c~scsi-release-req drivers/scsi/scsi.c
--- sysfs-bleed-2.5/drivers/scsi/scsi.c~scsi-release-req	Mon Apr 14 15:34:14 2003
+++ sysfs-bleed-2.5-andmike/drivers/scsi/scsi.c	Mon Apr 14 15:34:14 2003
@@ -224,8 +224,10 @@ void scsi_release_request(Scsi_Request *
 {
 	if( req->sr_command != NULL )
 	{
+    		request_queue_t *q = req->sr_device->request_queue;
 		scsi_put_command(req->sr_command);
 		req->sr_command = NULL;
+		scsi_queue_next_request(q, NULL);
 	}
 
 	kfree(req);
diff -puN drivers/scsi/scsi_error.c~scsi-release-req drivers/scsi/scsi_error.c
--- sysfs-bleed-2.5/drivers/scsi/scsi_error.c~scsi-release-req	Mon Apr 14 15:34:14 2003
+++ sysfs-bleed-2.5-andmike/drivers/scsi/scsi_error.c	Mon Apr 14 15:34:14 2003
@@ -1334,10 +1334,6 @@ static void scsi_eh_lock_done(struct scs
 {
 	struct scsi_request *sreq = scmd->sc_request;
 
-	scmd->sc_request = NULL;
-	sreq->sr_command = NULL;
-
-	scsi_put_command(scmd);
 	scsi_release_request(sreq);
 }
