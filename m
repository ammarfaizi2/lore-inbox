Return-Path: <linux-kernel-owner+w=401wt.eu-S1423123AbWLUWXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423123AbWLUWXf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 17:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423127AbWLUWXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 17:23:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59220 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423123AbWLUWXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 17:23:34 -0500
Date: Thu, 21 Dec 2006 17:22:46 -0500 (EST)
Message-Id: <20061221.172246.21934588.k-ueda@ct.jp.nec.com>
To: jens.axboe@oracle.com
Cc: agk@redhat.com, mchristi@redhat.com, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com
Subject: Re: [RFC PATCH 2/8] rqbased-dm: add block layer hook
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
In-Reply-To: <20061221074947.GC17199@kernel.dk>
References: <20061220134924.GG10535@kernel.dk>
	<20061220.165246.85417944.k-ueda@ct.jp.nec.com>
	<20061221074947.GC17199@kernel.dk>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Thu, 21 Dec 2006 08:49:47 +0100, Jens Axboe <jens.axboe@oracle.com> wrote:
> > The new hook is needed for error handling in dm.
> > For example, when an error occurred on a request, dm-multipath
> > wants to try another path before returning EIO to application.
> > Without the new hook, at the point of end_that_request_last(),
> > the bios are already finished with error and can't be retried.
> 
> Ok, I see what you are getting at. The current ->end_io() is called when
> the request has fully completed, you want notification for each chunk
> potentially completed.
> 
> I think a better design here would be to use ->end_io() as the full
> completion handler, similar to how bio->bi_end_io() works. A request
> originating from __make_request() would set something ala:
> 
> int fs_end_io(struct request *rq, int error, unsigned int nr_bytes)
> {
>         if (!__end_that_request_first(rq, err, nr_bytes)) {
>                 end_that_request_last(rq, error);
>                 return 0;
>         }
> 
>         return 1;
> }
> 
> and normal io completion from a driver would use a helper:
> 
> int blk_complete_io(struct request *rq, int error, unsigned int nr_bytes)
> {
>         return rq->end_io(rq, error, nr_bytes);
> }
> 
> instead of calling the functions manually. That would allow you to get
> notification right at the beginning and do what you need, without adding
> a special hook for this.

I'm not confident about what you mean.
Something like this?
  - __make_request() sets fs_end_io() to req->end_io()
  - The driver calls blk_complete_io()
       * if it succeeds, the request is done
       * if it fails, the request is not completed
         and the driver needs retry or something
  - Current users of req->end_io() have to update/rewrite thier end_io.
  - Features like mine will set its own end_io.
    It checks error and decides whether calling fs_end_io() or not.

Depending on drivers, there are some functions called between
__end_that_request_first() and end_that_request_last().
For example:
  - add_disk_randomness()
  - blk_queue_end_tag()
  - floppy_off()
So they might prevent such generalization.


In addition to the suggested approach, what do you think about
adding a new flag to req->cmd_flags which lets the end_io() handler
not to return bio to upper layer?
It will be useful for multipathing and can be done even within
the current __end_that_request_first().
For example,

static int __end_that_request_first()
{
	.....
	error = 0;
	if (end_io_error(uptodate))
		error = !uptodate ? -EIO : uptodate;
	.....
	if (error && (req->cmd_flags & "NEW_FLAG"))
		return 0; /* Tell the driver to call end_that_request_last() */

	total_types = bio_nbytes = 0;
	while ((bio = req->bio) != NULL) {
		..... /* process of finishing bios */
	}
	.....
}

Thanks,
Kiyoshi Ueda

