Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262551AbTDBHPe>; Wed, 2 Apr 2003 02:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262534AbTDBHPe>; Wed, 2 Apr 2003 02:15:34 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:55051 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262551AbTDBHPa>; Wed, 2 Apr 2003 02:15:30 -0500
Date: Wed, 2 Apr 2003 08:26:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [patch][rfc] Memory Binding (1/1)
Message-ID: <20030402082652.B22335@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Dobson <colpatch@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@digeo.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <3E8A135B.3030106@us.ibm.com> <3E8A151A.1040800@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E8A151A.1040800@us.ibm.com>; from colpatch@us.ibm.com on Tue, Apr 01, 2003 at 02:39:22PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 02:39:22PM -0800, Matthew Dobson wrote:
> --- linux-2.5.66-pre_membind/arch/i386/kernel/entry.S	Mon Mar 24 14:00:11 2003
> +++ linux-2.5.66-membind/arch/i386/kernel/entry.S	Mon Mar 31 17:45:20 2003
> @@ -852,6 +852,7 @@
>   	.long sys_clock_gettime		/* 265 */
>   	.long sys_clock_getres
>   	.long sys_clock_nanosleep
> + 	.long sys_membind

Syscall slot 223 is unused, please use it instead of adding at the end.

> +#ifndef CONFIG_NUMA
> +
> +asmlinkage unsigned long sys_membind(unsigned long start, unsigned long len, 
> +		unsigned long *mask_ptr, unsigned int mask_len, unsigned long policy)
> +{
> +	return -ENOSYS;
> +}
> +
> +#else /* CONFIG_NUMA */

Yuck!  Compile this file conditional on CONFIG_NUMA and add a cond_syscall
entry for sys_membind to kernel/sys.c

> +#include <linux/binding.h>
> +#include <asm/string.h>
> +#include <asm/topology.h>
> +#include <asm/uaccess.h>
> +
> +/* Translate a cpumask to a nodemask */
> +static inline void cpumask_to_nodemask(DECLARE_BITMAP(cpumask, NR_CPUS), 
> +		DECLARE_BITMAP(nodemask, MAX_NUMNODES))

Umm, this arguments looks strange.  DECLARE_BITMAP always expands to
an unsigned long array, so just use unsigned long * arguments.

> +static inline int add_zones(pg_data_t *pgdat, struct zonelist *zonelist, 
> +			int zone_num, int zone_type)
> +{
> +	switch (zone_type) {
> +		struct zone *zone;
> +	default:
> +		BUG();
> +	case ZONE_HIGHMEM:
> +		zone = pgdat->node_zones + ZONE_HIGHMEM;
> +		if (zone->present_pages)
> +			zonelist->zones[zone_num++] = zone;
> +	case ZONE_NORMAL:
> +		zone = pgdat->node_zones + ZONE_NORMAL;
> +		if (zone->present_pages)
> +			zonelist->zones[zone_num++] = zone;
> +	case ZONE_DMA:
> +		zone = pgdat->node_zones + ZONE_DMA;
> +		if (zone->present_pages)
> +			zonelist->zones[zone_num++] = zone;
> +	}

Hardconding of zones looks like a bad idea.  Do you really need to
expose zones in the API?  User memory should always be in ZONE_HIGHMEM
(or ZONE_NORMAL for 64bit arches).

> +	vma = find_vma(current->mm, start);
> +	if (!(vma && vma->vm_file && vma->vm_ops && 
> +		vma->vm_ops->nopage == shmem_nopage)) {
> +		/* This isn't a shm segment.  For now, we bail. */
> +		printk("%s: Can only bind shm(em) segments for now!\n", __FUNCTION__);
> +		error = -EINVAL;
> +		goto out;
> +	}

This check sounds like a bad idea.  Please make this API generic.

