Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269738AbUJHKlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269738AbUJHKlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 06:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269760AbUJHKlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 06:41:12 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:45196 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269738AbUJHKlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 06:41:07 -0400
Message-ID: <41666E90.2000208@yahoo.com.au>
Date: Fri, 08 Oct 2004 20:40:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Erich Focht <efocht@hpce.nec.com>
CC: lse-tech@lists.sourceforge.net, colpatch@us.ibm.com,
       Paul Jackson <pj@sgi.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>, simon.derr@bull.net,
       frankeh@watson.ibm.com
Subject: Re: [Lse-tech] [RFC PATCH] scheduler: Dynamic sched_domains
References: <1097110266.4907.187.camel@arrakis> <200410081214.20907.efocht@hpce.nec.com>
In-Reply-To: <200410081214.20907.efocht@hpce.nec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich Focht wrote:

> more flexibility in building the sched_domains is badly needed, so
> your effort towards providing this is the right step. I'm not sure
> yet whether your big change is really (and already) a simplification,
> but what you described sounded for me like getting the chance to
> configure the sched_domains at runtime, dynamically, from user
> space. I didn't notice any user interface in your patch, or overlooked
> it. Could you please describe the API you had in mind for that?
> 

OK, what we have in -mm is already close to what we need to do
dynamic building. But let's explore the other topic. User interface.

First of all, I think it may be easiest to allow the user to specify
which cpus belong to which exclusive domains, and have them otherwise
built in the shape of the underlying topology. So for example if your
domains look like this (excuse the crappy ascii art):

0 1  2 3  4 5  6 7
---  ---  ---  ---  <- domain 0
  |    |    |    |
  ------    ------   <- domain 1
     |        |
     ----------      <- domain 2 (global)

And so you want to make a partition with CPUs {0,1,2,4,5}, and {3,6,7}
for some crazy reason, the new domains would look like this:

0 1  2  4 5    3  6 7
---  -  ---    -  ---  <- 0
  |   |   |     |   |
  -----   -     -   -   <- 1
    |     |     |   |
    -------     -----   <- 2 (global, partitioned)

Agreed? You don't need to get fancier than that, do you?

Then how to input the partitions... you could have a sysfs entry that
takes the complete partition info in the form:

0,1,2,3 4,5,6 7,8 ...

Pretty dumb and simple.
