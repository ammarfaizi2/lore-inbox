Return-Path: <linux-kernel-owner+w=401wt.eu-S1423026AbWLUW4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423026AbWLUW4N (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 17:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423106AbWLUW4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 17:56:13 -0500
Received: from www.nabble.com ([72.21.53.35]:32953 "EHLO talk.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423026AbWLUW4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 17:56:12 -0500
Message-ID: <8016546.post@talk.nabble.com>
Date: Thu, 21 Dec 2006 14:56:11 -0800 (PST)
From: business1 <coreyu@bsgteamsite.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] rqbased-dm: add block layer hook
In-Reply-To: <20061221.172246.21934588.k-ueda@ct.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: coreyu@bsgteamsite.com
References: <20061219.171150.75425661.k-ueda@ct.jp.nec.com> <20061220134924.GG10535@kernel.dk> <20061220.165246.85417944.k-ueda@ct.jp.nec.com> <20061221074947.GC17199@kernel.dk> <20061221.172246.21934588.k-ueda@ct.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Kiyoshi Ueda wrote:
> 
> Hi Jens,
> 
> On Thu, 21 Dec 2006 08:49:47 +0100, Jens Axboe <jens.axboe@oracle.com>
> wrote:
>> > The new hook is needed for error handling in dm.
>> > For example, when an error occurred on a request, dm-multipath
>> > wants to try another path before returning EIO to application.
>> > Without the new hook, at the point of end_that_request_last(),
>> > the bios are already finished with error and can't be retried.
>> 
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
> Thanks,
> Kiyoshi Ueda
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
>   
> http://www.thebusinesssuccessgroup.com/Real-Estate-Investment-training.html

-- 
View this message in context: http://www.nabble.com/-RFC-PATCH-2-8--rqbased-dm%3A-add-block-layer-hook-tf2848786.html#a8016546
Sent from the linux-kernel mailing list archive at Nabble.com.

