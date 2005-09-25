Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVIYIyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVIYIyU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 04:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVIYIyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 04:54:20 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:48101 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751246AbVIYIyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 04:54:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=UY7zAZjjn6316CGRswPA5413ZsbrfjG94E1tdyBEEGNMLeYluhcXuED+icRUJFrlrS1m21Bvu4pmXS4+oi1cwk/MjddmJdUZMw6VUI+oB8EyTfzuZYVkQ2LQrIiqZarWZlQJxBtKTz5UXjWkyxBGh56rMpuLTQr/V4t0QnFz66s=
Message-ID: <433665A4.6010400@gmail.com>
Date: Sun, 25 Sep 2005 17:53:56 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: zwane@linuxpower.ca, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6 01/04] brsem: implement big reader semaphore
References: <20050925064218.E7558977@htj.dyndns.org> <20050925064218.FF1C2BEC@htj.dyndns.org> <43364F70.7010705@yahoo.com.au> <43365BCA.6030904@gmail.com> <43365F82.1040801@yahoo.com.au>
In-Reply-To: <43365F82.1040801@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hello, Nick.

Nick Piggin wrote:
> Tejun Heo wrote:
> 
>>
>>  As I've said in the other reply, I'll first rip off three stage init 
>> thing for cpucontrol.  That added pretty much complexity to it.  And 
>> with the weird naming scheme, please tell me how to fix it.  I have no 
>> problem renaming things.
>>
> 
> OK, my criticism of your naming was not constructive so I apologise
> for that. I willll help you with some of those minor issues if we
> establish that your overall design is a a goer.
> 

  Thanks. :-)

> 
>>> What would be wrong with an array of NR_CPUS rwsems? The only
>>> tiny trick you would have to do AFAIKS is have up_read remember
>>> what rwsem down_read took, but that could be returned from
>>> down_read as a token.
>>
>>
>>
>>  Using array of rwsems means that every reader-side ops performs 
>> (unnecessary) real down and up operations on the semaphore which 
>> involve atomic memory op and probably memory barrier.  These are 
>> pretty expensive operations.
>>
>>  What brsem tries to do is implementing rwsem semantics while 
>> performing only normal (as opposed to atomic/barrier) intstructions 
>> during reader-side operations.  That's why all the call_on_all_cpus 
>> stuff is needed while write-locking.  Do you think avoiding 
>> atomic/barrier stuff would be an overkill?
>>
> 
> Yes I think so. I think the main problem on modern CPUs is
> not atomic operations as such, but cacheline bouncing.
> 
> Without any numbers, I'd guess that your down_read is more
> expensive than mine simply due to touching more cachelines
> and having more branches.

  Other than local_bh_disable/enable(), all brsem read ops do are

  1. accessing sem->idx
  2. calculate per-cpu rcnt address from sem->idx
  3. do one branch on the value of per-cpu rcnt
  4. inc/dec per-cpu rcnt

  So, it does access one more cachline and, yeap, there is one branch 
for bh enabling and several more inside local_bh_enable.  I'll try to 
get some benchmark numbers for comparison.

  I'm thinking about adding down_read(&xxx->s_umount) to write(2) and 
compare normal rwsem and brsem performance by repeitively writing short 
data into a file on a UP machine.  Do you have better ideas?

> 
> The other thing is simply that you really want your
> synchronization primitives to be as simple and verifiable
> as possible. For example rwsems even recently have had subtle
> memory ordering and other implemntation corner cases, and
> they're much less complex than this brsem.
> 
> Nick
> 

  Thanks.

-- 
tejun
