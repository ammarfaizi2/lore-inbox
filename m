Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWH1DeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWH1DeK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 23:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWH1DeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 23:34:10 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:21194 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932381AbWH1DeH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 23:34:07 -0400
Date: Mon, 28 Aug 2006 09:03:32 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Balbir Singh <balbir@in.ibm.com>, sekharan@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: Re: [PATCH 1/7] CPU controller V1 - split runqueue
Message-ID: <20060828033331.GA25119@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060820174015.GA13917@in.ibm.com> <20060820174147.GB13917@in.ibm.com> <44EEEF28.4080707@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EEEF28.4080707@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 04:38:00PM +0400, Kirill Korotaev wrote:
> Srivatsa,
> 
> I suggest to split existing runqueue structure
> into 2 pieces: physical cpu (sd, ...) and
> virtual cpu (essentially a runqueue - array, nr_running, loac etc.)
> 
> Then replace all references to cpu as int with vcpu_t pointer.

That's going to be a massive change! If I understand you correctly,
things like get_cpu() return virtual CPU number rather than the
corresponding "physical" CPU (the later is anyway a misnomer on
virtualized platforms)? Also we have get_cpu() now reading some structure and be
able to tell which CPU a task is running. Now with virtual CPUs, another
level of translation is needed? Wonder what the performance impact of
that would be ..

> What advantages does it give?
> 1. it isolates Linux std scheduler code for scheduling
>   tasks inside runqueues, while adds possibility
>   to add cleanly more high-level scheduler, which can select
>   runqueues to run (lets call it "process groups scheduler" - PGS).
> 2. runqueues can run on arbitrary physical CPUs if needed
>   which helps to solve balancing problem on SMP.

How do you see the relation between load-balance done thr sched-domain
heirarchy today and what will be done thr' virtal runqueues? 

> 3. it allows naturally to use different PGS algorithms
>   on top of Linux one. e.g. yours algorithm (probobalistic) or
>   fair scheduling algorithms like SFQ, EEVDF, BVT with more 
>   predictable parameters of QoS.
> 4. it will help us to get to the consensus and commit this work
>   into mainstream, because different PGS with different properties
>   will be possible.
> 
> Part of this idea is implemented in OpenVZ scheduler and in some
> regards looks very much like your work, so I think if you like the idea
> we can eloborate.
> 
> What do you think?

I believe hypervisors like Xen have a similar approach (virtualing CPU
resource and running a virtual CPU on any available physical CPU). The 
worry I have applying this to Linux kernel scheduler is in terms of its 
invasiveness and thus general acceptability. I will however let the maintainers 
decide on that. Sending some patches also probably will help measure this 
"invasiveness/acceptability".

I had another question related to real-time tasks. How do you control
CPU usage of real-time tasks in different containers (especially if they
are SCHED_FIFO types)? Do they get capped at the bandwidth provided to
the container?

Also do you take any special steps to retain interactivity?

-- 
Regards,
vatsa
