Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946511AbWJTVEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946511AbWJTVEY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbWJTVEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:04:23 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:60812 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030355AbWJTVEW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:04:22 -0400
Date: Sat, 21 Oct 2006 02:34:22 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@google.com>,
       Paul Menage <menage@google.com>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, Rohit Seth <rohitseth@google.com>,
       Robin Holt <holt@sgi.com>, dipankar@in.ibm.com,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-ID: <20061020210422.GA29870@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 02:26:07AM -0700, Paul Jackson wrote:
> From: Paul Jackson <pj@sgi.com>
> 
> Enable user code to isolate CPUs on a system from the domains that
> determine scheduler load balancing.
> 
> This is already doable using the boot parameter "isolcpus=".  The folks
> running realtime code on production systems, where some nodes are
> isolated for realtime, and some not, and where it is unacceptable
> to reboot to adjust this, need to be able to change which CPUs are
> isolated from the scheduler balancing code on the fly.
> 
> This is done by exposing the kernels cpu_isolated_map as a cpumask
> in the root cpuset directory, in a file called 'isolated_cpus',
> where it can be read and written by sufficiently privileged user code.
> 
> Signed-off-by: Paul Jackson <pj@sgi.com>

IMO this patch addresses just one of the requirements for partitionable
sched domains

1. Partition the system into multiple sched domains such that rebalancing
   happens within the group of each such partition
2. Ability to create partitioned sched domains that can further be 
   partitioned with exclusive and non exclusive cpusets (exclusive in this
   context is not tied to sched domains anymore)
3. Ability to partition a system, such that a cpus in a partition dont
   have any rebalancing at all

Hope this makes sense

	-Dinakar


