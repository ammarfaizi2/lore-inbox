Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262000AbTCHCOG>; Fri, 7 Mar 2003 21:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262005AbTCHCOG>; Fri, 7 Mar 2003 21:14:06 -0500
Received: from packet.digeo.com ([12.110.80.53]:9892 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262000AbTCHCOE>;
	Fri, 7 Mar 2003 21:14:04 -0500
Date: Fri, 7 Mar 2003 18:24:47 -0800
From: Andrew Morton <akpm@digeo.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: Oops: 2.5.64 check_obj_poison for 'size-64'
Message-Id: <20030307182447.59cc83ea.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.50.0303072007190.1339-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303062358130.17080-100000@montezuma.mastecende.com>
	<20030306222328.14b5929c.akpm@digeo.com>
	<Pine.LNX.4.50.0303070221470.18716-100000@montezuma.mastecende.com>
	<20030306233517.68c922f9.akpm@digeo.com>
	<Pine.LNX.4.50.0303070351060.18716-100000@montezuma.mastecende.com>
	<20030307010539.3c0a14a3.akpm@digeo.com>
	<3E68F552.1010807@colorfullife.com>
	<Pine.LNX.4.50.0303071656160.18716-100000@montezuma.mastecende.com>
	<Pine.LNX.4.50.0303072007190.1339-100000@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Mar 2003 02:24:34.0348 (UTC) FILETIME=[DBBF36C0:01C2E519]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> Just triggered an oops, looks like debris from something else though. 
> still no slab debug messages.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000001
>  printing eip:
> c01da9a6
> *pde = 245f2001
> *pte = 00000000
> Oops: 0002
> CPU:    1
> EIP:    0060:[<c01da9a6>]    Not tainted
> EFLAGS: 00010246
> EIP is at number+0x1b6/0x2c0
> eax: 00000004   ebx: 00000000   ecx: 00000000   edx: 00000006
> esi: 00000000   edi: 00000001   ebp: 00000003   esp: e390be24
> ds: 007b   es: 007b   ss: 0068
> Process sadc (pid: 1205, threadinfo=e390a000 task=e3d398e0)
> Stack: 00000000 e390be38 00000006 c02ae560 2000002c 31323335 c0143333 
> e59ff060 
>        e59cfbfc 00000779 c0135fd6 e390be50 e390be50 c3a82a9c 00000001 00000000 
>        e390a000 c0128640 00000000 c03b4444 c03b4444 00000001 c034fa08 ffffffdd 
> Call Trace:
>  [<c0143333>] cache_grow+0x2e3/0x360
>  [<c0135fd6>] rcu_process_callbacks+0x1a6/0x1c0
>  [<c0128640>] tasklet_action+0x80/0xd0
>  [<c01dad52>] vsnprintf+0x2a2/0x430
>  [<c01796a9>] seq_printf+0x29/0x50
>  [<c010cc38>] show_interrupts+0x298/0x2f0
>  [<c0179148>] seq_read+0x108/0x2c0
>  [<c01593b8>] vfs_read+0xa8/0x160
>  [<c01596aa>] sys_read+0x2a/0x40
>  [<c010ad9b>] syscall_call+0x7/0xb
> 

Looks to me like you overran the page for seq_printf, which then returned -1
which then triggered what appears to be some utterly bogus code in
show_interrupts():

        for (j = 0; j < NR_CPUS; j++)
                if (cpu_online(j))
                        p += seq_printf(p, "%10u ", irq_stat[j].apic_timer_irqs);

Why is it modifying `p' there?  That's the pointer to the seq_file which
we're using.

Kill.  Two instances.


