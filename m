Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314604AbSDTL2w>; Sat, 20 Apr 2002 07:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314606AbSDTL2w>; Sat, 20 Apr 2002 07:28:52 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:53912 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314604AbSDTL2v>;
	Sat, 20 Apr 2002 07:28:51 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15553.17071.88897.914713@argo.ozlabs.ibm.com>
Date: Sat, 20 Apr 2002 20:27:59 +1000 (EST)
To: linux-kernel@vger.kernel.org
Subject: in_interrupt race
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty made the suggestion to me the other day that it would be
interesting to put some stuff in smp_processor_id() to BUG() if
preemption isn't disabled, and then see where the kernel breaks.  The
idea is that the result of smp_processor_id() is useless if preemption
is enabled, since you could move to another processor before you get
to use the result.

With that in mind, while I was poking around I noticed that
in_interrupt() uses smp_processor_id().  (This is true on all
architectures except ia64, which uses a local_cpu_data pointer
instead, and x86-64, which uses a read_pda function).

Thus if we have CONFIG_SMP and CONFIG_PREEMPT, there is a small but
non-zero probability that in_interrupt() will give the wrong answer if
it is called with preemption enabled.  If the process gets scheduled
from cpu A to cpu B between calling smp_processor_id() and evaluating
local_irq_count(cpu) or local_bh_count(), and cpu A then happens to be
in interrupt context at the point where the process resumes on cpu B,
then in_interrupt() will incorrectly return 1.

One idea I had is to use a couple of bits in
current_thread_info()->flags to indicate whether local_irq_count and
local_bh_count are non-zero for the current cpu.  These bits could be
tested safely without having to disable preemption.

In fact almost all uses of local_irq_count() and local_bh_count() are
for the current cpu; the exceptions are the irqs_running() function
and some debug printks.  Maybe the irq and bh counters themselves
could be put into the thread_info struct, if irqs_running could be
implemented another way.

Paul.
