Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268167AbUH2QuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268167AbUH2QuW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 12:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268170AbUH2QuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 12:50:21 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:5351 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268167AbUH2Qt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 12:49:58 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: SMP Panic caused by [PATCH] sched: consolidate sched domains
Date: Sun, 29 Aug 2004 09:48:06 -0700
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <1093786747.1708.8.camel@mulgrave>
In-Reply-To: <1093786747.1708.8.camel@mulgrave>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408290948.06473.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, August 29, 2004 6:39 am, James Bottomley wrote:
> This patch causes an immediate panic when the secondary processors come
> on-line because sd->next is NULL.
>
> The fix is to use cpu_possible_map instead of nodemask (which expands,
> probably erroneously, to cpu_online_map in the non-numa case).
>
> Any use of cpu_online_map in initialisation code is almost invariably
> wrong, so please don't do it in future.
>
> I know I'm sounding like a broken record, but it would be a lot easier
> to spot mistakes like this immediately if every arch used the hotplug
> paths to bring SMP up.
>
> Anyway, the attached fixes our panic.
>
> James
>
> ===== kernel/sched.c 1.329 vs edited =====
> --- 1.329/kernel/sched.c 2004-08-24 02:08:09 -07:00
> +++ edited/kernel/sched.c 2004-08-29 06:17:26 -07:00
> @@ -3756,7 +3756,7 @@
>    sd = &per_cpu(phys_domains, i);
>    group = cpu_to_phys_group(i);
>    *sd = SD_CPU_INIT;
> -  sd->span = nodemask;
> +  sd->span = cpu_possible_map;
>    sd->parent = p;
>    sd->groups = &sched_group_phys[group];
>
> @@ -3790,7 +3790,7 @@
>    if (cpus_empty(nodemask))
>     continue;
>
> -  init_sched_build_groups(sched_group_phys, nodemask,
> +  init_sched_build_groups(sched_group_phys, cpu_possible_map,
>        &cpu_to_phys_group);
>   }

But I think this breaks what the code is supposed to do.  You're right that we 
shouldn't use cpu_online_map, but we should leave the nodemask in there and 
fix the code that sets it in the non-NUMA case instead.

Jesse
