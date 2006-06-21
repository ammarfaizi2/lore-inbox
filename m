Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932693AbWFUTfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbWFUTfL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbWFUTfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:35:11 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:21406 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932693AbWFUTfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:35:07 -0400
Message-ID: <44999F5A.2080809@watson.ibm.com>
Date: Wed, 21 Jun 2006 15:34:50 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@engr.sgi.com>
CC: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com> <20060609042129.ae97018c.akpm@osdl.org> <4489EE7C.3080007@watson.ibm.com> <449999D1.7000403@engr.sgi.com> <44999A98.8030406@engr.sgi.com>
In-Reply-To: <44999A98.8030406@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:

>Jay Lan wrote:
>  
>
>>Shailabh Nagar wrote:
>> 
>>    
>>
>>>Andrew Morton wrote:
>>>
>>>   
>>>      
>>>
>>>>You see the problem - if one userspace package wants the tgid-stats and
>>>>another concurrently-running one does now, what do we do?  Just leave it
>>>>enabled and run a bit slower?
>>>>
>>>>If so, how much slower?  Your changelog says some potential users don't
>>>>need the tgid-stats, but so what?  I assume this patch is a performance
>>>>thing?  If so, has it been quantified?
>>>>  
>>>>     
>>>>        
>>>>
>>>Here are some results from running a simple program (source below) that does
>>>10 iterations of creating and then destroying 1000 threads. On the side, another utility
>>>kept reading the pid (+tgid if present) stats from exiting tasks.
>>>
>>>   
>>>      
>>>
>>I ran my testing using the same program posted by Shalilabh attached in his
>>posting.
>>    
>>
Thanks for running this. The results look interesting.

>>System: SGI a350, a two cpus IA64 machine.
>>Kernel:  2.6.17-rc3 + delay-acct-taskstats patch set
>>      + tgid-disable_patch_shailabh + exit race patch_balbir +
>>csa_patch_jlan
>>
>>I also modified the Decumentation/accounting/getdelay.c:
>>  - it repeatedly does recv() to retrieve data from kernel
>>  - instead of using printf() to display data received, i simply write
>>it to
>>    disk as it would be for an accounting daemon. Note that currently
>>both the
>>    BSD (or GNU) accounting and the CSA writes accounting data from kernel.
>>    As an effort of moving accounting system to userspace, the raw data
>>needs
>>    to be written to a raw file first before further processing.
>>    
>>
In exit_recv.c, you appear to be dumping the per-tgid data  received to 
disk too ?
If the accounting daemon isn't interested in per-tgid, shouldn't it be 
discarding the data immediately after
doing the recv() and only write to disk the data it wants ?
Perhaps I'm missing something.


<snip>

>>Another observation that i considered bad news is that all
>>10 runs produced 1 to 5 recv() error with errno=105 (ENOBUF).
>>    
>>
Wonder if this has to do with userspace not being able to keep up with 
the data flow because
of the pathological rate at which exits happen.

Anyway, lets look at the overhead part first perhaps.

--Shailabh
