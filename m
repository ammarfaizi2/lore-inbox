Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265204AbUD3SnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265204AbUD3SnS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 14:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUD3SnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 14:43:18 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:64399 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S265204AbUD3SnJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 14:43:09 -0400
Message-ID: <40929E30.9090701@watson.ibm.com>
Date: Fri, 30 Apr 2004 14:42:56 -0400
From: Shailabh <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [RFC] Revised CKRM release
References: <4090BBF1.6080801@watson.ibm.com> <20040430174117.A13372@infradead.org>
In-Reply-To: <20040430174117.A13372@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,


Christoph Hellwig wrote:
>>The basic concepts and motivation of CKRM remain the same as described
>>in the overview at http://ckrm.sf.net. Privileged users can define
>>classes consisting of groups of kernel objects (currently tasks and
>>sockets) and specify shares for these classes. Resource controllers,
>>which are independent of each other, can regulate and monitor the
>>resources consumed by classes e.g the CPU controller will control the
>>CPU time received by a class etc. Optional classification engines,
>>implemented as kernel modules, can assist in the automatic
>>classification of the kernel objects (tasks/sockets currently) into
>>classes.
> 
> 
> I'd still love to see practical problems this thing is solving.  

We'd outlined three scenarios in our OLS'03 presentation
http://ckrm.sourceforge.net/documentation/ckrm-ols03-presentation.pdf

a) application server serving multiple requests from customers of 
varying importance. The app server dynamically spawns processes to 
handle each customers request. We need to group all the processes that 
are currently serving a low-importance "bronze" customer and ensure 
they don't take resources away from the group serving a "gold" customer.
Important criteria: don't assume the processes spawned always serve 
the same customer (or customer type) ie. retain the flexibility for 
them being able to have a "gold" priority for some time and then 
revert to a "bronze" status.
   --> needs processes to be classified into groups and regulated 
based on some app-specific rules which cannot be predicted by the 
kernel in advance.


b)  Desktop user doing a combination of activites with different 
priorities (for him/her), say:
   compiling (lower) + listening to music (higher)
      --> needs music player to be given a higher share of all 
resources (cpu, mem, io) than the compile.
   disk backup (very low) + checking email (higher)
      --> needs io requests for email to be given a higher "share"

c) Multiple User-mode Linux instances running on a box (for virtual 
hosting). Each uml instance, serving a different type of consumer (say 
paying vs. nonpaying) needs a different level of service.
     --> need to define groups of processes which are spawned by the 
same uml instance

Besides, we have

d) department servers: multiple users logging in. Limit each 
user/login to a fixed share of cpu/mem/io.
   --> need to define groups of processes with same uid/gid or sharing 
the same tty....

e) monitor how much load is being seen by a related group of 
applications on a Linux box (perhaps to decide whether they're better 
hosted on another box).
   --> needs to group processes by application group even when the 
command names are arbitrary), should accomodate short-lived apps etc.

f) tcp connection requests for an http server are coming from sites 
with varying importance to the httpd owner. Serve some sites 
preferentially.
  --> needs incoming tcp connections to be accepted at differential 
rates for groups of listening sockets formed using source ip/port.



> It's a few thousand lines of code, not written to linux style guidelines,

Guilty as charged :-(  We will work to fix that until all are happy :-)

> sometimes particularly obsfucated with callbacks all over the place.

Not guilty ! Callbacks all over the place keep the various components 
independent - the resource controllers (which are/will be patches over 
the kernel schedulers), the classification engine module (which 
assists in automatic classification of processes/sockets into groups 
using rules; but is completely optional) and any code for new kinds of 
groupings (other than tasks and sockets) that may be found useful to 
control as a set in future.

This independence is a feature - it allows the controller code that is 
deemed acceptable to the corresponding scheduler maintainer to be 
integrated without being dependent on acceptance of other scheduler 
modifications.

Of course, the core and user interface (rcfs) have to be included, but 
they're not that large (subjective biased opinion of course, but 
seriously, if there are suggestions on how we can make it even leaner, 
we're open to ideas).



> I'd hate to see this in the kernel unless there's a very strong need
> for it and no way to solve it at a nicer layer of abstraction, e.g.
> userland virtual machines ala uml/umlinux.
>

Trying to achieve the same goals using abstractions built on top of 
process-centric rlimits  will not work for examples like a) or e).

Also, if we want to regulate resource consumption by groups of sockets 
or other types of kernel objects, the wheel would need to be reinvented.

We believe that CKRM addresses both of the above concerns.






> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

