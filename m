Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVAGGzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVAGGzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 01:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVAGGzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 01:55:31 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:5576 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261281AbVAGGyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 01:54:11 -0500
Subject: Re: SCSI aic7xxx driver: Initialization Failure over a kdump reboot
From: Vivek Goyal <vgoyal@in.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       linux scsi <linux-scsi@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Lukasz Kosewski <lkosewsk@nit.ca>
In-Reply-To: <41DE15C7.6030102@nit.ca>
References: <1105014959.2688.296.camel@2fwv946.in.ibm.com>
	 <1105013524.4468.3.camel@laptopd505.fenrus.org>
	 <20050106195043.4b77c63e.akpm@osdl.org>  <41DE15C7.6030102@nit.ca>
Content-Type: text/plain
Organization: 
Message-Id: <1105083395.2688.382.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jan 2005 13:06:36 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Few questions/observations on this.

1. What can be the reason that a lonely SCSI storage controller will
continuously interrupt the cpu. Little different from network card.

2. In a normal boot, irq 24 is requested for aic7xxx. But over a kdump
boot, it is trying to request for irq 9. I have no idea if it is normal
behavior??

3. I changed following existing code a little to force ahc_reset() and i
get panic.  May be called ahc_reset() at wrong place.

ahc_linux_pci_dev_probe()
{
	.........
	pci_enable_device();
	pci_set_master();
	............
	ahc_pci_config() {
		ahc_reset(ahc, FALSE);	
	}
		
}

I changed FALSE to TRUE, got following panic.

Oops: 0002 [#1]
SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c0257163>]    Not tainted VLI
EFLAGS: 00010246   (2.6.10-rc3-mm1-1M)
EIP is at ahc_chip_init+0x2e6/0xaa8
eax: 00000000   ebx: 00000000   ecx: 0000000f   edx: f880402f
esi: 00000000   edi: 00000000   ebp: f7d61c00   esp: c5211df4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c5210000 task=c51e6a80)
Stack: f7d61c00 00000f00 00000100 00000100 ffffffe8 f7d61c00 000003e7
00000001
       c025616e f7d61c00 00000000 00000000 00000000 f7d61c00 00000000
00000000
       c025dacd f7d61c00 00000001 00000004 00000156 c5211e4f 40d61c00
00000001
Call Trace:
 [<c025616e>] ahc_reset+0x269/0x3df
 [<c025dacd>] ahc_pci_config+0x2a3/0x9f4
 [<c01c78fa>] pci_set_master+0x4b/0x80
 [<c026c82f>] ahc_linux_pci_dev_probe+0x155/0x1af
 [<c01c9070>] pci_device_probe_static+0x52/0x61
 [<c01c90ba>] __pci_device_probe+0x3b/0x4e
 [<c01c90f9>] pci_device_probe+0x2c/0x4a
 [<c01f7657>] driver_probe_device+0x2f/0x6e
 [<c01f777d>] driver_attach+0x56/0x80
 [<c01f7bf7>] bus_add_driver+0x99/0xc7
 [<c01c934b>] pci_register_driver+0x72/0x90
 [<c026c898>] ahc_linux_pci_init+0xf/0x1b
 [<c0264148>] ahc_linux_detect+0x43/0x94
 [<c040fd8c>] ahc_linux_init+0xf/0x23
 [<c03f093d>] do_initcalls+0x28/0xb5
 [<c0411f6c>] sock_init+0x40/0x4d
 [<c01003a6>] init+0xab/0x185
 [<c01002fb>] init+0x0/0x185
 [<c010093d>] kernel_thread_helper+0x5/0xb
Code: 01 09 f0 89 44 24 04 e8 8d 15 00 00 83 fb 3f 7e e8 83 c7 01 83 44
24 0c 1
 <0>Kernel panic - not syncing: Attempted to kill init!


Thanks
Vivek



On Fri, 2005-01-07 at 10:23, Lukasz Kosewski wrote:
> Andrew Morton wrote:
> >> looks like the following is happening:
> >> the controller wants to send an irq (probably from previous life)
> >> then suddenly the driver gets loaded
> >> * which registers an irq handler
> >> * which does pci_enable_device()
> >> and .. the irq goes through. 
> >> the irq handler just is not yet expecting this irq, so
> >> returns "uh dunno not mine"
> >> the kernel then decides to disable the irq on the apic level
> >> and then the driver DOES need an irq during init
> >> ... which never happens.
> >>
> > 
> > 
> > yes, that's exactly what e100 was doing on my laptop last month.  Fixed
> > that by arranging for the NIC to be reset before the call to
> > pci_set_master().
> 
> I noticed the exact same thing with a usb-uhci hub on a VIA MicroATX
> board a month back.  I rewrote the init sequence of the driver so that
> it resets all of the hubs in the system first, and THEN registers their
> interrupts.
> 
> This seems like a problem that CAN happen with level-triggered
> interrupts.  Us fixing it in individual drivers is not the solution; we
> need a general solution.
> 
> I have an idea of something I might do for 2.6.11, but I doubt anyone
> will actually agree with it.  Say we keep a counter of how many times
> interrupt x has been fired off since the last timer interrupt
> (obviously, a timer interrupt resets the counter).  Then we can pick an
> arbitrary threshold for masking out this interrupt until another device
> actually pines for it.
> 
> Or something.  The point is, we need a general solution to the problem,
> not poking about in every single driver trying to tie it down.
> 
> Luke Kosewski
> Human Cannonball
> Net Integration Technologies
> 

