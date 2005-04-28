Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVD1LpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVD1LpK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 07:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVD1LpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 07:45:10 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:39066 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262080AbVD1LoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 07:44:21 -0400
Date: Thu, 28 Apr 2005 17:14:16 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: vgoyal@in.ibm.com, akpm@osdl.org, sharyathi@in.ibm.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
Subject: Re: [Fastboot] Re: Kdump Testing
Message-ID: <20050428114416.GA5706@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1114227003.4269c13be5f8b@imap.linux.ibm.com> <OFB57B3D45.D8C338C5-ON65256FEE.0042F961-65256FEE.0043D4CB@in.ibm.com> <20050425160925.3a48adc5.rddunlap@osdl.org> <20050426085448.GB4234@in.ibm.com> <20050427122312.358f5bd6.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427122312.358f5bd6.rddunlap@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 12:23:12PM -0700, Randy.Dunlap wrote:
> On Tue, 26 Apr 2005 14:24:48 +0530
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> 
> > > 
> > > 2.6.12-rc2-mm3 reboots vmlinux-recover-UP on panic.
> > > (vmlinux-recover-SMP hangs during [early] reboot, but -UP
> > > goes further....)
> > > 
> > > (BTW, how does I do serial console from the second
> > > kernel...?  It has the drivers, but not the command
> > > line info?  TBD.)
> > > 
> > 
> > 
> > While pre-loading the capture kernel using kexec, you can specify the command
> > line options to second kernel using --append="". You must already be passing
> > the root device. Add you serial console parameters as well something like
> > --append="console=ttyS0, 38400"
> > 
> > 
> > > vmlinux-recover-UP gets to this point, hand-written,
> > > several lines missing:
> > > 
> > > kfree_debugcheck: bad ptr c3dbffb0h.  ( == %esi)
> > > kernel BUG at <bad filename>:23128!
> > > invalid operand: 0000 [#1]
> > > DEBUG_PAGEALLOC
> > > EIP is at kfree_debugcheck+0x45/0x50
> > > 
> > > Stack dump shows lots of ext3 cache and inode functions...
> > > 
> > 
> > Can you post a full serial console output of second kernel? That would help.
> 
> I did another test run, same kernels (both running and recovery).
> The recovery kernel got a little further this time, still had
> Badness and a BUG.
> 
> ---

Ok. I am also able to see this slab corruption occurring on my machine. I can 
get away with the problem if I disable cachefs support. 

Infact, I can reproduce the problem if I boot capture kernel normally through 
BIOS with commandline "mem=64M". Looks like it is generic problem and not
associated with kexec/kdump. Cachefs might be doing some corruption.


> CacheFS: Wrong magic number on cache
> EXT3-fs: INFO: recovery required on readonly filesystem.
> EXT3-fs: write access will be enabled during recovery.
> input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: recovery complete.
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 220k freed
> Adding 2104472k swap on /dev/hda7.  Priority:42 extents:1
> mismatch in kmem_cache_free: expected cache c168fc80, got c4daca80
> c4daca80 is ext3_inode_cache.
> c168fc80 is skbuff_head_cache.
> Badness in cache_free_debugcheck at mm/slab.c:1917
>  [<c1003368>] dump_stack+0x16/0x18
>  [<c1041a94>] cache_free_debugcheck+0x88/0x1d5
>  [<c10424fd>] kmem_cache_free+0x26/0x65
>  [<c10a8c01>] ext3_destroy_inode+0x17/0x19
>  [<c10784c9>] destroy_inode+0x27/0x3d
>  [<c1078837>] dispose_list+0x60/0x178
>  [<c1078f81>] prune_icache+0x363/0x399
>  [<c1078fd0>] shrink_icache_memory+0x19/0x32
>  [<c1044dd7>] shrink_slab+0x104/0x172
>  [<c104641e>] try_to_free_pages+0xbe/0x16f
>  [<c103d9a0>] __alloc_pages+0x1d3/0x393
>  [<c104037c>] kmem_getpages+0x2d/0x7f
>  [<c1041869>] cache_grow+0x155/0x2a8
>  [<c1041f1f>] cache_alloc_refill+0x285/0x2c2
>  [<c10423c6>] kmem_cache_alloc+0x5d/0x77
>  [<c1075dac>] d_alloc+0x16/0x27a
>  [<c106b2b9>] real_lookup+0x40/0xc2
>  [<c106b68e>] do_lookup+0x41/0x75
>  [<c106c3a7>] __link_path_walk+0xce5/0x1066
>  [<c106c768>] link_path_walk+0x40/0xc7
>  [<c106ca87>] path_lookup+0xec/0xf7
>  [<c106cbc9>] __user_walk+0x28/0x42
>  [<c10667b3>] vfs_lstat+0x17/0x3f
>  [<c1066d1e>] sys_lstat64+0x13/0x29
>  [<c1002c5f>] sysenter_past_esp+0x54/0x75
> slab error in cache_free_debugcheck(): cache `ext3_inode_cache': double free, or memory outside object was overwritten
>  [<c1003368>] dump_stack+0x16/0x18
>  [<c1041ad2>] cache_free_debugcheck+0xc6/0x1d5
>  [<c10424fd>] kmem_cache_free+0x26/0x65
>  [<c10a8c01>] ext3_destroy_inode+0x17/0x19
>  [<c10784c9>] destroy_inode+0x27/0x3d
>  [<c1078837>] dispose_list+0x60/0x178
>  [<c1078f81>] prune_icache+0x363/0x399
>  [<c1078fd0>] shrink_icache_memory+0x19/0x32
>  [<c1044dd7>] shrink_slab+0x104/0x172
>  [<c104641e>] try_to_free_pages+0xbe/0x16f
>  [<c103d9a0>] __alloc_pages+0x1d3/0x393
>  [<c104037c>] kmem_getpages+0x2d/0x7f
>  [<c1041869>] cache_grow+0x155/0x2a8
>  [<c1041f1f>] cache_alloc_refill+0x285/0x2c2
>  [<c10423c6>] kmem_cache_alloc+0x5d/0x77
>  [<c1075dac>] d_alloc+0x16/0x27a
>  [<c106b2b9>] real_lookup+0x40/0xc2
>  [<c106b68e>] do_lookup+0x41/0x75
>  [<c106c3a7>] __link_path_walk+0xce5/0x1066
>  [<c106c768>] link_path_walk+0x40/0xc7
>  [<c106ca87>] path_lookup+0xec/0xf7
>  [<c106cbc9>] __user_walk+0x28/0x42
>  [<c10667b3>] vfs_lstat+0x17/0x3f
>  [<c1066d1e>] sys_lstat64+0x13/0x29
>  [<c1002c5f>] sysenter_past_esp+0x54/0x75
> c3d7afb0: redzone 1: 0x0, redzone 2: 0x0.
> ------------[ cut here ]------------
> kernel BUG at <bad filename>:18422!
> invalid operand: 0000 [#1]
> DEBUG_PAGEALLOC
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c1041b46>]    Not tainted VLI
> EFLAGS: 00010002   (2.6.12-rc2-mm3) 
> EIP is at cache_free_debugcheck+0x13a/0x1d5
> eax: c3d7a000   ebx: c3d7a000   ecx: 00001000   edx: 00000fb0
> esi: c3d7afb0   edi: c4daca80   ebp: c2f73bb8   esp: c2f73bac
> ds: 007b   es: 007b   ss: 0068
> Process showconsole (pid: 1264, threadinfo=c2f72000 task=c2f68ac0)
> Stack: c4d0fec4 c4daca80 c3d7bd44 c2f73be0 c10424fd c4daca80 c3d7bd44 c10a8c01 
>        00000080 00000286 c3d7bddc c2f73c2c 00000080 c2f73bf0 c10a8c01 c4daca80 
>        c3d7bd44 c2f73c00 c10784c9 c3d7bddc c3d7bddc c2f73c1c c1078837 c3d7bddc 
> Call Trace:
>  [<c100334a>] show_stack+0x7a/0x82
>  [<c1003453>] show_registers+0xe9/0x153
>  [<c100369f>] die+0x15c/0x23d
>  [<c1003a79>] do_invalid_op+0x90/0x97
>  [<c1002ed3>] error_code+0x4f/0x54
>  [<c10424fd>] kmem_cache_free+0x26/0x65
>  [<c10a8c01>] ext3_destroy_inode+0x17/0x19
>  [<c10784c9>] destroy_inode+0x27/0x3d
>  [<c1078837>] dispose_list+0x60/0x178
>  [<c1078f81>] prune_icache+0x363/0x399
>  [<c1078fd0>] shrink_icache_memory+0x19/0x32
>  [<c1044dd7>] shrink_slab+0x104/0x172
>  [<c104641e>] try_to_free_pages+0xbe/0x16f
>  [<c103d9a0>] __alloc_pages+0x1d3/0x393
>  [<c104037c>] kmem_getpages+0x2d/0x7f
>  [<c1041869>] cache_grow+0x155/0x2a8
>  [<c1041f1f>] cache_alloc_refill+0x285/0x2c2
>  [<c10423c6>] kmem_cache_alloc+0x5d/0x77
>  [<c1075dac>] d_alloc+0x16/0x27a
>  [<c106b2b9>] real_lookup+0x40/0xc2
>  [<c106b68e>] do_lookup+0x41/0x75
>  [<c106c3a7>] __link_path_walk+0xce5/0x1066
>  [<c106c768>] link_path_walk+0x40/0xc7
>  [<c106ca87>] path_lookup+0xec/0xf7
>  [<c106cbc9>] __user_walk+0x28/0x42
>  [<c10667b3>] vfs_lstat+0x17/0x3f
>  [<c1066d1e>] sys_lstat64+0x13/0x29
>  [<c1002c5f>] sysenter_past_esp+0x54/0x75
> Code: e8 bc e4 ff ff 8b 55 10 89 10 58 5a 8b 5b 0c 89 f0 31 d2 8b 4f 34 29 d8 f7 f1 3b 47 3c 72 02 0f 0b 0f af c1 8d 04 18 39 c6 74 02 <0f> 0b f6 47 39 02 74 15 6a 05 57 57 e8 1d e4 ff ff 8d 04 30 89 
>  
