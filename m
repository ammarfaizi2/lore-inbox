Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVFFBo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVFFBo1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 21:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVFFBo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 21:44:27 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:63363 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261159AbVFFBoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 21:44:18 -0400
Message-ID: <42A3AA63.7060201@yahoo.com.au>
Date: Mon, 06 Jun 2005 11:44:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "M.Baris Demiray" <baris@labristeknoloji.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.12-rc5-mm2] [sched] add allowed CPUs check into find_idlest_group()
References: <42A3381F.90801@labristeknoloji.com>
In-Reply-To: <42A3381F.90801@labristeknoloji.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M.Baris Demiray wrote:
> 
> Hello,
> following patch adds check for allowed CPUs into
> sched.c:find_idlest_group() -as told in comment line that had
> removed-. But, I have several questions about that comment.
> 
> Firstly, I've understood it as "Check whether process p is allowed to
> run on each CPU of to-be-found idlest group"; is that right?
> 

Close.

Probably it would be better to take the intersection of
(group->cpumask, p->cpus_allowed), and skip the group if
the intersection is empty.

In addition to that, do a patch for find_idlest_cpu that
skips cpus that aren't allowed. You needn't do the cpumask
check each time round the loop, again just take the
intersection of the group->cpumask and p->cpus_allowed, and
loop over that.

Wanna do a patch for that?


> If so, isn't it more appropriate to do check in find_idlest_cpu()?
> Because, we're only interested in CPUs that are in idlest group
> but doing a check in find_idlest_group() also checks for CPUs
> that are not in idlest group (since we're traversing all the groups
> in given domain). Checking this after finding the idlest group
> (in find_idlest_cpu() with ordinary call order as in
> sched_balance_self()) will save us from extra overhead.
> 
> Although I've questions in my mind, I'm sending a patch following
> that comment. Any explanation and comment on patch will be
> appreciated.
> 

I don't think it does anything ;)

> Regards.
> 
> Signed-off-by: M.Baris Demiray <baris@labristeknoloji.com>
> 
> --- linux-2.6.12-rc5-mm2/kernel/sched.c.orig    2005-06-05 
> 12:31:04.000000000 +0000
> +++ linux-2.6.12-rc5-mm2/kernel/sched.c    2005-06-05 16:49:49.000000000 
> +0000
> @@ -1040,7 +1040,12 @@
>          int i;
> 
>          local_group = cpu_isset(this_cpu, group->cpumask);
> -        /* XXX: put a cpus allowed check */
> +
> +        /* Check whether all CPUs in the group is allowed to run on */
> +        for_each_cpu_mask(i, group->cpumask) {
> +            if (!cpu_isset(i, p->cpus_allowed))
> +                continue;
> +        }
> 
>          /* Tally up the load of all CPUs in the group */
>          avg_load = 0;
> 
> 


-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
