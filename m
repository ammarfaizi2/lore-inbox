Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263854AbTE3Rw5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 13:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbTE3Rw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 13:52:56 -0400
Received: from wmail.atlantic.net ([209.208.0.84]:32431 "HELO
	wmail.atlantic.net") by vger.kernel.org with SMTP id S263854AbTE3Rwz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 13:52:55 -0400
Message-ID: <3ED79FE9.7090405@techsource.com>
Date: Fri, 30 May 2003 14:16:09 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "David S. Miller" <davem@redhat.com>, Scott A Crosby <scrosby@cs.rice.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
References: <Pine.LNX.4.44.0305300627140.4176-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:

> i'd suggest to use the jhash for the following additional kernel entities:  
> pagecache hash, inode hash, vcache hash.
> 
> the buffer-cache hash and the pidhash should be hard (impossible?) to
> attack locally.
> 


Maybe this is what someone is saying, and I just missed it, but...

Coming late into this discussion (once again), I am making some 
assumptions here.  A while back, someone came up with a method for 
breaking encryption (narrowing the brute force computations) by 
determining how long it took a given host to compute encryption keys or 
hashes or something.

If you have a situation where a lot of hashes are to be computed, and 
you want to decouple the computation time from the response time, then 
do this:

1) A kernel thread requests a hash to be computed.  That hash is 
computed and put into a queue.  The kernel thread is put into the task 
queue.
2) Other kernel threads do the same.
3) Threads get woken up only when their hash is pulled off the queue.


This way, the only added overhead is kernel context switch from one 
thread to another.  The algorithm doesn't waste CPU time trying to hide 
the complexity of the computation, because the time between request and 
receipt of a hash is dependent on whatever other random hashed are also 
being computed.  That is, receipt is much later than request, but you 
haven't wasted time.

The only case where this doesn't deal with the problem in a low-cost way 
is when the queue starts out empty when you make a request, and then 
it's the only one on the queue when it's pulled off.  In that case, you 
do have to waste time.  However, given that the kernel thread will go to 
sleep anyhow, the time between sleeping and waking up is somewhat random 
due to whatever other kernel and user threads might get executed in the 
mean time.

In fact, one solution to this problem would be for the hash computing 
function to just yield the CPU before or after the computation of the 
hash.  Even in a system with absolutely no other load, the fact that we 
have to go into and out of the scheduler will add some randomness to the 
computation time, perhaps.

Have I just completely left the topic here?  :)

