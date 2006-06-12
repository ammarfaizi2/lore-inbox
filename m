Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWFLQsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWFLQsU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 12:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWFLQsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 12:48:20 -0400
Received: from ns1.suse.de ([195.135.220.2]:42641 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750787AbWFLQsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 12:48:19 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: broken local_t on i386
Date: Mon, 12 Jun 2006 18:48:05 +0200
User-Agent: KMail/1.9.3
Cc: Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060609214024.2f7dd72c.akpm@osdl.org> <20060612114857.GA14616@elte.hu> <Pine.LNX.4.64.0606120921130.18975@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606120921130.18975@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606121848.05438.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2006 18:37, Christoph Lameter wrote:
> On Mon, 12 Jun 2006, Ingo Molnar wrote:
> 
> > below is an updated patch that includes fixups for i386 - but the real 
> > fix should be to properly reduce the per-arch local.h footprint to the 
> > bare minimum possible, and to do this fix on the asm-generic headers.
> 
> Nak. This is simply evidence of local.t breakage on i386. One cannot 
> calculate the address of a per cpu area and then increment without 
> disabling preemption. The process may have been moved to another processor 
> between those two operations and will then increment the event counter of 
> the former processor (which in turn may at the same time increment the 
> same counter). The inc is not atomic in the sense that it syncs multiple 
> processors. So we will have the race back.

True - i forgot that race.
 
> The increment must occur directly through the atomic-vs-interrupt dec/inc 
> on the local per cpu area *without* any use of *_smp_processor_id().
> 
> As far as I can see x86_64 does the right thing and it increments on the 
> local per cpu area. The definition of __get_cpu_var is:


> 
> #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))

It is also affected by your race. The inc would only be atomic if the counter
was in the PDA, but standard per cpu data isn't. So it has to follow 
a pointer and then it could already have switched.

[I think Ingo stated this earlier, but I didn't get -- sorry]

Fix would be to disable preemption. I don't think it needs cli/sti
on non preemptible kernels.

> i386 uses the asm-generic/percpu.h but provides its own 
> implementation of local.t. That simply cannot work. i386
> must provide a definition of __get_per_var that increments directly 
> on the variable in the local per cpu area.
> 
> The definition for __get_cpu_var in asm-generic/percpu.h is:
> 
> #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
> 
> This breaks the cpu_* operations for local.t on i386.
> 
> Also we have various forms of __raw_get_cpu_var() around. Is there any 
> reason for their existence. The presence of these shows the assumption 
> that one can determine the current processor id and then index into an 
> array of per cpu areas. That is not possible with preemption enabled.
> 
> In the absence of a race free __get_cpu_var() i386 would need to fall 
> back to atomic ops by using asm-generic/local.t.

Or just disable preemption?

-Andi