> 
> ---
> 
> I have built and booted this on one system, ia64/sn2, and
> verified that I can set and query the cpu_isolated_map,
> and that tasks are not scheduled on such isolated CPUs
> unless I explicitly place them there.
> 			-pj
> 
>  Documentation/cpusets.txt           |   26 +++++++++++++++++++++++---
>  Documentation/kernel-parameters.txt |    4 ++++
>  include/linux/sched.h               |    3 +++
>  kernel/cpuset.c                     |   31 +++++++++++++++++++++++++++++++
>  kernel/sched.c                      |   21 ++++++++++++++++++++-
>  5 files changed, 81 insertions(+), 4 deletions(-)
> 
> --- 2.6.19-rc1-mm1.orig/Documentation/cpusets.txt	2006-10-18 21:24:22.000000000 -0700
> +++ 2.6.19-rc1-mm1/Documentation/cpusets.txt	2006-10-18 21:24:22.000000000 -0700
> @@ -19,7 +19,8 @@ CONTENTS:
>    1.5 What does notify_on_release do ?
>    1.6 What is memory_pressure ?
>    1.7 What is memory spread ?
> -  1.8 How do I use cpusets ?
> +  1.8 What is isolated_cpus ?
> +  1.9 How do I use cpusets ?
>  2. Usage Examples and Syntax
>    2.1 Basic Usage
>    2.2 Adding/removing cpus
> @@ -174,8 +175,9 @@ containing the following files describin
>   - notify_on_release flag: run /sbin/cpuset_release_agent on exit?
>   - memory_pressure: measure of how much paging pressure in cpuset
>  
> -In addition, the root cpuset only has the following file:
> +In addition, the root cpuset only has the following files:
>   - memory_pressure_enabled flag: compute memory_pressure?
> + - isolated_cpus: cpus excluded from scheduler domains
>  
>  New cpusets are created using the mkdir system call or shell
>  command.  The properties of a cpuset, such as its flags, allowed
> @@ -378,7 +380,25 @@ data set, the memory allocation across t
>  can become very uneven.
>  
>  
> -1.8 How do I use cpusets ?
> +1.8 What is isolated_cpus ?
> +---------------------------
> +
> +The cpumask isolated_cpus, visible in the top cpuset, provides direct
> +access to the kernel cpu_isolated_map (in kernel/sched.c), which are
> +the CPUs which are excluded from scheduler domains.  The scheduler
> +will not load balance tasks on isolated cpus.  The 'isolated_cpus'
> +file in the root cpuset can be read, to obtain the current setting
> +of cpu_isolated_map, and can be written, to write a new cpumask to
> +cpu_isolated_map.
> +
> +The initial value of the cpu_isolated_map can be set by the kernel
> +boottime argument "isolcpus=n1,n2,n3,..." where n1, n2, n3, etc
> +are specific decimal numbers of CPUs to be isolated.  If not set
> +on the kernel boot line, then cpu_isolated_map defaults to the empty
> +cpumask.  See further Documentation/kernel-parameters.txt for isolcpus
> +documentation.
> +
> +1.9 How do I use cpusets ?
>  --------------------------
>  
>  In order to minimize the impact of cpusets on critical kernel
> --- 2.6.19-rc1-mm1.orig/Documentation/kernel-parameters.txt	2006-10-15 00:24:58.000000000 -0700
> +++ 2.6.19-rc1-mm1/Documentation/kernel-parameters.txt	2006-10-18 21:24:22.000000000 -0700
> @@ -731,6 +731,10 @@ and is between 256 and 4096 characters. 
>  			tasks in the system -- can cause problems and
>  			suboptimal load balancer performance.
>  
> +			If CPUSETS is configured, then the set of isolated
> +			CPUs can be manippulated after system boot using the
> +			"isolated_cpus" cpumask in the top cpuset.
> +
>  	isp16=		[HW,CD]
>  			Format: <io>,<irq>,<dma>,<setup>
>  
> --- 2.6.19-rc1-mm1.orig/include/linux/sched.h	2006-10-18 21:24:22.000000000 -0700
> +++ 2.6.19-rc1-mm1/include/linux/sched.h	2006-10-18 21:24:22.000000000 -0700
> @@ -715,6 +715,9 @@ struct sched_domain {
>  #endif
>  };
>  
> +extern const cpumask_t *sched_get_isolated_cpus(void);
> +extern int sched_set_isolated_cpus(const cpumask_t *isolated_cpus);
> +
>  /*
>   * Maximum cache size the migration-costs auto-tuning code will
>   * search from:
> --- 2.6.19-rc1-mm1.orig/kernel/cpuset.c	2006-10-18 21:24:22.000000000 -0700
> +++ 2.6.19-rc1-mm1/kernel/cpuset.c	2006-10-18 21:24:22.000000000 -0700
> @@ -974,6 +974,21 @@ static int update_memory_pressure_enable
>  }
>  
>  /*
> + * Call with manage_mutex held.
> + */
> +
> +static int update_isolated_cpus(struct cpuset *cs, char *buf)
> +{
> +	cpumask_t isolated_cpus;
> +	int retval;
> +
> +	retval = cpulist_parse(buf, isolated_cpus);
> +	if (retval < 0)
> +		return retval;
> +	return sched_set_isolated_cpus(&isolated_cpus);
> +}
> +
> +/*
>   * update_flag - read a 0 or a 1 in a file and update associated flag
>   * bit:	the bit to update (CS_CPU_EXCLUSIVE, CS_MEM_EXCLUSIVE,
>   *				CS_NOTIFY_ON_RELEASE, CS_MEMORY_MIGRATE,
> @@ -1215,6 +1230,7 @@ typedef enum {
>  	FILE_MEMORY_PRESSURE,
>  	FILE_SPREAD_PAGE,
>  	FILE_SPREAD_SLAB,
> +	FILE_ISOLATED_CPUS,
>  	FILE_TASKLIST,
>  } cpuset_filetype_t;
>  
> @@ -1282,6 +1298,9 @@ static ssize_t cpuset_common_file_write(
>  		retval = update_flag(CS_SPREAD_SLAB, cs, buffer);
>  		cs->mems_generation = cpuset_mems_generation++;
>  		break;
> +	case FILE_ISOLATED_CPUS:
> +		retval = update_isolated_cpus(cs, buffer);
> +		break;
>  	case FILE_TASKLIST:
>  		retval = attach_task(cs, buffer, &pathbuf);
>  		break;
> @@ -1397,6 +1416,10 @@ static ssize_t cpuset_common_file_read(s
>  	case FILE_SPREAD_SLAB:
>  		*s++ = is_spread_slab(cs) ? '1' : '0';
>  		break;
> +	case FILE_ISOLATED_CPUS:
> +		s += cpulist_scnprintf(page, PAGE_SIZE,
> +					*sched_get_isolated_cpus());
> +		break;
>  	default:
>  		retval = -EINVAL;
>  		goto out;
> @@ -1770,6 +1793,11 @@ static struct cftype cft_spread_slab = {
>  	.private = FILE_SPREAD_SLAB,
>  };
>  
> +static struct cftype cft_isolated_cpus = {
> +	.name = "isolated_cpus",
> +	.private = FILE_ISOLATED_CPUS,
> +};
> +
>  static int cpuset_populate_dir(struct dentry *cs_dentry)
>  {
>  	int err;
> @@ -1960,6 +1988,9 @@ int __init cpuset_init(void)
>  	/* memory_pressure_enabled is in root cpuset only */
>  	if (err == 0)
>  		err = cpuset_add_file(root, &cft_memory_pressure_enabled);
> +	/* isolated_cpus is in root cpuset only */
> +	if (err == 0)
> +		err = cpuset_add_file(root, &cft_isolated_cpus);
>  out:
>  	return err;
>  }
> --- 2.6.19-rc1-mm1.orig/kernel/sched.c	2006-10-18 21:24:22.000000000 -0700
> +++ 2.6.19-rc1-mm1/kernel/sched.c	2006-10-18 21:49:41.000000000 -0700
> @@ -5608,7 +5608,7 @@ static void cpu_attach_domain(struct sch
>  }
>  
>  /* cpus with isolated domains */
> -static cpumask_t __cpuinitdata cpu_isolated_map = CPU_MASK_NONE;
> +static cpumask_t cpu_isolated_map = CPU_MASK_NONE;
>  
>  /* Setup the mask of cpus configured for isolated domains */
>  static int __init isolated_cpu_setup(char *str)
> @@ -6866,6 +6866,25 @@ void __init sched_init_smp(void)
>  	if (set_cpus_allowed(current, non_isolated_cpus) < 0)
>  		BUG();
>  }
> +
> +const cpumask_t *sched_get_isolated_cpus(void)
> +{
> +	return &cpu_isolated_map;
> +}
> +
> +int sched_set_isolated_cpus(const cpumask_t *isolated_cpus)
> +{
> +	cpumask_t newly_isolated_cpus;
> +	int err;
> +
> +	lock_cpu_hotplug();
> +	cpus_and(newly_isolated_cpus, cpu_online_map, *isolated_cpus);
> +	detach_destroy_domains(&newly_isolated_cpus);
> +	cpu_isolated_map = *isolated_cpus;
> +	err = arch_init_sched_domains(&cpu_online_map);
> +	unlock_cpu_hotplug();
> +	return err;
> +}
>  #else
>  void __init sched_init_smp(void)
>  {
> 
> -- 
>                   I won't rest till it's the best ...
>                   Programmer, Linux Scalability
>                   Paul Jackson <pj@sgi.com> 1.925.600.0401
