Return-Path: <linux-kernel-owner+w=401wt.eu-S1423013AbWLUS1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423013AbWLUS1t (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 13:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423014AbWLUS1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 13:27:49 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:56907 "EHLO sabe.cs.wisc.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423013AbWLUS1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 13:27:49 -0500
Message-ID: <458ACB69.8000603@cs.wisc.edu>
Date: Thu, 21 Dec 2006 11:59:05 -0600
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: device-mapper development <dm-devel@redhat.com>
CC: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, mchristi@redhat.com,
       linux-kernel@vger.kernel.org, agk@redhat.com
Subject: Re: [dm-devel] Re: [RFC PATCH 1/8] rqbased-dm: allow blk_get_request()
 to be called from interrupt context
References: <20061220134848.GF10535@kernel.dk>	<20061220.125002.71083198.k-ueda@ct.jp.nec.com>	<20061220184917.GJ10535@kernel.dk>	<20061220.165549.39151582.k-ueda@ct.jp.nec.com> <20061221075305.GD17199@kernel.dk>
In-Reply-To: <20061221075305.GD17199@kernel.dk>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Dec 20 2006, Kiyoshi Ueda wrote:
>> Hi Jens,
>>
>> On Wed, 20 Dec 2006 19:49:17 +0100, Jens Axboe <jens.axboe@oracle.com> wrote:
>>>>> Big NACK on this - it's not only really ugly, it's also buggy to pass
>>>>> interrupt flags as function arguments. As you also mention in the 0/1
>>>>> mail, this also breaks CFQ.
>>>>>
>>>>> Why do you need in-interrupt request allocation?
>>>>  
>>>> Because I'd like to use blk_get_request() in q->request_fn()
>>>> which can be called from interrupt context like below:
>>>>   scsi_io_completion -> scsi_end_request -> scsi_next_command
>>>>   -> scsi_run_queue -> blk_run_queue -> q->request_fn
>>>>
>>>> Generally, device-mapper (dm) clones an original I/O and dispatches
>>>> the clones to underlying destination devices.
>>>> In the request-based dm patch, the clone creation and the dispatch
>>>> are done in q->request_fn().  To create the clone, blk_get_request()
>>>> is used to get a request from underlying destination device's queue.
>>>> By doing that in q->request_fn(), dm can deal with struct request
>>>> after bios are merged by __make_request().
>>>>
>>>> Do you think creating another function like blk_get_request_nowait()
>>>> is acceptable?
>>>> Or request should not be allocated in q->request_fn() anyway?
>>> You should not be allocating requests from that path, for a number of
>>> reasons.
>> Could I hear the reasons for my further work if possible?
>> Because of breaking current CFQ?  And is there any reason?
> 
> Mainly I just don't like the design, there are better ways to achieve
> what you need. The block layer has certain assumptions on the context
> from which rq allocation happens, and this breaks it. As I also
> mentioned, you cannot pass flags around as arguments. So the patch is
> even broken as-is.
> 


I was thinking that since this was going to be hooked into dm which has
the make_request hook in code, could we just allocate the cloned request
when from dm's make_request callout. The dm queue would call
__make_request, and if it detected that the bio started a new request it
would just allocate a second request which would be used as a clone or
maybe the block layer could allocate the clone request for us. On the
request_fn callout side, DM could then setup the cloned rq based on the
original fields and pass it down to the dm-multipath request_fn. The
dm-mutlipath request_fn then just decides which path to use based on the
path-selector modules and then we send it off.

