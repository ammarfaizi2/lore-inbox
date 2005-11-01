Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVKASHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVKASHu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 13:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVKASHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 13:07:50 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:41480 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751080AbVKASHs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 13:07:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <43679C69.6050107@jp.fujitsu.com>
References: <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au> <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu> <1130854224.14475.60.camel@localhost> <20051101142959.GA9272@elte.hu> <1130856555.14475.77.camel@localhost> <20051101150142.GA10636@elte.hu> <43679C69.6050107@jp.fujitsu.com>
X-OriginalArrivalTime: 01 Nov 2005 18:07:41.0174 (UTC) FILETIME=[26676160:01C5DF0F]
Content-class: urn:content-classes:message
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Tue, 1 Nov 2005 13:06:56 -0500
Message-ID: <Pine.LNX.4.61.0511011248330.2152@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Thread-Index: AcXfDyZxCNKT9Bb1SyqjccGSiqcdng==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Kamezawa Hiroyuki" <kamezawa.hiroyu@jp.fujitsu.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Dave Hansen" <haveblue@us.ibm.com>,
       "Mel Gorman" <mel@csn.ul.ie>, "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, "Andrew Morton" <akpm@osdl.org>,
       <kravetz@us.ibm.com>, "linux-mm" <linux-mm@kvack.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "lhms" <lhms-devel@lists.sourceforge.net>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 Nov 2005, Kamezawa Hiroyuki wrote:

> Ingo Molnar wrote:
>> so it's all about expectations: _could_ you reasonably remove a piece of
>> RAM? Customer will say: "I have stopped all nonessential services, and
>> free RAM is at 90%, still I cannot remove that piece of faulty RAM, fix
>> the kernel!". No reasonable customer will say: "True, I have all RAM
>> used up in mlock()ed sections, but i want to remove some RAM
>> nevertheless".
>>
> Hi, I'm one of men in -lhms
>
> In my understanding...
> - Memory Hotremove on IBM's LPAR? approach is
>   [remove some amount of memory from somewhere.]
>   For this approach, Mel's patch will work well.
>   But this will not guaranntee a user can remove specified range of
>   memory at any time because how memory range is used is not defined by an admin
>   but by the kernel automatically. But to extract some amount of memory,
>   Mel's patch is very important and they need this.
>
> My own target is NUMA node hotplug, what NUMA node hotplug want is
> - [remove the range of memory] For this approach, admin should define
>   *core* node and removable node. Memory on removable node is removable.
>   Dividing area into removable and not-removable is needed, because
>   we cannot allocate any kernel's object on removable area.
>   Removable area should be 100% removable. Customer can know the limitation before using.
>
> What I'm considering now is this:
> - removable area is hot-added area
> - not-removable area is memory which is visible to kernel at boot time.
> (I'd like to achieve this by the limitation : hot-added node goes into only ZONE_HIGHMEM)
> A customer can hot add their extra memory after boot. This is very easy to understand.
> Peformance problem is trade-off.(I'm afraid of this ;)
>
> If a cutomer wants to guarantee some memory areas should be hot-removable,
> he will hot-add them.
> I don't think adding memory for the kernel by hot-add is wanted by a customer.
>
> -- Kame

With ix86 machines, the page directory pointed to by CR3 needs
to always be present in physical memory. This means that there
must always be some RAM that can't be hot-swapped (you can't
put back the contents of the page-directory without using
the CPU which needs the page directory).

This is explained on page 5-21 of the i486 reference manual.
This happens because there is no "present" bit in CR3 as there
are in the page tables themselves.

This problem means that "surprise" swaps are impossible. However,
given a forewarning, it is possible to build a new table somewhere
in existing RAM within the physical constraints required, call
some code there (needs to be a 1:1 translation), disable paging,
then proceed. The problem is that of writing of the contents
of RAM to be replaced, to storage media so the new page-table
needs to be loaded from the new location. This may not work
if the LDT and the GDT are not accessible from their current
locations. If they are in the RAM to be replaced, you are
in a world of hurt taking the "world" apart and putting it
back together again.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
