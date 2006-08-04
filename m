Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161280AbWHDQQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161280AbWHDQQC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 12:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161281AbWHDQQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 12:16:01 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:182 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1161280AbWHDQQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 12:16:00 -0400
Message-ID: <44D372F5.5000901@sw.ru>
Date: Fri, 04 Aug 2006 20:16:53 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com, saw@sawoct.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu
 controller
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org> <20060803224253.49068b98.akpm@osdl.org> <1154684950.23655.178.camel@localhost.localdomain> <20060804114109.GA28988@in.ibm.com>
In-Reply-To: <20060804114109.GA28988@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I think the risk is that OpenVZ has all the controls and resource
>>managers we need, while CKRM is still more research-ish. I find the
>>OpenVZ code much clearer, cleaner and complete at the moment, although
>>also much more conservative in its approach to solving problems.
> 
> 
> I think it would be nice to compare first the features provided by ckrm and 
> openvz at some point and agree upon the minimum common features we need to have 
> as we go forward. For instance I think Openvz assumes that tasks do
> not need to move between containers (task-groups), whereas ckrm provides this
> flexibility for workload management. This may have some effect on the 
> controller/interface design, no?

BTW, to help to compare (as you noted above) here is the list of features provided by OpenVZ:

Memory and some other resources related to mem
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- kernel memory. vmas, LDT, page tables, poll, select, ipc undos and many other kernel
  structures which can be created on user requests.
  without it's accounting/limiting a system is DoS'able.

user memory (private memory, shared memory, tmpfs, swap):
- locked pages
- shmpages
- physpages. accounting only. Correctly accounts fractions of memory
  shared between containers. Can't be limited in a user friendly manner,
  since memory denials from page faults are not handled from user space :/
- private memory pages. These are private pages which has are not backed up
  in the file or swap and which are pure user pages. These are anonymous
  private mappings and cow-able mappings (e.g. glibc .data) which result in private memory.
  Accounted correctly taking into acount sharing between containers (i.e. page
  fraction is accounted).
  This resource is limited on mmap() call.

others:
- 2-level OOM killer. The most fat container should be selected to kill first.
  We introduce some guarantee against OOM, so that if the container
  consumes less memory than it is guaranteed to, then it won't be killed.
- memory pinned by dcache (there is a simple DoS which can be done
  by any Linux user to consume the whole normal zone)
- number of iptables entries (with virtualized networking
  containers can allocate memory for iptable rules)
- other socket buffers (unix, netlinks)
- TCP rcv/snd buffers
- UDP rcv buffers
- number of TCP sockets
- number of unix/netlink/other sockets
- number of flocks
- number of ptys
- number of siginfo's
- number of files
- number of tasks

CPU management
~~~~~~~~~~~~~~
1. 2 level fair CPU scheduler with known theoretical fairness and latency bounds:
- 1st level selects a container to run based on the container weight
- 2nd level selects a runqueue in the container and a task in the runqueue

2. cpu limits. Limitation of the container to some CPU rate even if CPUs are idle.


2 level disk quota
~~~~~~~~~~~~~~~~~~
allows to limit directory subtree to some amount of disk space.
inside this quota std linux per-user quotas are available.

Thanks,
Kirill
