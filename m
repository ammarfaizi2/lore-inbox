Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbTLFFkn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 00:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264955AbTLFFkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 00:40:43 -0500
Received: from holomorphy.com ([199.26.172.102]:62933 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264953AbTLFFkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 00:40:41 -0500
Date: Fri, 5 Dec 2003 21:40:31 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Stian Jordet <liste@jordet.nu>
Cc: Nick Piggin <piggin@cyberone.com.au>, Colin Coe <colin@coesta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
Message-ID: <20031206054031.GM8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Stian Jordet <liste@jordet.nu>,
	Nick Piggin <piggin@cyberone.com.au>, Colin Coe <colin@coesta.com>,
	linux-kernel@vger.kernel.org
References: <20031206024251.GG8039@holomorphy.com> <3FD14396.5070205@cyberone.com.au> <20031206030755.GI8039@holomorphy.com> <1070684918.7934.2.camel@chevrolet.hybel> <20031206043757.GJ8039@holomorphy.com> <1070686126.1166.0.camel@chevrolet.hybel> <20031206045409.GK8039@holomorphy.com> <1070686634.1166.3.camel@chevrolet.hybel> <20031206050908.GL8039@holomorphy.com> <1070687655.1166.6.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070687655.1166.6.camel@chevrolet.hybel>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

l?r, 06.12.2003 kl. 06.09 skrev William Lee Irwin III:
>> If you actually manage to get interrupt rates exceeding its thresholds,
>> you should see interrupts migrated, but only dynamically and on-demand,
>> not under light usage.

On Sat, Dec 06, 2003 at 06:14:15AM +0100, Stian Jordet wrote:
> I really don't know the definition of "light usage", but I'm beating the
> aic7xxx and eth0 quite hard at times, without any interrupts being
> migrated. Anyway, thanks :) This haven't been a problem for me so far,
> and I doubt it ever will :)

Okay, this should be fixed. The entire subarch organization is wrong
for this anyway. It needs several axes to vary upon for the APIC-based
subarches:

(a) xAPIC (P-IV) vs. serial APIC (before P-IV)
(b) logical vs. physical IPI's
(c) logical vs. physical IO interrupts
(d) flat logical vs. clustered hierarchical DFR
(e) NMI wakeup vs. INIT wakeup
(f) software vs. hardware interrupt load balancing
(g) locality-dependent vs. locality-independent APIC destinations

The real problem with all this is that it was arranged around minimal
impact code changes instead of adequately describing hardware, and so
it gives rise to numerous corner cases and is generally brittle. Of
course, 2.6 is too frozen to do anything with it now, and ia32 will
likely be largely legacy during the course of 2.7, so the damage will
probably be permanent.

What you've run into is essentially there being no distinction for (a)
or (f) in mach-default, what normal Pee Cees use. There are several
disturbing differences between the two cases which are for the moment
carefully avoided but at the very least raise my eyebrows. For instance,
both the physical broadcast destination and the size of the physical
APIC ID space differ between the two cases. The difference you've been
burned by is the fact that current revisions of xAPIC's have broken
hardware interrupt load balancing, and so singleton fixed destinations
are used with software interrupt balancing instead of lowest priority
destinations with many cpus in them perfectly suitable for P-III's,
which under your light usage pinned all interrupts on cpu 0.


-- wli
