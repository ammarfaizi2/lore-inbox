Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265531AbUG1Ftz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbUG1Ftz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 01:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbUG1Ftz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 01:49:55 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:17007 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265531AbUG1Ftx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 01:49:53 -0400
Message-ID: <41073A6C.1050606@yahoo.com.au>
Date: Wed, 28 Jul 2004 15:32:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Avi Kivity <avi@exanet.com>
CC: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
References: <200407280232.EAA14567@faui1m.informatik.uni-erlangen.de> <41073710.2020306@exanet.com>
In-Reply-To: <41073710.2020306@exanet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> Ulrich Weigand wrote:
> 
>> Avi Kivity wrote:
>>
>>  
>>
>>> In our case, all block I/O is done using unbuffered I/O, and all 
>>> memory is preallocated, so we don't need kswapd at all, just that 
>>> small bit of memory that syscalls consume.
>>>   
>>
>>
>> Does your userspace process need to send/receive network packets
>> in order to perform a write-out? 
> 
> Yes.
> 
>> If so, how can you make sure your
>> incoming packets aren't thrown away in out-of-memory situations?
>> (Outgoing packets can use PF_MEMALLOC memory I guess, but incoming
>> ones aren't associated to any process yet ...)
>>
>>  
>>
> I did nothing to address this. So far it works well, even under heavy 
> load. I guess a general solution needs to address this as well.
> 
> The kernel NFS client (which kswapd depends on) has the same issue. Has 
> anyone ever observed kswapd deadlock due to imcoming or outgoing NFS 
> packets being discarded due to oom?
> 

Yes this has been observed.

alloc_skb on the client needs to somehow know that traffic coming
from the server is "MEMALLOC" and allowed to use memory reserves.
