Return-Path: <SRS0=QUj5=7C=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C733C433E1
	for <io-uring@archiver.kernel.org>; Wed, 20 May 2020 08:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D9520708
	for <io-uring@archiver.kernel.org>; Wed, 20 May 2020 08:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgETIED (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 May 2020 04:04:03 -0400
Received: from verein.lst.de ([213.95.11.211]:48303 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETIED (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Wed, 20 May 2020 04:04:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AE88368C65; Wed, 20 May 2020 10:03:58 +0200 (CEST)
Date:   Wed, 20 May 2020 10:03:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>, io-uring@vger.kernel.org
Subject: io_uring vs CPU hotplug, was Re: [PATCH 5/9] blk-mq: don't set
 data->ctx and data->hctx in blk_mq_alloc_request_hctx
Message-ID: <20200520080357.GA4197@lst.de>
References: <20200518093155.GB35380@T590> <87imgty15d.fsf@nanos.tec.linutronix.de> <20200518115454.GA46364@T590> <20200518131634.GA645@lst.de> <20200518141107.GA50374@T590> <20200518165619.GA17465@lst.de> <20200519015420.GA70957@T590> <20200519153000.GB22286@lst.de> <20200520011823.GA415158@T590> <20200520030424.GI416136@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520030424.GI416136@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Wed, May 20, 2020 at 11:04:24AM +0800, Ming Lei wrote:
> On Wed, May 20, 2020 at 09:18:23AM +0800, Ming Lei wrote:
> > On Tue, May 19, 2020 at 05:30:00PM +0200, Christoph Hellwig wrote:
> > > On Tue, May 19, 2020 at 09:54:20AM +0800, Ming Lei wrote:
> > > > As Thomas clarified, workqueue hasn't such issue any more, and only other
> > > > per CPU kthreads can run until the CPU clears the online bit.
> > > > 
> > > > So the question is if IO can be submitted from such kernel context?
> > > 
> > > What other per-CPU kthreads even exist?
> > 
> > I don't know, so expose to wider audiences.
> 
> One user is io uring with IORING_SETUP_SQPOLL & IORING_SETUP_SQ_AFF, see
> io_sq_offload_start(), and it is a IO submission kthread.

As far as I can tell that code is buggy, as it still needs to migrate
the thread away when the cpu is offlined.  This isn't a per-cpu kthread
in the sene of having one for each CPU.

Jens?
