Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLKSih>; Mon, 11 Dec 2000 13:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQLKSi2>; Mon, 11 Dec 2000 13:38:28 -0500
Received: from cambot.suite224.net ([209.176.64.2]:25359 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S129228AbQLKSiP>;
	Mon, 11 Dec 2000 13:38:15 -0500
Message-ID: <005c01c0639d$d03abea0$9f42b0d1@pittscomp.com>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: <Heiko.Carstens@de.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <C12569B2.004D4100.00@d12mta01.de.ibm.com>
Subject: Re: CPU attachent and detachment in a running Linux system
Date: Mon, 11 Dec 2000 13:11:11 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko,
If I'm not mistaken, this sort of thing has been done by the beowulf folks.

Matthew D. Pitts
mpitts@suite224.net

----- Original Message ----- 
From: <Heiko.Carstens@de.ibm.com>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, December 11, 2000 9:03 AM
Subject: CPU attachent and detachment in a running Linux system






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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
