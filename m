Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVAMLGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVAMLGX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 06:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVAMLEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 06:04:10 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:40575 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261586AbVAMKz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:55:58 -0500
Message-ID: <41E65133.6060107@yahoo.com.au>
Date: Thu, 13 Jan 2005 21:45:07 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] possible rq starvation on oom
References: <20050113092246.GJ2815@suse.de>
In-Reply-To: <20050113092246.GJ2815@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Hi,
> 
> I stumbled across this the other day. The block layer only uses a single
> memory pool for request allocation, so it's very possible for eg writes
> to have allocated them all at any point in time. If that is the case and
> the machine is low on memory, a reader attempting to allocate a request
> and failing in blk_alloc_request() can get stuck for a long time since
> no one is there to wake it up.
> 

Yeah, this would do it for sure. Nice work Jens.

Actually, this could block up requests indefinitely couldn't it?

> The solution is either to add the extra mempool so both reads and writes
> have one, or attempt to handle the situation. I chose the latter, to
> save the extra memory required for the additional mempool with
> BLKDEV_MIN_RQ statically allocated requests per-queue.
> 
> If a read allocation fails and we have no readers in flight for this
> queue, mark us rq-starved so that the next write being freed will wake
> up the sleeping reader(s). Same situation would happen for writes as
> well of course, it's just a lot more unlikely.
> 

I wonder... could you put failed, starved readers on the writer's
waitqueue and vice versa? AFAIKS this would eliminate special casing
in the fast paths, and also hopefully preserve process ordering.

But either way, it looks like your patch should do the trick as well.

Nick

