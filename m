Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVAFEfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVAFEfq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 23:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVAFEfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 23:35:46 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:51807 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262186AbVAFEfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 23:35:40 -0500
Message-ID: <41DCC014.80007@yahoo.com.au>
Date: Thu, 06 Jan 2005 15:35:32 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: riel@redhat.com, marcelo.tosatti@cyclades.com, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
References: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com>	<20050105020859.3192a298.akpm@osdl.org>	<20050105180651.GD4597@dualathlon.random>	<Pine.LNX.4.61.0501051350150.22969@chimarrao.boston.redhat.com>	<20050105174934.GC15739@logos.cnet>	<20050105134457.03aca488.akpm@osdl.org>	<20050105203217.GB17265@logos.cnet>	<41DC7D86.8050609@yahoo.com.au>	<Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com>	<20050105173624.5c3189b9.akpm@osdl.org>	<Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com>	<41DCB577.9000205@yahoo.com.au> <20050105202611.65eb82cf.akpm@osdl.org>
In-Reply-To: <20050105202611.65eb82cf.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>>I suspect something might still be broken.  It may take a few
>>>days of continuous testing to trigger the bug, though ...
>>>
>>
>>It is possible to be those blk_congestion_wait paths, because
>>the queue simply won't be congested. So doing io_schedule_timeout
>>might help.
> 
> 
> If the queue is not congested, blk_congestion_wait() will still sleep.  See
> freed_request().
> 

Hmm... doesn't look like it to me:

         if (rl->count[rw] < queue_congestion_off_threshold(q))
                 clear_queue_congested(q, rw);

And clear_queue_congested does an unconditional wakeup (if there
is someone sleeping on the congestion queue).

> 
>>I wonder if reducing the size of the write queue in CFQ would help
>>too? IIRC, it only really wants a huge read queue.
> 
> 
> Surely it will help - but we need to be able to handle the situation
> because memory can still become full of PageWriteback pages if there are
> many disks.
> 

Yep.
