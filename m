Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319264AbSHNSdP>; Wed, 14 Aug 2002 14:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319265AbSHNSdP>; Wed, 14 Aug 2002 14:33:15 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:60433 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S319264AbSHNSdO>; Wed, 14 Aug 2002 14:33:14 -0400
Date: Wed, 14 Aug 2002 19:37:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com
Subject: Re: [patch] Scalable statistics counters using seq_file interfaces
Message-ID: <20020814193702.A22887@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ravikiran G Thirumalai <kiran@in.ibm.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	dipankar@in.ibm.com
References: <20020814165049.I27366@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020814165049.I27366@in.ibm.com>; from kiran@in.ibm.com on Wed, Aug 14, 2002 at 04:50:49PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 04:50:49PM +0530, Ravikiran G Thirumalai wrote:
> Christoph, since statctr_pentry describes only a proc entry for a
> set of counters, I thought it'd be more descriptive to use 
> statctr_proc_entry or statctr_pentry...something to indicate it is 
> for proc reporting only.

My educated guess is that I will rewrite the code to not depend on procfs
before 2.6 is out..  But as you use other procfs types it's just one more
search and replace, so..

> diff -ruN -X dontdiff linux-2.5.31/fs/proc/root.c statctr-2.5.31/fs/proc/root.c
> --- linux-2.5.31/fs/proc/root.c	Sun Aug 11 07:11:50 2002
> +++ statctr-2.5.31/fs/proc/root.c	Tue Aug 13 10:14:46 2002
> @@ -19,6 +19,7 @@
>  #include <linux/smp_lock.h>
>  
>  struct proc_dir_entry *proc_net, *proc_bus, *proc_root_fs, *proc_root_driver;
> +struct proc_dir_entry *proc_statistics;
>  
>  #ifdef CONFIG_SYSCTL
>  struct proc_dir_entry *proc_sys_root;
> @@ -77,6 +78,7 @@
>  	proc_rtas_init();
>  #endif
>  	proc_bus = proc_mkdir("bus", 0);
> +	proc_statistics = proc_mkdir("statistics", 0);

Any reason you don't do this in kernel/statctr.c?

> +#ifndef _LINUX_STATCTR_H
> +#define _LINUX_STATCTR_H
> + 
> +#ifdef  __KERNEL__

Is this needed?

> +static inline struct statctr_pentry 
> +*create_statctr_pentry(struct proc_dir_entry *parent, const char *name) 

Shouldn't this be:

static inline struct statctr_pentry *
create_statctr_pentry(struct proc_dir_entry *parent, const char *name)

> +{
> +	return(NULL);
> +}

return is not function-like and the additional braces are heavily disliked
in the kernel (at least for new code)

> +static inline int __statctr_init(statctr_t *stctr, int gfp_mask)
> +{
> +	stctr->ctr = kmalloc_percpu(sizeof(*(stctr->ctr)), gfp_mask); 
> +	if(!stctr->ctr) 

Kernel coding style has a space after the if.

> +		return -1;

-ENOMEM?

> +void free_statctr_pentry(struct statctr_pentry *pentry)
> +{
> +	if(!list_empty(&pentry->head))

Add an unlikely?

It might be worth to rework the code to follow Documentation/CodingStyle
