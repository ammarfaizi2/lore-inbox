Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262894AbVAKWft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbVAKWft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbVAKWfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:35:16 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:34428 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S262882AbVAKWc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:32:58 -0500
Date: Tue, 11 Jan 2005 16:32:48 -0600
From: DHollenbeck <dick@softplc.com>
Subject: Re: yenta_socket rapid fires interrupts
In-reply-to: <Pine.LNX.4.58.0501111340570.2373@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       magnus.damm@gmail.com
Message-id: <41E45410.7070004@softplc.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
References: <41E2BC77.2090509@softplc.com>
 <Pine.LNX.4.58.0501101857330.2373@ppc970.osdl.org>
 <41E42691.3060102@softplc.com>
 <Pine.LNX.4.58.0501111143370.2373@ppc970.osdl.org>
 <41E44738.2050606@softplc.com>
 <Pine.LNX.4.58.0501111340570.2373@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Tue, 11 Jan 2005, DHollenbeck wrote:
>  
>
>>Add to my last post, the information that IRQ 11 is only being used by
>>the two yenta sockets. So the "toggling" is not really toggling, but the
>>printing of the two card sockets which are both on the same IRQ?
>>    
>>
>
>Ahh. Good catch, silly me. No toggling, so you can ignore my last post. 
>There's no cycle going on, and the ports are stable, and the interrupt is 
>coming from somewhere else entirely.
>
>You could still enable debugging, but at that point I'd actually be 
>interested in the _first_ part of the debug output, not the long tail of 
>dead interrupts. You'd need a serial console or netconsole to catch it, 
>I'm afraid.
>
>		Linus
>
>  
>
My modfied, throw away, debug patch:

--- linux/drivers/pcmcia/yenta_socket..orig    2004-12-24 
15:35:00.000000000 -0600
+++ linux/drivers/pcmcia/yenta_socket.c    2005-01-11 16:16:47.000000000 
-0600
@@ -401,7 +401,7 @@
 static unsigned int yenta_events(struct yenta_socket *socket)
 {
     u8 csc;
-    u32 cb_event;
+    u32 cb_event, intctl;
     unsigned int events;
 
     /* Clear interrupt status for the event */
@@ -412,13 +412,31 @@
 
     events = (cb_event & (CB_CD1EVENT | CB_CD2EVENT)) ? SS_DETECT : 0 ;
     events |= (csc & I365_CSC_DETECT) ? SS_DETECT : 0;
-    if (exca_readb(socket, I365_INTCTL) & I365_PC_IOCARD) {
+    if ( (intctl=exca_readb(socket, I365_INTCTL)) & I365_PC_IOCARD) {
         events |= (csc & I365_CSC_STSCHG) ? SS_STSCHG : 0;
     } else {
         events |= (csc & I365_CSC_BVD1) ? SS_BATDEAD : 0;
         events |= (csc & I365_CSC_BVD2) ? SS_BATWARN : 0;
         events |= (csc & I365_CSC_READY) ? SS_READY : 0;
     }
+       
+/* RHH: per Linus */
+#if 1
+        {
+            u32 cb_state;
+           
+            static int intCount = 20;
+           
+            if( intCount > 0 )
+            {
+                --intCount;
+                cb_state = cb_readl(socket, CB_SOCKET_STATE);
+                printk("yenta: event %08x state %08x csc %02x intctl 
%02x events=%08x\n",
+                    cb_event, cb_state, csc, intctl, events );
+            }
+        }
+#endif       
+       
     return events;
 }
 

And the dmesg output.  Please look at intctl.  Is this our unsatisfied 
noise maker?


Linux Kernel Card Services
  options:  [pci] [cardbus]
PCI: Found IRQ 11 for device 0000:00:0d.0
PCI: Sharing IRQ 11 with 0000:00:0d.1
Yenta: CardBus bridge found at 0000:00:0d.0 [0000:0000]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0d.0, mfunc 0x00001022, devctl 0x64
Yenta: ISA IRQ mask 0x00a8, PCI irq 11
Socket status: 30000006
PCI: Found IRQ 11 for device 0000:00:0d.1
PCI: Sharing IRQ 11 with 0000:00:0d.0
Yenta: CardBus bridge found at 0000:00:0d.1 [0000:0000]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0d.1, mfunc 0x00001022, devctl 0x64
yenta: event 00000000 state 30000006 csc 00 intctl 50 events=00000000
Yenta: ISA IRQ mask 0x00a8, PCI irq 11
Socket status: 30000020
yenta: event 00000000 state 30000006 csc 00 intctl 50 events=00000000
yenta: event 00000000 state 30000829 csc 00 intctl 10 events=00000000
yenta: event 00000000 state 30000006 csc 00 intctl 50 events=00000000
yenta: event 00000008 state 30000829 csc 00 intctl 10 events=00000000
yenta: event 00000000 state 30000006 csc 00 intctl 50 events=00000000
yenta: event 00000000 state 30000829 csc 00 intctl 10 events=00000000
yenta: event 00000000 state 30000006 csc 00 intctl 50 events=00000000
yenta: event 00000000 state 30000829 csc 00 intctl 10 events=00000000
yenta: event 00000000 state 30000006 csc 00 intctl 50 events=00000000
yenta: event 00000000 state 30000829 csc 00 intctl 10 events=00000000
yenta: event 00000000 state 30000006 csc 00 intctl 50 events=00000000
yenta: event 00000000 state 30000829 csc 00 intctl 10 events=00000000
yenta: event 00000000 state 30000006 csc 00 intctl 50 events=00000000
yenta: event 00000000 state 30000829 csc 00 intctl 10 events=00000000
yenta: event 00000000 state 30000006 csc 00 intctl 50 events=00000000
yenta: event 00000000 state 30000829 csc 00 intctl 10 events=00000000
yenta: event 00000000 state 30000006 csc 00 intctl 50 events=00000000
yenta: event 00000000 state 30000829 csc 00 intctl 10 events=00000000
yenta: event 00000000 state 30000006 csc 00 intctl 50 events=00000000
irq 11: nobody cared (try booting with the "irqpoll" option.
 [<c012b752>] __report_bad_irq+0x22/0x90
 [<c012b868>] note_interrupt+0x78/0xc0
 [<c012b11d>] __do_IRQ+0x13d/0x160
 [<c0104aba>] do_IRQ+0x1a/0x30
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c012007b>] sys_getresgid+0xb/0xa0
 [<c0117750>] __do_softirq+0x30/0xa0
 [<c0120060>] sys_setresgid+0x120/0x130
 [<c01177f5>] do_softirq+0x35/0x40
 [<c012af65>] irq_exit+0x35/0x40
 [<c0104abf>] do_IRQ+0x1f/0x30
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c01005b0>] default_idle+0x0/0x40
 [<c038007b>] ic_setup_if+0xcb/0xd0
 [<c01005d3>] default_idle+0x23/0x40
 [<c010064c>] cpu_idle+0x1c/0x50
 [<c036873c>] start_kernel+0x13c/0x160
handlers:
[<c2838980>] (yenta_interrupt+0x0/0x40 [yenta_socket])
[<c2838980>] (yenta_interrupt+0x0/0x40 [yenta_socket])
Disabling IRQ #11
root@EMBEDDED[~]#


