Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbVKOUbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbVKOUbE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 15:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVKOUbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 15:31:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10971 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965035AbVKOUbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 15:31:02 -0500
Date: Tue, 15 Nov 2005 12:30:33 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Nathan Lynch <nathanl@austin.ibm.com>, ashok.raj@intel.com,
       linux-kernel@vger.kernel.org, ak@muc.de, zwane@arm.linux.org.uk,
       rusty@rustycorp.com.au, vatsa@in.ibm.com, jschopp@austin.ibm.com,
       anil.s.keshavamurthy@intel.com
Subject: Re: Documentation for CPU hotplug support
Message-ID: <20051115203033.GF7991@shell0.pdx.osdl.net>
References: <20051110075932.A16271@unix-os.sc.intel.com> <20051111072300.GY8977@localhost.localdomain> <20051111175953.7a5ce8dd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051111175953.7a5ce8dd.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Nathan Lynch <nathanl@austin.ibm.com> wrote:
> >
> >  Argh, no.  That current_in_cpuhotplug hack has to go.
> 
> Yes, Ashok is busily working on removing that ;)

That's nice.  As it is, it deadlocks on boot:

cpufreq_stats_init
  lock_cpu_hotplug
  cpufreq_stat_cpu_callback
  ... (trace below)
  cpufreq_governor_performance
  __cpufreq_driver_target
  lock_cpu_hotplug  <-- uh-oh

SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
swapper       D 003D08BC   764     1      0     2 			(L-TLB)
       eff8ed78 ef832030 c184a5f0 003d08bc effc5180 000000d0 df810b00 003d08bc
       00000002 ef832030 c184a5a0 00000000 df810b00 003d08bc ef832030 eff8dab0
       eff8dbd8 c0637140 c0637148 00000282 eff8edb0 c058bad3 eff8dab0 00000001
Call Trace:
 [<c058bad3>] __down+0x76/0xde
 [<c058a4aa>] __down_failed+0xa/0x10
 [<c04609ef>] .text.lock.cpufreq+0xee/0x1ff
 [<c0461049>] cpufreq_governor_performance+0x5d/0x74
 [<c045ff1c>] __cpufreq_governor+0x70/0x106
 [<c04603d8>] __cpufreq_set_policy+0x214/0x2b9
 [<c04605db>] cpufreq_update_policy+0xca/0xf1
 [<c0460fd5>] cpufreq_stat_cpu_callback+0x27/0x3e
 [<c06f657d>] cpufreq_stats_init+0xf0/0x152
 [<c06d59c2>] do_initcalls+0x56/0xba
 [<c06d5a4a>] do_basic_setup+0x24/0x2a
 [<c01003cf>] init+0xb5/0x1fe
 [<c010148d>] kernel_thread_helper+0x5/0xb
