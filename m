Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbUCTIEx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 03:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbUCTIEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 03:04:53 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:35627 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263245AbUCTIEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 03:04:51 -0500
Date: Sat, 20 Mar 2004 00:02:35 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-Id: <20040320000235.5e72040a.pj@sgi.com>
In-Reply-To: <20040320031843.GY2045@holomorphy.com>
References: <1079651064.8149.158.camel@arrakis>
	<20040318165957.592e49d3.pj@sgi.com>
	<1079659184.8149.355.camel@arrakis>
	<20040318175654.435b1639.pj@sgi.com>
	<1079737351.17841.51.camel@arrakis>
	<20040319165928.45107621.pj@sgi.com>
	<20040320031843.GY2045@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Other ways to reduce cpumask copies:

 1) Additional macros, for example a boolean cpus_intersect(x,y), which
    is true iff x overlaps y, and saves the tmp cpumask in the code:

        cpus_and(tmp, target_cpu_mask, allowed_mask);
        if (!cpus_empty(tmp)) {

    or a cpus_subset(x,y) "is x a subset of y" macro to replace this:

        cpus_and(tmp, cpumask, cpu_callout_map);
        BUG_ON(!cpus_equal(cpumask, tmp));

   with this:

	BUG_ON(!cpus_subset(cpumask, cpu_callout_map));

 2) Using existing macros more carefully, for example using cpu_set() to
    set the bit in the following, and saving the copy by assignment:

	pending_irq_balance_cpumask[irq] = cpumask_of_cpu(new_cpu);

    or using the existing cpu_isset() macro, replacing the code (seen
    in part above ;):

        cpus_and(allowed_mask, cpu_online_map, irq_affinity[selected_irq]);
        target_cpu_mask = cpumask_of_cpu(min_loaded);
        cpus_and(tmp, target_cpu_mask, allowed_mask);
        if (!cpus_empty(tmp)) {

    with the code:

	if (cpu_isset(min_loaded, cpu_online_map) && cpu_isset(min_loaded, irq_affinity[selected_irq]) {

    The current nested and ifdef'd complexity of the cpumask macro headers works
    against such efficient coding - it's non-trivial to see just what macros are
    available.  The youngins reading this may not appreciate the value of reducing
    brain load; but the oldins might.

 2) Pass a cpumask pointer to a function that generates a cpumask instead of
    taking one as a return value, letting the called function fill in the memory
    so referenced.  We should not be trying to hide such details, unless we can
    do so seamlessly and consistent with traditional 'C' semantics.

 3) Passing a const cpumask pointer to a function that examines a cpumask
    instead of passing the cpumask by value (on small systems, its one word
    either way - on big systems, it saves copying a multiword mask on the
    stack).

 4) Throwing away dead code:

	static int physical_balance = 0;
        cpumask_t tmp;
	cpus_shift_right(tmp, cpu_online_map, 2);
	if (smp_num_siblings > 1 && !cpus_empty(tmp)
		physical_balance = 1;

The above code fragments are from arch/i386 in 2.6.3-rc1-mm1.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
