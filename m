Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129778AbQLKOlP>; Mon, 11 Dec 2000 09:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129730AbQLKOlE>; Mon, 11 Dec 2000 09:41:04 -0500
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:54149 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S129511AbQLKOky> convert rfc822-to-8bit; Mon, 11 Dec 2000 09:40:54 -0500
From: Heiko.Carstens@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: linux-kernel@vger.kernel.org
Message-ID: <C12569B2.004D1644.00@d12mta01.de.ibm.com>
Date: Mon, 11 Dec 2000 15:01:55 +0100
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Recently I had some thoughts on how to realise CPU attachment and
detachment in a running Linux system (based on the 2.4 kernel).

CPU attachment and detachment would make sense on an S/390 when there
are several Linuxes running, each in its own logical partition. This
way a CPU could be taken from one partition and be given to another
partition (e.g. dependent on the current workload) on the fly without
the need to reboot anything.

Now the question is: how can this goal be achieved?

Attachment of a new CPU:

The idea is to synchronize all CPUs and then start the new CPU with a
sigp. To synchronize n CPUs one can create n kernel threads and give
them a high priority to make sure they will be executed soon (e.g. by
setting p->policy to SCHED_RR and p->rt_priority to a very high
value). As soon as all CPUs are in synchronized state (with
interrupts disabled) the new CPU can be started. But before this can
be done there are some other things left to do:
First of all a new cpu_idle task needs to be created for the new CPU.
Unfortunately there are several other parts in the kernel that need
to be updated when a new CPU will be attached to the running system.
For example the slabcache has a per-CPU cache for each of its caches.
This implies that with the arrival of a new CPU for each of these
caches a new per-CPU cache needs to be allocated. This is of course
only one issue in the common part of the kernel that needs to be
addressed.
Considering this maybe it would be a good idea that each part of the
kernel that has per-CPU data structures that need an update should
register a function which will be called before a new CPU will be
attached to the system.
Then the attachment of a new CPU should work the following way:
- synchronize all CPUs via kernel threads
- create a new idle task
- update all parts of the kernel that have per-CPU dependencies with
 the prior registered functions
- and finally start the new CPU (out of one of the kernel threads).


Detachment of a CPU:

Detaching a CPU should work nearly the same way:
- synchronize all CPUs via kernel threads
- stop the selected CPU (out of a kernel thread)
- update all parts of the kernel that have per-CPU dependencies with
 registered functions
- and finally remove the cpu_idle task of the released CPU (and the
 kernel thread which ran on the released CPU until the CPU was
 stopped).

Detaching a CPU is a bit more difficult than attaching a CPU because
one has to think for example of pending tasklets on the to be stopped
CPU. But these could simply be moved to another CPU.

The general question is: what do all of you think of the idea of an
interface where the parts of the kernel that have per-CPU
dependencies should register two functions (one for attaching a CPU
and one for detaching)?

Any comments on this would be appreciated..

Best regards,
Heiko


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
