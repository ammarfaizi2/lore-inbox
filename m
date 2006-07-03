Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWGCOUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWGCOUQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 10:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWGCOUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 10:20:16 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:36100 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751185AbWGCOUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 10:20:14 -0400
Message-ID: <44A9275F.9090103@shadowen.org>
Date: Mon, 03 Jul 2006 15:19:11 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Suresh Siddha <suresh.b.siddha@intel.com>
CC: Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-mm5
References: <44A8567B.2010309@mbligh.org> <20060702164113.6dc1cd6c.akpm@osdl.org> <44A8D410.5010001@shadowen.org>
In-Reply-To: <44A8D410.5010001@shadowen.org>
Content-Type: multipart/mixed;
 boundary="------------030209050300090201090809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030209050300090201090809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andy Whitcroft wrote:
> Andrew Morton wrote:
> 
>>On Sun, 02 Jul 2006 16:27:55 -0700
>>"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>>
>>
>>
>>>Panic on NUMA-Q (mm4 was fine). Presumably some new scheduler patch
>>>
>>>divide error: 0000 [#1]
>>>8K_STACKS SMP 
>>>last sysfs file: 
>>>Modules linked in:
>>>CPU:    1
>>>EIP:    0060:[<c0112b6e>]    Not tainted VLI
>>>EFLAGS: 00010046   (2.6.17-mm5-autokern1 #1) 
>>>EIP is at find_busiest_group+0x1a3/0x47c
>>>eax: 00000000   ebx: 00000007   ecx: 00000000   edx: 00000000
>>>esi: 00000000   edi: e75ff264   ebp: e7405ec8   esp: e7405e58
>>>ds: 007b   es: 007b   ss: 0068
>>>Process swapper (pid: 0, ti=e7404000 task=c13f8560 task.ti=e7404000)
>>>Stack: e75ff264 00000010 c0119020 00000000 00000000 00000000 00000000 00000000 
>>>      ffffffff 00000000 00000000 00000001 00000001 00000001 00000080 00000000 
>>>      00000000 00000200 00000020 00000080 00000000 00000000 e75ff260 c1364960 
>>>Call Trace:
>>>[<c0119020>] vprintk+0x5f/0x213
>>>[<c0112efb>] load_balance+0x54/0x1d6
>>>[<c011332d>] rebalance_tick+0xc5/0xe3
>>>[<c01137a3>] scheduler_tick+0x2cb/0x2d3
>>>[<c01215b4>] update_process_times+0x51/0x5d
>>>[<c010c224>] smp_apic_timer_interrupt+0x5a/0x61
>>>[<c0102d5b>] apic_timer_interrupt+0x1f/0x24
>>>[<c01006c0>] default_idle+0x0/0x59
>>>[<c01006f1>] default_idle+0x31/0x59
>>>[<c0100791>] cpu_idle+0x64/0x79
>>>Code: 00 5b 83 f8 1f 89 c6 5f 0f 8e 63 ff ff ff 8b 45 e0 8b 55 e8 01 45 dc 8b 4a 08 89 c2 01 4d d4 c1 e2 07 89 d0 31 d2 89 ce c1 ee 07 <f7> f1 83 7d 9c 00 89 45 e0 74 17 89 45 d8 8b 55 e8 8b 4d a4 8b 
>>>EIP: [<c0112b6e>] find_busiest_group+0x1a3/0x47c SS:ESP 0068:e7405e58
>>
>>
>>Yes, Andy's reporting that too.  I asked him to identify the file-n-line
>>and he ran away on me.
> 
> 
> I went away to debug it, but then had to skip out to a BBQ.  Its
> definatly the cpu_power on the group being zero.
> 
> group->cpu_power ZERO => c3150920
> 
> /me gives Ingo's patch a spin.

Ok.  Thats not fixed it either.

Confirmed that it is caused by the patch below, backing it out sorts things:

    sched-group-cpu-power-setup-cleanup.patch

Did a fair bit of analysis of this problem, and it seems that the issue
is where we initialise the NUMA domains.  For each cpu we initialise a
domain spanning the whole machine, but ordered starting at the node in
which we start.  In the original code we used the following to
initialise each of these groups:

        for (i = 0; i < MAX_NUMNODES; i++)
                init_numa_sched_groups_power(sched_group_nodes[i]);

init_numa_sched_groups_power iterated over all of the groups within the
domain and added up power based on the physical packages.  Now we use:

        for_each_cpu_mask(i, *cpu_map) {
                sd = &per_cpu(node_domains, i);
                init_sched_groups_power(i, sd);
        }

init_sched_groups_power only thinks in terms of the first group of the
domain, which leaves the subsequent groups in the domain at power 0.

I've tried reverting just that part of the change (as attached) and that
also seems to fix things.  However, are we correct in all the other
cases ignoring the subsequent groups?  I am also not sure if this will
change the purpose of the patch?  It seems unlikely but ...

Suresh I guess I'll punt to you :).

-apw

--------------030209050300090201090809
Content-Type: text/plain;
 name="sched-revert-numa-domain-init"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-revert-numa-domain-init"

sched revert numa domain init

Seems that the schedular domains for the NUMA nodea arn't being
initialised correctly.  Their cpu_power is left at 0 leading to
panic in load balancing.  Seem that just reverting this part of
the change below is enough to fix booting of NUMA systems.

   sched-group-cpu-power-setup-cleanup.patch

Not sure if this changes the purpose of that patch.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 sched.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)
diff -upN reference/kernel/sched.c current/kernel/sched.c
--- reference/kernel/sched.c
+++ current/kernel/sched.c
@@ -6656,10 +6656,8 @@ printk(KERN_WARNING "init CPU domains\n"
 
 printk(KERN_WARNING "init NUMA domains\n");
 #ifdef CONFIG_NUMA
-	for_each_cpu_mask(i, *cpu_map) {
-		sd = &per_cpu(node_domains, i);
-		init_sched_groups_power(i, sd);
-	}
+        for (i = 0; i < MAX_NUMNODES; i++)
+		init_numa_sched_groups_power(sched_group_nodes[i]);
 
 	init_numa_sched_groups_power(sched_group_allnodes);
 #endif

--------------030209050300090201090809--
