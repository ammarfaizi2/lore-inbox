Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264852AbUFBHFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264852AbUFBHFc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 03:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbUFBHFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 03:05:32 -0400
Received: from mx3.cs.washington.edu ([128.208.3.132]:18336 "EHLO
	mx3.cs.washington.edu") by vger.kernel.org with ESMTP
	id S264852AbUFBHFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 03:05:12 -0400
Date: Wed, 2 Jun 2004 00:05:06 -0700 (PDT)
From: Vadim Lobanov <vadim@cs.washington.edu>
To: jyotiraditya@softhome.net
cc: linux-kernel@vger.kernel.org
Subject: Re: Select/Poll
In-Reply-To: <courier.40BD66BD.00006D7D@softhome.net>
Message-ID: <20040601235641.M6580-100000@attu2.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2004 jyotiraditya@softhome.net wrote:

> Hello All, 
> 
> In one of the threads named: "Linux's implementation of poll() not 
> scalable?'
> Linus has stated the following:
> **************
> Neither poll() nor select() have this problem: they don't get more
> expensive as you have more and more events - their expense is the number
> of file descriptors, not the number of events per se. In fact, both poll()
> and select() tend to perform _better_ when you have pending events, as
> they are both amenable to optimizations when there is no need for waiting,
> and scanning the arrays can use early-out semantics.
> ************** 
> 
> Please help me understand the above.. I'm using select in a server to read
> on multiple FDs and the clients are dumping messages (of fixed size) in a
> loop on these FDs and the server maintainig those FDs is not able to get all
> the messages.. Some of the last messages sent by each client are lost.
> If the number of clients and hence the number of FDs (in the server) is
> increased the loss of data is proportional.
> eg: 5 clients send messages (100 each) to 1 server and server receives
>    96 messages from each client.
>    10 clients send messages (100 by each) to 1 server and server again
>    receives 96 from each client. 
> 
> If a small sleep in introduced between sending messages the loss of data
> decreases.
> Also please explain the algorithm select uses to read messages on FDs and
> how does it perform better when number of FDs increases. 
> 
> Thanks and Regards,
> Jyotiraditya 

I think everyone else already hit on the main points of UDP, so I'll pass 
on to the second question. :)

I believe that there is some confusion between the phrases "events" and 
"FDs". As far as I know, both poll() and select() scale O(n) (in other 
words, linearly) with the number of watched FDs, but scale O(1) (in other 
words, no effect) with the number of received events. Let's put this into 
more concrete terms:

Suppose you select/poll on an array of 100 FDs, which currently have no 
pending events. What the kernel will do for you, in essence, is go into an 
infinite loop, querying each of the 100 FDs in turn, whether it has 
received new events or not. If one of those has received an event, then 
select/poll will return that FD. But in the end, it reduces to a simple 
loop over the FDs to determine when events arrive, and it is exactly this 
loop that gives it O(n) behavior.

However, if by the time that select/poll are called, there are already 
pending events upon the FD set, then that syscall can return immediately 
with the events already present. In this case, you will not need to begin 
looping over the FDs, and hence you will not observe the O(n) behavior. 
Notice that this favorable scenario is more likely to occur when you have 
more events coming in. I think that this is what Linus meant when he said 
that select/poll like to have events waiting, for a faster return time.

As a very quick and very much simplistic summary, for select/poll, the 
more incoming events you get, and the less FDs you watch, the better off 
you are. But in your case, I do not think you have to worry about 
scalability much. If you _really_ want to, however, check epoll - should 
be standardized on the 2.6.x kernels (though my glibc still has VERY big 
issues with it).

And as a final word, I have no doubts that someone out there who is more 
knowledgeable can correct me wherever it may be needed. Such corrections 
are welcome, since I get to learn something new in that case. :)

-VadimL

