Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbTFIUbf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 16:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTFIUbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 16:31:35 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:65229 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261887AbTFIUag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 16:30:36 -0400
Date: Mon, 09 Jun 2003 13:33:07 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 794] New: RAID0 stripe not detected in 2.5.70 
Message-ID: <73570000.1055190787@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=794

           Summary: RAID0 stripe not detected in 2.5.70
    Kernel Version: 2.5.70-bk13
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: davej@codemonkey.org.uk


Up until 2.5.70, my RAID0 stripe mounted fine, in both 2.4 and 2.5. It looked
like this..

Here's how things look in 2.4, and in 2.5.69

md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 00000154]
 [events: 00000154]
md: autorun ...
md: considering hdg1 ...
md:  adding hdg1 ...
md:  adding hde1 ...
md: created md0
md: bind<hde1,1>
md: bind<hdg1,2>
md: running: <hdg1><hde1>
md: hdg1's event counter: 00000154
md: hde1's event counter: 00000154
md0: max total readahead window set to 1024k
md0: 2 data-disks, max readahead per data-disk: 512k
raid0: looking at hde1
raid0:   comparing hde1(45034752) with hde1(45034752)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdg1
raid0:   comparing hdg1(45034752) with hde1(45034752)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking hde1 ... contained as device 0
  (45034752) is smallest!.
raid0: checking hdg1 ... contained as device 1
raid0: zone->nb_dev: 2, size: 90069504
raid0: current zone offset: 45034752
raid0: done.
raid0 : md_size is 90069504 blocks.
raid0 : conf->smallest->size is 90069504 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md0 RAID superblock on device
md: hdg1 [events: 00000155]<6>(write) hdg1's sb offset: 45034816
md: hde1 [events: 00000155]<6>(write) hde1's sb offset: 45034816
md: ... autorun DONE


I tested 2.5.70-bk13, and found this happens instead...

md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdg1 ...
md:  adding hdg1 ...
md:  adding hde1 ...
md: created md0
md: bind<hde1>
md: bind<hdg1>
md: running: <hdg1><hde1>
md0: setting max_sectors to 256, segment boundary to 65535
raid0: looking at hdg1
raid0:   comparing hdg1(45034752) with hdg1(45034752)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hde1
raid0:   comparing hde1(45034752) with hdg1(45034752)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: multiple devices for 1 - aborting!
md: pers->run() failed ...
md :do_md_run() returned -22
md: md0 stopped.
md: unbind<hdg1>
md: export_rdev(hdg1)
md: unbind<hde1>   
md: export_rdev(hde1)
md: ... autorun DONE.


When this fails, the boot scripts get a little further, and then it oopses when
something tries to mount md0 (which isn't there)


Jun  8 18:55:43 tetrachloride kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000014
Jun  8 18:55:43 tetrachloride kernel:  printing eip:
Jun  8 18:55:43 tetrachloride kernel: c0392ec6
Jun  8 18:55:43 tetrachloride kernel: *pde = 00000000
Jun  8 18:55:43 tetrachloride kernel: Oops: 0000 [#1]
Jun  8 18:55:43 tetrachloride kernel: CPU:    0
Jun  8 18:55:43 tetrachloride kernel: EIP:    0060:[<c0392ec6>]    Not tainted
Jun  8 18:55:43 tetrachloride kernel: EFLAGS: 00010202
Jun  8 18:55:43 tetrachloride kernel: EIP is at raid0_make_request+0x3f/0x169
Jun  8 18:55:43 tetrachloride kernel: eax: 00000000   ebx: 00000000   ecx:
00000000   edx: 00000000
Jun  8 18:55:43 tetrachloride kernel: esi: 00000080   edi: 00000000   ebp:
cf801d50   esp: cf801d28
Jun  8 18:55:43 tetrachloride kernel: ds: 007b   es: 007b   ss: 0068
Jun  8 18:55:43 tetrachloride kernel: Process mount (pid: 90,
threadinfo=cf800000 task=cf8fe080)
Jun  8 18:55:43 tetrachloride kernel: Stack: c01652a0 c1287ee0 00000000 cf8fe080
c01210c3 00000000 00000007 cfcb5424 
Jun  8 18:55:43 tetrachloride kernel:        00000001 cfb699b8 cf801da4 c02e8d26
cfb699b8 cf7eee4c cf801d5c cf478850 
Jun  8 18:55:43 tetrachloride kernel:        cf801d88 c016533f cf7eee4c 00000001
00000000 cf801da0 c0167a46 cffbcd30 
Jun  8 18:55:43 tetrachloride kernel: Call Trace:
Jun  8 18:55:43 tetrachloride kernel:  [<c01652a0>] bh_lru_install+0x97/0xdc
Jun  8 18:55:43 tetrachloride kernel:  [<c01210c3>]
autoremove_wake_function+0x0/0x4b
Jun  8 18:55:43 tetrachloride kernel:  [<c02e8d26>] generic_make_request+0x133/0x1bb
Jun  8 18:55:43 tetrachloride kernel:  [<c016533f>] __find_get_block+0x5a/0xc2
Jun  8 18:55:43 tetrachloride kernel:  [<c0167a46>] bio_alloc+0xcc/0x197
Jun  8 18:55:43 tetrachloride kernel:  [<c02e8e01>] submit_bio+0x53/0x96
Jun  8 18:55:43 tetrachloride kernel:  [<c016519f>] __bread_slow+0x3c/0xa6
Jun  8 18:55:43 tetrachloride kernel:  [<c0165427>] __bread+0x35/0x39
Jun  8 18:55:43 tetrachloride kernel:  [<c01c4e94>] fat_fill_super+0x104/0x7d7
Jun  8 18:55:43 tetrachloride kernel:  [<c0147f03>] check_poison_obj+0x3e/0x199
Jun  8 18:55:43 tetrachloride kernel:  [<c025e822>] snprintf+0x26/0x2a
Jun  8 18:55:43 tetrachloride kernel:  [<c019a12b>] disk_name+0x9f/0xa1
Jun  8 18:55:43 tetrachloride kernel:  [<c01c9191>] vfat_fill_super+0x32/0x61
Jun  8 18:55:43 tetrachloride kernel:  [<c016a271>] get_sb_bdev+0x118/0x14b
Jun  8 18:55:43 tetrachloride kernel:  [<c0181a84>] alloc_vfsmnt+0x88/0xbc
Jun  8 18:55:43 tetrachloride kernel:  [<c01c91ee>] vfat_get_sb+0x2e/0x34
Jun  8 18:55:43 tetrachloride kernel:  [<c01c915f>] vfat_fill_super+0x0/0x61
Jun  8 18:55:43 tetrachloride kernel:  [<c016a48e>] do_kern_mount+0x56/0xc3
Jun  8 18:55:43 tetrachloride kernel:  [<c0183136>] do_add_mount+0x7d/0x17a
Jun  8 18:55:43 tetrachloride kernel:  [<c0183421>] do_mount+0x11d/0x160
Jun  8 18:55:43 tetrachloride kernel:  [<c01832ff>] copy_mount_options+0xcc/0xd1
Jun  8 18:55:43 tetrachloride kernel:  [<c0183b12>] sys_mount+0xcc/0x180
Jun  8 18:55:43 tetrachloride kernel:  [<c01096df>] syscall_call+0x7/0xb
Jun  8 18:55:43 tetrachloride kernel: 
Jun  8 18:55:43 tetrachloride kernel: Code: 8b 4f 14 89 d8 31 d2 d3 e8 f7 77 10
8b 17 8b 3c 82 8b 17 89

