Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbUBZTYY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbUBZTYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:24:23 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:5805 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262930AbUBZTYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:24:05 -0500
Message-ID: <403E47C4.4080104@watson.ibm.com>
Date: Thu, 26 Feb 2004 14:23:48 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030829 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Peter Williams <peterw@aurema.com>, Timothy Miller <miller@techsource.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.GSO.4.03.10402260834530.27582-100000@swag.sw.oz.au> <403D3E47.4080501@techsource.com> <403D576A.6030900@aurema.com> <403D5D32.4010007@matchmail.com> <403D71AB.9060609@aurema.com> <403D73B4.4060600@matchmail.com>
In-Reply-To: <403D73B4.4060600@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> Peter Williams wrote:
> 
>> Mike Fedyk wrote:
>>
>>> Peter Williams wrote:
>>>
>>>> 2. have a user space daemon poll running tasks periodically and 
>>>> renice them if they are running specified binaries
>>>>
>>>> Both of these solutions have their advantages and disadvantages, are 
>>>> (obviously) complicated than I've made them sound and would require 
>>>> a great deal of care to be taken during their implementation.  
>>>> However, I think that they are both doable.  My personal preference 
>>>> would be for the in kernel solution on the grounds of efficiency.

The CKRM project (http://ckrm.sf.net) took the kernel approach too, for the 
same reason you mentioned - efficiency.

Having a userspace daemon poll and readjust priorities/entitlements is 
possible but it will not be able to react as quickly when entitlements 
change and will incur overheads for unnecessary polls when they don't.

In CKRM, the corresponding problem being solved is what should be done when 
a task moves from one "class" to another with a potentially different 
entitlement (we call them guarantees and limits). Since class changes can 
happen relatively often (compared to changes to entitlements for ebs), it 
was even more imperative to be efficient.


>>>
>>>
>>>
>>>
>>> Better would be to have the kernel tell the daemon whenever a process 
>>> in exec-ed, and you have simplicity in the kernel, and policy in user 
>>> space.


As it turns out, one can still use a fairly simple in-kernel module which 
provides a *mechanism* for effectively changing a process' entitlement 
while retaining the policy component in userland.

CKRM has a rule-based classification engine that allows simple rules to be 
defined by the user/sysadmin and evaluated by the kernel at various kernel 
events. Using this, its not only possible to catch exec's but 
setuids/setgids etc. (which are also legitimate points at which a sysadmin 
may want a task's entitlement changed). The RBCE we wrote was fairly 
efficient though we didn't do specific measurements of the overhead as the 
interfaces started changing.


>>
>>
>> Yes.  That would be a good solution.  Does a mechanism that allows the 
>> kernel to notify specific programs about specific events like this exist?
> 

I guess there are two subparts to this question:

a) Are there efficient kernel-user communication mechanisms which could be 
used to do such event notifications ? Yes, netlink is one, relayfs 
(http://www.opersys.com/relayfs)  is another.
b) Are the hooks in place at the right points ? Except for the LSM 
security* calls, no.

Which leaves you with two options - put your own hooks into do_execve, 
either custom or using some general hook interface like KHI 
(http://www-124.ibm.com/linux/projects/kernelhooks/)
OR
find a way to stack your function with LSM's calls.

CKRM is looking at both these options since we need hooks in several places 
(fork, exec, setuid, setgid....)


> I'm sure DaveM would suggest Netlink, but there are probably several 
> implementations for Linux.
> 
> I'll let other more knowledgeable people fill in the list.

Disclaimer : no claim to be knowledgeable....:-)
Just sharing some of our experiences going over similar problems in a 
slightly broader context i.e. class-based resource management.

-- Shailabh





