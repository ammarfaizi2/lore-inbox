Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbTBONdW>; Sat, 15 Feb 2003 08:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbTBONdW>; Sat, 15 Feb 2003 08:33:22 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:15903
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261996AbTBONdV>; Sat, 15 Feb 2003 08:33:21 -0500
Date: Sat, 15 Feb 2003 08:41:41 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] flush_tlb_all is not preempt safe.
In-Reply-To: <Pine.LNX.4.50.0302140612320.3518-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0302150838540.3518-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0302140600050.3518-100000@montezuma.mastecende.com>
 <Pine.LNX.4.50.0302140612320.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2003, Zwane Mwaikambo wrote:

> On Fri, 14 Feb 2003, Zwane Mwaikambo wrote:
> 
> > Hi,
> > 	Considering that smp_call_function isn't allowed to hold a lock 
> > reference and within smp_call_function we lock and unlock call_lock thus 
> > triggering a preempt point. Therefore we can't guarantee that we'll be on 
> > the same processor when we hit do_flush_tlb_all_local.
> > 
> > void flush_tlb_all(void)
> > {
> > 	preempt_disable();
> > 	smp_call_function (flush_tlb_all_ipi,0,1,1);
> > 
> > 	do_flush_tlb_all_local();
> > 	preempt_enable();
> > }
> 
> Of course i had to go and paste the code i was working on. The original 
> isn't wrapped in preempt_disable/enable.
> 
> 	Zwane (who really needs to get to bed now)

void flush_tlb_all(void)
{
	BUG_ON(preempt_count() == 0);
	smp_call_function (flush_tlb_all_ipi,0,1,1);

	do_flush_tlb_all_local();
}


------------[ cut here ]------------
kernel BUG at arch/i386/kernel/smp.c:455!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c01166d8>]    Not tainted
EFLAGS: 00000246
EIP is at flush_tlb_all+0x88/0xa0
eax: 00000000   ebx: c1552000   ecx: 00040000   edx: 00040000
esi: c1bf7ec4   edi: 00000001   ebp: c1553f6c   esp: c1553f68
ds: 007b   es: 007b   ss: 0068
Process swapoff (pid: 1936, threadinfo=c1552000 task=c143ad40)
Stack: c2811000 c1553f84 c015427b c1bf7ec4 00000000 c2811000 c059a4e0 c1553f94
       c015430e c2811000 00000001 c1553fbc c0156b06 c2811000 c1552000 ffffffff
       c1ad0a34 c1bfb2e4 bfffff1a bfffff18 080493eb c1552000 c0109957 bfffff1a
Call Trace:
 [<c015427b>] __vunmap+0x2b/0xa0
 [<c015430e>] vfree+0x1e/0x30
 [<c0156b06>] sys_swapoff+0x3c6/0x4d0
 [<c0109957>] syscall_call+0x7/0xb

Code: 0f 0b c7 01 2b f8 43 c0 eb 80 8d b4 26 00 00 00 00 8d bc 27

	Zwane
-- 
function.linuxpower.ca
