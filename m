Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267582AbSLMB2w>; Thu, 12 Dec 2002 20:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267585AbSLMB2v>; Thu, 12 Dec 2002 20:28:51 -0500
Received: from dp.samba.org ([66.70.73.150]:61380 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267582AbSLMB2s>;
	Thu, 12 Dec 2002 20:28:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Chua <jchua@fedex.com>, "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@transmeta.com, axboe@suse.de, linux-ide@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: 2.5.51 ide module problem (fwd) 
In-reply-to: Your message of "12 Dec 2002 12:38:27 -0000."
             <1039696707.21192.11.camel@irongate.swansea.linux.org.uk> 
Date: Fri, 13 Dec 2002 12:35:50 +1100
Message-Id: <20021213013637.4F2652C0ED@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1039696707.21192.11.camel@irongate.swansea.linux.org.uk> you write:
> The module changes basically left me unable to do any further 2.5.5x
> work at an acceptable rate. My time is now allocated to other projects
> until January. At that point hopefully the module stuff will be usable
> again, parameters will work etc and I can go back to work on 2.5.

That's disappointing.  However, I can completely relate to your
frustration with the lack of module parameters.  Linus are you
listening? 8) Hopefully he's back today and will take patches, and
then I can look forward to some bug reports from you...

The patches I have queued for Linus are:
1) Param support
2) /lib/modules directory structure & depmod reversion
3) module's init calls request_module loop fix (bttv and parport do
   this in some configs).

> Rusty is right that the ide stuff has dependancy loops right now. His
> new module stuff shouldn't have crashed but the fundamental work to be
> done is in the IDE layer. There are also some locking problems to
> address before modular IDE becomes useful.

Also, my stress_modules script gave the following warning then oops
from ide-cd on 2.5.51 SMP x86 (IDE is built-in):

