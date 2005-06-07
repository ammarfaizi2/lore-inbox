Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVFGMG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVFGMG3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 08:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVFGMG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 08:06:29 -0400
Received: from fmr21.intel.com ([143.183.121.13]:33182 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261832AbVFGMGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 08:06:19 -0400
Date: Tue, 7 Jun 2005 05:05:15 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>, akpm <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>, x86-64 <discuss@x86-64.org>,
       Rusty Russell <rusty@rustycorp.com.au>, ak <ak@muc.de>
Subject: Re: [patch 4/5] try2: x86_64: Dont use broadcast shortcut to make it cpu hotplug safe.
Message-ID: <20050607050515.A24670@unix-os.sc.intel.com>
References: <20050606191433.104273000@araj-em64t> <20050606192113.307745000@araj-em64t> <1118128410.3949.3.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1118128410.3949.3.camel@linux-hp.sh.intel.com>; from shaohua.li@intel.com on Tue, Jun 07, 2005 at 03:13:30PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaohua,

The patch i submitted only has fix for x86_64. I did not yet submit one
for i386 yet. For x86_64, the whole access for __smp_call_function() is 
with call_lock held, so shouldnt be a problem.

Cheers,
ashok
On Tue, Jun 07, 2005 at 03:13:30PM +0800, Shaohua Li wrote:
> On Mon, 2005-06-06 at 12:14 -0700, Ashok Raj wrote:
> > plain text document attachment (no_broadcast_ipi.patch)
> > Broadcast IPI's provide un-expected behaviour for cpu hotplug. CPU's in offline
> > state also end up receiving the IPI. Once the cpus become online
> > they receive these stale IPI's which are bad and introduce unexpected
> > behaviour. 
> > 
> With the patch. smp_call_function still has race. It accesses
> cpu_online_map twice. First calculate online cpu counter and second,
> send the ipi, so it's not atomic. We should do something like this:
> 

Deleted....

> 
> --- a/arch/i386/kernel/smp.c	2005-04-26 08:47:08.000000000 +0800
> +++ b/arch/i386/kernel/smp.c	2005-05-31 16:37:10.565141944 +0800
> @@ -527,10 +527,13 @@ int smp_call_function (void (*func) (voi
>  {
>  	struct call_data_struct data;
>  	int cpus;
> +	cpumask_t mask;
>  
>  	/* Holding any lock stops cpus from going down. */
>  	spin_lock(&call_lock);
> -	cpus = num_online_cpus()-1;
> +	mask = cpu_online_map;
> +	cpu_clear(smp_processor_id(), mask);
> +	cpus = cpus_weight(mask);
>  
>  	if (!cpus) {
>  		spin_unlock(&call_lock);
> @@ -551,7 +554,7 @@ int smp_call_function (void (*func) (voi
>  	mb();
>  	
>  	/* Send a message to all other CPUs and wait for them to respond */
> -	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
> +	send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
>  
>  	/* Wait for response */
>  	while (atomic_read(&data.started) != cpus)
> --- a/arch/x86_64/kernel/smp.c	2005-04-12 10:12:16.000000000 +0800
> +++ b/arch/x86_64/kernel/smp.c	2005-05-31 16:38:07.613469280 +0800
> @@ -303,8 +303,11 @@ static void __smp_call_function (void (*
>  				int nonatomic, int wait)
>  {
>  	struct call_data_struct data;
> -	int cpus = num_online_cpus()-1;
> +	int cpus;
> +	cpumask_t mask = cpu_online_map;
>  
> +	cpu_clear(smp_processor_id(), mask);
> +	cpus = cpus_weight(mask);
>  	if (!cpus)
>  		return;
>  
> @@ -318,7 +321,7 @@ static void __smp_call_function (void (*
>  	call_data = &data;
>  	wmb();
>  	/* Send a message to all other CPUs and wait for them to respond */
> -	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
> +	send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
>  
>  	/* Wait for response */
>  	while (atomic_read(&data.started) != cpus)
> 
> 

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
