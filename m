Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUARQYh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 11:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUARQYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 11:24:37 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:61339 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S261931AbUARQYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 11:24:34 -0500
Date: Sun, 18 Jan 2004 08:24:15 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: andreas@fjortis.info
Subject: [Bug 1902] New: Kernel panic in drivers/net/fealnx.c	interrupt handler. 
Message-ID: <1214880000.1074443055@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1902

           Summary: Kernel panic in drivers/net/fealnx.c interrupt handler.
    Kernel Version: 2.6.1
            Status: NEW
          Severity: high
             Owner: jgarzik@pobox.com
         Submitter: andreas@fjortis.info


Distribution: Debian Sarge (Testing)
Hardware Environment: Pentium 166MHz, 40mb Ram, Realtek 8139, Surecom (fealnx)
Software Environment: Gateway with NAT and some filtering plus a couple of HTB 
rules to stop bittorrent from eating up all my upstream bandwitdth (which is 
only 1/10 of my downstream).

Problem Description:
My gateway machine running NAT for my workstation has had several kernel panics. 
About one per week. (Although I booted it up just before starting to write this 
and got one before I finished writing it, so it's totally "random".)

I have, with the help from people at #kernelnewbies (specially thanks goes to 
coderock), debugged it and found that the problem is at line 1520 in 
drivers/net/fealnx.c
http://lxr.linux.no/source/drivers/net/fealnx.c?v=2.6.0#L1520
np->cur_tx->skbuff somehow is NULL there.... and get dereferenced in the inlined 
function dev_kfree_skb_irq().
(for the whole story see: http://www.fjortis.info/pub/panic/my-debugging.txt )

I've previously posted information about this to linux-net and linux-kernel.
http://marc.theaimsgroup.com/?l=linux-net&m=107360949210508&w=2
http://www.ussg.iu.edu/hypermail/linux/kernel/0401.1/0281.html


Here's one kernel panic:

EIP: 0060:[<c3834473>] Not tainted
EFLAGS: 00010206
EIP is at intr_handler+0x173/0x390 [fealnx]
eax: 00207aee ebx: 00000000 ecx: c294c040 edx: 00000000
esi: c125ea00 edi: 00000018 ebp: 00000002 esp: c033bf44
ds: 007b es: 007b ss: 0068
Process swapper (pid: 0, threadinfo:c033a000, task: c02ce4c0)

Stack: 00006144 00006134 00006100 00006138 00000001 00000014 c2911620 04000001
       00000000 c033bfb0 c010a091 0000000a c125e800 c033bfb0 0000000a 00000140
       c0339b40 c2911620 c010a320 0000000a c033bfb0 c2911620 c033a000 000a0600

Call Trace:
 [<c010a091>] handle_IRQ_event+0x31/0x60
 [<c010a320>] do_IRQ+0x70/0xe0
 [<c0105000>] _stext+0x0/0x20
 [<c0108c68>] common_interrupt+0x18/0x20
 [<c0106b30>] default_idle+0x0/0x30
 [<c0105000>] _stext+0x0/0x20
 [<c0106b54>] default_idle+0x24/0x30
 [<c0106bc5>] cpu_idle+0x25/0x40
 [<c033c66d>] start_kernel+0x15d/0x190

Code: ff 8a 98 00 00 00 0f 94 c0 84 c0 0f 85 84 01 00 00 8b 86 a8
 <0>Kernel panic: Fatal exception in interrupt
In interupt handler - not syncing


I'm keeping information about this at http://fjortis.info/pub/panic/ so have a 
look there for more panic's and other information.


Steps to reproduce:
Use the fealnx driver and send some traffic over it.... (bittorrent seems to be 
the perfect killer. Atleast it happens here alot when I have a couple of 
torrents running.)


