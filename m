Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424767AbWLHGUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424767AbWLHGUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 01:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424771AbWLHGUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 01:20:30 -0500
Received: from poczta.o2.pl ([193.17.41.142]:45131 "EHLO poczta.o2.pl"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1424767AbWLHGU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 01:20:29 -0500
Date: Fri, 8 Dec 2006 07:27:26 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] lockdep: fix possible races while disabling lock-debugging
Message-ID: <20061208062725.GA1012@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20061207132903.GA341@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207132903.GA341@elte.hu>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 02:29:03PM +0100, Ingo Molnar wrote:
> Subject: [patch] lockdep: fix possible races while disabling lock-debugging
> From: Ingo Molnar <mingo@elte.hu>
...
> (also note that as we all know the Linux kernel is, by definition, 
> bug-free and perfect, so this code never triggers, so these fixes are 
> highly theoretical. I wrote this patch for aesthetic reasons alone.)

Now it's too sexy! I can't work.

PS: I had some problems with patching - probably
because of something from -mm, but:

> Signed-off-by: Ingo Molnar <mingo@elte.hu>
...
> @@ -567,12 +601,10 @@ static noinline int print_circular_bug_t
>  	if (debug_locks_silent)
>  		return 0;
>  
> -	/* hash_lock unlocked by the header */
> -	__raw_spin_lock(&hash_lock);
>  	this.class = check_source->class;
>  	if (!save_trace(&this.trace))
>  		return 0;
> -	__raw_spin_unlock(&hash_lock);
> +

IMHO lock is needed here for save_trace.

...
> @@ -1212,7 +1244,8 @@ register_lock_class(struct lockdep_map *
>  	hash_head = classhashentry(key);
>  
>  	raw_local_irq_save(flags);
> -	__raw_spin_lock(&hash_lock);
> +	if (!graph_lock())

	! raw_local_irq_restore(flags);

> +		return NULL;
>  	/*
>  	 * We have to do the hash-walk again, to avoid races
>  	 * with another CPU:

Jarek P.
