Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWHIByQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWHIByQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWHIByQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:54:16 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:31067 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750800AbWHIByP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:54:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=QY900rdAHb3JXuL66soOj/wFw8v+gp8xG69cvZv1aS8GYV/0o0VSJiOPArKeTXiY3fmznOwsyCt+LC2Pxs87Lc0PTNoz0Bkeh8IPyb97PZtmuF0QBvRcH1a+AL5krqC59ITXfyOy5G0gYhbwZ5m92w501EPSbkWAMGSLj6fHg4E=  ;
Message-ID: <44D9403F.4070608@yahoo.com.au>
Date: Wed, 09 Aug 2006 11:54:07 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Bligh <mbligh@mbligh.org>
CC: rohitseth@google.com, Dave Hansen <haveblue@us.ibm.com>,
       Kirill Korotaev <dev@sw.ru>, vatsa@in.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, sam@vilain.net, linux-kernel@vger.kernel.org,
       dev@openvz.org, efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, pj@sgi.com, Andrey Savochkin <saw@sw.ru>
Subject: Re: memory resource accounting (was Re: [RFC, PATCH 0/5] Going forward
 with Resource Management - A	cpu controller)
References: <20060804050753.GD27194@in.ibm.com>	 <20060803223650.423f2e6a.akpm@osdl.org>	 <20060803224253.49068b98.akpm@osdl.org>	 <1154684950.23655.178.camel@localhost.localdomain>	 <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>	 <44D388DF.8010406@mbligh.org> <44D6EAFA.8080607@sw.ru>	 <44D74F77.7080000@mbligh.org>  <44D76B43.5080507@sw.ru>	 <1154975486.31962.40.camel@galaxy.corp.google.com>	 <1154976236.19249.9.camel@localhost.localdomain> <1154977257.31962.57.camel@galaxy.corp.google.com> <44D798B1.8010604@mbligh.org> <44D89D7D.8040006@yahoo.com.au> <44D8C4F9.3000402@mbligh.org>
In-Reply-To: <44D8C4F9.3000402@mbligh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:

>>> It also saves you from maintaining huge lists against each page.
>>>
>>> Worse case, you want to bill everyone who opens that address_space
>>> equally. But the semantics on exit still suck.
>>>
>>> What was Alan's quote again? "unfair, unreliable, inefficient ...
>>> pick at least one out of the three". or something like that.
>>
>>
>> What's the sucking semantics on exit? I haven't looked much at the
>> existing memory controllers going around, but the implementation I
>> imagine looks something like this (I think it is conceptually similar
>> to the basic beancounters idea):
>
>
> You have to increase the other processes allocations, putting them
> over their limits. If you then force them into reclaim, they're going
> to stall, and give bad latency.


Not within a particular container. If the process exits but leaves around
some memory charge, then that just remains within the same container.

If you want to remove a container, then you have a hierarchy of billing
and your charge just gets accounted to the parent.

>
>> - anyone who allocates a page for anything gets charged for that page.
>>   Except interrupt/softirq context. Could we ignore these for the 
>> moment?
>>
>>   This does give you kernel (slab, pagetable, etc) allocations as 
>> well as
>>   userspace. I don't like the idea of doing controllers for inode cache
>>   and controllers for dentry cache, etc, etc, ad infinitum.
>>
>> - each struct page has a backpointer to its billed container. At the mm
>>   summit Linus said he didn't want back pointers, but I clarified 
>> with him
>>   and he isn't against them if they are easily configured out when 
>> not   using memory controllers.
>>
>> - memory accounting containers are in a hierarchy. If you want to 
>> destroy a
>>   container but it still has billed memory outstanding, that gets 
>> charged
>>   back to the parent. The data structure itself obviously still needs to
>>   stay around, to keep the backpointers from going stale... but that 
>> could
>>   be as little as a word or two in size.
>>
>> The reason I like this way of accounting is that it can be done with 
>> a couple
>> of hooks into page_alloc.c and an ifdef in mm.h, and that is the 
>> extent of
>> the impact on core mm/ so I'd be against anything more intrusive 
>> unless this
>> really doesn't work.
>>
>
> See "inefficent" above (sorry ;-)) What you've chosen is more correct,
> but much higher overhead. The point was that there's tradeoffs either
> way - the conclusion we came to last time was that to make it 100%
> correct, you'd be better off going with a model like Xen.


So if someone says they want it 100% correct, I can tell them to use
Xen and not put accounting into any place in the kernel that allocates
memory? Sweet OK.

If we're happy with doing userspace only memory, then a similar scheme
can be implemented on an object-accounting basis (eg. vmas). I think
there is something that already implements this.

>
> 1. You're adding a backpointer to struct page.


That's nowhere near the overhead of pte chain rmaps, though. I think it
is perfectly acceptible (assuming you *did* want to account kernel page
allocations) and probably will be difficult to notice on non-crazy-highmem
boxes. Which is just about everyone we care about now.

>
> 2. Each page is not accounted to one container, but shared across them,
> so the billing changes every time someone forks or exits. And not just
> for that container, but all of them. Think pte chain based rmap ...
> except worse.


In my proposed scheme, it is just the first who allocates. You hope that
statistically, that is good enough. Otherwise you could go into tracking
what process has a reference to which dentry... good luck getting that
past Al and Christoph.

>
> 3. When a container needs to "shrink" when somebody else exits, how do
> we do reclaim pages from a specific container?


Not the problem of accounting. Any other scheme will have a similar
problem.

However, having the container in the struct page *could* actually help
directed reclaim FWIW.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
