Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVE0G1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVE0G1O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 02:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVE0G1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 02:27:13 -0400
Received: from brick.kernel.dk ([62.242.22.158]:50115 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261407AbVE0G1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 02:27:05 -0400
Date: Fri, 27 May 2005 08:28:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
Message-ID: <20050527062802.GH1435@suse.de>
References: <20050526140058.GR1419@suse.de> <42964498.9080909@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42964498.9080909@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26 2005, Mark Lord wrote:
> I also saw a good boost from NCQ on the qstor driver (full version,
> not the libata subset) last year.  Very good for busy servers
> and RAID arrays.

It does seem to work amazingly well, from a performance point of view.

> Jens Axboe wrote:
> +	do {
> +		/*
> +		 * we rely on the FIFO order of the exclusive waitqueues
> +		 */
> +		prepare_to_wait_exclusive(&ap->cmd_wait_queue, &wait,
> +					  TASK_UNINTERRUPTIBLE);
> +
> +		if (!ata_qc_issue_ok(ap, qc, 1)) {
> +			spin_unlock_irq(&ap->host_set->lock);
> +			schedule();
> +			spin_lock_irq(&ap->host_set->lock);
> +		}
> +
> +		finish_wait(&ap->cmd_wait_queue, &wait);
> +
> +	} while (!ata_qc_issue_ok(ap, qc, 1));
> 
> In this bit (above), is it possible for this code to ever
> be invoked from a SCHED_RR or SCHED_FIFO context?
> 
> If so, it will lock out all lower-priority processes
> for the duration of the polling interval.

Yeah, I'm not a huge fan of the need for the above code... If every qc
was tied to a SCSI command, we could just ask for a later requeue of the
request as is currently done with NCQ commands. Alternatively, we could
add an internal libata qc queue for postponing these commands. That
would take a little effort, as the sync errors reported by
ata_qc_issue() would then be need to signalled async through the
completion callback instead.

Jeff, what do you think?

-- 
Jens Axboe

