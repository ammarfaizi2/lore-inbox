Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266387AbUAIAqs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 19:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266374AbUAIAqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 19:46:30 -0500
Received: from 1-1-1-9a.ghn.gbg.bostream.se ([82.182.69.4]:6916 "EHLO
	keff.fjortis.info") by vger.kernel.org with ESMTP id S266312AbUAIApm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 19:45:42 -0500
Date: Fri, 9 Jan 2004 01:38:17 +0100
From: Andreas Henriksson <andreas@fjortis.info>
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org, domen@coderock.org
Subject: 2.6 kernel panic in fealnx ethernet driver.
Message-ID: <20040109003817.GB2384@scream.fjortis.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

(Sorry if you get this twice... I think the first mail got dropped
because it was to big.)


Short version:
##############################################################

I got a bunch of panics in 2.6.0-test11-bk6 and they seemed very similar...
something seemed wrong in the fealnx driver.

I did my best at debugging the oops and with alot of help from #kernelnewbies 
it seemed to be line 1520 in drivers/net/fealnx.c[1]:

	dev_kfree_skb_irq(np->cur_tx->skbuff);

"coderock" had a couple of ideas[2] but I don't really have a clue why the oops
happened here.... anyone?


Notes:

1 -- Line 1520 of drivers/net/fealnx.c:
http://lxr.linux.no/source/drivers/net/fealnx.c?v=2.6.0#L1520

2 -- Whats up with the if/else and all the
	"np->cur_tx = np->cur_tx->next_desc_logical;"-lines just below?

For more info see the long version (or http://fjortis.info/pub/panic/ for any
updates... unless ofcourse it's down because of a kernel panic in fealnx. ;-P)

.. and by the way, both me <andreas at fjortis.info> and
"coderock" <domen at coderock.org> are interested in any suggested solutions
to this problem so please keep us in the CC. :)

oh... and locking in the interrupt handler.. isn't that needed (on SMP)?

-------------------------------------------
##############################################################
-------------------------------------------






Long version:
##############################################################

:exec lspci -vvv | grep -A 12 MYSON

00:12.0 Ethernet controller: MYSON Technology Inc SURECOM EP-320X-S 100/10M Ethernet PCI Adapter
        Subsystem: Surecom Technology: Unknown device 1320
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 6100 [size=256]
        Region 1: Memory at e0000000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [88] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0-,D1+,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-




:read ~/public_html/pub/panic/p166-panic-fealnx-2004-01.txt

Written down by hand.... hardware suspected of causing it but this is the
third very similar panic.... Kernel 2.6.0-test11-bk6

Process swapper (pid: 0, Threadinfo=c0328000 task=c02c2b20)
Stack: 00006134 00006100 00006138 00000001 00000014 c07898c0 04000001
       00000000 c0329f10 c010a5a1 0000000a c127b400 c010a5a1 0000000a 00000140
       c032b40  c07898c0 c010a830 0000000a c0329f10 c07898c0 c28f4c00 00000002

Call Trace:
[<c010a5a1>] handle_IRQ_event+0x31/0x60
[<c010a830>] do_IRQ+0x70/0xe0
[<c0109168>] common_interrupt+0x18/0x20
[<c02220d6>] netif_reqeive_skb+0x146/0x1b0
[<c02221af>] process_backlog+0xef/0x120
[<c02222bf>] net_rx_action+0x5f/0x100
[<c011dbe3>] do_softirq+0x93/0xa0
[<c010a885>] do_IRQ+0xc5/0xe0
[<c0105000>] _stext+0x0/0x20
[<c0109168>] common_interrupt+0x18/0x20
[<c0107030>] default_idle+0x0/0x30
[<c0105000>] _stext+0x0/0x20
[<c0107054>] default_idle+0x24/0x30
[<c01070c5>] cpu_idle+0x25/0x40
[<c032a66d>] start_kernel+0x15d/0x190

Code: ff 8a 98 00 00 00 0f 94 c0 84 c0 0f 85 84 01 00 00 8b 86 a8
<0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

----------------------------------------------------

I got another one... this one was a bit shorter so I could se the top of the
panic.... I notised this:

EIP is at intr_handler+0x173/0x390 [fealnx]

Maybee the fealnx driver is a bit unstable? Or maybee this driver wasn't
correctly converted back during the interrupt-rework in 2.5?

------------------------------------------------------

Got yet another one on the same day!... they have happened about once a week
before.... This one has a bit more information.... (maybee I should use 80x50 to
fit more lines on my monitor)

This one is also written down by hand... so there might be errors..

EIP: 0060:[<c3834473>] Not tainted
EFLAGS: 00010202
EIP is at intr_handler+0x173/0x390 [fealnx]
eax: 0018e86b ebx: 00000000 ecx: c000d040 edx: 00000000
esi: c18e0600 edi: 00000018 ebp: 00000001 esp: c0329f44
ds: 007b es: 007b ss: 0068
Process swapper (pid: 0, threadinfo=c0328000 task=c02c2b20)
Stack: 00006144 00006134 00006100 00006138 00000001 00000014 c1a8b960 04000001
       00000000 c0329fb0 c010a5a1 0000000a c18e0400 c0329fb0 0000000a 00000140
       c0327b40 c1a8b960 c010a830 0000000a c0329fb0 c1a8b960 c0328000 000a0600

Call Trace:
[<c010a5a1>] handle_IRQ_event+0x31/0x60
[<c010a830>] do_IRQ+0x70/0xe0
[<c0105000>] _stext+0x0/0x20
[<c0109168>] common_interrupt+0x18/0x20
[<c0107030>] default_idle+0x0/0x30
[<c0105000>] _stext+0x0/0x20
[<c0107054>] default_idle+0x24/0x30
[<c01070c5>] cpu_idle+0x25/0x40
[<c032a66d>] start_kernel+0x15d/0x190

Code: ff 8a 98 00 00 00 0f 94 c0 84 c0 0f 85 84 01 00 00 8b 86 a8
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing


-------------------------------------------------------




:read ~/public_html/pub/panic/my-debugging.txt

This is my attempt at locating the cause of the oops[1] I've received lately.
-----

My oops read:
EIP is at intr_handler+0x173/0x390 [fealnx]

This made me think that the fealnx network driver was at fault.

"From the Oops decide which register is at fault."[2]

Ok... how the fsck can I do that.... 

I read through urbanmyth.org's slides[3] and got some ideas...

The registers in my dump read:

eax: 0018e86b ebx: 00000000 ecx: c000d040 edx: 00000000
esi: c18e0600 edi: 00000018 ebp: 00000001 esp: c0329f44

So ... my guess it's eighter 'ebx' or 'edx' which is at fault...

I found out that I should use objdump -d on the module and look at the offset
0x173 to the intr_handler function.

intr_handler was at address 1300 (which seemed to be in hex)
so I just added 173 and this is whats at 1473:

1470:   8b 51 14                mov    0x14(%ecx),%edx
1473:   ff 8a 98 00 00 00       decl   0x98(%edx)
1479:   0f 94 c0                sete   %al

So... my guess now is that 'edx' is at fault..

So now I know the assembler instruction (and register) at fault...
Next step is to match the assembler to the C source.... and this is according
to Keith Owens[2] the hardest part... I'll give it a try...

urbanmyth.org says to look for flow control and gave some hints.

mpm in #kernelnewbies told me to look at the two places where -- is used in
the C source... 

There are 3 "dec" calls in the assembler code:

    1473:       ff 8a 98 00 00 00       decl   0x98(%edx)
    1497:       48                      dec    %eax
    1543:       ff 4c 24 14             decl   0x14(%esp,1)

The third one touches the stack-pointer so that was ruled out first...
Now there are 2 left... which must match the two usages of -- in the C source.

The parentesis around %edx in the first one means it's an "indirect reference"
(a pointer?) and the second one accesses a register directly. That made me
guess that "decl 0x98(%edx)" equals "--np->really_tx_count" and
"dec %eax" equals "--boguscnt" ..

so.... we have found it...

            --np->really_tx_count;

now... whats wrong here? :P

23:10 < coderock> fatal: your guess seems wrong, "dec %eax" is that 
                  "--np->really_tx_count" code... just look at =NULL line above 
                  and disassembled code

ok... did I mention I suck? .... at assembler atleast.. ;)

23:22 < coderock> fatal: your oopsing dec is from dev_kfree_skb_irq() "call" in 
                  atomic_dec_and_test()... nicely hidden in inlines :-)

ahh... sneaky inlines.... coderock rocks! :]






(and by the way... shouldn't there be a spinlock in the interrupt handler?)


References:
1 -- http://fjortis.info/pub/panic/p166-panic-fealnx-2004-01.txt
2 -- http://www.ussg.iu.edu/hypermail/linux/kernel/9904.1/0709.html
3 -- http://www.urbanmyth.org/linux/oops/slides.html

---------------------------------------------------




objdump -d fealnx.ko output: 
http://fjortis.info/pub/panic/objdump-d_fealnx.ko.txt

fealnx.ko module binary:
http://fjortis.info/pub/panic/fealnx.ko





read all the way down here? .. :)

Time for a plea.... any chance the 3c59x vlan tagging patch from 
http://www.candelatech.com/~greear/vlan/howto.html can be included any time
 soon?
I've been using it on 2.4.22 for some time now (since 2.4.22 was released) 
and it seems to work without any problems at all....
