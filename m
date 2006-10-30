Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161217AbWJ3Kes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161217AbWJ3Kes (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161223AbWJ3Kes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:34:48 -0500
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:29400 "EHLO
	ausmtp06.au.ibm.com") by vger.kernel.org with ESMTP
	id S1161217AbWJ3Ker (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:34:47 -0500
Message-ID: <4545D51A.1060808@in.ibm.com>
Date: Mon, 30 Oct 2006 16:04:02 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: dev@openvz.org, sekharan@us.ibm.com, menage@google.com, pj@sgi.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, rohitseth@google.com,
       dipankar@in.ibm.com, matthltc@us.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: RFC: Memory Controller
References: <20061030103356.GA16833@in.ibm.com>
In-Reply-To: <20061030103356.GA16833@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've seen a lot of discussion lately on the memory controller. The RFC below
provides a summary of the discussions so far. The goal of this RFC is to bring
together the thoughts so far, build consensus and agree on a path forward.

NOTE: I have tried to keep the information as accurate and current as possible.
Please bring out any omissions/corrections if you notice them. I would like to
keep this summary document accurate, current and live.

Summary of Memory Controller Discussions and Patches

1. Accounting

The patches submitted so far agree that the following memory
should be accounted for

Reclaimable memory

(i)   Anonymous pages - Anonymous pages are pages allocated by the user space,
      they are mapped into the user page tables, but not backed by a file.
(ii)  File mapped pages - File mapped pages map a portion of a file
(iii) Page Cache Pages - Consists of the following

    (a) Pages used during IPC using shmfs
    (c) Pages of a user mode process that are swapped out
    (c) Pages from block read/write operations
    (d) Pages from file read/write operations

Non Reclaimable memory

This memory is not reclaimable until it is explicitly released by the
allocator. Examples of such memory include slab allocated memory and
memory allocated by the kernel components in process context. mlock()'ed
memory is also considered as non-reclaimable, but it is usually handled
as a separate resource.

(i)  Slabs
(ii) Kernel pages and page_tables allocated on behalf of a task.

2. Control considerations for the memory controller

Control can be implemented using either

(i)  Limits
     Limits, limit the usage of the resource to the specified value. If the
     resource usage crosses the limit, then the group might be penalized
     or restricted. Soft limits can be exceeded by the group as long as
     the resource is still available. Hard limits are usually the cut-of-point.
     No additional resources might be allocated beyond the hard limit.

(ii) Guarantees
     Guarantees, come in two forms

     (a) Soft guarantees is a best effort service to provide the group
      with the specified guarantee of resource availability. In this form
      resources can be shared (the unutilized resources of one
      group can be used by other groups) among groups and groups are allowed to
      exceed their guarantee when the resource is available (there is
      no other group unable to meet its guarantee). When a group is unable
      to meet its guarantee, the system tries to provide it with it's
      guaranteed resources by trying to reclaim from other groups, which
      have exceeded their guarantee. In spite of its best effort, if the
      system is unable to meet the specified guarantee, the guarantee
      failed statistic of the group is incremented. This form of guarantees
      is best suited for non-reclaimable resources.

     (b) Hard guarantees is a more deterministic method of providing QoS.
     Resources need to be allocated in advance, to ensure that the group
     is always able to meet its guarantee. This form is undesirable as
     it leads to resource under utilization. Another approach is to
     allow sharing of resources, but when a group is unable to meet its
     guarantee, the system will OOM kill a group that exceeds its
     guarantee.  Hard guarantees are more difficult to provide for
     non-reclaimable resources, but might be easier to provide for
     reclaimable resources.

NOTE: It has been argued that guarantees can be implemented using
limits. See http://wiki.openvz.org/Guarantees_for_resources

3. Memory Controller Alternatives

(i)   Beancouners
(ii)  Containers
(iii) Resource groups (aka CKRM)
(iv)  Fake Nodes

+----+---------+------+---------+------------+----------------+-----------+
| No |Guarantee| Limit| User I/F| Controllers| New Controllers|Statistics |
+----+---------+------+---------+------------+----------------+-----------+
| i  |  No     | Yes  | syscall | Memory     | No framework   |   Yes     |
|    |         |      |         |            | to write new   |           |
|    |         |      |         |            | controllers    |           |
+----+---------+------+---------+------------+----------------+-----------+
|ii  |  No     | Yes  | configfs| Memory,    | Plans to       |   Yes     |
|    |         |      |         | task limit.| provide a      |           |
|    |         |      |         | Plans to   | framework      |           |
|    |         |      |         | allow      | to write new   |           |
|    |         |      |         | CPU and I/O| controllers    |           |
+----+---------+------+---------+------------+----------------+-----------+
|iii |  Yes    | Yes  | configfs| CPU, task  | Provides a     |   Yes     |
|    |         |      |         | limit &    | framework to   |           |
|    |         |      |         | Memory     | add new        |           |
|    |         |      |         | controller.| controllers    |           |
|    |         |      |         | I/O contr  |                |           |
|    |         |      |         | oller for  |                |           |
|    |         |      |         | older      |                |           |
|    |         |      |         | revisions  |                |           |
+----+---------+------+---------+------------+----------------+-----------+

4. Existing accounting

a. Beancounters currently account for the following resources

(i)   kmemsize - memory obtained through alloc_pages() with __GFP_BC flag set.
(ii)  physpages - Resident set size of the tasks in the group.
      Reclaim support is provided for this resource.
(iii) lockedpages - User pages locked in memory
(iv)  slabs - slabs allocated with kmem_cache_alloc_bc are accounted and
      controlled.

Beancounters provides some support for event notification (limit/barrier hit).

b. Containers account for the following resources

(i)   mapped pages
(ii)  anonymous pages
(iii) file pages (from the page cache)
(iv)  active pages

There is some support for reclaiming pages, the code is in the early stages of
development.

c. CKRM/RG Memory Controller

(i)   Tracks active pages
(ii)  Supports reclaim of LRU pages
(iii) Shared pages are not tracked

This controller provides its own res_zone, to aid reclaim and tracking of pages.

d. Fake NUMA Nodes

This approach was suggested while discussing the memory controller

Advantages

(i)   Accounting for zones is already present
(ii)  Reclaim code can directly deal with zones

Disadvantages

(i)   The approach leads to hard partitioning of memory.
(ii)  It's complex to
      resize the node. Resizing is required to allow change of limits for
      resource management.
(ii)  Addition/Deletion of a resource group would require memory hotplug
      support for add/delete a node. On deletion of node, its memory is
      not utilized until a new node of a same or lesser size is created.
      Addition of node, requires reserving memory for it upfront.

5. Open issues

(i)    Can we allow threads belonging to the same process belong
       to two different resource groups? Does this mean we need to do per-thread
       VM accounting now?
(ii)   There is an overhead associated with adding a pointer in struct page.
       Can this be reduced/avoided? One solution suggested is to use a
       mirror mem_map.
(iii)  How do we distribute the remaining resources among resource hungry
       groups? The Resource Group implementation used the ratio of the limits
       to decide on the ratio according to which they are distributed.
(iv)   How do we account for shared pages? Should it be charged to the first
       container which touches the page or should it be charged equally among
       all containers sharing the page?
(v)    Definition of RSS (see http://lkml.org/lkml/2006/10/10/130)

6. Going forward

(i)    Agree on requirements (there has been some agreement already, please
       see http://lkml.org/lkml/2006/9/6/102 and the BOF summary [7])
(ii)   Agree on minimum accounting and hooks in the kernel. It might be
       a good idea to take this up in phases
       phase 1 - account for user space memory
       phase 2 - account for kernel memory allocated on behalf of the user/task
(iii)  Infrastructure - There is a separate RFC on that.

7. References

1. http://www.openvz.org
2. http://lkml.org/lkml/2006/9/19/283 (Containers patches)
3. http://lwn.net/Articles/200073/ (Another Container Implementation)
4. http://ckrm.sf.net (Resource Groups)
5. http://lwn.net/Articles/197433/ (Resource Beancounters)
6. http://lwn.net/Articles/182369/ (CKRM Rebranded)
7. http://lkml.org/lkml/2006/7/26/237 (OLS BoF on Resource Management (NOTES))
