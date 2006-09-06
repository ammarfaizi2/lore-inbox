Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWIFNxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWIFNxt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWIFNxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:53:49 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:40340 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751050AbWIFNxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:53:47 -0400
Message-ID: <44FED3CA.7000005@sw.ru>
Date: Wed, 06 Sep 2006 17:57:30 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alexey Dobriyan <adobriyan@mail.ru>, Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
 memory)
References: <44FD918A.7050501@sw.ru> <1157478392.3186.26.camel@localhost.localdomain>
In-Reply-To: <1157478392.3186.26.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2006-09-05 at 19:02 +0400, Kirill Korotaev wrote:
> 
>>Core Resource Beancounters (BC) + kernel/user memory control.
>>
>>BC allows to account and control consumption
>>of kernel resources used by group of processes. 
> 
> 
> Hi Kirill, 
> 
> I've honestly lost track of these discussions along the way, so I hope
> you don't mind summarizing a bit.
I think we need to create wiki to summarize it once and forever.
http://wiki.openvz.org/UBC_discussion

> Do these patches help with accounting for anything other than memory?
this patch set - no, but the complete one - does:
* numfile
* numptys
* numsocks (TCP, other, etc.)
* numtasks
* numflocks
...
this list of resources was chosen to make sure that no DoS from the container
is possible.
This list is extensible easily and if resource is out of interest than
its limits can be set to unlimited.

> Will we need new user/kernel interfaces for cpu, i/o bandwidth, etc...?
no. no new interfaces are required.

BUT: I remind you the talks at OKS/OLS and in previous UBC discussions.
It was noted that having a separate interfaces for CPU, I/O bandwidth
and memory maybe worthwhile. BTW, I/O bandwidth already has a separate
interface :/

> Have you given any thought to the possibility that a task might need to
> move between accounting contexts?  That has certainly been a
> "requirement" pushed on to CKRM for a long time, and the need goes
> something like this:
Yes we thought about this and this is no more problematic for BC
than for CKRM. See my explanation below.

> 1. A system runs a web server, which services several virtual domains
> 2. that web server receives a request for foo.com
> 3. the web server switches into foo.com's accounting context
> 4. the web server reads things from disk, allocates some memory, and
>    makes a database request.
> 5. the database receives the request, and switches into foo.com's
>    accounting context, and charges foo.com for its resource use
> etc...
The question is - whether web server is multithreaded or not...
If it is not - then no problem here, you can change current
context and new resources will be charged accordingly.

And current BC code is _able_ to handle it with _minor_ changes.
(One just need to save bc not on mm struct, but rather on vma struct
and change mm->bc on set_bc_id()).

However, no one (can some one from CKRM team please?) explained so far
what to do with threads. Consider the following example.

1. Threaded web server spawns a child to serve a client.
2. child thread touches some pages and they are charged to child BC
   (which differs from parent's one)
3. child exits, but since its mm is shared with parent, these pages
   stay mapped and charged to child BC.

So the question is:  what to do with these pages?
- should we recharge them to another BC?
- leave them charged?

> So, the goal is to run _one_ copy of an application on a system, but
> account for its resources in a much more fine-grained way than at the
> application level.
Yes.

> I think we can probably use beancounters for this, if we do not worry
> about migrating _existing_ charges when we change accounting context.
> Does that make sense?
exactly. thats what I'm saying. we can use beancounters for this
if charges are kept for creator.

Thanks,
Kirill
