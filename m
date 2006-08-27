Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWH0JZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWH0JZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 05:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWH0JZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 05:25:53 -0400
Received: from 32.sub-70-198-1.myvzw.com ([70.198.1.32]:52418 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1751359AbWH0JZg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 05:25:36 -0400
Message-Id: <20060827084417.918992193@goop.org>
User-Agent: quilt/0.45-1
Date: Sun, 27 Aug 2006 01:44:17 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Zachary Amsden <zach@vmware.com>,
       Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH RFC 0/6] Implement per-processor data areas for i386.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

I haven't measured performance yet, but when using the PDA for "current"
and "smp_processor_id", I see a 5715 byte reduction in .text segment
size for my kernel.

Unfortunately, these patches don't actually work yet.  I'm not sure why;
I'm hoping review will turn something up.


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


TODO: 
- Make it work.  It works UP on a test QEMU machine, but it doesn't
  yet work on real hardware, or SMP (though not working SMP on QEMU is
  more likely to be a QEMU problem).  Not sure what the problem is yet;
  I'm hoping review will reveal something.
- Measure performance impact.  The patch adds a segment register
  save/restore on entry/exit to the kernel.  This expense should be
  offset by savings in using the PDA while in the kernel, but I haven't
  measured this yet.  Space savings are already appealing though.
- Modify more things to use the PDA.  The more that uses it, the more
  the cost of the %gs save/restore is amortized.  smp_processor_id and
  current are the obvious first choices, which are implemented in this
  series.
- Make it a config option?  UP systems don't need to do any of this,
  other than having a single pre-allocated PDA.  Unfortunately, it gets
  a bit messy to do this given the changes needed in handling %gs.
--

