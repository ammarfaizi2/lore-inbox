Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbTLFVlX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 16:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbTLFVlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 16:41:23 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:23937
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265252AbTLFVlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 16:41:21 -0500
Date: Sat, 6 Dec 2003 16:40:19 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-HT-2.6.0-test11-A5
In-Reply-To: <392900000.1070737269@[10.10.2.4]>
Message-ID: <Pine.LNX.4.58.0312061601400.1758@montezuma.fsmlabs.com>
References: <20031117021511.GA5682@averell><3FB83790.3060003@cyberone.com.au><20031117141548.GB1770@colin2.muc.de><Pine.LNX.4.56.0311171638140.29083@earth><20031118173607.GA88556@colin2.muc.de><Pine.LNX.4.56.0311181846360.23128@earth><20031118235710.GA10075@colin2.muc.de><3FBAF84B.3050203@cyberone.com.au><501330000.1069443756@flay><3FBF099F.8070403@cyberone.com.au><1010800000.1069532100@[10.10.2.4]><3FC01817.3090705@cyberone.com.au><3FC0A0C2.90800@cyberone.com.au><Pine.LNX.4.56.0311231300290.16152@earth>
 <1027750000.1069604762@[10.10.2.4]> <Pine.LNX.4.58.0312011102540.3323@earth>
 <392900000.1070737269@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Dec 2003, Martin J. Bligh wrote:

>
> > i've uploaded the HT scheduler patch against 2.6.0-test11 to:
> >
> >     redhat.com/~mingo/O(1)-scheduler/sched-HT-2.6.0-test11-A5
>
> Hangs on boot (NUMA-Q) after "Starting migration thread for cpu 0".
> Any ideas what that might be?

Ingo here is a patch to fix compilation on larger NR_CPUS, i have also
appended the oops Martin is probably seeing. Currently debugging it.

Index: linux-2.6.0-test11-ht/kernel/sched.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test11/kernel/sched.c,v
retrieving revision 1.1.1.2
diff -u -p -B -r1.1.1.2 sched.c
--- linux-2.6.0-test11-ht/kernel/sched.c	6 Dec 2003 21:21:07 -0000	1.1.1.2
+++ linux-2.6.0-test11-ht/kernel/sched.c	6 Dec 2003 21:22:30 -0000
@@ -266,7 +266,7 @@ static DEFINE_PER_CPU(struct runqueue, r
 #define migration_queue(cpu)	(&cpu_int(cpu)->migration_queue)

 #if NR_CPUS > 1
-# define task_allowed(p, cpu)	((p)->cpus_allowed & (1UL << (cpu)))
+# define task_allowed(p, cpu)	cpu_isset(cpu, (p)->cpus_allowed)
 #else
 # define task_allowed(p, cpu)	1
 #endif

..... CPU clock speed is 398.0715 MHz.
..... host bus clock speed is 99.0678 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Unable to handle kernel paging request at virtual address f000afae
 printing eip:
c0124608
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0124608>]    Not tainted
EFLAGS: 00010013
EIP is at migration_task+0x158/0x290
eax: 00000001   ebx: c150bbc0   ecx: c150c5e4   edx: f000afae
esi: c1b9ffcc   edi: c1b9e000   ebp: c1b9ffec   esp: c1b9ffc0
ds: 007b   es: 007b   ss: 0068
Process migration/0 (pid: 2, threadinfo=c1b9e000 task=c1bd29b0)
Stack: 00000000 c150bbc0 00000000 c1bbbf9c 00000000 00000063 00000000 00000000
       c01244b0 00000000 00000000 00000000 c0107185 c1bbbf9c 00000000 00000000
Call Trace:
 [<c01244b0>] migration_task+0x0/0x290
 [<c0107185>] kernel_thread_helper+0x5/0x10

Code: 89 02 89 50 04 8b 55 d4 89 12 89 52 04 8b 4d d8 b2 01 81 79

