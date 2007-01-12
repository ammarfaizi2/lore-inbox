Return-Path: <linux-kernel-owner+w=401wt.eu-S1161025AbXALHuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbXALHuX (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 02:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbXALHuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 02:50:23 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:48556 "EHLO
	ausmtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161025AbXALHuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 02:50:20 -0500
Message-ID: <45A72AE0.9010209@in.ibm.com>
Date: Fri, 12 Jan 2007 11:59:52 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.8 (X11/20061117)
MIME-Version: 1.0
To: Paul Menage <menage@google.com>
CC: vatsa@in.ibm.com, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, xemul@sw.ru, dev@sw.ru,
       containers@lists.osdl.org, pj@sgi.com, mbligh@google.com,
       winget@google.com, rohitseth@google.com, serue@us.ibm.com,
       devel@openvz.org
Subject: Re: [ckrm-tech] [PATCH 3/6] containers: Add generic multi-subsystem
 API to containers
References: <20061222141442.753211763@menage.corp.google.com> <20061222145216.574346828@menage.corp.google.com> <45A50CA5.6070101@in.ibm.com> <6599ad830701111453t62bec38cl9534263002f48a15@mail.gmail.com>
In-Reply-To: <6599ad830701111453t62bec38cl9534263002f48a15@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> On 1/10/07, Balbir Singh <balbir@in.ibm.com> wrote:
>> Paul Menage wrote:
>>> +/* The set of hierarchies in use. Hierarchy 0 is the "dummy
>>> + * container", reserved for the subsystems that are otherwise
>>> + * unattached - it never has more than a single container, and all
>>> + * tasks are part of that container. */
>>> +
>>> +static struct containerfs_root rootnode[CONFIG_MAX_CONTAINER_HIERARCHIES];
>>> +
>>> +/* dummytop is a shorthand for the dummy hierarchy's top container */
>>> +#define dummytop (&rootnode[0].top_container)
>>> +
>> With these changes, is there a generic way to determine the root container
>> for the hierarchy the subsystem is in? Calls to ->create() pass the dummytop
>> container.
> 
> There are two places that the subsystem create() function is called -
> the first is during the subsystem registration, to create the
> subsystem state for the root container. That one passes in dummytop
> since that is the container that all subsystems start attached to.
> 

Yes, I saw that.

> For clarification, the default (dummy) hierarchy is a placeholder for
> subsystems that aren't bound to a hierarchy. It always contains
> exactly one container (dummytop) and all processes are members of that
> container. It isn't reference-counted, since it can never go away, and
> it can never have any subcontainers.
> 
> When a real subcontainer is created (which must be after a subsystem
> has been bound to a hierarchy via a filesystem mount), the new
> subcontainer is passed in. From there you can follow the top_container
> field in the subcontainer, which leads to the root of the hierarchy.
> 
> Andrew has suggested that I need to document this better :-)
> 

One of things I was trying to do with cpu_acct was to actually calculate
the % load over a defined interval. I have the patch for that ready.
When the interval ticks over (which happens in interrupt context -
account_xxxxx_time()), I want to reset the load of child containers
to 0. To walk the hierarchy, I have no root now since I do not have
any task context. I was wondering if exporting the rootnode or providing
a function to export the rootnode of the mounter hierarchy will make
programming easier.

Something like

struct container *get_root_container(struct container_subsys *ss)
{
	return &rootnode[ss->hierarchy];
}

> Paul
> 


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
