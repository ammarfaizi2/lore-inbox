Return-Path: <linux-kernel-owner+w=401wt.eu-S1422818AbWLUHr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422818AbWLUHr7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 02:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422825AbWLUHr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 02:47:59 -0500
Received: from brick.kernel.dk ([62.242.22.158]:19189 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422818AbWLUHr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 02:47:58 -0500
Date: Thu, 21 Dec 2006 08:49:47 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Cc: agk@redhat.com, mchristi@redhat.com, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, j-nomura@ce.jp.nec.com
Subject: Re: [RFC PATCH 2/8] rqbased-dm: add block layer hook
Message-ID: <20061221074947.GC17199@kernel.dk>
References: <20061219.171150.75425661.k-ueda@ct.jp.nec.com> <20061220134924.GG10535@kernel.dk> <20061220.165246.85417944.k-ueda@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220.165246.85417944.k-ueda@ct.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20 2006, Kiyoshi Ueda wrote:
> Hi Jens,
> 
> Sorry for the less explanation.
> 
> On Wed, 20 Dec 2006 14:49:24 +0100, Jens Axboe <jens.axboe@oracle.com> wrote:
> > On Tue, Dec 19 2006, Kiyoshi Ueda wrote:
> > > This patch adds new "end_io_first" hook in __end_that_request_first()
> > > for request-based device-mapper.
> > 
> > What's this for, lack of stacking?
> 
> I don't understand the meaning of "lack of stacking" well but
> I guess that it means "Is the existing hook in end_that_request_last()
> not enough?"  If so, the answer is no.
> (If the geuss is wrong, please let me know.)
> 
> The new hook is needed for error handling in dm.
> For example, when an error occurred on a request, dm-multipath
> wants to try another path before returning EIO to application.
> Without the new hook, at the point of end_that_request_last(),
> the bios are already finished with error and can't be retried.

Ok, I see what you are getting at. The current ->end_io() is called when
the request has fully completed, you want notification for each chunk
potentially completed.

I think a better design here would be to use ->end_io() as the full
completion handler, similar to how bio->bi_end_io() works. A request
originating from __make_request() would set something ala:

int fs_end_io(struct request *rq, int error, unsigned int nr_bytes)
{
        if (!__end_that_request_first(rq, err, nr_bytes)) {
                end_that_request_last(rq, error);
                return 0;
        }

        return 1;
}

and normal io completion from a driver would use a helper:

int blk_complete_io(struct request *rq, int error, unsigned int nr_bytes)
{
        return rq->end_io(rq, error, nr_bytes);
}

instead of calling the functions manually. That would allow you to get
notification right at the beginning and do what you need, without adding
a special hook for this.

When designing these things, never be afraid to change some of the core
bits. It is a lot better than hacking around the current code, if it
doesn't quite fit your needs.

-- 
Jens Axboe

