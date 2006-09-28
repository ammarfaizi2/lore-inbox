Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751758AbWI1IBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbWI1IBp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 04:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWI1IBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 04:01:45 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:16011 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751758AbWI1IBo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 04:01:44 -0400
Message-ID: <451B815D.2010807@in.ibm.com>
Date: Thu, 28 Sep 2006 13:31:33 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: rohitseth@google.com, linux-kernel <linux-kernel@vger.kernel.org>,
       devel@openvz.org, CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
References: <1158718568.29000.44.camel@galaxy.corp.google.com>	<1159386644.4773.80.camel@linuxchandra>	<1159392487.23458.70.camel@galaxy.corp.google.com> <1159395892.4773.107.camel@linuxchandra>
In-Reply-To: <1159395892.4773.107.camel@linuxchandra>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:
> On Wed, 2006-09-27 at 14:28 -0700, Rohit Seth wrote:
> 
> Rohit,
> 
> For 1-4, I understand the rationale. But, your implementation deviates
> from the current behavior of the VM subsystem which could affect the
> ability of these patches getting into mainline.
> 
> IMO, the current behavior in terms of reclamation, LRU, vm_swappiness,
> and writeback logic should be maintained.
> 

<snip>

Hi, Rohit,

I have been playing around with the containers patch. I finally got
around to reading the code.


1. Comments on reclaiming

You could try the following options to overcome some of the disadvantages of the
current scheme.

(a) You could consider a reclaim path based on Dave Hansen's Challenged memory
controller (see http://marc.theaimsgroup.com/?l=linux-mm&m=115566982532345&w=2).

(b) The other option is to do what the resource group memory controller does -
build a per group LRU list of pages (active, inactive) and reclaim
them using the existing code (by passing the correct container pointer,
instead of the zone pointer). One disadvantage of this approach is that
the global reclaim is impacted as the global LRU list is broken. At the
expense of another list, we could maintain two lists, global LRU and
container LRU lists. Depending on the context of the reclaim - (container
over limit, memory pressure) we could update/manipulate both lists.
This approach is definitely very expensive.

2. Comments on task migration support

(a) One of the issues I found while using the container code is that, one could
add a task to a container say "a". "a" gets charged for the tasks usage,
when the same task moves to a different container say "b", when the task
exits, the credit goes to "b" and "a" remains indefinitely charged.

(b) For tasks addition and removal, I think it's probably better to move
the entire process (thread group) rather than allow each individual thread
to move across containers. Having threads belonging to the same process
reside in different containers can be complex to handle, since they
share the same VM. Do you have a scenario where the above condition
would be useful?


-- 

	Warm Regards,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs

PS: Chandra, I hope the details of the resource group memory controller
are correct.
