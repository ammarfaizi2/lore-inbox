Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbVDMBty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVDMBty (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbVDMBqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 21:46:44 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:9316 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262931AbVDMBqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 21:46:04 -0400
Message-ID: <425C79D0.4010007@yahoo.com.au>
Date: Wed, 13 Apr 2005 11:45:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Jens Axboe'" <axboe@suse.de>, Claudio Martins <ctpm@rnl.ist.utl.pt>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Processes stuck on D state on Dual Opteron
References: <200504121833.j3CIXLg12005@unix-os.sc.intel.com>
In-Reply-To: <200504121833.j3CIXLg12005@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Nick Piggin wrote on Tuesday, April 12, 2005 4:09 AM
> 
>>Chen, Kenneth W wrote:
>>
>>>I like the patch a lot and already did bench it on our db setup.  However,
>>>I'm seeing a negative regression compare to a very very crappy patch (see
>>>attached, you can laugh at me for doing things like that :-).
>>
>>OK - if we go that way, perhaps the following patch may be the
>>way to do it.
> 
> 
> OK, if you are going to do it that way, then the ioc_batching code in get_request
> has to be reworked.  We never push the queue so hard that it kicks itself into the
> batching mode.  However, calls to get_io_context and put_io_context are unconditional
> in that function.  Execution profile shows that these two little functions actually
> consumed lots of cpu cycles.
> 
> AFAICS, ioc_*batching() is trying to push more requests onto the queue that is full
> (or near full) and give high priority to the process that hits the last req slot.
> Why do we need to go all the way to tsk->io_context to keep track of that state?
> For a clean up bonus, I think the tracking can be moved into the queue structure.
> 

OK - well it is no different to what you had before these patches, so
probably future work would be seperate patches.

get_io_context can probably be reworked. For example, it is only called
with the current thread, so it probably doesn't need to increment the
refcount, as most users are only using it process context... all users
in ll_rw_blk.c, anyway.

-- 
SUSE Labs, Novell Inc.

