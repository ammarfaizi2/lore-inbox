Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWIKTsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWIKTsI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWIKTsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:48:07 -0400
Received: from [62.205.161.221] ([62.205.161.221]:5510 "EHLO kir.sacred.ru")
	by vger.kernel.org with ESMTP id S1751342AbWIKTsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:48:05 -0400
Message-ID: <4505BD89.8040400@openvz.org>
Date: Mon, 11 Sep 2006 23:48:25 +0400
From: Kir Kolyshkin <kir@openvz.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060905)
MIME-Version: 1.0
To: rohitseth@google.com, devel@openvz.org
CC: sekharan@us.ibm.com, Rik van Riel <riel@redhat.com>,
       Srivatsa <vatsa@in.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Devel] Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4)
 (added user	memory)
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>	<44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>	<1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>	<1157743424.19884.65.camel@linuxchandra>	<1157751834.1214.112.camel@galaxy.corp.google.com>	<1157999107.6029.7.camel@linuxchandra> <1158001831.12947.16.camel@galaxy.corp.google.com>
In-Reply-To: <1158001831.12947.16.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0.2 (kir.sacred.ru [62.205.161.221]); Mon, 11 Sep 2006 23:46:31 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:
> On Mon, 2006-09-11 at 11:25 -0700, Chandra Seetharaman wrote:
>   
>> On Fri, 2006-09-08 at 14:43 -0700, Rohit Seth wrote:
>> <snip>
>>
>>     
>>>>> Guarantee may be one of
>>>>>
>>>>>   1. container will be able to touch that number of pages
>>>>>   2. container will be able to sys_mmap() that number of pages
>>>>>   3. container will not be killed unless it touches that number of pages
>>>>>   4. anything else
>>>>>           
>>>> I would say (1) with slight modification
>>>>    "container will be able to touch _at least_ that number of pages"
>>>>
>>>>         
>>> Does this scheme support running of tasks outside of containers on the
>>> same platform where you have tasks running inside containers.  If so
>>> then how will you ensure processes running out side any container will
>>> not leave less than the total guaranteed memory to different containers.
>>>
>>>       
>> There could be a default container which doesn't have any guarantee or
>> limit. 
>>     
>
> First, I think it is critical that we allow processes to run outside of
> any container (unless we know for sure that the penalty of running a
> process inside a container is very very minimal).
>   
(1) there is a set of processes running outside of any container. In
OpenVZ we call that "VE0" or "host system", probably Chandra meant that
by "default container".
(2) The host system is used to manage the containers (start/stop/set
parameters/create/destroy).
(3) the penalty of running a process inside a container is indeed very low.

> And anything running outside a container should be limited by default
> Linux settings.
>   
(4) due to (2), it is not recommended to run anything but the tasks used
to manage the containers -- otherwise your gonna have security problems
(5) "Default Linux settings" do not cover everything (for example --
dentry cache), thus the need for beancounters.
>> When you create containers and assign guarantees to each of them
>> make sure that you leave some amount of resource unassigned. 
>>     
>                            ^^^^^ This will force the "default" container
> with limits (indirectly). IMO, the whole guarantee feature gets defeated
> the moment you bring in this fuzziness.
>
>   
>> That
>> unassigned resources can be used by the default container or can be used
>> by containers that want more than their guarantee (and less than their
>> limit). This is how CKRM/RG handles this issue.
>>
>>  
>>     
>
> It seems that a single notion of limit should suffice, and that limit
> should more be treated as something beyond which that resource
> consumption in the container will be throttled/not_allowed.
>   
Beancounters have a notion of "barrier" and "limit". For some parameters
they are the same, but for some parameters they differ -- and there is
some "safety gap" between the barrier and the limit. The problem is for
some types of resources you can not throttle or deny -- the only way is
to kill the process. The one (but not the only one) example is process
stack expansion. See more at http://wiki.openvz.org/UBC (and follow the
menu at the right side).
