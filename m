Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVCaKgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVCaKgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 05:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVCaKfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 05:35:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:31971 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261230AbVCaKcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 05:32:05 -0500
Date: Thu, 31 Mar 2005 11:32:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tejun Heo <htejun@gmail.com>
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH scsi-misc-2.6 11/13] scsi: add reprep arg to scsi_requeue_command() and make it public
Message-ID: <20050331103203.GA14266@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tejun Heo <htejun@gmail.com>, James.Bottomley@steeleye.com,
	axboe@suse.de, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20050331090647.FEDC3964@htj.dyndns.org> <20050331090647.ABDB1FF4@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331090647.ABDB1FF4@htj.dyndns.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - * Arguments:	q	- queue to operate on
> - *		cmd	- command that may need to be requeued.
> + * Arguments:	cmd	- command that may need to be requeued.
> + *		reprep	- needs to prep the command again?
>   *
>   * Returns:	Nothing
>   *
> @@ -478,11 +478,16 @@ void scsi_device_unbusy(struct scsi_devi
>   *		we need to request the blocks that come after the bad
>   *		sector.
>   */
> -static void scsi_requeue_command(struct request_queue *q, struct scsi_cmnd *cmd)
> +void scsi_requeue_command(struct scsi_cmnd *cmd, int reprep)
>  {
> +	struct request_queue *q = cmd->device->request_queue;
>  	unsigned long flags;
>  
> -	cmd->request->flags &= ~REQ_DONTPREP;
> +	cmd->state = SCSI_STATE_MLQUEUE;
> +	cmd->owner = SCSI_OWNER_MIDLEVEL;
> +
> +	if (reprep)
> +		cmd->request->flags &= ~REQ_DONTPREP;

the flag is not needed, you can move the clearing of the flag to the
caller.  And given that there's lots of callers rename the
scsi_requeue_command without it to __scsi_requeue_command and make
scsi_requeue_command a tiny inline wrapper around it that clears it.

