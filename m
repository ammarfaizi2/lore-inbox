Return-Path: <linux-kernel-owner+w=401wt.eu-S965173AbWLTXq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbWLTXq7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbWLTXq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:46:59 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:55564 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965170AbWLTXq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:46:57 -0500
Date: Wed, 20 Dec 2006 17:46:47 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Bergner <bergner@vnet.ibm.com>,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: Mutex debug lock failure [was Re: Bad gcc-4.1.0 leads to Power4 crashes... and power5 too, actually
Message-ID: <20061220234647.GD16860@austin.ibm.com>
References: <20061220004653.GL5506@austin.ibm.com> <1166579210.4963.15.camel@otta> <20061220211931.GB16860@austin.ibm.com> <1166650134.6673.9.camel@localhost.localdomain> <20061220230342.GC16860@austin.ibm.com> <1166656195.6673.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166656195.6673.23.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 10:09:55AM +1100, Benjamin Herrenschmidt wrote:
> 
> > This also doesn't explain the bizarre form of the failure on
> > power4 ... does power4 mishandle twi somehow? Will investigate
> > next. 
> 
> Or you hit it before you have a console ?

Ahh... I was about to claim I have a console, but on closer
examination: someone has been messing with consoles? 
I don't get it ... The power4 has ony a serial connection.
the power5 has a graphics card in it, unused.

The power5 has "Console: colour dummy device 80x25"
kick in, at which point the time goes crazy as well.

There may be multiple bugs here. 

The weird crash for 2.6.19-git7 on power4 looks like this:

Looking for displays
opening PHB /pci@400000000110... done
opening PHB /pci@400000000111... done
instantiating rtas at 0x000000002fd10000 ... done
0000000000000000 : boot cpu     0000000000000000
copying OF device tree ...
Building dt strings...
Building dt structure...
Device tree strings 0x00000000043a0000 -> 0x00000000043a135c
Device tree struct  0x00000000043b0000 -> 0x00000000043c0000
Calling quiesce ...
returning from prom_init
[    0.000000] Starting Linux PPC64 #0 SMP Tue Dec 5 17:20:17 CST 2006
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size                = 0x0
[    0.000000] physicalMemorySize            = 0x400000000
[    0.000000] ppc64_caches.dcache_line_size = 0x80
[    0.000000] ppc64_caches.icache_line_size = 0x80
[    0.000000] htab_address                  = 0xc0000003e0000000
[    0.000000] htab_hash_mask                = 0x1fffff
[    0.000000] -----------------------------------------------------
[    0.000000] Linux version 2.6.19-git7linas (root@venn) (gcc version
4.1.0 (SUSE Linux)) #0 SMP Tue Dec 5 17:20:17 CST 2006
[    0.000000] [boot]0012 Setup Arch
[    0.000000] No ramdisk, default root is /dev/sda2
[    0.000000] EEH: PCI Enhanced I/O Error Handling Enabled
[    0.000000] PPC64 nvram contains 81920 bytes
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->   262144
[    0.000000]   Normal     262144 ->   262144
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   262144
[    0.000000] [boot]0015 Setup Done
[    0.000000] Built 1 zonelists.  Total pages: 261888
[    0.000000] Kernel command line: root=/dev/sda3 console=ttyS0
selinux=0 elevator=cfq kdb=on
[    0.000000] [boot]0020 XICS Init
[    0.000000] i8259 legacy interrupt controller initialized
[    0.000000] [boot]0021 XICS Done
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
System assert at:  file: rtas_io_config.c  -- line: 195
rio_hub_num: 10
drawer_num: 6
phb_num: 3
buid: 7


which should be compared to 2.6.20-rc1-git6, build with the same
.config, on power4:

Looking for displays
opening PHB /pci@400000000110... done
opening PHB /pci@400000000111... done
instantiating rtas at 0x000000002fd10000 ... done
0000000000000000 : boot cpu     0000000000000000
copying OF device tree ...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000004380000 -> 0x000000000438135c
Device tree struct  0x0000000004390000 -> 0x00000000043a0000
Calling quiesce ...
returning from prom_init
[    0.000000] Starting Linux PPC64 #0 SMP Tue Dec 19 17:42:44 CST 2006
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size                = 0x0
[    0.000000] physicalMemorySize            = 0x400000000
[    0.000000] ppc64_caches.dcache_line_size = 0x80
[    0.000000] ppc64_caches.icache_line_size = 0x80
[    0.000000] htab_address                  = 0xc0000003e0000000
[    0.000000] htab_hash_mask                = 0x1fffff
[    0.000000] -----------------------------------------------------
[    0.000000] Linux version 2.6.20-rc1-git6linas (root@venn) (gcc
version 4.1.0 (SUSE Linux)) #0 SMP Tue Dec 19 17:42:44 CST 2006
[    0.000000] [boot]0012 Setup Arch
[    0.000000] No ramdisk, default root is /dev/sda2
[    0.000000] EEH: PCI Enhanced I/O Error Handling Enabled
[    0.000000] PPC64 nvram contains 81920 bytes
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->   262144
[    0.000000]   Normal     262144 ->   262144
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   262144
[    0.000000] [boot]0015 Setup Done
[    0.000000] Built 1 zonelists.  Total pages: 261888
[    0.000000] Kernel command line: root=/dev/sda3 console=ttyS0
selinux=0 elevator=cfq kdb=on
[    0.000000] [boot]0020 XICS Init
[    0.000000] i8259 legacy interrupt controller initialized
[    0.000000] [boot]0021 XICS Done
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
cpu 0x0: Vector: 700 (Program Check) at [c0000000007a3980]
    pc: c00000000007d574: .debug_mutex_unlock+0x5c/0x118
    lr: c000000000468068: .__mutex_unlock_slowpath+0x104/0x198
    sp: c0000000007a3c00
   msr: 9000000000029032
  current = 0xc000000000663690
  paca    = 0xc000000000663f80
    pid   = 0, comm = swapper
enter ? for help
[c0000000007a3c80] c000000000468068 .__mutex_unlock_slowpath+0x104/0x198
[c0000000007a3d20] c000000000231da8 .double_unlock_mutex+0x3c/0x58
[c0000000007a3db0] c00000000023b47c .dotest+0x5c/0x370
[c0000000007a3e50] c00000000023bc0c .locking_selftest+0x47c/0x17fc
[c0000000007a3ef0] c0000000005f06ec .start_kernel+0x1e4/0x344
[c0000000007a3f90] c0000000000084c8 .start_here_common+0x54/0x8c
0:mon>


And, exactly the same kernel, on power5:

Looking for displays
found display   : /pci@800000020000002/pci@2,2/pci@1/display@0, opening
... done
instantiating rtas at 0x0000000007710000 ... done
0000000000000000 : boot cpu     0000000000000000
0000000000000002 : starting cpu hw idx 0000000000000002... done
copying OF device tree ...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000002580000 -> 0x000000000258141e
Device tree struct  0x0000000002590000 -> 0x00000000025a0000
[    0.000000] Using pSeries machine description
[    0.000000] Partition configured for 4 cpus.
[    0.000000] Starting Linux PPC64 #0 SMP Tue Dec 19 17:42:44 CST 2006
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size                = 0x19
[    0.000000] physicalMemorySize            = 0x72000000
[    0.000000] ppc64_caches.dcache_line_size = 0x80
[    0.000000] ppc64_caches.icache_line_size = 0x80
[    0.000000] htab_address                  = 0x0000000000000000
[    0.000000] htab_hash_mask                = 0x3ffff
[    0.000000] -----------------------------------------------------
[    0.000000] Linux version 2.6.20-rc1-git6linas (root@venn) (gcc
version 4.1.0 (SUSE Linux)) #0 SMP Tue Dec 19 17:42:446[    0.000000]
[boot]0012 Setup Arch
[    0.000000] No ramdisk, default root is /dev/sda2
[    0.000000] EEH: PCI Enhanced I/O Error Handling Enabled
[    0.000000] PPC64 nvram contains 7168 bytes
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    29184
[    0.000000]   Normal      29184 ->    29184
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    29184
[    0.000000] [boot]0015 Setup Done
[    0.000000] Built 1 zonelists.  Total pages: 29156
[    0.000000] Kernel command line: root=/dev/sda9 console=hvsi0 selinux=0 elevator=cfq rtas_msgs=1
[    0.000000] [boot]0020 XICS Init
[    0.000000] [boot]0021 XICS Done
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[97741.568069] Console: colour dummy device 80x25
[97742.318175] ------------------------
[97742.318182] | Locking API testsuite:
[97742.318189] ----------------------------------------------------------------------------
[97742.318200]                                  | spin |wlock |rlock |mutex | wsem | rsem |
[97742.318211] --------------------------------------------------------------------------
[97742.318222]                      A-A deadlock:failed|failed|  ok |failed|failed|failed|
[97742.318246]                  A-B-B-A deadlock:failed|failed|  ok |failed|failed|failed|
[97742.318271]              A-B-B-C-C-A deadlock:failed|failed|  ok |failed|failed|failed|
[97742.318297]              A-B-C-A-B-C deadlock:failed|failed|  ok |failed|failed|failed|
[97742.318323]          A-B-B-C-C-D-D-A deadlock:failed|failed|  ok |failed|failed|failed|
[97742.318352]          A-B-C-D-B-D-D-A deadlock:failed|failed|  ok |failed|failed|failed|
[97742.318380]          A-B-C-D-B-C-D-A deadlock:failed|failed|  ok |failed|failed|failed|
[97742.318408]                     double unlock:  ok  |  ok |failed|<0>------------[ cut here ]------------
[97742.318440] Kernel BUG at c00000000007d574 [verbose debug info
unavailable]
cpu 0x0: Vector: 700 (Program Check) at [c0000000007a3980]
    pc: c00000000007d574: .debug_mutex_unlock+0x5c/0x118
    lr: c000000000468068: .__mutex_unlock_slowpath+0x104/0x198
    sp: c0000000007a3c00
   msr: 8000000000029032
  current = 0xc000000000663690
  paca    = 0xc000000000663f80
    pid   = 0, comm = swapper
enter ? for help
[c0000000007a3c80] c000000000468068 .__mutex_unlock_slowpath+0x104/0x198
[c0000000007a3d20] c000000000231da8 .double_unlock_mutex+0x3c/0x58
[c0000000007a3db0] c00000000023b47c .dotest+0x5c/0x370
[c0000000007a3e50] c00000000023bc0c .locking_selftest+0x47c/0x17fc
[c0000000007a3ef0] c0000000005f06ec .start_kernel+0x1e4/0x344
[c0000000007a3f90] c0000000000084c8 .start_here_common+0x54/0x8c
0:mon> r

