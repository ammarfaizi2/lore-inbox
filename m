Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161233AbWJ3LEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161233AbWJ3LEe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 06:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161234AbWJ3LEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 06:04:34 -0500
Received: from smtp-out.google.com ([216.239.45.12]:50449 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1161233AbWJ3LEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 06:04:33 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=L1LXJ/qHDzJeX5vSEj/fHBW0lNXmneDozwCc7u7LUDaiPYmP02r0zoSkIoeWlI23l
	1lzRgwMQsU/Vx4tboMt6w==
Message-ID: <6599ad830610300304l58e235f7td54ef8744e462a55@mail.gmail.com>
Date: Mon, 30 Oct 2006 03:04:21 -0800
From: "Paul Menage" <menage@google.com>
To: balbir@in.ibm.com
Subject: Re: RFC: Memory Controller
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com, pj@sgi.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, rohitseth@google.com,
       dipankar@in.ibm.com, matthltc@us.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <4545D51A.1060808@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Balbir Singh <balbir@in.ibm.com> wrote:
> +----+---------+------+---------+------------+----------------+-----------+
> |ii  |  No     | Yes  | configfs| Memory,    | Plans to       |   Yes     |
> |    |         |      |         | task limit.| provide a      |           |
> |    |         |      |         | Plans to   | framework      |           |
> |    |         |      |         | allow      | to write new   |           |
> |    |         |      |         | CPU and I/O| controllers    |           |

I have a port of Rohit's memory controller to run over my generic containers.

>
> d. Fake NUMA Nodes
>
> This approach was suggested while discussing the memory controller
>
> Advantages
>
> (i)   Accounting for zones is already present
> (ii)  Reclaim code can directly deal with zones
>
> Disadvantages
>
> (i)   The approach leads to hard partitioning of memory.
> (ii)  It's complex to
>       resize the node. Resizing is required to allow change of limits for
>       resource management.
> (ii)  Addition/Deletion of a resource group would require memory hotplug
>       support for add/delete a node. On deletion of node, its memory is
>       not utilized until a new node of a same or lesser size is created.
>       Addition of node, requires reserving memory for it upfront.

A much simpler way of adding/deleting/resizing resource groups is to
partition the system at boot time into a large number of fake numa
nodes (say one node per 64MB in the system) and then use cpusets to
assign the appropriate number of nodes each group. We're finding a few
ineffiencies in the current code when using such a large number of
small nodes (e.g. slab alien node caches), but we're confident that we
can iron those out.

> (iv)   How do we account for shared pages? Should it be charged to the first
>        container which touches the page or should it be charged equally among
>        all containers sharing the page?

A third option is to allow inodes to be associated with containers in
their own right, and charge all pages for those inodes to the
associated container. So if several different containers are sharing a
large data file, you can put that file in its own container, and you
then have an exact count of how many pages are in use in that shared
file.

This is cheaper than having to keep track of multiple users of a page,
and is also useful when you're trying to do scheduling, to decide who
to evict. Suppose you have two jobs each allocating 100M of anonymous
memory and each accessing all of a 1G shared file, and you need to
free up 500M of memory in order to run a higher-priority job.

If you charge the first user, then it will appear that the first job
is using 1.1G of memory and the second is using 100M of memory. So you
might evict the first job, thinking it would free up 1.1G of memory -
but it would actually only free up 100M of memory, since the shared
pages would still be in use by the second job.

If you share the charge between both users, then it would appear that
each job is using 600M of memory - but it's still the case that
evicting either one would only free up 100M of memory.

If you can see that the shared file that they're both using is
accounting for 1G of the memory total, and that they're each using
100M of anon memory, then it's easier to see that you'd need to evict
*both* jobs in order to free up 500M of memory.

Paul
