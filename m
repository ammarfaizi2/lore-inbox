Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267221AbTAPUJy>; Thu, 16 Jan 2003 15:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267222AbTAPUJy>; Thu, 16 Jan 2003 15:09:54 -0500
Received: from packet.digeo.com ([12.110.80.53]:49364 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267221AbTAPUJx>;
	Thu, 16 Jan 2003 15:09:53 -0500
Date: Thu, 16 Jan 2003 12:18:37 -0800
From: Andrew Morton <akpm@digeo.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Make prof_counter use per-cpu areas patch 1/4 -- x86
 arch
Message-Id: <20030116121837.19846346.akpm@digeo.com>
In-Reply-To: <20030116120608.GD13013@in.ibm.com>
References: <20030113122835.GC2714@in.ibm.com>
	<200301131210.47318.akpm@digeo.com>
	<20030116120608.GD13013@in.ibm.com>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jan 2003 20:18:44.0072 (UTC) FILETIME=[77B56680:01C2BD9C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:
>
> Even cpu_possible does not seem to be setup this early.  Seems like 
> reinitialisation of prof_counter/prof_multiplier et al is redundant.
> Here's a newer patch which removes this initialisation at smp_boot_cpus.
> Works fine for me (tested same on a 4 way with difft profiling multipliers..
> LOC interrupts seem to fire at the right intervals).

Things still look a bit fishy to me.

In apic.c:

	int prof_multiplier[NR_CPUS] = { 1, };
	int prof_old_multiplier[NR_CPUS] = { 1, };
	DEFINE_PER_CPU(int, prof_counter) = 1;

This means that all the prof_counter values are set to 1, but the multiplier
arrays have 1 in the zeroeth entry, and zero in the remaining entries.

The zero multipliers remain in place until someone runs
setup_profiling_timer().

One approach would be to initialise all members:

	int prof_multiplier[NR_CPUS] = { [ 0 ... NR_CPUS-1 ] = 1 };

But I think it would be better to put the multipliers into per-cpu memory as
well.  Something like:

struct profiling_info {
	int multiplier;
	int old_multiplier;
	int counter;
};

DEFINE_PER_CPU(struct profiling_info, profiling_info) = {1, 1, 1};

Perhaps?

Also bits and pieces of the profiling code seem to be randomly splattered all
over the place.  Consolidating it all into the one .c file would be nice.


