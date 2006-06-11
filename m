Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWFKIxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWFKIxR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 04:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWFKIxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 04:53:17 -0400
Received: from stats.hypersurf.com ([209.237.0.12]:12555 "EHLO
	stats.hypersurf.com") by vger.kernel.org with ESMTP
	id S1750820AbWFKIxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 04:53:17 -0400
From: HighPoint Linux Team <linux@highpoint-tech.com>
Organization: HighPoint Technologies, Inc.
To: James.Bottomley@SteelEye.com
Subject: Re: [PATCH] hptiop: HighPoint RocketRAID 3xxx controller driver
Date: Sun, 11 Jun 2006 17:07:31 +0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, akpm@osdl.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606111706.52930.linux@highpoint-tech.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, June 10, 2006 11:36 PM, James Bottomley wrote: 
>	_req = get_req(hba);
>	if (_req == NULL) {
>		dprintk("hptiop_queuecmd : no free req\n");
>		scp->result = DID_BUS_BUSY << 16;
>		goto cmd_done;
>	}
> 
> This should be doing a return SCSI_MLQUEUE_HOST_BUSY.  DID_BUS_BUSY
> doesn't do the resource contention counting that you want
> (MLQUEUE_HOST_BUSY will wait until a command returns ... presumably
> freeing up resources before trying another).

Right, this should be modified.

>	/*
>	 * hptiop_shutdown will flash controller cache.
>	 */
>	if (scp->cmnd[0] == SYNCHRONIZE_CACHE)  {
>		scp->result = DID_OK<<16;
>		goto cmd_done;
>	}
>
> Are you really sure you want to do this?  It looks like we'll be doing
> this in cases where shutdown won't be called (like suspend). 

These lines should be removed. The controller firmware will response to
SYNCHRONIZE_CACHE command.

>	host->can_queue = le32_to_cpu(iop_config.max_requests);
>	host->cmd_per_lun = le32_to_cpu(iop_config.max_requests);
> 
> You might want to think about adjusting this.  For the single LUN case,
> it's fine.  For the multi-lun case it may allow commands to a single LUN
> to starve everything else.

There will be no multi-lun support for the controller so this is not
an issue.

Signed-off-by: HighPoint Linux Team <linux@highpoint-tech.com>
---

diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index 8302f3b..7806c45 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -504,18 +504,10 @@ static int hptiop_queuecommand(struct sc
 	BUG_ON(!done);
 	scp->scsi_done = done;
 
-	/*
-	 * hptiop_shutdown will flash controller cache.
-	 */
-	if (scp->cmnd[0] == SYNCHRONIZE_CACHE)  {
-		scp->result = DID_OK<<16;
-		goto cmd_done;
-	}
-
 	_req = get_req(hba);
 	if (_req == NULL) {
 		dprintk("hptiop_queuecmd : no free req\n");
-		scp->result = DID_BUS_BUSY << 16;
+		scp->result = SCSI_MLQUEUE_HOST_BUSY;
 		goto cmd_done;
 	}


