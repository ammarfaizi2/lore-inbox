Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262823AbVAKVUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbVAKVUA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVAKVT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:19:59 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:2862 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S262827AbVAKVRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:17:07 -0500
Date: Tue, 11 Jan 2005 15:16:56 -0600
From: DHollenbeck <dick@softplc.com>
Subject: Re: yenta_socket rapid fires interrupts
In-reply-to: <Pine.LNX.4.58.0501111143370.2373@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       magnus.damm@gmail.com
Message-id: <41E44248.2000500@softplc.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
References: <41E2BC77.2090509@softplc.com>
 <Pine.LNX.4.58.0501101857330.2373@ppc970.osdl.org>
 <41E42691.3060102@softplc.com>
 <Pine.LNX.4.58.0501111143370.2373@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>Can you add a "printk()" to "yenta_events()" that shows the value of both 
>"csc" and "cb_event", and additionally shows CB_STATUS. Something like 
>the appended (and totally untested) patch..
>
>It's going to be very noisy when the problem happens (you'll see 10000 
>lines scroll by very quickly), but it would be good to see what the last 
>lines were. Just to see if some event/state seems stuck..
>
>		Linus
>
>===== drivers/pcmcia/yenta_socket.c 1.65 vs edited =====
>--- 1.65/drivers/pcmcia/yenta_socket.c	2004-12-01 00:14:04 -08:00
>+++ edited/drivers/pcmcia/yenta_socket.c	2005-01-11 11:52:10 -08:00
>@@ -401,7 +401,7 @@
> static unsigned int yenta_events(struct yenta_socket *socket)
> {
> 	u8 csc;
>-	u32 cb_event;
>+	u32 cb_event, cb_state;
> 	unsigned int events;
> 
> 	/* Clear interrupt status for the event */
>@@ -409,6 +409,9 @@
> 	cb_writel(socket, CB_SOCKET_EVENT, cb_event);
> 
> 	csc = exca_readb(socket, I365_CSC);
>+
>+	cb_state = cb_readl(socket, CB_SOCKET_STATE);
>+	printk("yenta: event %08x state %08x csc %02x\n", cb_event, cb_state, csc);
> 
> 	events = (cb_event & (CB_CD1EVENT | CB_CD2EVENT)) ? SS_DETECT : 0 ;
> 	events |= (csc & I365_CSC_DETECT) ? SS_DETECT : 0;
>
>  
>

TI 1520 data sheet URL:   http://www-s.ti.com/sc/ds/pci1520.pdf

output from printk:

only the last several lines were caught.  There is toggling between two 
states, the very first state was not captured.
:
:
yenta: event 00000000 state 30000006 csc 00
yenta: event 00000000 state 30000829 csc 00
yenta: event 00000000 state 30000006 csc 00
yenta: event 00000000 state 30000829 csc 00
yenta: event 00000000 state 30000006 csc 00
yenta: event 00000000 state 30000829 csc 00
yenta: event 00000000 state 30000006 csc 00
yenta: event 00000000 state 30000829 csc 00
:
:
:
yenta: event 00000000 state 30000006 csc 00
yenta: event 00000000 state 30000829 csc 00
yenta: event 00000000 state 30000006 csc 00
yenta: event 00000000 state 30000829 csc 00
yenta: event 00000000 state 30000006 csc 00
yenta: event 00000000 state 30000829 csc 00
yenta: event 00000000 state 30000006 csc 00
yenta: event 00000000 state 30000829 csc 00
yenta: event 00000000 state 30000006 csc 00
yenta: event 00000000 state 30000829 csc 00
yenta: event 00000000 state 30000006 csc 00
yenta: event 00000000 state 30000829 csc 00
yenta: event 00000000 state 30000006 csc 00
yenta: event 00000000 state 30000829 csc 00
yenta: event 00000000 state 30000006 csc 00
yenta: event 00000000 state 30000829 csc 00
yenta: event 00000000 state 30000006 csc 00
yenta: event 00000000 state 30000829 csc 00
irq 11: nobody cared (try booting with the "irqpoll" option.
 [<c012b752>] __report_bad_irq+0x22/0x90
 [<c012b868>] note_interrupt+0x78/0xc0
 [<c012b11d>] __do_IRQ+0x13d/0x160
 [<c0104aba>] do_IRQ+0x1a/0x30
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c012af99>] handle_IRQ_event+0x29/0x70
 [<c012b0b1>] __do_IRQ+0xd1/0x160
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
[<c2838950>] (yenta_interrupt+0x0/0x40 [yenta_socket])
[<c2838950>] (yenta_interrupt+0x0/0x40 [yenta_socket])
Disabling IRQ #11

I can read bits in a datasheet, but their meaning in the context of this 
driver is better interpreted by somebody with more PCMCIA experience 
than me.  Thanks for your help!


