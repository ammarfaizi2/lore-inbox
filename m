Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161857AbWI2Ttq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161857AbWI2Ttq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161862AbWI2Ttp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:49:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62366 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161857AbWI2Tto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:49:44 -0400
Date: Fri, 29 Sep 2006 12:45:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm2 - oops in cache_alloc_refill()
Message-Id: <20060929124558.33ef6c75.akpm@osdl.org>
In-Reply-To: <200609291519.k8TFJfvw004256@turing-police.cc.vt.edu>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	<200609290319.k8T3JOwS005455@turing-police.cc.vt.edu>
	<20060928202931.dc324339.akpm@osdl.org>
	<200609291519.k8TFJfvw004256@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 11:19:41 -0400
Valdis.Kletnieks@vt.edu wrote:

> On Thu, 28 Sep 2006 20:29:31 PDT, Andrew Morton said:
> 
> > bisecting would be good, thanks.  It might be quicker to strip down the .config
> > though.
> 
> Well, I started with a clean 2.6.18 tree, and did a 'quilt push origin.patch'
> to put just the stuff already in Linus's tree on.  Unfortunately, *that*
> dies a *different* horrid death after 2 to 5 minutes or so of uptime (and
> this one is also a locked-up-hard power-cycle hang, no alt-sysrq).  Of the
> 3 or 4 times I triggered it, it managed to scribble the oops down into
> syslog before totally wedging:
> 
> BUG: unable to handle kernel paging request at virtual address 00100104
> printing eip:
> c014c8b3
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT
> Modules linked in: xt_SECMARK xt_CONNSECMARK ip6table_mangle iptable_mangle nf_conntrack_ftp xt_pkttype ipt_REJECT nf_conntrack_ipv4 ipt_LOG iptable_filter ip_tables xt_tcpudp nf_conntrack_ipv6 xt_state nf_conntrack ip6t_LOG xt_limit ip6table_filter ip6_tables x_tables thermal processor fan button battery ac nfnetlink i8k floppy nvram orinoco_cs orinoco hermes pcmcia firmware_class ohci1394 intel_agp ieee1394 agpgart yenta_socket rsrc_nonstatic pcmcia_core rtc
> CPU:    0
> EIP:    0060:[<c014c8b3>]    Not tainted VLI
> EFLAGS: 00010083   (2.6.18-test #1)
> EIP is at drain_freelist+0x45/0x9b
> eax: 00200200   ebx: e5ce0540   ecx: effe10c0   edx: 00100100
> esi: effdf4c0   edi: 00000001   ebp: effd2f54   esp: effd2f40
> ds: 007b   es: 007b   ss: 0068
> Process events/0 (pid: 3, ti=effd2000 task=c56cf000 task.ti=effd2000)
> Stack: 00000002 effe18c0 effdf4c0 effe18c0 efe006c0 effd2f64 c014d8ea 00000296
> c053df60 effd2f80 c0120f91 c014d864 00000000 efe006d0 efe006c0 efe006c8
> effd2fc4 c01214d6 00000001 00000000 00000001 00010000 00000000 00000000
> Call Trace:
> [<c014d8ea>] cache_reap+0x86/0xc4
> [<c0120f91>] run_workqueue+0x8f/0xe0
> [<c01214d6>] worker_thread+0xe1/0x113
> [<c0123861>] kthread+0xb0/0xdf
> [<c0103813>] kernel_thread_helper+0x7/0x10
> DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
> 
> Leftover inexact backtrace:
> 
> [<c0103c4d>] show_trace_log_lvl+0x12/0x25
> [<c0103cec>] show_stack_log_lvl+0x8c/0x97
> [<c0103e18>] show_registers+0x121/0x1b2
> [<c0104041>] die+0x198/0x273
> [<c034fce1>] do_page_fault+0x3f5/0x4c2
> [<c034e819>] error_code+0x39/0x40
> [<c014d8ea>] cache_reap+0x86/0xc4
> [<c0120f91>] run_workqueue+0x8f/0xe0
> [<c01214d6>] worker_thread+0xe1/0x113
> [<c0123861>] kthread+0xb0/0xdf
> [<c0103813>] kernel_thread_helper+0x7/0x10
> =======================
> Code: f0 ff ff ff 40 14 8b 5e 14 39 d3 75 19 fb 89 e0 25 00 f0 ff ff ff 48 14 8b 40 08 a8 08 74 59 e8 99 04 20 00 eb 52 8b 13 8b 43 04 <89> 42 04 89 10 c7 03 00 01 10 00 c7 43 04 00 02 20 00 8b 46 18
> EIP: [<c014c8b3>] drain_freelist+0x45/0x9b SS:ESP 0068:effd2f40
> <6>note: events/0[3] exited with preempt_count 1
> 
> Now the question arises - is this the same bug I was seeing under the full -mm2,
> and all the other patches just move the manifestation around, or is this fixed
> by another -mm2 patch, and my original bug report is something else?

I'd expect it's the same bug - slab data structures have gone bad.

> I may have to learn how to use 'git bisect' to shoot this one, it appears.

That's one way.

Again: how come nobody else is hitting this?  Something's different.

What device drivers are being used?

