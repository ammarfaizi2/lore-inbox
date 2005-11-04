Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVKDT5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVKDT5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 14:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVKDT5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 14:57:12 -0500
Received: from outbound04.telus.net ([199.185.220.223]:59360 "EHLO
	priv-edtnes28.telusplanet.net") by vger.kernel.org with ESMTP
	id S1750713AbVKDT5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 14:57:11 -0500
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Balancing near the locking cliff, with some numbers
Date: Fri, 4 Nov 2005 20:56:59 +0100
User-Agent: KMail/1.8
Cc: dipankar@in.ibm.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511042056.59813.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I recently generated some data on how many locks/semaphores/atomics/memory
barriers simple system calls use. The original idea for this is from Dipankar, 
who did similar things for an older kernel.

I thought some folks might find these numbers interesting.

Making the kernel more scalable requires more locks and atomic counts etc.,
but each lock even when uncontended adds more overhead (on x86 everything
with a LOCK prefix is costly, depending on the CPU). The locking cliff is when
you add some many locks that (a) nobody can understand/debug all
the dependencies anymore and when the basic performance gets worse
and worse due to locking overhead.

Here are some results:

open:
locks: 106 sems: 32 atomics: 50 rwlocks: 30 irqsaves: 89 barriers: 47
read:
locks: 52 sems: 0 atomics: 16 rwlocks: 12 irqsaves: 69 barriers: 11
write:
locks: 38 sems: 4 atomics: 20 rwlocks: 8 irqsaves: 42 barriers: 12
page fault:
locks: 4 sems: 2 atomics: 2 rwlocks: 0 irqsaves: 9 barriers: 0

open: open a file on ext3
read: read a cache cold file from disk
write: write a new file
page fault: fault in an empty page

Notes:
I generated the numbers by running an instrumented SMP kernel
on my P-M laptop. It's not from a real multi processor machine.
The number always count lock and unlock separately.
atomic_t is any atomic_t operation
barriers includes mb/wmb/rmb
irqsaves don't have a lock prefix, but at least one some CPUs they tend to be 
quite slow too.

Summary:
I don't think Linux fell over the locking cliff yet. But it's getting 
dangerously near. Before you add new locking or atomics always think twice
and only add them when there is really a very good reason for it.
Even on MP systems using less locks and atomics can be faster.

-Andi
