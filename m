Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWA0JqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWA0JqQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 04:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWA0JqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 04:46:16 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:44238 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932446AbWA0JqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 04:46:16 -0500
Date: Fri, 27 Jan 2006 10:46:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RT] possible bug in trace_start_sched_wakeup
Message-ID: <20060127094656.GA24878@elte.hu>
References: <1138327022.7814.8.camel@localhost.localdomain> <1138336718.7814.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138336718.7814.41.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

>  	spin_lock(&sch.trace_lock);
> -	if (sch.task && (sch.task->prio >= p->prio))
> +	if (sch.task && ((sch.task->prio <= p->prio) || !rt_task(p)))
>  		goto out_unlock;

good catch - but i'd not do the !rt_task(p) condition, because e.g. PI 
related priority boosting works _without_ changing p->policy. So it is 
p->prio that controls. I.e. a simple "sch.task->prio <= p->prio" should 
be enough.

	Ingo
