Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVDLMHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVDLMHp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 08:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVDLMG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:06:58 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:30117 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262330AbVDLMEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:04:47 -0400
Message-ID: <425BB958.3080308@yahoo.com.au>
Date: Tue, 12 Apr 2005 22:04:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Jens Axboe'" <axboe@suse.de>, Claudio Martins <ctpm@rnl.ist.utl.pt>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Processes stuck on D state on Dual Opteron
References: <200504120803.j3C83tg06634@unix-os.sc.intel.com> <425BAC55.7020506@yahoo.com.au> <425BB073.8050308@yahoo.com.au>
In-Reply-To: <425BB073.8050308@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Nick Piggin wrote:
> 
>> Chen, Kenneth W wrote:
> 
> 
>>> I like the patch a lot and already did bench it on our db setup.  
>>> However,
>>> I'm seeing a negative regression compare to a very very crappy patch 
>>> (see
>>> attached, you can laugh at me for doing things like that :-).
>>>
>>
>> OK - if we go that way, perhaps the following patch may be the
>> way to do it.
>>
> 
> Here.
> 

Actually yes this is good I think.

What I was worried about is that you could lose some fairness due
to not being put on the queue before allocation.

This is probably a silly thing to worry about, because up until
that point things aren't really deterministic anyway (and before this
patchset it would try doing a GFP_ATOMIC allocation first anyway).

However after the subsequent locking rework, both these get_request()
calls will be performed under the same lock - giving you the same
fairness. So it is nothing to worry about anyway!

It is a bit subtle: get_request may only drop the lock and return NULL
(after retaking the lock), if we fail on a memory allocation. If we
just fail due to unavailable queue slots, then the lock is never
dropped. And the mem allocation can't fail because it is a mempool
alloc with GFP_NOIO.

Nick

-- 
SUSE Labs, Novell Inc.

