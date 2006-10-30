Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWJ3N2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWJ3N2M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 08:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWJ3N2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 08:28:12 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:57256 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S932444AbWJ3N2L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 08:28:11 -0500
Message-ID: <4545FDCD.3080107@in.ibm.com>
Date: Mon, 30 Oct 2006 18:57:41 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Paul Menage <menage@google.com>
CC: dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com
Subject: Re: [ckrm-tech] RFC: Memory Controller
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com> <6599ad830610300304l58e235f7td54ef8744e462a55@mail.gmail.com>
In-Reply-To: <6599ad830610300304l58e235f7td54ef8744e462a55@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> On 10/30/06, Balbir Singh <balbir@in.ibm.com> wrote:
>> +----+---------+------+---------+------------+----------------+-----------+
>> |ii  |  No     | Yes  | configfs| Memory,    | Plans to       |   Yes     |
>> |    |         |      |         | task limit.| provide a      |           |
>> |    |         |      |         | Plans to   | framework      |           |
>> |    |         |      |         | allow      | to write new   |           |
>> |    |         |      |         | CPU and I/O| controllers    |           |
> 
> I have a port of Rohit's memory controller to run over my generic containers.

Cool!

> 
>> d. Fake NUMA Nodes
>>
>> This approach was suggested while discussing the memory controller
>>
>> Advantages
>>
>> (i)   Accounting for zones is already present
>> (ii)  Reclaim code can directly deal with zones
>>
>> Disadvantages
>>
>> (i)   The approach leads to hard partitioning of memory.
>> (ii)  It's complex to
>>       resize the node. Resizing is required to allow change of limits for
>>       resource management.
>> (ii)  Addition/Deletion of a resource group would require memory hotplug
>>       support for add/delete a node. On deletion of node, its memory is
>>       not utilized until a new node of a same or lesser size is created.
>>       Addition of node, requires reserving memory for it upfront.
> 
> A much simpler way of adding/deleting/resizing resource groups is to
> partition the system at boot time into a large number of fake numa
> nodes (say one node per 64MB in the system) and then use cpusets to
> assign the appropriate number of nodes each group. We're finding a few
> ineffiencies in the current code when using such a large number of
> small nodes (e.g. slab alien node caches), but we're confident that we
> can iron those out.
> 

You'll also end up with per zone page cache pools for each zone. A list of
active/inactive pages per zone (which will split up the global LRU list).
What about the hard-partitioning. If a container/cpuset is not using its full
64MB of a fake node, can some other node use it? Also, won't you end up
with a big zonelist?

>> (iv)   How do we account for shared pages? Should it be charged to the first
>>        container which touches the page or should it be charged equally among
>>        all containers sharing the page?
> 
> A third option is to allow inodes to be associated with containers in
> their own right, and charge all pages for those inodes to the
> associated container. So if several different containers are sharing a
> large data file, you can put that file in its own container, and you
> then have an exact count of how many pages are in use in that shared
> file.
> 
> This is cheaper than having to keep track of multiple users of a page,
> and is also useful when you're trying to do scheduling, to decide who
> to evict. Suppose you have two jobs each allocating 100M of anonymous
> memory and each accessing all of a 1G shared file, and you need to
> free up 500M of memory in order to run a higher-priority job.
> 
> If you charge the first user, then it will appear that the first job
> is using 1.1G of memory and the second is using 100M of memory. So you
> might evict the first job, thinking it would free up 1.1G of memory -
> but it would actually only free up 100M of memory, since the shared
> pages would still be in use by the second job.
> 
> If you share the charge between both users, then it would appear that
> each job is using 600M of memory - but it's still the case that
> evicting either one would only free up 100M of memory.
> 
> If you can see that the shared file that they're both using is
> accounting for 1G of the memory total, and that they're each using
> 100M of anon memory, then it's easier to see that you'd need to evict
> *both* jobs in order to free up 500M of memory.

Consider the other side of the story. lets say we have a shared lib shared
among quite a few containers. We limit the usage of the inode containing
the shared library to 50M. Tasks A and B use some part of the library
and cause the container "C" to reach the limit. Container C is charged
for all usage of the shared library. Now no other task, irrespective of which
container it belongs to, can touch any new pages of the shared library.

We might also be interested in limiting the page cache usage of a container.
In such cases, this solution might not work out to be the best.

What you are suggesting is to virtually group the inodes by container rather
than task. It might make sense in some cases, but not all.

We could consider implementing the controllers in phases

1. RSS control (anon + mapped pages)
2. Page Cache control
3. Kernel accounting and control




-- 
	Cheers,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
