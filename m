Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbUKMS4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUKMS4U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 13:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbUKMS4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 13:56:19 -0500
Received: from lists.us.dell.com ([143.166.224.162]:57804 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261153AbUKMS4H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 13:56:07 -0500
Date: Sat, 13 Nov 2004 12:55:53 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Chuck Ebbert <76306.1226@compuserve.com>,
       Christian Kujau <evil@g-house.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
Message-ID: <20041113185553.GA9685@lists.us.dell.com>
References: <200411122248_MC3-1-8E97-BFE5@compuserve.com> <20041113142835.GA9109@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041113142835.GA9109@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 08:28:35AM -0600, Matt Domsch wrote:
> On Fri, Nov 12, 2004 at 10:45:12PM -0500, Chuck Ebbert wrote:
> > On Tue, 9 Nov 2004 at 17:01:10 -0800 Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > > > PS: do you have *any* idea how this could be related to the snd-es1371
> > > > driver (which is producing the oops then)?
> > >
> > > I bet it's overwriting some array, and just corrupting memory after it. 
> > > For example, the edd_info[] array only has 6 entries,
> > 
> >   That's almost certainly the problem.  There can be up to 16 EDD devices
> > as of the Jun 30 update to the EDD code.
> 
> Bingo...  edd_devices[] was too short.  When we keep more
> than 6 signatures, it overruns the end.

In particular, depending on your .config, with EDD=y it overwrites 40
bytes past the end of edd_devices (here I've already extended it by
the necessary amount, but the 40 bytes past its end are all subject to
be overwritten):
c043a880 b edd_devices
c043a8c0 b pci_bios_present
c043a8c4 B pci_mmcfg_base_addr
c043a8c8 b mmcfg_last_accessed_device
c043a8cc b called.0
c043a8d0 B pcibios_enable_irq
c043a8d4 b eisa_irq_mask.0
c043a8d8 b broken_hp_bios_irq9
c043a8dc b acer_tm360_irqrouting
c043a8e0 b pirq_table
c043a8e4 b pirq_router

hence the failure Christian saw and attributed to the sound drivers:

EIP is at 0xc15d5820
eax: 00000000   ebx: dff20400   ecx: c15d5820   edx: dff205c4
esi: ffffffed   edi: dff20400   ebp: dff20400   esp: c17a3e58
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 178, threadinfo=c17a2000 task=dfcf05a0)
Stack: c01fa5c8 dff20400 000007ff dff20400 c01fa5ff dff20400 000007ff
c15ea400 
       e082729d dff20400 c15ea400 00000000 e08469df c15ea400 000001f8
       000000d0 
       000000d0 df45ed14 00000000 c018e14e c15ea400 ffffffed dff20400
       dff20400 
Call Trace:
 [<c01fa5c8>] pci_enable_device_bars+0x28/0x40
 [<c01fa5ff>] pci_enable_device+0x1f/0x40
 [<e082729d>] snd_ensoniq_create+0x1d/0x480 [snd_ens1371]
 [<e08469df>] snd_card_new+0x1cf/0x2c0 [snd]
 [<c018e14e>] sysfs_new_dirent+0x2e/0x90
 [<e0827867>] snd_audiopci_probe+0x87/0x1e0 [snd_ens1371]
 [<c01fb012>] pci_device_probe_static+0x52/0x70
 [<c01fb05c>] __pci_device_probe+0x2c/0x30
 [<c01fb08c>] pci_device_probe+0x2c/0x60
 [<c0258f4f>] driver_probe_device+0x2f/0x80
 [<c02590b2>] driver_attach+0x52/0xa0
 [<c02595f8>] bus_add_driver+0x98/0xe0
 [<c0259c5f>] driver_register+0x2f/0x40
 [<c01fb340>] pci_register_driver+0x40/0x50
 [<e08279cf>] alsa_card_ens137x_init+0xf/0x13 [snd_ens1371]
 [<c0134279>] sys_init_module+0x169/0x240
 [<c01041eb>] syscall_call+0x7/0xb


With CONFIG_EDD=m, there just wasn't anything interesting in memory
following edd_devices[] (thanks module loader for using whole pages I
believe).

-Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
