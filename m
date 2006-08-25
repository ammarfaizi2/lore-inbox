Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWHYLqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWHYLqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 07:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWHYLqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 07:46:25 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:18819 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750748AbWHYLqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 07:46:24 -0400
Message-ID: <44EEE3BB.10303@sw.ru>
Date: Fri, 25 Aug 2006 15:49:15 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH] BC: resource beancounters (v2)
References: <44EC31FB.2050002@sw.ru> <20060823100532.459da50a.akpm@osdl.org>
In-Reply-To: <20060823100532.459da50a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>>As the first step we want to propose for discussion
>>the most complicated parts of resource management:
>>kernel memory and virtual memory.
> 
> 
> The patches look reasonable to me - mergeable after updating them for
> today's batch of review commentlets.
sure. will do updates as long as there are reasonable comments.

> I have two high-level problems though.
> 
> a) I don't yet have a sense of whether this implementation
>    is appropriate/sufficient for the various other
>    applications which people are working on.
> 
>    If the general shape is OK and we think this
>    implementation can be grown into one which everyone can
>    use then fine.
> 
> And...
> 
> 
>>The patch set to be sent provides core for BC and
>>management of kernel memory only. Virtual memory
>>management will be sent in a couple of days.
> 
> 
> We need to go over this work before we can commit to the BC
> core.  Last time I looked at the VM accounting patch it
> seemed rather unpleasing from a maintainability POV.
hmmm... in which regard?

> And, if I understand it correctly, the only response to a job
> going over its VM limits is to kill it, rather than trimming
> it.  Which sounds like a big problem?
No, UBC virtual memory management refuses occur on mmap()'s.
Andrey Savochkin wrote already a brief summary on vm resource management:

------------- cut ----------------
The task of limiting a container to 4.5GB of memory bottles down to the
question: what to do when the container starts to use more than assigned
4.5GB of memory?

At this moment there are only 3 viable alternatives.

A) Have separate memory management for each container,
   with separate buddy allocator, lru lists, page replacement mechanism.
   That implies a considerable overhead, and the main challenge there
   is sharing of pages between these separate memory managers.

B) Return errors on extension of mappings, but not on page faults, where
   memory is actually consumed.
   In this case it makes sense to take into account not only the size of used
   memory, but the size of created mappings as well.
   This is approximately what "privvmpages" accounting/limiting provides in
   UBC.

C) Rely on OOM killer.
   This is a fall-back method in UBC, for the case "privvmpages" limits
   still leave the possibility to overload the system.

It would be nice, indeed, to invent something new.
The ideal mechanism would
 - slow down the container over-using memory, to signal the user that
   he is over his limits,
 - at the same time this slowdown shouldn't lead to the increase of memory
   usage: for example, a simple slowdown of apache web server would lead
   to the growth of the number of serving children and consumption of more
   memory while showing worse performance,
 - and, at the same time, it shouldn't penalize the rest of the system from
   the performance point of view...
May be this can be achieved via carefully tuned swapout mechanism together
with disk bandwidth management capable of tracking asynchronous write
requests, may be something else is required.
It's really a big challenge.

Meanwhile, I guess we can only make small steps in improving Linux resource
management features for this moment.
------------- cut ----------------

Thanks,
Kirill
