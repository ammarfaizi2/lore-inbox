Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751898AbWJMU52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbWJMU52 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 16:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbWJMU52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 16:57:28 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:58263 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751898AbWJMU51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 16:57:27 -0400
Subject: Re: kernel BUG in __cache_alloc_node at
	linux-2.6.git/mm/slab.c:3177!
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Reply-To: will_schmidt@vnet.ibm.com
To: Christoph Lameter <clameter@sgi.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1160769226.11239.22.camel@farscape>
References: <1160764895.11239.14.camel@farscape>
	 <Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
	 <1160769226.11239.22.camel@farscape>
Content-Type: text/plain
Organization: IBM
Date: Fri, 13 Oct 2006 15:57:20 -0500
Message-Id: <1160773040.11239.28.camel@farscape>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-13-10 at 14:53 -0500, Will Schmidt wrote:
> On Fri, 2006-13-10 at 12:05 -0700, Christoph Lameter wrote:
> > On Fri, 13 Oct 2006, Will Schmidt wrote:
> > 
> > >     Am seeing a crash on a power5 LPAR when booting the linux-2.6 git
> > > tree.  It's fairly early during boot, so I've included the whole log
> > > below.   This partition has 8 procs, (shared, including threads), and
> > > 512M RAM.  
> > 
> > This looks like slab bootstrap. You are bootstrapping while having 
> > zonelists build with zones that are only going to be populated later? 
> > This will lead to incorrect NUMA placement of lots of slab structures on 
> > bootup.
> 
> I dont think so..   but it's not an area I'm very familiar with.   one
> of the other PPC folks might chime in with something here.  
> 
> > 
> > Check if the patch below may cure the oops. Your memory is likely 
> > still placed on the wrong numa nodes since we have to fallback from 
> > the intended node.
> 
> Nope, no change with this patch.
> 

Here is another boot log, with that patch applied, and with a numa=debug
parm. 

-----------------------------------------------------
ppc64_pft_size                = 0x18
physicalMemorySize            = 0x22000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x1ffff
-----------------------------------------------------
Linux version 2.6.19-rc1-gb8a3ad5b-dirty (willschm@airbag2) (gcc version
4.1.0 (SUSE Linux)) #60 SMP Fri Oct 13 14:48:20 CDT 2006
[boot]0012 Setup Arch
NUMA associativity depth for CPU/Memory: 3
adding cpu 0 to node 0
node 0
NODE_DATA() = c000000015ffee80
start_paddr = 8000000
end_paddr = 16000000
bootmap_paddr = 15ffc000
reserve_bootmem ffc0000 40000
reserve_bootmem 15ffc000 2000
reserve_bootmem 15ffee80 1180
node 1
NODE_DATA() = c000000021ff7c80
start_paddr = 0
end_paddr = 22000000
bootmap_paddr = 21ff2000
reserve_bootmem 0 847000
reserve_bootmem 264b000 9000
reserve_bootmem 77b2000 84e000
reserve_bootmem 21ff2000 5000
reserve_bootmem 21ff7c80 1180
reserve_bootmem 21ff8e58 71a4
No ramdisk, default root is /dev/sda2
EEH: No capable adapters found
PPC64 nvram contains 7168 bytes
Zone PFN ranges:
  DMA             0 ->   139264
  Normal     139264 ->   139264
early_node_map[3] active PFN ranges
    1:        0 ->    32768
    0:    32768 ->    90112
    1:    90112 ->   139264
[boot]0015 Setup Done
Built 2 zonelists.  Total pages: 136576
Kernel command line: root=/dev/sda3  xmon=on  numa=debug
[boot]0020 XICS Init
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
freeing bootmem node 0
freeing bootmem node 1
Memory: 530256k/557056k available (5508k kernel code, 30468k reserved,
2224k data, 543k bss, 244k init)
kernel BUG in __cache_alloc_node
at /development/kernels/linux-2.6.git/mm/slab.c:3178!
cpu 0x0: Vector: 700 (Program Check) at [c0000000007938d0]
    pc: c0000000000b3c78: .__cache_alloc_node+0x44/0x1e8
    lr: c0000000000b3ed4: .fallback_alloc+0xb8/0xfc
    sp: c000000000793b50
   msr: 8000000000021032
  current = 0xc000000000583a90
  paca    = 0xc000000000584300
    pid   = 0, comm = swapper
kernel BUG in __cache_alloc_node
at /development/kernels/linux-2.6.git/mm/slab.c:3178!
enter ? for help
[c000000000793c00] c0000000000b3ed4 .fallback_alloc+0xb8/0xfc
[c000000000793ca0] c0000000000b4484 .kmem_cache_zalloc+0xc8/0x11c
[c000000000793d40] c0000000000b6630 .kmem_cache_create+0x1e8/0x5e0
[c000000000793e30] c00000000053e834 .kmem_cache_init+0x1d8/0x4b0
[c000000000793ef0] c000000000524748 .start_kernel+0x244/0x328
[c000000000793f90] c0000000000084f8 .start_here_common+0x54/0x5c
0:mon>                          


