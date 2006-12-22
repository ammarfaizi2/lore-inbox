Return-Path: <linux-kernel-owner+w=401wt.eu-S1750839AbWLVRa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWLVRa1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 12:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWLVRa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 12:30:27 -0500
Received: from brick.kernel.dk ([62.242.22.158]:20571 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbWLVRa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 12:30:27 -0500
Date: Fri, 22 Dec 2006 18:32:22 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>,
       agk@redhat.com, mchristi@redhat.com, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, j-nomura@ce.jp.nec.com
Subject: Re: [RFC PATCH 1/8] rqbased-dm: allow blk_get_request() to be called from interrupt context
Message-ID: <20061222173220.GU17199@kernel.dk>
References: <20061219.171119.18572687.k-ueda@ct.jp.nec.com> <20061220134848.GF10535@kernel.dk> <20061220.125002.71083198.k-ueda@ct.jp.nec.com> <20061222140139.GA26033@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222140139.GA26033@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22 2006, Christoph Hellwig wrote:
> On Wed, Dec 20, 2006 at 12:50:02PM -0500, Kiyoshi Ueda wrote:
> > Because I'd like to use blk_get_request() in q->request_fn()
> > which can be called from interrupt context like below:
> >   scsi_io_completion -> scsi_end_request -> scsi_next_command
> >   -> scsi_run_queue -> blk_run_queue -> q->request_fn
> 
> > Or request should not be allocated in q->request_fn() anyway?
> > Do you have any other ideas?
> 
> The right long-term fix is to make sure request_fn is only ever called
> from process context.  This means moving retry handling to a thread instead
> of a softirq, but this will need careful performance testing and tweaking.

It's a lot more than just retry handling. Most driver reinvoke queueing
from the completion handling, so basically most of the time request_fn
is run from either softirq (like SCSI) or interrupt context (like IDE).

-- 
Jens Axboe

