Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTIEHRI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 03:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbTIEHRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 03:17:08 -0400
Received: from dyn-ctb-210-9-244-140.webone.com.au ([210.9.244.140]:4870 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262072AbTIEHRF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 03:17:05 -0400
Message-ID: <3F583861.6070109@cyberone.com.au>
Date: Fri, 05 Sep 2003 17:16:49 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@kernel.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix IO hangs
References: <3F5833BA.5090909@cyberone.com.au> <20030905070426.GP840@suse.de>
In-Reply-To: <20030905070426.GP840@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jens Axboe wrote:

>On Fri, Sep 05 2003, Nick Piggin wrote:
>
>>Hi, sorry for the hangs, everyone. I think I have it worked out, but
>>testers and an ack from Jens would be good.
>>
>>The insert_here code now does as advertised. The big difference being
>>that regular blk_fs_requests will be subject to it (required for SCSI
>>requeue). Unfortunately ll_rw_blk.c misuses it and will sometimes try
>>to insert at requests which are not on the dispatch list, causing the
>>badness.
>>
>>It looks like the code was maybe used to provide an insertion hint
>>for the elevator. The RB tree has now eliminated that requirement even
>>if the code did work. Which it doesn't.
>>
>>I can't reproduce the hangs with this patch. Please test.
>>
>>
>>Aside, insert_here really seems to be quite dangerous to me. I think
>>combination of barriers and an "insert at start/end" flag would be
>>enough.
>>
>
>Please just kill insert_here, it's exceeded its life expectancy. The 2.2
>io scheduler did a merge scan followed by an insertion scan, 2.3
>collapsed them into one scan as an optimization. Performance oriented io
>schedulers need to use better data structures.
>
>Best would be to change it to pass a request back even for the NO_MERGE
>case, if it has found a good insertion point. It's still a good idea to
>be able to pass hints back like this, as it could still be a viable
>optimization for _other_ io schedulers.
>

OK, that is sort of an ACK! Pending wider testing this patch needs
to get in.

Jens, if insert_here is dead, there is no point to passing back a hint
because it can't get back to the elevator anyway.

I'd very much like to kill insert_here and be done with it. If another
io scheduler comes along with a good use for it then the writers can
come up with an elegant solution ;) Hey, if they know a NO_MERGE return
means an insert will soon happen under the same lock, they could keep
it cached privately.


