Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270049AbUJHP5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270049AbUJHP5O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270055AbUJHP4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:56:35 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:12262 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270053AbUJHPwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:52:11 -0400
Message-ID: <4166B75A.1020002@watson.ibm.com>
Date: Fri, 08 Oct 2004 11:50:50 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Erich Focht <efocht@hpce.nec.com>, lse-tech@lists.sourceforge.net,
       colpatch@us.ibm.com, Paul Jackson <pj@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>,
       simon.derr@bull.net
Subject: Re: [ckrm-tech] Re: [Lse-tech] [RFC PATCH] scheduler: Dynamic sched_domains
References: <1097110266.4907.187.camel@arrakis> <200410081214.20907.efocht@hpce.nec.com> <41666E90.2000208@yahoo.com.au>
In-Reply-To: <41666E90.2000208@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

> Erich Focht wrote:
> 
>> more flexibility in building the sched_domains is badly needed, so
>> your effort towards providing this is the right step. I'm not sure
>> yet whether your big change is really (and already) a simplification,
>> but what you described sounded for me like getting the chance to
>> configure the sched_domains at runtime, dynamically, from user
>> space. I didn't notice any user interface in your patch, or overlooked
>> it. Could you please describe the API you had in mind for that?
>>
> 
> OK, what we have in -mm is already close to what we need to do
> dynamic building. But let's explore the other topic. User interface.
> 
> First of all, I think it may be easiest to allow the user to specify
> which cpus belong to which exclusive domains, and have them otherwise
> built in the shape of the underlying topology. So for example if your
> domains look like this (excuse the crappy ascii art):
> 
> 0 1  2 3  4 5  6 7
> ---  ---  ---  ---  <- domain 0
>  |    |    |    |
>  ------    ------   <- domain 1
>     |        |
>     ----------      <- domain 2 (global)
> 
> And so you want to make a partition with CPUs {0,1,2,4,5}, and {3,6,7}
> for some crazy reason, the new domains would look like this:
> 
> 0 1  2  4 5    3  6 7
> ---  -  ---    -  ---  <- 0
>  |   |   |     |   |
>  -----   -     -   -   <- 1
>    |     |     |   |
>    -------     -----   <- 2 (global, partitioned)
> 
> Agreed? You don't need to get fancier than that, do you?
> 
> Then how to input the partitions... you could have a sysfs entry that
> takes the complete partition info in the form:
> 
> 0,1,2,3 4,5,6 7,8 ...
> 
> Pretty dumb and simple.
> 

Agreed, what we are thinking is that the CKRM API can be used for that.
Each domain is a class build of resources (cpus,mem).
You use the config interface of CKRM to specify which cpu/mem belongs
to the class. The underlying controller verifies it.

For a first approximation, classes that have config constraints 
specified this way will not be allowed to set shares. In sched_domain
terms it would mean that if the sched_domain is not balancable with its
siblings then it forms an exclusive domain. Under the exclusive
class one can continue with the hierarchy that will allow share settings.

So from an API issue this certainly looks feasible, maybe even clean.


