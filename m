Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271220AbTHCOOA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 10:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271222AbTHCOOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 10:14:00 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:7836 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S271220AbTHCON7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 10:13:59 -0400
Message-ID: <3F2D1884.3010001@colorfullife.com>
Date: Sun, 03 Aug 2003 16:13:24 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: IDE locking problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Then, IDE could do something like:
>
> - set dead flag
> - wait for all pending requests to drain (easy: insert a barrier
>   in the queue and wait on it, with a hack for the barrier insertion
>   to bypass the dead flag... ugh... maybe a blk_terminate_queue()
>   doing all that would be helpful ?)
> - unregister blkdev
> - then tear down the queue (leaving the "empty" queue with the dead
>   flag set, not just memset(...,0,...), so that any bozo keeping a
>   reference to it will be rejected trying to insert request instead
>   of trying to tap an uninitalized queue object
>
>What do you think ?
>  
>
The last step is bad - sooner or later the queue will be kfreed, and if 
there are bozos around that still have references, they would access 
random memory. It must be guaranteed that all references expired before 
the tear down begins. Just leaving a dead flag set is not sufficient.

--
    Manfred

