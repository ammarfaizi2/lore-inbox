Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266049AbUAFAqB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265940AbUAFAm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:42:59 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:25795 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266035AbUAFAj4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:39:56 -0500
Message-ID: <3FFA03D9.2040906@cyberone.com.au>
Date: Tue, 06 Jan 2004 11:39:53 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: colpatch@us.ibm.com
CC: linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       Andrew Morton <akpm@osdl.org>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: Re: [TRIVIAL PATCH] Use valid node number when unmapping CPUs
References: <3FE74801.2010401@us.ibm.com> <3FE78F53.9090302@cyberone.com.au> <3FF9EABF.7050906@us.ibm.com>
In-Reply-To: <3FF9EABF.7050906@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Matthew Dobson wrote:

> Nick Piggin wrote:
>
>>
>>
>> Matthew Dobson wrote:
>>
>>> The cpu_2_node array for i386 is initialized to 0 for each CPU, 
>>> effectively mapping all CPUs to node 0 unless changed.  When we 
>>> unmap CPUs, however, we stick a -1 in the array, mapping the CPU to 
>>> an invalid node.  This really isn't helpful.  We should map the CPU 
>>> to node 0, to make sure that callers of cpu_to_node() and friends 
>>> aren't returned a bogus node number.  This trivial patch changes the 
>>> unmapping code to place a 0 in the node mapping for removed CPUs.
>>>
>>> Cheers!
>>
>>
>>
>>
>> I'd prefer it got initialised to -1 for each cpu, and either set to -1
>> or not touched during unmap.
>
> >
>
>>
>> 0 is more bogus than the alternatives, isn't it? At least for the subset
>> of CPUs not on node 0. Callers should be fixed.
>
>
> Not really...  These macros are usually used for things like 
> scheduling, memory placement and other decisions.  Right now the value 
> doesn't have to be error-checked, because it is assumed to always 
> return a valid node.  For these types of uses, it's far better to 
> schedule/allocate something on the wrong node (ie: node 0) than on an 
> invalid node (ie: node -1).  Having a possible negative value for this 
> will break things when used as an array index (as it often is), and 
> will force us to put tests to ensure it is a valid value before using 
> it, and introduce possible races in the future (ie: imagine testing if 
> CPU 17's node mapping is non-negative, simultaneously unmapping the 
> CPU, then using the macro again to make a node decision.  You may get 
> a negative value back, thus causing you to index way off the end of 
> your array... BOOM).  If we stick with the convention that we always 
> have a valid (even if not *correct*) value in these arrays, the worst 
> we should get is poor performance, not breakage.


OK, then keep the correct node number. No need to change it to node 0.
Having the value not change at all (1) gives you the correct information
at all times, and (2) eliminates the remaining race possibilities.


