Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266751AbUG1Bbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266751AbUG1Bbn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 21:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266755AbUG1Bbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 21:31:42 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:64697 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266751AbUG1Bbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 21:31:40 -0400
Message-ID: <41070183.5000701@yahoo.com.au>
Date: Wed, 28 Jul 2004 11:29:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Avi Kivity <avi@exanet.com>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
 server on local NFS mount
References: <41050300.90800@exanet.com> <20040726210229.GC21889@openzaurus.ucw.cz> <4106B992.8000703@exanet.com> <20040727203438.GB2149@elf.ucw.cz> <4106C2E8.905@exanet.com>
In-Reply-To: <4106C2E8.905@exanet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> Pavel Machek wrote:
> 
>> I'd hope that kswapd was carefully to make sure that it always has
>> enough pages...
>>
>> ...it is harder to do the same auditing with userland program.
>>
>>  
>>
> Very true. But is a kernel thread like kswapd depends on a userspace 
> program, then that program better be well behaved.
> 
>>> A more complete solution would be to assign memory reserve levels 
>>> below which a process starts allocating synchronously. For example, 
>>> normal processes must have >20MB to make forward progress, kswapd 
>>> wants >15MB and the NFS server needs >10MB. Some way would be needed 
>>> to express the dependencies.
>>>   
>>
>>
>> Yes, something like that would be neccessary. I believe it would be
>> slightly more complicated, like
>>
>> "NFS server needs > 10MB *and working kswapd*", so you'd need 25MB in
>> fact... and this info should be stored in some readable form so that
>> it can be checked.
>>
>>  
>>
> If the NFS server needed kswapd, we'd deadlock pretty soon, as kswapd 
> *really* needs the NFS server. In our case, all block I/O is done using 
> unbuffered I/O, and all memory is preallocated, so we don't need kswapd 
> at all, just that small bit of memory that syscalls consume.
> 
> If the NFS server really needs kswapd, then there'd better be two of 
> them. Regular processes would depend on one kswapd, which depends on the 
> NFS server, which depends on the second kswapd, which depends on the 
> hardware alone. It should be fun trying to describe that topology to the 
> kernel through some API.
> 
> Our filesystem actually does something like that internally, except the 
> dependency chain length is seven, not two.
> 

There is some need arising for a call to set the PF_MEMALLOC flag for
userspace tasks, so you could probably get a patch accepted. Don't
call it KSWAPD_HELPER though, maybe MEMFREE or RECLAIM or RECLAIM_HELPER.

But why is your NFS server needed to reclaim memory? Do you have the
filesystem mounted locally?
