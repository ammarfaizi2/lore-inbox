Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268004AbUJOBh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268004AbUJOBh4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 21:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUJOBh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 21:37:56 -0400
Received: from ozlabs.org ([203.10.76.45]:19421 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268004AbUJOBhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 21:37:53 -0400
Subject: Re: 2.6.9-rc3-mm2
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200410051607.40860.dominik.karall@gmx.net>
References: <20041004020207.4f168876.akpm@osdl.org>
	 <200410051607.40860.dominik.karall@gmx.net>
Content-Type: text/plain
Message-Id: <1097804285.22673.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 11:38:05 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 00:07, Dominik Karall wrote:
> On Monday 04 October 2004 11:02, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6
> >.9-rc3-mm2/
> 
> some more scheduling/preempt problems. following patches were applied:
> --- 
> 25/include/linux/netfilter_ipv4/ip_conntrack.h~conntrack-preempt-safety-fix 
> Mon Oct  4 14:36:19 2004
> +++ 25-akpm/include/linux/netfilter_ipv4/ip_conntrack.h Mon Oct  4 14:37:02 
> 2004
> @@ -311,10 +311,11 @@ struct ip_conntrack_stat
>         unsigned int expect_delete;
>  };
>  
> -#define CONNTRACK_STAT_INC(count)                              \
> -       do {                                                    \
> -               per_cpu(ip_conntrack_stat, get_cpu()).count++;  \
> -               put_cpu();                                      \
> +#define CONNTRACK_STAT_INC(count)                                      \
> +       do {                                                            \
> +               preempt_disable();                                      \
> +               per_cpu(ip_conntrack_stat, smp_processor_id()).count++; \
> +               preempt_disable();                                      \
>         } while (0)

Please, please please!  Never use per_cpu(XXX, smp_processor_id())!  In
this case, it's "get_cpu_var(ip_conntrack_stat).count++; put_cpu(),
although I think this code should only be called in a softirq, so a
simple "__get_cpu_var(ip_conntrack_stat).count++;" is sufficient.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

