Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVCOAGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVCOAGI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVCOAGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:06:08 -0500
Received: from fire.osdl.org ([65.172.181.4]:733 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262135AbVCOAFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:05:52 -0500
Date: Mon, 14 Mar 2005 15:59:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, davidm@hpl.hp.com, hch@lst.de
Subject: Re: Fix irq_affinity write from /proc for IPF
Message-Id: <20050314155923.4847aea3.akpm@osdl.org>
In-Reply-To: <20050314155004.A22573@unix-os.sc.intel.com>
References: <20050314155004.A22573@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> Hi Andrew/Tony
> 
> This patch is required for IPF to perform deferred write to rte's when
> affinity is programmed via /proc. These entries can only be programmed when 
> interrupt is pending.

"ia64" is preferred, please.  Nobody knows what an IPF is.

> 
>  release_dir-araj/arch/ia64/kernel/irq.c |   12 ++++++++++--
>  release_dir-araj/kernel/irq/proc.c      |   10 ++++++++--
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff -puN arch/ia64/kernel/irq.c~fix_ia64_smp_affinity arch/ia64/kernel/irq.c
> --- release_dir/arch/ia64/kernel/irq.c~fix_ia64_smp_affinity	2005-03-14 14:35:44.589293491 -0800
> +++ release_dir-araj/arch/ia64/kernel/irq.c	2005-03-14 15:27:54.262106715 -0800
> @@ -94,12 +94,20 @@ skip:
>  /*
>   * This is updated when the user sets irq affinity via /proc
>   */
> -cpumask_t __cacheline_aligned pending_irq_cpumask[NR_IRQS];
> +static cpumask_t __cacheline_aligned pending_irq_cpumask[NR_IRQS];
>  static unsigned long pending_irq_redir[BITS_TO_LONGS(NR_IRQS)];
>  
> -static cpumask_t irq_affinity [NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
>  static char irq_redir [NR_IRQS]; // = { [0 ... NR_IRQS-1] = 1 };
>  
> +/*
> + * Arch specific routine for deferred write to iosapic rte to reprogram
> + * intr destination.
> + */
> +void proc_set_irq_affinity(unsigned int irq, cpumask_t mask_val)
> +{
> +	pending_irq_cpumask[irq] = mask_val;
> +}
> +
>  void set_irq_affinity_info (unsigned int irq, int hwid, int redir)
>  {
>  	cpumask_t mask = CPU_MASK_NONE;
> diff -puN kernel/irq/proc.c~fix_ia64_smp_affinity kernel/irq/proc.c
> --- release_dir/kernel/irq/proc.c~fix_ia64_smp_affinity	2005-03-14 14:41:05.475031747 -0800
> +++ release_dir-araj/kernel/irq/proc.c	2005-03-14 15:27:59.436911339 -0800
> @@ -19,6 +19,13 @@ static struct proc_dir_entry *root_irq_d
>   */
>  static struct proc_dir_entry *smp_affinity_entry[NR_IRQS];
>  
> +void __attribute__((weak))
> +proc_set_irq_affinity(unsigned int irq, cpumask_t mask_val)
> +{
> +	irq_affinity[irq] = mask_val;
> +	irq_desc[irq].handler->set_affinity(irq, mask_val);
> +}
> +

Is it not possible for ia64's ->set_affinity() handler to do this deferring?

