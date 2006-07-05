Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWGETns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWGETns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWGETns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:43:48 -0400
Received: from mga05.intel.com ([192.55.52.89]:3772 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S964978AbWGETnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:43:47 -0400
X-IronPort-AV: i="4.06,210,1149490800"; 
   d="scan'208"; a="93592139:sNHT15872920"
Date: Wed, 5 Jul 2006 12:36:29 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, mbligh@mbligh.org,
       linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: [patch] sched: fix macro -> inline function conversion bug
Message-ID: <20060705123629.A7271@unix-os.sc.intel.com>
References: <44A8567B.2010309@mbligh.org> <20060702164113.6dc1cd6c.akpm@osdl.org> <20060703052538.GB13415@elte.hu> <20060702224247.21e8aa8f.akpm@osdl.org> <20060703060320.GA15782@elte.hu> <20060703060832.GA15940@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060703060832.GA15940@elte.hu>; from mingo@elte.hu on Mon, Jul 03, 2006 at 08:08:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin, Andy: Can you please try the appended patch on top of 2.6.17-mm5?

thanks,
suresh

On Mon, Jul 03, 2006 at 08:08:32AM +0200, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > Did you work out which divide is getting the div-by-zero?  I started 
> > > at it a bit and wasn't sure - am getting wildly different code 
> > > generation over here.
> > 
> > my bet is on sched-group-cpu-power-setup-cleanup.patch.
> 
> in particular, we dont seem to initialize ->cpu_power properly. Martin, 
> does the patch below solve your crash?
> 
>  		sd = sd->child;
> -		if (sd && sd->flags & flag)
> +		if (test_sd_flag(sd, flag))

There is a bug in my patch. Appended patch fixes this.

> -	if (!sd || !sd->groups || (cpu != first_cpu(sd->groups->cpumask)))
> +	WARN_ON(!sd || !sd->groups);
> +
> +	if (cpu != first_cpu(sd->groups->cpumask)) {
> +		sd->groups->cpu_power = SCHED_LOAD_SCALE;
>  		return;

This is also not correct and will corrupt some of the groups cpu_power.
NUMA sched group setup is some what different from the other domains like
HT and SMP. Appended patch has the correct fix.

--

- go back to original numa sched group power initialization
- fix the sched_balance_self code
- some cleanup as suggested by Ingo.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.17mm5/kernel/sched.c~	2006-07-05 10:15:27.274721992 -0700
+++ linux-2.6.17mm5/kernel/sched.c	2006-07-05 10:34:01.072399008 -0700
@@ -1292,7 +1292,7 @@ static int sched_balance_self(int cpu, i
 		cpu = new_cpu;
 nextlevel:
 		sd = sd->child;
-		if (sd && sd->flags & flag)
+		if (sd && !(sd->flags & flag))
 			goto nextlevel;
 		/* while loop will break here if sd == NULL */
 	}
@@ -5534,7 +5534,7 @@ static void cpu_attach_domain(struct sch
 
 	if (sd && sd_degenerate(sd)) {
 		sd = sd->parent;
-		if(sd)
+		if (sd)
 			sd->child = NULL;
 	}
 
@@ -6224,6 +6224,7 @@ static int cpu_to_allnodes_group(int cpu
 {
 	return cpu_to_node(cpu);
 }
+
 static void init_numa_sched_groups_power(struct sched_group *group_head)
 {
 	struct sched_group *sg = group_head;
@@ -6314,7 +6315,9 @@ static void init_sched_groups_power(int 
 	struct sched_domain *child;
 	struct sched_group *group;
 
-	if (!sd || !sd->groups || (cpu != first_cpu(sd->groups->cpumask)))
+	WARN_ON(!sd || !sd->groups);
+
+	if (cpu != first_cpu(sd->groups->cpumask))
 		return;
 
 	child = sd->child;
@@ -6596,10 +6599,8 @@ static int build_sched_domains(const cpu
 	}
 
 #ifdef CONFIG_NUMA
-	for_each_cpu_mask(i, *cpu_map) {
-		sd = &per_cpu(node_domains, i);
-		init_sched_groups_power(i, sd);
-	}
+	for (i = 0; i < MAX_NUMNODES; i++)
+		init_numa_sched_groups_power(sched_group_nodes[i]);
 
 	init_numa_sched_groups_power(sched_group_allnodes);
 #endif
--- linux-2.6.17mm5/include/linux/sched.h~	2006-07-05 10:18:10.014981712 -0700
+++ linux-2.6.17mm5/include/linux/sched.h	2006-07-05 10:30:55.889551080 -0700
@@ -636,7 +636,7 @@ enum idle_type
 	((sched_mc_power_savings || sched_smt_power_savings) ?	\
 					SD_POWERSAVINGS_BALANCE : 0)
 
-#define test_sd_flag(sd, flag)	((sd && sd->flags & flag) ? 1 : 0)
+#define test_sd_flag(sd, flag)	((sd && (sd->flags & flag)) ? 1 : 0)
 
 
 struct sched_group {
