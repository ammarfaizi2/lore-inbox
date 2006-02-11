Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWBKALA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWBKALA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 19:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWBKALA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 19:11:00 -0500
Received: from proof.pobox.com ([207.106.133.28]:47580 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S932261AbWBKALA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 19:11:00 -0500
Date: Fri, 10 Feb 2006 18:10:45 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, ak@muc.de, ashok.raj@intel.com,
       riel@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       mingo@elte.hu, 76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com, pj@sgi.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-ID: <20060211001045.GP18730@localhost.localdomain>
References: <20060209160808.GL18730@localhost.localdomain> <20060209090321.A9380@unix-os.sc.intel.com> <20060209100429.03f0b1c3.akpm@osdl.org> <200602101102.25437.ak@muc.de> <20060210024222.67db06f3.akpm@osdl.org> <43EC7473.20109@cosmosbay.com> <20060210032332.13ed3b67.akpm@osdl.org> <43EC9F89.7090809@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EC9F89.7090809@cosmosbay.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
>
> [PATCH] HOTPLUG_CPU : avoid hitting too many cachelines in recalc_bh_state()
> 
> Instead of using for_each_cpu(i), we can use for_each_online_cpu(i) : The 
> difference matters if HOTPUG_CPU=y
> 
> When a CPU goes offline (ie removed from online map), it might have a non 
> null bh_accounting.nr, so this patch adds a transfert of this counter to an 
> online CPU counter.
> 
> We already have a hotcpu_notifier, (function buffer_cpu_notify()), where we 
> can do this bh_accounting.nr transfert.
> 
> Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

> --- a/fs/buffer.c	2006-02-10 15:08:21.000000000 +0100
> +++ b/fs/buffer.c	2006-02-10 15:47:55.000000000 +0100
> @@ -3138,7 +3138,7 @@
>  	if (__get_cpu_var(bh_accounting).ratelimit++ < 4096)
>  		return;
>  	__get_cpu_var(bh_accounting).ratelimit = 0;
> -	for_each_cpu(i)
> +	for_each_online_cpu(i)
>  		tot += per_cpu(bh_accounting, i).nr;
>  	buffer_heads_over_limit = (tot > max_buffer_heads);
>  }
> @@ -3187,6 +3187,9 @@
>  		brelse(b->bhs[i]);
>  		b->bhs[i] = NULL;
>  	}
> +	get_cpu_var(bh_accounting).nr += per_cpu(bh_accounting, cpu).nr ;
> +	per_cpu(bh_accounting, cpu).nr = 0;
> +	put_cpu_var(bh_accounting);
>  }

But now there is a window between the time the cpu is marked offline
and the time its bh_accounting.nr is moved to another cpu.  So
recalc_bh_state could fail to set buffer_heads_over_limit when it
should.

Maybe it's not worth worrying about?  I don't really know this code,
just thought I would point it out.
