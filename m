Return-Path: <linux-kernel-owner+w=401wt.eu-S1752869AbWLSHUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbWLSHUd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 02:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbWLSHUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 02:20:32 -0500
Received: from poczta.o2.pl ([193.17.41.142]:36601 "EHLO poczta.o2.pl"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752869AbWLSHUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 02:20:32 -0500
Date: Tue, 19 Dec 2006 08:21:34 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] lockdep: more unlock-on-error fixes
Message-ID: <20061219072134.GA1731@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20061218115632.GA5373@ff.dom.local> <20061218143936.GA4415@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061218143936.GA4415@elte.hu>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 03:39:36PM +0100, Ingo Molnar wrote:
> 
> * Jarek Poplawski <jarkao2@o2.pl> wrote:
> 
> > Hello,
> > 
> > If any of this proposals should be omitted or separated let me know.
> 
> thanks for the fixes, they look good to me. I have reorganized the 
> __lock_acquire() changes a bit. Plus i dropped the check_locks_freed() 
> changes: there's no reason lockdep should be using 'raw' irq flags 
> saving - these functions are not part of the irq-flags tracing code so 
> they dont /need/ to be raw.

I'm not 100% convinced - now trace_hardirqs_off/on is 
done only for lockdep reasons, so it is like selfcheck.
But it's probably the matter of taste.

...
> Index: linux/kernel/lockdep.c
> ===================================================================
> --- linux.orig/kernel/lockdep.c
> +++ linux/kernel/lockdep.c
...
> @@ -2210,19 +2214,24 @@ out_calc_hash:
>  		if (!chain_head && ret != 2)
>  			if (!check_prevs_add(curr, hlock))
>  				return 0;
> -		graph_unlock();
> -	}
> +	} else
> +		/* after lookup_chain_cache(): */
> +		if (unlikely(!debug_locks))
> +			return 0;
> +
>  	curr->lockdep_depth++;
>  	check_chain_key(curr);
>  	if (unlikely(curr->lockdep_depth >= MAX_LOCK_DEPTH)) {
> -		debug_locks_off();
> +		debug_locks_off_graph_unlock();
>  		printk("BUG: MAX_LOCK_DEPTH too low!\n");
>  		printk("turning off the locking correctness validator.\n");
>  		return 0;
>  	}
> +
>  	if (unlikely(curr->lockdep_depth > max_lockdep_depth))
>  		max_lockdep_depth = curr->lockdep_depth;
>  
> +	graph_unlock();
>  	return 1;
>  }

Sorry but it's not good... There could be no lock 
at all here (eg. trylock != 0 || check != 2). 

Jarek P.
