Return-Path: <linux-kernel-owner+w=401wt.eu-S1423029AbWLUS6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423029AbWLUS6P (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 13:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423030AbWLUS6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 13:58:15 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:56964 "EHLO sabe.cs.wisc.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423029AbWLUS6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 13:58:14 -0500
Message-ID: <458AD92D.5000901@cs.wisc.edu>
Date: Thu, 21 Dec 2006 12:57:49 -0600
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: device-mapper development <dm-devel@redhat.com>, mchristi@redhat.com,
       linux-kernel@vger.kernel.org, agk@redhat.com
Subject: Re: [dm-devel] Re: [RFC PATCH 1/8] rqbased-dm: allow blk_get_request()
  to be called from interrupt context
References: <20061220134848.GF10535@kernel.dk> <20061220.125002.71083198.k-ueda@ct.jp.nec.com> <20061220184917.GJ10535@kernel.dk> <20061220.165549.39151582.k-ueda@ct.jp.nec.com> <20061221075305.GD17199@kernel.dk> <458ACB69.8000603@cs.wisc.edu> <458ACEB1.3030406@cs.wisc.edu> <20061221182432.GB17199@kernel.dk> <458AD2E0.40807@cs.wisc.edu> <458AD43C.3050603@cs.wisc.edu> <20061221184203.GD17199@kernel.dk>
In-Reply-To: <20061221184203.GD17199@kernel.dk>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Dec 21 2006, Mike Christie wrote:
>> Mike Christie wrote:
>>> Jens Axboe wrote:
>>>> On Thu, Dec 21 2006, Mike Christie wrote:
>>>>> Or the block layer code could set up the clone too. elv_next_request
>>>>> could prep a clone based on the orignal request for the driver then dm
>>>>> would not have to worry about that part.
>>>> It really can't, since it doesn't know how to allocate the clone
>>>> request. I'd rather export this functionality as helpers.
>>>>
>>> What do you think about dm's plan to break up make_request into a
>>> mapping function and in to the part the builds the bio into a request.
>>> This would fit well with them being helpers and being able to allocate
>>> the request from the correct context.
>>>
>>> I see patches for that did not get posted, but I thought Joe and
>>> Alasdair used to talk about that a lot and in the dm code I think there
>>> is sill comments about doing it. Maybe the dm comments mentioned the
>>> merge_fn, but I guess the merge_fn did not fit what they wanted to do or
>>> something. I think Alasdair talked about this at one of his talks at OLS
>>> or it was in a proposal for the kernel summit. I can dig up the mail if
>>> you want.
>>>
>> Ignore that. The problem would be that we may not want to decide which
>> path to use at map time.
> 
> Latter part, or both paragraphs? Dipping into ->make_request_fn() for
> some parts do seem to make sense to me. It'll be cheaper than at
> potential soft irq time (from elv_next_request()).
> 

I think we got crisscrossed.

The original idea but using your helper suggestion would have been this:

dm->make_request_fn(bio)
{
	rq = __make_request(bio)
	if (this is a new request) {
		allocate clone from either a real device/path specific mempool() or a
dm q mempool
}


dm->prep_fn(rq)
{
	setup clone rq fields based on orig request fields.
}

dm->request_fn(rq)
{
	figure out which path to use;
	set rq->q;
	send cloned rq to real device;
}


The second idea based on Joe and Alasdair to break up make_request would
just have been a more formal break up of the dm->make_request_fn above,
because I thought your comment about not knowing how to allocate the
clone request meant that we did not know which q's mempool to take the
request from if we were going to take the cloned request from the real
device/path's mempool. I guess this does not really matter since we can
have just a dm q mempool of requests to use for cloned requests.
