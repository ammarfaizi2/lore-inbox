Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbUCaRXd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 12:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbUCaRUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 12:20:16 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:34995 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id S262213AbUCaRRI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 12:17:08 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: kernel BUG at kernel/timer.c:370!
Date: Wed, 31 Mar 2004 09:16:52 -0800
Message-ID: <0320111483D8B84AAAB437215BBDA526847F70@NAEX01.na.qualcomm.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel BUG at kernel/timer.c:370!
Thread-Index: AcPy1DN2GYH79VZ8ToCXWApgQLhGrgkbSVbQAACdvuA=
From: "Craig, Dave" <dwcraig@qualcomm.com>
To: "Andrew Morton" <akpm@osdl.org>,
       "Rafael D'Halleweyn \(List\)" <list@noduck.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 31 Mar 2004 17:16:53.0102 (UTC) FILETIME=[F60580E0:01C41743]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cascade: c1a1d5e0 != c1a0d5e0
hander=c028ee8d (igmp_ifc_timer_expire+0x0/0x3e)
Call Trace:
 [<c012ca73>] cascade+0x79/0xa1
 [<c028ee8d>] igmp_ifc_timer_expire+0x0/0x3e
 [<c012d0b3>] run_timer_softirq+0x159/0x1c9
 [<c012899d>] do_softirq+0xc9/0xcb
 [<c0119c46>] smp_apic_timer_interrupt+0xd8/0x140
 [<c0108c09>] default_idle+0x0/0x32
 [<c010bab2>] apic_timer_interrupt+0x1a/0x20
 [<c0108c09>] default_idle+0x0/0x32
 [<c0108c36>] default_idle+0x2d/0x32
 [<c0108cb4>] cpu_idle+0x3a/0x43
 [<c0105000>] rest_init+0x0/0x68
 [<c039c89f>] start_kernel+0x1b7/0x209
 [<c039c427>] unknown_bootoption+0x0/0x124

Here is the result.  I am doing a lot of IPv4 multicast.

	Dave

-----Original Message-----
From: Craig, Dave 
Sent: Wednesday, March 31, 2004 9:00 AM
To: 'Andrew Morton'; Rafael D'Halleweyn (List)
Cc: linux-kernel@vger.kernel.org
Subject: RE: kernel BUG at kernel/timer.c:370!

I just observed this failure on two separate systems this morning.  I
added the patch in the hopes that it will provide some useful
information.

	Dave Craig

QUALCOMM Incorporated

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Andrew Morton
Sent: Saturday, February 14, 2004 12:22 AM
To: Rafael D'Halleweyn (List)
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at kernel/timer.c:370!

"Rafael D'Halleweyn (List)" <list@noduck.net> wrote:
>
> I sometimes get the following BUG (transcribed from a digital camera
>  snapshot, so it might contain errors). I did not copy the stack
trace,
>  let me know if you want it.
> 
>  kernel BUG at kernel/timer.c:370!
>  invalid operand: 0000 [#1]
>  CPU:    0
>  EIP:    0060:[<c01284f8>]    Not tainted
>  EFLAGS: 00010003
>  EIP is at cascade+0x50/0x70
>  eax: d0a77724   ebx: d0a77724   ecx: c04aaa28   edx: 0000001c
>  esi: c04aab08   edi: c04aa220   ebp: 0000001c   esp: c0457e9e
>  ds: 007b   es: 007b   ss: 0068
>  Process swapper (pid: 0, threadinfo=c0456000 task=c03d2de0)
>  Stack: ...
>  Call Trace:
>   [<c01289e4>] update_process_times+0x44/0x50
>   [<c0128b3f>] run_timer_softirq+0x12f/0x1c0
>   [<c0124695>] do_softirq+0x95/0xa0
>   [<c010d2fb>] do_IRQ+0xfb/0x130
>   [<c010b5e8>] common_interrupt+0x18/0x20

This could be a hardware problem.  Or it could be a bug basically
anywhere
in the kernel.

Are you using CONFIG_DEBUG_SLAB?

Could you please apply the below patch, wait for the problem to reoccur,
then let us know?

diff -puN kernel/timer.c~a kernel/timer.c
--- 25/kernel/timer.c~a	2004-02-14 00:14:46.000000000 -0800
+++ 25-akpm/kernel/timer.c	2004-02-14 00:20:09.000000000 -0800
@@ -31,6 +31,7 @@
 #include <linux/time.h>
 #include <linux/jiffies.h>
 #include <linux/cpu.h>
+#include <linux/kallsyms.h>
 
 #include <asm/uaccess.h>
 #include <asm/div64.h>
@@ -367,7 +368,15 @@ static int cascade(tvec_base_t *base, tv
 		struct timer_list *tmp;
 
 		tmp = list_entry(curr, struct timer_list, entry);
-		BUG_ON(tmp->base != base);
+		if (tmp->base != base) {
+			printk("%s: %p != %p\n",
+				__FUNCTION__, tmp->base, base);
+			printk("handler=%p", tmp->function);
+			print_symbol(" (%s)", (unsigned
long)tmp->function);
+			printk("\n");
+			dump_stack();
+			tmp->base = base;
+		}
 		curr = curr->next;
 		internal_add_timer(base, tmp);
 	}

_


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


