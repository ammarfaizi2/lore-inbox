Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWDUT52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWDUT52 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWDUT52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:57:28 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:21423 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751267AbWDUT51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:57:27 -0400
Date: Fri, 21 Apr 2006 11:34:30 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, johnrose@us.ibm.com
Subject: Re: [PATCH] powerpc/pseries: avoid crash in PCI code if mem system not up.
Message-ID: <20060421163430.GE7242@austin.ibm.com>
References: <20060421004042.GC7242@austin.ibm.com> <17480.51661.41707.53706@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17480.51661.41707.53706@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Apr 21, 2006 at 10:02:21PM +1000, Paul Mackerras wrote:
> Linas Vepstas writes:
>
> > Please apply and forward upstream.  And a question: once
> > upon a time, the arch PCI subsystem was inited after mem init
> > was done; currently, it seems to be happening before mem init.
> > Is this intentional?
>
> No, and it is bogus if it is.  Do you have the full backtrace from the
> crash?

Yes, below.
The relevant bits are this:

start_kernel() {
  setup_arch() {
     pSeries_setup_arch () {
         eeh_init () {
           ... if err kmalloc()
               crash.
         }
     }
  }
  mem_init()

  // are there other appropriate arch init points
  // ater mem_init() where we can do arch-dependent
  // i/o bridge initialization ??
}

I also remember there being some nastiness re kmalloc
when initializing dlpar/hot-plug PCI slots before
mem_init was done.  Basically, if the hotplug slots
are present at boot time, we can't use kmalloc/kfree
to manage them.

If the arch dependent I/O bridges/subsystem init could
be moved later, maybe this could be fixed as well.

--linas

Linux zImage starting: loaded at 0x00010000-0x00849cbc
(0x0/0x0/0x00c39a48; sp: 0x0181ffd0)
uncompressing ELF header done. (0x00000100 bytes)
Allocated 0x009f9020 bytes for kernel @ 0x02000000
Allocated 0x005f389c bytes for initrd @ 0x029fa000
uncompressing kernel done. (0x0063d538 bytes)
entering kernel at 0x02010000(29fa000/5f389c/00c39a48)
OF stdout device is: /vdevice/vty@30000000
Hypertas detected, assuming LPAR !
command line:
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 0000000002fee000
  alloc_top    : 0000000010000000
 alloc_top_hi : 00000003b0000000
  rmo_top      : 0000000010000000
  ram_top      : 00000003b0000000
Looking for displays
instantiating rtas at 0x000000000f702000 ...RTAS Code version:
bPF060322
rtas_ram_size = 5a1000
fixed_base_addr = f702000
code_base_addr = f99f000
 done
0000000000000000 : boot cpu     0000000000000000
0000000000000002 : starting cpu hw idx 0000000000000002... done
0000000000000004 : starting cpu hw idx 0000000000000004... done
0000000000000006 : starting cpu hw idx 0000000000000006... done
0000000000000008 : starting cpu hw idx 0000000000000008... done
000000000000000a : starting cpu hw idx 000000000000000a... done
000000000000000c : starting cpu hw idx 000000000000000c... done
000000000000000e : starting cpu hw idx 000000000000000e... done
copying OF device tree ...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000002fef000 -> 0x0000000002ff0428
Device tree struct  0x0000000002ff1000 -> 0x000000000300a000
Calling quiesce ...
returning from prom_init
Page orders: linear mapping = 24, others = 12
Found initrd at 0xc0000000029fa000:0xc000000002fed89c
cpu 0x0: Vector: 300 (Data Access) at [c0000000004434d0]
    pc: c0000000000c06b4: .kmem_cache_alloc+0x8c/0xf4
    lr: c00000000004ad6c: .eeh_send_failure_event+0x48/0xfc
    sp: c000000000443750
   msr: 8000000000001032
   dar: 0
 dsisr: 40000000
  current = 0xc00000000048e660
  paca    = 0xc00000000048ee80
    pid   = 0, comm = swapper
enter ? for help
[c0000000004437e0] c00000000004ad6c .eeh_send_failure_event+0x48/0xfc
[c000000000443880] c000000000049dfc .eeh_dn_check_failure+0x250/0x2a8
[c000000000443930] c00000000001da6c .rtas_read_config+0x100/0x13c
[c0000000004439d0] c0000000000497a8 .early_enable_eeh+0x25c/0x2ac
[c000000000443a90] c00000000002ba4c .traverse_pci_devices+0x84/0x100
[c000000000443b30] c00000000041ae7c .eeh_init+0x1a8/0x204
[c000000000443bd0] c00000000041a308 .pSeries_setup_arch+0x1e8/0x2b8
[c000000000443e60] c00000000040a6a0 .setup_arch+0x20c/0x25c
[c000000000443ef0] c00000000040252c .start_kernel+0x40/0x288
[c000000000443f90] c000000000008594 .start_here_common+0x88/0x8c


