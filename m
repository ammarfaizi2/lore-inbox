Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264036AbSIVKlW>; Sun, 22 Sep 2002 06:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264040AbSIVKlV>; Sun, 22 Sep 2002 06:41:21 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:5802 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S264036AbSIVKlV> convert rfc822-to-8bit; Sun, 22 Sep 2002 06:41:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Date: Sun, 22 Sep 2002 12:45:30 +0200
User-Agent: KMail/1.4.1
Cc: LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
References: <200209211159.41751.efocht@ess.nec.de> <595579668.1032598511@[10.10.2.3]>
In-Reply-To: <595579668.1032598511@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209221245.30798.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 September 2002 17:55, Martin J. Bligh wrote:
> >  - Each process has a homenode assigned to it at creation time
> >    (initial load balancing). Memory will be allocated from this node.
...
>  #ifdef CONFIG_NUMA
> +#ifdef CONFIG_NUMA_SCHED
> +#define numa_node_id() (current->node)
> +#else
>  #define numa_node_id() _cpu_to_node(smp_processor_id())
> +#endif
>  #endif /* CONFIG_NUMA */
>
> I'm not convinced it's a good idea to modify this generic function,
> which was meant to tell you what node you're running on. I can't
> see it being used anywhere else right now, but wouldn't it be better
> to just modify alloc_pages instead to use current->node, and leave
> this macro as intended? Or make a process_node_id or something?

OK, I see your point and I agree that numa_node_is() should be similar to
smp_processor_id(). I'll change the alloc_pages instead.

Do you think it makes sense to get memory from the homenode only for
user processes? Many kernel threads have currently the wrong homenode,
for some of them it's unclear which homenode they should have...

There is an alternative idea (we discussed this at OLS with Andrea, maybe
you remember): allocate memory from the current node and keep statistics
on where it is allocated. Determine the homenode from this (from time to
time) and schedule accordingly. This eliminates the initial load balancing
and leaves it all to the scheduler, but has the drawback that memory can
be somewhat scattered across the nodes. Any comments?

Regards,
Erich

