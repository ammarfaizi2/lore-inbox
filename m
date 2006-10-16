Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbWJPSHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWJPSHp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 14:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbWJPSHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 14:07:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23431 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422660AbWJPSHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 14:07:44 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Yinghai Lu" <yinghai.lu@amd.com>
Cc: "Andi Kleen" <ak@muc.de>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
Subject: Re: Fwd: [PATCH] x86_64: typo in __assign_irq_vector when update pos for vector and offset
References: <86802c440610150029k28957786v3b313e29f1f52c8@mail.gmail.com>
	<86802c440610151221v2217cb67t354e1ccbcee54b6a@mail.gmail.com>
	<86802c440610160826g6b918d9bh65948d49f668e892@mail.gmail.com>
Date: Mon, 16 Oct 2006 12:05:35 -0600
In-Reply-To: <86802c440610160826g6b918d9bh65948d49f668e892@mail.gmail.com>
	(Yinghai Lu's message of "Mon, 16 Oct 2006 08:26:08 -0700")
Message-ID: <m1zmbwb0gg.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Yinghai Lu" <yinghai.lu@amd.com> writes:

> Please check the patch.

It looks good.  I think I was having a bad day when I introduced those thinkos.
I'm a bit distracted at the moment so I don't trust myself to forward
the patch on.  Hopefully later today.

> Also I have a question about TARGET_CPUS in io_apic.c.
>
> for a 16 sockets system with 32 non coherent ht chain. and if every
> chain have 8 irq for devices, the genapic will use physflat. and it
> should use you new added "different cpu can have same vector for
> different irq".  --- in the i8259.c
>
> but the setup_IOAPIC_irqs and arch_setup_ht_irq and arch_setup_msi_irq
> is still using TARGET_CPUS ( it is cpumask_of_cpu(0) for physflat), so
> the assign_irq_vector will not get vector for them, becase cpu 0 does
> not have that much vector to be alllocated. and later
> setup_affinity_xxx_irq can not be used because before irq is not there
> and show on /proc/interrupts.

Yep, that is a bug.  I hadn't realized real systems that exhausted the
number of vectors were quite so close.  That totally explains your
interest.  That is one I/O heavy development system you have YH.

Unless there is a reason not to, TARGET_CPUS should be cpu_online map.
I don't know why it is restricted to a single cpu.  I'm curious how
that would affect the user space irq balancer.

> So I want to
> 1. for arch_setup_ht_irq and arch_setup_msi_irq, we can use the dev it
> takes to get bus and use bus->sysdata to get bus->node mapping that is
> created in fillin_cpumask_to_bus, to get real target_cpus instead of
> cpu0.

That sounds like a very reasonable approach.

> 2. for ioapics, may need to add another array,
> ioapic_node[MAX_IOAPICS], and use ioapic address to get the numa node
> for it. So later can use it to get real targets cpus when need to use
> TARGET_CPUS.

Yes.  Numa affinity for the ioapics seems to make sense.  I don't
think we can count on looking at the address though?  Are your
ioapics pci devices?  If so that would be the easiest way to
deal with this problem.

> Please comments.

So far that is the job of the user space irqbalancer, but I don't see
why the kernel can't setup some reasonable defaults, if we have all of
the information needed.

For 2.6.19 we should be able to get my typos fixed, and probably
the default mask increased so that we are given a choice of something
other than cpu 0.

Beyond that it is going to take some additional working and thinking
and so it probably makes sense to have the code sit in the -mm
or Andi's tree for a while, and let it mature for 2.6.20.

Eric
