Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUAEXAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUAEXA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:00:29 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:62889 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265993AbUAEW5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:57:39 -0500
Message-ID: <3FF9EABF.7050906@us.ibm.com>
Date: Mon, 05 Jan 2004 14:52:47 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       Andrew Morton <akpm@osdl.org>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: Re: [TRIVIAL PATCH] Use valid node number when unmapping CPUs
References: <3FE74801.2010401@us.ibm.com> <3FE78F53.9090302@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> 
> Matthew Dobson wrote:
> 
>> The cpu_2_node array for i386 is initialized to 0 for each CPU, 
>> effectively mapping all CPUs to node 0 unless changed.  When we unmap 
>> CPUs, however, we stick a -1 in the array, mapping the CPU to an 
>> invalid node.  This really isn't helpful.  We should map the CPU to 
>> node 0, to make sure that callers of cpu_to_node() and friends aren't 
>> returned a bogus node number.  This trivial patch changes the 
>> unmapping code to place a 0 in the node mapping for removed CPUs.
>>
>> Cheers!
> 
> 
> 
> I'd prefer it got initialised to -1 for each cpu, and either set to -1
> or not touched during unmap.
 >
> 
> 0 is more bogus than the alternatives, isn't it? At least for the subset
> of CPUs not on node 0. Callers should be fixed.

Not really...  These macros are usually used for things like scheduling, 
memory placement and other decisions.  Right now the value doesn't have 
to be error-checked, because it is assumed to always return a valid 
node.  For these types of uses, it's far better to schedule/allocate 
something on the wrong node (ie: node 0) than on an invalid node (ie: 
node -1).  Having a possible negative value for this will break things 
when used as an array index (as it often is), and will force us to put 
tests to ensure it is a valid value before using it, and introduce 
possible races in the future (ie: imagine testing if CPU 17's node 
mapping is non-negative, simultaneously unmapping the CPU, then using 
the macro again to make a node decision.  You may get a negative value 
back, thus causing you to index way off the end of your array... BOOM). 
  If we stick with the convention that we always have a valid (even if 
not *correct*) value in these arrays, the worst we should get is poor 
performance, not breakage.

Cheers!

-Matt

