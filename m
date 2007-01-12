Return-Path: <linux-kernel-owner+w=401wt.eu-S1161026AbXALHuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbXALHuF (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 02:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbXALHuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 02:50:05 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:42790 "EHLO
	ausmtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161027AbXALHuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 02:50:02 -0500
Message-ID: <45A729A9.5070902@in.ibm.com>
Date: Fri, 12 Jan 2007 11:54:41 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.8 (X11/20061117)
MIME-Version: 1.0
To: Paul Menage <menage@google.com>
CC: akpm@osdl.org, pj@sgi.com, sekharan@us.ibm.com, dev@sw.ru, xemul@sw.ru,
       serue@us.ibm.com, vatsa@in.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, mbligh@google.com,
       winget@google.com, containers@lists.osdl.org, devel@openvz.org
Subject: Re: [ckrm-tech] [PATCH 4/6] containers: Simple CPU accounting container
 subsystem
References: <20061222141442.753211763@menage.corp.google.com> <20061222145216.755437205@menage.corp.google.com> <45A4F675.3080503@in.ibm.com> <6599ad830701111633j2ae65807sad393d2dad44a260@mail.gmail.com>
In-Reply-To: <6599ad830701111633j2ae65807sad393d2dad44a260@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> On 1/10/07, Balbir Singh <balbir@in.ibm.com> wrote:
>> I have run into a problem running this patch on a powerpc box. Basically,
>> the machine panics as soon as I mount the container filesystem with
> 
> This is a multi-processor system?

Yes, it has 4 cpus

> 
> My guess is that it's a race in the subsystem API that I've been
> meaning to deal with for some time - basically I've been using
> (<foo>_subsys.subsys_id != -1) to indicate that <foo> is ready for
> use, but there's a brief window during subsystem registration where
> that's not actually true.
>
> I'll add an "active" field in the container_subsys structure, which
> isn't set until registration is completed, and subsystems should use
> that instead. container_register_subsys() will set it just prior to
> releasing callback_mutex, and cpu_acct.c (and other subsystems) will
> check <foo>_subsys.active rather than (<foo>_subsys.subsys_id != -1)
> 

I tried something similar, I added an activated field, which is set
to true when the ->create() callback is invoked. That did not help
either, the machine still panic'ed.

>> I am trying to figure out the reason for the panic and trying to find
>> a fix. Since the introduction of whole hierarchy system, the debugging
>> has gotten a bit harder and taking longer, hence I was wondering if you
>> had any clues about the problem
>>
> 
> Yes, the multi-hierarchy support does make the whole code a little
> more complex - but people presented reasonable scenarios where a
> single container tree for all resource controllers just wasn't
> flexible enough.
> 

I see the need for it, but I wonder if we should start with that
right away. I understand that people might want to group cpusets
differently from their grouping of let's say the cpu resource
manager. I would still prefer to start with one hierarchy and then
move to multiple hierarchies. I am concerned that adding complexity
upfront might turn off people from using the infrastructure.

> Paul


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
