Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWBRJ0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWBRJ0T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 04:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWBRJ0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 04:26:19 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:40077 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751095AbWBRJ0S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 04:26:18 -0500
Date: Sat, 18 Feb 2006 14:55:17 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, dada1@cosmosbay.com
Subject: Re: [PATCH 2/2] fix file counting
Message-ID: <20060218092517.GP29846@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060217154147.GL29846@in.ibm.com> <20060217154337.GM29846@in.ibm.com> <20060217154626.GN29846@in.ibm.com> <20060218010414.1f8d6782.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218010414.1f8d6782.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 01:04:14AM -0800, Andrew Morton wrote:
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> Fair enough.
> 
> What do you think of these changes?
> 
> 
> - Nuke the blank line between "}" and EXPORT_SYMBOL().  That's never seemed
>   pointful to me.

Sounds good.

> 
> - Make the get_max_files export use _GPL - only unix.ko uses it.

Always good. I just didn't want to be the one :)

> - Use `-1' in the arg to percpu_counter_mod() rather than `-1L'.  The
>   compiler will dtrt and we shouldn't be peering inside percpu_counter
>   internals here anyway.
> 
> - Scrub that - use percpu_counter_dec() and percpu_counter_inc().

Gah! I missed those APIs. Makes perfect sense.

> 
> - percpu_counters can be inaccurate on big SMP.  Before we actually fail a
>   get_empty_filp() attempt, use the (new in -mm) expensive
>   percpu_counter_sum() to check whether we're really over the limit.


> -	if (get_nr_files() >= files_stat.max_files &&
> -				!capable(CAP_SYS_ADMIN))
> -		goto over;
> +	if (get_nr_files() >= files_stat.max_files && !capable(CAP_SYS_ADMIN)) {
> +		/*
> +		 * percpu_counters are inaccurate.  Do an expensive check before
> +		 * we go and fail.
> +		 */
> +		if (percpu_counter_sum(&nr_files) >= files_stat.max_files)
> +			goto over;
> +	}

Slight optimization -

	if (get_nr_files() >= files_stat.max_files) {
		if (capable(CAP_SYS_ADMIN)) {
		/*
		 * percpu_counters are inaccurate.  Do an expensive check before
		 * we go and fail.
		 */
			if (percpu_counter_sum(&nr_files) >= 
						files_stat.max_files)
				goto over;
		} else 
			goto over;
	}
	
>  
> 
> - Make get_nr_files() static.  Which is just as well - any callers might
>   want the percpu_counter_sum() treatment.  In which case we'd be better off
>   exporting some
> 
> 	bool are_files_over_limit(how_many_i_want);

Well, as of now there is none (xfs use was removed a few months ago).
So, I removed the EXPORT_SYMBOL for get_nr_files() and forgot to
make it static. Your patch does the right thing.

Thanks
Dipankar
