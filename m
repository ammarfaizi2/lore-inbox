Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUKWWqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUKWWqj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbUKWWmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 17:42:14 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:42161 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261604AbUKWWkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 17:40:19 -0500
Message-ID: <41A3BFAD.9000809@devicelogics.com>
Date: Tue, 23 Nov 2004 15:54:37 -0700
From: "Jeff V. Merkey" <jmerkey@devicelogics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: ltd@cisco.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9 pktgen module causes INIT process respawning   and
 sickness
References: <5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14.suse.lists.linux.kernel> <419E6B44.8050505@devicelogics.com.suse.lists.linux.kernel> <419E6B44.8050505@devicelogics.com.suse.lists.linux.kernel> <5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14.suse.lists.linux.kernel> <5.1.0.14.2.20041123094109.04003720@171.71.163.14.suse.lists.linux.kernel> <41A2862A.2000602@devicelogics.com.suse.lists.linux.kernel> <p73k6sc1epi.fsf@bragg.suse.de> <41A3B23C.2080406@devicelogics.com> <20041123222734.GK20608@wotan.suse.de>
In-Reply-To: <20041123222734.GK20608@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>On Tue, Nov 23, 2004 at 02:57:16PM -0700, Jeff V. Merkey wrote:
>  
>
>>Implementation of this with skb's would not be trivial. M$ in their 
>>network drivers did this sort of circular list of pages
>>structure per adapter for receives and use it "pinned" to some of their 
>>proprietary drivers in W2K and would use their
>>version of an skb as a "pointer" of sorts that could dynamically assign 
>>a filled page from this list as a "receive" then perform
>>the user space copy from the page and release it back to the adapter. 
>>This allowed them to fill the ring buffers with static
>>addresses and copy into user space as fast as they could allocate 
>>control blocks.
>>    
>>
>
>The point is to eliminate the writes for the address and buffer
>fields in the ring descriptor right? I don't really see the point
>because you have to twiggle at least the owner bit, so you
>always have a cacheline sized transaction on the bus.
>And that would likely include the ring descriptor anyways, just
>implicitely in the read-modify-write cycle.
>  
>

True. Without the proposed hardware change to the 1 GbE abd 10GbE adapter,
I doubt this could be eliminated. There would still be the need to free 
the descriptor
from the ring buffer and this does require touching this memory. Scrap 
that idea.
The long term solution is for the card vendors to enable a batch mode 
for submission
of ring buffer entries that do not require clearing any fields, but that 
simply would
take an entire slate of newly allocated s/g entries and swap them 
between tables.

for sparse conditions, an interrupt when packet(s) are pending is 
already instrumented
in these adapters, so adding this capability would not be diffidult. 
I've probed around
with some of these vendors with these discussions, and for the Intel 
adapters, it would
require a change to the chipset, but not a major one. It's doable.

>If you're worried about the latencies of the separate writes
>you could always use write combining to combine the writes.
>
>If you write the full cache line you could possibly even
>avoid the read in this cae.
>
>On x86-64 it can be enabled for writel/writeq with CONFIG_UNORDERED_IO.
>You just have to be careful to add all the required memory
>barriers, but the driver should have that already if it works
>on IA64/sparc64/alpha/ppc64. 
>
>It's an experimental option not enabled by default on x86-64 because
>the performance implications haven't been really investigated well.
>You could probably do it on i386 too by setting the right MSR
>or adding a ioremap_wc() 
>  
>

I will look at this feature and see how much it helps. Long term, folks 
should
inquire from the board vendors if they would be willing to instrument 
something
like this. Then the OS's could actually use 10GbE. The buses support the
bandwidth today, and I have measured it.

Jeff

>-Andi
>
>  
>

