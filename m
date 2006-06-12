Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751855AbWFLLGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbWFLLGf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 07:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbWFLLGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 07:06:35 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:29838 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751855AbWFLLGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 07:06:34 -0400
Date: Mon, 12 Jun 2006 13:05:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Lameter <clameter@sgi.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2
Message-ID: <20060612110537.GA11358@elte.hu>
References: <20060609214024.2f7dd72c.akpm@osdl.org> <6bffcb0e0606100323p122e9b23g37350fa9692337ae@mail.gmail.com> <20060610092412.66dd109f.akpm@osdl.org> <Pine.LNX.4.64.0606100939480.6651@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0606100951340.7174@schroedinger.engr.sgi.com> <20060610100318.8900f849.akpm@osdl.org> <Pine.LNX.4.64.0606101102380.7421@schroedinger.engr.sgi.com> <6bffcb0e0606101114u37c8b642u5c9cc8dd566cba7c@mail.gmail.com> <Pine.LNX.4.64.0606101118410.7535@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606101118410.7535@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Lameter <clameter@sgi.com> wrote:

> Sorry that patch was still against mm1. Here is a fixed up version 
> that applies cleanly against mm2:

i have applied both patches you sent in this thread but it still 
triggers tons of messages:

 printk: 104 messages suppressed.
 BUG: using smp_processor_id() in preemptible [00000001] code: distccd/9263
 caller is __handle_mm_fault+0x58/0xd70
  [<c0105d6f>] show_trace+0xd/0x10
  [<c0105d89>] dump_stack+0x17/0x1a
  [<c0585ab4>] debug_smp_processor_id+0x88/0xa0
  [<c016eb63>] __handle_mm_fault+0x58/0xd70
  [<c110ff1c>] do_page_fault+0x2e5/0x672
  [<c0104a69>] error_code+0x39/0x40
  [<c110eade>] __kprobes_text_start+0x6/0x14

trying to fix it i realized that i'd have to touch tons of 
architectures, which all duplicate this piece of code:

/* Use these for per-cpu local_t variables: on some archs they are
 * much more efficient than these naive implementations.  Note they take
 * a variable, not an address.
 */
#define cpu_local_read(v)	local_read(&__get_cpu_var(v))
#define cpu_local_set(v, i)	local_set(&__get_cpu_var(v), (i))
#define cpu_local_inc(v)	local_inc(&__get_cpu_var(v))
#define cpu_local_dec(v)	local_dec(&__get_cpu_var(v))
#define cpu_local_add(i, v)	local_add((i), &__get_cpu_var(v))
#define cpu_local_sub(i, v)	local_sub((i), &__get_cpu_var(v))

#define __cpu_local_inc(v)	cpu_local_inc(v)
#define __cpu_local_dec(v)	cpu_local_dec(v)
#define __cpu_local_add(i, v)	cpu_local_add((i), (v))
#define __cpu_local_sub(i, v)	cpu_local_sub((i), (v))

that code must all be consolidated into a header in asm-generic, so that 
the per-arch file only implements _truly_ per-arch logic.

	Ingo
