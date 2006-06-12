Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752141AbWFLShp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbWFLShp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbWFLShp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:37:45 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:997 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1752141AbWFLShp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:37:45 -0400
Date: Mon, 12 Jun 2006 20:37:43 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC -mm] more cpu_relax() places?
Message-ID: <20060612183743.GA28610@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

while reviewing 2.6.17-rc6-mm1, I found some places that might
want to make use of cpu_relax() in order to not block secondary
pipelines while busy-polling (probably especially useful on SMT CPUs):

arch/i386/kernel/smp.c/flush_tlb_others():

        while (!cpus_empty(flush_cpumask))
                /* nothing. lockup detection does not belong here */
                mb();

should probably be made

        while (!cpus_empty(flush_cpumask)) {
		cpu_relax();
                /* nothing. lockup detection does not belong here */
                mb();
	}

(to have memory barrier directly before flush_cpumask is read).


Second,
include/asm-i386/apic.h/apic_wait_icr_idle() does use cpu_relax(),
but the version in asm-x86_64/ NOT!
Is this because there's not much use doing cpu_relax() on SMP non-SMT
machines, and x86_64 are always non-SMT? Or rather because someone
screwed up?


And what about include/asm-i386/acpi.h/__acpi_acquire/release_global_lock()?

static inline int
__acpi_acquire_global_lock (unsigned int *lock)
{
        unsigned int old, new, val;
        do {
                old = *lock;
                new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
                val = cmpxchg(lock, old, new);
        } while (unlikely (val != old));
        return (new < 3) ? -1 : 0;
}

could probably be made

static inline int
__acpi_acquire_global_lock (unsigned int *lock)
{
        unsigned int old, new, val;
        while (1) {
                old = *lock;
                new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
                val = cmpxchg(lock, old, new);
		if (likely(val == old))
			break;
		cpu_relax();
        }
        return (new < 3) ? -1 : 0;
}

Andreas Mohr
