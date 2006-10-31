Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423592AbWJaRH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423592AbWJaRH6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423687AbWJaRH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:07:57 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:958 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1423592AbWJaRH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:07:57 -0500
Message-ID: <454782D2.3040208@in.ibm.com>
Date: Tue, 31 Oct 2006 22:37:30 +0530
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
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com>	<6599ad830610300304l58e235f7td54ef8744e462a55@mail.gmail.com>	<4545FDCD.3080107@in.ibm.com> <6599ad830610301014l1bf78ce8q998229483d055a90@mail.gmail.com>
In-Reply-To: <6599ad830610301014l1bf78ce8q998229483d055a90@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> On 10/30/06, Balbir Singh <balbir@in.ibm.com> wrote:
>> You'll also end up with per zone page cache pools for each zone. A list of
>> active/inactive pages per zone (which will split up the global LRU list).
> 
> Yes, these are some of the inefficiencies that we're ironing out.
> 
>> What about the hard-partitioning. If a container/cpuset is not using its full
>> 64MB of a fake node, can some other node use it?
> 
> No. So the granularity at which you can divide up the system depends
> on how big your fake nodes are. For our purposes, we figure that 64MB
> granularity should be fine.
> 

I am still a little concerned about how limit size changes will be implemented.
Will the cpuset "mems" field change to reflect the changed limits?

>> Also, won't you end up
>> with a big zonelist?
> 
> Yes - but PaulJ's recent patch to speed up the zone selection helped
> reduce the overhead of this a lot.

Great! let me find those patches

> 
>> Consider the other side of the story. lets say we have a shared lib shared
>> among quite a few containers. We limit the usage of the inode containing
>> the shared library to 50M. Tasks A and B use some part of the library
>> and cause the container "C" to reach the limit. Container C is charged
>> for all usage of the shared library. Now no other task, irrespective of which
>> container it belongs to, can touch any new pages of the shared library.
> 
> Well, if the pages aren't mlocked then presumably some of the existing
> pages can be flushed out to disk and replaced with other pages.
> 
>> What you are suggesting is to virtually group the inodes by container rather
>> than task. It might make sense in some cases, but not all.
> 
> Right - I think it's an important feature to be able to support, but I
> agree that it's not suitable for all situations.

>> We could consider implementing the controllers in phases
>>
>> 1. RSS control (anon + mapped pages)
>> 2. Page Cache control
> 
> Page cache control is actually more essential that RSS control, in our
> experience - it's pretty easy to track RSS values from userspace, and
> react reasonably quickly to kill things that go over their limit, but
> determining page cache usage (i.e. determining which job on the system
> is flooding the page cache with dirty buffers) is pretty much
> impossible currently.
> 

Hmm... interesting. Why do you think its impossible, what are the kinds of
issues you've run into?


> Paul
> 

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
