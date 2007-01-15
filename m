Return-Path: <linux-kernel-owner+w=401wt.eu-S932157AbXAOJwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbXAOJwG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 04:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbXAOJwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 04:52:06 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:46426 "EHLO
	ausmtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932157AbXAOJwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 04:52:03 -0500
Message-ID: <45AB4EA0.3030704@in.ibm.com>
Date: Mon, 15 Jan 2007 15:21:28 +0530
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
Subject: Re: [ckrm-tech] [PATCH 1/1] Fix a panic while mouting containers
 on powerpc and some other small cleanups (Re: [PATCH 4/6] containers: Simple
 CPU accounting container subsystem)
References: <20061222141442.753211763@menage.corp.google.com> <20061222145216.755437205@menage.corp.google.com> <45A4F675.3080503@in.ibm.com> <6599ad830701111633j2ae65807sad393d2dad44a260@mail.gmail.com> <45AB42E6.4020507@in.ibm.com> <45AB43B5.3070007@in.ibm.com> <6599ad830701150122g7156a599t1b3dd3af9f5f821b@mail.gmail.com>
In-Reply-To: <6599ad830701150122g7156a599t1b3dd3af9f5f821b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> On 1/15/07, Balbir Singh <balbir@in.ibm.com> wrote:
>> In sched.c, account_user_time() can be called with the task p set to rq->idle.
>> Since idle tasks do not belong to any container, this was causing a panic in
>> task_ca() in cpu_acct.c.
> 
> How come that didn't cause a problem on x86_64? If this is an
> inconsistency between architectures then perhaps it ought to be
> cleaned up.
> 

That is because account_system/user_time() is also called from
account_process_vtime() which is called from __switch_to in
power pc. vtime is for virtual time accounting. Enabled by
CONFIG_VIRT_CPU_ACCOUNTING.

> Additionally, I think that we should make the idle tasks members of
> the root container(s), to remove this special case. (I'm a bit
> surprised that they're not already - I thought that the early
> container initialization was early enough that the idle tasks hadn't
> yet been forked. Is that different on PowerPC?
> 

idle threads are associated only with the runqueue and not visible
by the do_each_thread()/while_each_thread() loop. They are not added
to the tasklist (please see init_idle() in kernel/sched.c).

>> Multiplying the time by 1000 is not correct in cpuusage_read(). The code
>> has been converted to use the correct cputime API.
> 
> Thanks.
> 
>> Add mount/umount callbacks.
> 
> I'm not sure I like the mount/unmount callbacks. What exactly are you
> trying to gain from them? My intention was that the
> 
> cont->subsys[i]->container = cont;
> 
> line in container_get_sb() was doing essentially this - i.e. the
> container_subsys_state for the root container in a subsystem is
> already kept up to date by the container system, and the subsystem can
> rely on the "container" field in the container_subsys_state.
> 


While writing/extending the cpuacct container, I found it useful to
know if the container resource group we are controlling is really mounted.
Controllers can try and avoid doing work when not mounted and start
when the subsystem is mounted. Also, without these callbacks, one has no
definite way of checking if the top_container is dummy or for real.

> Thanks,
> 
> Paul

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
