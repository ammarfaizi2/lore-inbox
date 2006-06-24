Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752184AbWFXK77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbWFXK77 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 06:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752199AbWFXK76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 06:59:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14100 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751560AbWFXK76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 06:59:58 -0400
Date: Sat, 24 Jun 2006 13:01:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Fengguang Wu <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Lubos Lunak <l.lunak@suse.cz>
Subject: Re: [PATCH 7/7] iosched: introduce deadline_kick_page()
Message-ID: <20060624110104.GP4083@suse.de>
References: <20060624082006.574472632@localhost.localdomain> <20060624082312.833976992@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624082312.833976992@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24 2006, Fengguang Wu wrote:
> Introduce deadline_kick_page() to
> 	- find the request containing the page
> 	- remove its BIO_RW_AHEAD flag
> 	- reschedule if it was of type READA
> 
> Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
> ---
> 
> 
>  block/deadline-iosched.c |   45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 43 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.17-rc6-mm2.orig/block/deadline-iosched.c
> +++ linux-2.6.17-rc6-mm2/block/deadline-iosched.c
> @@ -317,6 +317,44 @@ deadline_add_request(struct request_queu
>  }
>  
>  /*
> + * We have a pending read on @page,
> + * find the corresponding request of type READA,
> + * promote it to READ, and reschedule it.
> + */
> +static int
> +deadline_kick_page(struct request_queue *q, struct page *page)
> +{
> +	struct deadline_data *dd = q->elevator->elevator_data;
> +	struct deadline_rq *drq;
> +	struct request *rq;
> +	struct list_head *pos;
> +	struct bio_vec *bvec;
> +	struct bio *bio;
> +	int i;
> +
> +	list_for_each(pos, &dd->fifo_list[READ]) {
> +		drq = list_entry_fifo(pos);
> +		rq = drq->request;
> +		if (rq->flags & (1 << BIO_RW_AHEAD)) {
> +			rq_for_each_bio(bio, rq) {
> +				bio_for_each_segment(bvec, bio, i) {
> +					if (page == bvec->bv_page)
> +						goto found;
> +				}
> +			}
> +		}
> +	}

Uh that's horrible!

Before we go into further details, I'd like to see some numbers on where
this makes a difference.

-- 
Jens Axboe

