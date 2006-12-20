Return-Path: <linux-kernel-owner+w=401wt.eu-S1030284AbWLTTPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWLTTPu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWLTTPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:15:50 -0500
Received: from brick.kernel.dk ([62.242.22.158]:7715 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030284AbWLTTPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:15:49 -0500
Date: Wed, 20 Dec 2006 20:17:33 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Kiyoshi Ueda'" <k-ueda@ct.jp.nec.com>, agk@redhat.com,
       mchristi@redhat.com, linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       j-nomura@ce.jp.nec.com
Subject: Re: [RFC PATCH 1/8] rqbased-dm: allow blk_get_request() to be called from interrupt context
Message-ID: <20061220191730.GL10535@kernel.dk>
References: <20061220.125002.71083198.k-ueda@ct.jp.nec.com> <000001c7246a$ae31c8a0$ff0da8c0@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c7246a$ae31c8a0$ff0da8c0@amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20 2006, Chen, Kenneth W wrote:
> Kiyoshi Ueda wrote on Wednesday, December 20, 2006 9:50 AM
> > On Wed, 20 Dec 2006 14:48:49 +0100, Jens Axboe <jens.axboe@oracle.com> wrote:
> > > Big NACK on this - it's not only really ugly, it's also buggy to pass
> > > interrupt flags as function arguments. As you also mention in the 0/1
> > > mail, this also breaks CFQ.
> > > 
> > > Why do you need in-interrupt request allocation?
> >  
> > Because I'd like to use blk_get_request() in q->request_fn()
> > which can be called from interrupt context like below:
> >   scsi_io_completion -> scsi_end_request -> scsi_next_command
> >   -> scsi_run_queue -> blk_run_queue -> q->request_fn
> > 
> > [ ...]
> > 
> > Do you think creating another function like blk_get_request_nowait()
> > is acceptable?
> 
> You don't need to create another function.  blk_get_request already
> have both wait and nowait semantics via gfp_mask argument. If you can
> not block, then clear __GFP_WAIT bit in the mask before calling
> blk_get_request.

Doesn't work, get_request() assumes that the caller grabbed the queue
lock and disabled interrupts, and does an unconditionaly

        spin_unlock_irq()

inside it. So you can NEVER use get_request() for even GFP_ATOMIC
allocations, as it assumes the original context was a process context.

-- 
Jens Axboe

