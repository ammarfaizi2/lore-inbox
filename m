Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbUDAQ5e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 11:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbUDAQ5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 11:57:34 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:6861 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262967AbUDAQ5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 11:57:21 -0500
Date: Thu, 1 Apr 2004 10:56:43 -0600 (CST)
From: Olof Johansson <olof@austin.ibm.com>
To: manfred@colorfullife.com
cc: torvalds@osdl.org, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <anton@samba.org>
Subject: Oops in get_boot_pages at reboot
Message-ID: <Pine.A41.4.44.0403312015050.29064-100000@forte.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We've started to see Oopses when rebooting some ppc64 systems built with
CONFIG_NUMA after the distribute-early-allocations-across-nodes patch went
in. This happens on the way down at a reboot:

Please stand by while rebooting the system...
md: stopping all md devices.
md: md0 switched to read-only mode.
Oops: Exception in kernel mode, sig: 4 [#1]
SMP NR_CPUS=32 NUMA
NIP: C00000000046D424 XER: 0000000020000000 LR: C0000000000D36CC
REGS: c000000033f8f6b0 TRAP: 0700   Tainted: GF   (2.6.5-rc2-ames)
MSR: 8000000000089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK: c0000000018ff240[1] 'init' THREAD: c000000033f8c000 CPU: 7
GPR00: C0000000000D36CC C000000033F8F930 C000000000605100 00000000000000D0
GPR04: 0000000000000000 C000000033F8FAC0 0000000000000000 0000000000000000
GPR08: C000000033F8FAC0 0000000000001000 C00000003374B680 C000000000603000
GPR12: C0000000078A3BB0 C00000000049E000 0000000000000000 0000000000000400
GPR16: 0000000000000000 0000000000000000 C00000002FEBEB28 C00000002FEBEB18
GPR20: C00000002FEBEB20 C00000002FEBEB08 C00000002FEBEB10 C00000002FEBEB18
GPR24: 000000000000000B 0000000000000000 0000000000000400 C00000003374B680
GPR28: C000000033F8FAC0 C000000033ABFE80 C000000000549008 0000000000000000
NIP [c00000000046d424] .get_boot_pages+0x0/0x1ac
LR [c0000000000d36cc] .__pollwait+0x5c/0x108
Call Trace:
[c0000000000c9984] .pipe_poll+0xc4/0xd0
[c0000000000d3bac] .do_select+0x334/0x400
[c000000000020828] .sys32_select+0x440/0x654
[c000000000020a50] .ppc32_select+0x14/0x28
[c000000000011bdc] .ret_from_syscall_1+0x0/0xa4

So __pollwait() calls __get_free_page(), system_running is 0 so
get_boot_pages is called. Since get_boot_pages is labeled __init, badness
happens.

How about checking against mem_init_done instead of system_running? It
helps against the oops, but there might be some good reason not to do
it. I don't claim to know the intrisic details about the MM. :-)

I'm not sure yet why we don't see this on all kernels at all times. Most
likely seems to be that it's a timing issue with init doing select (it
seems to use it to sleep). Either way, the test of system_running still
seems risky.


Thanks,

Olof

===== mm/page_alloc.c 1.190 vs edited =====
--- 1.190/mm/page_alloc.c	Sat Mar 20 05:56:20 2004
+++ edited/mm/page_alloc.c	Wed Mar 31 18:22:48 2004
@@ -732,9 +732,10 @@
 fastcall unsigned long __get_free_pages(unsigned int gfp_mask, unsigned int order)
 {
 	struct page * page;
-
 #ifdef CONFIG_NUMA
-	if (unlikely(!system_running))
+	extern int mem_init_done;
+
+	if (unlikely(!mem_init_done))
 		return get_boot_pages(gfp_mask, order);
 #endif
 	page = alloc_pages(gfp_mask, order);




