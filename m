Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266655AbUGMVz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266655AbUGMVz6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266866AbUGMVz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:55:58 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:30469 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266655AbUGMVzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:55:19 -0400
Message-ID: <40F45FF9.8030702@techsource.com>
Date: Tue, 13 Jul 2004 18:19:37 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Adrian Bunk <bunk@fs.tum.de>, Arjan van de Ven <arjanv@redhat.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Jakub Jelinek <jakub@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GCC 3.4 and broken inlining.
References: <1089287198.3988.18.camel@nigel-laptop.wpcb.org.au> <20040708120719.GS21264@devserv.devel.redhat.com> <20040708205225.GI28324@fs.tum.de> <20040708210925.GA13908@devserv.devel.redhat.com> <1089324501.3098.9.camel@nigel-laptop.wpcb.org.au> <20040709062403.GA15585@devserv.devel.redhat.com> <20040710012117.GA28324@fs.tum.de> <20040710023045.GD21066@holomorphy.com>
In-Reply-To: <20040710023045.GD21066@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:
> On Fri, Jul 09, 2004 at 08:24:03AM +0200, Arjan van de Ven wrote:
> 
>>>one thing to note is that you also need to monitor stack usage then :)
>>>inlining somewhat blows up stack usage so do monitor it...
> 
> 
> On Sat, Jul 10, 2004 at 03:21:17AM +0200, Adrian Bunk wrote:
> 
>>How could inlining increase stack usage?
> 
> 
> As more variables go into scope, gcc's stack slot allocation bug bites
> progressively harder and stackspace requirements grow without bound.


Blah... you should see what Sun's compiler does with volatiles.

Imagine you have some pointers like this:

volatile int *a, *b, *c, *d, *e;

And they are all valid pointers.

And then you have an expression like this:

x = ((((*a + *b) + *c) + *d) + *e);

Since *a and *b are volatile, the Sun compiler thinks that the sum of 
the two is also volatile, allocates stack space for it.  It computes (*a 
+ *b), stores it on the stack, and then loads it back from the stack, 
and then computes that plus *c, stores that result on the stack, then 
reloads it, etc.

I had a case where pointers had to be volatile, because I needed the 
memory space (over PCI) read at the right point in the code, and I 
needed to do some math on what was read.  I had 32 lines of code each of 
which got allocated 5 temporary variables on the stack, for absolutely 
no good reason.  The solution was to cast away the volatile a la ((int)*a).

Now, we all know that it makes no sense for the sum of two volatiles to 
also be volatile.  Once *a and *b are dereferenced and their sum 
computed, the sum isn't going to change, and it isn't even an lvalue, so 
nothing can modify it!

So, you want to talk about bugs.... give GCC a little slack.  :)

