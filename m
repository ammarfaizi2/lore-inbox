Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWH1JVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWH1JVZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 05:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWH1JVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 05:21:25 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:41175 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932341AbWH1JVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 05:21:24 -0400
Subject: Re: Is stopmachine() preempt safe?
From: Rusty Russell <rusty@rustcorp.com.au>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       Len Brown <len.brown@intel.com>
In-Reply-To: <10518.1156747016@kao2.melbourne.sgi.com>
References: <10518.1156747016@kao2.melbourne.sgi.com>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 19:21:18 +1000
Message-Id: <1156756878.10467.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 16:36 +1000, Keith Owens wrote:
> There is a lot of code in the kernel that runs cpu_online_map without
> taking any locks and without disabling preemption.  Obviously we do not
> want all that code to lock or disable preemption, it will kill
> scalability.

There is actually not much code which should use cpu_online_map.  Code
which does must be careful: you generally need to think about handling
cpu hotplug notifiers as well as the map changing underneath you.

Doing a brief audit, ignoring the already-acknowledged cpufreq code and
arch-specifics, I can see these cases which seem suspicious:

./drivers/acpi/processor_core.c:acpi_processor_handle_eject()
        - I assume this is relying on some other mechanism so the cpu
        doesn't get onlined?
        - A couple of other num_online_cpus() there in ACPI might need a
        rethink for hotplug CPU though.

./kernel/irq/proc.c:  irq_affinity_write_proc()
        - seems complicated, but I think migration.c handles when cpus
        gone offline?

./drivers/oprofile/cpu_buffer.c:
        - needs to handle hotplug cpus (or just say don't do that?)

./drivers/infiniband/hw/ipath/ipath_file_ops.c:
        - seems to be using num_online_cpus as a really poor heuristic,
        and incorrectly (for i = 0; i < num_online_cpus(); i++) <-- i is
        not a valid CPU number!).

./kernel/power/main.c:suspend_prepare()
        - suspicious, code here, too.
        
./net/core/dev.c: net_dma_rebalance()
        - This is a heuristic, which may be OK.
./net/core/dev.c: softnet_get_online()
        - It'd be nice if net/dev/core.c used cpu_possible() not
        cpu_online() to report stats, so they don't get lost from
        offlined CPUs.

./net/core/pktgen.c: pg_init()
        - Assumes no CPU plugging, but is a pretty specialized driver.
        
(Other uses get away with being in initcalls, or on platforms without
hotplug CPU).

Disappointingly, none of these would be fixed by changing the semantics
of stop_machine; they rely on the online cpus and must take action when
they change, whether they are reading the online_cpu_map at the time or
not.

Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

