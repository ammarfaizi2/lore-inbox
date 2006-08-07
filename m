Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWHGRw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWHGRw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 13:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWHGRw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 13:52:56 -0400
Received: from xenotime.net ([66.160.160.81]:19346 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750821AbWHGRwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 13:52:55 -0400
Date: Mon, 7 Aug 2006 10:55:37 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
Message-Id: <20060807105537.08557636.rdunlap@xenotime.net>
In-Reply-To: <m1wt9kcv2n.fsf@ebiederm.dsl.xmission.com>
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	<20060807085924.72f832af.rdunlap@xenotime.net>
	<m1wt9kcv2n.fsf@ebiederm.dsl.xmission.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Aug 2006 11:30:24 -0600 Eric W. Biederman wrote:

> Currently on a SMP system we can theoretically support
> NR_CPUS*224 irqs.  Unfortunately our data structures
> don't cope will with that many irqs, nor does hardware
> typically provide that many irq sources.
> 
> With the number of cores starting to follow Moore's Law,
> and the apicid limits being raised beyond an 8bit
> number trying to track our current maximum with our
> current data structures would be fatal and wasteful.
> 
> So this patch decouples the number of irqs we support
> from the number of cpus.  We can revisit this decision
> once someone reworks the current data structures.
> 
> This version has my stupid typos fix and the true maximum
> exposed to make it clear that I have a low default.  The
> worst that I can see happening is there won't be any
> per_cpu space left for modules if someone sets this
> too high, but the system should still boot.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
> 
> This of course applies to the -mm tree because the rest
> of the irq work is not yet in the mainline kernel.
> 
>  arch/x86_64/Kconfig      |   14 ++++++++++++++
>  include/asm-x86_64/irq.h |    3 ++-
>  2 files changed, 16 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
> index 7598d99..cea78d7 100644
> --- a/arch/x86_64/Kconfig
> +++ b/arch/x86_64/Kconfig
> @@ -384,6 +384,20 @@ config NR_CPUS
>  	  This is purely to save memory - each supported CPU requires
>  	  memory in the static kernel configuration.

Thanks for the language fixes.
I'm confused about one thing.  What is NR_IRQS for non-SMP?
Does it default to 4096 or something else?

Does this build on non-SMP?  Is CONFIG_NR_IRQS defined for non-SMP?

> +config NR_IRQS
> +	int "Maximum number of IRQs (224-57344)"
> +	range 224 57344
> +	depends on SMP
> +	default "4096"
> +	help
> +	  This allows you to specify the maximum number of IRQs which this
> +	  kernel will support. Current default is 4096 IRQs as that
> +	  is slightly larger than has observed in the field.  Setting
> +	  a noticeably larger value will exhaust your per cpu memory,
> +	  and waste memory in the per irq arrays.
> +
> +	  If unsure leave this at 4096.
> +
>  config HOTPLUG_CPU
>  	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
>  	depends on SMP && HOTPLUG && EXPERIMENTAL
> diff --git a/include/asm-x86_64/irq.h b/include/asm-x86_64/irq.h
> index 5006c6e..34b264a 100644
> --- a/include/asm-x86_64/irq.h
> +++ b/include/asm-x86_64/irq.h
> @@ -31,7 +31,8 @@ #define NR_VECTORS 256
>  
>  #define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in hw_irq.h */
>  
> -#define NR_IRQS (NR_VECTORS + (32 *NR_CPUS))
> +/* We can use at most NR_CPUS*224 irqs at one time */
> +#define NR_IRQS (CONFIG_NR_IRQS)
>  #define NR_IRQ_VECTORS NR_IRQS
>  
>  static __inline__ int irq_canonicalize(int irq)
> -- 

---
~Randy
