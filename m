Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932735AbWCRBNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbWCRBNZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 20:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbWCRBNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 20:13:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30630 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932735AbWCRBNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 20:13:24 -0500
Date: Fri, 17 Mar 2006 17:15:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jack Steiner <steiner@sgi.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Reduce overhead of calc_load
Message-Id: <20060317171538.3826eb41.akpm@osdl.org>
In-Reply-To: <20060317152611.GA4449@sgi.com>
References: <20060317145709.GA4296@sgi.com>
	<20060317145912.GA13207@elte.hu>
	<20060317152611.GA4449@sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Steiner <steiner@sgi.com> wrote:
>
> +unsigned long nr_active(void)
> +{
> +	unsigned long i, running = 0, uninterruptible = 0;
> +
> +	for_each_online_cpu(i) {
> +		running += cpu_rq(i)->nr_running;
> +		uninterruptible += cpu_rq(i)->nr_uninterruptible;
> +	}
> +
> +	if (unlikely((long)uninterruptible < 0))
> +		uninterruptible = 0;
> +
> +	return running + uninterruptible;
> +}

Is that check for (uninterruptible < 0) (copied from nr_uninterruptible)
really needed?  Can rq->nr_uninterruptible actually go negative?

Perhaps nr_context_switches() and nr_iowait() should also go into this
function, then we rename it all to

	struct sched_stuff {
		unsigned nr_uninterruptible;
		unsigned nr_running;
		unsigned nr_active;
		unsigned long nr_context_switches;
	};

	void get_sched_stuff(struct sched_stuff *);

and then convert all those random little counter-upper-callers we have.

And then give get_sched_stuff() a hotplug handler (probably unneeded) and
then scratch our heads over why nr_uninterruptible() iterates across all
possible CPUs while this new nr_active() iterates over all online CPUs like
nr_running() and unlike nr_context_switches().


IOW: this code's an inefficient mess and needs some caring for.
