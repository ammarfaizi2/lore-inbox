Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264033AbTCXQ0S>; Mon, 24 Mar 2003 11:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264037AbTCXQ0S>; Mon, 24 Mar 2003 11:26:18 -0500
Received: from [81.80.245.157] ([81.80.245.157]:47561 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id <S264033AbTCXQ0M>;
	Mon, 24 Mar 2003 11:26:12 -0500
Date: Mon, 24 Mar 2003 17:37:44 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Dominik Brodowski <linux@brodo.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pcmcia_bus_type changes cause oops...
Message-ID: <20030324163744.GD32044@hottah.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Dominik Brodowski <linux@brodo.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030324153659.GA32044@hottah.alcove-fr> <20030324162519.GB2194@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324162519.GB2194@brodo.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 05:25:19PM +0100, Dominik Brodowski wrote:

> Hi Stelian,
> 
> Thanks for your bug report. Let me analyze it a bit:
> 
> > ds: no socket drivers loaded!
> 
> ds.o is loaded for the first time, but fails as the yenta-socket driver was 
> not loaded before
> 
> > pcnet_cs: Unknown symbol pcmcia_unregister_driver
> > pcnet_cs: Unknown symbol pcmcia_register_driver
> 
> This is strange. There is an EXPORT_SYMBOL(pcmcia_register_driver) ...
> maybe gets away after a "make clean"... not worriesome, though; as the
> loading continues.

I did a make mrproper before compiling it. I could do it again but
it would take some time. But I agree it is strance.

> > kobject pcmcia: registering. parent: <NULL>, set: bus
> ds.o is loaded for the second time; and pcmcia_bus_type is to be added
> again. Due to a bug in ds.c it didn't get unregistered in the failed loading
> of ds.o - the attached patch should fix it. Could you please try it?

It does something for sure, but not enough to get it work:

------------------8<-------------------------8<----------------
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
subsystem pcmcia_socket: registering
kobject pcmcia_socket: registering. parent: <NULL>, set: class
kobject devices: registering. parent: pcmcia_socket, set: <NULL>
kobject drivers: registering. parent: pcmcia_socket, set: <NULL>
subsystem pcmcia: registering
kobject pcmcia: registering. parent: <NULL>, set: bus
kobject devices: registering. parent: pcmcia, set: <NULL>
kobject drivers: registering. parent: pcmcia, set: <NULL>
ds: no socket drivers loaded!
kobject drivers: unregistering
kobject drivers: cleaning up
kobject devices: unregistering
kobject devices: cleaning up
subsystem pcmcia: unregistering
kobject pcmcia: unregistering
kobject pcmcia: cleaning up
Unable to handle kernel NULL pointer dereference at virtual address 00000068
 printing eip:
c01b8855
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01b8855>]    Not tainted
EFLAGS: 00010202
EIP is at kobject_get+0x15/0x50
eax: c5ca0000   ebx: 00000058   ecx: 00000000   edx: c79a5c94
esi: c79a47b8   edi: c79a5cc0   ebp: c5ca1f00   esp: c5ca1efc
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 603, threadinfo=c5ca0000 task=c6a8c6c0)
Stack: c79a5cb0 c5ca1f10 c01b857e 00000058 c79a5cb0 c5ca1f2c c01b8778 c79a5cb0 
       c79a5d00 c5ca1f2c c021286f c79a5cb0 c5ca1f4c c0212697 c79a5cb0 00000000 
       fffffffc c79a5d00 c02debd8 c02debd8 c5ca1f68 c0212ba1 c79a5c94 00000000 
Call Trace:
 [<c79a5cb0>] pcnet_driver+0x30/0x80 [pcnet_cs]
 [<c01b857e>] kobject_init+0x2e/0x50
 [<c79a5cb0>] pcnet_driver+0x30/0x80 [pcnet_cs]
 [<c01b8778>] kobject_register+0x18/0x70
 [<c79a5cb0>] pcnet_driver+0x30/0x80 [pcnet_cs]
 [<c79a5d00>] +0x0/0x100 [pcnet_cs]
 [<c021286f>] get_bus+0x1f/0x40
 [<c79a5cb0>] pcnet_driver+0x30/0x80 [pcnet_cs]
 [<c0212697>] bus_add_driver+0x57/0xf0
 [<c79a5cb0>] pcnet_driver+0x30/0x80 [pcnet_cs]
 [<c79a5d00>] +0x0/0x100 [pcnet_cs]
 [<c0212ba1>] driver_register+0x31/0x40
 [<c79a5c94>] pcnet_driver+0x14/0x80 [pcnet_cs]
 [<c79a5d00>] +0x0/0x100 [pcnet_cs]
 [<c7951043>] +0x43/0x47 [pcnet_cs]
 [<c79a5c94>] pcnet_driver+0x14/0x80 [pcnet_cs]
 [<c79941c0>] +0x1e0/0x3a0 [pcmcia_core]
 [<c0135c5a>] sys_init_module+0x15a/0x240
 [<c010b25b>] syscall_call+0x7/0xb

Code: 8b 43 10 85 c0 7e 24 ff 43 10 b8 00 e0 ff ff 21 e0 ff 48 14 
 <6>note: modprobe[603] exited with preempt_count 1
kobject cardbus: registering. parent: <NULL>, set: drivers
Yenta IRQ list 0cb8, PCI irq9
Socket status: 30000419
------------------8<-------------------------8<----------------
> 
> It is strange, though, that you nonetheless managed to get it to work with
> "inadvertedly modified" timings...

The bug is probably somewhere else, I guess...

Thanks,

Stelian.

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
