Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWC1B2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWC1B2O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 20:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWC1B2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 20:28:14 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:37295 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751201AbWC1B2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 20:28:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=fzqJM2/NQ2+3ann+k29Cyu48TqeC270tHeLFsPwg12udr2NaicM8klc2kzQr3xd69vCJ50PeZgU7Fq9EgRWLwtW5M31QVLE0K50sAYj0DuxJ34wzQz8rjMVfRxPeRXGmy7CoNykMtVISi12JbCNyCGekfoZynUuv7eWfBtVj3aM=  ;
Message-ID: <44288FB3.5030208@yahoo.com.au>
Date: Tue, 28 Mar 2006 12:21:55 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: emin ak <eminak71@gmail.com>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.16-rt10 crash on ppc
References: <2cf1ee820603270656w6697778ai83935217ea5ab3a5@mail.gmail.com> <2cf1ee820603271231l69187925j3150098097c7ca15@mail.gmail.com>
In-Reply-To: <2cf1ee820603271231l69187925j3150098097c7ca15@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

emin ak wrote:

>Dear all,
>Today I have tried Ingo Molnar's patch-2.6.16-rt10 on a ppc (PQ3 MPC8540ADS)
>For testing purpose I have enabled packet routing  and send ethernet
>packets over the system with a network test equipment. under light
>load  on ethernet, the system is working fine, but under heavy load,
>firstly console freezes, then the message below prints on the console
>again and again. The system without patch is working fine on light or
>heavy loads. What can be the problem, is there a bug  or am i doing
>something wrong?
>Thanks alot..
>here is the console output
>--------------------------console output-----
>softirq-net-rx/: page allocation failure. order:0, mode:0x20
>Call Trace:
>[C04E3DB0] [C000A60C] show_stack+0x50/0x188 (unreliable)
>[C04E3DE0] [C004C3EC] __alloc_pages+0x1c8/0x2a4
>[C04E3E30] [C0063C90] cache_alloc_refill+0x35c/0x57c
>[C04E3E80] [C0063FA4] __kmalloc+0xf4/0xfc
>[C04E3EB0] [C012D460] __alloc_skb+0x58/0x118
>[C04E3ED0] [C011AF20] gfar_new_skb+0x40/0xd4
>[C04E3EF0] [C011D320] gfar_clean_rx_ring+0x25c/0x634
>[C04E3F30] [C011D72C] gfar_poll+0x34/0x140
>[C04E3F50] [C013364C] net_rx_action+0x94/0x188
>[C04E3F80] [C0026730] ksoftirqd+0x104/0x1b4
>[C04E3FC0] [C003779C] kthread+0xf8/0x100
>[C04E3FF0] [C0004DB8] kernel_thread+0x44/0x60
>Mem-info:
>DMA per-cpu:
>cpu 0 hot: high 90, batch 15 used:0
>cpu 0 cold: high 30, batch 7 used:0
>DMA32 per-cpu: empty
>Normal per-cpu: empty
>HighMem per-cpu: empty
>Free pages:         768kB (0kB HighMem)
>Active:1650 inactive:2036 dirty:0 writeback:0 unstable:0 free:192
>slab:60106 mapped:764 pagetables:29
>DMA free:768kB min:2048kB low:2560kB high:3072kB active:6600kB
>inactive:8144kB present:262144kB pages_scanned:0 all_unreclaimab
>le? no
>lowmem_reserve[]: 0 0 0 0
>

You have plenty of memory that should be reclaimable (active+inactive, 
though
some may be mlocked or otherwise unreclaimable).

What it looks like is that the page reclaim is not able to take place, 
because
all your allocations are coming from interrupt context.

Normally what will happen is that kswapd will be woken up, and ksoftirqd 
will
start throttling (soft) interrupts and kswapd will be allowed to get a 
chance
to run. With the -rt kernel, I guess if your network irq has a higher 
priority
than kswapd, it could prevent it from running completely. (I could be wrong
here).

You might try increasing /proc/sys/vm/min_free_kbytes, or failing that, 
increase
the priority of kswapd to something comparable to or greater than your 
network
interrupt.

I'm not very familiar with the -rt tree, but possibly what should be 
happening,
if interrupts are executed in process context and allowed to schedule, 
is that
their memory allocations should also be allowed to reclaim memory.

OTOH, I guess for a deterministic realtime system, you need to allocate 
fixed
minimum amounts of memory for each element of the system so you never 
run out
like this.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
