Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269201AbTCBNE5>; Sun, 2 Mar 2003 08:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269202AbTCBNE5>; Sun, 2 Mar 2003 08:04:57 -0500
Received: from holomorphy.com ([66.224.33.161]:63373 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S269201AbTCBNE4>;
	Sun, 2 Mar 2003 08:04:56 -0500
Date: Sun, 2 Mar 2003 05:15:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: percpu-2.5.63-bk5-1 (properly generated)
Message-ID: <20030302131506.GI1195@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030302110747.GR24172@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030302110747.GR24172@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 03:07:47AM -0800, William Lee Irwin III wrote:
> This patch does 3 different things:
> (1) shoves per-cpu areas into node-local memory
> (2) creates a new per-node thing analogous to per-cpu
> (3) uses (1) and (2) to shove several frequently-accessed things into
>         node-local memory
> Tested, boots, and runs on NUMA-Q. Trims 6s of 41s off kernel compiles.
> Compiletested for walmart x86 SMP/UP, and could use runtime testing.
> A few non-x86 arches probably need fixups for per_cpu irq_stat[].
> Also available at:
> ftp://ftp.kernel.org/pub/linux/kernel/people/wli/percpu/

Okay, I got requests for a more detailed changelog, so here it is:
This patch does 19 different things when put under the microscope
and/or in an excessively finegrained subdivision of simple concepts.

(1) reuse the arch/i386/discontigmem.c per-node mem_map[] virtual remap
	to remap node-local memory backing per_cpu and per_node areas
(2)  make irq_stat[] per_cpu, x86-only
(3)  make mmu_gathers[] per_cpu, with comcomitant divorce from asm-generic
(4)  delay discontig zone_sizes_init() to dodge bootstrap order issues
(5)  add .data.pernode section handling in vmlinux.lds.S
(6)  per_cpu()/__get_cpu_var() needs to parenthesize the cpu arg
(7)  introduced asm-generic/pernode.h to do similar things as percpu.h
(8)  added MAX_NODE_CPUS for pessimistic sizing of virtual remapping arenas
(9)  fix return type error in NUMA-Q get_zholes_size()
(10) #undef asm-i386/per{cpu,node}.h's __GENERIC_PER_{CPU,NODE}
(11) declare setup_per_cpu_areas() in asm-i386/percpu.h
(12) make an asm-i386/pernode.h stub header like include/asm-generic/pernode.h
(13) declare MAX_NODE_CPUS in include/asm-i386/srat.h
(14) make zone_table[] per_node
(15) call setup_per_node_areas() in init/main.c, with analogous hooks
(16) make task_cache per_cpu
(17) make runqueues[] per_cpu
(18) make node_nr_running[] per_node
(19) make reap_timers[] per_cpu

-- wli
