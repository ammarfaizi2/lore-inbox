Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWH1LEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWH1LEU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 07:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWH1LEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 07:04:20 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:24995 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964808AbWH1LES
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 07:04:18 -0400
Date: Mon, 28 Aug 2006 16:33:30 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Balbir Singh <balbir@in.ibm.com>, sekharan@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: Re: [PATCH 1/7] CPU controller V1 - split runqueue
Message-ID: <20060828110330.GA30090@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060820174015.GA13917@in.ibm.com> <20060820174147.GB13917@in.ibm.com> <44EEEF28.4080707@sw.ru> <20060828033331.GA25119@in.ibm.com> <44F2A62C.9090609@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F2A62C.9090609@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 12:15:40PM +0400, Kirill Korotaev wrote:
> >How do you see the relation between load-balance done thr sched-domain
> >heirarchy today and what will be done thr' virtal runqueues? 
> sorry, can't get your question.

Currently, sched-domain heirarchies exist to facilitate load-balance at
different levels (SMT, MC, CPU and finally Node). They have been so
setup to do frequent load-balance across groups at lower levels (like 
SMT/CPU) than across groups across higher levels (ex: node).
Also the domain defines what physical cpus you can actually balance 
across (which can be modified by something like exclusive cpusets).
And some domains support balance-on-exec/fork while others needn't
support it.

The scheduler currently also relies on the load-balance done thr' this
mechanism to keep each physical CPU busy with work. When CPUs are left
idle because of this mechanism, it may be on purpose (for example the
recent HT/MC optimizations, where we strive to keep each package busy
rather than each CPU - achieved thr' i think active_load_balance).

My question was: when you wanted to exploit the physical vs virtual
runqueue separation on each CPU for load-balance purpose, how would that
play with the above mentioned sched-domain based load-balance mechanisms?
For example: we need to preserve the HT/MC optimizations handled in 
sched-domains code currently.

> When I talked with Nick Piggin on summit he was quite optimistic
> with such an approach. And again, this invasiveness is very simple
> so I do not forsee much objections.

Ingo/Nick, what do you think? If we decide that is a usefull thing to
try, I can see how these mechanisms will be usefull for general SMP
systems too (w/o depending on resource management).

> >I will however let the maintainers 
> >decide on that. Sending some patches also probably will help measure this 
> >"invasiveness/acceptability".
> I propose to work on this together helping each other.
> This makes part of your patches simlper and ours as well.
> And what is good allows different approaches with different properties to 
> be used.

Are you advocating that we should be able to switch between
approaches at run-time? Linux (for some good reasons perhaps) has avoided
going that route so far (ex: pluggable schedulers).

-- 
Regards,
vatsa
