Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWAFOBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWAFOBE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 09:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWAFOBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 09:01:04 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:24505 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932206AbWAFOBB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 09:01:01 -0500
Message-ID: <43BE77F1.4090301@cosmosbay.com>
Date: Fri, 06 Jan 2006 15:00:17 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>, netdev@vger.kernel.org
Subject: Re: [PATCH, RFC] RCU : OOM avoidance and lower latency
References: <20060105235845.967478000@sorel.sous-sol.org>	 <20060106004555.GD25207@sorel.sous-sol.org>	 <Pine.LNX.4.64.0601051727070.3169@g5.osdl.org>	 <43BE43B6.3010105@cosmosbay.com> <1136554632.30498.7.camel@localhost.localdomain>
In-Reply-To: <1136554632.30498.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 06 Jan 2006 15:00:19 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox a écrit :
> On Gwe, 2006-01-06 at 11:17 +0100, Eric Dumazet wrote:
>> I assume that if a CPU queued 10.000 items in its RCU queue, then the oldest 
>> entry cannot still be in use by another CPU. This might sounds as a violation 
>> of RCU rules, (I'm not an RCU expert) but seems quite reasonable.
> 
> Fixing the real problem in the routing code would be the real fix. 
> 

So far nobody succeeded in 'fixing the routing code', few people can even read 
the code from the first line to the last one...

I think this code is not buggy, it only makes general RCU assumptions about 
delayed freeing of dst entries. In some cases, the general assumptions are 
just wrong. We can fix it at RCU level, and future users of call_rcu_bh() wont 
have to think *hard* about 'general assumptions'.

Of course, we can ignore the RCU problem and mark somewhere on a sticker: 
***DONT USE OR RISK CRASHES***
***USE IT ONLY FOR FUN***

> The underlying problem of RCU and memory usage could be solved more
> safely by making sure that the sleeping memory allocator path always
> waits until at least one RCU cleanup has occurred after it fails an
> allocation before it starts trying harder. That ought to also naturally
> throttle memory consumers more in the situation which is the right
> behaviour.
> 

In the case of call_rcu_bh(), you can be sure that the caller cannot afford 
'sleeping memory allocations'. Better drop a frame than block the stack, no ?

Eric
