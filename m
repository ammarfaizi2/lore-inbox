Return-Path: <linux-kernel-owner+w=401wt.eu-S1422998AbWLVOBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422998AbWLVOBz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 09:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422999AbWLVOBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 09:01:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34018 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422998AbWLVOBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 09:01:54 -0500
Date: Fri, 22 Dec 2006 14:01:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Cc: jens.axboe@oracle.com, agk@redhat.com, mchristi@redhat.com,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       j-nomura@ce.jp.nec.com
Subject: Re: [RFC PATCH 1/8] rqbased-dm: allow blk_get_request() to be called from interrupt context
Message-ID: <20061222140139.GA26033@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, jens.axboe@oracle.com,
	agk@redhat.com, mchristi@redhat.com, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com, j-nomura@ce.jp.nec.com
References: <20061219.171119.18572687.k-ueda@ct.jp.nec.com> <20061220134848.GF10535@kernel.dk> <20061220.125002.71083198.k-ueda@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220.125002.71083198.k-ueda@ct.jp.nec.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 12:50:02PM -0500, Kiyoshi Ueda wrote:
> Because I'd like to use blk_get_request() in q->request_fn()
> which can be called from interrupt context like below:
>   scsi_io_completion -> scsi_end_request -> scsi_next_command
>   -> scsi_run_queue -> blk_run_queue -> q->request_fn

> Or request should not be allocated in q->request_fn() anyway?
> Do you have any other ideas?

The right long-term fix is to make sure request_fn is only ever called
from process context.  This means moving retry handling to a thread instead
of a softirq, but this will need careful performance testing and tweaking.
