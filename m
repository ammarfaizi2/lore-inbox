Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757655AbWKXId7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757655AbWKXId7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 03:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757657AbWKXId6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 03:33:58 -0500
Received: from gw1.cosmosbay.com ([86.65.150.130]:55177 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1757654AbWKXId5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 03:33:57 -0500
Message-ID: <4566AE48.70409@cosmosbay.com>
Date: Fri, 24 Nov 2006 09:33:12 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ulrich Drepper <drepper@redhat.com>, Jeff Garzik <jeff@garzik.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Subject: Re: [take25 1/6] kevent: Description.
References: <11641265982190@2ka.mipt.ru>	<456621AC.7000009@redhat.com>	<45662522.9090101@garzik.org>	<45663298.7000108@redhat.com>	<45664160.6060504@cosmosbay.com> <20061124001412.371ec4e7.akpm@osdl.org>
In-Reply-To: <20061124001412.371ec4e7.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [86.65.150.130]); Fri, 24 Nov 2006 09:33:02 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> On Fri, 24 Nov 2006 01:48:32 +0100
> Eric Dumazet <dada1@cosmosbay.com> wrote:
> 
>>> The alternative is the sorry state we have now.  In nscd, for instance, 
>>> we have one single thread waiting for incoming connections and it then 
>>> has to wake up a worker thread to handle the processing.  This is done 
>>> because we cannot "park" all threads in the accept() call since when a 
>>> new connection is announced _all_ the threads are woken.  With the new 
>>> event handling this wouldn't be the case, one thread only is woken and 
>>> we don't have to wake worker threads.  All threads can be worker threads.
>> Having one specialized thread handling the distribution of work to worker 
>> threads is better most of the time.
> 
> It might be now.  Think "commodity 128-way".  Your single distribution thread
> will run out of steam.
> 
> What Ulrich is proposing is faster.  This is a new interface.  Let's design
> it to be fast.

Hum... I guess you didnt read my mail... I basically agree with Ulrich.

I just wanted to say that a fast application cannot rely only on a "let's park 
N threads waiting for single event in this queue", and hope kernel will be 
smart for us.

Even with 128-ways, you still hit a central point of coordination (it can be a 
mutex in kevent code, a atomic uidx in userland, or whatever) for a 'kevent 
queue'. Once you paid the cache lines ping/pong, you wont be *fast*.

I wish *you* dont think of kevent of only dispatching HTTP 1.0 trivial web 
requests.

Being able to direct a particular request on a particular CPU is certainly 
something that cannot be hardcoded in 'the new kevent interface'.

Eric
