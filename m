Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933608AbWKQN1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933608AbWKQN1p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 08:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933607AbWKQN1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 08:27:45 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:9704 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933608AbWKQN1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 08:27:43 -0500
Date: Fri, 17 Nov 2006 14:26:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>,
       Wolfgang Erig <Wolfgang.Erig@fujitsu-siemens.com>,
       Andreas Friedrich <andreas.friedrich@fujitsu-siemens.com>,
       Adrian Bunk <bunk@stusta.de>, Greg Kroah-Hartman <gregkh@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [patch] i386/x86_64: ACPI cpu_idle_wait() fix
Message-ID: <20061117132618.GA14411@elte.hu>
References: <20061116110558.GB14245@elte.hu> <20061116122820.GA2718@upset.pdb.fsc.net> <20061116123335.GA1392@elte.hu> <20061116124132.GA9048@upset.pdb.fsc.net> <20061116131842.GA12961@elte.hu> <20061116133019.GA14546@upset.pdb.fsc.net> <20061116144356.GA4891@elte.hu> <20061117090356.GA26013@upset.pdb.fsc.net> <20061117112237.GA26270@elte.hu> <20061117124913.GA24893@upset.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117124913.GA24893@upset.pdb.fsc.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -3.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.7 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_40 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.1 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
	[score: 0.2424]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] i386/x86_64: ACPI cpu_idle_wait() fix
From: Ingo Molnar <mingo@elte.hu>

The scheduler on Andreas Friedrich's hyperthreading system
stopped working properly as of 2.6.18: the scheduler would
never move tasks to another CPU!

after a couple of attempts to corner the bug, the following
smoking gun was found:

BIOS reported wrong ACPI idfor the processor
CPU#1: set_cpus_allowed(), swapper:1, 3 -> 2
 [<c0103bbe>] show_trace_log_lvl+0x34/0x4a
 [<c0103ceb>] show_trace+0x2c/0x2e
 [<c01045f8>] dump_stack+0x2b/0x2d
 [<c0116a77>] set_cpus_allowed+0x52/0xec
 [<c0101d86>] cpu_idle_wait+0x2e/0x100
 [<c0259c57>] acpi_processor_power_exit+0x45/0x58
 [<c0259752>] acpi_processor_remove+0x46/0xea
 [<c025c6fb>] acpi_start_single_object+0x47/0x54
 [<c025cee5>] acpi_bus_register_driver+0xa4/0xd3
 [<c04ab2d7>] acpi_processor_init+0x57/0x77
 [<c01004d7>] init+0x146/0x2fd
 [<c0103a87>] kernel_thread_helper+0x7/0x10

a quick look at cpu_idle_wait() shows how broken that code is
on i386: it changes the init task's affinity map but never
restores it ...

and because all userspace tasks get forked by init, they all
inherited that single-CPU affinity mask. x86_64 cloned this
bug too.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/kernel/process.c   |    4 +++-
 arch/x86_64/kernel/process.c |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

Index: linux/arch/i386/kernel/process.c
===================================================================
--- linux.orig/arch/i386/kernel/process.c
+++ linux/arch/i386/kernel/process.c
@@ -205,7 +205,7 @@ void cpu_idle(void)
 void cpu_idle_wait(void)
 {
 	unsigned int cpu, this_cpu = get_cpu();
-	cpumask_t map;
+	cpumask_t map, tmp = current->cpus_allowed;
 
 	set_cpus_allowed(current, cpumask_of_cpu(this_cpu));
 	put_cpu();
@@ -227,6 +227,8 @@ void cpu_idle_wait(void)
 		}
 		cpus_and(map, map, cpu_online_map);
 	} while (!cpus_empty(map));
+
+	set_cpus_allowed(current, tmp);
 }
 EXPORT_SYMBOL_GPL(cpu_idle_wait);
 
Index: linux/arch/x86_64/kernel/process.c
===================================================================
--- linux.orig/arch/x86_64/kernel/process.c
+++ linux/arch/x86_64/kernel/process.c
@@ -144,7 +144,7 @@ static void poll_idle (void)
 void cpu_idle_wait(void)
 {
 	unsigned int cpu, this_cpu = get_cpu();
-	cpumask_t map;
+	cpumask_t map, tmp = current->cpus_allowed;
 
 	set_cpus_allowed(current, cpumask_of_cpu(this_cpu));
 	put_cpu();
@@ -167,6 +167,8 @@ void cpu_idle_wait(void)
 		}
 		cpus_and(map, map, cpu_online_map);
 	} while (!cpus_empty(map));
+
+	set_cpus_allowed(current, tmp);
 }
 EXPORT_SYMBOL_GPL(cpu_idle_wait);
 
