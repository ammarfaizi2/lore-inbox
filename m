Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261835AbSJJS0u>; Thu, 10 Oct 2002 14:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbSJJS0u>; Thu, 10 Oct 2002 14:26:50 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:64150 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261835AbSJJS0q>;
	Thu, 10 Oct 2002 14:26:46 -0400
Message-ID: <3DA5C6EC.7040904@us.ibm.com>
Date: Thu, 10 Oct 2002 11:29:00 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE <lse-tech@lists.sourceforge.net>, Martin Bligh <mjbligh@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] Memory Binding API v0.3 2.5.41
References: <3DA4D3E4.6080401@us.ibm.com> <3DA4EE6C.6B4184CC@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Matthew Dobson wrote:
>>Greetings & Salutations,
>>        Here's a wonderful patch that I know you're all dying for...  Memory
>>Binding!
> Seems reasonable to me.
Good news!

> Could you tell us a bit about the operator's view of this?
> 
> I assume that a typical usage scenario would be to bind a process
> to a bunch of CPUs and to then bind that process to a bunch of
> memblks as well? 
> 
> If so, then how does the operator know how to identify those
> memblks?  To perform the (cpu list) <-> (memblk list) mapping?
Well, that's what the super-duper In-Kernel topology API is for!  ;)  If 
the operator wanted to ensure that all the processes memory was *only* 
allocated from the memblks closest to her bound CPUs, she'd loop over 
her cpu binding, and for each set bit, she'd:
	bitmask &= 1 << __node_to_memblk(__cpu_to_node(cpu));
I suppose that I could include a macro to do this in the patch, but I 
was a bit afraid (and still am) that it already may be a bit large for 
people's tastes.  I've got some suggestions on how to split it up/pare 
it down, so we'll see.

> Also, what advantage does this provide over the current node-local
> allocation policy?  I'd have thought that once you'd bound a 
> process to a CPU (or to a node's CPUs) that as long as the zone
> fallback list was right, that process would be getting local memory
> pretty much all the time anyway?
Very true...  This is to specifically allow for processes that want to 
do something *different* than the default policy.  Again, akin to CPU 
affinity, this is not something that the average process is going to 
ever use, or even care about.  The majority of processes don't 
specifically bind themselves to certain CPUs or groups of CPUs, because 
for them the default scheduler policies are fine.  For the majority of 
processes, the default memory allocation policy works just dandy.  This 
is for processes that want to do something different: Testing/debugging 
apps on a large (likely NUMA) system, high-end databases, and who knows 
what else?  There is also a plan to add a function call to bind specific 
regions of a processes memory to certain memblks, and this would allow 
for efficient shared memory for process groups spread across a large system.

> Last but not least: you got some benchmark numbers for this?
Nope..  It is not something that is going to (on average) improve 
benchmark numbers for something like a kernel compile...  As you 
mentioned above, the default policy is to allocate from the local memory 
block anyway.  This API is more useful for something where you want to 
pin your memory close to a particular process that your process is 
working with, or pin you memory to a different node than the one you're 
executing on to purposely test/debug something.  If you'd like, I can do 
some kernbench runs or something to come up with some numbers to show 
that it doesn't negatively affect performance, but I don't know of any 
benchmarking suites offhand that would show positive numbers.

> Thanks.
My pleasure! ;)

Cheers!

-Matt

