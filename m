Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbTEMSVa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbTEMSVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:21:13 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:58752
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262290AbTEMSUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:20:15 -0400
Date: Tue, 13 May 2003 14:23:40 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Alex Riesen <alexander.riesen@synopsys.COM>
cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.5.69+bk: "irq 15: nobody cared!" on a Compaq Armada 1592DT
In-Reply-To: <20030513134907.GF32559@Synopsys.COM>
Message-ID: <Pine.LNX.4.50.0305131020070.5420-100000@montezuma.mastecende.com>
References: <20030513134907.GF32559@Synopsys.COM>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003, Alex Riesen wrote:

> PCI: Found IRQ 15 for device 00:11.0
> irq 15: nobody cared!
> Call Trace:
>  [<c010a8fb>] handle_IRQ_event+0x7b/0xf0
>  [<c010ab39>] do_IRQ+0xa9/0x150
>  [<c01093a8>] common_interrupt+0x18/0x20
>  [<c01a4355>] pci_bus_write_config_word+0x55/0x70
>  [<c6a20f60>] +0x0/0x840 [yenta_socket]
>  [<c6a1eeb1>] yenta_probe_irq+0xb1/0x120 [yenta_socket]
>  [<c6a1ed60>] yenta_interrupt+0x0/0x60 [yenta_socket]
>  [<c6a20f60>] +0x0/0x840 [yenta_socket]
>  [<c6a20f60>] +0x0/0x840 [yenta_socket]
>  [<c6a1ef49>] yenta_get_socket_capabilities+0x29/0x50 [yenta_socket]
>  [<c6a20f60>] +0x0/0x840 [yenta_socket]
>  [<c6a1fa6e>] yenta_open+0x12e/0x180 [yenta_socket]
>  [<c6a20f60>] +0x0/0x840 [yenta_socket]
>  [<c6a20ff4>] +0x94/0x840 [yenta_socket]
>  [<c6a1e316>] add_pci_socket+0xa6/0xe0 [yenta_socket]
>  [<c6a20f60>] +0x0/0x840 [yenta_socket]
>  [<c6a20bc0>] pci_cardbus_driver+0x0/0xa0 [yenta_socket]
>  [<c6a1e391>] cardbus_probe+0x31/0x40 [yenta_socket]
>  [<c6a20e40>] yenta_operations+0x0/0x40 [yenta_socket]
>  [<c01a7555>] pci_device_probe+0x45/0x60
>  [<c6a20b80>] cardbus_table+0x0/0x40 [yenta_socket]
>  [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
>  [<c01cf675>] bus_match+0x35/0x60
>  [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
>  [<c01cf768>] driver_attach+0x58/0x60
>  [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
>  [<c6a20c10>] pci_cardbus_driver+0x50/0xa0 [yenta_socket]
>  [<c01cf9f6>] bus_add_driver+0x96/0xb0
>  [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
>  [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
>  [<c6a20e80>] +0x0/0xe0 [yenta_socket]
>  [<c01cfe1f>] driver_register+0x2f/0x40
>  [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
>  [<c01a765e>] pci_register_driver+0x3e/0x50
>  [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
>  [<c6a1200d>] +0xd/0x11 [yenta_socket]
>  [<c6a20bc0>] pci_cardbus_driver+0x0/0xa0 [yenta_socket]
>  [<c012f015>] sys_init_module+0x135/0x280
>  [<c0109187>] syscall_call+0x7/0xb
> 
> handlers:
> [<c6a1ed60>] (yenta_interrupt+0x0/0x60 [yenta_socket])

Bugger, this is due to yenta_probe_irq.

There really should be 'events' to handle unless... 
Perhaps someone who knows yenta could best comment.

static unsigned int yenta_probe_irq(pci_socket_t *socket, u32 isa_irq_mask)
{
...
        /*
         * Probe for usable interrupts using the force
         * register to generate bogus card status events.
         */
        cb_writel(socket, CB_SOCKET_EVENT, -1);


static unsigned int yenta_events(pci_socket_t *socket)
{
...
        /* Clear interrupt status for the event */
        cb_event = cb_readl(socket, CB_SOCKET_EVENT); <-- cb_event = 0xffffffff?
        cb_writel(socket, CB_SOCKET_EVENT, cb_event);

-- 
function.linuxpower.ca
