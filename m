Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVIYKLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVIYKLP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 06:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVIYKLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 06:11:15 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:13485 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751092AbVIYKLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 06:11:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=unSqeI8I+BRi1OSGNg+lFgfyxBqE9wwDfHaRUhIG3Rt73A+7fg09Bk5xUFvZzAdgVzLIBV4cqqm0KYid1Oz5jqwnhTYusJnPfPE+AhAthE8kOgttOhwbT7n0uvyYpE7h9kxbviqTBDQe1uC7DxkSc6S27gpS4ar7+YY3jGuS394=
Message-ID: <43367676.1080308@gmail.com>
Date: Sun, 25 Sep 2005 19:05:42 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6 01/04] brsem: implement big reader semaphore
References: <20050925064218.E7558977@htj.dyndns.org> <20050925064218.FF1C2BEC@htj.dyndns.org> <43364F70.7010705@yahoo.com.au> <43365BCA.6030904@gmail.com> <43365F82.1040801@yahoo.com.au> <433665A4.6010400@gmail.com> <43366CBA.5010306@yahoo.com.au>
In-Reply-To: <43366CBA.5010306@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hello, Nick.

Nick Piggin wrote:
> Tejun Heo wrote:
> 
>>  Other than local_bh_disable/enable(), all brsem read ops do are
>>
>>  1. accessing sem->idx
>>  2. calculate per-cpu rcnt address from sem->idx
>>  3. do one branch on the value of per-cpu rcnt
>>  4. inc/dec per-cpu rcnt
>>
>>  So, it does access one more cachline and, yeap, there is one branch 
>> for bh enabling and several more inside local_bh_enable.  I'll try to 
>> get some benchmark numbers for comparison.
>>
> 
> Well local_bh_disable touches the preempt count too, although we
> can probably assume that's hot in cache.
> 
> You might also find yours has a bigger icache footprint as well.
> 
>>  I'm thinking about adding down_read(&xxx->s_umount) to write(2) and 
>> compare normal rwsem and brsem performance by repeitively writing 
>> short data into a file on a UP machine.  Do you have better ideas?
>>
> 
> To be honest I'd say that you wouldn't be able to measure it if
> you're going through a regular system call path, although such
> a measurement certainly won't hurt.
> 
> I don't have a better idea though. I don't think a busy loop
> microbenchmark is going to be very informative either, it might
> actually give a measurable difference but that difference
> probably won't be too representitive of real use :\
> 

  I did a busy-loop microbenchmark, and I think it's informative enough. :-)

  The following command is run on three versions - vanilla version, one 
with read_down/up(->s_umount) added to vfs_write(), and one with 
brsem_read_down/up(->s_umount) added to vfs_write().

# time -p dd if=/dev/zero of=out bs=32 count=10M

  The test is run three times and the results are averaged.

a. vanilla

real 58.63
user 5.61
sys 52.37

b. rwsem

real 59.24
user 6.06
sys 52.29

c. brsem

real 61.74
user 5.78
sys 55.04

  I don't think brsem has any chance of being faster than rwsem if it's 
slower in this micro benchmark.  One weird thing is that the result of 
rwsem consistently showed higher user time and lower system time than 
vanilla (no synchronization) case, maybe oprofiling will tell something.

  Anyways, you were absolutely right.  My brsem was a pretty stupid idea 
after all.  Let's hope at least I learned something from it.  :-(

  Thanks a lot.

-- 
tejun
