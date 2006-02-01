Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161035AbWBANJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbWBANJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWBANJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:09:56 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:32227 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964955AbWBANJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:09:55 -0500
Date: Wed, 1 Feb 2006 14:08:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
Message-ID: <20060201130818.GA26481@elte.hu>
References: <1138736609.7088.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138736609.7088.35.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

[pls. use -p when generating patches]

> @@ -1983,6 +1983,10 @@
>  
>  	curr = curr->prev;
>  
> +	/* bail if someone else woke up */
> +	if (need_resched())
> +		goto out;
> +
>  	if (!can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
>  		if (curr != head)
>  			goto skip_queue;

even putting the problems of this approach aside (is it right to abort 
the act of load-balancing - which is a periodic activity that wont be 
restarted after this - so we lose real work), i think this will not 
solve the latency. Imagine a hardirq hitting the CPU that is executing 
move_tasks() above. We might not service that hardirq for up to 1.5 
msecs ...

i think the right approach would be to split up this work into smaller 
chunks. Or rather, lets first see how this can happen: why is 
can_migrate() false for so many tasks? Are they all cpu-hot? If yes, 
shouldnt we simply skip only up to a limit of tasks in this case - it's 
not like we want to spend 1.5 msecs searching for a cache-cold task 
which might give us a 50 usecs advantage over cache-hot tasks ...

	Ingo
