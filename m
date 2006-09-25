Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWIYUPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWIYUPf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWIYUPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:15:34 -0400
Received: from 17.sub-70-199-97.myvzw.com ([70.199.97.17]:53407 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1751083AbWIYUP0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:15:26 -0400
Message-Id: <20060925184540.601971833@goop.org>
User-Agent: quilt/0.45-1
Date: Mon, 25 Sep 2006 11:45:40 -0700
From: jeremy@goop.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Per-processor private data areas for i386
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Changes since previous post:
  - roll a new set of patches with all updates, based on 2.6.18-mm1 ]

Implement per-processor data areas for i386.

This patch implements per-processor data areas by using %gs as the
base segment of the per-processor memory.  This has two principle
advantages:

- It allows very simple direct access to per-processor data by
  effectively using an effective address of the form %gs:offset, where
  offset is the offset into struct i386_pda.  These sequences are faster
  and smaller than the current mechanism using current_thread_info().

- It also allows per-CPU data to be allocated as each CPU is brought
  up, rather than statically allocating it based on the maximum number
  of CPUs which could be brought up.

Performance:

I've done some simple performance tests on an Intel Core Duo running
at 1GHz (to emphisize any performance delta).  The results for the
lmbench null syscall latency test, which should show the most negative
effect from this change, show a ~9ns decline (.237uS -> .245uS).
This corresponds to around 9 CPU cycles, and correlates well with
the addition of the push/load/pop %gs into the hot path.

I have not yet measured the effect on other typees of processor or
more complex syscalls (though I would expect the push/pop overhead
would be drowned by longer times spent in the kernel, and mitigated by
actual use of the PDA).

The size improvements on the kernel text are nice as well: 
    2889361 -> 2883936 = 5425 bytes saved


Some background for people unfamiliar with x86 segmentation:

This uses the x86 segmentation stuff in a way similar to NPTL's way of
implementing Thread-Local Storage.  It relies on the fact that each CPU
has its own Global Descriptor Table (GDT), which is basically an array
of base-length pairs (with some extra stuff).  When a segment register
is loaded with a descriptor (approximately, an index in the GDT), and
you use that segment register for memory access, the address has the
base added to it, and the resulting address is used.

In other words, if you imagine the GDT containing an entry:
	Index	Offset
	123:	0xc0211000 (allocated PDA)
and you load %gs with this selector:
	mov $123, %gs
and then use GS later on:
	mov %gs:4, %eax
This has the effect of
	mov 0xc0211004, %eax
and because the GDT is per-CPU, the offset (= 0xc0211000 = memory
allocated for this CPU's PDA) can be a CPU-specific value while leaving
everything else constant.

This means that something like "current" or "smp_processor_id()" can
collapse to a single instruction:
	mov %gs:PDA_current, %reg
--

