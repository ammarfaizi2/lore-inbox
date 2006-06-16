Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWFPRei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWFPRei (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 13:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWFPRei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 13:34:38 -0400
Received: from mga06.intel.com ([134.134.136.21]:11880 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751501AbWFPReh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 13:34:37 -0400
X-IronPort-AV: i="4.06,143,1149490800"; 
   d="scan'208"; a="51974557:sNHT873735835"
Date: Fri, 16 Jun 2006 10:29:35 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com, ak@suse.de
Subject: Re: [RFC][PATCH] avoid cpu hot remove of cpus which have special RT tasks.
Message-ID: <20060616102934.A2940@unix-os.sc.intel.com>
References: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com> <Pine.LNX.4.64.0606160908120.14330@schroedinger.engr.sgi.com> <20060617014623.8f820e8b.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060617014623.8f820e8b.kamezawa.hiroyu@jp.fujitsu.com>; from kamezawa.hiroyu@jp.fujitsu.com on Sat, Jun 17, 2006 at 01:46:23AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2006 at 01:46:23AM +0900, KAMEZAWA Hiroyuki wrote:
> +		if (tsk->mm && stop_derailed_process) {
> +			force = 1;
> +			printk(KERN_INFO, "process %d (%s) is stopped "
> +			       "by stop_derailed_process sysctl\n",
> +				tsk->pid, tsk->comm);
> +		}
>  	}
>  	__migrate_task(tsk, dead_cpu, dest_cpu);
> +	if (force)
> +		force_sig_specific(SIGSTOP, tsk);
>  }
>  

Humm, dont know killing tasks is a good thing, unless the thread specifically 
asked for it.

I dont know if there are bad cases, but if a thread just switched itself to 
get to some per cpu data its best to ensure it does that consistently.

i see some code in kernel that does this today


        cpumask_t save_cpus_allowed = current->cpus_allowed;
        cpumask_t new_cpus_allowed = cpumask_of_cpu(cpu);
        set_cpus_allowed(current, new_cpus_allowed);
        (*fn)(arg);
        set_cpus_allowed(current, save_cpus_allowed);

Probably such code should use a get_cpu()/put_cpu() to ensure they do this on 
the right context to ensure they are not switched.

Should we have this flag on a per-task so we know if this task should be 
killed, or could be migrated without damage (assuming its going to run slow, 
but nothing critically bad will happen)

Iam just worried if killing them globally without giving them a chance is 
any good and favorite apps such as databases will have probably have
ill effects.

Cheers,
ashok
