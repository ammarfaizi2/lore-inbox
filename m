Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWFJPgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWFJPgc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 11:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWFJPgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 11:36:32 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:50854 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751158AbWFJPgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 11:36:31 -0400
Subject: Re: [PATCH] hptiop: HighPoint RocketRAID 3xxx controller driver
From: James Bottomley <James.Bottomley@SteelEye.com>
To: HighPoint Linux Team <linux@highpoint-tech.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200605161438.09717.linux@highpoint-tech.com>
References: <200605101704.27491.linux@highpoint-tech.com>
	 <200605121107.48597.linux@highpoint-tech.com>
	 <200605161438.09717.linux@highpoint-tech.com>
Content-Type: text/plain
Date: Sat, 10 Jun 2006 10:36:22 -0500
Message-Id: <1149953782.3335.7.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 14:38 +0800, HighPoint Linux Team wrote: 
	_req = get_req(hba);
	if (_req == NULL) {
		dprintk("hptiop_queuecmd : no free req\n");
		scp->result = DID_BUS_BUSY << 16;
		goto cmd_done;
	}

This should be doing a return SCSI_MLQUEUE_HOST_BUSY.  DID_BUS_BUSY
doesn't do the resource contention counting that you want
(MLQUEUE_HOST_BUSY will wait until a command returns ... presumably
freeing up resources before trying another).


	/*
	 * hptiop_shutdown will flash controller cache.
	 */
	if (scp->cmnd[0] == SYNCHRONIZE_CACHE)  {
		scp->result = DID_OK<<16;
		goto cmd_done;
	}

Are you really sure you want to do this?  It looks like we'll be doing
this in cases where shutdown won't be called (like suspend). 

	host->can_queue = le32_to_cpu(iop_config.max_requests);
	host->cmd_per_lun = le32_to_cpu(iop_config.max_requests);

You might want to think about adjusting this.  For the single LUN case,
it's fine.  For the multi-lun case it may allow commands to a single LUN
to starve everything else.

However, these are minor points ... I'll put the driver in and you can
fix them up later.

James


