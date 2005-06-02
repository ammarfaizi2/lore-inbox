Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVFBSvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVFBSvL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 14:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVFBSvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 14:51:11 -0400
Received: from colin.muc.de ([193.149.48.1]:29447 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261236AbVFBSuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 14:50:55 -0400
Date: 2 Jun 2005 20:50:53 +0200
Date: Thu, 2 Jun 2005 20:50:53 +0200
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5 is broken in nvidia Ck804 Opteron MB/with dual cor e dual way
Message-ID: <20050602185053.GF1683@muc.de>
References: <3174569B9743D511922F00A0C94314230A403901@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C94314230A403901@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 08:16:35PM -0700, YhLu wrote:
> andi,
> 
> in arch/x86_64/kernel/smboot.c, function detect_siblings(),
> 
> because smp_num_siblings is always =1,  so several lines can be removed.

What do you mean? On intel systems with HyperThreading it is > 1.
> 
>         for_each_online_cpu (cpu) {
>                 struct cpuinfo_x86 *c = cpu_data + cpu;
> *R*                int siblings = 0;
>                 int i;
> *R*                if (smp_num_siblings > 1) {
> *R*                        for_each_online_cpu (i) {
> *R*                                if (cpu_core_id[cpu] == cpu_core_id[i]) {
> *R*                                        siblings++;
> *R*                                        cpu_set(i, cpu_sibling_map[cpu]);
> *R*                                }
> *R*                        }
> *R*                } else {
> *R*                      siblings++;
>                         cpu_set(cpu, cpu_sibling_map[cpu]);
> *R*                }
> 
> 
>  *R*               if (siblings != smp_num_siblings) {
>  *R*                       printk(KERN_WARNING
>  *R*              "WARNING: %d siblings found for CPU%d, should be %d\n",
>  *R*                              siblings, cpu, smp_num_siblings);
>  *R*                       smp_num_siblings = siblings;
>  *R*               }
> 
> Also I found the workaround for hang on second node is
> adding one line in setup.c
>         /* Low order bits define the core id (index of core in socket) */
>         cpu_core_id[cpu] = phys_proc_id[cpu] & ((1 << bits)-1);
>         /* Convert the APIC ID into the socket ID */
>         phys_proc_id[cpu] >>= bits;
> +        printk(KERN_INFO "  CPU %d(%d)  phys_proc_id %d  Core %d\n", 
> +               cpu, c->x86_num_cores, phys_proc_id[cpu], cpu_core_id[cpu]);

That would just change the timing.

-Andi