Dec 12 11:05:36 mingo kernel: Badness in kobject_register at lib/kobject.c:113
Dec 12 11:05:37 mingo kernel: Call Trace:
Dec 12 11:05:37 mingo kernel:  [<d0968fec>] ide_cdrom_driver+0x4c/0xd4 [ide_cd]
Dec 12 11:05:37 mingo kernel:  [<c01a5745>] kobject_register+0x39/0x50
Dec 12 11:05:37 mingo kernel:  [<c01b2352>] bus_add_driver+0x7a/0xc8
Dec 12 11:05:37 mingo kernel:  [<d0969010>] ide_cdrom_driver+0x70/0xd4 [ide_cd]
Dec 12 11:05:37 mingo kernel:  [<d0969000>] ide_cdrom_driver+0x60/0xd4 [ide_cd]
Dec 12 11:05:37 mingo kernel:  [<d0968fa0>] ide_cdrom_driver+0x0/0xd4 [ide_cd]
Dec 12 11:05:37 mingo kernel:  [<d0968fec>] ide_cdrom_driver+0x4c/0xd4 [ide_cd]
Dec 12 11:05:37 mingo kernel:  [<c01dc239>] ata_attach+0xfd/0x2d0
Dec 12 11:05:37 mingo kernel:  [<d0969010>] ide_cdrom_driver+0x70/0xd4 [ide_cd]
Dec 12 11:05:37 mingo kernel:  [<c01b2776>] driver_register+0x3e/0x44
Dec 12 11:05:37 mingo kernel:  [<d0968fec>] ide_cdrom_driver+0x4c/0xd4 [ide_cd]
Dec 12 11:05:37 mingo kernel:  [<c01dd305>] ide_register_driver+0x1c9/0x1d4
Dec 12 11:05:37 mingo kernel:  [<d0968fec>] ide_cdrom_driver+0x4c/0xd4 [ide_cd]
Dec 12 11:05:37 mingo kernel:  [<d096618a>] ide_cdrom_init+0xa/0x10 [ide_cd]
Dec 12 11:05:37 mingo kernel:  [<d0968fa0>] ide_cdrom_driver+0x0/0xd4 [ide_cd]
Dec 12 11:05:37 mingo kernel:  [<c01307a3>] sys_init_module+0x183/0x210
Dec 12 11:05:37 mingo kernel:  [<c0108f73>] syscall_call+0x7/0xb
Dec 12 11:05:44 mingo kernel: Unable to handle kernel paging request at virtual address d0969024
Dec 12 11:05:44 mingo kernel:  printing eip:
Dec 12 11:05:44 mingo kernel: c01a56c5
Dec 12 11:05:44 mingo kernel: *pde = 0ff09067
Dec 12 11:05:44 mingo kernel: *pte = 00000000
Dec 12 11:05:44 mingo kernel: Oops: 0002
Dec 12 11:05:44 mingo kernel: CPU:    1
Dec 12 11:05:44 mingo kernel: EIP:    0060:[<c01a56c5>]    Not tainted
Dec 12 11:05:44 mingo kernel: EFLAGS: 00010246
Dec 12 11:05:44 mingo kernel: EIP is at kobject_add+0x85/0xcc
Dec 12 11:05:44 mingo kernel: eax: d08fd024   ebx: c02c4fe8   ecx: d0969024   edx: c02c4fe0
Dec 12 11:05:44 mingo kernel: esi: d08fd010   edi: c02c4fb8   ebp: 00000000   esp: ccf67f38
Dec 12 11:05:44 mingo kernel: ds: 0068   es: 0068   ss: 0068
Dec 12 11:05:44 mingo kernel: Process modprobe (pid: 2977, threadinfo=ccf66000 task=ccfb2d20)
Dec 12 11:05:44 mingo kernel: Stack: d08fd010 d08fcdf4 d08fd020 d08fcfec c01a5721 d08fd010 d08fd010 c02c4f60 
Dec 12 11:05:44 mingo kernel:        c01b2352 d08fd010 d08fd000 d08fcfa0 ccf67fa0 d08fcfec c01dc239 d08fd010 
Dec 12 11:05:44 mingo kernel:        c02c4f94 c01b2776 d08fcfec c036dc94 c01dd305 d08fcfec d083f000 c0291534 
Dec 12 11:05:44 mingo kernel: Call Trace:
Dec 12 11:05:44 mingo kernel:  [<d08fd010>] ide_cdrom_driver+0x70/0xd4 [ide_cd]
Dec 12 11:05:44 mingo kernel:  [<d08fcdf4>] sense_data_texts+0x263c/0x2728 [ide_cd]
Dec 12 11:05:44 mingo kernel:  [<d08fd020>] ide_cdrom_driver+0x80/0xd4 [ide_cd]
Dec 12 11:05:44 mingo kernel:  [<d08fcfec>] ide_cdrom_driver+0x4c/0xd4 [ide_cd]
Dec 12 11:05:44 mingo kernel:  [<c01a5721>] kobject_register+0x15/0x50
Dec 12 11:05:44 mingo kernel:  [<d08fd010>] ide_cdrom_driver+0x70/0xd4 [ide_cd]
Dec 12 11:05:44 mingo kernel:  [<d08fd010>] ide_cdrom_driver+0x70/0xd4 [ide_cd]
Dec 12 11:05:44 mingo kernel:  [<c01b2352>] bus_add_driver+0x7a/0xc8
Dec 12 11:05:44 mingo kernel:  [<d08fd010>] ide_cdrom_driver+0x70/0xd4 [ide_cd]
Dec 12 11:05:44 mingo kernel:  [<d08fd000>] ide_cdrom_driver+0x60/0xd4 [ide_cd]
Dec 12 11:05:44 mingo kernel:  [<d08fcfa0>] ide_cdrom_driver+0x0/0xd4 [ide_cd]
Dec 12 11:05:44 mingo kernel:  [<d08fcfec>] ide_cdrom_driver+0x4c/0xd4 [ide_cd]
Dec 12 11:05:44 mingo kernel:  [<c01dc239>] ata_attach+0xfd/0x2d0
Dec 12 11:05:44 mingo kernel:  [<d08fd010>] ide_cdrom_driver+0x70/0xd4 [ide_cd]
Dec 12 11:05:44 mingo kernel:  [<c01b2776>] driver_register+0x3e/0x44
Dec 12 11:05:44 mingo kernel:  [<d08fcfec>] ide_cdrom_driver+0x4c/0xd4 [ide_cd]
Dec 12 11:05:44 mingo kernel:  [<c01dd305>] ide_register_driver+0x1c9/0x1d4
Dec 12 11:05:44 mingo kernel:  [<d08fcfec>] ide_cdrom_driver+0x4c/0xd4 [ide_cd]
Dec 12 11:05:44 mingo kernel:  [<d08fa18a>] ide_cdrom_init+0xa/0x10 [ide_cd]
Dec 12 11:05:44 mingo kernel:  [<d08fcfa0>] ide_cdrom_driver+0x0/0xd4 [ide_cd]
Dec 12 11:05:44 mingo kernel:  [<c01307a3>] sys_init_module+0x183/0x210
Dec 12 11:05:44 mingo kernel:  [<c0108f73>] syscall_call+0x7/0xb
Dec 12 11:05:44 mingo kernel: 
Dec 12 11:05:44 mingo kernel: Code: 89 01 57 e8 3b 01 00 00 89 46 1c 83 c4 04 89 d8 ba ff ff 00 

Hope that helps!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
