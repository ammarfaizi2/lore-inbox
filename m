Return-Path: <linux-kernel-owner+w=401wt.eu-S1945962AbWLVHTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945962AbWLVHTL (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 02:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945961AbWLVHTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 02:19:10 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:57753 "EHLO sabe.cs.wisc.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945962AbWLVHTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 02:19:09 -0500
Message-ID: <458B86D4.3000107@cs.wisc.edu>
Date: Fri, 22 Dec 2006 01:18:44 -0600
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: device-mapper development <dm-devel@redhat.com>
CC: jens.axboe@oracle.com, linux-kernel@vger.kernel.org, mchristi@redhat.com,
       agk@redhat.com
Subject: Re: [dm-devel] Re: [RFC PATCH 2/8] rqbased-dm: add block layer hook
References: <20061220134924.GG10535@kernel.dk>	<20061220.165246.85417944.k-ueda@ct.jp.nec.com>	<20061221074947.GC17199@kernel.dk> <20061221.172246.21934588.k-ueda@ct.jp.nec.com>
In-Reply-To: <20061221.172246.21934588.k-ueda@ct.jp.nec.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kiyoshi Ueda wrote:
> Hi Jens,
> 
> On Thu, 21 Dec 2006 08:49:47 +0100, Jens Axboe <jens.axboe@oracle.com> wrote:
>>> The new hook is needed for error handling in dm.
>>> For example, when an error occurred on a request, dm-multipath
>>> wants to try another path before returning EIO to application.
>>> Without the new hook, at the point of end_that_request_last(),
>>> the bios are already finished with error and can't be retried.
>> Ok, I see what you are getting at. The current ->end_io() is called when
>> the request has fully completed, you want notification for each chunk
>> potentially completed.
>>
>> I think a better design here would be to use ->end_io() as the full
>> completion handler, similar to how bio->bi_end_io() works. A request
>> originating from __make_request() would set something ala:
>>
>> int fs_end_io(struct request *rq, int error, unsigned int nr_bytes)
>> {
>>         if (!__end_that_request_first(rq, err, nr_bytes)) {
>>                 end_that_request_last(rq, error);
>>                 return 0;
>>         }
>>
>>         return 1;
>> }
>>
>> and normal io completion from a driver would use a helper:
>>
>> int blk_complete_io(struct request *rq, int error, unsigned int nr_bytes)
>> {
>>         return rq->end_io(rq, error, nr_bytes);
>> }
>>
>> instead of calling the functions manually. That would allow you to get
>> notification right at the beginning and do what you need, without adding
>> a special hook for this.
> 
> I'm not confident about what you mean.
> Something like this?
>   - __make_request() sets fs_end_io() to req->end_io()
>   - The driver calls blk_complete_io()
>        * if it succeeds, the request is done
>        * if it fails, the request is not completed
>          and the driver needs retry or something
>   - Current users of req->end_io() have to update/rewrite thier end_io.
>   - Features like mine will set its own end_io.
>     It checks error and decides whether calling fs_end_io() or not.
> 
> Depending on drivers, there are some functions called between
> __end_that_request_first() and end_that_request_last().
> For example:
>   - add_disk_randomness()
>   - blk_queue_end_tag()
>   - floppy_off()
> So they might prevent such generalization.
> 
> 
> In addition to the suggested approach, what do you think about
> adding a new flag to req->cmd_flags which lets the end_io() handler
> not to return bio to upper layer?
> It will be useful for multipathing and can be done even within
> the current __end_that_request_first().
> For example,
> 
> static int __end_that_request_first()
> {
> 	.....
> 	error = 0;
> 	if (end_io_error(uptodate))
> 		error = !uptodate ? -EIO : uptodate;
> 	.....
> 	if (error && (req->cmd_flags & "NEW_FLAG"))
> 		return 0; /* Tell the driver to call end_that_request_last() */
> 
> 	total_types = bio_nbytes = 0;
> 	while ((bio = req->bio) != NULL) {
> 		..... /* process of finishing bios */
> 	}
> 	.....
> }
> 

Who would call end_that_request_first with the new flag set? The scsi
layer or multipath layer?

The end_io_first callout was a hack around the lack of stacking and
because I was not yet sure how to handle medium errors.

We hooked into end_that_request_first, because for SCSI we can get a
medium error and the scsi layer will complete the first X bytes of a
request, then retry the leftover part itself. For this error we want to
update the request and bio fields so that when the request is resent by
the scsi layer, the scatterlist will get made with the updated values.

Maybe if FAILFAST is made to cover all errors then we would not need
this type of hack. Having multipath handle medium errors seems a little
silly though since the scsi layer knows better what to do there.

Another alternative is to do something similar to what bio based dm does
today. The bio/bvec update code and bio mapping and stacking has a
similar problem. In dm we have that bio record/details code which copies
some of the bio fields and dm-mpath also does not do partial retries.
For example, on a medium error where part of a bio is successful but the
end part fails because of a transport error and needs to be retried this
will result in the entire bio being redriven.
