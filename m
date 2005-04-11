Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVDKMoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVDKMoi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 08:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVDKMob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 08:44:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32151 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261562AbVDKMoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 08:44:24 -0400
Date: Mon, 11 Apr 2005 13:44:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tejun Heo <htejun@gmail.com>
Cc: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH scsi-misc-2.6 03/04] scsi: make scsi_requeue_request() use blk_requeue_request()
Message-ID: <20050411124419.GA13747@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tejun Heo <htejun@gmail.com>, James.Bottomley@steeleye.com,
	axboe@suse.de, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20050411034451.B75F3870@htj.dyndns.org> <20050411034451.6204E57B@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411034451.6204E57B@htj.dyndns.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	cmd->request->flags |= REQ_SOFTBARRIER;
> +
> +	spin_lock_irqsave(q->queue_lock, flags);
> +	blk_requeue_request(q, cmd->request);
> +	spin_unlock_irqrestore(q->queue_lock, flags);
>  
>  	scsi_run_queue(q);

This exact code sequence is duplicated in the previous patch, maybe time
for a

void scsi_requeue_request(struct request *rq)
{
	struct request_queue *q = rq->q;
	unsigned long flags;

	rq->flags |= REQ_SOFTBARRIER;

	spin_lock_irqsave(q->queue_lock, flags);
	blk_requeue_request(q, rq);
	spin_unlock_irqrestore(q->queue_lock, flags);
  
  	scsi_run_queue(q);
}

