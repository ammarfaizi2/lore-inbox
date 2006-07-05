Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbWGEXpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbWGEXpB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 19:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWGEXpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 19:45:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21957 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965073AbWGEXpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 19:45:00 -0400
Date: Wed, 5 Jul 2006 16:44:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Keith Mannthey" <kmannth@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-Id: <20060705164457.60e6dbc2.akpm@osdl.org>
In-Reply-To: <a762e240607051628n42bf3b79v34178c7251ad7d92@mail.gmail.com>
References: <20060703030355.420c7155.akpm@osdl.org>
	<a762e240607051447x3c3c6e15k9cdb38804cf13f35@mail.gmail.com>
	<20060705155037.7228aa48.akpm@osdl.org>
	<a762e240607051628n42bf3b79v34178c7251ad7d92@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 16:28:39 -0700
"Keith Mannthey" <kmannth@gmail.com> wrote:

> > Per-cpuifying the 2.5 kbyte runqueue struct will have hurt.
> >
> > [does readelf --section-headers drivers/scsi/sd_mod.ko, wonders why
> > .data.percpu isn't there]
> 
> hmm.  There is no message from the readelf command but there it dosen't
> report any  .data.percpu area.  The only sections for data are just .data  and
> .rela.data

hm.

> > Are you able to add this, see if we can work out where it all went?
> 
> I am still booting with the larger percpu size but I see
> 
> percpu_modalloc: allocating 16 bytes for module scsi_mod (vmlinux:41600)
> percpu_modalloc: allocating 8 bytes for module ipv6 (vmlinux:41600)
> 
> from the log.  Something built in is eating it.

Yes, vmlinux got it all.

> I am turing off the readhead to see if that helps.

Use

	nm -n vmlinux | grep per_cpu

I get:

00000000c0425780 A __per_cpu_start
00000000c0427980 d per_cpu__cpu_idle_state
00000000c0427a00 D per_cpu__irq_stat
00000000c0427a80 D per_cpu__cpu_16bit_stack
00000000c0427e80 D per_cpu__cpu_gdt_descr
00000000c0427f00 D per_cpu__cpu_tlbstate
00000000c0427f80 D per_cpu__cpu_state
00000000c0427f84 d per_cpu__perfctr_nmi_owner
00000000c0427f88 d per_cpu__evntsel_nmi_owner
00000000c0427f94 d per_cpu__nmi_watchdog_ctlblk
00000000c0427fc0 D per_cpu__current_kprobe
00000000c0427fe0 D per_cpu__kprobe_ctlblk
00000000c0428080 D per_cpu__mmu_gathers
00000000c0428880 d per_cpu__runqueues
00000000c0429240 d per_cpu__cpu_domains
00000000c0429320 d per_cpu__core_domains
00000000c0429400 d per_cpu__phys_domains
00000000c04294e0 D per_cpu__kstat
00000000c04298dc D per_cpu__process_counts
00000000c04298e0 d per_cpu__cpu_profile_hits
00000000c04298e8 d per_cpu__cpu_profile_flip
00000000c04298ec d per_cpu__tasklet_vec
00000000c04298f0 d per_cpu__tasklet_hi_vec
00000000c04298f4 d per_cpu__ksoftirqd
00000000c04298f8 d per_cpu__tvec_bases
00000000c0429900 D per_cpu__rcu_data
00000000c0429940 D per_cpu__rcu_bh_data
00000000c0429980 d per_cpu__rcu_tasklet
00000000c04299a0 d per_cpu__hrtimer_bases
00000000c0429a38 d per_cpu__kprobe_instance
00000000c0429a3c d per_cpu__touch_timestamp
00000000c0429a40 d per_cpu__print_timestamp
00000000c0429a44 d per_cpu__watchdog_task
00000000c0429a60 d per_cpu__ratelimits.18951
00000000c0429a80 d per_cpu__committed_space
00000000c0429aa0 d per_cpu__lru_add_pvecs
00000000c0429ae0 d per_cpu__lru_add_active_pvecs
00000000c0429b20 D per_cpu__vm_event_states
00000000c0429bc0 d per_cpu__reap_work
00000000c0429c00 d per_cpu__bh_lrus
00000000c0429c20 d per_cpu__bh_accounting
00000000c0429c40 d per_cpu__fdtable_defer_list
00000000c0429ca8 D per_cpu__avc_cache_stats
00000000c0429cc0 d per_cpu__blk_cpu_done
00000000c0429cc8 d per_cpu__blk_trace_cpu_offset
00000000c0429ce0 D per_cpu__radix_tree_preloads
00000000c0429d00 d per_cpu__trickle_count
00000000c0429d04 d per_cpu__proc_event_counts
00000000c0429d20 d per_cpu__loopback_stats
00000000c0429d80 d per_cpu__sockets_in_use
00000000c0429e00 D per_cpu__softnet_data
00000000c042a300 D per_cpu__netdev_rx_stat
00000000c042a310 d per_cpu__net_rand_state
00000000c042a380 d per_cpu__flow_tables
00000000c042a400 d per_cpu__flow_hash_info
00000000c042a480 d per_cpu__flow_flush_tasklets
00000000c042a4a0 d per_cpu__rt_cache_stat
00000000c042a4e0 d per_cpu____icmp_socket
00000000c042a4e4 A __per_cpu_end

Which is 19k.

<wonders what happened to the first 8.5k>

If we have any 2-D arrays in there (something dimensioned by NR_CPUS) then
we'll have a big problem.

I guess a medium-term fix would be to add a boot parameter to override
PERCPU_ENOUGH_ROOM - it's hard to justify increasing it permanently just
for the benefit of the tiny minority of kernels which are hand-built with
lots of drivers in vmlinux.

But first let's find out where it all went.
