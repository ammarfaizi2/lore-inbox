Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965589AbWKDS1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965589AbWKDS1n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 13:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965591AbWKDS1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 13:27:43 -0500
Received: from sp604001mt.neufgp.fr ([84.96.92.60]:59862 "EHLO Smtp.neuf.fr")
	by vger.kernel.org with ESMTP id S965589AbWKDS1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 13:27:43 -0500
Date: Sat, 04 Nov 2006 19:27:48 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: New filesystem for Linux
In-reply-to: <20061104173716.GA618@in.ibm.com>
To: ego@in.ibm.com
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Message-id: <454CDBA4.4040503@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <20061104173716.GA618@in.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham R Shenoy a écrit :
> On Thu, Nov 02, 2006 at 10:52:47PM +0100, Mikulas Patocka wrote:
>> Hi
> 
> Hi Mikulas
>> As my PhD thesis, I am designing and writing a filesystem, and it's now in 
>> a state that it can be released. You can download it from 
>> http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/
>>
>> It has some new features, such as keeping inode information directly in 
>> directory (until you create hardlink) so that ls -la doesn't seek much, 
>> new method to keep data consistent in case of crashes (instead of 
>> journaling), free space is organized in lists of free runs and converted 
>> to bitmap only in case of extreme fragmentation.
>>
>> It is not very widely tested, so if you want, test it.
>>
>> I have these questions:
>>
>> * There is a rw semaphore that is locked for read for nearly all 
>> operations and locked for write only rarely. However locking for read 
>> causes cache line pingpong on SMP systems. Do you have an idea how to make 
>> it better?
>>
>> It could be improved by making a semaphore for each CPU and locking for 
>> read only the CPU's semaphore and for write all semaphores. Or is there a 
>> better method?
> 
> I am currently experimenting with a light-weight reader writer semaphore 
> with an objective to do away what you call a reader side cache line
> "ping pong". It achieves this by using a per-cpu refcount.
> 
> A drawback of this approach, as Eric Dumazet mentioned elsewhere in this
> thread, would be that each instance of the rw_semaphore would require
> (NR_CPUS * size_of(int)) bytes worth of memory in order to keep track of
> the per-cpu refcount, which can prove to be pretty costly if this
> rw_semaphore is for something like inode->i_alloc_sem.

We might use an hybrid approach : Use a percpu counter if NR_CPUS <= 8

#define refcount_addr(zone, cpu) zone[cpu]

For larger setups, have a fixed limit of 8 counters, and use a modulo

#define refcount_addr(zone, cpu) zone[cpu & 7]

In order not use too much memory, we could use kind of vmalloc() space, using 
one PAGE per cpu, so that addr(cpu) = base + (cpu)*PAGE_SIZE;
(vmalloc space allows a NUMA allocation if possible)

So instead of storing in an object a table of 8 pointers, we store only the 
address for cpu0.


> 
> So the question I am interested in is, how many *live* instances of this
> rw_semaphore are you expecting to have at any given time?
> If this number is a constant (and/or not very big!), the light-weight
> reader writer semaphore might be useful.
> 
> Regards
> Gautham.

